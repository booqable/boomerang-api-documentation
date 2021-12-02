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
          "order_id": "932ed4bc-bf69-4bb3-bb94-d74b1e24b134",
          "items": [
            {
              "type": "products",
              "id": "bc216b77-20e7-4314-8efb-c253b4810898",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "91f0e10d-0ca2-482a-851c-9daba0f2d18f",
              "stock_item_ids": [
                "3969a8c3-eff3-4f6a-8192-270b1101be32",
                "1cbbf4f4-f8c9-475c-8a3c-1f7d5f336b72"
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
            "item_id": "bc216b77-20e7-4314-8efb-c253b4810898",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "91f0e10d-0ca2-482a-851c-9daba0f2d18f",
            "unavailable": [
              "3969a8c3-eff3-4f6a-8192-270b1101be32"
            ],
            "available": [
              "1cbbf4f4-f8c9-475c-8a3c-1f7d5f336b72"
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
          "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
          "items": [
            {
              "type": "products",
              "id": "12e9f5e5-c607-414b-983e-dd4769615f19",
              "stock_item_ids": [
                "af8c5e7f-dfe9-4d52-9bcc-60afc8613adb",
                "41b65956-bd7e-44e2-8882-b953f6f8af86",
                "77a5a607-4887-4a5b-b00c-55d7f49a01f4"
              ]
            },
            {
              "type": "products",
              "id": "95ac6a67-6fae-4498-a2d8-62fefd01e31a",
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
    "id": "a891c535-01e3-5ecc-bcb4-a66269311d78",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "39f97526-28a0-42a9-b1c2-719fe2988138"
          },
          {
            "type": "lines",
            "id": "c6839f2d-4b83-427f-af4c-3f5e1f39ca8c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c9dad551-1492-4c4b-8df8-6daf1f3181f0"
          },
          {
            "type": "plannings",
            "id": "82c6662f-f250-4baa-93de-eac3410326d3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1b41a1ce-b8d1-4841-8860-585a99cec5c4"
          },
          {
            "type": "stock_item_plannings",
            "id": "1ade058c-3398-4db2-b3c9-6eaeb7e93712"
          },
          {
            "type": "stock_item_plannings",
            "id": "3f83389e-76c6-4ba3-8db5-dd28954af4a4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T11:35:46+00:00",
        "updated_at": "2021-12-02T11:35:49+00:00",
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
        "customer_id": "374e9c2d-215c-4296-bf1a-908ac0a30a65",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93",
        "stop_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93"
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
      "id": "39f97526-28a0-42a9-b1c2-719fe2988138",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T11:35:47+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
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
        "item_id": "95ac6a67-6fae-4498-a2d8-62fefd01e31a",
        "tax_category_id": "99d126ca-2145-4443-83df-3d89e0a10d11",
        "parent_line_id": null,
        "owner_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
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
      "id": "c6839f2d-4b83-427f-af4c-3f5e1f39ca8c",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T11:35:48+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
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
        "item_id": "12e9f5e5-c607-414b-983e-dd4769615f19",
        "tax_category_id": "99d126ca-2145-4443-83df-3d89e0a10d11",
        "parent_line_id": null,
        "owner_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
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
      "id": "c9dad551-1492-4c4b-8df8-6daf1f3181f0",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:48+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
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
        "item_id": "12e9f5e5-c607-414b-983e-dd4769615f19",
        "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
        "start_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93",
        "stop_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93",
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
      "id": "82c6662f-f250-4baa-93de-eac3410326d3",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:47+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
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
        "item_id": "95ac6a67-6fae-4498-a2d8-62fefd01e31a",
        "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc",
        "start_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93",
        "stop_location_id": "6f8ca6ce-8afe-4040-a1a3-2267e06e1b93",
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
      "id": "1b41a1ce-b8d1-4841-8860-585a99cec5c4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:48+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af8c5e7f-dfe9-4d52-9bcc-60afc8613adb",
        "planning_id": "c9dad551-1492-4c4b-8df8-6daf1f3181f0",
        "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc"
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
      "id": "1ade058c-3398-4db2-b3c9-6eaeb7e93712",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:48+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "41b65956-bd7e-44e2-8882-b953f6f8af86",
        "planning_id": "c9dad551-1492-4c4b-8df8-6daf1f3181f0",
        "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc"
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
      "id": "3f83389e-76c6-4ba3-8db5-dd28954af4a4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:48+00:00",
        "updated_at": "2021-12-02T11:35:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "77a5a607-4887-4a5b-b00c-55d7f49a01f4",
        "planning_id": "c9dad551-1492-4c4b-8df8-6daf1f3181f0",
        "order_id": "2f4a3f3b-4fbc-47ad-865f-e148c4a082bc"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=12e9f5e5-c607-414b-983e-dd4769615f19&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=af8c5e7f-dfe9-4d52-9bcc-60afc8613adb&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=41b65956-bd7e-44e2-8882-b953f6f8af86&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=77a5a607-4887-4a5b-b00c-55d7f49a01f4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=95ac6a67-6fae-4498-a2d8-62fefd01e31a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2f4a3f3b-4fbc-47ad-865f-e148c4a082bc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "9cd7f237-13f4-421f-ae01-5c46b5acb626",
          "items": [
            {
              "type": "bundles",
              "id": "35730366-3499-4d9a-a228-e37a6f82d788",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "84536bb3-31ac-4512-b657-fb27f7278706",
                  "id": "25560f90-165b-4b76-9191-aad17b55c4dd"
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
    "id": "5ad45f4d-3c05-5feb-85d5-087f213d80a5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9cd7f237-13f4-421f-ae01-5c46b5acb626"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9cd7f237-13f4-421f-ae01-5c46b5acb626"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c8d2c843-3e7f-4630-a805-e6a55dc50bb3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7918d800-9694-4e83-89b0-783676b15215"
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
      "id": "9cd7f237-13f4-421f-ae01-5c46b5acb626",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T11:35:51+00:00",
        "updated_at": "2021-12-02T11:35:52+00:00",
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
        "starts_at": "2021-11-30T11:30:00+00:00",
        "stops_at": "2021-12-04T11:30:00+00:00",
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
        "start_location_id": "359e29a4-5ff4-4ce9-8b27-af7cfeea8374",
        "stop_location_id": "359e29a4-5ff4-4ce9-8b27-af7cfeea8374"
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
      "id": "c8d2c843-3e7f-4630-a805-e6a55dc50bb3",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T11:35:52+00:00",
        "updated_at": "2021-12-02T11:35:52+00:00",
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
        "item_id": "35730366-3499-4d9a-a228-e37a6f82d788",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "9cd7f237-13f4-421f-ae01-5c46b5acb626",
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
      "id": "7918d800-9694-4e83-89b0-783676b15215",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T11:35:52+00:00",
        "updated_at": "2021-12-02T11:35:52+00:00",
        "quantity": 1,
        "starts_at": "2021-11-30T11:30:00+00:00",
        "stops_at": "2021-12-04T11:30:00+00:00",
        "reserved_from": "2021-11-30T11:30:00+00:00",
        "reserved_till": "2021-12-04T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "35730366-3499-4d9a-a228-e37a6f82d788",
        "order_id": "9cd7f237-13f4-421f-ae01-5c46b5acb626",
        "start_location_id": "359e29a4-5ff4-4ce9-8b27-af7cfeea8374",
        "stop_location_id": "359e29a4-5ff4-4ce9-8b27-af7cfeea8374",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&data%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&data%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&data%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&data%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=35730366-3499-4d9a-a228-e37a6f82d788&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84536bb3-31ac-4512-b657-fb27f7278706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=25560f90-165b-4b76-9191-aad17b55c4dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=9cd7f237-13f4-421f-ae01-5c46b5acb626&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





