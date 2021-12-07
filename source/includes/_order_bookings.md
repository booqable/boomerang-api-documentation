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
          "order_id": "450cd9d7-482f-4137-92b8-66c106d0eb1b",
          "items": [
            {
              "type": "products",
              "id": "308906b6-934b-46fd-843b-0b1382463945",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8c342a43-9b97-4089-9cc2-ecacc66f2065",
              "stock_item_ids": [
                "9ae73e35-725e-4d4c-a57a-8ced0bfcd498",
                "cd4d4ffa-6864-41c3-96cc-c52108b3c188"
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
            "item_id": "308906b6-934b-46fd-843b-0b1382463945",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "8c342a43-9b97-4089-9cc2-ecacc66f2065",
            "unavailable": [
              "9ae73e35-725e-4d4c-a57a-8ced0bfcd498"
            ],
            "available": [
              "cd4d4ffa-6864-41c3-96cc-c52108b3c188"
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
          "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
          "items": [
            {
              "type": "products",
              "id": "abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e",
              "stock_item_ids": [
                "6056c41e-e3f8-4509-b561-48ce0adb073b",
                "8c57f24a-4e54-40e9-9ef9-7d64cdc71497",
                "a89e5b3c-4ead-4c4a-ab4e-4367156a2c81"
              ]
            },
            {
              "type": "products",
              "id": "f6dfd436-b314-4e30-a6ac-0c3b7c97d059",
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
    "id": "8220727d-494b-5d03-a2e6-ac5fd16e1cbd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7eb6233a-aeff-494b-93e4-448f247209fc"
          },
          {
            "type": "lines",
            "id": "e63ccc69-6be9-4ab9-95a1-3bf93c85cc55"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "415f3d14-d09c-4416-9a54-72d5bff44d17"
          },
          {
            "type": "plannings",
            "id": "716b8421-c383-49b4-94ca-9e1271d6e0e3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "570d3f02-391b-4b8c-83c7-7c8bced810c8"
          },
          {
            "type": "stock_item_plannings",
            "id": "46d9a1eb-50ae-447c-983a-f8a7dffc7889"
          },
          {
            "type": "stock_item_plannings",
            "id": "81f4739b-6903-43c6-9a16-5668955b1063"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-07T11:01:59+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
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
        "customer_id": "82cb29a8-35bd-4795-a060-b5a86b5bdf81",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199",
        "stop_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199"
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
      "id": "7eb6233a-aeff-494b-93e4-448f247209fc",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-07T11:01:59+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
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
        "item_id": "f6dfd436-b314-4e30-a6ac-0c3b7c97d059",
        "tax_category_id": "e16b725c-3f3b-4359-8c1d-dfb3a49e5330",
        "parent_line_id": null,
        "owner_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
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
      "id": "e63ccc69-6be9-4ab9-95a1-3bf93c85cc55",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-07T11:02:01+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
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
        "item_id": "abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e",
        "tax_category_id": "e16b725c-3f3b-4359-8c1d-dfb3a49e5330",
        "parent_line_id": null,
        "owner_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
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
      "id": "415f3d14-d09c-4416-9a54-72d5bff44d17",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-07T11:02:01+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
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
        "item_id": "abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e",
        "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
        "start_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199",
        "stop_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199",
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
      "id": "716b8421-c383-49b4-94ca-9e1271d6e0e3",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-07T11:01:59+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
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
        "item_id": "f6dfd436-b314-4e30-a6ac-0c3b7c97d059",
        "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd",
        "start_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199",
        "stop_location_id": "b7f83843-d65c-4213-964d-59e5e98f8199",
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
      "id": "570d3f02-391b-4b8c-83c7-7c8bced810c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-07T11:02:01+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6056c41e-e3f8-4509-b561-48ce0adb073b",
        "planning_id": "415f3d14-d09c-4416-9a54-72d5bff44d17",
        "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd"
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
      "id": "46d9a1eb-50ae-447c-983a-f8a7dffc7889",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-07T11:02:01+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8c57f24a-4e54-40e9-9ef9-7d64cdc71497",
        "planning_id": "415f3d14-d09c-4416-9a54-72d5bff44d17",
        "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd"
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
      "id": "81f4739b-6903-43c6-9a16-5668955b1063",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-07T11:02:01+00:00",
        "updated_at": "2021-12-07T11:02:01+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a89e5b3c-4ead-4c4a-ab4e-4367156a2c81",
        "planning_id": "415f3d14-d09c-4416-9a54-72d5bff44d17",
        "order_id": "dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=abf2ae60-7db9-4a0c-a0a0-7f35e0494f5e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=6056c41e-e3f8-4509-b561-48ce0adb073b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8c57f24a-4e54-40e9-9ef9-7d64cdc71497&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a89e5b3c-4ead-4c4a-ab4e-4367156a2c81&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f6dfd436-b314-4e30-a6ac-0c3b7c97d059&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dbaa3cfd-1987-4e62-a71b-d2ed6b5e99cd&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "68e52fc2-0aaf-4638-9104-042793a00c0e",
          "items": [
            {
              "type": "bundles",
              "id": "cc1f99de-fa48-4869-baf1-59eeb2a99818",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "95911584-8649-4d73-babd-c5c57616f77b",
                  "id": "d7619ca0-239d-4e05-bf6d-de7bf2859f7c"
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
    "id": "d11cb1bc-849f-5bc0-a6ee-e8f207ab1843",
    "type": "order_bookings",
    "attributes": {
      "order_id": "68e52fc2-0aaf-4638-9104-042793a00c0e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "68e52fc2-0aaf-4638-9104-042793a00c0e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b031ef08-fc7f-475b-9c0b-b1907ac7ae35"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3e050cc8-93bb-4f59-9a16-3d92ff40d8df"
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
      "id": "68e52fc2-0aaf-4638-9104-042793a00c0e",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-07T11:02:03+00:00",
        "updated_at": "2021-12-07T11:02:04+00:00",
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
        "starts_at": "2021-12-05T11:00:00+00:00",
        "stops_at": "2021-12-09T11:00:00+00:00",
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
        "start_location_id": "9d5d2e8a-5cf5-4a34-80ac-24ae3bf31b08",
        "stop_location_id": "9d5d2e8a-5cf5-4a34-80ac-24ae3bf31b08"
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
      "id": "b031ef08-fc7f-475b-9c0b-b1907ac7ae35",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-07T11:02:04+00:00",
        "updated_at": "2021-12-07T11:02:04+00:00",
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
        "item_id": "cc1f99de-fa48-4869-baf1-59eeb2a99818",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "68e52fc2-0aaf-4638-9104-042793a00c0e",
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
      "id": "3e050cc8-93bb-4f59-9a16-3d92ff40d8df",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-07T11:02:04+00:00",
        "updated_at": "2021-12-07T11:02:04+00:00",
        "quantity": 1,
        "starts_at": "2021-12-05T11:00:00+00:00",
        "stops_at": "2021-12-09T11:00:00+00:00",
        "reserved_from": "2021-12-05T11:00:00+00:00",
        "reserved_till": "2021-12-09T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cc1f99de-fa48-4869-baf1-59eeb2a99818",
        "order_id": "68e52fc2-0aaf-4638-9104-042793a00c0e",
        "start_location_id": "9d5d2e8a-5cf5-4a34-80ac-24ae3bf31b08",
        "stop_location_id": "9d5d2e8a-5cf5-4a34-80ac-24ae3bf31b08",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&data%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&data%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&data%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&data%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cc1f99de-fa48-4869-baf1-59eeb2a99818&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=95911584-8649-4d73-babd-c5c57616f77b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=d7619ca0-239d-4e05-bf6d-de7bf2859f7c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=68e52fc2-0aaf-4638-9104-042793a00c0e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





