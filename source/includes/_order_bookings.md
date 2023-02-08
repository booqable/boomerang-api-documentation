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
          "order_id": "bcf08946-5bb6-473c-b6e8-87a47fd225cd",
          "items": [
            {
              "type": "products",
              "id": "bd6a1ea9-c95a-4b2d-9a33-844ac0b4cde2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d49b4dc5-7f82-4d77-b918-f8a6d7de8359",
              "stock_item_ids": [
                "753f3cb0-0565-421d-96af-1c668eadf071",
                "ce115213-2fbf-4c24-b443-c367571556a4"
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
            "item_id": "bd6a1ea9-c95a-4b2d-9a33-844ac0b4cde2",
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
          "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
          "items": [
            {
              "type": "products",
              "id": "1a3e8df9-6f20-4228-a750-a1df447364d8",
              "stock_item_ids": [
                "be8c0bca-eed0-4c59-94a3-2405b1bfdfc0",
                "f0e1fd93-b0c8-4965-b015-476a3f5a66f1",
                "7ad43f6c-722b-4238-9556-bc886250ace0"
              ]
            },
            {
              "type": "products",
              "id": "afaf24c9-638d-4ba2-8bfb-bf511379f7b2",
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
    "id": "d90cbfd2-5c94-5c6c-938b-4e610de0e708",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "469e7ff5-02d8-408d-9d33-6e3e8aa9bff7"
          },
          {
            "type": "lines",
            "id": "c3d0b0e9-d669-468f-8ca4-d016dc56e41d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "362a3646-c5dd-4075-b0a6-229466649db5"
          },
          {
            "type": "plannings",
            "id": "74555942-b04a-47b5-93f2-2f4ba91e8e0c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "12cf0911-6632-4133-8777-3b70c04f4778"
          },
          {
            "type": "stock_item_plannings",
            "id": "3cda04ce-394e-4f98-8af0-ea83c1859f37"
          },
          {
            "type": "stock_item_plannings",
            "id": "bbb2b205-76e9-4674-b8b6-9d472247507d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:20:02+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
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
        "customer_id": "67d69ce0-8f63-42bd-b02e-eb9f987f6135",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc",
        "stop_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc"
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
      "id": "469e7ff5-02d8-408d-9d33-6e3e8aa9bff7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
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
        "item_id": "1a3e8df9-6f20-4228-a750-a1df447364d8",
        "tax_category_id": "5569282e-8e25-4304-8563-6f419cf626a4",
        "planning_id": "362a3646-c5dd-4075-b0a6-229466649db5",
        "parent_line_id": null,
        "owner_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
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
      "id": "c3d0b0e9-d669-468f-8ca4-d016dc56e41d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
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
        "item_id": "afaf24c9-638d-4ba2-8bfb-bf511379f7b2",
        "tax_category_id": "5569282e-8e25-4304-8563-6f419cf626a4",
        "planning_id": "74555942-b04a-47b5-93f2-2f4ba91e8e0c",
        "parent_line_id": null,
        "owner_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
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
      "id": "362a3646-c5dd-4075-b0a6-229466649db5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
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
        "item_id": "1a3e8df9-6f20-4228-a750-a1df447364d8",
        "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
        "start_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc",
        "stop_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc",
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
      "id": "74555942-b04a-47b5-93f2-2f4ba91e8e0c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
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
        "item_id": "afaf24c9-638d-4ba2-8bfb-bf511379f7b2",
        "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a",
        "start_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc",
        "stop_location_id": "0dcc863e-c786-4fe6-a4c2-8221faca07cc",
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
      "id": "12cf0911-6632-4133-8777-3b70c04f4778",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "be8c0bca-eed0-4c59-94a3-2405b1bfdfc0",
        "planning_id": "362a3646-c5dd-4075-b0a6-229466649db5",
        "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a"
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
      "id": "3cda04ce-394e-4f98-8af0-ea83c1859f37",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f0e1fd93-b0c8-4965-b015-476a3f5a66f1",
        "planning_id": "362a3646-c5dd-4075-b0a6-229466649db5",
        "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a"
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
      "id": "bbb2b205-76e9-4674-b8b6-9d472247507d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:03+00:00",
        "updated_at": "2023-02-08T15:20:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7ad43f6c-722b-4238-9556-bc886250ace0",
        "planning_id": "362a3646-c5dd-4075-b0a6-229466649db5",
        "order_id": "cfdaf269-bc06-4850-ad3e-5caf0af52e5a"
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
          "order_id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19",
          "items": [
            {
              "type": "bundles",
              "id": "b7f79d89-20b2-4bff-8dfb-5fa150ff2197",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0a8c1b73-bedc-43e5-85d5-bb0d99645a3e",
                  "id": "6e1b958c-ee93-4c72-8842-1b614f354dd5"
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
    "id": "83e2aa56-8314-57a8-bf5b-1fb953de2a9c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "da4e8843-ac0c-46bc-9818-33de65794fe9"
          },
          {
            "type": "lines",
            "id": "eaf7e330-bcdd-4073-a569-6e7af075198a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "aea2ccaf-f822-4d96-9264-82172e230929"
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
      "id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:20:06+00:00",
        "updated_at": "2023-02-08T15:20:07+00:00",
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
        "starts_at": "2023-02-06T15:15:00+00:00",
        "stops_at": "2023-02-10T15:15:00+00:00",
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
        "start_location_id": "256092aa-f190-43a8-9ae3-92e5e69c9c71",
        "stop_location_id": "256092aa-f190-43a8-9ae3-92e5e69c9c71"
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
      "id": "da4e8843-ac0c-46bc-9818-33de65794fe9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:20:06+00:00",
        "updated_at": "2023-02-08T15:20:06+00:00",
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
        "item_id": "b7f79d89-20b2-4bff-8dfb-5fa150ff2197",
        "tax_category_id": null,
        "planning_id": "aea2ccaf-f822-4d96-9264-82172e230929",
        "parent_line_id": null,
        "owner_id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19",
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
      "id": "eaf7e330-bcdd-4073-a569-6e7af075198a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:20:06+00:00",
        "updated_at": "2023-02-08T15:20:06+00:00",
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
        "item_id": "6e1b958c-ee93-4c72-8842-1b614f354dd5",
        "tax_category_id": null,
        "planning_id": "ba32b125-fd1b-46ba-8d6d-d76a02fa070e",
        "parent_line_id": "da4e8843-ac0c-46bc-9818-33de65794fe9",
        "owner_id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19",
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
      "id": "aea2ccaf-f822-4d96-9264-82172e230929",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:20:06+00:00",
        "updated_at": "2023-02-08T15:20:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T15:15:00+00:00",
        "stops_at": "2023-02-10T15:15:00+00:00",
        "reserved_from": "2023-02-06T15:15:00+00:00",
        "reserved_till": "2023-02-10T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b7f79d89-20b2-4bff-8dfb-5fa150ff2197",
        "order_id": "7c8b1a45-3e75-4dc7-9138-f45a45353d19",
        "start_location_id": "256092aa-f190-43a8-9ae3-92e5e69c9c71",
        "stop_location_id": "256092aa-f190-43a8-9ae3-92e5e69c9c71",
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





