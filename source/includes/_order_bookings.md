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
          "order_id": "ca29d503-b0f5-4d14-9210-4cb12724c16f",
          "items": [
            {
              "type": "products",
              "id": "19fbb43c-c7bc-431c-a158-fe509acf7532",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1d9b2eab-bb4d-4b96-9672-e3ec73010cfe",
              "stock_item_ids": [
                "867ca65d-fae7-4513-aeec-0b2a844ca150",
                "9f71a8bc-855b-46e7-bc25-d0dd2a8ce5d6"
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
            "item_id": "19fbb43c-c7bc-431c-a158-fe509acf7532",
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
          "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
          "items": [
            {
              "type": "products",
              "id": "60dcdf71-86e0-4212-a7a7-1c0f58d66a3b",
              "stock_item_ids": [
                "b3ac5edb-691c-4b1a-9fb4-446cab21d646",
                "03a175b1-d436-45cd-a001-1e5613884020",
                "dfb8b889-5f9b-474d-80e2-7197da094c79"
              ]
            },
            {
              "type": "products",
              "id": "962e0deb-abd0-47ea-b7c3-b78c55590429",
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
    "id": "d973d817-cae4-52dd-83b3-6ae0ecfbc925",
    "type": "order_bookings",
    "attributes": {
      "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "da50bc5b-000f-457e-829d-17bcf3778ff0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "00194ff0-087e-4c8c-9c23-56cc8bb19311"
          },
          {
            "type": "lines",
            "id": "dc78436b-2bcb-4c7c-8f71-30e10fdc4c44"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5c350833-7f2d-414b-915e-26c295072d33"
          },
          {
            "type": "plannings",
            "id": "8157a6ef-19d2-4088-914a-69a8ccff87d9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d5105722-9221-45bb-a511-4b3bdf56a37b"
          },
          {
            "type": "stock_item_plannings",
            "id": "a21b31ec-a8ea-4f79-bc40-afdf5eaa9206"
          },
          {
            "type": "stock_item_plannings",
            "id": "0edfb04f-7200-43b6-9982-f3a353ea61b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-21T10:30:02+00:00",
        "updated_at": "2022-11-21T10:30:04+00:00",
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
        "customer_id": "4ff252fb-f20f-4636-8c00-3aefd6357ea6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "37cf862c-069a-4060-b87a-88fafc123e96",
        "stop_location_id": "37cf862c-069a-4060-b87a-88fafc123e96"
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
      "id": "00194ff0-087e-4c8c-9c23-56cc8bb19311",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:04+00:00",
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
        "item_id": "60dcdf71-86e0-4212-a7a7-1c0f58d66a3b",
        "tax_category_id": "4bfe14e5-7fe9-4e7d-b121-ddf0bdd7ae8b",
        "planning_id": "5c350833-7f2d-414b-915e-26c295072d33",
        "parent_line_id": null,
        "owner_id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
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
      "id": "dc78436b-2bcb-4c7c-8f71-30e10fdc4c44",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:04+00:00",
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
        "item_id": "962e0deb-abd0-47ea-b7c3-b78c55590429",
        "tax_category_id": "4bfe14e5-7fe9-4e7d-b121-ddf0bdd7ae8b",
        "planning_id": "8157a6ef-19d2-4088-914a-69a8ccff87d9",
        "parent_line_id": null,
        "owner_id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
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
      "id": "5c350833-7f2d-414b-915e-26c295072d33",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:04+00:00",
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
        "item_id": "60dcdf71-86e0-4212-a7a7-1c0f58d66a3b",
        "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
        "start_location_id": "37cf862c-069a-4060-b87a-88fafc123e96",
        "stop_location_id": "37cf862c-069a-4060-b87a-88fafc123e96",
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
      "id": "8157a6ef-19d2-4088-914a-69a8ccff87d9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:04+00:00",
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
        "item_id": "962e0deb-abd0-47ea-b7c3-b78c55590429",
        "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0",
        "start_location_id": "37cf862c-069a-4060-b87a-88fafc123e96",
        "stop_location_id": "37cf862c-069a-4060-b87a-88fafc123e96",
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
      "id": "d5105722-9221-45bb-a511-4b3bdf56a37b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b3ac5edb-691c-4b1a-9fb4-446cab21d646",
        "planning_id": "5c350833-7f2d-414b-915e-26c295072d33",
        "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0"
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
      "id": "a21b31ec-a8ea-4f79-bc40-afdf5eaa9206",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "03a175b1-d436-45cd-a001-1e5613884020",
        "planning_id": "5c350833-7f2d-414b-915e-26c295072d33",
        "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0"
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
      "id": "0edfb04f-7200-43b6-9982-f3a353ea61b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:03+00:00",
        "updated_at": "2022-11-21T10:30:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dfb8b889-5f9b-474d-80e2-7197da094c79",
        "planning_id": "5c350833-7f2d-414b-915e-26c295072d33",
        "order_id": "da50bc5b-000f-457e-829d-17bcf3778ff0"
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
          "order_id": "af3f77df-c5c5-42d0-9c62-aa416357ac39",
          "items": [
            {
              "type": "bundles",
              "id": "c760f324-33c4-42d5-a0a3-905ddad456e5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d8d065aa-1f8d-4771-99ca-89cb8bd765fd",
                  "id": "aa707921-90f1-42a7-998f-f5b66f79bd14"
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
    "id": "273b9c6d-7744-57d7-b31e-39c163f12369",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af3f77df-c5c5-42d0-9c62-aa416357ac39"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af3f77df-c5c5-42d0-9c62-aa416357ac39"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7baadb0d-187f-42d5-80bb-3628f8994969"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "283532c0-9758-47d5-be17-80bea75afb75"
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
      "id": "af3f77df-c5c5-42d0-9c62-aa416357ac39",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-21T10:30:06+00:00",
        "updated_at": "2022-11-21T10:30:07+00:00",
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
        "starts_at": "2022-11-19T10:30:00+00:00",
        "stops_at": "2022-11-23T10:30:00+00:00",
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
        "start_location_id": "11d6a6c2-7933-4500-a1fe-117269ed486c",
        "stop_location_id": "11d6a6c2-7933-4500-a1fe-117269ed486c"
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
      "id": "7baadb0d-187f-42d5-80bb-3628f8994969",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-21T10:30:06+00:00",
        "updated_at": "2022-11-21T10:30:06+00:00",
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
        "item_id": "c760f324-33c4-42d5-a0a3-905ddad456e5",
        "tax_category_id": null,
        "planning_id": "283532c0-9758-47d5-be17-80bea75afb75",
        "parent_line_id": null,
        "owner_id": "af3f77df-c5c5-42d0-9c62-aa416357ac39",
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
      "id": "283532c0-9758-47d5-be17-80bea75afb75",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-21T10:30:06+00:00",
        "updated_at": "2022-11-21T10:30:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-19T10:30:00+00:00",
        "stops_at": "2022-11-23T10:30:00+00:00",
        "reserved_from": "2022-11-19T10:30:00+00:00",
        "reserved_till": "2022-11-23T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c760f324-33c4-42d5-a0a3-905ddad456e5",
        "order_id": "af3f77df-c5c5-42d0-9c62-aa416357ac39",
        "start_location_id": "11d6a6c2-7933-4500-a1fe-117269ed486c",
        "stop_location_id": "11d6a6c2-7933-4500-a1fe-117269ed486c",
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





