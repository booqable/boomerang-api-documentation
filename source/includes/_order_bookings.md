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
          "order_id": "225bf808-6c6f-4523-905e-9d9ebdb88a78",
          "items": [
            {
              "type": "products",
              "id": "ce14d86f-8821-4dae-a665-4c7be5290b23",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0c83b41b-9be6-4080-a9ce-99b5d82e133d",
              "stock_item_ids": [
                "31790ce9-3735-460f-90e3-e6895d666195",
                "27580c9c-ef18-4041-88ff-bee838842097"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 31790ce9-3735-460f-90e3-e6895d666195 has already been booked on this order"
        ]
      }
    }
  ]
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
          "order_id": "83478a41-f427-4661-9dd6-afea7331e177",
          "items": [
            {
              "type": "bundles",
              "id": "dc5ef1f7-dce8-4e8f-b12c-14f06fd1d570",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e8d011bf-dd51-4088-864c-b7463f3b386e",
                  "id": "33f11712-e679-4dc6-b428-58e5f084b082"
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
    "id": "aa5e566a-aaf4-5950-add1-ea898703efe0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "83478a41-f427-4661-9dd6-afea7331e177"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "83478a41-f427-4661-9dd6-afea7331e177"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3771ae73-73fa-4d92-8dab-9b99092a05d0"
          },
          {
            "type": "lines",
            "id": "ff097756-5266-4e56-81aa-856f3755471e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "288d56fc-7880-4f74-bebb-6be0b5a8de24"
          },
          {
            "type": "plannings",
            "id": "f0747a9d-481e-417e-8d35-bc3781d36cbc"
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
      "id": "83478a41-f427-4661-9dd6-afea7331e177",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-08T09:14:20+00:00",
        "updated_at": "2024-01-08T09:14:21+00:00",
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
        "starts_at": "2024-01-06T09:00:00+00:00",
        "stops_at": "2024-01-10T09:00:00+00:00",
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
        "start_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7",
        "stop_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7"
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
      "id": "3771ae73-73fa-4d92-8dab-9b99092a05d0",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-08T09:14:21+00:00",
        "updated_at": "2024-01-08T09:14:21+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 1",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "83478a41-f427-4661-9dd6-afea7331e177",
        "item_id": "dc5ef1f7-dce8-4e8f-b12c-14f06fd1d570",
        "tax_category_id": null,
        "planning_id": "288d56fc-7880-4f74-bebb-6be0b5a8de24",
        "parent_line_id": null,
        "owner_id": "83478a41-f427-4661-9dd6-afea7331e177",
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
      "id": "ff097756-5266-4e56-81aa-856f3755471e",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-08T09:14:21+00:00",
        "updated_at": "2024-01-08T09:14:21+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000004 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "83478a41-f427-4661-9dd6-afea7331e177",
        "item_id": "33f11712-e679-4dc6-b428-58e5f084b082",
        "tax_category_id": null,
        "planning_id": "f0747a9d-481e-417e-8d35-bc3781d36cbc",
        "parent_line_id": "3771ae73-73fa-4d92-8dab-9b99092a05d0",
        "owner_id": "83478a41-f427-4661-9dd6-afea7331e177",
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
      "id": "288d56fc-7880-4f74-bebb-6be0b5a8de24",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:21+00:00",
        "updated_at": "2024-01-08T09:14:21+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-06T09:00:00+00:00",
        "stops_at": "2024-01-10T09:00:00+00:00",
        "reserved_from": "2024-01-06T09:00:00+00:00",
        "reserved_till": "2024-01-10T09:00:00+00:00",
        "reserved": false,
        "order_id": "83478a41-f427-4661-9dd6-afea7331e177",
        "item_id": "dc5ef1f7-dce8-4e8f-b12c-14f06fd1d570",
        "start_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7",
        "stop_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7",
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
      "id": "f0747a9d-481e-417e-8d35-bc3781d36cbc",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:21+00:00",
        "updated_at": "2024-01-08T09:14:21+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-06T09:00:00+00:00",
        "stops_at": "2024-01-10T09:00:00+00:00",
        "reserved_from": "2024-01-06T09:00:00+00:00",
        "reserved_till": "2024-01-10T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "83478a41-f427-4661-9dd6-afea7331e177",
        "item_id": "33f11712-e679-4dc6-b428-58e5f084b082",
        "start_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7",
        "stop_location_id": "d87a199e-49c5-4b73-9769-87b80ab747b7",
        "parent_planning_id": "288d56fc-7880-4f74-bebb-6be0b5a8de24",
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


> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
          "items": [
            {
              "type": "products",
              "id": "0629d814-215d-4011-814c-1045a3c39726",
              "stock_item_ids": [
                "319f0aa2-8d86-4762-bc52-0c94bdc2b11a",
                "61c6e284-8c37-417b-9ae5-a74b30be43f4",
                "b53b2497-1d26-46e6-8f2b-8c548efdcf5b"
              ]
            },
            {
              "type": "products",
              "id": "e32c251c-b86f-4569-8a41-6546182f311e",
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
    "id": "19db3e86-72c9-5796-b9ed-32e33dddc4fc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f614d635-ac60-49d3-a829-1394d0c9b41d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "58df6b0f-59ab-462d-b709-1b364975d00f"
          },
          {
            "type": "lines",
            "id": "76cfb9a5-848a-4a3c-9f81-a9cdb6cfec62"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00"
          },
          {
            "type": "plannings",
            "id": "2e049111-9cbd-4766-8411-a45bdf187268"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e463c2e4-1160-4ae3-90e2-a0e6a7118433"
          },
          {
            "type": "stock_item_plannings",
            "id": "a9bb7399-17da-49ae-9d5c-ea7210334552"
          },
          {
            "type": "stock_item_plannings",
            "id": "c1176283-d061-4ed5-a901-24a8ab8afe2c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-08T09:14:23+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
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
        "customer_id": "f2f3a002-4006-4574-a9de-9da89ef7d255",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9",
        "stop_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9"
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
      "id": "58df6b0f-59ab-462d-b709-1b364975d00f",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
        "item_id": "0629d814-215d-4011-814c-1045a3c39726",
        "tax_category_id": "bdc0746f-cad1-4be9-b0ad-527d4e20a132",
        "planning_id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00",
        "parent_line_id": null,
        "owner_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
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
      "id": "76cfb9a5-848a-4a3c-9f81-a9cdb6cfec62",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
        "item_id": "e32c251c-b86f-4569-8a41-6546182f311e",
        "tax_category_id": "bdc0746f-cad1-4be9-b0ad-527d4e20a132",
        "planning_id": "2e049111-9cbd-4766-8411-a45bdf187268",
        "parent_line_id": null,
        "owner_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
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
      "id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
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
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
        "item_id": "0629d814-215d-4011-814c-1045a3c39726",
        "start_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9",
        "stop_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9",
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
      "id": "2e049111-9cbd-4766-8411-a45bdf187268",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
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
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d",
        "item_id": "e32c251c-b86f-4569-8a41-6546182f311e",
        "start_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9",
        "stop_location_id": "8ffe73ba-716e-4811-9ed4-5bd03faa53d9",
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
      "id": "e463c2e4-1160-4ae3-90e2-a0e6a7118433",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "319f0aa2-8d86-4762-bc52-0c94bdc2b11a",
        "planning_id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00",
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d"
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
      "id": "a9bb7399-17da-49ae-9d5c-ea7210334552",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "61c6e284-8c37-417b-9ae5-a74b30be43f4",
        "planning_id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00",
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d"
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
      "id": "c1176283-d061-4ed5-a901-24a8ab8afe2c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-08T09:14:26+00:00",
        "updated_at": "2024-01-08T09:14:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b53b2497-1d26-46e6-8f2b-8c548efdcf5b",
        "planning_id": "e4a1811a-3050-4bfa-b1ab-f4d657c06f00",
        "order_id": "f614d635-ac60-49d3-a829-1394d0c9b41d"
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





