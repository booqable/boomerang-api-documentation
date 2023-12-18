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
          "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
          "items": [
            {
              "type": "products",
              "id": "473fceda-3a0f-4a36-8f10-31df80c38257",
              "stock_item_ids": [
                "7163a43a-aea7-4baa-a555-3179eb8db674",
                "72819623-d428-408b-ad2e-f2fa61cc4ed2",
                "199e6c4b-2498-4d9f-bd4b-7467bb4afe2f"
              ]
            },
            {
              "type": "products",
              "id": "393e4309-daa1-4fd6-b505-d325843bb546",
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
    "id": "5249f8a8-323d-5070-863e-bada2e31462a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a2c26e10-d68d-42bf-aacb-ffc9928a3941"
          },
          {
            "type": "lines",
            "id": "f4499072-9d0f-411f-83d5-00b7c484d308"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5aa5afd7-03e4-4de9-af26-6bf276867e35"
          },
          {
            "type": "plannings",
            "id": "82b7ceb2-2e8f-49a1-817d-17c1f65988df"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "86267126-80e0-4c04-8e69-e2ba8078191a"
          },
          {
            "type": "stock_item_plannings",
            "id": "31f4323f-b860-4e42-b223-3130bda5fe01"
          },
          {
            "type": "stock_item_plannings",
            "id": "c08d776c-ed32-4926-8659-617309eb4d1b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-18T09:16:01+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
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
        "customer_id": "b7e3f6db-2bca-44cd-a7ff-57c2febbe765",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f",
        "stop_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f"
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
      "id": "a2c26e10-d68d-42bf-aacb-ffc9928a3941",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
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
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
        "item_id": "473fceda-3a0f-4a36-8f10-31df80c38257",
        "tax_category_id": "b3f05d10-b66b-47b5-8977-79ea685fc55c",
        "planning_id": "5aa5afd7-03e4-4de9-af26-6bf276867e35",
        "parent_line_id": null,
        "owner_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
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
      "id": "f4499072-9d0f-411f-83d5-00b7c484d308",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
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
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
        "item_id": "393e4309-daa1-4fd6-b505-d325843bb546",
        "tax_category_id": "b3f05d10-b66b-47b5-8977-79ea685fc55c",
        "planning_id": "82b7ceb2-2e8f-49a1-817d-17c1f65988df",
        "parent_line_id": null,
        "owner_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
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
      "id": "5aa5afd7-03e4-4de9-af26-6bf276867e35",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
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
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
        "item_id": "473fceda-3a0f-4a36-8f10-31df80c38257",
        "start_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f",
        "stop_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f",
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
      "id": "82b7ceb2-2e8f-49a1-817d-17c1f65988df",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
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
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81",
        "item_id": "393e4309-daa1-4fd6-b505-d325843bb546",
        "start_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f",
        "stop_location_id": "7d4639ca-63f0-4af8-af87-c4f41c84a55f",
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
      "id": "86267126-80e0-4c04-8e69-e2ba8078191a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7163a43a-aea7-4baa-a555-3179eb8db674",
        "planning_id": "5aa5afd7-03e4-4de9-af26-6bf276867e35",
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81"
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
      "id": "31f4323f-b860-4e42-b223-3130bda5fe01",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "72819623-d428-408b-ad2e-f2fa61cc4ed2",
        "planning_id": "5aa5afd7-03e4-4de9-af26-6bf276867e35",
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81"
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
      "id": "c08d776c-ed32-4926-8659-617309eb4d1b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:04+00:00",
        "updated_at": "2023-12-18T09:16:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "199e6c4b-2498-4d9f-bd4b-7467bb4afe2f",
        "planning_id": "5aa5afd7-03e4-4de9-af26-6bf276867e35",
        "order_id": "7a8d3920-fb5d-4990-8bdd-9aeef437eb81"
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
          "order_id": "5b4c15a3-b82e-4ac3-b627-c88893729bf2",
          "items": [
            {
              "type": "products",
              "id": "3caec987-20eb-43a6-a254-579203ebb5a9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4e575583-2e03-41d7-bcb1-09561c86cf17",
              "stock_item_ids": [
                "4197d397-46af-4be0-aa18-eb095076c695",
                "4520ee23-d7e5-466d-9615-2c5d828f399d"
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
          "stock_item_id 4197d397-46af-4be0-aa18-eb095076c695 has already been booked on this order"
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
          "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
          "items": [
            {
              "type": "bundles",
              "id": "2065b330-d6d9-4caf-9968-a7136c926855",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "66d879d6-f0c2-4f66-a195-e831c067c8ca",
                  "id": "9d3abfd1-0ffa-4502-ad6b-4f7ad1832327"
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
    "id": "14f9454b-0538-50f0-9673-c6f2509516f0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fa9afeaf-54d0-4b5f-b3f5-35c9445eac81"
          },
          {
            "type": "lines",
            "id": "fbaa4d0d-9dff-45ac-92f1-c7e79004ce01"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "57d6aa2f-f2d4-4d05-aea3-fc7945b902c9"
          },
          {
            "type": "plannings",
            "id": "5237c0f9-c4ee-4f19-8436-2a0ebe2eb04a"
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
      "id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-18T09:16:10+00:00",
        "updated_at": "2023-12-18T09:16:11+00:00",
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
        "starts_at": "2023-12-16T09:15:00+00:00",
        "stops_at": "2023-12-20T09:15:00+00:00",
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
        "start_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5",
        "stop_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5"
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
      "id": "fa9afeaf-54d0-4b5f-b3f5-35c9445eac81",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-18T09:16:11+00:00",
        "updated_at": "2023-12-18T09:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000029 - red",
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
        "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
        "item_id": "9d3abfd1-0ffa-4502-ad6b-4f7ad1832327",
        "tax_category_id": null,
        "planning_id": "5237c0f9-c4ee-4f19-8436-2a0ebe2eb04a",
        "parent_line_id": "fbaa4d0d-9dff-45ac-92f1-c7e79004ce01",
        "owner_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
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
      "id": "fbaa4d0d-9dff-45ac-92f1-c7e79004ce01",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-18T09:16:11+00:00",
        "updated_at": "2023-12-18T09:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 4",
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
        "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
        "item_id": "2065b330-d6d9-4caf-9968-a7136c926855",
        "tax_category_id": null,
        "planning_id": "57d6aa2f-f2d4-4d05-aea3-fc7945b902c9",
        "parent_line_id": null,
        "owner_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
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
      "id": "57d6aa2f-f2d4-4d05-aea3-fc7945b902c9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:11+00:00",
        "updated_at": "2023-12-18T09:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-16T09:15:00+00:00",
        "stops_at": "2023-12-20T09:15:00+00:00",
        "reserved_from": "2023-12-16T09:15:00+00:00",
        "reserved_till": "2023-12-20T09:15:00+00:00",
        "reserved": false,
        "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
        "item_id": "2065b330-d6d9-4caf-9968-a7136c926855",
        "start_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5",
        "stop_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5",
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
      "id": "5237c0f9-c4ee-4f19-8436-2a0ebe2eb04a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-18T09:16:11+00:00",
        "updated_at": "2023-12-18T09:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-16T09:15:00+00:00",
        "stops_at": "2023-12-20T09:15:00+00:00",
        "reserved_from": "2023-12-16T09:15:00+00:00",
        "reserved_till": "2023-12-20T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "de48d0ca-1ebd-4ca9-a7d0-900f4c829397",
        "item_id": "9d3abfd1-0ffa-4502-ad6b-4f7ad1832327",
        "start_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5",
        "stop_location_id": "6f682917-07a8-4c98-9474-90cf10d02cb5",
        "parent_planning_id": "57d6aa2f-f2d4-4d05-aea3-fc7945b902c9",
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





