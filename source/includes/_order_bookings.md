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
          "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
          "items": [
            {
              "type": "products",
              "id": "6ecbe60d-c53b-4277-a37e-6730be4f4952",
              "stock_item_ids": [
                "ff367555-7d28-409c-9363-0f1185284ba5",
                "d0ecbd00-fee5-475f-bdbb-c8d45ba7df6c",
                "f43976a1-ea03-4af8-bac0-fb751574b2e1"
              ]
            },
            {
              "type": "products",
              "id": "297305e4-23c4-4f27-bd38-63190eea531d",
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
    "id": "bb2a6624-106d-5f57-a358-49facf5da9da",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3ce44632-180d-45ee-9e91-a81fa9f46835"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "109a012b-8f01-4014-a881-8c8a29f75f45"
          },
          {
            "type": "lines",
            "id": "7e054ce2-3adb-41f9-b32f-91e4053f2ccc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b50a8c07-7a46-4f65-9a8e-842483404ace"
          },
          {
            "type": "plannings",
            "id": "874cd2b0-fd1c-418e-bb8f-85186b96d824"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0e524109-b35a-4701-ad9d-5f9ce9f598e4"
          },
          {
            "type": "stock_item_plannings",
            "id": "dd401da8-57a6-4023-9fcb-5cafeab787c3"
          },
          {
            "type": "stock_item_plannings",
            "id": "7f134cae-50c5-41c8-b709-1a11bfd2890a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-09T07:37:01+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
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
        "customer_id": "d6109fdc-3f72-4d75-80af-f8b2af62ec0e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d",
        "stop_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d"
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
      "id": "109a012b-8f01-4014-a881-8c8a29f75f45",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
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
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
        "item_id": "6ecbe60d-c53b-4277-a37e-6730be4f4952",
        "tax_category_id": "f8d1eef7-86bc-49ed-a9e5-c785da64dceb",
        "planning_id": "b50a8c07-7a46-4f65-9a8e-842483404ace",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
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
      "id": "7e054ce2-3adb-41f9-b32f-91e4053f2ccc",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
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
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
        "item_id": "297305e4-23c4-4f27-bd38-63190eea531d",
        "tax_category_id": "f8d1eef7-86bc-49ed-a9e5-c785da64dceb",
        "planning_id": "874cd2b0-fd1c-418e-bb8f-85186b96d824",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
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
      "id": "b50a8c07-7a46-4f65-9a8e-842483404ace",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
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
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
        "item_id": "6ecbe60d-c53b-4277-a37e-6730be4f4952",
        "start_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d",
        "stop_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d",
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
      "id": "874cd2b0-fd1c-418e-bb8f-85186b96d824",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
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
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835",
        "item_id": "297305e4-23c4-4f27-bd38-63190eea531d",
        "start_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d",
        "stop_location_id": "3b71eae7-5e2a-4be3-8921-cd5db8da642d",
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
      "id": "0e524109-b35a-4701-ad9d-5f9ce9f598e4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ff367555-7d28-409c-9363-0f1185284ba5",
        "planning_id": "b50a8c07-7a46-4f65-9a8e-842483404ace",
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835"
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
      "id": "dd401da8-57a6-4023-9fcb-5cafeab787c3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d0ecbd00-fee5-475f-bdbb-c8d45ba7df6c",
        "planning_id": "b50a8c07-7a46-4f65-9a8e-842483404ace",
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835"
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
      "id": "7f134cae-50c5-41c8-b709-1a11bfd2890a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:03+00:00",
        "updated_at": "2024-04-09T07:37:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f43976a1-ea03-4af8-bac0-fb751574b2e1",
        "planning_id": "b50a8c07-7a46-4f65-9a8e-842483404ace",
        "order_id": "3ce44632-180d-45ee-9e91-a81fa9f46835"
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
          "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
          "items": [
            {
              "type": "bundles",
              "id": "f7218b8d-0a3a-4f56-bad1-b84373c70092",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e4cb342c-a8f2-484d-97c5-8a91dbc58e5e",
                  "id": "1a078411-d0d7-45b3-b6b7-443a8a0dd8e8"
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
    "id": "9b86b3ad-a3e2-5e5a-aa8e-60eb4a506209",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af40320f-5f4e-4794-87af-e8ff1960e566"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "01d0d5d5-6506-4ff7-9c25-b58d5932fb91"
          },
          {
            "type": "lines",
            "id": "e4557203-f4a3-416e-ad06-1e39413905d0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "87c432c0-94f8-49c1-89cc-bb3277459a5a"
          },
          {
            "type": "plannings",
            "id": "cfcb40f5-04d4-46d7-9db6-ac429340d1d3"
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
      "id": "af40320f-5f4e-4794-87af-e8ff1960e566",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-09T07:37:06+00:00",
        "updated_at": "2024-04-09T07:37:07+00:00",
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
        "starts_at": "2024-04-07T07:30:00+00:00",
        "stops_at": "2024-04-11T07:30:00+00:00",
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
        "start_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700",
        "stop_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700"
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
      "id": "01d0d5d5-6506-4ff7-9c25-b58d5932fb91",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-09T07:37:07+00:00",
        "updated_at": "2024-04-09T07:37:07+00:00",
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
        "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
        "item_id": "f7218b8d-0a3a-4f56-bad1-b84373c70092",
        "tax_category_id": null,
        "planning_id": "87c432c0-94f8-49c1-89cc-bb3277459a5a",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
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
      "id": "e4557203-f4a3-416e-ad06-1e39413905d0",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-09T07:37:07+00:00",
        "updated_at": "2024-04-09T07:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000000 - red",
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
        "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
        "item_id": "1a078411-d0d7-45b3-b6b7-443a8a0dd8e8",
        "tax_category_id": null,
        "planning_id": "cfcb40f5-04d4-46d7-9db6-ac429340d1d3",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "01d0d5d5-6506-4ff7-9c25-b58d5932fb91",
        "owner_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
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
      "id": "87c432c0-94f8-49c1-89cc-bb3277459a5a",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:06+00:00",
        "updated_at": "2024-04-09T07:37:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-07T07:30:00+00:00",
        "stops_at": "2024-04-11T07:30:00+00:00",
        "reserved_from": "2024-04-07T07:30:00+00:00",
        "reserved_till": "2024-04-11T07:30:00+00:00",
        "reserved": false,
        "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
        "item_id": "f7218b8d-0a3a-4f56-bad1-b84373c70092",
        "start_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700",
        "stop_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700",
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
      "id": "cfcb40f5-04d4-46d7-9db6-ac429340d1d3",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-09T07:37:06+00:00",
        "updated_at": "2024-04-09T07:37:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-07T07:30:00+00:00",
        "stops_at": "2024-04-11T07:30:00+00:00",
        "reserved_from": "2024-04-07T07:30:00+00:00",
        "reserved_till": "2024-04-11T07:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "af40320f-5f4e-4794-87af-e8ff1960e566",
        "item_id": "1a078411-d0d7-45b3-b6b7-443a8a0dd8e8",
        "start_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700",
        "stop_location_id": "139a3ccf-5db7-4ca3-83ed-a4bb3f853700",
        "parent_planning_id": "87c432c0-94f8-49c1-89cc-bb3277459a5a",
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
          "order_id": "d3f4b524-9f2a-44ac-bb65-e4c0140032f4",
          "items": [
            {
              "type": "products",
              "id": "838dc437-a750-4e38-a030-c94352d32d98",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "14565913-d023-4324-95fc-ad37d23b4ed6",
              "stock_item_ids": [
                "1d5619b7-392e-4250-8aec-acf0d29843c1",
                "83811ee0-25f9-4e67-b7ab-7876ac790156"
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
          "stock_item_id 1d5619b7-392e-4250-8aec-acf0d29843c1 has already been booked on this order"
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





