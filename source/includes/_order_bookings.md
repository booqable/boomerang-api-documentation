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
          "order_id": "4ffb4b17-609a-4b86-9396-ef45edd49ab2",
          "items": [
            {
              "type": "products",
              "id": "abb28d7e-84ca-4aab-b92c-8d63ae7da797",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "15fa6877-019e-4d30-b9e4-93df6c2dfe3c",
              "stock_item_ids": [
                "0501797d-f900-4f59-835f-ae9d360e5f77",
                "84e7d239-e0fd-402c-a194-36e13e04177d"
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
            "item_id": "abb28d7e-84ca-4aab-b92c-8d63ae7da797",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "15fa6877-019e-4d30-b9e4-93df6c2dfe3c",
            "unavailable": [
              "0501797d-f900-4f59-835f-ae9d360e5f77"
            ],
            "available": [
              "84e7d239-e0fd-402c-a194-36e13e04177d"
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
          "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07",
          "items": [
            {
              "type": "products",
              "id": "49e3874e-da56-481f-8275-2669dc972b56",
              "stock_item_ids": [
                "ca4e467e-2169-4dd2-942b-3ffba879c05a",
                "a3d39b85-8fdf-434e-9a7d-40b805ffa443",
                "e038bc85-0901-4435-b3a9-c08a71a87bea"
              ]
            },
            {
              "type": "products",
              "id": "e2ca7868-f1a9-48af-8ba5-382b0c0f6f63",
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
    "id": "7f63014c-a1da-5e17-94fd-019c2bfab2fc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c93c2376-6484-416a-9a0c-82b98f16db07"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "37b1e68b-8e8a-4f01-a697-1c4d40da7165"
          },
          {
            "type": "lines",
            "id": "d8828b64-fc01-4da0-a1f0-b243ec6c96f6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4922f332-bbad-4959-9bbd-99e1f4578e2a"
          },
          {
            "type": "plannings",
            "id": "6c5d4477-a9c8-4b26-83d1-97111f97642b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "428f06d9-6b80-4da2-ae2f-80c2167627f8"
          },
          {
            "type": "stock_item_plannings",
            "id": "99f4b31a-61e7-401b-b735-23ab5f6662d3"
          },
          {
            "type": "stock_item_plannings",
            "id": "f6b0d26d-9770-400b-962f-41efcd011399"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c93c2376-6484-416a-9a0c-82b98f16db07",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-08T11:25:44+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
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
        "customer_id": "e77f9fab-9dec-44a8-994c-c619735e99a6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27",
        "stop_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27"
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
      "id": "37b1e68b-8e8a-4f01-a697-1c4d40da7165",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
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
        "item_id": "e2ca7868-f1a9-48af-8ba5-382b0c0f6f63",
        "tax_category_id": "d9e34fb9-c0ae-4b80-a077-d0ea371b52af",
        "parent_line_id": null,
        "owner_id": "c93c2376-6484-416a-9a0c-82b98f16db07",
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
      "id": "d8828b64-fc01-4da0-a1f0-b243ec6c96f6",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-08T11:25:46+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
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
        "item_id": "49e3874e-da56-481f-8275-2669dc972b56",
        "tax_category_id": "d9e34fb9-c0ae-4b80-a077-d0ea371b52af",
        "parent_line_id": null,
        "owner_id": "c93c2376-6484-416a-9a0c-82b98f16db07",
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
      "id": "4922f332-bbad-4959-9bbd-99e1f4578e2a",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
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
        "item_id": "49e3874e-da56-481f-8275-2669dc972b56",
        "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07",
        "start_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27",
        "stop_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27",
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
      "id": "6c5d4477-a9c8-4b26-83d1-97111f97642b",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
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
        "item_id": "e2ca7868-f1a9-48af-8ba5-382b0c0f6f63",
        "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07",
        "start_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27",
        "stop_location_id": "4432ed95-b03a-48a2-ab5d-678e68866d27",
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
      "id": "428f06d9-6b80-4da2-ae2f-80c2167627f8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ca4e467e-2169-4dd2-942b-3ffba879c05a",
        "planning_id": "4922f332-bbad-4959-9bbd-99e1f4578e2a",
        "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07"
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
      "id": "99f4b31a-61e7-401b-b735-23ab5f6662d3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a3d39b85-8fdf-434e-9a7d-40b805ffa443",
        "planning_id": "4922f332-bbad-4959-9bbd-99e1f4578e2a",
        "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07"
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
      "id": "f6b0d26d-9770-400b-962f-41efcd011399",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:45+00:00",
        "updated_at": "2021-12-08T11:25:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e038bc85-0901-4435-b3a9-c08a71a87bea",
        "planning_id": "4922f332-bbad-4959-9bbd-99e1f4578e2a",
        "order_id": "c93c2376-6484-416a-9a0c-82b98f16db07"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=49e3874e-da56-481f-8275-2669dc972b56&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ca4e467e-2169-4dd2-942b-3ffba879c05a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3d39b85-8fdf-434e-9a7d-40b805ffa443&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e038bc85-0901-4435-b3a9-c08a71a87bea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e2ca7868-f1a9-48af-8ba5-382b0c0f6f63&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c93c2376-6484-416a-9a0c-82b98f16db07&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0",
          "items": [
            {
              "type": "bundles",
              "id": "fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "21c77830-f32f-400e-9071-ac2ecc226d38",
                  "id": "99fd376d-4b07-4a82-93a1-b68db0d4b030"
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
    "id": "ba3ed28d-cabc-5e28-888f-18ceef7cf1a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "40beab35-0ef4-4588-a670-0bc19d4b6fab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9d364d5f-6d5a-444e-ae56-28c837f72fb0"
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
      "id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-08T11:25:48+00:00",
        "updated_at": "2021-12-08T11:25:49+00:00",
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
        "starts_at": "2021-12-06T11:15:00+00:00",
        "stops_at": "2021-12-10T11:15:00+00:00",
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
        "start_location_id": "1776e0b5-e219-4a72-9312-2ecd15a4399a",
        "stop_location_id": "1776e0b5-e219-4a72-9312-2ecd15a4399a"
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
      "id": "40beab35-0ef4-4588-a670-0bc19d4b6fab",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-08T11:25:49+00:00",
        "updated_at": "2021-12-08T11:25:49+00:00",
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
        "item_id": "fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0",
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
      "id": "9d364d5f-6d5a-444e-ae56-28c837f72fb0",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-08T11:25:49+00:00",
        "updated_at": "2021-12-08T11:25:49+00:00",
        "quantity": 1,
        "starts_at": "2021-12-06T11:15:00+00:00",
        "stops_at": "2021-12-10T11:15:00+00:00",
        "reserved_from": "2021-12-06T11:15:00+00:00",
        "reserved_till": "2021-12-10T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18",
        "order_id": "060d1569-c54e-45d4-984e-4fcdf73fa6a0",
        "start_location_id": "1776e0b5-e219-4a72-9312-2ecd15a4399a",
        "stop_location_id": "1776e0b5-e219-4a72-9312-2ecd15a4399a",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&data%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&data%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&data%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&data%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=fdfe6f53-91c1-48ad-8cca-dd5ab83f9b18&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=21c77830-f32f-400e-9071-ac2ecc226d38&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=99fd376d-4b07-4a82-93a1-b68db0d4b030&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=060d1569-c54e-45d4-984e-4fcdf73fa6a0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





