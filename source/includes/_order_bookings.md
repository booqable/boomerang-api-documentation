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



> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
          "items": [
            {
              "type": "products",
              "id": "dd2576fa-8f73-4609-9c17-72a09e4b2268",
              "stock_item_ids": [
                "d7232c4e-ee82-4bcf-a432-f06139d76e47",
                "0f0c6a46-e2dc-4367-992a-7045afe7108c",
                "a1f1fd50-302e-42b4-8e60-90cd751ba37f"
              ]
            },
            {
              "type": "products",
              "id": "7d0ab1f8-830d-4765-8049-ce3b353f877c",
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
    "id": "374d2a46-e659-5c45-9e22-9e1ec8bf579a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "879ab39b-2d7c-4027-a155-ecd827868068"
          },
          {
            "type": "lines",
            "id": "7a7ba3c9-c8e8-4520-adf7-95feab980077"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44"
          },
          {
            "type": "plannings",
            "id": "c3ecd84e-2b29-4e6a-ac92-bc2b7abaa1bb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0ecad462-0d46-435c-8730-86c288094549"
          },
          {
            "type": "stock_item_plannings",
            "id": "f39b662f-c9b1-42c8-be43-dc74dcb9555d"
          },
          {
            "type": "stock_item_plannings",
            "id": "4fe3b25d-da97-4441-86e0-679c4dfd9368"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-20T09:25:26+00:00",
        "updated_at": "2024-05-20T09:25:30+00:00",
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
        "override_period_restrictions": false,
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
        "customer_id": "65cda81e-8c2c-4f7b-852b-6d1f369c2956",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e",
        "stop_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e"
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
        "transfers": {
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
      "id": "879ab39b-2d7c-4027-a155-ecd827868068",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-20T09:25:30+00:00",
        "updated_at": "2024-05-20T09:25:30+00:00",
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
        "display_price_in_cents": 96300,
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
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
        "item_id": "dd2576fa-8f73-4609-9c17-72a09e4b2268",
        "tax_category_id": "acb59e9a-9c34-4fed-accb-bdc89a2cdf94",
        "planning_id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "7a7ba3c9-c8e8-4520-adf7-95feab980077",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-20T09:25:30+00:00",
        "updated_at": "2024-05-20T09:25:30+00:00",
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
        "display_price_in_cents": 80250,
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
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
        "item_id": "7d0ab1f8-830d-4765-8049-ce3b353f877c",
        "tax_category_id": "acb59e9a-9c34-4fed-accb-bdc89a2cdf94",
        "planning_id": "c3ecd84e-2b29-4e6a-ac92-bc2b7abaa1bb",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:29+00:00",
        "updated_at": "2024-05-20T09:25:29+00:00",
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
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
        "item_id": "dd2576fa-8f73-4609-9c17-72a09e4b2268",
        "start_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e",
        "stop_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e",
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
      "id": "c3ecd84e-2b29-4e6a-ac92-bc2b7abaa1bb",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:29+00:00",
        "updated_at": "2024-05-20T09:25:29+00:00",
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
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281",
        "item_id": "7d0ab1f8-830d-4765-8049-ce3b353f877c",
        "start_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e",
        "stop_location_id": "9cbf9728-a03b-4808-8be0-9a8c588ea34e",
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
      "id": "0ecad462-0d46-435c-8730-86c288094549",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:29+00:00",
        "updated_at": "2024-05-20T09:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d7232c4e-ee82-4bcf-a432-f06139d76e47",
        "planning_id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44",
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281"
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
      "id": "f39b662f-c9b1-42c8-be43-dc74dcb9555d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:29+00:00",
        "updated_at": "2024-05-20T09:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0f0c6a46-e2dc-4367-992a-7045afe7108c",
        "planning_id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44",
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281"
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
      "id": "4fe3b25d-da97-4441-86e0-679c4dfd9368",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:29+00:00",
        "updated_at": "2024-05-20T09:25:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a1f1fd50-302e-42b4-8e60-90cd751ba37f",
        "planning_id": "7e9b1ee4-b714-4be6-9b35-e6c29f535b44",
        "order_id": "8f68b694-1f3e-4ff3-a0ac-66249d80f281"
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
          "order_id": "349a0fc1-4e2e-43e9-983f-e3aa3cca8baf",
          "items": [
            {
              "type": "products",
              "id": "16524481-5888-4a87-8a3f-dff0911e8597",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7eb6eb73-1bf7-49be-a6f9-f4a228f66912",
              "stock_item_ids": [
                "63686961-f2d9-4890-b927-3eb311cc16a1",
                "df031bc8-2702-440d-ac23-6fbf786d080b"
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
          "stock_item_id 63686961-f2d9-4890-b927-3eb311cc16a1 has already been booked on this order"
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
          "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
          "items": [
            {
              "type": "bundles",
              "id": "a83e284b-114c-4053-a312-b5573ee78774",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "24e6f414-0672-4193-a0e6-a5af56268274",
                  "id": "19f0a4aa-0365-4b04-9452-2034bf80333e"
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
    "id": "69edad0b-14d5-5e99-a508-71e5e297c4e3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a1cf4e82-eb2c-4387-904b-3ca6e21151b9"
          },
          {
            "type": "lines",
            "id": "d696adc4-f02b-43b6-868e-d578a08b46aa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e47c2a8b-9a1d-447c-9ab2-61cf94d0b2df"
          },
          {
            "type": "plannings",
            "id": "95362c09-982e-4963-8e46-6b2823bf094d"
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
      "id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-20T09:25:39+00:00",
        "updated_at": "2024-05-20T09:25:39+00:00",
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
        "starts_at": "2024-05-18T09:15:00+00:00",
        "stops_at": "2024-05-22T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "override_period_restrictions": false,
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
        "start_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015",
        "stop_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015"
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
        "transfers": {
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
      "id": "a1cf4e82-eb2c-4387-904b-3ca6e21151b9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-20T09:25:39+00:00",
        "updated_at": "2024-05-20T09:25:39+00:00",
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
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
        "item_id": "a83e284b-114c-4053-a312-b5573ee78774",
        "tax_category_id": null,
        "planning_id": "e47c2a8b-9a1d-447c-9ab2-61cf94d0b2df",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "d696adc4-f02b-43b6-868e-d578a08b46aa",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-20T09:25:39+00:00",
        "updated_at": "2024-05-20T09:25:39+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000018 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
        "item_id": "19f0a4aa-0365-4b04-9452-2034bf80333e",
        "tax_category_id": null,
        "planning_id": "95362c09-982e-4963-8e46-6b2823bf094d",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "a1cf4e82-eb2c-4387-904b-3ca6e21151b9",
        "owner_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "e47c2a8b-9a1d-447c-9ab2-61cf94d0b2df",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:39+00:00",
        "updated_at": "2024-05-20T09:25:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-18T09:15:00+00:00",
        "stops_at": "2024-05-22T09:15:00+00:00",
        "reserved_from": "2024-05-18T09:15:00+00:00",
        "reserved_till": "2024-05-22T09:15:00+00:00",
        "reserved": false,
        "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
        "item_id": "a83e284b-114c-4053-a312-b5573ee78774",
        "start_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015",
        "stop_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015",
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
      "id": "95362c09-982e-4963-8e46-6b2823bf094d",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-20T09:25:39+00:00",
        "updated_at": "2024-05-20T09:25:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-18T09:15:00+00:00",
        "stops_at": "2024-05-22T09:15:00+00:00",
        "reserved_from": "2024-05-18T09:15:00+00:00",
        "reserved_till": "2024-05-22T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "823a8593-5b2f-4a46-9f63-58fbbc115f7a",
        "item_id": "19f0a4aa-0365-4b04-9452-2034bf80333e",
        "start_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015",
        "stop_location_id": "b9a9e5af-8083-497b-82d6-0d499fddd015",
        "parent_planning_id": "e47c2a8b-9a1d-447c-9ab2-61cf94d0b2df",
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





