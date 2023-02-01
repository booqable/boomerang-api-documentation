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
          "order_id": "59904dac-1999-442c-98de-3ccd280c0771",
          "items": [
            {
              "type": "products",
              "id": "f2a24cf5-eb62-4ae9-8728-645e48904522",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b3be388d-2a3c-4bd9-9faa-b0947b50e7c3",
              "stock_item_ids": [
                "3989371a-1943-47db-9567-5f52e703429d",
                "2bfe5213-a263-4cc3-83ff-3324e764ae8b"
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
            "item_id": "f2a24cf5-eb62-4ae9-8728-645e48904522",
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
          "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
          "items": [
            {
              "type": "products",
              "id": "b1b96166-a2f4-4ca6-9c71-5a0b3f4b60ef",
              "stock_item_ids": [
                "e3e9d6f7-f572-4cf9-bad5-1ed6c33e936b",
                "3bbba3c8-11ac-44f8-a78e-aae18d40d918",
                "a1d53cab-41a8-412c-b9c0-e0cd06872203"
              ]
            },
            {
              "type": "products",
              "id": "2f9249b9-db3f-4d6c-a817-5bfcdce1d5bf",
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
    "id": "ae5cb143-f246-5589-a6b6-6335b72d0284",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6ade228a-53bb-4c51-b951-6c12f3ed97d1"
          },
          {
            "type": "lines",
            "id": "cdb432e0-d377-4d12-a709-60ad997a877d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "66434873-79f2-4b39-8a11-8f0f1313464b"
          },
          {
            "type": "plannings",
            "id": "781e782a-7df1-4c77-ad99-9754316ce212"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "bb78eac0-a38e-4ea4-90cb-bb2ef4b66fd6"
          },
          {
            "type": "stock_item_plannings",
            "id": "b9ddf53f-3248-455b-aa5f-01873ca6b0d8"
          },
          {
            "type": "stock_item_plannings",
            "id": "f8722bac-b7d9-4dfe-a30d-d04fc7935938"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T13:01:17+00:00",
        "updated_at": "2023-02-01T13:01:19+00:00",
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
        "customer_id": "6fbc5c30-de1c-487f-a89d-d9b9bbd2f784",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68",
        "stop_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68"
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
      "id": "6ade228a-53bb-4c51-b951-6c12f3ed97d1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
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
        "item_id": "b1b96166-a2f4-4ca6-9c71-5a0b3f4b60ef",
        "tax_category_id": "55fe04b5-c42a-43a9-8bc4-f8c67c19c083",
        "planning_id": "66434873-79f2-4b39-8a11-8f0f1313464b",
        "parent_line_id": null,
        "owner_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
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
      "id": "cdb432e0-d377-4d12-a709-60ad997a877d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
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
        "item_id": "2f9249b9-db3f-4d6c-a817-5bfcdce1d5bf",
        "tax_category_id": "55fe04b5-c42a-43a9-8bc4-f8c67c19c083",
        "planning_id": "781e782a-7df1-4c77-ad99-9754316ce212",
        "parent_line_id": null,
        "owner_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
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
      "id": "66434873-79f2-4b39-8a11-8f0f1313464b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
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
        "item_id": "b1b96166-a2f4-4ca6-9c71-5a0b3f4b60ef",
        "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
        "start_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68",
        "stop_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68",
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
      "id": "781e782a-7df1-4c77-ad99-9754316ce212",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
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
        "item_id": "2f9249b9-db3f-4d6c-a817-5bfcdce1d5bf",
        "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc",
        "start_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68",
        "stop_location_id": "7ac4357b-0c7d-4171-a5e8-31e04825cb68",
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
      "id": "bb78eac0-a38e-4ea4-90cb-bb2ef4b66fd6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e3e9d6f7-f572-4cf9-bad5-1ed6c33e936b",
        "planning_id": "66434873-79f2-4b39-8a11-8f0f1313464b",
        "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc"
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
      "id": "b9ddf53f-3248-455b-aa5f-01873ca6b0d8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3bbba3c8-11ac-44f8-a78e-aae18d40d918",
        "planning_id": "66434873-79f2-4b39-8a11-8f0f1313464b",
        "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc"
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
      "id": "f8722bac-b7d9-4dfe-a30d-d04fc7935938",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:18+00:00",
        "updated_at": "2023-02-01T13:01:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a1d53cab-41a8-412c-b9c0-e0cd06872203",
        "planning_id": "66434873-79f2-4b39-8a11-8f0f1313464b",
        "order_id": "3afbd09c-5cf5-4e74-8fee-a6e3a68435bc"
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
          "order_id": "809aa2f8-74c3-4df2-ac2e-fbb517047335",
          "items": [
            {
              "type": "bundles",
              "id": "551874ca-e87a-49b6-8128-5dbd1c0633b8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a718163f-5f24-45f8-9984-40cd69e36962",
                  "id": "80e115f0-0769-44cc-85c1-f0d33dbef1e0"
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
    "id": "29321c12-2d50-56ce-86a5-ba69f79fb6e4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "809aa2f8-74c3-4df2-ac2e-fbb517047335"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "809aa2f8-74c3-4df2-ac2e-fbb517047335"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "138d117f-2cf2-4318-972c-98ae8e2beaf1"
          },
          {
            "type": "lines",
            "id": "ba186d47-98e4-4ef6-971b-64648b36d709"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c8f78622-1fc8-4bdc-a927-1acfeeb4e596"
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
      "id": "809aa2f8-74c3-4df2-ac2e-fbb517047335",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T13:01:21+00:00",
        "updated_at": "2023-02-01T13:01:21+00:00",
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
        "starts_at": "2023-01-30T13:00:00+00:00",
        "stops_at": "2023-02-03T13:00:00+00:00",
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
        "start_location_id": "942ad632-fb16-4c8f-8812-104f7919b437",
        "stop_location_id": "942ad632-fb16-4c8f-8812-104f7919b437"
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
      "id": "138d117f-2cf2-4318-972c-98ae8e2beaf1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:01:21+00:00",
        "updated_at": "2023-02-01T13:01:21+00:00",
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
        "item_id": "80e115f0-0769-44cc-85c1-f0d33dbef1e0",
        "tax_category_id": null,
        "planning_id": "1fc3a6cf-b8b9-4998-bb07-66a16b5be44e",
        "parent_line_id": "ba186d47-98e4-4ef6-971b-64648b36d709",
        "owner_id": "809aa2f8-74c3-4df2-ac2e-fbb517047335",
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
      "id": "ba186d47-98e4-4ef6-971b-64648b36d709",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:01:21+00:00",
        "updated_at": "2023-02-01T13:01:21+00:00",
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
        "item_id": "551874ca-e87a-49b6-8128-5dbd1c0633b8",
        "tax_category_id": null,
        "planning_id": "c8f78622-1fc8-4bdc-a927-1acfeeb4e596",
        "parent_line_id": null,
        "owner_id": "809aa2f8-74c3-4df2-ac2e-fbb517047335",
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
      "id": "c8f78622-1fc8-4bdc-a927-1acfeeb4e596",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:01:21+00:00",
        "updated_at": "2023-02-01T13:01:21+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-30T13:00:00+00:00",
        "stops_at": "2023-02-03T13:00:00+00:00",
        "reserved_from": "2023-01-30T13:00:00+00:00",
        "reserved_till": "2023-02-03T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "551874ca-e87a-49b6-8128-5dbd1c0633b8",
        "order_id": "809aa2f8-74c3-4df2-ac2e-fbb517047335",
        "start_location_id": "942ad632-fb16-4c8f-8812-104f7919b437",
        "stop_location_id": "942ad632-fb16-4c8f-8812-104f7919b437",
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





