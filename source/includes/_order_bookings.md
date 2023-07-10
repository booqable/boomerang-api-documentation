# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
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
          "order_id": "a51c9f43-57d4-42ec-a5dc-1f18a863e77b",
          "items": [
            {
              "type": "products",
              "id": "8d13a483-f3f1-4a3c-8e5c-10d6775be734",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1fe551d8-3fd4-45b0-87fc-7422422c369e",
              "stock_item_ids": [
                "0fea1776-9157-4acb-8739-cd1d2a76e6bc",
                "5998e45b-250f-45c7-8aeb-1f2949947f7e"
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
          "stock_item_id 0fea1776-9157-4acb-8739-cd1d2a76e6bc has already been booked on this order"
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
          "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
          "items": [
            {
              "type": "products",
              "id": "fe2a108b-1832-43e0-a814-859c7f00634d",
              "stock_item_ids": [
                "957f8136-dc7a-43bc-ac44-028190e29f3a",
                "2e801b4c-e10e-48be-9c75-0f8e806f7018",
                "b1456c82-5d53-4439-9aba-41043f485ac0"
              ]
            },
            {
              "type": "products",
              "id": "65309df2-02b3-424d-a934-8f0461e79ea6",
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
    "id": "6bc818a9-c996-55b7-87c8-7e364503855d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a3ec0d4b-4187-49a8-99af-bf53a140e8e4"
          },
          {
            "type": "lines",
            "id": "69cae75e-cee1-4cbf-ba62-642717f3e8bd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "44dbe363-40d9-4da1-b5cb-8b18821061ea"
          },
          {
            "type": "plannings",
            "id": "ce9b291f-a8ec-411f-919c-c4e321701cb3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9b19b787-c05d-4c7d-8a3e-4ef2e7c2af46"
          },
          {
            "type": "stock_item_plannings",
            "id": "c2e20e50-6241-48fa-b0df-809a39655905"
          },
          {
            "type": "stock_item_plannings",
            "id": "5279cf15-cd53-4bfd-94f9-e702e1717705"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-07-10T09:17:56+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
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
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "e6ce8807-709b-473d-8b6b-aa066657e87c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a",
        "stop_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a"
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
      "id": "a3ec0d4b-4187-49a8-99af-bf53a140e8e4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
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
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "item_id": "fe2a108b-1832-43e0-a814-859c7f00634d",
        "tax_category_id": "405c0ade-f2ae-4a96-b5bd-9af07d740d3b",
        "planning_id": "44dbe363-40d9-4da1-b5cb-8b18821061ea",
        "parent_line_id": null,
        "owner_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "69cae75e-cee1-4cbf-ba62-642717f3e8bd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
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
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "item_id": "65309df2-02b3-424d-a934-8f0461e79ea6",
        "tax_category_id": "405c0ade-f2ae-4a96-b5bd-9af07d740d3b",
        "planning_id": "ce9b291f-a8ec-411f-919c-c4e321701cb3",
        "parent_line_id": null,
        "owner_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "44dbe363-40d9-4da1-b5cb-8b18821061ea",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
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
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "item_id": "fe2a108b-1832-43e0-a814-859c7f00634d",
        "start_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a",
        "stop_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "ce9b291f-a8ec-411f-919c-c4e321701cb3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
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
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e",
        "item_id": "65309df2-02b3-424d-a934-8f0461e79ea6",
        "start_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a",
        "stop_location_id": "30dd9c6a-9777-42ea-834b-28272bfc908a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "9b19b787-c05d-4c7d-8a3e-4ef2e7c2af46",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "957f8136-dc7a-43bc-ac44-028190e29f3a",
        "planning_id": "44dbe363-40d9-4da1-b5cb-8b18821061ea",
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e"
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
      "id": "c2e20e50-6241-48fa-b0df-809a39655905",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e801b4c-e10e-48be-9c75-0f8e806f7018",
        "planning_id": "44dbe363-40d9-4da1-b5cb-8b18821061ea",
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e"
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
      "id": "5279cf15-cd53-4bfd-94f9-e702e1717705",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-07-10T09:17:58+00:00",
        "updated_at": "2023-07-10T09:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b1456c82-5d53-4439-9aba-41043f485ac0",
        "planning_id": "44dbe363-40d9-4da1-b5cb-8b18821061ea",
        "order_id": "414aaafa-f737-4b6f-9dce-2a2c2e39806e"
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
          "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
          "items": [
            {
              "type": "bundles",
              "id": "dc49df1e-75e7-4b64-b872-8e49680bede8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "43a79b60-2cbd-4b70-9439-573e1e2fdcfa",
                  "id": "3a7c8b2d-dcf9-4601-9331-0a013c9ddc18"
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
    "id": "2f8ae360-82ae-5be9-b05e-d5b5d81ed375",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "97642532-42db-4afc-b2df-c25013be1442"
          },
          {
            "type": "lines",
            "id": "8208bdd1-b9d0-4e63-a7d7-27af254d3d54"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8fd41ef5-4bb2-4e9e-a71b-910bd7f750e9"
          },
          {
            "type": "plannings",
            "id": "9b575021-8445-45c7-9d68-c9c001dd1864"
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
      "id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-07-10T09:18:01+00:00",
        "updated_at": "2023-07-10T09:18:01+00:00",
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
        "starts_at": "2023-07-08T09:15:00+00:00",
        "stops_at": "2023-07-12T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3",
        "stop_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3"
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
      "id": "97642532-42db-4afc-b2df-c25013be1442",
      "type": "lines",
      "attributes": {
        "created_at": "2023-07-10T09:18:01+00:00",
        "updated_at": "2023-07-10T09:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
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
        "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "item_id": "dc49df1e-75e7-4b64-b872-8e49680bede8",
        "tax_category_id": null,
        "planning_id": "8fd41ef5-4bb2-4e9e-a71b-910bd7f750e9",
        "parent_line_id": null,
        "owner_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "8208bdd1-b9d0-4e63-a7d7-27af254d3d54",
      "type": "lines",
      "attributes": {
        "created_at": "2023-07-10T09:18:01+00:00",
        "updated_at": "2023-07-10T09:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000012 - red",
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
        "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "item_id": "3a7c8b2d-dcf9-4601-9331-0a013c9ddc18",
        "tax_category_id": null,
        "planning_id": "9b575021-8445-45c7-9d68-c9c001dd1864",
        "parent_line_id": "97642532-42db-4afc-b2df-c25013be1442",
        "owner_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "8fd41ef5-4bb2-4e9e-a71b-910bd7f750e9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-07-10T09:18:01+00:00",
        "updated_at": "2023-07-10T09:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-07-08T09:15:00+00:00",
        "stops_at": "2023-07-12T09:15:00+00:00",
        "reserved_from": "2023-07-08T09:15:00+00:00",
        "reserved_till": "2023-07-12T09:15:00+00:00",
        "reserved": false,
        "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "item_id": "dc49df1e-75e7-4b64-b872-8e49680bede8",
        "start_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3",
        "stop_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "9b575021-8445-45c7-9d68-c9c001dd1864",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-07-10T09:18:01+00:00",
        "updated_at": "2023-07-10T09:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-07-08T09:15:00+00:00",
        "stops_at": "2023-07-12T09:15:00+00:00",
        "reserved_from": "2023-07-08T09:15:00+00:00",
        "reserved_till": "2023-07-12T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "e371ac9a-6f8d-40ea-9db9-71ff9074f48c",
        "item_id": "3a7c8b2d-dcf9-4601-9331-0a013c9ddc18",
        "start_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3",
        "stop_location_id": "12cb478a-3292-43fc-a72d-f289b7c6dbf3",
        "parent_planning_id": "8fd41ef5-4bb2-4e9e-a71b-910bd7f750e9",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





