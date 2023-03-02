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
          "order_id": "4bf85339-b7fb-4e74-9cb8-fef245bba3e3",
          "items": [
            {
              "type": "products",
              "id": "0dc490c0-97f2-4537-945d-4126ea88e9ea",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9415f029-c5ca-46a4-93b4-aa0fd8690005",
              "stock_item_ids": [
                "3357e45d-b494-44ce-bb0e-54328be4a11c",
                "cc767b47-c5ae-4138-ade3-6c1641ac8c67"
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
          "stock_item_id 3357e45d-b494-44ce-bb0e-54328be4a11c has already been booked on this order"
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
          "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
          "items": [
            {
              "type": "products",
              "id": "05d3d203-19da-49bd-83ab-a10c6c25be37",
              "stock_item_ids": [
                "1150c372-e946-400f-a059-400b4f04b9bb",
                "a33ce8d8-9764-40c2-a7dd-271d366526b2",
                "92e13b1a-8ea9-4447-9640-fcce56f24c51"
              ]
            },
            {
              "type": "products",
              "id": "b22e427f-c216-491b-8eea-e0b70569a46d",
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
    "id": "2c65a81c-646a-5e2a-8656-cc941473ee0b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e1c4bf59-ea0a-465e-85ae-1bb0be5d4717"
          },
          {
            "type": "lines",
            "id": "4bf3bd31-7942-4623-8dd8-be38f0279c52"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "527b1c06-6749-4474-8cdc-5e5a1cc36338"
          },
          {
            "type": "plannings",
            "id": "ec393101-846f-4d29-9bec-9b00a7692e74"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6bfe4c7c-1999-48dc-87ee-c6c05e933a9d"
          },
          {
            "type": "stock_item_plannings",
            "id": "947bc75e-3b52-4d36-b396-de56480aa905"
          },
          {
            "type": "stock_item_plannings",
            "id": "92bc7c8d-4a4a-4185-bbf2-67a599bb7f8a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T13:56:26+00:00",
        "updated_at": "2023-03-02T13:56:29+00:00",
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
        "customer_id": "0750e456-f957-4f6d-80b3-e6e87b34fa72",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433",
        "stop_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433"
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
      "id": "e1c4bf59-ea0a-465e-85ae-1bb0be5d4717",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
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
        "item_id": "05d3d203-19da-49bd-83ab-a10c6c25be37",
        "tax_category_id": "c56dec78-720c-4163-a9a3-ad99b840a123",
        "planning_id": "527b1c06-6749-4474-8cdc-5e5a1cc36338",
        "parent_line_id": null,
        "owner_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
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
      "id": "4bf3bd31-7942-4623-8dd8-be38f0279c52",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
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
        "item_id": "b22e427f-c216-491b-8eea-e0b70569a46d",
        "tax_category_id": "c56dec78-720c-4163-a9a3-ad99b840a123",
        "planning_id": "ec393101-846f-4d29-9bec-9b00a7692e74",
        "parent_line_id": null,
        "owner_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
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
      "id": "527b1c06-6749-4474-8cdc-5e5a1cc36338",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
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
        "item_id": "05d3d203-19da-49bd-83ab-a10c6c25be37",
        "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
        "start_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433",
        "stop_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433",
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
      "id": "ec393101-846f-4d29-9bec-9b00a7692e74",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
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
        "item_id": "b22e427f-c216-491b-8eea-e0b70569a46d",
        "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9",
        "start_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433",
        "stop_location_id": "c57a9a58-3127-4ead-935e-8e5c9fd56433",
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
      "id": "6bfe4c7c-1999-48dc-87ee-c6c05e933a9d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1150c372-e946-400f-a059-400b4f04b9bb",
        "planning_id": "527b1c06-6749-4474-8cdc-5e5a1cc36338",
        "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9"
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
      "id": "947bc75e-3b52-4d36-b396-de56480aa905",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a33ce8d8-9764-40c2-a7dd-271d366526b2",
        "planning_id": "527b1c06-6749-4474-8cdc-5e5a1cc36338",
        "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9"
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
      "id": "92bc7c8d-4a4a-4185-bbf2-67a599bb7f8a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:28+00:00",
        "updated_at": "2023-03-02T13:56:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "92e13b1a-8ea9-4447-9640-fcce56f24c51",
        "planning_id": "527b1c06-6749-4474-8cdc-5e5a1cc36338",
        "order_id": "3600da6b-dbad-4f83-8f8d-46fcc49418a9"
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
          "order_id": "304b5c7c-3511-4147-a257-38b77db32573",
          "items": [
            {
              "type": "bundles",
              "id": "efc33d35-592c-465d-93c9-f81910ffa647",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ff82b4da-be11-4fa5-a29c-985091be54a3",
                  "id": "9915ae96-61b5-40b9-a4ca-1d48b2b244fb"
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
    "id": "728dbd65-3ca3-5562-ae12-045b1c4697e6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "304b5c7c-3511-4147-a257-38b77db32573"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "304b5c7c-3511-4147-a257-38b77db32573"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "755e66fb-2e5c-4311-be6b-04b58b622cab"
          },
          {
            "type": "lines",
            "id": "435aa0c7-47e6-4a01-92b5-27dfd8008620"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "de78a106-7d27-4bfe-8742-cbbb8e7569cb"
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
      "id": "304b5c7c-3511-4147-a257-38b77db32573",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T13:56:31+00:00",
        "updated_at": "2023-03-02T13:56:32+00:00",
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
        "starts_at": "2023-02-28T13:45:00+00:00",
        "stops_at": "2023-03-04T13:45:00+00:00",
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
        "start_location_id": "897b450e-c22f-4ce0-87cd-7e8b2ac763ea",
        "stop_location_id": "897b450e-c22f-4ce0-87cd-7e8b2ac763ea"
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
      "id": "755e66fb-2e5c-4311-be6b-04b58b622cab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T13:56:31+00:00",
        "updated_at": "2023-03-02T13:56:31+00:00",
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
        "item_id": "9915ae96-61b5-40b9-a4ca-1d48b2b244fb",
        "tax_category_id": null,
        "planning_id": "b37f5633-1985-4c0f-89f5-77c34c324420",
        "parent_line_id": "435aa0c7-47e6-4a01-92b5-27dfd8008620",
        "owner_id": "304b5c7c-3511-4147-a257-38b77db32573",
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
      "id": "435aa0c7-47e6-4a01-92b5-27dfd8008620",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T13:56:31+00:00",
        "updated_at": "2023-03-02T13:56:31+00:00",
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
        "item_id": "efc33d35-592c-465d-93c9-f81910ffa647",
        "tax_category_id": null,
        "planning_id": "de78a106-7d27-4bfe-8742-cbbb8e7569cb",
        "parent_line_id": null,
        "owner_id": "304b5c7c-3511-4147-a257-38b77db32573",
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
      "id": "de78a106-7d27-4bfe-8742-cbbb8e7569cb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T13:56:31+00:00",
        "updated_at": "2023-03-02T13:56:31+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-28T13:45:00+00:00",
        "stops_at": "2023-03-04T13:45:00+00:00",
        "reserved_from": "2023-02-28T13:45:00+00:00",
        "reserved_till": "2023-03-04T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "efc33d35-592c-465d-93c9-f81910ffa647",
        "order_id": "304b5c7c-3511-4147-a257-38b77db32573",
        "start_location_id": "897b450e-c22f-4ce0-87cd-7e8b2ac763ea",
        "stop_location_id": "897b450e-c22f-4ce0-87cd-7e8b2ac763ea",
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





