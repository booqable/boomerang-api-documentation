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
          "order_id": "61e4c5cb-4de2-4765-8f3e-7ba2f5c627a5",
          "items": [
            {
              "type": "products",
              "id": "3aef6c45-66d3-418c-8d7a-ab8462ce2825",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5bdb743d-ea4d-40bd-9609-896d2ec80744",
              "stock_item_ids": [
                "3014a795-b56c-415d-8bbb-626e5d10fe1c",
                "ce6e7ea5-df81-4da9-83ad-0730b3a0af7e"
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
            "item_id": "3aef6c45-66d3-418c-8d7a-ab8462ce2825",
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
          "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
          "items": [
            {
              "type": "products",
              "id": "cce2cd77-a62d-46e8-9636-61a636cf41c0",
              "stock_item_ids": [
                "f0602436-ede5-4ebd-8ac2-d08203af2f56",
                "2e95281d-6ed8-412d-8532-81b3abdc9814",
                "ebe18ce1-e630-4c06-a9a6-dee54e401757"
              ]
            },
            {
              "type": "products",
              "id": "985cd00b-75f9-42f5-98e3-3719587636c5",
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
    "id": "f5e320ba-cc0d-59dd-ab49-495e31b45506",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8e8190e9-e166-44dc-98a5-ab0d67d03bee"
          },
          {
            "type": "lines",
            "id": "c0283ca2-3753-43dc-b649-82ac955cd92f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0"
          },
          {
            "type": "plannings",
            "id": "a9f93f42-54a7-488a-a542-923c160a3f35"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5e56b1cf-828b-4a3f-8383-686d881f4b37"
          },
          {
            "type": "stock_item_plannings",
            "id": "cbd88ede-2a60-4b50-885a-3ffe054060d7"
          },
          {
            "type": "stock_item_plannings",
            "id": "0594fe2e-8b49-4bbb-b8d2-1c5ade58d232"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T17:43:14+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
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
        "customer_id": "536f2e15-4e36-4bfe-946b-17458ad05fa9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1",
        "stop_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1"
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
      "id": "8e8190e9-e166-44dc-98a5-ab0d67d03bee",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
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
        "item_id": "cce2cd77-a62d-46e8-9636-61a636cf41c0",
        "tax_category_id": "cd657f8d-c65f-4c93-a18a-fe442f0cfc9b",
        "planning_id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0",
        "parent_line_id": null,
        "owner_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
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
      "id": "c0283ca2-3753-43dc-b649-82ac955cd92f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
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
        "item_id": "985cd00b-75f9-42f5-98e3-3719587636c5",
        "tax_category_id": "cd657f8d-c65f-4c93-a18a-fe442f0cfc9b",
        "planning_id": "a9f93f42-54a7-488a-a542-923c160a3f35",
        "parent_line_id": null,
        "owner_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
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
      "id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
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
        "item_id": "cce2cd77-a62d-46e8-9636-61a636cf41c0",
        "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
        "start_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1",
        "stop_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1",
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
      "id": "a9f93f42-54a7-488a-a542-923c160a3f35",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
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
        "item_id": "985cd00b-75f9-42f5-98e3-3719587636c5",
        "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f",
        "start_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1",
        "stop_location_id": "51118189-cf5d-4502-9f4d-c1923b23b0f1",
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
      "id": "5e56b1cf-828b-4a3f-8383-686d881f4b37",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f0602436-ede5-4ebd-8ac2-d08203af2f56",
        "planning_id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0",
        "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f"
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
      "id": "cbd88ede-2a60-4b50-885a-3ffe054060d7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e95281d-6ed8-412d-8532-81b3abdc9814",
        "planning_id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0",
        "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f"
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
      "id": "0594fe2e-8b49-4bbb-b8d2-1c5ade58d232",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:16+00:00",
        "updated_at": "2022-11-22T17:43:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ebe18ce1-e630-4c06-a9a6-dee54e401757",
        "planning_id": "7026cf51-2dbe-4cd6-a66d-84d45cc426f0",
        "order_id": "ab6bce34-ad4d-4720-b8c8-a52c30013a3f"
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
          "order_id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9",
          "items": [
            {
              "type": "bundles",
              "id": "1e08a106-126d-4d08-867b-1d5f467bf1bc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f8331fc0-4739-4b62-b734-12bbfb8a5d5c",
                  "id": "351e479c-8d4b-47b8-a661-87fb883b6a85"
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
    "id": "296ca2ca-8205-58d2-bc23-af6b9fcfcdfd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d88bae3-eabb-492d-9534-826af08d5dc2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3af0d8f5-6d54-4d40-9553-7ac63ca6636a"
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
      "id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T17:43:18+00:00",
        "updated_at": "2022-11-22T17:43:19+00:00",
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
        "starts_at": "2022-11-20T17:30:00+00:00",
        "stops_at": "2022-11-24T17:30:00+00:00",
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
        "start_location_id": "4bd6d6c3-6ea4-40dc-9904-0097e6b0125a",
        "stop_location_id": "4bd6d6c3-6ea4-40dc-9904-0097e6b0125a"
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
      "id": "7d88bae3-eabb-492d-9534-826af08d5dc2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:43:18+00:00",
        "updated_at": "2022-11-22T17:43:18+00:00",
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
        "item_id": "1e08a106-126d-4d08-867b-1d5f467bf1bc",
        "tax_category_id": null,
        "planning_id": "3af0d8f5-6d54-4d40-9553-7ac63ca6636a",
        "parent_line_id": null,
        "owner_id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9",
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
      "id": "3af0d8f5-6d54-4d40-9553-7ac63ca6636a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:43:18+00:00",
        "updated_at": "2022-11-22T17:43:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T17:30:00+00:00",
        "stops_at": "2022-11-24T17:30:00+00:00",
        "reserved_from": "2022-11-20T17:30:00+00:00",
        "reserved_till": "2022-11-24T17:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1e08a106-126d-4d08-867b-1d5f467bf1bc",
        "order_id": "47a7feed-5a1d-4c63-ba94-0dd5fed04bc9",
        "start_location_id": "4bd6d6c3-6ea4-40dc-9904-0097e6b0125a",
        "stop_location_id": "4bd6d6c3-6ea4-40dc-9904-0097e6b0125a",
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





