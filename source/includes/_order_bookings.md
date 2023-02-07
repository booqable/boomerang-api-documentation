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
          "order_id": "da361b83-aa3f-4e58-8f22-3e068ade2199",
          "items": [
            {
              "type": "products",
              "id": "5f70c4d9-5fcf-4ef6-af41-ec5977c8cf8c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fd339943-ec70-48cc-8a16-9079f17be651",
              "stock_item_ids": [
                "a07aa53a-8646-4ccf-bbc2-84c13b496e64",
                "ffac648e-bbbc-4ce8-9215-38c7e0cee2c5"
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
            "item_id": "5f70c4d9-5fcf-4ef6-af41-ec5977c8cf8c",
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
          "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
          "items": [
            {
              "type": "products",
              "id": "b53a8a6d-70ce-49a8-b9ba-c8d5a2e912d2",
              "stock_item_ids": [
                "0bddaa15-098e-4639-b666-d2335c670f70",
                "5ac535cf-27d5-4e9e-99a0-0a586ab8e3d6",
                "450cba7c-80c9-4dea-b108-0b87e833f90a"
              ]
            },
            {
              "type": "products",
              "id": "e036f7b4-60a7-4637-82c2-d6f622f9b034",
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
    "id": "636f5666-bf29-5cfb-ae7e-1d8463e11597",
    "type": "order_bookings",
    "attributes": {
      "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5b9776cf-63dd-4deb-acb0-116f7582432d"
          },
          {
            "type": "lines",
            "id": "f6234ce3-0551-49fd-b98a-33319640ee7e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e2249447-3ff3-440d-a2f0-e2c47e18cace"
          },
          {
            "type": "plannings",
            "id": "92f3d07a-20b5-43f8-87e4-85e74d10b6c8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "382c5e20-5d9e-4758-9033-65d30e47580f"
          },
          {
            "type": "stock_item_plannings",
            "id": "4c7f0255-4b59-43dc-9b39-1c63293e409d"
          },
          {
            "type": "stock_item_plannings",
            "id": "33b57685-a957-4a4a-bcd4-6fde375fffe6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T14:34:17+00:00",
        "updated_at": "2023-02-07T14:34:20+00:00",
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
        "customer_id": "5427dd86-951f-4c35-bbb8-256947699c4c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0",
        "stop_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0"
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
      "id": "5b9776cf-63dd-4deb-acb0-116f7582432d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:20+00:00",
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
        "item_id": "b53a8a6d-70ce-49a8-b9ba-c8d5a2e912d2",
        "tax_category_id": "227330e0-4e1a-404a-8ccb-5424e4f72358",
        "planning_id": "e2249447-3ff3-440d-a2f0-e2c47e18cace",
        "parent_line_id": null,
        "owner_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
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
      "id": "f6234ce3-0551-49fd-b98a-33319640ee7e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:20+00:00",
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
        "item_id": "e036f7b4-60a7-4637-82c2-d6f622f9b034",
        "tax_category_id": "227330e0-4e1a-404a-8ccb-5424e4f72358",
        "planning_id": "92f3d07a-20b5-43f8-87e4-85e74d10b6c8",
        "parent_line_id": null,
        "owner_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
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
      "id": "e2249447-3ff3-440d-a2f0-e2c47e18cace",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:20+00:00",
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
        "item_id": "b53a8a6d-70ce-49a8-b9ba-c8d5a2e912d2",
        "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
        "start_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0",
        "stop_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0",
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
      "id": "92f3d07a-20b5-43f8-87e4-85e74d10b6c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:20+00:00",
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
        "item_id": "e036f7b4-60a7-4637-82c2-d6f622f9b034",
        "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed",
        "start_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0",
        "stop_location_id": "cb37ac12-24e5-4e6e-bf37-8f8cfe0e73d0",
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
      "id": "382c5e20-5d9e-4758-9033-65d30e47580f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0bddaa15-098e-4639-b666-d2335c670f70",
        "planning_id": "e2249447-3ff3-440d-a2f0-e2c47e18cace",
        "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed"
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
      "id": "4c7f0255-4b59-43dc-9b39-1c63293e409d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5ac535cf-27d5-4e9e-99a0-0a586ab8e3d6",
        "planning_id": "e2249447-3ff3-440d-a2f0-e2c47e18cace",
        "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed"
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
      "id": "33b57685-a957-4a4a-bcd4-6fde375fffe6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:19+00:00",
        "updated_at": "2023-02-07T14:34:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "450cba7c-80c9-4dea-b108-0b87e833f90a",
        "planning_id": "e2249447-3ff3-440d-a2f0-e2c47e18cace",
        "order_id": "120dd5bd-6fb0-4c3a-978c-01cbdccd7aed"
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
          "order_id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42",
          "items": [
            {
              "type": "bundles",
              "id": "9a38ab07-cd37-4332-858f-e60fd56be559",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "78c81e2a-e087-401d-af85-64ea84db8639",
                  "id": "e55d98b8-59ab-46b1-9a94-b2faed36b5cb"
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
    "id": "40e13aab-2ebc-54e4-8e20-7f0d707c8a38",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6970203b-bb03-44b5-9b1c-cf474ed1c2a7"
          },
          {
            "type": "lines",
            "id": "17afcab5-62b2-488b-9133-239d79f91dd4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5746ca76-fada-4707-924e-64bac99c6cb0"
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
      "id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T14:34:23+00:00",
        "updated_at": "2023-02-07T14:34:24+00:00",
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
        "starts_at": "2023-02-05T14:30:00+00:00",
        "stops_at": "2023-02-09T14:30:00+00:00",
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
        "start_location_id": "46482edb-7de0-4774-bd73-832d9a140e50",
        "stop_location_id": "46482edb-7de0-4774-bd73-832d9a140e50"
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
      "id": "6970203b-bb03-44b5-9b1c-cf474ed1c2a7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:34:23+00:00",
        "updated_at": "2023-02-07T14:34:24+00:00",
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
        "item_id": "9a38ab07-cd37-4332-858f-e60fd56be559",
        "tax_category_id": null,
        "planning_id": "5746ca76-fada-4707-924e-64bac99c6cb0",
        "parent_line_id": null,
        "owner_id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42",
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
      "id": "17afcab5-62b2-488b-9133-239d79f91dd4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:34:23+00:00",
        "updated_at": "2023-02-07T14:34:24+00:00",
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
        "item_id": "e55d98b8-59ab-46b1-9a94-b2faed36b5cb",
        "tax_category_id": null,
        "planning_id": "f542d2ec-9190-4414-aa4e-d12c31aadc3f",
        "parent_line_id": "6970203b-bb03-44b5-9b1c-cf474ed1c2a7",
        "owner_id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42",
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
      "id": "5746ca76-fada-4707-924e-64bac99c6cb0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:34:23+00:00",
        "updated_at": "2023-02-07T14:34:23+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T14:30:00+00:00",
        "stops_at": "2023-02-09T14:30:00+00:00",
        "reserved_from": "2023-02-05T14:30:00+00:00",
        "reserved_till": "2023-02-09T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9a38ab07-cd37-4332-858f-e60fd56be559",
        "order_id": "b173fb2c-0dd3-4afb-99ed-b3d86ec43b42",
        "start_location_id": "46482edb-7de0-4774-bd73-832d9a140e50",
        "stop_location_id": "46482edb-7de0-4774-bd73-832d9a140e50",
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





