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
          "order_id": "60fb19db-3d0c-4875-bdd8-4d9019f5dc55",
          "items": [
            {
              "type": "products",
              "id": "50e85cd7-0ec4-4bdc-9bfc-a47fb16d2463",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "40fd8557-33f8-4512-bdea-2ec139a7e881",
              "stock_item_ids": [
                "7bc4f439-d1ef-4127-98e9-edb616dfce0f",
                "a499470c-86a1-4966-9c00-daa7294b3f95"
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
            "item_id": "50e85cd7-0ec4-4bdc-9bfc-a47fb16d2463",
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
          "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663",
          "items": [
            {
              "type": "products",
              "id": "a1376492-c550-4fc8-91d1-ea320c48b562",
              "stock_item_ids": [
                "8e0a711d-34ac-4814-98d3-bab725d8f1df",
                "2a341e8c-1110-4dcc-8491-48c6e475f568",
                "9b1d4fd4-b342-4f50-b776-d50c3e20d9cc"
              ]
            },
            {
              "type": "products",
              "id": "4d6858c7-b60b-44e8-a4d1-a6916be6a168",
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
    "id": "db078ed3-876e-52ea-b40a-3fda2482f338",
    "type": "order_bookings",
    "attributes": {
      "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "26b36827-d839-4e61-b6ac-1df003c4a663"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "45db5844-1026-4166-b085-538a11443fb7"
          },
          {
            "type": "lines",
            "id": "095981d0-8be9-48ab-8dd1-21de1596bf92"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cde745f0-5574-4ed9-8eb9-b140fc386153"
          },
          {
            "type": "plannings",
            "id": "08172799-0b24-4822-b230-53b9dcc1c475"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d3adbd5b-f6a6-42de-9ab1-0a394a85d641"
          },
          {
            "type": "stock_item_plannings",
            "id": "953d7306-a4e0-4f8e-b890-89afaef9e223"
          },
          {
            "type": "stock_item_plannings",
            "id": "b9cfa4c2-2be3-4e48-b9a7-a84ef4c37198"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "26b36827-d839-4e61-b6ac-1df003c4a663",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T09:29:18+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
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
        "customer_id": "2b935687-2df5-40de-9b6f-1a1d9dc1b052",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328",
        "stop_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328"
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
      "id": "45db5844-1026-4166-b085-538a11443fb7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
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
        "item_id": "a1376492-c550-4fc8-91d1-ea320c48b562",
        "tax_category_id": "5cbbd02c-f478-411d-a6d8-a7cbac78e15f",
        "planning_id": "cde745f0-5574-4ed9-8eb9-b140fc386153",
        "parent_line_id": null,
        "owner_id": "26b36827-d839-4e61-b6ac-1df003c4a663",
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
      "id": "095981d0-8be9-48ab-8dd1-21de1596bf92",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
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
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "4d6858c7-b60b-44e8-a4d1-a6916be6a168",
        "tax_category_id": "5cbbd02c-f478-411d-a6d8-a7cbac78e15f",
        "planning_id": "08172799-0b24-4822-b230-53b9dcc1c475",
        "parent_line_id": null,
        "owner_id": "26b36827-d839-4e61-b6ac-1df003c4a663",
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
      "id": "cde745f0-5574-4ed9-8eb9-b140fc386153",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
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
        "item_id": "a1376492-c550-4fc8-91d1-ea320c48b562",
        "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663",
        "start_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328",
        "stop_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328",
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
      "id": "08172799-0b24-4822-b230-53b9dcc1c475",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
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
        "item_id": "4d6858c7-b60b-44e8-a4d1-a6916be6a168",
        "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663",
        "start_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328",
        "stop_location_id": "5e521b2a-e8d2-416b-9ebc-8a0d0d49b328",
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
      "id": "d3adbd5b-f6a6-42de-9ab1-0a394a85d641",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e0a711d-34ac-4814-98d3-bab725d8f1df",
        "planning_id": "cde745f0-5574-4ed9-8eb9-b140fc386153",
        "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663"
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
      "id": "953d7306-a4e0-4f8e-b890-89afaef9e223",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2a341e8c-1110-4dcc-8491-48c6e475f568",
        "planning_id": "cde745f0-5574-4ed9-8eb9-b140fc386153",
        "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663"
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
      "id": "b9cfa4c2-2be3-4e48-b9a7-a84ef4c37198",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:20+00:00",
        "updated_at": "2023-02-09T09:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9b1d4fd4-b342-4f50-b776-d50c3e20d9cc",
        "planning_id": "cde745f0-5574-4ed9-8eb9-b140fc386153",
        "order_id": "26b36827-d839-4e61-b6ac-1df003c4a663"
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
          "order_id": "b0755715-d871-40dd-8a77-7be9795fcba0",
          "items": [
            {
              "type": "bundles",
              "id": "eeac377f-b861-4c75-a27b-b72418094f98",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "85595e8b-7e98-4d23-a1d1-fec8a4b7fc27",
                  "id": "ebeeb595-6fb4-4928-a168-ebfc3e301f28"
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
    "id": "981297f7-97e0-59c1-84e8-5e0a192ea382",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b0755715-d871-40dd-8a77-7be9795fcba0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b0755715-d871-40dd-8a77-7be9795fcba0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ce177b34-4cf2-4815-aadd-62ba93d95ea6"
          },
          {
            "type": "lines",
            "id": "6b90bd5d-9aec-4472-aed5-6ab98d6ed5e8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3f70eaa7-9cf8-4681-b924-0653cc1c6b82"
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
      "id": "b0755715-d871-40dd-8a77-7be9795fcba0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T09:29:23+00:00",
        "updated_at": "2023-02-09T09:29:24+00:00",
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
        "starts_at": "2023-02-07T09:15:00+00:00",
        "stops_at": "2023-02-11T09:15:00+00:00",
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
        "start_location_id": "31d392db-51d4-4f36-9edd-8c4258b1070a",
        "stop_location_id": "31d392db-51d4-4f36-9edd-8c4258b1070a"
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
      "id": "ce177b34-4cf2-4815-aadd-62ba93d95ea6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:29:24+00:00",
        "updated_at": "2023-02-09T09:29:24+00:00",
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
        "item_id": "eeac377f-b861-4c75-a27b-b72418094f98",
        "tax_category_id": null,
        "planning_id": "3f70eaa7-9cf8-4681-b924-0653cc1c6b82",
        "parent_line_id": null,
        "owner_id": "b0755715-d871-40dd-8a77-7be9795fcba0",
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
      "id": "6b90bd5d-9aec-4472-aed5-6ab98d6ed5e8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:29:24+00:00",
        "updated_at": "2023-02-09T09:29:24+00:00",
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
        "item_id": "ebeeb595-6fb4-4928-a168-ebfc3e301f28",
        "tax_category_id": null,
        "planning_id": "5fcf279d-7f26-48f7-98b3-945974b6c471",
        "parent_line_id": "ce177b34-4cf2-4815-aadd-62ba93d95ea6",
        "owner_id": "b0755715-d871-40dd-8a77-7be9795fcba0",
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
      "id": "3f70eaa7-9cf8-4681-b924-0653cc1c6b82",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:29:23+00:00",
        "updated_at": "2023-02-09T09:29:23+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T09:15:00+00:00",
        "stops_at": "2023-02-11T09:15:00+00:00",
        "reserved_from": "2023-02-07T09:15:00+00:00",
        "reserved_till": "2023-02-11T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "eeac377f-b861-4c75-a27b-b72418094f98",
        "order_id": "b0755715-d871-40dd-8a77-7be9795fcba0",
        "start_location_id": "31d392db-51d4-4f36-9edd-8c4258b1070a",
        "stop_location_id": "31d392db-51d4-4f36-9edd-8c4258b1070a",
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





