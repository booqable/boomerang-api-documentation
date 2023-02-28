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
          "order_id": "6308ba0a-d436-461f-8105-9ac13fb99ef2",
          "items": [
            {
              "type": "products",
              "id": "d2a5a644-ba2c-4396-bfd1-bdab803ab115",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f1549c4b-1636-4bf2-a22a-78c1d0d6b142",
              "stock_item_ids": [
                "d1848b1c-4e19-415a-9907-9394b2d7a66a",
                "5be1e6a0-40b9-4b94-a0e0-f09dff80b852"
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
          "stock_item_id d1848b1c-4e19-415a-9907-9394b2d7a66a has already been booked on this order"
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
          "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
          "items": [
            {
              "type": "products",
              "id": "94921e8f-c553-4211-94e0-57b9ed960640",
              "stock_item_ids": [
                "4771c19e-1e25-4f48-ba00-bc0700b3a7ec",
                "470b0c87-481a-408c-b746-4f87b7a1a855",
                "2160fe02-9dee-4f7f-b7ee-c99dd6b0e716"
              ]
            },
            {
              "type": "products",
              "id": "eb954e52-6504-4fb1-bc76-29032dde5049",
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
    "id": "b7d3ad31-9321-53cb-a624-04a070d0aa96",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e782d5f8-53c6-44e5-bdb9-1a44cda953b8"
          },
          {
            "type": "lines",
            "id": "6b1925ea-be1a-466f-af0d-33febb50f91d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461"
          },
          {
            "type": "plannings",
            "id": "94e404ce-6c10-425f-9c90-c67554a3721a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3d98d916-01cf-4131-aef2-a9281ff9c059"
          },
          {
            "type": "stock_item_plannings",
            "id": "a7d4f3ad-4149-494a-b903-232172406967"
          },
          {
            "type": "stock_item_plannings",
            "id": "1dc5dec9-bde9-44fd-a3bd-09318392fd1c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T08:45:52+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
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
        "customer_id": "5e3a8292-1542-4ba5-b09e-d4d96a52f6ce",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc",
        "stop_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc"
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
      "id": "e782d5f8-53c6-44e5-bdb9-1a44cda953b8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
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
        "item_id": "94921e8f-c553-4211-94e0-57b9ed960640",
        "tax_category_id": "59165806-8d89-419f-80aa-23e0660c8662",
        "planning_id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461",
        "parent_line_id": null,
        "owner_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
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
      "id": "6b1925ea-be1a-466f-af0d-33febb50f91d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
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
        "item_id": "eb954e52-6504-4fb1-bc76-29032dde5049",
        "tax_category_id": "59165806-8d89-419f-80aa-23e0660c8662",
        "planning_id": "94e404ce-6c10-425f-9c90-c67554a3721a",
        "parent_line_id": null,
        "owner_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
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
      "id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
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
        "item_id": "94921e8f-c553-4211-94e0-57b9ed960640",
        "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
        "start_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc",
        "stop_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc",
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
      "id": "94e404ce-6c10-425f-9c90-c67554a3721a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
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
        "item_id": "eb954e52-6504-4fb1-bc76-29032dde5049",
        "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004",
        "start_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc",
        "stop_location_id": "6d83e6b2-8c5b-499f-9310-0287e4275ccc",
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
      "id": "3d98d916-01cf-4131-aef2-a9281ff9c059",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4771c19e-1e25-4f48-ba00-bc0700b3a7ec",
        "planning_id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461",
        "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004"
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
      "id": "a7d4f3ad-4149-494a-b903-232172406967",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "470b0c87-481a-408c-b746-4f87b7a1a855",
        "planning_id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461",
        "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004"
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
      "id": "1dc5dec9-bde9-44fd-a3bd-09318392fd1c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:53+00:00",
        "updated_at": "2023-02-28T08:45:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2160fe02-9dee-4f7f-b7ee-c99dd6b0e716",
        "planning_id": "c08dfddb-01f9-4c5d-beef-8f5360b9d461",
        "order_id": "b55ac44d-9c43-4eb4-860c-bddd6e1a1004"
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
          "order_id": "31298ae2-8b60-4155-84cb-aff0929a326d",
          "items": [
            {
              "type": "bundles",
              "id": "8d74b554-fb14-439c-8eb4-47482a615bd6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2bc3e0ee-6298-46ca-a9d0-02456de0881b",
                  "id": "37bec9f8-e70e-4e0e-bbf9-97d5499df24d"
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
    "id": "22422b58-b5cb-5ea9-980f-cb1010f50818",
    "type": "order_bookings",
    "attributes": {
      "order_id": "31298ae2-8b60-4155-84cb-aff0929a326d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "31298ae2-8b60-4155-84cb-aff0929a326d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "48318708-4eee-4406-99f8-6421458e83c4"
          },
          {
            "type": "lines",
            "id": "f080477b-a37c-4dfc-bf99-f8b31f2365c3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fdcb431a-9a41-43df-a524-db190fc6e2a6"
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
      "id": "31298ae2-8b60-4155-84cb-aff0929a326d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T08:45:55+00:00",
        "updated_at": "2023-02-28T08:45:56+00:00",
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
        "starts_at": "2023-02-26T08:45:00+00:00",
        "stops_at": "2023-03-02T08:45:00+00:00",
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
        "start_location_id": "855e8d48-6ffb-4636-9a08-d588eab82431",
        "stop_location_id": "855e8d48-6ffb-4636-9a08-d588eab82431"
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
      "id": "48318708-4eee-4406-99f8-6421458e83c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:45:55+00:00",
        "updated_at": "2023-02-28T08:45:55+00:00",
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
        "item_id": "8d74b554-fb14-439c-8eb4-47482a615bd6",
        "tax_category_id": null,
        "planning_id": "fdcb431a-9a41-43df-a524-db190fc6e2a6",
        "parent_line_id": null,
        "owner_id": "31298ae2-8b60-4155-84cb-aff0929a326d",
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
      "id": "f080477b-a37c-4dfc-bf99-f8b31f2365c3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:45:55+00:00",
        "updated_at": "2023-02-28T08:45:55+00:00",
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
        "item_id": "37bec9f8-e70e-4e0e-bbf9-97d5499df24d",
        "tax_category_id": null,
        "planning_id": "c858b214-38a9-4e6b-88e4-e54b2d27a9d9",
        "parent_line_id": "48318708-4eee-4406-99f8-6421458e83c4",
        "owner_id": "31298ae2-8b60-4155-84cb-aff0929a326d",
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
      "id": "fdcb431a-9a41-43df-a524-db190fc6e2a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:45:55+00:00",
        "updated_at": "2023-02-28T08:45:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-26T08:45:00+00:00",
        "stops_at": "2023-03-02T08:45:00+00:00",
        "reserved_from": "2023-02-26T08:45:00+00:00",
        "reserved_till": "2023-03-02T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8d74b554-fb14-439c-8eb4-47482a615bd6",
        "order_id": "31298ae2-8b60-4155-84cb-aff0929a326d",
        "start_location_id": "855e8d48-6ffb-4636-9a08-d588eab82431",
        "stop_location_id": "855e8d48-6ffb-4636-9a08-d588eab82431",
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





