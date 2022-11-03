# Order bookings

Add products, bundles and specific stock items to an order.

Items can be added quantitatively or, for trackable products, specific stock items can be specified. Specifying stock items is not required on order_booking; they can also be defined when transitioning the order status to a `started` state.

> Adding items quantitatively:

```json
  "items": [
    {
      "type": "products",
      "id": "69a6ac18-244e-4b1e-b2e1-c88d155b51e5",
      "quantity": 10
    }
  ]
```

> Adding specific stock items:

```json
  "items": [
    {
      "type": "products",
      "id": "a2d96edf-7d8b-42de-9897-e5aee335f3ca",
      "quantity": 3,
      "stock_item_ids": [
        "1456d221-029c-42ad-abcd-ad8d70c9e3f0",
        "ee64a622-3ac5-4859-a582-b3467b8027e8"
      ]
    }
  ]
```

> Adding a bundle:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
    }
  ]
```

> Adding a bundle and specifying a variation (for product that has variations)

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "products": [
        {
          "type": "products",
          "bundle_item_id": "1456d221-029c-42ad-abcd-ad8d70c9e3f0",
          "id": "ee64a622-3ac5-4859-a582-b3467b8027e8"
        }
      }
    }
  ]
```

**When an order booking is successful, the price and status information of the order will be updated, and the following resources are created:**

- **Plannings** Quantitative data about the planning of an item.
- **Stock item plannings** Planning for specific stock items (when stock items are specified).
- **Lines** Individual elements on order, which in the case of [order bookings](#order-bookings) contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Fields
Every order booking has the following fields:

Name | Description
- | -
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`lines` | **Lines** `readonly`<br>Associated Lines
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Creating an order booking



> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "9ae0a84c-7dfc-41d8-8e8e-1d61222cb72c",
          "items": [
            {
              "type": "products",
              "id": "ced1c0a8-6f26-4f5f-951b-24bf9c10774c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bd2b5339-0bf0-4987-ba67-9d7f8cc38073",
              "stock_item_ids": [
                "c6565ce7-b6b8-4a23-9621-32d304e3340a",
                "a8e6b517-e9d5-476c-8712-1a7e0fc312d8"
              ]
            }
          ]
        }
      }
    }'
```

> A 422 status response looks like this:

```json
  {
  "errors": [
    {
      "code": "items_not_available",
      "status": "422",
      "title": "Items not available",
      "detail": "One or more items are not available",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "shortage",
            "item_id": "ced1c0a8-6f26-4f5f-951b-24bf9c10774c",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          }
        ]
      }
    }
  ]
}
```


> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15",
          "items": [
            {
              "type": "products",
              "id": "8f6f07ab-f2a2-44dd-92d0-b09c32b22d6d",
              "stock_item_ids": [
                "b277ebbc-7c6a-480d-94be-789018205b2a",
                "a698f996-8599-4fe6-b076-3ff9242201c3",
                "51612020-a631-4742-89d3-423fbc65081a"
              ]
            },
            {
              "type": "products",
              "id": "5261a6d2-38e5-442c-8449-ab081e507d22",
              "quantity": 1
            }
          ]
        }
      },
      "include": "order,lines,plannings,stock_item_plannings"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "dc583055-c288-593c-aa87-58b1582ff634",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1333eafb-1709-42d2-9680-105f6aabcd15"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "aac08344-ec85-4592-9a97-05219894bd9c"
          },
          {
            "type": "lines",
            "id": "e70c5701-6f92-4409-84f2-fe048d84c9b4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bbe0bff8-767d-4214-be71-993bc376cfb0"
          },
          {
            "type": "plannings",
            "id": "b088443b-a615-45ab-aaa3-61729167ceb1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1590f5cf-e77b-45f1-9b15-3477451135c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "c0d95c93-7e5c-445b-ae02-0541fdf749b2"
          },
          {
            "type": "stock_item_plannings",
            "id": "4f7b2d30-f4ab-48bb-9a5b-57577016c788"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1333eafb-1709-42d2-9680-105f6aabcd15",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-03T11:07:50+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "number": 1,
        "status": "reserved",
        "statuses": [
          "reserved"
        ],
        "status_counts": {
          "concept": 0,
          "new": 0,
          "reserved": 5,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "tag_list": [
          "webshop"
        ],
        "properties": {},
        "price_in_cents": 256800,
        "grand_total_in_cents": 231120,
        "grand_total_with_tax_in_cents": 279655,
        "tax_in_cents": 48535,
        "discount_in_cents": 25680,
        "coupon_discount_in_cents": 0,
        "total_discount_in_cents": 25680,
        "deposit_in_cents": 35000,
        "deposit_paid_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "deposit_held_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "to_be_paid_in_cents": 314655,
        "paid_in_cents": 0,
        "discount_percentage": 10.0,
        "customer_id": "8df2bc1c-f2c0-46af-b2ab-2172c713721d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab",
        "stop_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab"
      },
      "relationships": {
        "customer": {
          "meta": {
            "included": false
          }
        },
        "tax_region": {
          "meta": {
            "included": false
          }
        },
        "coupon": {
          "meta": {
            "included": false
          }
        },
        "barcode": {
          "meta": {
            "included": false
          }
        },
        "properties": {
          "meta": {
            "included": false
          }
        },
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        },
        "tax_values": {
          "meta": {
            "included": false
          }
        },
        "lines": {
          "meta": {
            "included": false
          }
        },
        "stock_item_plannings": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "aac08344-ec85-4592-9a97-05219894bd9c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z"
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": "3100.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "8f6f07ab-f2a2-44dd-92d0-b09c32b22d6d",
        "tax_category_id": "0823b0b1-920c-4192-96aa-de5e534c2b52",
        "planning_id": "bbe0bff8-767d-4214-be71-993bc376cfb0",
        "parent_line_id": null,
        "owner_id": "1333eafb-1709-42d2-9680-105f6aabcd15",
        "owner_type": "orders"
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "tax_category": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "parent_line": {
          "meta": {
            "included": false
          }
        },
        "nested_lines": {
          "meta": {
            "included": false
          }
        },
        "owner": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "e70c5701-6f92-4409-84f2-fe048d84c9b4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z"
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "5261a6d2-38e5-442c-8449-ab081e507d22",
        "tax_category_id": "0823b0b1-920c-4192-96aa-de5e534c2b52",
        "planning_id": "b088443b-a615-45ab-aaa3-61729167ceb1",
        "parent_line_id": null,
        "owner_id": "1333eafb-1709-42d2-9680-105f6aabcd15",
        "owner_type": "orders"
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "tax_category": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "parent_line": {
          "meta": {
            "included": false
          }
        },
        "nested_lines": {
          "meta": {
            "included": false
          }
        },
        "owner": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "bbe0bff8-767d-4214-be71-993bc376cfb0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 3,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8f6f07ab-f2a2-44dd-92d0-b09c32b22d6d",
        "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15",
        "start_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab",
        "stop_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        },
        "order_line": {
          "meta": {
            "included": false
          }
        },
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        },
        "parent_planning": {
          "meta": {
            "included": false
          }
        },
        "nested_plannings": {
          "meta": {
            "included": false
          }
        },
        "stock_item_plannings": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "b088443b-a615-45ab-aaa3-61729167ceb1",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5261a6d2-38e5-442c-8449-ab081e507d22",
        "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15",
        "start_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab",
        "stop_location_id": "052cb96b-29b9-408d-bac6-20398f5a74ab",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        },
        "order_line": {
          "meta": {
            "included": false
          }
        },
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        },
        "parent_planning": {
          "meta": {
            "included": false
          }
        },
        "nested_plannings": {
          "meta": {
            "included": false
          }
        },
        "stock_item_plannings": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "1590f5cf-e77b-45f1-9b15-3477451135c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b277ebbc-7c6a-480d-94be-789018205b2a",
        "planning_id": "bbe0bff8-767d-4214-be71-993bc376cfb0",
        "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15"
      },
      "relationships": {
        "stock_item": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "c0d95c93-7e5c-445b-ae02-0541fdf749b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a698f996-8599-4fe6-b076-3ff9242201c3",
        "planning_id": "bbe0bff8-767d-4214-be71-993bc376cfb0",
        "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15"
      },
      "relationships": {
        "stock_item": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "4f7b2d30-f4ab-48bb-9a5b-57577016c788",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:53+00:00",
        "updated_at": "2022-11-03T11:07:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "51612020-a631-4742-89d3-423fbc65081a",
        "planning_id": "bbe0bff8-767d-4214-be71-993bc376cfb0",
        "order_id": "1333eafb-1709-42d2-9680-105f6aabcd15"
      },
      "relationships": {
        "stock_item": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```


> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "c75e4695-424d-4b1a-88a1-41a873d4edde",
          "items": [
            {
              "type": "bundles",
              "id": "6b097ed4-6054-4d49-a609-d2eddcce1a22",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fc08e88e-f0ef-4a4a-832d-16c4719f84dc",
                  "id": "222c76fa-0bb9-41ef-b475-36ace83bc97b"
                }
              ]
            }
          ]
        }
      },
      "include": "order,lines,plannings,stock_item_plannings"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "32394b6a-9d9a-5fcf-9b18-f3032106df39",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c75e4695-424d-4b1a-88a1-41a873d4edde"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c75e4695-424d-4b1a-88a1-41a873d4edde"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "45f8f2d4-9158-4495-afdb-41b0c4a9a135"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a71dd94e-455b-4b99-bcc7-a78582bd3dad"
          }
        ]
      },
      "stock_item_plannings": {
        "data": []
      }
    }
  },
  "included": [
    {
      "id": "c75e4695-424d-4b1a-88a1-41a873d4edde",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-03T11:07:56+00:00",
        "updated_at": "2022-11-03T11:07:57+00:00",
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {
          "concept": 0,
          "new": 1,
          "reserved": 0,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "2022-11-01T11:00:00+00:00",
        "stops_at": "2022-11-05T11:00:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "tag_list": [],
        "properties": {},
        "price_in_cents": 0,
        "grand_total_in_cents": 0,
        "grand_total_with_tax_in_cents": 0,
        "tax_in_cents": 0,
        "discount_in_cents": 0,
        "coupon_discount_in_cents": 0,
        "total_discount_in_cents": 0,
        "deposit_in_cents": 0,
        "deposit_paid_in_cents": 0,
        "deposit_refunded_in_cents": 0,
        "deposit_held_in_cents": 0,
        "deposit_to_refund_in_cents": 0,
        "to_be_paid_in_cents": 0,
        "paid_in_cents": 0,
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d2bd376a-bc4b-4983-a58c-13dba4a8d5a1",
        "stop_location_id": "d2bd376a-bc4b-4983-a58c-13dba4a8d5a1"
      },
      "relationships": {
        "customer": {
          "meta": {
            "included": false
          }
        },
        "tax_region": {
          "meta": {
            "included": false
          }
        },
        "coupon": {
          "meta": {
            "included": false
          }
        },
        "barcode": {
          "meta": {
            "included": false
          }
        },
        "properties": {
          "meta": {
            "included": false
          }
        },
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        },
        "tax_values": {
          "meta": {
            "included": false
          }
        },
        "lines": {
          "meta": {
            "included": false
          }
        },
        "stock_item_plannings": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "45f8f2d4-9158-4495-afdb-41b0c4a9a135",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-03T11:07:57+00:00",
        "updated_at": "2022-11-03T11:07:57+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "6b097ed4-6054-4d49-a609-d2eddcce1a22",
        "tax_category_id": null,
        "planning_id": "a71dd94e-455b-4b99-bcc7-a78582bd3dad",
        "parent_line_id": null,
        "owner_id": "c75e4695-424d-4b1a-88a1-41a873d4edde",
        "owner_type": "orders"
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "tax_category": {
          "meta": {
            "included": false
          }
        },
        "planning": {
          "meta": {
            "included": false
          }
        },
        "parent_line": {
          "meta": {
            "included": false
          }
        },
        "nested_lines": {
          "meta": {
            "included": false
          }
        },
        "owner": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "a71dd94e-455b-4b99-bcc7-a78582bd3dad",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-03T11:07:57+00:00",
        "updated_at": "2022-11-03T11:07:57+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-01T11:00:00+00:00",
        "stops_at": "2022-11-05T11:00:00+00:00",
        "reserved_from": "2022-11-01T11:00:00+00:00",
        "reserved_till": "2022-11-05T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6b097ed4-6054-4d49-a609-d2eddcce1a22",
        "order_id": "c75e4695-424d-4b1a-88a1-41a873d4edde",
        "start_location_id": "d2bd376a-bc4b-4983-a58c-13dba4a8d5a1",
        "stop_location_id": "d2bd376a-bc4b-4983-a58c-13dba4a8d5a1",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
          "meta": {
            "included": false
          }
        },
        "order_line": {
          "meta": {
            "included": false
          }
        },
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        },
        "parent_planning": {
          "meta": {
            "included": false
          }
        },
        "nested_plannings": {
          "meta": {
            "included": false
          }
        },
        "stock_item_plannings": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/order_bookings`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid** <br>
`data[attributes][items][]` | **Array** <br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





