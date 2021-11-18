# Bookings

Add products, bundles and specific stock items to an order.

Items can be added quantitatively or, for trackable products, specific stock items can be specified. Specifying stock items is not required on booking; they can also be defined when transitioning the order status to a `started` state.

> Adding items quantitatively:

```
  "items": [
    {
      "type": "products",
      "id": "69a6ac18-244e-4b1e-b2e1-c88d155b51e5",
      "quantity": 10
    }
  ]
```

> Adding specific stock items:

```
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

```
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
    }
  ]
```

> Adding a bundle and specifying a variation (for product that has variations)

```
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "products": [
        {
          type: "products",
          bundle_item_id: "1456d221-029c-42ad-abcd-ad8d70c9e3f0",
          id: "ee64a622-3ac5-4859-a582-b3467b8027e8"
        }
      }
    }
  ]
```

**When a booking is successful, the price and status information of the order will be updated, and the following resources are created:**

- **Plannings** Quantitative data about the planning of an item.
- **Stock item plannings** Planning for specific stock items (when stock items are specified).
- **Lines** Individual elements on order, which in the case of bookings contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Endpoints
`POST /api/boomerang/bookings`

## Fields
Every booking has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


## Relationships
Bookings have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`lines` | **Lines** `readonly`<br>Associated Lines
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Creating a booking



> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "d8b7d209-4e59-4e3b-9338-44ab916a243b",
          "items": [
            {
              "type": "products",
              "id": "24092341-07b4-4d45-87e2-b18918969969",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1b60dc11-d8e4-481e-8801-db77d879a5c9",
              "stock_item_ids": [
                "ecc5a6f8-51cd-4525-9f58-0830a2cd7efb",
                "12cd3502-b795-412f-ade1-33ec7bde10d8"
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
            "item_id": "24092341-07b4-4d45-87e2-b18918969969",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "1b60dc11-d8e4-481e-8801-db77d879a5c9",
            "unavailable": [
              "ecc5a6f8-51cd-4525-9f58-0830a2cd7efb"
            ],
            "available": [
              "12cd3502-b795-412f-ade1-33ec7bde10d8"
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
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
          "items": [
            {
              "type": "products",
              "id": "007cb7b1-de6f-4198-bf24-9498171ae163",
              "stock_item_ids": [
                "9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93",
                "7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc",
                "529720e3-d5a1-4e28-8ca4-191d6f5fa13b"
              ]
            },
            {
              "type": "products",
              "id": "0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b",
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
    "id": "b8d8f79b-4bca-5557-964f-d293aded0220",
    "type": "bookings",
    "attributes": {
      "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1652fb44-2ea7-4d3c-9f72-120b0e3e4b51"
          },
          {
            "type": "lines",
            "id": "be98a127-5a32-40be-875e-0ccce80aa187"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d34bf814-7f64-4957-be74-3ad6c5f146b5"
          },
          {
            "type": "plannings",
            "id": "9d096dfc-1e5e-413f-b94a-21231d5e15f5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ed214f66-c9f5-49b4-9b10-ec023619eff5"
          },
          {
            "type": "stock_item_plannings",
            "id": "3114ecb7-c327-4304-a20f-b9d2a8749457"
          },
          {
            "type": "stock_item_plannings",
            "id": "20005d04-c16f-49d9-a529-f150e1910892"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T15:31:34+00:00",
        "updated_at": "2021-11-18T15:31:37+00:00",
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
        "customer_id": "36c2e64b-f2ba-48fa-8dd7-5b64fd7b3663",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd",
        "stop_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd"
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
      "id": "1652fb44-2ea7-4d3c-9f72-120b0e3e4b51",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:31:35+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
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
        "item_id": "0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b",
        "tax_category_id": "03ea5163-cf12-48c3-a6e5-7be44be036d9",
        "parent_line_id": null,
        "owner_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
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
      "id": "be98a127-5a32-40be-875e-0ccce80aa187",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:31:36+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
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
        "item_id": "007cb7b1-de6f-4198-bf24-9498171ae163",
        "tax_category_id": "03ea5163-cf12-48c3-a6e5-7be44be036d9",
        "parent_line_id": null,
        "owner_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
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
      "id": "d34bf814-7f64-4957-be74-3ad6c5f146b5",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:36+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
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
        "item_id": "007cb7b1-de6f-4198-bf24-9498171ae163",
        "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
        "start_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd",
        "stop_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd",
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
      "id": "9d096dfc-1e5e-413f-b94a-21231d5e15f5",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:35+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
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
        "item_id": "0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b",
        "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd",
        "start_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd",
        "stop_location_id": "da95e9bf-b69e-4b94-81d2-94c6d009a0cd",
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
      "id": "ed214f66-c9f5-49b4-9b10-ec023619eff5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:36+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93",
        "planning_id": "d34bf814-7f64-4957-be74-3ad6c5f146b5",
        "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd"
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
      "id": "3114ecb7-c327-4304-a20f-b9d2a8749457",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:36+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc",
        "planning_id": "d34bf814-7f64-4957-be74-3ad6c5f146b5",
        "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd"
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
      "id": "20005d04-c16f-49d9-a529-f150e1910892",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:36+00:00",
        "updated_at": "2021-11-18T15:31:36+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "529720e3-d5a1-4e28-8ca4-191d6f5fa13b",
        "planning_id": "d34bf814-7f64-4957-be74-3ad6c5f146b5",
        "order_id": "7733e1b1-3a68-4295-bd1a-65c7e4167cfd"
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=007cb7b1-de6f-4198-bf24-9498171ae163&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9b18d7b8-f4ad-4dce-a5fb-c6b0b2824d93&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bfbf99d-b0d6-4a74-a8f3-7edaa30f5cfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=529720e3-d5a1-4e28-8ca4-191d6f5fa13b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0f15ddeb-d2a9-46fc-bf39-d6045a4c7d3b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7733e1b1-3a68-4295-bd1a-65c7e4167cfd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "67707801-a65d-4794-9ade-0d32d68f7971",
          "items": [
            {
              "type": "bundles",
              "id": "b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "212feaf7-e9b1-49c1-8842-9ce22c11c872",
                  "id": "05a9a2c8-9982-4be3-a42e-bd77c8728b64"
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
    "id": "18e5b387-7704-56e0-a37e-8f283228f25b",
    "type": "bookings",
    "attributes": {
      "order_id": "67707801-a65d-4794-9ade-0d32d68f7971"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "67707801-a65d-4794-9ade-0d32d68f7971"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "639af7ba-d1e5-48bf-9f5d-90d6d1fa1fe6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "25d25c98-8014-4fc1-9868-380c5e81bf5d"
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
      "id": "67707801-a65d-4794-9ade-0d32d68f7971",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T15:31:38+00:00",
        "updated_at": "2021-11-18T15:31:39+00:00",
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
        "starts_at": "2021-11-16T15:30:00+00:00",
        "stops_at": "2021-11-20T15:30:00+00:00",
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
        "start_location_id": "a19a1d1d-903f-47cc-94ab-bd7cf256bedc",
        "stop_location_id": "a19a1d1d-903f-47cc-94ab-bd7cf256bedc"
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
      "id": "639af7ba-d1e5-48bf-9f5d-90d6d1fa1fe6",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:31:39+00:00",
        "updated_at": "2021-11-18T15:31:39+00:00",
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
        "item_id": "b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "67707801-a65d-4794-9ade-0d32d68f7971",
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
      "id": "25d25c98-8014-4fc1-9868-380c5e81bf5d",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:31:39+00:00",
        "updated_at": "2021-11-18T15:31:39+00:00",
        "quantity": 1,
        "starts_at": "2021-11-16T15:30:00+00:00",
        "stops_at": "2021-11-20T15:30:00+00:00",
        "reserved_from": "2021-11-16T15:30:00+00:00",
        "reserved_till": "2021-11-20T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb",
        "order_id": "67707801-a65d-4794-9ade-0d32d68f7971",
        "start_location_id": "a19a1d1d-903f-47cc-94ab-bd7cf256bedc",
        "stop_location_id": "a19a1d1d-903f-47cc-94ab-bd7cf256bedc",
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&data%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&data%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&data%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b6f0dfd5-3f9d-4eb0-af08-2747fa8700bb&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=212feaf7-e9b1-49c1-8842-9ce22c11c872&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=05a9a2c8-9982-4be3-a42e-bd77c8728b64&data%5Battributes%5D%5Border_id%5D=67707801-a65d-4794-9ade-0d32d68f7971&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bookings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bookings]=id,created_at,updated_at`


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





