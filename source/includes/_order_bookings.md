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
          "order_id": "fd24fb6e-e69f-46b3-a398-23b586346eba",
          "items": [
            {
              "type": "products",
              "id": "e8d7ee73-57e2-410b-808a-29aa4b6116a4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d6ee6d5c-a890-4fdd-a107-96d8c2a8af4d",
              "stock_item_ids": [
                "8808cbe7-dc81-452d-982d-ba03cc0780eb",
                "c0705859-27bf-437e-8ebd-e467ef9f4bdc"
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
          "stock_item_id 8808cbe7-dc81-452d-982d-ba03cc0780eb has already been booked on this order"
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
          "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4",
          "items": [
            {
              "type": "products",
              "id": "b73ebf57-ee3f-4d22-99d3-9fb6845fc348",
              "stock_item_ids": [
                "14c8cc1f-ee00-41c9-b315-712739320872",
                "5743aa43-4969-414e-830a-c88f7039c69e",
                "b3031e5e-5e46-418c-8203-b7ae2dc07662"
              ]
            },
            {
              "type": "products",
              "id": "fdd656f9-5d6b-4e37-8d58-bde38b9e272a",
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
    "id": "4bf011f0-a64d-5b13-b5cc-cd6cee24b556",
    "type": "order_bookings",
    "attributes": {
      "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "13a8491f-9855-4589-a158-1b6cb46043a4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9f6af34a-bc41-4f83-a979-f67b27dd4382"
          },
          {
            "type": "lines",
            "id": "f5d713d7-1639-4c9c-94e0-709e861a7ced"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e93cca35-4ed2-4933-9d40-1d2363c219c9"
          },
          {
            "type": "plannings",
            "id": "153a9283-d540-47fe-b7c3-c0a9225e80a6"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "463ca812-47ed-4d3a-b661-e3c62f11560e"
          },
          {
            "type": "stock_item_plannings",
            "id": "a0ca9ed4-4637-46bf-967a-c3de5ca03e88"
          },
          {
            "type": "stock_item_plannings",
            "id": "2f6c61ff-cae6-44c9-bc4c-4386339aaa00"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "13a8491f-9855-4589-a158-1b6cb46043a4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-15T13:23:13+00:00",
        "updated_at": "2023-02-15T13:23:16+00:00",
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
        "customer_id": "5b747d95-c550-4f27-ad55-67312e2feee7",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6",
        "stop_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6"
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
      "id": "9f6af34a-bc41-4f83-a979-f67b27dd4382",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
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
        "item_id": "b73ebf57-ee3f-4d22-99d3-9fb6845fc348",
        "tax_category_id": "a3c0f31d-a625-42e1-9aef-e21b8ee61225",
        "planning_id": "e93cca35-4ed2-4933-9d40-1d2363c219c9",
        "parent_line_id": null,
        "owner_id": "13a8491f-9855-4589-a158-1b6cb46043a4",
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
      "id": "f5d713d7-1639-4c9c-94e0-709e861a7ced",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
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
        "item_id": "fdd656f9-5d6b-4e37-8d58-bde38b9e272a",
        "tax_category_id": "a3c0f31d-a625-42e1-9aef-e21b8ee61225",
        "planning_id": "153a9283-d540-47fe-b7c3-c0a9225e80a6",
        "parent_line_id": null,
        "owner_id": "13a8491f-9855-4589-a158-1b6cb46043a4",
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
      "id": "e93cca35-4ed2-4933-9d40-1d2363c219c9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
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
        "item_id": "b73ebf57-ee3f-4d22-99d3-9fb6845fc348",
        "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4",
        "start_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6",
        "stop_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6",
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
      "id": "153a9283-d540-47fe-b7c3-c0a9225e80a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
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
        "item_id": "fdd656f9-5d6b-4e37-8d58-bde38b9e272a",
        "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4",
        "start_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6",
        "stop_location_id": "cd58e98b-7937-4bd7-8355-f2dab77ecac6",
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
      "id": "463ca812-47ed-4d3a-b661-e3c62f11560e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "14c8cc1f-ee00-41c9-b315-712739320872",
        "planning_id": "e93cca35-4ed2-4933-9d40-1d2363c219c9",
        "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4"
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
      "id": "a0ca9ed4-4637-46bf-967a-c3de5ca03e88",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5743aa43-4969-414e-830a-c88f7039c69e",
        "planning_id": "e93cca35-4ed2-4933-9d40-1d2363c219c9",
        "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4"
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
      "id": "2f6c61ff-cae6-44c9-bc4c-4386339aaa00",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:15+00:00",
        "updated_at": "2023-02-15T13:23:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b3031e5e-5e46-418c-8203-b7ae2dc07662",
        "planning_id": "e93cca35-4ed2-4933-9d40-1d2363c219c9",
        "order_id": "13a8491f-9855-4589-a158-1b6cb46043a4"
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
          "order_id": "8b22a5cf-e362-4397-b887-29d4988fcb62",
          "items": [
            {
              "type": "bundles",
              "id": "ab7d9caf-67e5-49d0-965c-f41fb067a941",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7aa93b69-ce8f-45f1-ae40-c7515c6e1a7c",
                  "id": "9e60a3c7-77fc-46a4-976b-2d65676c8e0f"
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
    "id": "11b9535e-a78e-5e6a-a42a-328a2a6d69b3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8b22a5cf-e362-4397-b887-29d4988fcb62"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8b22a5cf-e362-4397-b887-29d4988fcb62"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "70f8c63f-424e-41af-ae6d-9bc0e75b577c"
          },
          {
            "type": "lines",
            "id": "f7a0138c-0037-4c8d-966c-9c22ecf8058e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fe943a5d-fd89-4d52-9eef-c1ad15765f43"
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
      "id": "8b22a5cf-e362-4397-b887-29d4988fcb62",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-15T13:23:18+00:00",
        "updated_at": "2023-02-15T13:23:18+00:00",
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
        "starts_at": "2023-02-13T13:15:00+00:00",
        "stops_at": "2023-02-17T13:15:00+00:00",
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
        "start_location_id": "9c16182f-1de2-4bf0-860e-021825f6a801",
        "stop_location_id": "9c16182f-1de2-4bf0-860e-021825f6a801"
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
      "id": "70f8c63f-424e-41af-ae6d-9bc0e75b577c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-15T13:23:18+00:00",
        "updated_at": "2023-02-15T13:23:18+00:00",
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
        "item_id": "9e60a3c7-77fc-46a4-976b-2d65676c8e0f",
        "tax_category_id": null,
        "planning_id": "ebf9718a-f17b-4212-be2e-77a778925a6d",
        "parent_line_id": "f7a0138c-0037-4c8d-966c-9c22ecf8058e",
        "owner_id": "8b22a5cf-e362-4397-b887-29d4988fcb62",
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
      "id": "f7a0138c-0037-4c8d-966c-9c22ecf8058e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-15T13:23:18+00:00",
        "updated_at": "2023-02-15T13:23:18+00:00",
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
        "item_id": "ab7d9caf-67e5-49d0-965c-f41fb067a941",
        "tax_category_id": null,
        "planning_id": "fe943a5d-fd89-4d52-9eef-c1ad15765f43",
        "parent_line_id": null,
        "owner_id": "8b22a5cf-e362-4397-b887-29d4988fcb62",
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
      "id": "fe943a5d-fd89-4d52-9eef-c1ad15765f43",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-15T13:23:18+00:00",
        "updated_at": "2023-02-15T13:23:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-13T13:15:00+00:00",
        "stops_at": "2023-02-17T13:15:00+00:00",
        "reserved_from": "2023-02-13T13:15:00+00:00",
        "reserved_till": "2023-02-17T13:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ab7d9caf-67e5-49d0-965c-f41fb067a941",
        "order_id": "8b22a5cf-e362-4397-b887-29d4988fcb62",
        "start_location_id": "9c16182f-1de2-4bf0-860e-021825f6a801",
        "stop_location_id": "9c16182f-1de2-4bf0-860e-021825f6a801",
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





