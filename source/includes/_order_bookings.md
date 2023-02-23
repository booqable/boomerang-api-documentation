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
          "order_id": "fe3d2a4d-3974-4156-91b5-4db3a3647cb8",
          "items": [
            {
              "type": "products",
              "id": "38f80a99-8e88-4115-b2af-6add835d9789",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f1bf4cec-b02f-4cfa-8d78-dc4899195b6e",
              "stock_item_ids": [
                "50caad43-9b16-4175-9ea1-cd1214b90446",
                "0b95f37c-d152-4013-8a23-eae2b90df962"
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
          "stock_item_id 50caad43-9b16-4175-9ea1-cd1214b90446 has already been booked on this order"
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
          "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
          "items": [
            {
              "type": "products",
              "id": "098dd71a-4a7c-4689-bb1c-e8aefd252dd9",
              "stock_item_ids": [
                "ffc75a4f-b8ed-4ba1-a211-d86d6e5183bb",
                "b88a7ace-616c-455a-9d38-f345f89e9289",
                "619977f1-4640-463e-901d-0ea0c6e08904"
              ]
            },
            {
              "type": "products",
              "id": "b2d884e5-95b3-45e6-8a62-419be286d7a8",
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
    "id": "4437741e-55d4-589c-9556-502b03760021",
    "type": "order_bookings",
    "attributes": {
      "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1f0dd4b0-5d62-403c-a2e8-1f8236b79459"
          },
          {
            "type": "lines",
            "id": "fc9779ff-d246-49d8-9e6b-10883808e247"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3"
          },
          {
            "type": "plannings",
            "id": "fda47467-f3e4-4f59-a709-d4136d2c2f24"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7cce65a7-06d8-4c2a-855d-6a3e24f81ab9"
          },
          {
            "type": "stock_item_plannings",
            "id": "069042fb-2332-460a-a3ff-73bfd183edb7"
          },
          {
            "type": "stock_item_plannings",
            "id": "fc1d782c-40b9-41b8-8b09-55f59c003b1d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T08:21:08+00:00",
        "updated_at": "2023-02-23T08:21:11+00:00",
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
        "customer_id": "7ca0c785-42ce-42b5-a267-590ba3266b25",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485",
        "stop_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485"
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
      "id": "1f0dd4b0-5d62-403c-a2e8-1f8236b79459",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:11+00:00",
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
        "item_id": "098dd71a-4a7c-4689-bb1c-e8aefd252dd9",
        "tax_category_id": "f35d296d-d45b-4234-ab3f-895c6c88826d",
        "planning_id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3",
        "parent_line_id": null,
        "owner_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
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
      "id": "fc9779ff-d246-49d8-9e6b-10883808e247",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:11+00:00",
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
        "item_id": "b2d884e5-95b3-45e6-8a62-419be286d7a8",
        "tax_category_id": "f35d296d-d45b-4234-ab3f-895c6c88826d",
        "planning_id": "fda47467-f3e4-4f59-a709-d4136d2c2f24",
        "parent_line_id": null,
        "owner_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
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
      "id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:10+00:00",
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
        "item_id": "098dd71a-4a7c-4689-bb1c-e8aefd252dd9",
        "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
        "start_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485",
        "stop_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485",
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
      "id": "fda47467-f3e4-4f59-a709-d4136d2c2f24",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:10+00:00",
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
        "item_id": "b2d884e5-95b3-45e6-8a62-419be286d7a8",
        "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b",
        "start_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485",
        "stop_location_id": "2374c9ec-6839-4736-aac0-3a47550fc485",
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
      "id": "7cce65a7-06d8-4c2a-855d-6a3e24f81ab9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ffc75a4f-b8ed-4ba1-a211-d86d6e5183bb",
        "planning_id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3",
        "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b"
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
      "id": "069042fb-2332-460a-a3ff-73bfd183edb7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b88a7ace-616c-455a-9d38-f345f89e9289",
        "planning_id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3",
        "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b"
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
      "id": "fc1d782c-40b9-41b8-8b09-55f59c003b1d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:10+00:00",
        "updated_at": "2023-02-23T08:21:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "619977f1-4640-463e-901d-0ea0c6e08904",
        "planning_id": "33c3c0ee-1483-467f-9c0b-4d4f60750fd3",
        "order_id": "68d3e9a1-18bf-4eb5-87e8-6f98032c518b"
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
          "order_id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc",
          "items": [
            {
              "type": "bundles",
              "id": "e43302ba-34d7-4175-8ac6-e55866179dfa",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "bbb65c20-37c4-4257-8fb9-a1cab6bb2e8d",
                  "id": "80018681-6144-4522-b1a7-14b0e49bb6c4"
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
    "id": "149abf09-56e1-57c6-a2e7-19f6294ceb84",
    "type": "order_bookings",
    "attributes": {
      "order_id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cebd3944-eda4-4423-b0d1-f8f441499478"
          },
          {
            "type": "lines",
            "id": "686bf401-ca0e-4fd2-9a0a-a1b2ec980b92"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f7125f8a-953f-4b05-b42b-8ffcc23bc959"
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
      "id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T08:21:17+00:00",
        "updated_at": "2023-02-23T08:21:18+00:00",
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
        "starts_at": "2023-02-21T08:15:00+00:00",
        "stops_at": "2023-02-25T08:15:00+00:00",
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
        "start_location_id": "d9255b8c-3ccb-4199-beef-176c50816235",
        "stop_location_id": "d9255b8c-3ccb-4199-beef-176c50816235"
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
      "id": "cebd3944-eda4-4423-b0d1-f8f441499478",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:21:18+00:00",
        "updated_at": "2023-02-23T08:21:18+00:00",
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
        "item_id": "e43302ba-34d7-4175-8ac6-e55866179dfa",
        "tax_category_id": null,
        "planning_id": "f7125f8a-953f-4b05-b42b-8ffcc23bc959",
        "parent_line_id": null,
        "owner_id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc",
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
      "id": "686bf401-ca0e-4fd2-9a0a-a1b2ec980b92",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:21:18+00:00",
        "updated_at": "2023-02-23T08:21:18+00:00",
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
        "item_id": "80018681-6144-4522-b1a7-14b0e49bb6c4",
        "tax_category_id": null,
        "planning_id": "edf5a472-22d4-45a0-816d-58077036cb5e",
        "parent_line_id": "cebd3944-eda4-4423-b0d1-f8f441499478",
        "owner_id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc",
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
      "id": "f7125f8a-953f-4b05-b42b-8ffcc23bc959",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:21:18+00:00",
        "updated_at": "2023-02-23T08:21:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-21T08:15:00+00:00",
        "stops_at": "2023-02-25T08:15:00+00:00",
        "reserved_from": "2023-02-21T08:15:00+00:00",
        "reserved_till": "2023-02-25T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e43302ba-34d7-4175-8ac6-e55866179dfa",
        "order_id": "becc18c3-5f09-400b-bdf2-edfe7fe701fc",
        "start_location_id": "d9255b8c-3ccb-4199-beef-176c50816235",
        "stop_location_id": "d9255b8c-3ccb-4199-beef-176c50816235",
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





