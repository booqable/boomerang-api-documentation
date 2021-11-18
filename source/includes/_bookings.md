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
          "order_id": "5a3a9d10-110f-4de9-92f3-13bed330c561",
          "items": [
            {
              "type": "products",
              "id": "1d7fdb03-43cc-416b-a45b-cad3b05ff774",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4fcf389d-8953-48a0-ba27-103f211cd3c9",
              "stock_item_ids": [
                "27fdff96-00d0-478d-8078-3c07898c7321",
                "33bf1fb7-d40a-4845-9180-bc1c9ca6f12e"
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
            "item_id": "1d7fdb03-43cc-416b-a45b-cad3b05ff774",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "4fcf389d-8953-48a0-ba27-103f211cd3c9",
            "unavailable": [
              "27fdff96-00d0-478d-8078-3c07898c7321"
            ],
            "available": [
              "33bf1fb7-d40a-4845-9180-bc1c9ca6f12e"
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
          "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
          "items": [
            {
              "type": "products",
              "id": "92f864a0-e59d-46d0-a9b5-72e5ec82e0e7",
              "stock_item_ids": [
                "24292a41-a6b8-4e8b-8f23-c7086bf82f2f",
                "fff54f9f-fa61-42d3-818f-4fa6978dbde9",
                "2938b9c5-d490-4513-8b41-b36beb678892"
              ]
            },
            {
              "type": "products",
              "id": "de7214aa-f72a-40b0-b0af-200756c3c204",
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
    "id": "4ffbca3c-bb97-5aa9-9b38-476dab214b48",
    "type": "bookings",
    "attributes": {
      "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6bcee788-7c77-4c05-9b19-d5e744d874c5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "810a73cf-6a68-4671-946b-ca036329c5c6"
          },
          {
            "type": "lines",
            "id": "9b263fc8-6227-4b0b-a917-79fe4dde82f2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b47f7cd8-bcc9-4d85-9eae-12a25f43d269"
          },
          {
            "type": "plannings",
            "id": "8562e28c-62b8-4e80-84de-0ae541f8b0cd"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4602f7eb-ee5d-4864-b046-5157bb34dc25"
          },
          {
            "type": "stock_item_plannings",
            "id": "d55eac09-ff07-4e7a-bff7-8848260e002d"
          },
          {
            "type": "stock_item_plannings",
            "id": "04b9bc81-4bfe-4c90-a6a7-64f8023ab203"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T15:14:22+00:00",
        "updated_at": "2021-11-18T15:14:24+00:00",
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
        "customer_id": "5645da57-639a-4e39-8196-3f5d8f33f686",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c",
        "stop_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c"
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
      "id": "810a73cf-6a68-4671-946b-ca036329c5c6",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:14:22+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
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
        "item_id": "de7214aa-f72a-40b0-b0af-200756c3c204",
        "tax_category_id": "180c0b0b-9fb1-4a8e-84e7-730d56aa4151",
        "parent_line_id": null,
        "owner_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
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
      "id": "9b263fc8-6227-4b0b-a917-79fe4dde82f2",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:14:23+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
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
        "item_id": "92f864a0-e59d-46d0-a9b5-72e5ec82e0e7",
        "tax_category_id": "180c0b0b-9fb1-4a8e-84e7-730d56aa4151",
        "parent_line_id": null,
        "owner_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
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
      "id": "b47f7cd8-bcc9-4d85-9eae-12a25f43d269",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:23+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
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
        "item_id": "92f864a0-e59d-46d0-a9b5-72e5ec82e0e7",
        "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
        "start_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c",
        "stop_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c",
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
      "id": "8562e28c-62b8-4e80-84de-0ae541f8b0cd",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:22+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
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
        "item_id": "de7214aa-f72a-40b0-b0af-200756c3c204",
        "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5",
        "start_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c",
        "stop_location_id": "3eac374a-6607-499a-96be-22f7a193ee5c",
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
      "id": "4602f7eb-ee5d-4864-b046-5157bb34dc25",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:23+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "24292a41-a6b8-4e8b-8f23-c7086bf82f2f",
        "planning_id": "b47f7cd8-bcc9-4d85-9eae-12a25f43d269",
        "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5"
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
      "id": "d55eac09-ff07-4e7a-bff7-8848260e002d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:23+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fff54f9f-fa61-42d3-818f-4fa6978dbde9",
        "planning_id": "b47f7cd8-bcc9-4d85-9eae-12a25f43d269",
        "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5"
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
      "id": "04b9bc81-4bfe-4c90-a6a7-64f8023ab203",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:23+00:00",
        "updated_at": "2021-11-18T15:14:23+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2938b9c5-d490-4513-8b41-b36beb678892",
        "planning_id": "b47f7cd8-bcc9-4d85-9eae-12a25f43d269",
        "order_id": "6bcee788-7c77-4c05-9b19-d5e744d874c5"
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92f864a0-e59d-46d0-a9b5-72e5ec82e0e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=24292a41-a6b8-4e8b-8f23-c7086bf82f2f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fff54f9f-fa61-42d3-818f-4fa6978dbde9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2938b9c5-d490-4513-8b41-b36beb678892&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=de7214aa-f72a-40b0-b0af-200756c3c204&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=6bcee788-7c77-4c05-9b19-d5e744d874c5&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "774fa8a2-f66a-4829-9883-eb9a0cf19074",
          "items": [
            {
              "type": "bundles",
              "id": "b3550a7f-fcad-4daa-a40a-27a4a2e8c74c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b510ba44-b845-481c-b202-59a67260830b",
                  "id": "5478c7f2-8cde-43d0-a844-b8dec705ba3c"
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
    "id": "a24bd245-ddd4-5d60-a99a-6d4e3d84f311",
    "type": "bookings",
    "attributes": {
      "order_id": "774fa8a2-f66a-4829-9883-eb9a0cf19074"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "774fa8a2-f66a-4829-9883-eb9a0cf19074"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "463a0e1d-6213-4068-8dda-07e77bc9bab4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d8001312-96af-471d-9016-f8b9c9e81e22"
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
      "id": "774fa8a2-f66a-4829-9883-eb9a0cf19074",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T15:14:25+00:00",
        "updated_at": "2021-11-18T15:14:26+00:00",
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
        "starts_at": "2021-11-16T15:00:00+00:00",
        "stops_at": "2021-11-20T15:00:00+00:00",
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
        "start_location_id": "af3a2948-4fea-43d6-810e-fdb9504485ad",
        "stop_location_id": "af3a2948-4fea-43d6-810e-fdb9504485ad"
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
      "id": "463a0e1d-6213-4068-8dda-07e77bc9bab4",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T15:14:26+00:00",
        "updated_at": "2021-11-18T15:14:26+00:00",
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
        "item_id": "b3550a7f-fcad-4daa-a40a-27a4a2e8c74c",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "774fa8a2-f66a-4829-9883-eb9a0cf19074",
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
      "id": "d8001312-96af-471d-9016-f8b9c9e81e22",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T15:14:26+00:00",
        "updated_at": "2021-11-18T15:14:26+00:00",
        "quantity": 1,
        "starts_at": "2021-11-16T15:00:00+00:00",
        "stops_at": "2021-11-20T15:00:00+00:00",
        "reserved_from": "2021-11-16T15:00:00+00:00",
        "reserved_till": "2021-11-20T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b3550a7f-fcad-4daa-a40a-27a4a2e8c74c",
        "order_id": "774fa8a2-f66a-4829-9883-eb9a0cf19074",
        "start_location_id": "af3a2948-4fea-43d6-810e-fdb9504485ad",
        "stop_location_id": "af3a2948-4fea-43d6-810e-fdb9504485ad",
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&data%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&data%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&data%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b3550a7f-fcad-4daa-a40a-27a4a2e8c74c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b510ba44-b845-481c-b202-59a67260830b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=5478c7f2-8cde-43d0-a844-b8dec705ba3c&data%5Battributes%5D%5Border_id%5D=774fa8a2-f66a-4829-9883-eb9a0cf19074&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





