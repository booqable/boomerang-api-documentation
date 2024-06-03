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
          "order_id": "54a06b58-b49d-4296-aaad-157db397fe19",
          "items": [
            {
              "type": "products",
              "id": "15bd4e1c-5a98-4ca9-831d-f2142e058940",
              "stock_item_ids": [
                "6b1688e6-399f-40fb-a98d-e305cb4ff7bf",
                "ccf739b4-c5d0-41e9-bed8-48e40d8ef20b",
                "8a59f4ce-0ed4-4a98-b2db-fb38944424d0"
              ]
            },
            {
              "type": "products",
              "id": "28a4d066-d60d-4d17-8f53-998017602a04",
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
    "id": "75b006a9-7e9e-5452-a207-d5cf1e2e7e3f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "54a06b58-b49d-4296-aaad-157db397fe19"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "54a06b58-b49d-4296-aaad-157db397fe19"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "72d6c54c-33ad-4db9-b11e-de90dc89c60c"
          },
          {
            "type": "lines",
            "id": "f3984071-0125-438b-bc1a-2182206ff659"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c2031439-eda0-4a10-a086-679632a23978"
          },
          {
            "type": "plannings",
            "id": "7d0f9998-d52a-42d9-9518-081962bab906"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1dcb5962-0088-4796-885a-60965b7ca0e2"
          },
          {
            "type": "stock_item_plannings",
            "id": "b64ed193-b8e9-4bb8-ad18-f6ac1dbd79af"
          },
          {
            "type": "stock_item_plannings",
            "id": "a44773eb-6afb-47a6-a463-851e95286cd4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "54a06b58-b49d-4296-aaad-157db397fe19",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-03T09:29:33.740134+00:00",
        "updated_at": "2024-06-03T09:29:37.214115+00:00",
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
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
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
        "customer_id": "bdf01e0a-c5f0-490b-9076-68dc04bee58a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08",
        "stop_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08"
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
      "id": "72d6c54c-33ad-4db9-b11e-de90dc89c60c",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.995206+00:00",
        "updated_at": "2024-06-03T09:29:37.287312+00:00",
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
                  "price_in_cents": 7750
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
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19",
        "item_id": "15bd4e1c-5a98-4ca9-831d-f2142e058940",
        "tax_category_id": "16d2c475-e7c1-464f-8d71-68b0814b95db",
        "planning_id": "c2031439-eda0-4a10-a086-679632a23978",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "54a06b58-b49d-4296-aaad-157db397fe19",
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
      "id": "f3984071-0125-438b-bc1a-2182206ff659",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.995206+00:00",
        "updated_at": "2024-06-03T09:29:37.287312+00:00",
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
                  "price_in_cents": 7750
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
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19",
        "item_id": "28a4d066-d60d-4d17-8f53-998017602a04",
        "tax_category_id": "16d2c475-e7c1-464f-8d71-68b0814b95db",
        "planning_id": "7d0f9998-d52a-42d9-9518-081962bab906",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "54a06b58-b49d-4296-aaad-157db397fe19",
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
      "id": "c2031439-eda0-4a10-a086-679632a23978",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.871911+00:00",
        "updated_at": "2024-06-03T09:29:36.871911+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 3,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19",
        "item_id": "15bd4e1c-5a98-4ca9-831d-f2142e058940",
        "start_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08",
        "stop_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08",
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
      "id": "7d0f9998-d52a-42d9-9518-081962bab906",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.871911+00:00",
        "updated_at": "2024-06-03T09:29:36.871911+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19",
        "item_id": "28a4d066-d60d-4d17-8f53-998017602a04",
        "start_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08",
        "stop_location_id": "33017d20-c86b-4b34-be1d-8021256b1a08",
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
      "id": "1dcb5962-0088-4796-885a-60965b7ca0e2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.890502+00:00",
        "updated_at": "2024-06-03T09:29:36.890502+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6b1688e6-399f-40fb-a98d-e305cb4ff7bf",
        "planning_id": "c2031439-eda0-4a10-a086-679632a23978",
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19"
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
      "id": "b64ed193-b8e9-4bb8-ad18-f6ac1dbd79af",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.890502+00:00",
        "updated_at": "2024-06-03T09:29:36.890502+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ccf739b4-c5d0-41e9-bed8-48e40d8ef20b",
        "planning_id": "c2031439-eda0-4a10-a086-679632a23978",
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19"
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
      "id": "a44773eb-6afb-47a6-a463-851e95286cd4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:36.890502+00:00",
        "updated_at": "2024-06-03T09:29:36.890502+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8a59f4ce-0ed4-4a98-b2db-fb38944424d0",
        "planning_id": "c2031439-eda0-4a10-a086-679632a23978",
        "order_id": "54a06b58-b49d-4296-aaad-157db397fe19"
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
          "order_id": "88cb3c8e-f608-4e73-92af-f2232bb56263",
          "items": [
            {
              "type": "products",
              "id": "7f915f09-c315-4bb0-8078-fa085636cdf0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "09c88644-535b-49bb-b067-d59986e4007f",
              "stock_item_ids": [
                "22a3af64-6c72-476f-b743-15416922f94d",
                "c3024cc8-cb0b-4740-bec6-e9554bd7f6cb"
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
          "stock_item_id 22a3af64-6c72-476f-b743-15416922f94d has already been booked on this order"
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
          "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
          "items": [
            {
              "type": "bundles",
              "id": "7cce6b3d-6520-43db-814d-e0d83c691541",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fbf5c9fd-c1f9-4a1e-978f-44dbbfabf7da",
                  "id": "79a9a7dd-7e21-440b-b358-94f0495ba173"
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
    "id": "03eb668c-64dc-5128-8760-4e84174a0fcf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4f078b06-1f7e-4521-8a80-1f4c221d6314"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "913c2c1a-6954-40cc-9a1e-09cd9f7c7a1d"
          },
          {
            "type": "lines",
            "id": "7ffa7ebe-4aa4-4457-b3f9-1a9ba3c29e51"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b383f404-3906-4659-ae84-5ddc737adf70"
          },
          {
            "type": "plannings",
            "id": "67c38ef1-3d4e-469c-8b14-af8361cc2239"
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
      "id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-03T09:29:45.818379+00:00",
        "updated_at": "2024-06-03T09:29:47.349840+00:00",
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
        "starts_at": "2024-06-01T09:15:00.000000+00:00",
        "stops_at": "2024-06-05T09:15:00.000000+00:00",
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
        "start_location_id": "89444bd9-43ff-4c88-99ac-321893f87748",
        "stop_location_id": "89444bd9-43ff-4c88-99ac-321893f87748"
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
      "id": "913c2c1a-6954-40cc-9a1e-09cd9f7c7a1d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-03T09:29:47.409807+00:00",
        "updated_at": "2024-06-03T09:29:47.492816+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 8",
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
        "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
        "item_id": "7cce6b3d-6520-43db-814d-e0d83c691541",
        "tax_category_id": null,
        "planning_id": "b383f404-3906-4659-ae84-5ddc737adf70",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
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
      "id": "7ffa7ebe-4aa4-4457-b3f9-1a9ba3c29e51",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-03T09:29:47.417695+00:00",
        "updated_at": "2024-06-03T09:29:47.492816+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000066 - red",
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
        "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
        "item_id": "79a9a7dd-7e21-440b-b358-94f0495ba173",
        "tax_category_id": null,
        "planning_id": "67c38ef1-3d4e-469c-8b14-af8361cc2239",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "913c2c1a-6954-40cc-9a1e-09cd9f7c7a1d",
        "owner_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
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
      "id": "b383f404-3906-4659-ae84-5ddc737adf70",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:47.323679+00:00",
        "updated_at": "2024-06-03T09:29:47.323679+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-06-01T09:15:00.000000+00:00",
        "stops_at": "2024-06-05T09:15:00.000000+00:00",
        "reserved_from": "2024-06-01T09:15:00.000000+00:00",
        "reserved_till": "2024-06-05T09:15:00.000000+00:00",
        "reserved": false,
        "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
        "item_id": "7cce6b3d-6520-43db-814d-e0d83c691541",
        "start_location_id": "89444bd9-43ff-4c88-99ac-321893f87748",
        "stop_location_id": "89444bd9-43ff-4c88-99ac-321893f87748",
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
      "id": "67c38ef1-3d4e-469c-8b14-af8361cc2239",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-03T09:29:47.323679+00:00",
        "updated_at": "2024-06-03T09:29:47.323679+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-06-01T09:15:00.000000+00:00",
        "stops_at": "2024-06-05T09:15:00.000000+00:00",
        "reserved_from": "2024-06-01T09:15:00.000000+00:00",
        "reserved_till": "2024-06-05T09:15:00.000000+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "4f078b06-1f7e-4521-8a80-1f4c221d6314",
        "item_id": "79a9a7dd-7e21-440b-b358-94f0495ba173",
        "start_location_id": "89444bd9-43ff-4c88-99ac-321893f87748",
        "stop_location_id": "89444bd9-43ff-4c88-99ac-321893f87748",
        "parent_planning_id": "b383f404-3906-4659-ae84-5ddc737adf70",
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





