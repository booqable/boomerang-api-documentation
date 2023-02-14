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
          "order_id": "5ac99ca6-d82a-470f-8323-251c16b387c9",
          "items": [
            {
              "type": "products",
              "id": "8d84a767-723a-478b-92f9-e2782f059aa5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7ff9443a-371a-46ea-b91b-a155beb0c2c0",
              "stock_item_ids": [
                "dc450c21-211d-43e7-bc7a-dc1ace6f5296",
                "a69b3d58-aeef-41bd-99c3-64b92a6da139"
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
          "stock_item_id dc450c21-211d-43e7-bc7a-dc1ace6f5296 has already been booked on this order"
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
          "order_id": "decb6518-1662-4bd8-b569-92aef382458d",
          "items": [
            {
              "type": "products",
              "id": "99c3a83b-3a07-4509-9268-138aed099b37",
              "stock_item_ids": [
                "3a9869c1-bef7-49a7-b417-91955eab630f",
                "62d25a7c-d3ed-4193-9538-2e5d5f60fac0",
                "b6a3ced4-193e-43d2-af9e-f0eca6c0191c"
              ]
            },
            {
              "type": "products",
              "id": "054c5e13-a3cf-461b-967a-93125dc38594",
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
    "id": "12ded30a-9b79-59a2-abe6-530dfefb87bd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "decb6518-1662-4bd8-b569-92aef382458d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "decb6518-1662-4bd8-b569-92aef382458d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c0933a19-5e5e-4b1e-b8eb-ab7048d882b8"
          },
          {
            "type": "lines",
            "id": "1ff12364-47b7-46b1-b155-3f403df7a86a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ce31e728-d41d-4254-b72f-7067223a5ded"
          },
          {
            "type": "plannings",
            "id": "adca36ec-9210-4935-ba3c-bff671209f4c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f3b8a6c8-f91e-4fa6-8188-df57fbc33f12"
          },
          {
            "type": "stock_item_plannings",
            "id": "4ddfad92-9bfb-46a8-8b92-a0d5318a361a"
          },
          {
            "type": "stock_item_plannings",
            "id": "ed447059-e738-4759-bc12-bb0964572356"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "decb6518-1662-4bd8-b569-92aef382458d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T13:03:03+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
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
        "customer_id": "a6e7e86a-0e92-4f67-98a4-cd9d092d0c78",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b",
        "stop_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b"
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
      "id": "c0933a19-5e5e-4b1e-b8eb-ab7048d882b8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
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
        "item_id": "99c3a83b-3a07-4509-9268-138aed099b37",
        "tax_category_id": "06550d95-0f09-48a3-83ec-bc2c47db450d",
        "planning_id": "ce31e728-d41d-4254-b72f-7067223a5ded",
        "parent_line_id": null,
        "owner_id": "decb6518-1662-4bd8-b569-92aef382458d",
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
      "id": "1ff12364-47b7-46b1-b155-3f403df7a86a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
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
        "item_id": "054c5e13-a3cf-461b-967a-93125dc38594",
        "tax_category_id": "06550d95-0f09-48a3-83ec-bc2c47db450d",
        "planning_id": "adca36ec-9210-4935-ba3c-bff671209f4c",
        "parent_line_id": null,
        "owner_id": "decb6518-1662-4bd8-b569-92aef382458d",
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
      "id": "ce31e728-d41d-4254-b72f-7067223a5ded",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
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
        "item_id": "99c3a83b-3a07-4509-9268-138aed099b37",
        "order_id": "decb6518-1662-4bd8-b569-92aef382458d",
        "start_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b",
        "stop_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b",
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
      "id": "adca36ec-9210-4935-ba3c-bff671209f4c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
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
        "item_id": "054c5e13-a3cf-461b-967a-93125dc38594",
        "order_id": "decb6518-1662-4bd8-b569-92aef382458d",
        "start_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b",
        "stop_location_id": "d9f3b051-0e90-4bba-a84b-48943693755b",
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
      "id": "f3b8a6c8-f91e-4fa6-8188-df57fbc33f12",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3a9869c1-bef7-49a7-b417-91955eab630f",
        "planning_id": "ce31e728-d41d-4254-b72f-7067223a5ded",
        "order_id": "decb6518-1662-4bd8-b569-92aef382458d"
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
      "id": "4ddfad92-9bfb-46a8-8b92-a0d5318a361a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "62d25a7c-d3ed-4193-9538-2e5d5f60fac0",
        "planning_id": "ce31e728-d41d-4254-b72f-7067223a5ded",
        "order_id": "decb6518-1662-4bd8-b569-92aef382458d"
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
      "id": "ed447059-e738-4759-bc12-bb0964572356",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:05+00:00",
        "updated_at": "2023-02-14T13:03:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b6a3ced4-193e-43d2-af9e-f0eca6c0191c",
        "planning_id": "ce31e728-d41d-4254-b72f-7067223a5ded",
        "order_id": "decb6518-1662-4bd8-b569-92aef382458d"
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
          "order_id": "539fa84a-c1a1-4aec-9f4f-a25492687b04",
          "items": [
            {
              "type": "bundles",
              "id": "8fc81bd1-140a-4af6-81c9-2603ec8ca45d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3ec1ee80-ffcd-4ebe-9ec5-bdd4db42fa2d",
                  "id": "f033b2a6-dc76-4991-9a8d-04be76f0e58f"
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
    "id": "2cacdd54-ba20-55ee-bd42-bb2353b628e1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "539fa84a-c1a1-4aec-9f4f-a25492687b04"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "539fa84a-c1a1-4aec-9f4f-a25492687b04"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7be14739-7601-484c-a202-e4c133727475"
          },
          {
            "type": "lines",
            "id": "d98425df-6fc1-4331-b313-c3bd662f7d3e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7a107f9a-8df7-4121-8357-324fb2ad6b06"
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
      "id": "539fa84a-c1a1-4aec-9f4f-a25492687b04",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T13:03:08+00:00",
        "updated_at": "2023-02-14T13:03:09+00:00",
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
        "starts_at": "2023-02-12T13:00:00+00:00",
        "stops_at": "2023-02-16T13:00:00+00:00",
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
        "start_location_id": "85e17a15-4ddd-4919-9387-def2d736e68c",
        "stop_location_id": "85e17a15-4ddd-4919-9387-def2d736e68c"
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
      "id": "7be14739-7601-484c-a202-e4c133727475",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T13:03:09+00:00",
        "updated_at": "2023-02-14T13:03:09+00:00",
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
        "item_id": "f033b2a6-dc76-4991-9a8d-04be76f0e58f",
        "tax_category_id": null,
        "planning_id": "54420de5-3f9e-45a6-9b6a-374853e26a67",
        "parent_line_id": "d98425df-6fc1-4331-b313-c3bd662f7d3e",
        "owner_id": "539fa84a-c1a1-4aec-9f4f-a25492687b04",
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
      "id": "d98425df-6fc1-4331-b313-c3bd662f7d3e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T13:03:09+00:00",
        "updated_at": "2023-02-14T13:03:09+00:00",
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
        "item_id": "8fc81bd1-140a-4af6-81c9-2603ec8ca45d",
        "tax_category_id": null,
        "planning_id": "7a107f9a-8df7-4121-8357-324fb2ad6b06",
        "parent_line_id": null,
        "owner_id": "539fa84a-c1a1-4aec-9f4f-a25492687b04",
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
      "id": "7a107f9a-8df7-4121-8357-324fb2ad6b06",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T13:03:09+00:00",
        "updated_at": "2023-02-14T13:03:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-12T13:00:00+00:00",
        "stops_at": "2023-02-16T13:00:00+00:00",
        "reserved_from": "2023-02-12T13:00:00+00:00",
        "reserved_till": "2023-02-16T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8fc81bd1-140a-4af6-81c9-2603ec8ca45d",
        "order_id": "539fa84a-c1a1-4aec-9f4f-a25492687b04",
        "start_location_id": "85e17a15-4ddd-4919-9387-def2d736e68c",
        "stop_location_id": "85e17a15-4ddd-4919-9387-def2d736e68c",
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





