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
          "order_id": "470e4550-a11c-45b7-a91c-db8a912ebe34",
          "items": [
            {
              "type": "products",
              "id": "891298d4-d004-40b7-b0dd-72c689408801",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2b8e2f8b-9f2b-4ac6-a24f-1f3008db2266",
              "stock_item_ids": [
                "ee3e6622-1d54-4870-a3a6-59463f84fd41",
                "5fa03efa-4012-4563-a27b-e72b761c7476"
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
            "item_id": "891298d4-d004-40b7-b0dd-72c689408801",
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
          "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47",
          "items": [
            {
              "type": "products",
              "id": "c4eef803-21af-4b1f-8bb0-0f498d168a78",
              "stock_item_ids": [
                "e79c0d67-7178-47f7-bb2d-b409084cce34",
                "c530dade-2ac0-482d-a396-2a32ac450698",
                "504be983-234f-4078-b58c-26b7433cd319"
              ]
            },
            {
              "type": "products",
              "id": "d730762c-c378-4bfb-853d-7259150514f3",
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
    "id": "a60f6009-274c-533c-a135-b4b0e04d1704",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d9d97949-6a75-47a6-9bc5-396756506f47"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ea389ab2-ca51-4a7f-b230-3ee6820cc967"
          },
          {
            "type": "lines",
            "id": "a8a0a19e-9eb1-4bfb-8687-e45132ac711c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b12490cb-ebad-4d43-8fb5-b0946fb935de"
          },
          {
            "type": "plannings",
            "id": "94f3ea5b-6909-4811-921b-fdd130040afd"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c988cfbb-f32d-43e4-8dd2-c1c7b506c64d"
          },
          {
            "type": "stock_item_plannings",
            "id": "2e3d1f27-09af-4e01-bd88-5eb5d377941a"
          },
          {
            "type": "stock_item_plannings",
            "id": "e6a111ce-86c1-494e-a599-7d8353a2171b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9d97949-6a75-47a6-9bc5-396756506f47",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-06T15:14:36+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
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
        "customer_id": "43a07978-840a-4b9a-992e-5bf99e1b8fdf",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b",
        "stop_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b"
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
      "id": "ea389ab2-ca51-4a7f-b230-3ee6820cc967",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
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
        "item_id": "c4eef803-21af-4b1f-8bb0-0f498d168a78",
        "tax_category_id": "c0a3c331-faa6-4280-b649-1c1b81a42eb8",
        "planning_id": "b12490cb-ebad-4d43-8fb5-b0946fb935de",
        "parent_line_id": null,
        "owner_id": "d9d97949-6a75-47a6-9bc5-396756506f47",
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
      "id": "a8a0a19e-9eb1-4bfb-8687-e45132ac711c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
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
        "item_id": "d730762c-c378-4bfb-853d-7259150514f3",
        "tax_category_id": "c0a3c331-faa6-4280-b649-1c1b81a42eb8",
        "planning_id": "94f3ea5b-6909-4811-921b-fdd130040afd",
        "parent_line_id": null,
        "owner_id": "d9d97949-6a75-47a6-9bc5-396756506f47",
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
      "id": "b12490cb-ebad-4d43-8fb5-b0946fb935de",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
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
        "item_id": "c4eef803-21af-4b1f-8bb0-0f498d168a78",
        "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47",
        "start_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b",
        "stop_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b",
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
      "id": "94f3ea5b-6909-4811-921b-fdd130040afd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
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
        "item_id": "d730762c-c378-4bfb-853d-7259150514f3",
        "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47",
        "start_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b",
        "stop_location_id": "0f42536a-1e99-4eb5-9956-6c725c77b98b",
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
      "id": "c988cfbb-f32d-43e4-8dd2-c1c7b506c64d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e79c0d67-7178-47f7-bb2d-b409084cce34",
        "planning_id": "b12490cb-ebad-4d43-8fb5-b0946fb935de",
        "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47"
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
      "id": "2e3d1f27-09af-4e01-bd88-5eb5d377941a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c530dade-2ac0-482d-a396-2a32ac450698",
        "planning_id": "b12490cb-ebad-4d43-8fb5-b0946fb935de",
        "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47"
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
      "id": "e6a111ce-86c1-494e-a599-7d8353a2171b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:38+00:00",
        "updated_at": "2023-01-06T15:14:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "504be983-234f-4078-b58c-26b7433cd319",
        "planning_id": "b12490cb-ebad-4d43-8fb5-b0946fb935de",
        "order_id": "d9d97949-6a75-47a6-9bc5-396756506f47"
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
          "order_id": "9eddd905-02b5-46d3-ad28-86445668ba66",
          "items": [
            {
              "type": "bundles",
              "id": "df3e625a-384f-4251-a7cf-49da3d8250dc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ab8dfd62-0acf-4c3c-a28e-fd48f6c59842",
                  "id": "b2503f53-c370-4cde-a37c-72c16128181e"
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
    "id": "6de2d280-df8d-5021-80a2-35bb481bc7e3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9eddd905-02b5-46d3-ad28-86445668ba66"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9eddd905-02b5-46d3-ad28-86445668ba66"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fca5cee5-abc5-4cda-a5b2-11f720576260"
          },
          {
            "type": "lines",
            "id": "22eac5a9-aa6f-40d9-b9d8-b1d81f703202"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bb8dee4b-d801-4378-943b-bb2ded0ddcf9"
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
      "id": "9eddd905-02b5-46d3-ad28-86445668ba66",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-06T15:14:40+00:00",
        "updated_at": "2023-01-06T15:14:41+00:00",
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
        "starts_at": "2023-01-04T15:00:00+00:00",
        "stops_at": "2023-01-08T15:00:00+00:00",
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
        "start_location_id": "65c445d2-e3c5-4b4e-b71b-7ab91e8d2209",
        "stop_location_id": "65c445d2-e3c5-4b4e-b71b-7ab91e8d2209"
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
      "id": "fca5cee5-abc5-4cda-a5b2-11f720576260",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-06T15:14:41+00:00",
        "updated_at": "2023-01-06T15:14:41+00:00",
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
        "item_id": "b2503f53-c370-4cde-a37c-72c16128181e",
        "tax_category_id": null,
        "planning_id": "5b92bfde-8af5-4d98-8e89-5220b5a70edb",
        "parent_line_id": "22eac5a9-aa6f-40d9-b9d8-b1d81f703202",
        "owner_id": "9eddd905-02b5-46d3-ad28-86445668ba66",
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
      "id": "22eac5a9-aa6f-40d9-b9d8-b1d81f703202",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-06T15:14:41+00:00",
        "updated_at": "2023-01-06T15:14:41+00:00",
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
        "item_id": "df3e625a-384f-4251-a7cf-49da3d8250dc",
        "tax_category_id": null,
        "planning_id": "bb8dee4b-d801-4378-943b-bb2ded0ddcf9",
        "parent_line_id": null,
        "owner_id": "9eddd905-02b5-46d3-ad28-86445668ba66",
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
      "id": "bb8dee4b-d801-4378-943b-bb2ded0ddcf9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-06T15:14:41+00:00",
        "updated_at": "2023-01-06T15:14:41+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-04T15:00:00+00:00",
        "stops_at": "2023-01-08T15:00:00+00:00",
        "reserved_from": "2023-01-04T15:00:00+00:00",
        "reserved_till": "2023-01-08T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "df3e625a-384f-4251-a7cf-49da3d8250dc",
        "order_id": "9eddd905-02b5-46d3-ad28-86445668ba66",
        "start_location_id": "65c445d2-e3c5-4b4e-b71b-7ab91e8d2209",
        "stop_location_id": "65c445d2-e3c5-4b4e-b71b-7ab91e8d2209",
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





