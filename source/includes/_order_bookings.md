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
          "order_id": "2caeb7c9-c8d2-4087-8e79-a25b2ef271b2",
          "items": [
            {
              "type": "products",
              "id": "ce6640d5-c957-49c0-a378-e2af1b1038ca",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7f4e3d3e-24dd-47b9-843c-172e9dc176ce",
              "stock_item_ids": [
                "81396351-21f3-4e21-ad88-631db2dbc6e9",
                "83704703-fb9a-47c9-a283-830a66315b01"
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
          "stock_item_id 81396351-21f3-4e21-ad88-631db2dbc6e9 has already been booked on this order"
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
          "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
          "items": [
            {
              "type": "products",
              "id": "7f95ad96-408f-4070-bf01-581de927ef34",
              "stock_item_ids": [
                "7fb0c508-60cc-4fc2-a592-4cd81d649f9a",
                "dd239b6a-e6ea-44e9-bd05-3bc9b6c1fdc2",
                "ab0bc43c-0bfd-49ba-9fb5-b0478f539f67"
              ]
            },
            {
              "type": "products",
              "id": "9b07a11f-b445-4fc1-b959-303dc2e8e496",
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
    "id": "c3e7a3e0-67ea-595b-b3b8-3b2b378d3569",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9f7d78eb-1582-42a6-899c-1927bbaf5f4b"
          },
          {
            "type": "lines",
            "id": "aeafc2cf-8161-48f6-8386-7360ef101bad"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c"
          },
          {
            "type": "plannings",
            "id": "2076455d-1481-4bde-99b3-695dde60646d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d56f86f5-1e9f-4b35-b162-b58e29a7f021"
          },
          {
            "type": "stock_item_plannings",
            "id": "5db67c24-103b-4ba2-b6f5-748b065d3b60"
          },
          {
            "type": "stock_item_plannings",
            "id": "d8a9ad3a-ac5a-4e0d-8201-a049e2c9bae9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T07:57:47+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
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
        "customer_id": "3bf05d5a-ba21-4a49-979c-cc8f7098b45d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398",
        "stop_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398"
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
      "id": "9f7d78eb-1582-42a6-899c-1927bbaf5f4b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
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
        "item_id": "7f95ad96-408f-4070-bf01-581de927ef34",
        "tax_category_id": "c63737bd-2c84-4a45-907d-c9fb536fa1da",
        "planning_id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c",
        "parent_line_id": null,
        "owner_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
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
      "id": "aeafc2cf-8161-48f6-8386-7360ef101bad",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
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
        "item_id": "9b07a11f-b445-4fc1-b959-303dc2e8e496",
        "tax_category_id": "c63737bd-2c84-4a45-907d-c9fb536fa1da",
        "planning_id": "2076455d-1481-4bde-99b3-695dde60646d",
        "parent_line_id": null,
        "owner_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
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
      "id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
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
        "item_id": "7f95ad96-408f-4070-bf01-581de927ef34",
        "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
        "start_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398",
        "stop_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398",
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
      "id": "2076455d-1481-4bde-99b3-695dde60646d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
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
        "item_id": "9b07a11f-b445-4fc1-b959-303dc2e8e496",
        "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1",
        "start_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398",
        "stop_location_id": "c6d43668-0d91-4dbd-8fe3-1bf2711a7398",
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
      "id": "d56f86f5-1e9f-4b35-b162-b58e29a7f021",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7fb0c508-60cc-4fc2-a592-4cd81d649f9a",
        "planning_id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c",
        "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1"
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
      "id": "5db67c24-103b-4ba2-b6f5-748b065d3b60",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dd239b6a-e6ea-44e9-bd05-3bc9b6c1fdc2",
        "planning_id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c",
        "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1"
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
      "id": "d8a9ad3a-ac5a-4e0d-8201-a049e2c9bae9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:49+00:00",
        "updated_at": "2023-03-07T07:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ab0bc43c-0bfd-49ba-9fb5-b0478f539f67",
        "planning_id": "ecb5d6dc-64a4-4bde-bf3b-c2ad2c65870c",
        "order_id": "c3f07e65-8db0-4cfd-9409-8e3ad4f63bc1"
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
          "order_id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f",
          "items": [
            {
              "type": "bundles",
              "id": "b3b9221e-5834-4d29-82bb-2f0aa8a0e8a3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0c6c5d83-29cc-4591-97cd-a44ab83ca6dc",
                  "id": "741892e9-4cf0-4498-a705-75160520eb04"
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
    "id": "5b70c28d-c129-5ed7-9320-e136fba34929",
    "type": "order_bookings",
    "attributes": {
      "order_id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "84caca35-28a4-4df6-bccc-c1d1f15ae627"
          },
          {
            "type": "lines",
            "id": "e4f8c81e-66bc-428a-bcdd-fec873c64433"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e7317c49-239d-4683-93de-46b5c6c4939e"
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
      "id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T07:57:52+00:00",
        "updated_at": "2023-03-07T07:57:53+00:00",
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
        "starts_at": "2023-03-05T07:45:00+00:00",
        "stops_at": "2023-03-09T07:45:00+00:00",
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
        "start_location_id": "3047ee0d-1677-40ea-b74d-f4fc3297ed28",
        "stop_location_id": "3047ee0d-1677-40ea-b74d-f4fc3297ed28"
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
      "id": "84caca35-28a4-4df6-bccc-c1d1f15ae627",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T07:57:52+00:00",
        "updated_at": "2023-03-07T07:57:52+00:00",
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
        "item_id": "741892e9-4cf0-4498-a705-75160520eb04",
        "tax_category_id": null,
        "planning_id": "0fd72cf0-e051-43fe-b847-2894db65599d",
        "parent_line_id": "e4f8c81e-66bc-428a-bcdd-fec873c64433",
        "owner_id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f",
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
      "id": "e4f8c81e-66bc-428a-bcdd-fec873c64433",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T07:57:52+00:00",
        "updated_at": "2023-03-07T07:57:52+00:00",
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
        "item_id": "b3b9221e-5834-4d29-82bb-2f0aa8a0e8a3",
        "tax_category_id": null,
        "planning_id": "e7317c49-239d-4683-93de-46b5c6c4939e",
        "parent_line_id": null,
        "owner_id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f",
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
      "id": "e7317c49-239d-4683-93de-46b5c6c4939e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T07:57:52+00:00",
        "updated_at": "2023-03-07T07:57:52+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-05T07:45:00+00:00",
        "stops_at": "2023-03-09T07:45:00+00:00",
        "reserved_from": "2023-03-05T07:45:00+00:00",
        "reserved_till": "2023-03-09T07:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b3b9221e-5834-4d29-82bb-2f0aa8a0e8a3",
        "order_id": "46ca9e9d-6246-477e-8c83-9c2b91dbce7f",
        "start_location_id": "3047ee0d-1677-40ea-b74d-f4fc3297ed28",
        "stop_location_id": "3047ee0d-1677-40ea-b74d-f4fc3297ed28",
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





