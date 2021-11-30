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
          "order_id": "928914f0-06ba-43d4-b6b4-3c47d7864021",
          "items": [
            {
              "type": "products",
              "id": "118a90b4-0e73-4218-a840-80410b916009",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5b5a327c-a8f8-47ec-b35a-eaa18b0b2961",
              "stock_item_ids": [
                "2deec3a6-4493-4565-90a8-ec3ec75ace56",
                "3f661f79-28d5-4704-b8df-398a79b77d4a"
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
            "item_id": "118a90b4-0e73-4218-a840-80410b916009",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "5b5a327c-a8f8-47ec-b35a-eaa18b0b2961",
            "unavailable": [
              "2deec3a6-4493-4565-90a8-ec3ec75ace56"
            ],
            "available": [
              "3f661f79-28d5-4704-b8df-398a79b77d4a"
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
          "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
          "items": [
            {
              "type": "products",
              "id": "0052b835-0ffe-4195-ba6d-d543d0a86f04",
              "stock_item_ids": [
                "40e9ae1f-c2c8-4530-9d0a-7d0299270911",
                "10b404b7-197f-4c92-b790-bef1533a4795",
                "9a4ad97e-a780-4fdc-a464-8b3542599155"
              ]
            },
            {
              "type": "products",
              "id": "66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f",
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
    "id": "0adabc08-935d-54e7-99ba-151c5cd6f57f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ea30d09c-0b64-4c51-a177-6e563fc64712"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "afad8ff2-2a0f-417c-ac5d-2b01a16c0a81"
          },
          {
            "type": "lines",
            "id": "84632ade-eabd-4659-9ee1-1c3b6f0fff3c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dcde0fa0-6707-4fed-aee2-52ded4e197ba"
          },
          {
            "type": "plannings",
            "id": "cd6c571c-8ae3-4357-b3a4-58b965846370"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4c609a19-38a0-4d6f-8088-4cd2bd5e95b9"
          },
          {
            "type": "stock_item_plannings",
            "id": "66bcb644-241f-4960-a6b5-e79c76bb1215"
          },
          {
            "type": "stock_item_plannings",
            "id": "5e4e3344-b152-45e9-86e0-f7531295564a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-30T12:56:06+00:00",
        "updated_at": "2021-11-30T12:56:08+00:00",
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
        "customer_id": "efeeb7d7-9bbe-44c8-9217-fbe0f6258072",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755",
        "stop_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755"
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
      "id": "afad8ff2-2a0f-417c-ac5d-2b01a16c0a81",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
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
        "item_id": "66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f",
        "tax_category_id": "857412bd-b6c4-4f46-b87e-36c94eba748c",
        "parent_line_id": null,
        "owner_id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
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
      "id": "84632ade-eabd-4659-9ee1-1c3b6f0fff3c",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
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
        "item_id": "0052b835-0ffe-4195-ba6d-d543d0a86f04",
        "tax_category_id": "857412bd-b6c4-4f46-b87e-36c94eba748c",
        "parent_line_id": null,
        "owner_id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
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
      "id": "dcde0fa0-6707-4fed-aee2-52ded4e197ba",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
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
        "item_id": "0052b835-0ffe-4195-ba6d-d543d0a86f04",
        "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
        "start_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755",
        "stop_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755",
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
      "id": "cd6c571c-8ae3-4357-b3a4-58b965846370",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
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
        "item_id": "66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f",
        "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712",
        "start_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755",
        "stop_location_id": "0aaa5136-895e-4a1f-a1bf-a1ecd9576755",
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
      "id": "4c609a19-38a0-4d6f-8088-4cd2bd5e95b9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "40e9ae1f-c2c8-4530-9d0a-7d0299270911",
        "planning_id": "dcde0fa0-6707-4fed-aee2-52ded4e197ba",
        "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712"
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
      "id": "66bcb644-241f-4960-a6b5-e79c76bb1215",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "10b404b7-197f-4c92-b790-bef1533a4795",
        "planning_id": "dcde0fa0-6707-4fed-aee2-52ded4e197ba",
        "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712"
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
      "id": "5e4e3344-b152-45e9-86e0-f7531295564a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:07+00:00",
        "updated_at": "2021-11-30T12:56:07+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9a4ad97e-a780-4fdc-a464-8b3542599155",
        "planning_id": "dcde0fa0-6707-4fed-aee2-52ded4e197ba",
        "order_id": "ea30d09c-0b64-4c51-a177-6e563fc64712"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0052b835-0ffe-4195-ba6d-d543d0a86f04&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40e9ae1f-c2c8-4530-9d0a-7d0299270911&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=10b404b7-197f-4c92-b790-bef1533a4795&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9a4ad97e-a780-4fdc-a464-8b3542599155&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=66066d3a-bbb4-4d74-9d1e-e3f3a2b4138f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ea30d09c-0b64-4c51-a177-6e563fc64712&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "84052586-126d-4691-8001-57b3c08ebfd6",
          "items": [
            {
              "type": "bundles",
              "id": "b2b974af-23d3-4a6e-a70e-3d62addbd94f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8",
                  "id": "30354fc6-212e-46d9-9867-b33d3644f91a"
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
    "id": "e92360bd-44ef-5cfe-b13c-0aed69ff8012",
    "type": "order_bookings",
    "attributes": {
      "order_id": "84052586-126d-4691-8001-57b3c08ebfd6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "84052586-126d-4691-8001-57b3c08ebfd6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7b414114-cdea-4587-80bb-31bb6a4372a2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "81765160-fd85-492e-a6d8-a947d586d6a2"
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
      "id": "84052586-126d-4691-8001-57b3c08ebfd6",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-30T12:56:10+00:00",
        "updated_at": "2021-11-30T12:56:11+00:00",
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
        "starts_at": "2021-11-28T12:45:00+00:00",
        "stops_at": "2021-12-02T12:45:00+00:00",
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
        "start_location_id": "4cf3feed-4b9a-42ba-b2c1-5b972211741a",
        "stop_location_id": "4cf3feed-4b9a-42ba-b2c1-5b972211741a"
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
      "id": "7b414114-cdea-4587-80bb-31bb6a4372a2",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-30T12:56:10+00:00",
        "updated_at": "2021-11-30T12:56:10+00:00",
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
        "item_id": "b2b974af-23d3-4a6e-a70e-3d62addbd94f",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "84052586-126d-4691-8001-57b3c08ebfd6",
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
      "id": "81765160-fd85-492e-a6d8-a947d586d6a2",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-30T12:56:10+00:00",
        "updated_at": "2021-11-30T12:56:10+00:00",
        "quantity": 1,
        "starts_at": "2021-11-28T12:45:00+00:00",
        "stops_at": "2021-12-02T12:45:00+00:00",
        "reserved_from": "2021-11-28T12:45:00+00:00",
        "reserved_till": "2021-12-02T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b2b974af-23d3-4a6e-a70e-3d62addbd94f",
        "order_id": "84052586-126d-4691-8001-57b3c08ebfd6",
        "start_location_id": "4cf3feed-4b9a-42ba-b2c1-5b972211741a",
        "stop_location_id": "4cf3feed-4b9a-42ba-b2c1-5b972211741a",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&data%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&data%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&data%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&data%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2b974af-23d3-4a6e-a70e-3d62addbd94f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=5ff6e8b0-ad7f-4c10-b6e8-00d9e8d920b8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=30354fc6-212e-46d9-9867-b33d3644f91a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=84052586-126d-4691-8001-57b3c08ebfd6&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





