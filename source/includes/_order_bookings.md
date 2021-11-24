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
          "order_id": "7d0e7839-c63c-4e59-95f5-d2fccdc4a104",
          "items": [
            {
              "type": "products",
              "id": "ab2c0579-744e-4752-a277-ac23d336939a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b4121928-9852-4756-bcec-488db0bd890e",
              "stock_item_ids": [
                "221fcb0c-0041-4699-ad1f-24ea650fb7ef",
                "df9c1b61-82e0-4023-890e-77d29a22d52e"
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
            "item_id": "ab2c0579-744e-4752-a277-ac23d336939a",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "b4121928-9852-4756-bcec-488db0bd890e",
            "unavailable": [
              "221fcb0c-0041-4699-ad1f-24ea650fb7ef"
            ],
            "available": [
              "df9c1b61-82e0-4023-890e-77d29a22d52e"
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
          "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b",
          "items": [
            {
              "type": "products",
              "id": "cef18f11-2229-4824-bb63-86041d4f89d1",
              "stock_item_ids": [
                "b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9",
                "ef48db43-2903-4b40-9df8-d9bc023487f3",
                "b535c6c9-cd87-4587-a8d8-d86d27317859"
              ]
            },
            {
              "type": "products",
              "id": "2afe486a-b357-474a-8b10-ff1e37d64102",
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
    "id": "5435b29e-14d2-5ad5-ba0a-c878c5e37f32",
    "type": "order_bookings",
    "attributes": {
      "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "14502ef3-1472-4874-9b4f-3d636b10391b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "51aa2674-70ae-463c-a4e4-e9280b173cbf"
          },
          {
            "type": "lines",
            "id": "539b9105-465b-4fd4-aad9-4c3feab22d65"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f5f22fc4-d955-443d-ba39-a782ab7ea414"
          },
          {
            "type": "plannings",
            "id": "320cad83-d30b-41e7-a760-b8f5ce52a4fb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e2e11ee2-0ddd-4157-b5ba-de57e6198a51"
          },
          {
            "type": "stock_item_plannings",
            "id": "9f351909-3f6d-4202-bfe5-3564dad6dc56"
          },
          {
            "type": "stock_item_plannings",
            "id": "28e1b19e-12bf-4cf7-8bd5-de269a0e9c12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "14502ef3-1472-4874-9b4f-3d636b10391b",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-24T18:22:00+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
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
        "customer_id": "f8267d80-8a7f-465f-94eb-0a1352402bb8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2",
        "stop_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2"
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
      "id": "51aa2674-70ae-463c-a4e4-e9280b173cbf",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-24T18:22:01+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
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
        "item_id": "2afe486a-b357-474a-8b10-ff1e37d64102",
        "tax_category_id": "937d477e-e848-4f94-a38e-be78d07bc110",
        "parent_line_id": null,
        "owner_id": "14502ef3-1472-4874-9b4f-3d636b10391b",
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
      "id": "539b9105-465b-4fd4-aad9-4c3feab22d65",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-24T18:22:02+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
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
        "item_id": "cef18f11-2229-4824-bb63-86041d4f89d1",
        "tax_category_id": "937d477e-e848-4f94-a38e-be78d07bc110",
        "parent_line_id": null,
        "owner_id": "14502ef3-1472-4874-9b4f-3d636b10391b",
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
      "id": "f5f22fc4-d955-443d-ba39-a782ab7ea414",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:01+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
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
        "item_id": "2afe486a-b357-474a-8b10-ff1e37d64102",
        "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b",
        "start_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2",
        "stop_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2",
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
      "id": "320cad83-d30b-41e7-a760-b8f5ce52a4fb",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:02+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
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
        "item_id": "cef18f11-2229-4824-bb63-86041d4f89d1",
        "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b",
        "start_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2",
        "stop_location_id": "7016d1d0-a471-4fc0-8320-c324cdcce2c2",
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
      "id": "e2e11ee2-0ddd-4157-b5ba-de57e6198a51",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:02+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9",
        "planning_id": "320cad83-d30b-41e7-a760-b8f5ce52a4fb",
        "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b"
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
      "id": "9f351909-3f6d-4202-bfe5-3564dad6dc56",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:02+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ef48db43-2903-4b40-9df8-d9bc023487f3",
        "planning_id": "320cad83-d30b-41e7-a760-b8f5ce52a4fb",
        "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b"
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
      "id": "28e1b19e-12bf-4cf7-8bd5-de269a0e9c12",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:02+00:00",
        "updated_at": "2021-11-24T18:22:02+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b535c6c9-cd87-4587-a8d8-d86d27317859",
        "planning_id": "320cad83-d30b-41e7-a760-b8f5ce52a4fb",
        "order_id": "14502ef3-1472-4874-9b4f-3d636b10391b"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cef18f11-2229-4824-bb63-86041d4f89d1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b4a8fb32-6ce3-4225-9c4c-3ea04f3a82a9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ef48db43-2903-4b40-9df8-d9bc023487f3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b535c6c9-cd87-4587-a8d8-d86d27317859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2afe486a-b357-474a-8b10-ff1e37d64102&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=14502ef3-1472-4874-9b4f-3d636b10391b&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803",
          "items": [
            {
              "type": "bundles",
              "id": "ab101737-58af-47fe-a2e8-9c5123e16c11",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fca2b736-eb93-4afc-b007-114750309195",
                  "id": "9b8ff57e-b605-494a-bd37-d7a881bd36b7"
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
    "id": "fbf19481-74de-55bd-9f87-553ec985e3a2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ad46b2cf-79a0-43ae-b861-ac1b8c41e5b8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6eac753e-4345-457c-bc10-ad6387467d5d"
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
      "id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-24T18:22:04+00:00",
        "updated_at": "2021-11-24T18:22:05+00:00",
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
        "starts_at": "2021-11-22T18:15:00+00:00",
        "stops_at": "2021-11-26T18:15:00+00:00",
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
        "start_location_id": "cb8fb3ed-6680-4fb8-b027-fc80b4a807bf",
        "stop_location_id": "cb8fb3ed-6680-4fb8-b027-fc80b4a807bf"
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
      "id": "ad46b2cf-79a0-43ae-b861-ac1b8c41e5b8",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-24T18:22:05+00:00",
        "updated_at": "2021-11-24T18:22:05+00:00",
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
        "item_id": "ab101737-58af-47fe-a2e8-9c5123e16c11",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803",
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
      "id": "6eac753e-4345-457c-bc10-ad6387467d5d",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-24T18:22:05+00:00",
        "updated_at": "2021-11-24T18:22:05+00:00",
        "quantity": 1,
        "starts_at": "2021-11-22T18:15:00+00:00",
        "stops_at": "2021-11-26T18:15:00+00:00",
        "reserved_from": "2021-11-22T18:15:00+00:00",
        "reserved_till": "2021-11-26T18:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ab101737-58af-47fe-a2e8-9c5123e16c11",
        "order_id": "d68b3d58-5b97-4fa3-821c-1a6cc865d803",
        "start_location_id": "cb8fb3ed-6680-4fb8-b027-fc80b4a807bf",
        "stop_location_id": "cb8fb3ed-6680-4fb8-b027-fc80b4a807bf",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&data%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&data%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&data%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&data%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ab101737-58af-47fe-a2e8-9c5123e16c11&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=fca2b736-eb93-4afc-b007-114750309195&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9b8ff57e-b605-494a-bd37-d7a881bd36b7&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=d68b3d58-5b97-4fa3-821c-1a6cc865d803&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





