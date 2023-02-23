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
          "order_id": "c5453aae-8e31-4538-8b57-2ecfda924203",
          "items": [
            {
              "type": "products",
              "id": "f602df3f-88af-4d39-b773-5e2397c7f025",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "cca93cb0-f058-4e02-acdc-143719e9b199",
              "stock_item_ids": [
                "30855b56-0d2a-4f98-a610-65ea73198418",
                "3918a711-86a5-40bc-9647-63e861bb03a6"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 30855b56-0d2a-4f98-a610-65ea73198418 has already been booked on this order"
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
          "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
          "items": [
            {
              "type": "products",
              "id": "bb470df3-718e-466f-bf16-02b63fa9204b",
              "stock_item_ids": [
                "b66de821-a19d-4efb-81ea-d7a86490edc8",
                "e1820849-59ea-41bb-9941-8d7a351577e8",
                "8b67ea11-f86a-4c8c-b3d0-65532a334131"
              ]
            },
            {
              "type": "products",
              "id": "f7fe9d45-f4d6-4388-a298-87c9b875d090",
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
    "id": "99618a5c-ef6d-5f7f-99b2-537db4b5e292",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a81e1ca3-78ec-4b3a-9a20-c2cff68a1aa7"
          },
          {
            "type": "lines",
            "id": "eaf2c956-1537-41da-9778-aac1773efa8f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25"
          },
          {
            "type": "plannings",
            "id": "56a1fa05-5777-4f3f-bfa9-7d4ff3cc5a4c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e807fb3c-5d3c-4c2f-92d9-207c9b4db110"
          },
          {
            "type": "stock_item_plannings",
            "id": "bc39b412-c5fb-41f1-a799-d83470e924bd"
          },
          {
            "type": "stock_item_plannings",
            "id": "f61dcdd6-872b-4cd1-837c-bc7fceffcca2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T13:51:51+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
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
        "customer_id": "e2e42080-47e1-42a6-99a2-79cf77254ac4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9",
        "stop_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9"
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
      "id": "a81e1ca3-78ec-4b3a-9a20-c2cff68a1aa7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
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
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "bb470df3-718e-466f-bf16-02b63fa9204b",
        "tax_category_id": "2e739c1e-4f06-454e-a14e-b31d2c7451c1",
        "planning_id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25",
        "parent_line_id": null,
        "owner_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
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
      "id": "eaf2c956-1537-41da-9778-aac1773efa8f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
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
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "f7fe9d45-f4d6-4388-a298-87c9b875d090",
        "tax_category_id": "2e739c1e-4f06-454e-a14e-b31d2c7451c1",
        "planning_id": "56a1fa05-5777-4f3f-bfa9-7d4ff3cc5a4c",
        "parent_line_id": null,
        "owner_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
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
      "id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
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
        "item_id": "bb470df3-718e-466f-bf16-02b63fa9204b",
        "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
        "start_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9",
        "stop_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9",
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
      "id": "56a1fa05-5777-4f3f-bfa9-7d4ff3cc5a4c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
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
        "item_id": "f7fe9d45-f4d6-4388-a298-87c9b875d090",
        "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b",
        "start_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9",
        "stop_location_id": "6a5c7ecc-4bde-4e7d-b7cb-99fa0dfe02e9",
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
      "id": "e807fb3c-5d3c-4c2f-92d9-207c9b4db110",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b66de821-a19d-4efb-81ea-d7a86490edc8",
        "planning_id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25",
        "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b"
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
      "id": "bc39b412-c5fb-41f1-a799-d83470e924bd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e1820849-59ea-41bb-9941-8d7a351577e8",
        "planning_id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25",
        "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b"
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
      "id": "f61dcdd6-872b-4cd1-837c-bc7fceffcca2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:53+00:00",
        "updated_at": "2023-02-23T13:51:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b67ea11-f86a-4c8c-b3d0-65532a334131",
        "planning_id": "e3bdcd53-a184-4834-b1f5-ce4a9f496f25",
        "order_id": "d9de5f54-6803-4f57-a2ac-cfe310c5bd8b"
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
          "order_id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d",
          "items": [
            {
              "type": "bundles",
              "id": "8330364a-90c2-4973-82f9-7b577ed594a1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "00048767-d817-4471-a113-a0828f146811",
                  "id": "4d08696b-4259-4473-9fe1-cac44e6e4b82"
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
    "id": "a3575f82-49aa-5ffd-b743-2374f4d29373",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "84bc8696-9c5c-40c8-b620-c79c0a2034a2"
          },
          {
            "type": "lines",
            "id": "39dff785-d780-4ae8-8b95-4a6b37e3c9c4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "60929179-399d-4d6e-af36-68c9953cc2fc"
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
      "id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T13:51:55+00:00",
        "updated_at": "2023-02-23T13:51:55+00:00",
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
        "starts_at": "2023-02-21T13:45:00+00:00",
        "stops_at": "2023-02-25T13:45:00+00:00",
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
        "start_location_id": "a615e24c-8130-4f63-8388-126d859e48de",
        "stop_location_id": "a615e24c-8130-4f63-8388-126d859e48de"
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
      "id": "84bc8696-9c5c-40c8-b620-c79c0a2034a2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:51:55+00:00",
        "updated_at": "2023-02-23T13:51:55+00:00",
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
        "item_id": "8330364a-90c2-4973-82f9-7b577ed594a1",
        "tax_category_id": null,
        "planning_id": "60929179-399d-4d6e-af36-68c9953cc2fc",
        "parent_line_id": null,
        "owner_id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d",
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
      "id": "39dff785-d780-4ae8-8b95-4a6b37e3c9c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:51:55+00:00",
        "updated_at": "2023-02-23T13:51:55+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 13 - red",
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
        "item_id": "4d08696b-4259-4473-9fe1-cac44e6e4b82",
        "tax_category_id": null,
        "planning_id": "9f36309a-4ed7-4a64-9e9f-027e41ec75e7",
        "parent_line_id": "84bc8696-9c5c-40c8-b620-c79c0a2034a2",
        "owner_id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d",
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
      "id": "60929179-399d-4d6e-af36-68c9953cc2fc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:51:55+00:00",
        "updated_at": "2023-02-23T13:51:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-21T13:45:00+00:00",
        "stops_at": "2023-02-25T13:45:00+00:00",
        "reserved_from": "2023-02-21T13:45:00+00:00",
        "reserved_till": "2023-02-25T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8330364a-90c2-4973-82f9-7b577ed594a1",
        "order_id": "1ab24de4-ff0d-4e38-a963-12d78187cc9d",
        "start_location_id": "a615e24c-8130-4f63-8388-126d859e48de",
        "stop_location_id": "a615e24c-8130-4f63-8388-126d859e48de",
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





