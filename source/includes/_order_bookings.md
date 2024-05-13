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
          "order_id": "c02fc702-86ca-4b2d-bf65-9aa37da53449",
          "items": [
            {
              "type": "products",
              "id": "59dd1d6b-b757-493f-b6b5-900b02f7a991",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5528a88b-6167-44da-bd5f-802e4b0dfb46",
              "stock_item_ids": [
                "1a13fffb-ccf8-4fd3-9eb8-afa8fc7ba0f0",
                "fe36717a-2c9c-4f87-bf27-fc762f4922f8"
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
          "stock_item_id 1a13fffb-ccf8-4fd3-9eb8-afa8fc7ba0f0 has already been booked on this order"
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
          "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
          "items": [
            {
              "type": "products",
              "id": "5e836fdf-9567-4ba9-9aab-db011cc0fbe3",
              "stock_item_ids": [
                "29040d47-8a22-4ef1-a629-8f215f1d415a",
                "dcc046c8-b275-4fdb-8dd2-5395f0d7f513",
                "0a6ae958-1c94-4cec-9782-e3a19e5ca008"
              ]
            },
            {
              "type": "products",
              "id": "27e3d288-2997-4c44-9120-4cef4e72e123",
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
    "id": "6efa677c-5e0b-5646-be20-7cb4c53f9ec1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "831b6c46-d466-4d73-973d-ed684c00dda3"
          },
          {
            "type": "lines",
            "id": "045ff74c-8f05-47af-a4b5-c35920c66766"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83"
          },
          {
            "type": "plannings",
            "id": "16046209-bb73-46d3-9272-e7c8fb956591"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a918ca3b-5454-4084-a457-81a10e90411f"
          },
          {
            "type": "stock_item_plannings",
            "id": "2e50f6bb-a28c-4c13-a8cf-b08a33f741fc"
          },
          {
            "type": "stock_item_plannings",
            "id": "9eb48697-b5be-471b-b367-da2f6b9403c1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-13T09:28:24+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
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
        "customer_id": "b5c6388c-3858-4fdb-8bf1-115922cf81b7",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87",
        "stop_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87"
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
      "id": "831b6c46-d466-4d73-973d-ed684c00dda3",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
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
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
        "item_id": "5e836fdf-9567-4ba9-9aab-db011cc0fbe3",
        "tax_category_id": "880f766b-94ae-41f5-8515-922b42bf4c37",
        "planning_id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
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
      "id": "045ff74c-8f05-47af-a4b5-c35920c66766",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
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
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
        "item_id": "27e3d288-2997-4c44-9120-4cef4e72e123",
        "tax_category_id": "880f766b-94ae-41f5-8515-922b42bf4c37",
        "planning_id": "16046209-bb73-46d3-9272-e7c8fb956591",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
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
      "id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
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
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
        "item_id": "5e836fdf-9567-4ba9-9aab-db011cc0fbe3",
        "start_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87",
        "stop_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87",
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
      "id": "16046209-bb73-46d3-9272-e7c8fb956591",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
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
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f",
        "item_id": "27e3d288-2997-4c44-9120-4cef4e72e123",
        "start_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87",
        "stop_location_id": "b97975f3-397b-4fcb-9f3e-ce3ccbc39f87",
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
      "id": "a918ca3b-5454-4084-a457-81a10e90411f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "29040d47-8a22-4ef1-a629-8f215f1d415a",
        "planning_id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83",
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f"
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
      "id": "2e50f6bb-a28c-4c13-a8cf-b08a33f741fc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dcc046c8-b275-4fdb-8dd2-5395f0d7f513",
        "planning_id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83",
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f"
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
      "id": "9eb48697-b5be-471b-b367-da2f6b9403c1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:28+00:00",
        "updated_at": "2024-05-13T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0a6ae958-1c94-4cec-9782-e3a19e5ca008",
        "planning_id": "77a2ec58-91a0-4265-8ac4-cc2d4c49fe83",
        "order_id": "be5b47ad-adaa-4241-a341-1ee9c7f1741f"
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
          "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
          "items": [
            {
              "type": "bundles",
              "id": "d63dcc01-81a8-4290-b62b-73c02e323815",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2bd1796e-b981-4980-bc4a-cca81dde409a",
                  "id": "ba8fcc4b-9693-4d9a-8f93-87fca9975309"
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
    "id": "15040d42-b87e-5b1a-97fe-e3c3de326960",
    "type": "order_bookings",
    "attributes": {
      "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "68e35f9d-67f7-44f3-b098-23356e1d3793"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6c81befc-3447-49ee-8fa1-e0baf0918a5f"
          },
          {
            "type": "lines",
            "id": "36589617-69bd-4e27-bfb4-a4dfaa16a0e1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6bb4a32a-6e9b-4b27-a54f-0e8075bf468f"
          },
          {
            "type": "plannings",
            "id": "421dee38-a8d1-4d73-a5c1-375c0c9aa279"
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
      "id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-13T09:28:34+00:00",
        "updated_at": "2024-05-13T09:28:34+00:00",
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
        "starts_at": "2024-05-11T09:15:00+00:00",
        "stops_at": "2024-05-15T09:15:00+00:00",
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
        "start_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366",
        "stop_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366"
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
      "id": "6c81befc-3447-49ee-8fa1-e0baf0918a5f",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-13T09:28:35+00:00",
        "updated_at": "2024-05-13T09:28:35+00:00",
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
        "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
        "item_id": "d63dcc01-81a8-4290-b62b-73c02e323815",
        "tax_category_id": null,
        "planning_id": "6bb4a32a-6e9b-4b27-a54f-0e8075bf468f",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
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
      "id": "36589617-69bd-4e27-bfb4-a4dfaa16a0e1",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-13T09:28:35+00:00",
        "updated_at": "2024-05-13T09:28:35+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000067 - red",
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
        "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
        "item_id": "ba8fcc4b-9693-4d9a-8f93-87fca9975309",
        "tax_category_id": null,
        "planning_id": "421dee38-a8d1-4d73-a5c1-375c0c9aa279",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "6c81befc-3447-49ee-8fa1-e0baf0918a5f",
        "owner_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
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
      "id": "6bb4a32a-6e9b-4b27-a54f-0e8075bf468f",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:34+00:00",
        "updated_at": "2024-05-13T09:28:34+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-11T09:15:00+00:00",
        "stops_at": "2024-05-15T09:15:00+00:00",
        "reserved_from": "2024-05-11T09:15:00+00:00",
        "reserved_till": "2024-05-15T09:15:00+00:00",
        "reserved": false,
        "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
        "item_id": "d63dcc01-81a8-4290-b62b-73c02e323815",
        "start_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366",
        "stop_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366",
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
      "id": "421dee38-a8d1-4d73-a5c1-375c0c9aa279",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-13T09:28:34+00:00",
        "updated_at": "2024-05-13T09:28:34+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-11T09:15:00+00:00",
        "stops_at": "2024-05-15T09:15:00+00:00",
        "reserved_from": "2024-05-11T09:15:00+00:00",
        "reserved_till": "2024-05-15T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "68e35f9d-67f7-44f3-b098-23356e1d3793",
        "item_id": "ba8fcc4b-9693-4d9a-8f93-87fca9975309",
        "start_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366",
        "stop_location_id": "bbbbbf40-faac-484f-8df8-36a3fdba6366",
        "parent_planning_id": "6bb4a32a-6e9b-4b27-a54f-0e8075bf468f",
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





