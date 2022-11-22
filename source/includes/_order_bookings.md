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
          "order_id": "7d386dbf-964b-410b-9c4d-55ee28e77200",
          "items": [
            {
              "type": "products",
              "id": "02a6b4c5-b586-47e3-bb8f-551429c30542",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b099c9ba-d7d6-47f0-bb46-c6f51c1cb270",
              "stock_item_ids": [
                "a75cbed5-74d2-4554-bc12-a139735cfaab",
                "1be1123c-ee70-4cab-9f89-7fdf86abf3c4"
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
            "item_id": "02a6b4c5-b586-47e3-bb8f-551429c30542",
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
          "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
          "items": [
            {
              "type": "products",
              "id": "18d6fdef-0aab-4911-91ec-c47f382276ea",
              "stock_item_ids": [
                "a453bcaf-f737-4b41-85f2-36472b3f0c0a",
                "84fe35e6-7f96-4f74-8e4e-98142a06cbee",
                "9a0772b4-039c-4f6a-b15a-e1657034f6da"
              ]
            },
            {
              "type": "products",
              "id": "73d03b16-3344-4382-8886-7744ffd41de4",
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
    "id": "46eb75bc-32f3-50cd-a070-a6e5b4bd2521",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d2771dc-689e-47e7-82ed-81b33794246e"
          },
          {
            "type": "lines",
            "id": "5c3953b4-f471-41d9-b409-c1db10b5dcbf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f"
          },
          {
            "type": "plannings",
            "id": "3efc2050-081f-445c-a7f4-bbc3d6fb5cd5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b64eb4b4-04ec-45bd-9956-9d03a3fe6714"
          },
          {
            "type": "stock_item_plannings",
            "id": "29241bb4-0ae0-4c50-941f-eb1ef92d9aee"
          },
          {
            "type": "stock_item_plannings",
            "id": "208c6335-e777-4fdd-b11f-a5173d48f9fe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T14:42:57+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
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
        "customer_id": "0a931f62-d3c4-459b-ad7f-6e8909d006e5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616",
        "stop_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616"
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
      "id": "7d2771dc-689e-47e7-82ed-81b33794246e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
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
        "item_id": "18d6fdef-0aab-4911-91ec-c47f382276ea",
        "tax_category_id": "2586d999-b12b-4379-b738-41047a47f59d",
        "planning_id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f",
        "parent_line_id": null,
        "owner_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
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
      "id": "5c3953b4-f471-41d9-b409-c1db10b5dcbf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
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
        "item_id": "73d03b16-3344-4382-8886-7744ffd41de4",
        "tax_category_id": "2586d999-b12b-4379-b738-41047a47f59d",
        "planning_id": "3efc2050-081f-445c-a7f4-bbc3d6fb5cd5",
        "parent_line_id": null,
        "owner_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
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
      "id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
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
        "item_id": "18d6fdef-0aab-4911-91ec-c47f382276ea",
        "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
        "start_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616",
        "stop_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616",
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
      "id": "3efc2050-081f-445c-a7f4-bbc3d6fb5cd5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
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
        "item_id": "73d03b16-3344-4382-8886-7744ffd41de4",
        "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee",
        "start_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616",
        "stop_location_id": "9b0d3221-bdcc-4955-82c2-fdea39364616",
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
      "id": "b64eb4b4-04ec-45bd-9956-9d03a3fe6714",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a453bcaf-f737-4b41-85f2-36472b3f0c0a",
        "planning_id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f",
        "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee"
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
      "id": "29241bb4-0ae0-4c50-941f-eb1ef92d9aee",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "84fe35e6-7f96-4f74-8e4e-98142a06cbee",
        "planning_id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f",
        "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee"
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
      "id": "208c6335-e777-4fdd-b11f-a5173d48f9fe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:42:59+00:00",
        "updated_at": "2022-11-22T14:42:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9a0772b4-039c-4f6a-b15a-e1657034f6da",
        "planning_id": "d4bd9eab-2f4d-444b-9967-58bdc8126f8f",
        "order_id": "f170de44-9e4a-4dbc-80a7-69981ae6c1ee"
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
          "order_id": "c58ebc88-7844-4093-8f18-5e79e43d95a3",
          "items": [
            {
              "type": "bundles",
              "id": "f378e04d-cd6c-485f-be94-3748ef608a3a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f0b35e83-a1cc-4af4-aa1c-e7e703a029cf",
                  "id": "42c4d475-df12-4451-8545-4ad6683d03b2"
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
    "id": "fce09af8-2d4a-5b9b-80f6-ee476ffdb824",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c58ebc88-7844-4093-8f18-5e79e43d95a3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c58ebc88-7844-4093-8f18-5e79e43d95a3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "80d7ea2b-6d28-4cde-a24b-f9c212dbccab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5df19473-7e55-403d-87af-06804e37032c"
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
      "id": "c58ebc88-7844-4093-8f18-5e79e43d95a3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T14:43:02+00:00",
        "updated_at": "2022-11-22T14:43:02+00:00",
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
        "starts_at": "2022-11-20T14:30:00+00:00",
        "stops_at": "2022-11-24T14:30:00+00:00",
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
        "start_location_id": "a74faca1-ede8-41cd-8126-a217a516aab2",
        "stop_location_id": "a74faca1-ede8-41cd-8126-a217a516aab2"
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
      "id": "80d7ea2b-6d28-4cde-a24b-f9c212dbccab",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:43:02+00:00",
        "updated_at": "2022-11-22T14:43:02+00:00",
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
        "item_id": "f378e04d-cd6c-485f-be94-3748ef608a3a",
        "tax_category_id": null,
        "planning_id": "5df19473-7e55-403d-87af-06804e37032c",
        "parent_line_id": null,
        "owner_id": "c58ebc88-7844-4093-8f18-5e79e43d95a3",
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
      "id": "5df19473-7e55-403d-87af-06804e37032c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:43:02+00:00",
        "updated_at": "2022-11-22T14:43:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T14:30:00+00:00",
        "stops_at": "2022-11-24T14:30:00+00:00",
        "reserved_from": "2022-11-20T14:30:00+00:00",
        "reserved_till": "2022-11-24T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f378e04d-cd6c-485f-be94-3748ef608a3a",
        "order_id": "c58ebc88-7844-4093-8f18-5e79e43d95a3",
        "start_location_id": "a74faca1-ede8-41cd-8126-a217a516aab2",
        "stop_location_id": "a74faca1-ede8-41cd-8126-a217a516aab2",
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





