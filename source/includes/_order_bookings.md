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
          "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
          "items": [
            {
              "type": "bundles",
              "id": "8122c0c2-c8a4-4b2f-8714-b4dfded332fc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "94b500f3-8aae-4f26-ae06-fa32ef23a98a",
                  "id": "12964cab-ba42-42ad-924a-4e16280ea0ed"
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
    "id": "f6df3ff4-8393-5884-ad81-7178213588f8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aba1d716-108f-43d5-99b5-63d17c80f6b4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "06023dfc-eb5f-48cb-a376-c923afb572bb"
          },
          {
            "type": "lines",
            "id": "f26eea41-6fc9-49d9-a609-23677377fee9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "55331492-fca0-4085-b0d3-8fbc2893a785"
          },
          {
            "type": "plannings",
            "id": "d64f5eb4-958e-4e0c-b2dd-0716db22b166"
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
      "id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-19T09:19:02+00:00",
        "updated_at": "2024-02-19T09:19:03+00:00",
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
        "starts_at": "2024-02-17T09:15:00+00:00",
        "stops_at": "2024-02-21T09:15:00+00:00",
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
        "start_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418",
        "stop_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418"
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
      "id": "06023dfc-eb5f-48cb-a376-c923afb572bb",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-19T09:19:03+00:00",
        "updated_at": "2024-02-19T09:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
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
        "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
        "item_id": "8122c0c2-c8a4-4b2f-8714-b4dfded332fc",
        "tax_category_id": null,
        "planning_id": "55331492-fca0-4085-b0d3-8fbc2893a785",
        "parent_line_id": null,
        "owner_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
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
      "id": "f26eea41-6fc9-49d9-a609-23677377fee9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-19T09:19:03+00:00",
        "updated_at": "2024-02-19T09:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000055 - red",
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
        "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
        "item_id": "12964cab-ba42-42ad-924a-4e16280ea0ed",
        "tax_category_id": null,
        "planning_id": "d64f5eb4-958e-4e0c-b2dd-0716db22b166",
        "parent_line_id": "06023dfc-eb5f-48cb-a376-c923afb572bb",
        "owner_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
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
      "id": "55331492-fca0-4085-b0d3-8fbc2893a785",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:03+00:00",
        "updated_at": "2024-02-19T09:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-17T09:15:00+00:00",
        "stops_at": "2024-02-21T09:15:00+00:00",
        "reserved_from": "2024-02-17T09:15:00+00:00",
        "reserved_till": "2024-02-21T09:15:00+00:00",
        "reserved": false,
        "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
        "item_id": "8122c0c2-c8a4-4b2f-8714-b4dfded332fc",
        "start_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418",
        "stop_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418",
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
      "id": "d64f5eb4-958e-4e0c-b2dd-0716db22b166",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:03+00:00",
        "updated_at": "2024-02-19T09:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-17T09:15:00+00:00",
        "stops_at": "2024-02-21T09:15:00+00:00",
        "reserved_from": "2024-02-17T09:15:00+00:00",
        "reserved_till": "2024-02-21T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "aba1d716-108f-43d5-99b5-63d17c80f6b4",
        "item_id": "12964cab-ba42-42ad-924a-4e16280ea0ed",
        "start_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418",
        "stop_location_id": "b77a1e36-3c9d-4ff1-80dc-337edf694418",
        "parent_planning_id": "55331492-fca0-4085-b0d3-8fbc2893a785",
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "813dcac2-87fe-41ad-973f-1f6117252cce",
          "items": [
            {
              "type": "products",
              "id": "7932ca0b-d6d2-4ac3-b6b6-b4f58fd09f8d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "56c1a474-1b2d-481f-b785-de76a7dc1c1b",
              "stock_item_ids": [
                "1ec7282d-b67f-48aa-b1eb-2cf1ebddc565",
                "2aa78569-7a0d-4a11-be90-2c69eb3043e4"
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
          "stock_item_id 1ec7282d-b67f-48aa-b1eb-2cf1ebddc565 has already been booked on this order"
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
          "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
          "items": [
            {
              "type": "products",
              "id": "b019ef34-d64a-4046-af13-9d3cc97b2e6c",
              "stock_item_ids": [
                "710d2e0e-053c-47fa-b309-21985e1faeda",
                "54e73cc2-71be-4f82-88d8-863ed63d921f",
                "779a3c27-57aa-4528-a667-6fa44357de38"
              ]
            },
            {
              "type": "products",
              "id": "57ee4882-9a5b-4602-8952-d47a0b47c07a",
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
    "id": "5d64fae5-9d50-5f56-94c9-674ef002c8b9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "33685d45-2f50-4501-aa36-4a7cc1ffb1d6"
          },
          {
            "type": "lines",
            "id": "1935933c-26da-4c04-bc61-320425a8ed8f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2793193f-effb-4b4a-a344-9c9659b60c4d"
          },
          {
            "type": "plannings",
            "id": "99c61961-62ef-4183-ac7e-020b47ebeee4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "422a7d33-54ae-449a-8581-bfe6217155d7"
          },
          {
            "type": "stock_item_plannings",
            "id": "7336572a-6134-487f-972b-e5d3432b7f0c"
          },
          {
            "type": "stock_item_plannings",
            "id": "d2fad676-73c7-4b7f-be8b-aae5f0cf173c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-19T09:19:06+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
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
        "customer_id": "70470a78-c1b2-4772-bb1b-f02ceafbdc77",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd",
        "stop_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd"
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
      "id": "33685d45-2f50-4501-aa36-4a7cc1ffb1d6",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
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
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
        "item_id": "b019ef34-d64a-4046-af13-9d3cc97b2e6c",
        "tax_category_id": "1c83040c-1468-4f4d-b264-fd2b324f8bf8",
        "planning_id": "2793193f-effb-4b4a-a344-9c9659b60c4d",
        "parent_line_id": null,
        "owner_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
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
      "id": "1935933c-26da-4c04-bc61-320425a8ed8f",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
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
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
        "item_id": "57ee4882-9a5b-4602-8952-d47a0b47c07a",
        "tax_category_id": "1c83040c-1468-4f4d-b264-fd2b324f8bf8",
        "planning_id": "99c61961-62ef-4183-ac7e-020b47ebeee4",
        "parent_line_id": null,
        "owner_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
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
      "id": "2793193f-effb-4b4a-a344-9c9659b60c4d",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
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
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
        "item_id": "b019ef34-d64a-4046-af13-9d3cc97b2e6c",
        "start_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd",
        "stop_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd",
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
      "id": "99c61961-62ef-4183-ac7e-020b47ebeee4",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
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
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e",
        "item_id": "57ee4882-9a5b-4602-8952-d47a0b47c07a",
        "start_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd",
        "stop_location_id": "5334a641-131f-49b0-b6a0-4d05ad1266dd",
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
      "id": "422a7d33-54ae-449a-8581-bfe6217155d7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "710d2e0e-053c-47fa-b309-21985e1faeda",
        "planning_id": "2793193f-effb-4b4a-a344-9c9659b60c4d",
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e"
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
      "id": "7336572a-6134-487f-972b-e5d3432b7f0c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "54e73cc2-71be-4f82-88d8-863ed63d921f",
        "planning_id": "2793193f-effb-4b4a-a344-9c9659b60c4d",
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e"
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
      "id": "d2fad676-73c7-4b7f-be8b-aae5f0cf173c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-19T09:19:09+00:00",
        "updated_at": "2024-02-19T09:19:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "779a3c27-57aa-4528-a667-6fa44357de38",
        "planning_id": "2793193f-effb-4b4a-a344-9c9659b60c4d",
        "order_id": "ca36c1d1-c22f-4048-b58f-ed3dbe37ba8e"
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





