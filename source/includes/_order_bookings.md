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
          "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
          "items": [
            {
              "type": "products",
              "id": "21faa545-6984-4de4-97c7-88bbaad1efad",
              "stock_item_ids": [
                "af16c6a6-3167-4b61-94ea-943bd545d575",
                "e132e898-a7a9-4612-ae15-b527eb5c01bb",
                "768ab91d-c7bc-4f23-9435-5ebe5b6075db"
              ]
            },
            {
              "type": "products",
              "id": "7322c9f7-3cf0-4d19-be67-aec7e2120aec",
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
    "id": "af2dfff7-fb09-5535-9714-7c2d21524838",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d0992f01-63cb-4151-869d-7ca16f58f4dc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "911eb7cb-7f8c-458f-bf6e-16b2ae75c38b"
          },
          {
            "type": "lines",
            "id": "eb17c632-6b0c-4169-94dd-bc01a9097cbe"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3095b7ba-beb6-4584-9768-12a28b5a89bf"
          },
          {
            "type": "plannings",
            "id": "e736b3fc-4e32-46c3-b529-d1f314e96255"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f18cfe5d-65b7-471c-9f56-62abe32235a4"
          },
          {
            "type": "stock_item_plannings",
            "id": "d025baff-cc01-48af-ae2e-84eac9a9a1dd"
          },
          {
            "type": "stock_item_plannings",
            "id": "717504fb-e313-411f-acc5-5242626dfe90"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-12T09:18:10+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
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
        "customer_id": "78afda80-cfcf-40b0-9e94-67ce94769e32",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080",
        "stop_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080"
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
      "id": "911eb7cb-7f8c-458f-bf6e-16b2ae75c38b",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
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
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
        "item_id": "21faa545-6984-4de4-97c7-88bbaad1efad",
        "tax_category_id": "b49a18bb-fc21-4a32-8ba5-15eacc8c27f9",
        "planning_id": "3095b7ba-beb6-4584-9768-12a28b5a89bf",
        "parent_line_id": null,
        "owner_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
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
      "id": "eb17c632-6b0c-4169-94dd-bc01a9097cbe",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
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
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
        "item_id": "7322c9f7-3cf0-4d19-be67-aec7e2120aec",
        "tax_category_id": "b49a18bb-fc21-4a32-8ba5-15eacc8c27f9",
        "planning_id": "e736b3fc-4e32-46c3-b529-d1f314e96255",
        "parent_line_id": null,
        "owner_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
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
      "id": "3095b7ba-beb6-4584-9768-12a28b5a89bf",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
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
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
        "item_id": "21faa545-6984-4de4-97c7-88bbaad1efad",
        "start_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080",
        "stop_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080",
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
      "id": "e736b3fc-4e32-46c3-b529-d1f314e96255",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
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
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc",
        "item_id": "7322c9f7-3cf0-4d19-be67-aec7e2120aec",
        "start_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080",
        "stop_location_id": "1b0cd07c-3f72-4166-a6b5-c02fb48c1080",
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
      "id": "f18cfe5d-65b7-471c-9f56-62abe32235a4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af16c6a6-3167-4b61-94ea-943bd545d575",
        "planning_id": "3095b7ba-beb6-4584-9768-12a28b5a89bf",
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc"
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
      "id": "d025baff-cc01-48af-ae2e-84eac9a9a1dd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e132e898-a7a9-4612-ae15-b527eb5c01bb",
        "planning_id": "3095b7ba-beb6-4584-9768-12a28b5a89bf",
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc"
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
      "id": "717504fb-e313-411f-acc5-5242626dfe90",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:12+00:00",
        "updated_at": "2024-02-12T09:18:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "768ab91d-c7bc-4f23-9435-5ebe5b6075db",
        "planning_id": "3095b7ba-beb6-4584-9768-12a28b5a89bf",
        "order_id": "d0992f01-63cb-4151-869d-7ca16f58f4dc"
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
          "order_id": "439d6fec-c09b-4e41-952b-7732e0511238",
          "items": [
            {
              "type": "products",
              "id": "52d96a03-1b67-428e-9aca-5f271dbaa427",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9f3ac0b2-0d3f-4674-abd0-138bd10433eb",
              "stock_item_ids": [
                "132020d0-3be5-4bd7-a9cd-1961f1680b1e",
                "8e14c1ce-5c5a-48d1-b1ad-4fb051981ccb"
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
          "stock_item_id 132020d0-3be5-4bd7-a9cd-1961f1680b1e has already been booked on this order"
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
          "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
          "items": [
            {
              "type": "bundles",
              "id": "2a4d3333-8977-459e-9aca-6b82c0894168",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "02c26b4d-f281-4ff3-8c34-f6479e1a2f3f",
                  "id": "a7ad3165-6f3d-4970-af14-9d7bb52638a9"
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
    "id": "a1419e7c-af19-5e35-ad01-024c3aebf6ff",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af454e4c-9d4e-459d-b4a7-973460feb03c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "12c317b8-23b2-4594-9db3-75ee78c05fa9"
          },
          {
            "type": "lines",
            "id": "8631f213-8c6f-46d7-a0e8-8a722c901c63"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ac20973f-b636-44de-acfc-cd6da17e342b"
          },
          {
            "type": "plannings",
            "id": "00680589-bc5b-4808-b9dc-f9707ff19a24"
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
      "id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-12T09:18:17+00:00",
        "updated_at": "2024-02-12T09:18:17+00:00",
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
        "starts_at": "2024-02-10T09:15:00+00:00",
        "stops_at": "2024-02-14T09:15:00+00:00",
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
        "start_location_id": "fea92ddd-0971-415f-be55-698897b72703",
        "stop_location_id": "fea92ddd-0971-415f-be55-698897b72703"
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
      "id": "12c317b8-23b2-4594-9db3-75ee78c05fa9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-12T09:18:17+00:00",
        "updated_at": "2024-02-12T09:18:17+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000074 - red",
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
        "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
        "item_id": "a7ad3165-6f3d-4970-af14-9d7bb52638a9",
        "tax_category_id": null,
        "planning_id": "00680589-bc5b-4808-b9dc-f9707ff19a24",
        "parent_line_id": "8631f213-8c6f-46d7-a0e8-8a722c901c63",
        "owner_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
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
      "id": "8631f213-8c6f-46d7-a0e8-8a722c901c63",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-12T09:18:17+00:00",
        "updated_at": "2024-02-12T09:18:17+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 5",
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
        "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
        "item_id": "2a4d3333-8977-459e-9aca-6b82c0894168",
        "tax_category_id": null,
        "planning_id": "ac20973f-b636-44de-acfc-cd6da17e342b",
        "parent_line_id": null,
        "owner_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
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
      "id": "ac20973f-b636-44de-acfc-cd6da17e342b",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:17+00:00",
        "updated_at": "2024-02-12T09:18:17+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-10T09:15:00+00:00",
        "stops_at": "2024-02-14T09:15:00+00:00",
        "reserved_from": "2024-02-10T09:15:00+00:00",
        "reserved_till": "2024-02-14T09:15:00+00:00",
        "reserved": false,
        "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
        "item_id": "2a4d3333-8977-459e-9aca-6b82c0894168",
        "start_location_id": "fea92ddd-0971-415f-be55-698897b72703",
        "stop_location_id": "fea92ddd-0971-415f-be55-698897b72703",
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
      "id": "00680589-bc5b-4808-b9dc-f9707ff19a24",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-12T09:18:17+00:00",
        "updated_at": "2024-02-12T09:18:17+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-10T09:15:00+00:00",
        "stops_at": "2024-02-14T09:15:00+00:00",
        "reserved_from": "2024-02-10T09:15:00+00:00",
        "reserved_till": "2024-02-14T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "af454e4c-9d4e-459d-b4a7-973460feb03c",
        "item_id": "a7ad3165-6f3d-4970-af14-9d7bb52638a9",
        "start_location_id": "fea92ddd-0971-415f-be55-698897b72703",
        "stop_location_id": "fea92ddd-0971-415f-be55-698897b72703",
        "parent_planning_id": "ac20973f-b636-44de-acfc-cd6da17e342b",
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





