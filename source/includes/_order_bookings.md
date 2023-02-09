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
          "order_id": "c11ac091-46d1-4710-83c6-21e500928d98",
          "items": [
            {
              "type": "products",
              "id": "9e3afed4-5098-4172-b5b8-e0f2c55a94a1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "26a3c00b-d820-464b-b628-a6c29a25ec4a",
              "stock_item_ids": [
                "922868fd-e9ed-4a3c-abf8-893fbe492d30",
                "68e3405d-f1ec-4fc2-b607-1edfeeec65bc"
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
            "item_id": "9e3afed4-5098-4172-b5b8-e0f2c55a94a1",
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
          "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895",
          "items": [
            {
              "type": "products",
              "id": "1733195c-234b-470a-975d-8f18a3db3fad",
              "stock_item_ids": [
                "ad343a7b-677f-444a-a146-dc894394a413",
                "c34af651-9a91-440a-8c22-50209ee17533",
                "d812e703-6f04-4c8e-a5ea-dae4421d28d2"
              ]
            },
            {
              "type": "products",
              "id": "237ad482-bac7-433f-8467-b25e8a99dc60",
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
    "id": "68d0f705-d2a4-5aad-b7dc-238282446e70",
    "type": "order_bookings",
    "attributes": {
      "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "565b152b-26b7-4fb5-86f9-d942cd409895"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "78720c93-31d4-406b-bc62-216141354229"
          },
          {
            "type": "lines",
            "id": "7843eb7c-2bf8-470f-99c6-9880dbdc2ff4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474"
          },
          {
            "type": "plannings",
            "id": "dbefc918-e7ae-4a09-9aef-0fc5970e4955"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "43eb3b57-654a-413f-be8f-2a77e937bdf1"
          },
          {
            "type": "stock_item_plannings",
            "id": "1deadc9f-8dab-41e7-a641-857d38c667d2"
          },
          {
            "type": "stock_item_plannings",
            "id": "fa51ab4b-93c8-4088-bcd5-98edc0fab8c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "565b152b-26b7-4fb5-86f9-d942cd409895",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T13:01:26+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
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
        "customer_id": "36486dc9-c2d3-490a-a3a6-e6ac9f5b2f76",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88",
        "stop_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88"
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
      "id": "78720c93-31d4-406b-bc62-216141354229",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
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
        "item_id": "1733195c-234b-470a-975d-8f18a3db3fad",
        "tax_category_id": "7eec6e0b-fa79-4eb7-84d2-c3696f4079ca",
        "planning_id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474",
        "parent_line_id": null,
        "owner_id": "565b152b-26b7-4fb5-86f9-d942cd409895",
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
      "id": "7843eb7c-2bf8-470f-99c6-9880dbdc2ff4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
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
        "item_id": "237ad482-bac7-433f-8467-b25e8a99dc60",
        "tax_category_id": "7eec6e0b-fa79-4eb7-84d2-c3696f4079ca",
        "planning_id": "dbefc918-e7ae-4a09-9aef-0fc5970e4955",
        "parent_line_id": null,
        "owner_id": "565b152b-26b7-4fb5-86f9-d942cd409895",
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
      "id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
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
        "item_id": "1733195c-234b-470a-975d-8f18a3db3fad",
        "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895",
        "start_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88",
        "stop_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88",
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
      "id": "dbefc918-e7ae-4a09-9aef-0fc5970e4955",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
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
        "item_id": "237ad482-bac7-433f-8467-b25e8a99dc60",
        "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895",
        "start_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88",
        "stop_location_id": "17e4b6b6-1da2-489c-92fb-07e73edc3d88",
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
      "id": "43eb3b57-654a-413f-be8f-2a77e937bdf1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ad343a7b-677f-444a-a146-dc894394a413",
        "planning_id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474",
        "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895"
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
      "id": "1deadc9f-8dab-41e7-a641-857d38c667d2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c34af651-9a91-440a-8c22-50209ee17533",
        "planning_id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474",
        "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895"
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
      "id": "fa51ab4b-93c8-4088-bcd5-98edc0fab8c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:28+00:00",
        "updated_at": "2023-02-09T13:01:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d812e703-6f04-4c8e-a5ea-dae4421d28d2",
        "planning_id": "f4b941d9-8255-4b3c-91ef-6cfe03bf0474",
        "order_id": "565b152b-26b7-4fb5-86f9-d942cd409895"
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
          "order_id": "f17b5f05-6115-4603-87ca-c75d686effcc",
          "items": [
            {
              "type": "bundles",
              "id": "36e8fb06-991c-4e5e-9086-f05ab6758198",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b99d8b41-6022-4c64-ba5f-561f79f880cc",
                  "id": "fc261c3c-21fe-4cad-8472-3b3c1670541a"
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
    "id": "daa3df42-cd6f-5363-92c0-7ce2110ec58f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f17b5f05-6115-4603-87ca-c75d686effcc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f17b5f05-6115-4603-87ca-c75d686effcc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f10fba2d-f80f-4243-adf8-cadead226fdd"
          },
          {
            "type": "lines",
            "id": "9bf31578-feca-4333-ae8b-a25f96c84bbc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7bacbd85-c000-4a93-af2c-8840db49065b"
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
      "id": "f17b5f05-6115-4603-87ca-c75d686effcc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T13:01:31+00:00",
        "updated_at": "2023-02-09T13:01:31+00:00",
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
        "starts_at": "2023-02-07T13:00:00+00:00",
        "stops_at": "2023-02-11T13:00:00+00:00",
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
        "start_location_id": "efdc5f8e-998c-4e2b-8239-05ff79fd8b9a",
        "stop_location_id": "efdc5f8e-998c-4e2b-8239-05ff79fd8b9a"
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
      "id": "f10fba2d-f80f-4243-adf8-cadead226fdd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:01:31+00:00",
        "updated_at": "2023-02-09T13:01:31+00:00",
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
        "item_id": "36e8fb06-991c-4e5e-9086-f05ab6758198",
        "tax_category_id": null,
        "planning_id": "7bacbd85-c000-4a93-af2c-8840db49065b",
        "parent_line_id": null,
        "owner_id": "f17b5f05-6115-4603-87ca-c75d686effcc",
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
      "id": "9bf31578-feca-4333-ae8b-a25f96c84bbc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:01:31+00:00",
        "updated_at": "2023-02-09T13:01:31+00:00",
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
        "item_id": "fc261c3c-21fe-4cad-8472-3b3c1670541a",
        "tax_category_id": null,
        "planning_id": "af8b1032-2840-4bbc-8e59-c8e78d11829a",
        "parent_line_id": "f10fba2d-f80f-4243-adf8-cadead226fdd",
        "owner_id": "f17b5f05-6115-4603-87ca-c75d686effcc",
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
      "id": "7bacbd85-c000-4a93-af2c-8840db49065b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:01:31+00:00",
        "updated_at": "2023-02-09T13:01:31+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T13:00:00+00:00",
        "stops_at": "2023-02-11T13:00:00+00:00",
        "reserved_from": "2023-02-07T13:00:00+00:00",
        "reserved_till": "2023-02-11T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "36e8fb06-991c-4e5e-9086-f05ab6758198",
        "order_id": "f17b5f05-6115-4603-87ca-c75d686effcc",
        "start_location_id": "efdc5f8e-998c-4e2b-8239-05ff79fd8b9a",
        "stop_location_id": "efdc5f8e-998c-4e2b-8239-05ff79fd8b9a",
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





