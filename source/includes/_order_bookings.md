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
          "order_id": "4fadeab6-7920-40c1-9177-baad5a7dbc0a",
          "items": [
            {
              "type": "products",
              "id": "39820fcc-2586-4458-bf14-1df1b496cd88",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "20a8c34f-d4ac-480a-a339-1a27ee9077fb",
              "stock_item_ids": [
                "9a7ca848-54fe-4560-9533-be20be21c10b",
                "3cf4d5c5-e02a-49de-9916-628385b781f9"
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
          "stock_item_id 9a7ca848-54fe-4560-9533-be20be21c10b has already been booked on this order"
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
          "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
          "items": [
            {
              "type": "products",
              "id": "696f11a6-ad4d-4e61-80e1-c1d1d9ae3511",
              "stock_item_ids": [
                "4cb8bc42-9c65-4542-b9cd-d7027454a066",
                "f7b119e1-c6b0-470a-9bde-1588f0ae215b",
                "77feff69-e07f-4315-a41a-42db03d96861"
              ]
            },
            {
              "type": "products",
              "id": "3b26d92d-1c0e-4849-9a85-3352581a36e3",
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
    "id": "80eaf5d9-a971-5c27-a7d4-556121d2a8d5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8696b877-efc6-4573-97fa-3f35d0e9e35f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "544770bb-ba0b-4e5f-8334-baaab44a81df"
          },
          {
            "type": "lines",
            "id": "83729257-245f-4aa8-9e81-40a5117ad0b4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70"
          },
          {
            "type": "plannings",
            "id": "a217a621-093e-4f42-83a8-06ad4dec3811"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "85d3cb5d-ac3e-4a87-ac6f-c1715dff7569"
          },
          {
            "type": "stock_item_plannings",
            "id": "c62f12dd-c672-456c-b113-8eb901421003"
          },
          {
            "type": "stock_item_plannings",
            "id": "60a278b2-ebbb-4794-b474-d8fdb6cbf509"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
      "type": "orders",
      "attributes": {
        "created_at": "2024-03-04T09:17:40+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
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
        "customer_id": "e9f447e6-86a0-4657-93ba-a9f9c92fd4fc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779",
        "stop_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779"
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
      "id": "544770bb-ba0b-4e5f-8334-baaab44a81df",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
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
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
        "item_id": "696f11a6-ad4d-4e61-80e1-c1d1d9ae3511",
        "tax_category_id": "41c9be59-1eb3-4b87-9143-6ed55a70e909",
        "planning_id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
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
      "id": "83729257-245f-4aa8-9e81-40a5117ad0b4",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
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
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
        "item_id": "3b26d92d-1c0e-4849-9a85-3352581a36e3",
        "tax_category_id": "41c9be59-1eb3-4b87-9143-6ed55a70e909",
        "planning_id": "a217a621-093e-4f42-83a8-06ad4dec3811",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
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
      "id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
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
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
        "item_id": "696f11a6-ad4d-4e61-80e1-c1d1d9ae3511",
        "start_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779",
        "stop_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779",
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
      "id": "a217a621-093e-4f42-83a8-06ad4dec3811",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
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
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f",
        "item_id": "3b26d92d-1c0e-4849-9a85-3352581a36e3",
        "start_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779",
        "stop_location_id": "31a849a7-eb1e-4fdb-8c23-cf1bd579d779",
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
      "id": "85d3cb5d-ac3e-4a87-ac6f-c1715dff7569",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4cb8bc42-9c65-4542-b9cd-d7027454a066",
        "planning_id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70",
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f"
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
      "id": "c62f12dd-c672-456c-b113-8eb901421003",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f7b119e1-c6b0-470a-9bde-1588f0ae215b",
        "planning_id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70",
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f"
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
      "id": "60a278b2-ebbb-4794-b474-d8fdb6cbf509",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:42+00:00",
        "updated_at": "2024-03-04T09:17:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "77feff69-e07f-4315-a41a-42db03d96861",
        "planning_id": "10dd636f-6c73-4a77-af69-7d24bb0e3a70",
        "order_id": "8696b877-efc6-4573-97fa-3f35d0e9e35f"
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
          "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
          "items": [
            {
              "type": "bundles",
              "id": "6a8b6e93-cdc1-4b8a-bcf2-21af08655ea3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7637c84f-1cca-4e8b-adf5-7006052ae02d",
                  "id": "41f76ea2-c067-4e26-843c-a9d58d9dba28"
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
    "id": "0b14ea7b-4afa-58a1-9a69-406667a92551",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5a526622-6566-49f7-a0cd-4b842ed2f425"
          },
          {
            "type": "lines",
            "id": "91349489-b5b0-4447-adac-416a4694d27d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "227b06b5-8227-45b2-a70d-29383f6d6a51"
          },
          {
            "type": "plannings",
            "id": "6b6d5d5c-718e-4b2f-bdee-27198b6aebad"
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
      "id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
      "type": "orders",
      "attributes": {
        "created_at": "2024-03-04T09:17:45+00:00",
        "updated_at": "2024-03-04T09:17:46+00:00",
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
        "starts_at": "2024-03-02T09:15:00+00:00",
        "stops_at": "2024-03-06T09:15:00+00:00",
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
        "start_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9",
        "stop_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9"
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
      "id": "5a526622-6566-49f7-a0cd-4b842ed2f425",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-04T09:17:46+00:00",
        "updated_at": "2024-03-04T09:17:46+00:00",
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
        "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
        "item_id": "6a8b6e93-cdc1-4b8a-bcf2-21af08655ea3",
        "tax_category_id": null,
        "planning_id": "227b06b5-8227-45b2-a70d-29383f6d6a51",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
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
      "id": "91349489-b5b0-4447-adac-416a4694d27d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-04T09:17:46+00:00",
        "updated_at": "2024-03-04T09:17:46+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000051 - red",
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
        "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
        "item_id": "41f76ea2-c067-4e26-843c-a9d58d9dba28",
        "tax_category_id": null,
        "planning_id": "6b6d5d5c-718e-4b2f-bdee-27198b6aebad",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "5a526622-6566-49f7-a0cd-4b842ed2f425",
        "owner_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
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
      "id": "227b06b5-8227-45b2-a70d-29383f6d6a51",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:46+00:00",
        "updated_at": "2024-03-04T09:17:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-03-02T09:15:00+00:00",
        "stops_at": "2024-03-06T09:15:00+00:00",
        "reserved_from": "2024-03-02T09:15:00+00:00",
        "reserved_till": "2024-03-06T09:15:00+00:00",
        "reserved": false,
        "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
        "item_id": "6a8b6e93-cdc1-4b8a-bcf2-21af08655ea3",
        "start_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9",
        "stop_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9",
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
      "id": "6b6d5d5c-718e-4b2f-bdee-27198b6aebad",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-04T09:17:46+00:00",
        "updated_at": "2024-03-04T09:17:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-03-02T09:15:00+00:00",
        "stops_at": "2024-03-06T09:15:00+00:00",
        "reserved_from": "2024-03-02T09:15:00+00:00",
        "reserved_till": "2024-03-06T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "3f1f59d5-2a40-43d8-83a9-25695459b9d4",
        "item_id": "41f76ea2-c067-4e26-843c-a9d58d9dba28",
        "start_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9",
        "stop_location_id": "f2a432ed-d481-4071-bd3a-e32038c234e9",
        "parent_planning_id": "227b06b5-8227-45b2-a70d-29383f6d6a51",
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





