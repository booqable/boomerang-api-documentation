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
- **Lines** Individual elements on order, which in the case of order bookings contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Endpoints
`POST /api/boomerang/order_bookings`

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
          "order_id": "b46a9398-7555-44f5-a8a0-d6559b2ae8b6",
          "items": [
            {
              "type": "products",
              "id": "79f0c8bf-c863-404c-8bac-9b61b8f213c6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e522cd8b-598c-4b71-aa42-c1d094edda48",
              "stock_item_ids": [
                "3605bab8-99ac-45da-a680-95d636a526a8",
                "76ac2476-4350-45bb-98af-f02b91f0c310"
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
            "item_id": "79f0c8bf-c863-404c-8bac-9b61b8f213c6",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "e522cd8b-598c-4b71-aa42-c1d094edda48",
            "unavailable": [
              "3605bab8-99ac-45da-a680-95d636a526a8"
            ],
            "available": [
              "76ac2476-4350-45bb-98af-f02b91f0c310"
            ]
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
          "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
          "items": [
            {
              "type": "products",
              "id": "5bf1d18b-6cf6-4a26-b711-475eb73dac5f",
              "stock_item_ids": [
                "22a74405-2c42-4193-a9ba-1c22260775b5",
                "a6d25419-489c-4282-b208-82700712e43d",
                "a177aae5-3192-49c9-be1d-8e4b4b0f0c5e"
              ]
            },
            {
              "type": "products",
              "id": "35588fab-b2f0-4556-a0a0-b57cd33f5f4b",
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
    "id": "4902ffe8-e411-5d84-847c-943d25e6fb79",
    "type": "order_bookings",
    "attributes": {
      "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "10b41b63-7256-4a2e-8cb9-ad703b343783"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c2131ebb-e2b2-40ec-b8f7-2e1a2d7a920e"
          },
          {
            "type": "lines",
            "id": "41d5f347-8941-4d31-b9fa-9cd11c4b1f4b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4cf4053e-ef40-4756-92ad-7d105a4c8b9b"
          },
          {
            "type": "plannings",
            "id": "b51f67e1-76e5-4a47-b56d-091af06234f5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "03be1961-2afe-4428-b2a6-4122d6c3e41d"
          },
          {
            "type": "stock_item_plannings",
            "id": "d2690c9b-62f8-46c6-9348-f913785960bf"
          },
          {
            "type": "stock_item_plannings",
            "id": "424d7551-9ffc-431b-a97a-200fae74bdd5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-23T12:48:36+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
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
        "customer_id": "145f7934-c6e0-4b1c-8dff-fbf644452340",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b",
        "stop_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b"
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
      "id": "c2131ebb-e2b2-40ec-b8f7-2e1a2d7a920e",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-23T12:48:37+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
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
        "item_id": "35588fab-b2f0-4556-a0a0-b57cd33f5f4b",
        "tax_category_id": "815386b2-3cfa-4975-af53-91cb1a96986a",
        "parent_line_id": null,
        "owner_id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
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
      "id": "41d5f347-8941-4d31-b9fa-9cd11c4b1f4b",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-23T12:48:38+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
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
        "item_id": "5bf1d18b-6cf6-4a26-b711-475eb73dac5f",
        "tax_category_id": "815386b2-3cfa-4975-af53-91cb1a96986a",
        "parent_line_id": null,
        "owner_id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
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
      "id": "4cf4053e-ef40-4756-92ad-7d105a4c8b9b",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:37+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
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
        "item_id": "35588fab-b2f0-4556-a0a0-b57cd33f5f4b",
        "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
        "start_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b",
        "stop_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b",
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
      "id": "b51f67e1-76e5-4a47-b56d-091af06234f5",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:38+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
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
        "item_id": "5bf1d18b-6cf6-4a26-b711-475eb73dac5f",
        "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783",
        "start_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b",
        "stop_location_id": "64e7acce-0fe1-4bc0-ac5c-640d3cd36b5b",
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
      "id": "03be1961-2afe-4428-b2a6-4122d6c3e41d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:38+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "22a74405-2c42-4193-a9ba-1c22260775b5",
        "planning_id": "b51f67e1-76e5-4a47-b56d-091af06234f5",
        "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783"
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
      "id": "d2690c9b-62f8-46c6-9348-f913785960bf",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:38+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a6d25419-489c-4282-b208-82700712e43d",
        "planning_id": "b51f67e1-76e5-4a47-b56d-091af06234f5",
        "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783"
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
      "id": "424d7551-9ffc-431b-a97a-200fae74bdd5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:38+00:00",
        "updated_at": "2021-11-23T12:48:38+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a177aae5-3192-49c9-be1d-8e4b4b0f0c5e",
        "planning_id": "b51f67e1-76e5-4a47-b56d-091af06234f5",
        "order_id": "10b41b63-7256-4a2e-8cb9-ad703b343783"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5bf1d18b-6cf6-4a26-b711-475eb73dac5f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=22a74405-2c42-4193-a9ba-1c22260775b5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a6d25419-489c-4282-b208-82700712e43d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a177aae5-3192-49c9-be1d-8e4b4b0f0c5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35588fab-b2f0-4556-a0a0-b57cd33f5f4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=10b41b63-7256-4a2e-8cb9-ad703b343783&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "f1891291-e1fd-4ab7-a101-89e39c01ac20",
          "items": [
            {
              "type": "bundles",
              "id": "c39b34ba-37d2-4dee-bb60-6237552d43ba",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7630a09f-dc23-43dd-be81-0351f858ea59",
                  "id": "6a29082a-5d89-49e1-9fbe-e191daf55215"
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
    "id": "76baa0e3-374a-50c6-a50c-5285b2c753eb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f1891291-e1fd-4ab7-a101-89e39c01ac20"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f1891291-e1fd-4ab7-a101-89e39c01ac20"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "88017886-065f-4a3f-991b-a1ef0c0c20a1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4b3c5d9e-6e21-40bf-a7d1-61beda3abf83"
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
      "id": "f1891291-e1fd-4ab7-a101-89e39c01ac20",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-23T12:48:40+00:00",
        "updated_at": "2021-11-23T12:48:41+00:00",
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
        "starts_at": "2021-11-21T12:45:00+00:00",
        "stops_at": "2021-11-25T12:45:00+00:00",
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
        "start_location_id": "d81beb26-b0a1-4e84-893a-25a3d7612959",
        "stop_location_id": "d81beb26-b0a1-4e84-893a-25a3d7612959"
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
      "id": "88017886-065f-4a3f-991b-a1ef0c0c20a1",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-23T12:48:41+00:00",
        "updated_at": "2021-11-23T12:48:41+00:00",
        "title": "Bundle item 1",
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
        "item_id": "c39b34ba-37d2-4dee-bb60-6237552d43ba",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "f1891291-e1fd-4ab7-a101-89e39c01ac20",
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
      "id": "4b3c5d9e-6e21-40bf-a7d1-61beda3abf83",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-23T12:48:41+00:00",
        "updated_at": "2021-11-23T12:48:41+00:00",
        "quantity": 1,
        "starts_at": "2021-11-21T12:45:00+00:00",
        "stops_at": "2021-11-25T12:45:00+00:00",
        "reserved_from": "2021-11-21T12:45:00+00:00",
        "reserved_till": "2021-11-25T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c39b34ba-37d2-4dee-bb60-6237552d43ba",
        "order_id": "f1891291-e1fd-4ab7-a101-89e39c01ac20",
        "start_location_id": "d81beb26-b0a1-4e84-893a-25a3d7612959",
        "stop_location_id": "d81beb26-b0a1-4e84-893a-25a3d7612959",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&data%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&data%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&data%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&data%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c39b34ba-37d2-4dee-bb60-6237552d43ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=7630a09f-dc23-43dd-be81-0351f858ea59&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6a29082a-5d89-49e1-9fbe-e191daf55215&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f1891291-e1fd-4ab7-a101-89e39c01ac20&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





