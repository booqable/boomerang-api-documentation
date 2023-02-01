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
          "order_id": "06b36cd3-28ec-498f-bdba-e2dceefebe78",
          "items": [
            {
              "type": "products",
              "id": "13d7ec8d-2cd9-4f22-add4-33a88d36bf7b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a403fca1-886b-4dd6-96a7-4ba0c7e8eeff",
              "stock_item_ids": [
                "195e4d51-3de5-4928-8ec5-92f2c1495f59",
                "449b9c1e-da3d-4bb6-8464-f51a6ab0175c"
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
            "item_id": "13d7ec8d-2cd9-4f22-add4-33a88d36bf7b",
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
          "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
          "items": [
            {
              "type": "products",
              "id": "f013c341-b18e-436b-9b13-4892c1bb3948",
              "stock_item_ids": [
                "776fac5c-649a-4111-b302-472c3e62c714",
                "7f7e00d6-5790-41b2-96d7-ea03eb0499b4",
                "ec3612f7-4401-4de7-b690-af77b922323b"
              ]
            },
            {
              "type": "products",
              "id": "b6d39674-85ae-47a9-9550-786de93e6acb",
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
    "id": "9ae18ec3-fb88-59bd-b464-4bdccbe31b6b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b07e03ad-61db-48ff-a89e-254d47f18fea"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d12cb47-c159-437c-bfc5-aba51bf8a940"
          },
          {
            "type": "lines",
            "id": "048ad116-8b71-439d-a0a0-b19212285e63"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4fc8b01b-84d5-439c-8721-9c0473d1796b"
          },
          {
            "type": "plannings",
            "id": "57c6cda2-961a-426e-a3c0-a03277135177"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d3c913ea-bb24-4e48-b65c-ba40ab9ad231"
          },
          {
            "type": "stock_item_plannings",
            "id": "65da63da-d2c8-42f5-b5bb-9b407ceae27c"
          },
          {
            "type": "stock_item_plannings",
            "id": "1b36df5b-28bc-44e3-99af-729f6577bd62"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T15:19:04+00:00",
        "updated_at": "2023-02-01T15:19:06+00:00",
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
        "customer_id": "857779e7-ff4f-407b-94e8-0b686c6c2618",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f",
        "stop_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f"
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
      "id": "7d12cb47-c159-437c-bfc5-aba51bf8a940",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
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
        "item_id": "f013c341-b18e-436b-9b13-4892c1bb3948",
        "tax_category_id": "cf355f82-667c-4401-ac8e-ff969e99b768",
        "planning_id": "4fc8b01b-84d5-439c-8721-9c0473d1796b",
        "parent_line_id": null,
        "owner_id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
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
      "id": "048ad116-8b71-439d-a0a0-b19212285e63",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
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
        "item_id": "b6d39674-85ae-47a9-9550-786de93e6acb",
        "tax_category_id": "cf355f82-667c-4401-ac8e-ff969e99b768",
        "planning_id": "57c6cda2-961a-426e-a3c0-a03277135177",
        "parent_line_id": null,
        "owner_id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
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
      "id": "4fc8b01b-84d5-439c-8721-9c0473d1796b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
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
        "item_id": "f013c341-b18e-436b-9b13-4892c1bb3948",
        "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
        "start_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f",
        "stop_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f",
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
      "id": "57c6cda2-961a-426e-a3c0-a03277135177",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
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
        "item_id": "b6d39674-85ae-47a9-9550-786de93e6acb",
        "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea",
        "start_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f",
        "stop_location_id": "c31934b4-6976-48d8-9547-cc2debfce53f",
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
      "id": "d3c913ea-bb24-4e48-b65c-ba40ab9ad231",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "776fac5c-649a-4111-b302-472c3e62c714",
        "planning_id": "4fc8b01b-84d5-439c-8721-9c0473d1796b",
        "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea"
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
      "id": "65da63da-d2c8-42f5-b5bb-9b407ceae27c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7f7e00d6-5790-41b2-96d7-ea03eb0499b4",
        "planning_id": "4fc8b01b-84d5-439c-8721-9c0473d1796b",
        "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea"
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
      "id": "1b36df5b-28bc-44e3-99af-729f6577bd62",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:05+00:00",
        "updated_at": "2023-02-01T15:19:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ec3612f7-4401-4de7-b690-af77b922323b",
        "planning_id": "4fc8b01b-84d5-439c-8721-9c0473d1796b",
        "order_id": "b07e03ad-61db-48ff-a89e-254d47f18fea"
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
          "order_id": "c54cd88a-2bba-4799-b247-aac2ad3280e1",
          "items": [
            {
              "type": "bundles",
              "id": "10fa001b-1cdd-4114-8740-5fcb48d9e2da",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "415820b8-cf6d-4432-9b84-51d08ebb5614",
                  "id": "ed4da0fe-9cd6-4544-acf5-81c479727f3a"
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
    "id": "9e90fa11-b2bd-5a6b-9ede-84022b63ba46",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c54cd88a-2bba-4799-b247-aac2ad3280e1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c54cd88a-2bba-4799-b247-aac2ad3280e1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d3fec354-c67a-41d7-bed0-d4517eaa10d5"
          },
          {
            "type": "lines",
            "id": "16e25b1a-9fdb-4289-a397-d629a8a3ed5e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2068a0dc-4f29-4338-8e78-a812b9afdbc9"
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
      "id": "c54cd88a-2bba-4799-b247-aac2ad3280e1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T15:19:08+00:00",
        "updated_at": "2023-02-01T15:19:09+00:00",
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
        "starts_at": "2023-01-30T15:15:00+00:00",
        "stops_at": "2023-02-03T15:15:00+00:00",
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
        "start_location_id": "5578337d-c8ac-4e0d-94c5-7005a6eef2df",
        "stop_location_id": "5578337d-c8ac-4e0d-94c5-7005a6eef2df"
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
      "id": "d3fec354-c67a-41d7-bed0-d4517eaa10d5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:19:08+00:00",
        "updated_at": "2023-02-01T15:19:08+00:00",
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
        "item_id": "10fa001b-1cdd-4114-8740-5fcb48d9e2da",
        "tax_category_id": null,
        "planning_id": "2068a0dc-4f29-4338-8e78-a812b9afdbc9",
        "parent_line_id": null,
        "owner_id": "c54cd88a-2bba-4799-b247-aac2ad3280e1",
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
      "id": "16e25b1a-9fdb-4289-a397-d629a8a3ed5e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:19:08+00:00",
        "updated_at": "2023-02-01T15:19:08+00:00",
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
        "item_id": "ed4da0fe-9cd6-4544-acf5-81c479727f3a",
        "tax_category_id": null,
        "planning_id": "fc504969-9b0c-40ef-85d6-ca5760cf3a2c",
        "parent_line_id": "d3fec354-c67a-41d7-bed0-d4517eaa10d5",
        "owner_id": "c54cd88a-2bba-4799-b247-aac2ad3280e1",
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
      "id": "2068a0dc-4f29-4338-8e78-a812b9afdbc9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:19:08+00:00",
        "updated_at": "2023-02-01T15:19:08+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-30T15:15:00+00:00",
        "stops_at": "2023-02-03T15:15:00+00:00",
        "reserved_from": "2023-01-30T15:15:00+00:00",
        "reserved_till": "2023-02-03T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "10fa001b-1cdd-4114-8740-5fcb48d9e2da",
        "order_id": "c54cd88a-2bba-4799-b247-aac2ad3280e1",
        "start_location_id": "5578337d-c8ac-4e0d-94c5-7005a6eef2df",
        "stop_location_id": "5578337d-c8ac-4e0d-94c5-7005a6eef2df",
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





