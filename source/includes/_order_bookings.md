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
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


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
          "order_id": "d30164a2-0136-4503-828b-b013c20e2f6b",
          "items": [
            {
              "type": "products",
              "id": "42001da4-00e4-4272-ac5e-4521e879afeb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "264eb270-e291-4a1a-a514-e30daef4d968",
              "stock_item_ids": [
                "a8eb893c-6504-4e72-b17b-6355c4578019",
                "1f72cd08-0fe1-4f0c-94ca-c79e7f3dd970"
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
            "item_id": "42001da4-00e4-4272-ac5e-4521e879afeb",
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
          "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
          "items": [
            {
              "type": "products",
              "id": "bb7f455f-449d-4f78-9597-75b88785bfcf",
              "stock_item_ids": [
                "1221f3bc-342b-4f92-ac44-32107109536e",
                "bc2cd96f-864a-4ab7-9858-33da44b40b7f",
                "9a756823-0d82-488c-bde9-73149fc409bf"
              ]
            },
            {
              "type": "products",
              "id": "9045cb1b-14bc-49d0-9ef9-67253da0001a",
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
    "id": "44709c91-1a1f-5254-b766-2ef10b207fd7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b78e34a3-480e-4b36-bd6c-88659b27930e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "491a47c4-54b3-49c4-bd36-81720d482992"
          },
          {
            "type": "lines",
            "id": "7bfed047-8d29-4ec4-a0ba-748ada2b37e1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7553f8c7-b90b-40a7-ae28-214c4c90ff4f"
          },
          {
            "type": "plannings",
            "id": "fbbbd066-62f4-4855-a323-035784f92bbb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1e4fe5a0-9923-4178-b0cb-42aeed0b2dd9"
          },
          {
            "type": "stock_item_plannings",
            "id": "448bcd18-849d-45ef-9d24-25dae43168e6"
          },
          {
            "type": "stock_item_plannings",
            "id": "fba84475-d002-4f40-b90f-9e4b2b725eb1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-30T12:19:11+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
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
        "customer_id": "e2eb1d33-aeb4-4bdb-8af7-1e7ade89cb5f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9",
        "stop_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9"
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
      "id": "491a47c4-54b3-49c4-bd36-81720d482992",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-30T12:19:11+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 2,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 160500,
        "position": 1,
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
        "item_id": "9045cb1b-14bc-49d0-9ef9-67253da0001a",
        "tax_category_id": "a1ec9b43-2d78-4994-b58c-8dec11b6cdfe",
        "planning_id": "7553f8c7-b90b-40a7-ae28-214c4c90ff4f",
        "parent_line_id": null,
        "owner_id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
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
      "id": "7bfed047-8d29-4ec4-a0ba-748ada2b37e1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-30T12:19:13+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
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
        "item_id": "bb7f455f-449d-4f78-9597-75b88785bfcf",
        "tax_category_id": "a1ec9b43-2d78-4994-b58c-8dec11b6cdfe",
        "planning_id": "fbbbd066-62f4-4855-a323-035784f92bbb",
        "parent_line_id": null,
        "owner_id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
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
      "id": "7553f8c7-b90b-40a7-ae28-214c4c90ff4f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:11+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9045cb1b-14bc-49d0-9ef9-67253da0001a",
        "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
        "start_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9",
        "stop_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9",
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
      "id": "fbbbd066-62f4-4855-a323-035784f92bbb",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:13+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
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
        "item_id": "bb7f455f-449d-4f78-9597-75b88785bfcf",
        "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e",
        "start_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9",
        "stop_location_id": "45bf7922-d0f0-4311-9be9-8b9dde8050e9",
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
      "id": "1e4fe5a0-9923-4178-b0cb-42aeed0b2dd9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:13+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1221f3bc-342b-4f92-ac44-32107109536e",
        "planning_id": "fbbbd066-62f4-4855-a323-035784f92bbb",
        "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e"
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
      "id": "448bcd18-849d-45ef-9d24-25dae43168e6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:13+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bc2cd96f-864a-4ab7-9858-33da44b40b7f",
        "planning_id": "fbbbd066-62f4-4855-a323-035784f92bbb",
        "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e"
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
      "id": "fba84475-d002-4f40-b90f-9e4b2b725eb1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:13+00:00",
        "updated_at": "2022-05-30T12:19:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9a756823-0d82-488c-bde9-73149fc409bf",
        "planning_id": "fbbbd066-62f4-4855-a323-035784f92bbb",
        "order_id": "b78e34a3-480e-4b36-bd6c-88659b27930e"
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
          "order_id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b",
          "items": [
            {
              "type": "bundles",
              "id": "882ccaa3-524e-40c3-a8bd-208b03e6aac5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fde6ea8f-308e-4dc7-a7ba-7789c544153d",
                  "id": "82b56f48-25aa-4455-809c-2d2400abb61a"
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
    "id": "9f24caa3-a027-58e4-955f-395213b33481",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d1e29fca-b2bd-4ce4-9566-10cc7d7baa3d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "eed4effd-ffea-4dd6-bde3-a353a523b8df"
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
      "id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-30T12:19:16+00:00",
        "updated_at": "2022-05-30T12:19:17+00:00",
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
        "starts_at": "2022-05-28T12:15:00+00:00",
        "stops_at": "2022-06-01T12:15:00+00:00",
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
        "start_location_id": "1e6808c4-27a6-49ba-a8bd-0943db82d1a6",
        "stop_location_id": "1e6808c4-27a6-49ba-a8bd-0943db82d1a6"
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
      "id": "d1e29fca-b2bd-4ce4-9566-10cc7d7baa3d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-30T12:19:16+00:00",
        "updated_at": "2022-05-30T12:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "882ccaa3-524e-40c3-a8bd-208b03e6aac5",
        "tax_category_id": null,
        "planning_id": "eed4effd-ffea-4dd6-bde3-a353a523b8df",
        "parent_line_id": null,
        "owner_id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b",
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
      "id": "eed4effd-ffea-4dd6-bde3-a353a523b8df",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-30T12:19:16+00:00",
        "updated_at": "2022-05-30T12:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-28T12:15:00+00:00",
        "stops_at": "2022-06-01T12:15:00+00:00",
        "reserved_from": "2022-05-28T12:15:00+00:00",
        "reserved_till": "2022-06-01T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "882ccaa3-524e-40c3-a8bd-208b03e6aac5",
        "order_id": "c17e5ccc-e35b-45cc-9dbb-9bda8217cc6b",
        "start_location_id": "1e6808c4-27a6-49ba-a8bd-0943db82d1a6",
        "stop_location_id": "1e6808c4-27a6-49ba-a8bd-0943db82d1a6",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>
`data[attributes][items][]` | **Array**<br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





