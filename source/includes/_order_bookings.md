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
          "order_id": "d19f3fc7-b271-4bbd-b2e1-b363010687f5",
          "items": [
            {
              "type": "products",
              "id": "42e249d5-c581-49e8-8cf6-5563904ee8f6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5a5a91fd-8131-453b-b553-37087289fda3",
              "stock_item_ids": [
                "23a66940-0e08-4618-9fa1-103b406098b9",
                "def32d67-e6fd-4b47-9f35-0ef9da418ab3"
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
            "item_id": "42e249d5-c581-49e8-8cf6-5563904ee8f6",
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
          "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
          "items": [
            {
              "type": "products",
              "id": "3aac9b37-4315-428e-bb4e-008974cdfcc4",
              "stock_item_ids": [
                "6db1b003-a225-4466-b712-684feb551c3e",
                "9858691c-b6f0-47b7-9435-5d21c96705d3",
                "8cdeb936-420c-4685-9f92-6e0bc51e5f9c"
              ]
            },
            {
              "type": "products",
              "id": "fb681864-3295-4e73-aef3-2aa26a07ebd0",
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
    "id": "7b646fcc-4b4f-5b01-91d2-90372acc3991",
    "type": "order_bookings",
    "attributes": {
      "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "64813a2f-373d-4ed7-a011-64cea5ac6417"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f1055218-43be-40c1-90ff-032d96fe4ea8"
          },
          {
            "type": "lines",
            "id": "0c065823-9f78-49d4-8913-f7442935f185"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0cc6a488-debd-4d52-91e6-2fefac97cea8"
          },
          {
            "type": "plannings",
            "id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ac8b912a-8ef8-45f3-9593-e145c198294e"
          },
          {
            "type": "stock_item_plannings",
            "id": "f679e149-8957-47a2-a25c-294358bed81d"
          },
          {
            "type": "stock_item_plannings",
            "id": "f0498cfd-86aa-44e9-be53-7d1b104e3b7d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-07T12:00:05+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
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
        "customer_id": "9176e8a5-be07-421c-a2e1-7161e04aada5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e",
        "stop_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e"
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
      "id": "f1055218-43be-40c1-90ff-032d96fe4ea8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:00:06+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "fb681864-3295-4e73-aef3-2aa26a07ebd0",
        "tax_category_id": "85e678b7-279c-461d-a600-caa792d82643",
        "planning_id": "0cc6a488-debd-4d52-91e6-2fefac97cea8",
        "parent_line_id": null,
        "owner_id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
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
      "id": "0c065823-9f78-49d4-8913-f7442935f185",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:00:07+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
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
        "item_id": "3aac9b37-4315-428e-bb4e-008974cdfcc4",
        "tax_category_id": "85e678b7-279c-461d-a600-caa792d82643",
        "planning_id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54",
        "parent_line_id": null,
        "owner_id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
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
      "id": "0cc6a488-debd-4d52-91e6-2fefac97cea8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:06+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "fb681864-3295-4e73-aef3-2aa26a07ebd0",
        "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
        "start_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e",
        "stop_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e",
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
      "id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:07+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
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
        "item_id": "3aac9b37-4315-428e-bb4e-008974cdfcc4",
        "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417",
        "start_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e",
        "stop_location_id": "a57c1390-6150-4860-9189-572b6fb5a97e",
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
      "id": "ac8b912a-8ef8-45f3-9593-e145c198294e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:07+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6db1b003-a225-4466-b712-684feb551c3e",
        "planning_id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54",
        "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417"
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
      "id": "f679e149-8957-47a2-a25c-294358bed81d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:07+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9858691c-b6f0-47b7-9435-5d21c96705d3",
        "planning_id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54",
        "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417"
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
      "id": "f0498cfd-86aa-44e9-be53-7d1b104e3b7d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:07+00:00",
        "updated_at": "2022-07-07T12:00:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8cdeb936-420c-4685-9f92-6e0bc51e5f9c",
        "planning_id": "c6f631ba-4cfb-4b23-8f24-4aeecfc9bc54",
        "order_id": "64813a2f-373d-4ed7-a011-64cea5ac6417"
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
          "order_id": "9377a088-9046-4521-a919-72f09838d5f5",
          "items": [
            {
              "type": "bundles",
              "id": "c3db6b08-9c3d-44d4-8b01-4b08dabed791",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "dee77196-7a81-4980-8af5-e6c7207450ab",
                  "id": "73fe71f7-7fda-4dde-a7a5-6ff8769d315f"
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
    "id": "783d2646-bcc5-507b-b092-2d1b8878e177",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9377a088-9046-4521-a919-72f09838d5f5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9377a088-9046-4521-a919-72f09838d5f5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3c6295fa-ca3d-41dd-aec4-7dd362b3fbc6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bbdd497a-0536-42d9-9ac0-d017811b8c0f"
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
      "id": "9377a088-9046-4521-a919-72f09838d5f5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-07T12:00:09+00:00",
        "updated_at": "2022-07-07T12:00:10+00:00",
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
        "starts_at": "2022-07-05T12:00:00+00:00",
        "stops_at": "2022-07-09T12:00:00+00:00",
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
        "start_location_id": "55c08ce1-0028-412a-b262-553165c5eb94",
        "stop_location_id": "55c08ce1-0028-412a-b262-553165c5eb94"
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
      "id": "3c6295fa-ca3d-41dd-aec4-7dd362b3fbc6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:00:10+00:00",
        "updated_at": "2022-07-07T12:00:10+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "c3db6b08-9c3d-44d4-8b01-4b08dabed791",
        "tax_category_id": null,
        "planning_id": "bbdd497a-0536-42d9-9ac0-d017811b8c0f",
        "parent_line_id": null,
        "owner_id": "9377a088-9046-4521-a919-72f09838d5f5",
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
      "id": "bbdd497a-0536-42d9-9ac0-d017811b8c0f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:00:10+00:00",
        "updated_at": "2022-07-07T12:00:10+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-05T12:00:00+00:00",
        "stops_at": "2022-07-09T12:00:00+00:00",
        "reserved_from": "2022-07-05T12:00:00+00:00",
        "reserved_till": "2022-07-09T12:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c3db6b08-9c3d-44d4-8b01-4b08dabed791",
        "order_id": "9377a088-9046-4521-a919-72f09838d5f5",
        "start_location_id": "55c08ce1-0028-412a-b262-553165c5eb94",
        "stop_location_id": "55c08ce1-0028-412a-b262-553165c5eb94",
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





