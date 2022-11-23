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
          "order_id": "5c952694-0cde-490b-ba25-cda7fc18b52c",
          "items": [
            {
              "type": "products",
              "id": "bb1574ff-0fb1-4fa1-a475-0c6f3cc6388e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a1effa83-afe3-43ab-9b65-b43656403c04",
              "stock_item_ids": [
                "5bf5fca8-e906-4e76-a067-40aa764b2062",
                "cde26fda-dda8-4a34-8dba-2c9d8697b5ec"
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
            "item_id": "bb1574ff-0fb1-4fa1-a475-0c6f3cc6388e",
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
          "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
          "items": [
            {
              "type": "products",
              "id": "48ab3300-31c5-42b4-868a-438fca878734",
              "stock_item_ids": [
                "ca03b681-4874-443e-9879-65b0ccc39c82",
                "e5d6ef78-b6ee-48e8-bab0-7087e4af14e1",
                "55f08cf4-c364-4470-8d82-5a73a1f2aaf6"
              ]
            },
            {
              "type": "products",
              "id": "477089b9-8a7d-4f32-b221-4ebf416afc99",
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
    "id": "2416654d-2323-5bbc-b51c-e0764e8e0c5b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3fe36c55-534d-46b0-ac9a-741a074846f5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f66bd8bf-e9c8-40d6-8b22-f9f45d5bd13a"
          },
          {
            "type": "lines",
            "id": "88ba6621-83f1-4684-8ee2-dd42a698426d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "75bab0ea-a45d-4e53-a248-97d79e7c0517"
          },
          {
            "type": "plannings",
            "id": "c265211d-23f2-4d4c-bf0b-5cd14a95f8ef"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6b22b555-feeb-41ea-9dfe-3fe06ed30541"
          },
          {
            "type": "stock_item_plannings",
            "id": "4f200b90-66ee-4707-b873-d01c2aea7ed0"
          },
          {
            "type": "stock_item_plannings",
            "id": "dbc85930-0f2f-4554-b247-d1f14d922d29"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-23T11:35:29+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
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
        "customer_id": "cfe25a60-b4ec-4840-ba32-34a0cc043713",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70",
        "stop_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70"
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
      "id": "f66bd8bf-e9c8-40d6-8b22-f9f45d5bd13a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
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
        "item_id": "48ab3300-31c5-42b4-868a-438fca878734",
        "tax_category_id": "f804af9c-5354-49bc-96e3-85c0ce98742f",
        "planning_id": "75bab0ea-a45d-4e53-a248-97d79e7c0517",
        "parent_line_id": null,
        "owner_id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
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
      "id": "88ba6621-83f1-4684-8ee2-dd42a698426d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
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
        "item_id": "477089b9-8a7d-4f32-b221-4ebf416afc99",
        "tax_category_id": "f804af9c-5354-49bc-96e3-85c0ce98742f",
        "planning_id": "c265211d-23f2-4d4c-bf0b-5cd14a95f8ef",
        "parent_line_id": null,
        "owner_id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
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
      "id": "75bab0ea-a45d-4e53-a248-97d79e7c0517",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
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
        "item_id": "48ab3300-31c5-42b4-868a-438fca878734",
        "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
        "start_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70",
        "stop_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70",
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
      "id": "c265211d-23f2-4d4c-bf0b-5cd14a95f8ef",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
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
        "item_id": "477089b9-8a7d-4f32-b221-4ebf416afc99",
        "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5",
        "start_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70",
        "stop_location_id": "2b6505d3-0b11-4d0f-b5ab-79ff62da8f70",
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
      "id": "6b22b555-feeb-41ea-9dfe-3fe06ed30541",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ca03b681-4874-443e-9879-65b0ccc39c82",
        "planning_id": "75bab0ea-a45d-4e53-a248-97d79e7c0517",
        "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5"
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
      "id": "4f200b90-66ee-4707-b873-d01c2aea7ed0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e5d6ef78-b6ee-48e8-bab0-7087e4af14e1",
        "planning_id": "75bab0ea-a45d-4e53-a248-97d79e7c0517",
        "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5"
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
      "id": "dbc85930-0f2f-4554-b247-d1f14d922d29",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:31+00:00",
        "updated_at": "2022-11-23T11:35:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "55f08cf4-c364-4470-8d82-5a73a1f2aaf6",
        "planning_id": "75bab0ea-a45d-4e53-a248-97d79e7c0517",
        "order_id": "3fe36c55-534d-46b0-ac9a-741a074846f5"
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
          "order_id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a",
          "items": [
            {
              "type": "bundles",
              "id": "3021cb60-1d98-4abe-92b0-6dc26f07f6f6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "88f94708-a14f-4c7a-8d81-63c4623465ee",
                  "id": "fa9f7203-128e-4519-8750-6dfdf68953fa"
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
    "id": "c57edcdb-f46d-596c-aa7f-4a9dda4d54a5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fa4eb026-a5cb-4488-8038-52dbefcd42c7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d4d7a179-3f10-457e-bebc-f094fde86a96"
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
      "id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-23T11:35:34+00:00",
        "updated_at": "2022-11-23T11:35:34+00:00",
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
        "starts_at": "2022-11-21T11:30:00+00:00",
        "stops_at": "2022-11-25T11:30:00+00:00",
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
        "start_location_id": "e1235754-dd2e-4c8b-b1fc-beb8206c695f",
        "stop_location_id": "e1235754-dd2e-4c8b-b1fc-beb8206c695f"
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
      "id": "fa4eb026-a5cb-4488-8038-52dbefcd42c7",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-23T11:35:34+00:00",
        "updated_at": "2022-11-23T11:35:34+00:00",
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
        "item_id": "3021cb60-1d98-4abe-92b0-6dc26f07f6f6",
        "tax_category_id": null,
        "planning_id": "d4d7a179-3f10-457e-bebc-f094fde86a96",
        "parent_line_id": null,
        "owner_id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a",
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
      "id": "d4d7a179-3f10-457e-bebc-f094fde86a96",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-23T11:35:34+00:00",
        "updated_at": "2022-11-23T11:35:34+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-21T11:30:00+00:00",
        "stops_at": "2022-11-25T11:30:00+00:00",
        "reserved_from": "2022-11-21T11:30:00+00:00",
        "reserved_till": "2022-11-25T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3021cb60-1d98-4abe-92b0-6dc26f07f6f6",
        "order_id": "d25ebaec-4e08-4898-8e5c-ac429605ec5a",
        "start_location_id": "e1235754-dd2e-4c8b-b1fc-beb8206c695f",
        "stop_location_id": "e1235754-dd2e-4c8b-b1fc-beb8206c695f",
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





