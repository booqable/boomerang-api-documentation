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
          "order_id": "1876398b-2a1a-4536-9f9f-718339c1c57d",
          "items": [
            {
              "type": "products",
              "id": "a788eba2-677d-4b25-beba-78c996e72ee5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9e8d1a42-d5a3-43a7-8c90-fb57f27cf824",
              "stock_item_ids": [
                "8b57ebbd-0be2-4fb2-9f31-60e37fd5d9eb",
                "3ed45236-8fd8-492d-af13-52a6dfdd6de5"
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
          "stock_item_id 8b57ebbd-0be2-4fb2-9f31-60e37fd5d9eb has already been booked on this order"
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
          "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
          "items": [
            {
              "type": "products",
              "id": "d09ce6d5-ab74-4c3e-99f5-7a9e815d138e",
              "stock_item_ids": [
                "0e372dd5-aef0-4ae3-8296-1c3a414c7eab",
                "41b83705-0ffe-4dbd-8c72-9d6531a4b0f9",
                "32cf8371-345a-46a7-9152-1fb38a9d1f13"
              ]
            },
            {
              "type": "products",
              "id": "7ce96407-5777-4e39-8ad2-1c4db840afa5",
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
    "id": "ee6c80fe-b61a-5325-84d7-4de95ba414c3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0804b1e1-c901-423a-8651-b6f56436d6c4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "52df53c1-6077-4061-afd3-7d1a85e5127d"
          },
          {
            "type": "lines",
            "id": "72a72a14-685f-4a09-b13b-baf5893e8f36"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63"
          },
          {
            "type": "plannings",
            "id": "b19fa8ce-c8c6-411d-8d42-0b184e2544a6"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8267c80f-e200-447b-8182-f9444adc343a"
          },
          {
            "type": "stock_item_plannings",
            "id": "76aee834-60de-4ef6-bcba-5822325edccb"
          },
          {
            "type": "stock_item_plannings",
            "id": "957af3ae-196c-41a1-804e-7339fed606d8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T08:54:17+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
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
        "customer_id": "58299098-22ab-4f96-ad64-2b9fc6654860",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42",
        "stop_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42"
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
      "id": "52df53c1-6077-4061-afd3-7d1a85e5127d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
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
        "item_id": "d09ce6d5-ab74-4c3e-99f5-7a9e815d138e",
        "tax_category_id": "ed09b35a-bb63-4c4d-8204-9cd264477716",
        "planning_id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63",
        "parent_line_id": null,
        "owner_id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
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
      "id": "72a72a14-685f-4a09-b13b-baf5893e8f36",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
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
        "item_id": "7ce96407-5777-4e39-8ad2-1c4db840afa5",
        "tax_category_id": "ed09b35a-bb63-4c4d-8204-9cd264477716",
        "planning_id": "b19fa8ce-c8c6-411d-8d42-0b184e2544a6",
        "parent_line_id": null,
        "owner_id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
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
      "id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
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
        "item_id": "d09ce6d5-ab74-4c3e-99f5-7a9e815d138e",
        "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
        "start_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42",
        "stop_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42",
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
      "id": "b19fa8ce-c8c6-411d-8d42-0b184e2544a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
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
        "item_id": "7ce96407-5777-4e39-8ad2-1c4db840afa5",
        "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4",
        "start_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42",
        "stop_location_id": "dd66bd8a-e510-42f5-852f-3c367da29d42",
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
      "id": "8267c80f-e200-447b-8182-f9444adc343a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0e372dd5-aef0-4ae3-8296-1c3a414c7eab",
        "planning_id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63",
        "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4"
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
      "id": "76aee834-60de-4ef6-bcba-5822325edccb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "41b83705-0ffe-4dbd-8c72-9d6531a4b0f9",
        "planning_id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63",
        "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4"
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
      "id": "957af3ae-196c-41a1-804e-7339fed606d8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:18+00:00",
        "updated_at": "2023-02-24T08:54:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "32cf8371-345a-46a7-9152-1fb38a9d1f13",
        "planning_id": "e34df6a8-7cb3-48b3-a0d1-e63b3bf8ca63",
        "order_id": "0804b1e1-c901-423a-8651-b6f56436d6c4"
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
          "order_id": "a1ff92d4-d07b-4c01-b127-3da255f7300a",
          "items": [
            {
              "type": "bundles",
              "id": "7b0004a3-02db-42dd-bfa5-c22864dbdbfa",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5789d0ec-bb93-4c02-af62-e67c43cb3502",
                  "id": "c22a4850-8edd-4e0d-a2bd-20412b3a1397"
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
    "id": "7f272171-fabd-55a4-a9b0-be5d3869e75e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a1ff92d4-d07b-4c01-b127-3da255f7300a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a1ff92d4-d07b-4c01-b127-3da255f7300a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0f164ea3-f8d1-47e7-b17d-036b0434f4dc"
          },
          {
            "type": "lines",
            "id": "8c7fa756-3979-4e4d-b8f8-23e973f1341c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5f778aeb-bb15-4756-bc02-6c9dacac7ae0"
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
      "id": "a1ff92d4-d07b-4c01-b127-3da255f7300a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T08:54:20+00:00",
        "updated_at": "2023-02-24T08:54:21+00:00",
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
        "starts_at": "2023-02-22T08:45:00+00:00",
        "stops_at": "2023-02-26T08:45:00+00:00",
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
        "start_location_id": "5cfcf9f8-9b53-4796-9e42-26c24092937d",
        "stop_location_id": "5cfcf9f8-9b53-4796-9e42-26c24092937d"
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
      "id": "0f164ea3-f8d1-47e7-b17d-036b0434f4dc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:54:21+00:00",
        "updated_at": "2023-02-24T08:54:21+00:00",
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
        "item_id": "c22a4850-8edd-4e0d-a2bd-20412b3a1397",
        "tax_category_id": null,
        "planning_id": "4796eeb1-0054-47ff-9904-531102d7c5c7",
        "parent_line_id": "8c7fa756-3979-4e4d-b8f8-23e973f1341c",
        "owner_id": "a1ff92d4-d07b-4c01-b127-3da255f7300a",
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
      "id": "8c7fa756-3979-4e4d-b8f8-23e973f1341c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:54:21+00:00",
        "updated_at": "2023-02-24T08:54:21+00:00",
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
        "item_id": "7b0004a3-02db-42dd-bfa5-c22864dbdbfa",
        "tax_category_id": null,
        "planning_id": "5f778aeb-bb15-4756-bc02-6c9dacac7ae0",
        "parent_line_id": null,
        "owner_id": "a1ff92d4-d07b-4c01-b127-3da255f7300a",
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
      "id": "5f778aeb-bb15-4756-bc02-6c9dacac7ae0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:54:21+00:00",
        "updated_at": "2023-02-24T08:54:21+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T08:45:00+00:00",
        "stops_at": "2023-02-26T08:45:00+00:00",
        "reserved_from": "2023-02-22T08:45:00+00:00",
        "reserved_till": "2023-02-26T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7b0004a3-02db-42dd-bfa5-c22864dbdbfa",
        "order_id": "a1ff92d4-d07b-4c01-b127-3da255f7300a",
        "start_location_id": "5cfcf9f8-9b53-4796-9e42-26c24092937d",
        "stop_location_id": "5cfcf9f8-9b53-4796-9e42-26c24092937d",
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





