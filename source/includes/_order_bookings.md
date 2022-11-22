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
          "order_id": "a4a0f943-671a-4c4d-b555-8070086711d3",
          "items": [
            {
              "type": "products",
              "id": "de0b3846-a595-4e12-afd7-e022b1cbcfc0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8a256796-aaa8-4996-85ce-d9f9b3167814",
              "stock_item_ids": [
                "529462b9-3846-4e69-8ed7-d4ca6ea16099",
                "ae2fa4a4-76d3-4d6b-8e46-2ab43abf5488"
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
            "item_id": "de0b3846-a595-4e12-afd7-e022b1cbcfc0",
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
          "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
          "items": [
            {
              "type": "products",
              "id": "0b5c1fba-fecb-48a8-8f2d-95b29dd9a17c",
              "stock_item_ids": [
                "ec2285fe-3eee-4658-ad76-2423443ed384",
                "47ed1e03-dba8-4fb5-83db-40e4d2571e2b",
                "2d2ef7ae-fa14-4451-9d9e-97c1e21d9d0d"
              ]
            },
            {
              "type": "products",
              "id": "4ee6f74f-7f33-4720-8710-23ffb65f8ceb",
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
    "id": "9d40a8c2-f174-5ced-b487-e81d38c97883",
    "type": "order_bookings",
    "attributes": {
      "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "15346fd2-e560-4b8f-b81b-932faee14ddd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9518bde9-256a-42ef-af57-a5049e22a283"
          },
          {
            "type": "lines",
            "id": "055e0873-1b98-4ec6-8851-42ae104b4498"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6c50955d-2ba3-4665-9a01-c10f9eb71353"
          },
          {
            "type": "plannings",
            "id": "ce72fcfe-f3c4-46a3-8c61-04622e2073be"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d7c223c0-be09-4c6b-80ca-29b099d2c186"
          },
          {
            "type": "stock_item_plannings",
            "id": "2df675c6-aa64-4e1c-9d90-f9fa3b1ea7c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "79e986d7-e68f-48cd-96f3-9fd30599fb14"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T16:35:59+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
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
        "customer_id": "c7504b8c-7ede-41e0-8248-e7483f5b16b4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25",
        "stop_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25"
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
      "id": "9518bde9-256a-42ef-af57-a5049e22a283",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
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
        "item_id": "0b5c1fba-fecb-48a8-8f2d-95b29dd9a17c",
        "tax_category_id": "e9d9af9e-8c32-4358-9037-bb3e5574f5d7",
        "planning_id": "6c50955d-2ba3-4665-9a01-c10f9eb71353",
        "parent_line_id": null,
        "owner_id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
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
      "id": "055e0873-1b98-4ec6-8851-42ae104b4498",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
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
        "item_id": "4ee6f74f-7f33-4720-8710-23ffb65f8ceb",
        "tax_category_id": "e9d9af9e-8c32-4358-9037-bb3e5574f5d7",
        "planning_id": "ce72fcfe-f3c4-46a3-8c61-04622e2073be",
        "parent_line_id": null,
        "owner_id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
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
      "id": "6c50955d-2ba3-4665-9a01-c10f9eb71353",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
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
        "item_id": "0b5c1fba-fecb-48a8-8f2d-95b29dd9a17c",
        "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
        "start_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25",
        "stop_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25",
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
      "id": "ce72fcfe-f3c4-46a3-8c61-04622e2073be",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
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
        "item_id": "4ee6f74f-7f33-4720-8710-23ffb65f8ceb",
        "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd",
        "start_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25",
        "stop_location_id": "5bc5cc09-a854-4fa3-9d06-03860d7a1d25",
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
      "id": "d7c223c0-be09-4c6b-80ca-29b099d2c186",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ec2285fe-3eee-4658-ad76-2423443ed384",
        "planning_id": "6c50955d-2ba3-4665-9a01-c10f9eb71353",
        "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd"
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
      "id": "2df675c6-aa64-4e1c-9d90-f9fa3b1ea7c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "47ed1e03-dba8-4fb5-83db-40e4d2571e2b",
        "planning_id": "6c50955d-2ba3-4665-9a01-c10f9eb71353",
        "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd"
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
      "id": "79e986d7-e68f-48cd-96f3-9fd30599fb14",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:00+00:00",
        "updated_at": "2022-11-22T16:36:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2d2ef7ae-fa14-4451-9d9e-97c1e21d9d0d",
        "planning_id": "6c50955d-2ba3-4665-9a01-c10f9eb71353",
        "order_id": "15346fd2-e560-4b8f-b81b-932faee14ddd"
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
          "order_id": "227832e7-d91c-4d1c-8377-ebe3cc64c011",
          "items": [
            {
              "type": "bundles",
              "id": "c6c0d5ed-19df-4f9d-b775-c49f789ca299",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "778bf16c-776f-4131-8238-d1604d5b7be7",
                  "id": "b8700e19-ce5b-4bde-b70f-f505e074d695"
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
    "id": "ce27d2e6-7cd4-532b-aa27-f90cc5f3f6a7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "227832e7-d91c-4d1c-8377-ebe3cc64c011"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "227832e7-d91c-4d1c-8377-ebe3cc64c011"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3840423f-4cdd-4e21-9ec0-db766e6adf82"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "863a47e6-d0df-4ad2-8837-4b4dd163ad37"
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
      "id": "227832e7-d91c-4d1c-8377-ebe3cc64c011",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T16:36:02+00:00",
        "updated_at": "2022-11-22T16:36:02+00:00",
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
        "starts_at": "2022-11-20T16:30:00+00:00",
        "stops_at": "2022-11-24T16:30:00+00:00",
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
        "start_location_id": "e3612d51-b368-45e4-8324-38733a767b70",
        "stop_location_id": "e3612d51-b368-45e4-8324-38733a767b70"
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
      "id": "3840423f-4cdd-4e21-9ec0-db766e6adf82",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T16:36:02+00:00",
        "updated_at": "2022-11-22T16:36:02+00:00",
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
        "item_id": "c6c0d5ed-19df-4f9d-b775-c49f789ca299",
        "tax_category_id": null,
        "planning_id": "863a47e6-d0df-4ad2-8837-4b4dd163ad37",
        "parent_line_id": null,
        "owner_id": "227832e7-d91c-4d1c-8377-ebe3cc64c011",
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
      "id": "863a47e6-d0df-4ad2-8837-4b4dd163ad37",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T16:36:02+00:00",
        "updated_at": "2022-11-22T16:36:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T16:30:00+00:00",
        "stops_at": "2022-11-24T16:30:00+00:00",
        "reserved_from": "2022-11-20T16:30:00+00:00",
        "reserved_till": "2022-11-24T16:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c6c0d5ed-19df-4f9d-b775-c49f789ca299",
        "order_id": "227832e7-d91c-4d1c-8377-ebe3cc64c011",
        "start_location_id": "e3612d51-b368-45e4-8324-38733a767b70",
        "stop_location_id": "e3612d51-b368-45e4-8324-38733a767b70",
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





