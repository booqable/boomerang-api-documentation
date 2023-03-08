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
          "order_id": "78ad2cd6-bc3f-4154-8287-6e13e0416968",
          "items": [
            {
              "type": "products",
              "id": "a3d742cf-6c9f-458c-a6c6-178910d24a3f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4c1cb113-ee9e-43d7-9d78-f600987bb4ba",
              "stock_item_ids": [
                "76916cb9-5673-48ab-a04a-2f2114a17d3c",
                "37b96e1f-7814-490f-9778-f077ea980fdb"
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
          "stock_item_id 76916cb9-5673-48ab-a04a-2f2114a17d3c has already been booked on this order"
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
          "order_id": "65059f00-68cc-4ca5-b477-03458591f711",
          "items": [
            {
              "type": "products",
              "id": "71ce6020-0c87-4e07-b308-9889648cbbd8",
              "stock_item_ids": [
                "7c684e8e-5346-4a9c-b35c-2c050ff5ce0a",
                "b07f11fb-7280-4166-b540-9c2d48a03b10",
                "918d4d2d-d491-4dd7-8a67-2c1495a85f38"
              ]
            },
            {
              "type": "products",
              "id": "991adcd7-2a51-4100-9336-d50091c424cc",
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
    "id": "20a4bdb7-926d-5a39-8a44-8c1e76c174cb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "65059f00-68cc-4ca5-b477-03458591f711"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "65059f00-68cc-4ca5-b477-03458591f711"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4a86b162-c96a-459a-beab-753a4d3869ab"
          },
          {
            "type": "lines",
            "id": "51ec9893-92dc-4b8b-b36e-0a6d1ae7ba2d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bc460f32-30f0-46cd-8859-f2a52c488a45"
          },
          {
            "type": "plannings",
            "id": "b70456a5-c0ee-4834-884c-fbf406599acb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "51e4ab12-6dbf-4a6a-af27-fef921da8325"
          },
          {
            "type": "stock_item_plannings",
            "id": "b2f29448-9f0f-4364-aceb-eb7b3f745eb1"
          },
          {
            "type": "stock_item_plannings",
            "id": "bfc90b1f-ee8d-4757-86d9-2832e869880c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65059f00-68cc-4ca5-b477-03458591f711",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T09:19:55+00:00",
        "updated_at": "2023-03-08T09:19:57+00:00",
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
        "customer_id": "4ca5a2a7-7700-46d6-8ca1-3156d4995700",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375",
        "stop_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375"
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
      "id": "4a86b162-c96a-459a-beab-753a4d3869ab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
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
        "item_id": "71ce6020-0c87-4e07-b308-9889648cbbd8",
        "tax_category_id": "2f68242b-f3ad-46ad-8803-48d8f4a049f1",
        "planning_id": "bc460f32-30f0-46cd-8859-f2a52c488a45",
        "parent_line_id": null,
        "owner_id": "65059f00-68cc-4ca5-b477-03458591f711",
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
      "id": "51ec9893-92dc-4b8b-b36e-0a6d1ae7ba2d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
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
        "item_id": "991adcd7-2a51-4100-9336-d50091c424cc",
        "tax_category_id": "2f68242b-f3ad-46ad-8803-48d8f4a049f1",
        "planning_id": "b70456a5-c0ee-4834-884c-fbf406599acb",
        "parent_line_id": null,
        "owner_id": "65059f00-68cc-4ca5-b477-03458591f711",
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
      "id": "bc460f32-30f0-46cd-8859-f2a52c488a45",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
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
        "item_id": "71ce6020-0c87-4e07-b308-9889648cbbd8",
        "order_id": "65059f00-68cc-4ca5-b477-03458591f711",
        "start_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375",
        "stop_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375",
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
      "id": "b70456a5-c0ee-4834-884c-fbf406599acb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
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
        "item_id": "991adcd7-2a51-4100-9336-d50091c424cc",
        "order_id": "65059f00-68cc-4ca5-b477-03458591f711",
        "start_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375",
        "stop_location_id": "bd16dc7e-e0f4-4a79-97d7-19e363792375",
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
      "id": "51e4ab12-6dbf-4a6a-af27-fef921da8325",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7c684e8e-5346-4a9c-b35c-2c050ff5ce0a",
        "planning_id": "bc460f32-30f0-46cd-8859-f2a52c488a45",
        "order_id": "65059f00-68cc-4ca5-b477-03458591f711"
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
      "id": "b2f29448-9f0f-4364-aceb-eb7b3f745eb1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b07f11fb-7280-4166-b540-9c2d48a03b10",
        "planning_id": "bc460f32-30f0-46cd-8859-f2a52c488a45",
        "order_id": "65059f00-68cc-4ca5-b477-03458591f711"
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
      "id": "bfc90b1f-ee8d-4757-86d9-2832e869880c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:56+00:00",
        "updated_at": "2023-03-08T09:19:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "918d4d2d-d491-4dd7-8a67-2c1495a85f38",
        "planning_id": "bc460f32-30f0-46cd-8859-f2a52c488a45",
        "order_id": "65059f00-68cc-4ca5-b477-03458591f711"
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
          "order_id": "ed867454-e673-4d1c-a60b-d0e7e1b91977",
          "items": [
            {
              "type": "bundles",
              "id": "0ee8c56b-1b8f-416a-8577-e56f20ee8212",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e0f936b1-6777-414e-819e-31a5b25d1c72",
                  "id": "253ab1c8-471f-4391-8b40-ea0a3fc2c1ff"
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
    "id": "a945f598-686d-5dcc-866e-5d7b94432f2a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ed867454-e673-4d1c-a60b-d0e7e1b91977"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ed867454-e673-4d1c-a60b-d0e7e1b91977"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "76e96b16-530b-42ea-adc0-cfcc0d371e2b"
          },
          {
            "type": "lines",
            "id": "5beb69ec-d8dc-45c1-85e5-656c8cfa8df5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "acf525b6-4b3c-45c8-b744-77854f1b3918"
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
      "id": "ed867454-e673-4d1c-a60b-d0e7e1b91977",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T09:19:59+00:00",
        "updated_at": "2023-03-08T09:20:00+00:00",
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
        "starts_at": "2023-03-06T09:15:00+00:00",
        "stops_at": "2023-03-10T09:15:00+00:00",
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
        "start_location_id": "e7fcd62a-1c73-4b80-8590-5f79d7348e71",
        "stop_location_id": "e7fcd62a-1c73-4b80-8590-5f79d7348e71"
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
      "id": "76e96b16-530b-42ea-adc0-cfcc0d371e2b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:19:59+00:00",
        "updated_at": "2023-03-08T09:19:59+00:00",
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
        "item_id": "0ee8c56b-1b8f-416a-8577-e56f20ee8212",
        "tax_category_id": null,
        "planning_id": "acf525b6-4b3c-45c8-b744-77854f1b3918",
        "parent_line_id": null,
        "owner_id": "ed867454-e673-4d1c-a60b-d0e7e1b91977",
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
      "id": "5beb69ec-d8dc-45c1-85e5-656c8cfa8df5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:19:59+00:00",
        "updated_at": "2023-03-08T09:19:59+00:00",
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
        "item_id": "253ab1c8-471f-4391-8b40-ea0a3fc2c1ff",
        "tax_category_id": null,
        "planning_id": "c937edf9-ecfc-4ee1-9bdf-7e519d05d27d",
        "parent_line_id": "76e96b16-530b-42ea-adc0-cfcc0d371e2b",
        "owner_id": "ed867454-e673-4d1c-a60b-d0e7e1b91977",
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
      "id": "acf525b6-4b3c-45c8-b744-77854f1b3918",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:19:59+00:00",
        "updated_at": "2023-03-08T09:19:59+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-06T09:15:00+00:00",
        "stops_at": "2023-03-10T09:15:00+00:00",
        "reserved_from": "2023-03-06T09:15:00+00:00",
        "reserved_till": "2023-03-10T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0ee8c56b-1b8f-416a-8577-e56f20ee8212",
        "order_id": "ed867454-e673-4d1c-a60b-d0e7e1b91977",
        "start_location_id": "e7fcd62a-1c73-4b80-8590-5f79d7348e71",
        "stop_location_id": "e7fcd62a-1c73-4b80-8590-5f79d7348e71",
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





