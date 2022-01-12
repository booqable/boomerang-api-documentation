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
          "order_id": "8fee2053-e1a4-41e1-9bba-bb67bb6ecbd7",
          "items": [
            {
              "type": "products",
              "id": "c2452fc4-8a27-45bd-9327-85305778bcbb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "141692f0-98a4-41c6-995e-33f1d37b03e6",
              "stock_item_ids": [
                "6ca9c502-4844-4b54-b7cb-4425d411bbe4",
                "396724af-2cc9-44d7-945f-2dc10ce9cbd8"
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
            "item_id": "c2452fc4-8a27-45bd-9327-85305778bcbb",
            "stock_count": 7,
            "reserved": 0,
            "needed": 10,
            "shortage": 3
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
          "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
          "items": [
            {
              "type": "products",
              "id": "6de6b568-9105-4e4d-a0bf-7b0f7bdba52a",
              "stock_item_ids": [
                "e7aa282a-5f0b-4e89-845b-6dd5793973c4",
                "5222ea54-3a53-47b2-ab36-a0c40d9e7723",
                "b9ea2b40-7f22-428f-98df-4859e80b7dfd"
              ]
            },
            {
              "type": "products",
              "id": "62b10cd2-5c91-4c26-a7ab-b908bfcbee14",
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
    "id": "5f71b3aa-413c-5287-89dc-b7e26084bb50",
    "type": "order_bookings",
    "attributes": {
      "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4c2cddd7-7740-4060-860f-b966396ccefa"
          },
          {
            "type": "lines",
            "id": "52ef3ac5-62ea-48fe-a09e-7cc334be0fde"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "106a88ad-e45d-4d8e-a3e7-8313a0ecc921"
          },
          {
            "type": "plannings",
            "id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "62b7f95a-3972-4c13-ab7b-a0e3d65fb981"
          },
          {
            "type": "stock_item_plannings",
            "id": "4b22366c-7f3e-4846-9ac9-8e9ed2aee934"
          },
          {
            "type": "stock_item_plannings",
            "id": "2c408844-e89e-41fb-84cb-605e48a908e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T14:03:25+00:00",
        "updated_at": "2022-01-12T14:03:27+00:00",
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
        "customer_id": "7e40e65d-089a-4ea0-978a-3482451bdbd2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73",
        "stop_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73"
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
      "id": "4c2cddd7-7740-4060-860f-b966396ccefa",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:27+00:00",
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
        "item_id": "62b10cd2-5c91-4c26-a7ab-b908bfcbee14",
        "tax_category_id": "9213d9bd-b18e-471f-97bf-b76b7d78217a",
        "planning_id": "106a88ad-e45d-4d8e-a3e7-8313a0ecc921",
        "parent_line_id": null,
        "owner_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
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
      "id": "52ef3ac5-62ea-48fe-a09e-7cc334be0fde",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:27+00:00",
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
        "item_id": "6de6b568-9105-4e4d-a0bf-7b0f7bdba52a",
        "tax_category_id": "9213d9bd-b18e-471f-97bf-b76b7d78217a",
        "planning_id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9",
        "parent_line_id": null,
        "owner_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
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
      "id": "106a88ad-e45d-4d8e-a3e7-8313a0ecc921",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:26+00:00",
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
        "item_id": "62b10cd2-5c91-4c26-a7ab-b908bfcbee14",
        "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
        "start_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73",
        "stop_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73",
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
      "id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:26+00:00",
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
        "item_id": "6de6b568-9105-4e4d-a0bf-7b0f7bdba52a",
        "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72",
        "start_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73",
        "stop_location_id": "bb151c46-29e9-46e8-8db7-ffbe16ed7c73",
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
      "id": "62b7f95a-3972-4c13-ab7b-a0e3d65fb981",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e7aa282a-5f0b-4e89-845b-6dd5793973c4",
        "planning_id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9",
        "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72"
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
      "id": "4b22366c-7f3e-4846-9ac9-8e9ed2aee934",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5222ea54-3a53-47b2-ab36-a0c40d9e7723",
        "planning_id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9",
        "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72"
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
      "id": "2c408844-e89e-41fb-84cb-605e48a908e3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:26+00:00",
        "updated_at": "2022-01-12T14:03:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b9ea2b40-7f22-428f-98df-4859e80b7dfd",
        "planning_id": "56acada6-9a5a-4dc8-9452-93cf990b9aa9",
        "order_id": "09d04c6d-779b-444e-ab5c-d4567a5a8f72"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6de6b568-9105-4e4d-a0bf-7b0f7bdba52a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e7aa282a-5f0b-4e89-845b-6dd5793973c4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5222ea54-3a53-47b2-ab36-a0c40d9e7723&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b9ea2b40-7f22-428f-98df-4859e80b7dfd&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=62b10cd2-5c91-4c26-a7ab-b908bfcbee14&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=09d04c6d-779b-444e-ab5c-d4567a5a8f72&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "23d2a4fd-a6bb-4232-a268-e261a0307077",
          "items": [
            {
              "type": "bundles",
              "id": "6eba4e64-d21f-4460-98bc-8f26968b7b27",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0d0ff061-c39f-4dc0-9bac-717883a23271",
                  "id": "22753f3d-0333-4723-85c5-3aeeb4c683cb"
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
    "id": "e86adb1a-8d14-53de-8749-d0d3b6948fbf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "23d2a4fd-a6bb-4232-a268-e261a0307077"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "23d2a4fd-a6bb-4232-a268-e261a0307077"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7556db16-8081-4ba1-a959-8f47b136923a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "23b82287-f1d3-402a-8ef3-d41f94fb34c2"
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
      "id": "23d2a4fd-a6bb-4232-a268-e261a0307077",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T14:03:29+00:00",
        "updated_at": "2022-01-12T14:03:30+00:00",
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
        "starts_at": "2022-01-10T14:00:00+00:00",
        "stops_at": "2022-01-14T14:00:00+00:00",
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
        "start_location_id": "08a1a92a-02ac-4bb1-9a9a-7f5676741781",
        "stop_location_id": "08a1a92a-02ac-4bb1-9a9a-7f5676741781"
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
      "id": "7556db16-8081-4ba1-a959-8f47b136923a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T14:03:30+00:00",
        "updated_at": "2022-01-12T14:03:30+00:00",
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
        "item_id": "6eba4e64-d21f-4460-98bc-8f26968b7b27",
        "tax_category_id": null,
        "planning_id": "23b82287-f1d3-402a-8ef3-d41f94fb34c2",
        "parent_line_id": null,
        "owner_id": "23d2a4fd-a6bb-4232-a268-e261a0307077",
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
      "id": "23b82287-f1d3-402a-8ef3-d41f94fb34c2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T14:03:29+00:00",
        "updated_at": "2022-01-12T14:03:29+00:00",
        "quantity": 1,
        "starts_at": "2022-01-10T14:00:00+00:00",
        "stops_at": "2022-01-14T14:00:00+00:00",
        "reserved_from": "2022-01-10T14:00:00+00:00",
        "reserved_till": "2022-01-14T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6eba4e64-d21f-4460-98bc-8f26968b7b27",
        "order_id": "23d2a4fd-a6bb-4232-a268-e261a0307077",
        "start_location_id": "08a1a92a-02ac-4bb1-9a9a-7f5676741781",
        "stop_location_id": "08a1a92a-02ac-4bb1-9a9a-7f5676741781",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&data%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&data%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&data%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&data%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6eba4e64-d21f-4460-98bc-8f26968b7b27&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=0d0ff061-c39f-4dc0-9bac-717883a23271&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=22753f3d-0333-4723-85c5-3aeeb4c683cb&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=23d2a4fd-a6bb-4232-a268-e261a0307077&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





