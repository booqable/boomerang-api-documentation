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
          "order_id": "88411be1-7e89-4d98-b76b-379434b30e99",
          "items": [
            {
              "type": "products",
              "id": "3706d47c-4d0e-4a7c-a5f6-f31fe8905bc5",
              "stock_item_ids": [
                "a75c5906-8b2e-45c6-8835-53cd4ca23de3",
                "4234021f-c1da-4021-b340-712f76bf0fc4",
                "b688f481-eed6-4c22-8e87-3e7efda75171"
              ]
            },
            {
              "type": "products",
              "id": "1bfe4c79-949a-48c4-b219-3110c4c59370",
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
    "id": "b032dc87-14c2-5cfd-8972-0de35b0d20ab",
    "type": "order_bookings",
    "attributes": {
      "order_id": "88411be1-7e89-4d98-b76b-379434b30e99"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "88411be1-7e89-4d98-b76b-379434b30e99"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "60615158-1877-48c5-9333-7110c4c766d9"
          },
          {
            "type": "lines",
            "id": "2be9bb1c-7001-4f6d-bccd-4d07bfca5ac1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "47407f0c-be9b-4dd6-85d5-300a96761a92"
          },
          {
            "type": "plannings",
            "id": "b3dc4fc1-025c-412b-ab7d-7e4e556df950"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "bdcc5ed2-e3a7-4017-b362-5e16959ea6bb"
          },
          {
            "type": "stock_item_plannings",
            "id": "b5491be3-d6ac-4b2f-88b7-6469f219ce55"
          },
          {
            "type": "stock_item_plannings",
            "id": "d3a5cdfe-7736-4ec3-9b57-64c364634875"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "88411be1-7e89-4d98-b76b-379434b30e99",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-29T09:30:58+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
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
        "customer_id": "c48767ff-a218-4152-a260-783c2c3fe4ef",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456",
        "stop_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456"
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
      "id": "60615158-1877-48c5-9333-7110c4c766d9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
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
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99",
        "item_id": "3706d47c-4d0e-4a7c-a5f6-f31fe8905bc5",
        "tax_category_id": "94b291a0-f07c-456d-a84d-a8746e077777",
        "planning_id": "47407f0c-be9b-4dd6-85d5-300a96761a92",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "88411be1-7e89-4d98-b76b-379434b30e99",
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
      "id": "2be9bb1c-7001-4f6d-bccd-4d07bfca5ac1",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
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
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99",
        "item_id": "1bfe4c79-949a-48c4-b219-3110c4c59370",
        "tax_category_id": "94b291a0-f07c-456d-a84d-a8746e077777",
        "planning_id": "b3dc4fc1-025c-412b-ab7d-7e4e556df950",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "88411be1-7e89-4d98-b76b-379434b30e99",
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
      "id": "47407f0c-be9b-4dd6-85d5-300a96761a92",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
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
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99",
        "item_id": "3706d47c-4d0e-4a7c-a5f6-f31fe8905bc5",
        "start_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456",
        "stop_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456",
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
      "id": "b3dc4fc1-025c-412b-ab7d-7e4e556df950",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
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
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99",
        "item_id": "1bfe4c79-949a-48c4-b219-3110c4c59370",
        "start_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456",
        "stop_location_id": "a24671f2-e9f7-4c62-ae31-9af3be2df456",
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
      "id": "bdcc5ed2-e3a7-4017-b362-5e16959ea6bb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a75c5906-8b2e-45c6-8835-53cd4ca23de3",
        "planning_id": "47407f0c-be9b-4dd6-85d5-300a96761a92",
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99"
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
      "id": "b5491be3-d6ac-4b2f-88b7-6469f219ce55",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4234021f-c1da-4021-b340-712f76bf0fc4",
        "planning_id": "47407f0c-be9b-4dd6-85d5-300a96761a92",
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99"
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
      "id": "d3a5cdfe-7736-4ec3-9b57-64c364634875",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:01+00:00",
        "updated_at": "2024-04-29T09:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b688f481-eed6-4c22-8e87-3e7efda75171",
        "planning_id": "47407f0c-be9b-4dd6-85d5-300a96761a92",
        "order_id": "88411be1-7e89-4d98-b76b-379434b30e99"
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
          "order_id": "761b15ac-18ad-4099-a63f-9caba4745ba3",
          "items": [
            {
              "type": "products",
              "id": "ac9aa2cb-92f3-4ea9-a5b2-0880b527d098",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3d0037a4-fef9-4044-954a-4d7506381547",
              "stock_item_ids": [
                "213e5d6b-b3cd-494d-a2ef-53b1a5475165",
                "19655734-65b6-4984-93cf-1a39ff64b9f9"
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
          "stock_item_id 213e5d6b-b3cd-494d-a2ef-53b1a5475165 has already been booked on this order"
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
          "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
          "items": [
            {
              "type": "bundles",
              "id": "aaceed13-acb4-4cc7-88a8-004a3e4eade7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c9adaf1c-6be8-45eb-a228-48c3647aa8d6",
                  "id": "f626c63a-5c4f-4394-b25c-d6bd8e6c4001"
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
    "id": "e593d757-4729-525a-91ad-eb990b95be08",
    "type": "order_bookings",
    "attributes": {
      "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "75e728d3-bbc5-48e6-828f-ea0010240187"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "acf0811b-c5f9-4ebd-b62c-1453351652e3"
          },
          {
            "type": "lines",
            "id": "3d769ff1-daa6-4882-b547-17e428edbe38"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6116fa7a-0248-4ea3-8ba8-4ffd53f94276"
          },
          {
            "type": "plannings",
            "id": "af3acbb2-924e-4418-aac0-4a76693099a6"
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
      "id": "75e728d3-bbc5-48e6-828f-ea0010240187",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-29T09:31:10+00:00",
        "updated_at": "2024-04-29T09:31:11+00:00",
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
        "starts_at": "2024-04-27T09:30:00+00:00",
        "stops_at": "2024-05-01T09:30:00+00:00",
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
        "start_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f",
        "stop_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f"
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
      "id": "acf0811b-c5f9-4ebd-b62c-1453351652e3",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-29T09:31:11+00:00",
        "updated_at": "2024-04-29T09:31:11+00:00",
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
        "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
        "item_id": "aaceed13-acb4-4cc7-88a8-004a3e4eade7",
        "tax_category_id": null,
        "planning_id": "6116fa7a-0248-4ea3-8ba8-4ffd53f94276",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
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
      "id": "3d769ff1-daa6-4882-b547-17e428edbe38",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-29T09:31:11+00:00",
        "updated_at": "2024-04-29T09:31:11+00:00",
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
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
        "item_id": "f626c63a-5c4f-4394-b25c-d6bd8e6c4001",
        "tax_category_id": null,
        "planning_id": "af3acbb2-924e-4418-aac0-4a76693099a6",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "acf0811b-c5f9-4ebd-b62c-1453351652e3",
        "owner_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
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
      "id": "6116fa7a-0248-4ea3-8ba8-4ffd53f94276",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:11+00:00",
        "updated_at": "2024-04-29T09:31:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-27T09:30:00+00:00",
        "stops_at": "2024-05-01T09:30:00+00:00",
        "reserved_from": "2024-04-27T09:30:00+00:00",
        "reserved_till": "2024-05-01T09:30:00+00:00",
        "reserved": false,
        "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
        "item_id": "aaceed13-acb4-4cc7-88a8-004a3e4eade7",
        "start_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f",
        "stop_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f",
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
      "id": "af3acbb2-924e-4418-aac0-4a76693099a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-29T09:31:11+00:00",
        "updated_at": "2024-04-29T09:31:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-27T09:30:00+00:00",
        "stops_at": "2024-05-01T09:30:00+00:00",
        "reserved_from": "2024-04-27T09:30:00+00:00",
        "reserved_till": "2024-05-01T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "75e728d3-bbc5-48e6-828f-ea0010240187",
        "item_id": "f626c63a-5c4f-4394-b25c-d6bd8e6c4001",
        "start_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f",
        "stop_location_id": "5d0f7540-9a0d-476f-9fd0-ce0bd9ec3d2f",
        "parent_planning_id": "6116fa7a-0248-4ea3-8ba8-4ffd53f94276",
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





