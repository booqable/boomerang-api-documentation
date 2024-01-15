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



> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
          "items": [
            {
              "type": "bundles",
              "id": "3843bd92-502f-40d3-8101-4e5d75fbf5da",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "694d216e-1f85-4689-8115-7819fe878543",
                  "id": "362baed6-3d83-4d56-9095-dd0930d4555e"
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
    "id": "c8db2e3e-cd24-56a6-b60d-95bce0d597d9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e9eac2c-319f-4536-8d86-795066b82dae"
          },
          {
            "type": "lines",
            "id": "ee2167dc-ced8-4b37-a8ac-59923100aeb2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "abfec825-a669-48fe-8c33-d5f978704e58"
          },
          {
            "type": "plannings",
            "id": "c09f8e89-b06d-4f35-bce0-58a2b5c12068"
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
      "id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-15T09:13:28+00:00",
        "updated_at": "2024-01-15T09:13:29+00:00",
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
        "starts_at": "2024-01-13T09:00:00+00:00",
        "stops_at": "2024-01-17T09:00:00+00:00",
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
        "start_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e",
        "stop_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e"
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
      "id": "5e9eac2c-319f-4536-8d86-795066b82dae",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-15T09:13:29+00:00",
        "updated_at": "2024-01-15T09:13:29+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 2",
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
        "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
        "item_id": "3843bd92-502f-40d3-8101-4e5d75fbf5da",
        "tax_category_id": null,
        "planning_id": "abfec825-a669-48fe-8c33-d5f978704e58",
        "parent_line_id": null,
        "owner_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
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
      "id": "ee2167dc-ced8-4b37-a8ac-59923100aeb2",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-15T09:13:29+00:00",
        "updated_at": "2024-01-15T09:13:29+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000016 - red",
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
        "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
        "item_id": "362baed6-3d83-4d56-9095-dd0930d4555e",
        "tax_category_id": null,
        "planning_id": "c09f8e89-b06d-4f35-bce0-58a2b5c12068",
        "parent_line_id": "5e9eac2c-319f-4536-8d86-795066b82dae",
        "owner_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
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
      "id": "abfec825-a669-48fe-8c33-d5f978704e58",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:29+00:00",
        "updated_at": "2024-01-15T09:13:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-13T09:00:00+00:00",
        "stops_at": "2024-01-17T09:00:00+00:00",
        "reserved_from": "2024-01-13T09:00:00+00:00",
        "reserved_till": "2024-01-17T09:00:00+00:00",
        "reserved": false,
        "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
        "item_id": "3843bd92-502f-40d3-8101-4e5d75fbf5da",
        "start_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e",
        "stop_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e",
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
      "id": "c09f8e89-b06d-4f35-bce0-58a2b5c12068",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:29+00:00",
        "updated_at": "2024-01-15T09:13:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-13T09:00:00+00:00",
        "stops_at": "2024-01-17T09:00:00+00:00",
        "reserved_from": "2024-01-13T09:00:00+00:00",
        "reserved_till": "2024-01-17T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "aa9cb430-d6d3-46a7-be0d-a12e0fba94a0",
        "item_id": "362baed6-3d83-4d56-9095-dd0930d4555e",
        "start_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e",
        "stop_location_id": "64740a62-a623-48f7-80ec-7d863b592c9e",
        "parent_planning_id": "abfec825-a669-48fe-8c33-d5f978704e58",
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
          "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
          "items": [
            {
              "type": "products",
              "id": "19f390c0-c850-4ee3-aef6-eaae8b385c81",
              "stock_item_ids": [
                "4917d985-0241-4c6e-88d6-1b89085d0c4f",
                "1a323ff8-e0e2-4217-aeca-414e63a96381",
                "c12ca54e-58c1-4d19-a246-d02642e296b7"
              ]
            },
            {
              "type": "products",
              "id": "b4e9132f-8826-4275-82ef-abba0d4f942c",
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
    "id": "7808e7c5-8381-53a7-ad85-54cc5227e7b7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "722523da-0a98-4cb5-bae4-4eb938661b09"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8ea255e0-0536-4802-a3dc-3fb815911e03"
          },
          {
            "type": "lines",
            "id": "2e74e160-f4c3-4b1c-ab85-9ae466cade2d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "83499f64-8411-4008-9a5f-b4b901894b74"
          },
          {
            "type": "plannings",
            "id": "7af39730-0c48-4e7c-9970-593261840f6e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6c5e946f-c810-416b-9b4c-b4a75ad8750f"
          },
          {
            "type": "stock_item_plannings",
            "id": "365e23c2-a43f-4e43-a949-9c973c4636be"
          },
          {
            "type": "stock_item_plannings",
            "id": "d945831d-ee4d-40d0-b9f2-b36b102d500f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "722523da-0a98-4cb5-bae4-4eb938661b09",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-15T09:13:30+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
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
        "customer_id": "6cc6d67a-c818-462b-82a3-f62ed87fad38",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597",
        "stop_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597"
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
      "id": "8ea255e0-0536-4802-a3dc-3fb815911e03",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
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
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
        "item_id": "19f390c0-c850-4ee3-aef6-eaae8b385c81",
        "tax_category_id": "020bc0eb-1f20-46ed-bc44-6d0b562fbb11",
        "planning_id": "83499f64-8411-4008-9a5f-b4b901894b74",
        "parent_line_id": null,
        "owner_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
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
      "id": "2e74e160-f4c3-4b1c-ab85-9ae466cade2d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
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
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
        "item_id": "b4e9132f-8826-4275-82ef-abba0d4f942c",
        "tax_category_id": "020bc0eb-1f20-46ed-bc44-6d0b562fbb11",
        "planning_id": "7af39730-0c48-4e7c-9970-593261840f6e",
        "parent_line_id": null,
        "owner_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
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
      "id": "83499f64-8411-4008-9a5f-b4b901894b74",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
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
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
        "item_id": "19f390c0-c850-4ee3-aef6-eaae8b385c81",
        "start_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597",
        "stop_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597",
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
      "id": "7af39730-0c48-4e7c-9970-593261840f6e",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
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
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09",
        "item_id": "b4e9132f-8826-4275-82ef-abba0d4f942c",
        "start_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597",
        "stop_location_id": "06a2fe5c-8800-4198-a19c-2a81c9488597",
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
      "id": "6c5e946f-c810-416b-9b4c-b4a75ad8750f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4917d985-0241-4c6e-88d6-1b89085d0c4f",
        "planning_id": "83499f64-8411-4008-9a5f-b4b901894b74",
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09"
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
      "id": "365e23c2-a43f-4e43-a949-9c973c4636be",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1a323ff8-e0e2-4217-aeca-414e63a96381",
        "planning_id": "83499f64-8411-4008-9a5f-b4b901894b74",
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09"
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
      "id": "d945831d-ee4d-40d0-b9f2-b36b102d500f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-15T09:13:33+00:00",
        "updated_at": "2024-01-15T09:13:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c12ca54e-58c1-4d19-a246-d02642e296b7",
        "planning_id": "83499f64-8411-4008-9a5f-b4b901894b74",
        "order_id": "722523da-0a98-4cb5-bae4-4eb938661b09"
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "585db311-c6f0-48b9-aa11-58699aeb85ff",
          "items": [
            {
              "type": "products",
              "id": "27edad0c-8c0b-42a5-9851-bbbc0216ac03",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "338777d9-53ec-4af6-abaf-15264f7b3cfb",
              "stock_item_ids": [
                "18aafe31-dbda-49e6-834a-a305b1de5fa9",
                "59f1f465-49a2-4c44-b7f2-26e854ef4203"
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
          "stock_item_id 18aafe31-dbda-49e6-834a-a305b1de5fa9 has already been booked on this order"
        ]
      }
    }
  ]
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





