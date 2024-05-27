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
          "order_id": "65ffcd28-5bed-47ee-92ba-7ba7d6d7816c",
          "items": [
            {
              "type": "products",
              "id": "2e711048-eb6f-4b8f-9c24-65ba61bb733a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "065a5005-75b9-4d4e-bcb8-9475d837a07f",
              "stock_item_ids": [
                "ea0ae4c6-3556-4e7a-a324-93e909efeae2",
                "811cfa08-0719-4d1a-b29a-6e6140d61c13"
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
          "stock_item_id ea0ae4c6-3556-4e7a-a324-93e909efeae2 has already been booked on this order"
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
          "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
          "items": [
            {
              "type": "bundles",
              "id": "a993dcfa-016a-4469-a7e0-7ac678b41327",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "09042fe0-a5b8-494e-9577-2c136433d1f9",
                  "id": "11acce08-eb83-4e4c-b860-98526b40fc82"
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
    "id": "86aa40af-257d-517a-9ffc-a6795f3cfe04",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9f96db80-27f2-488e-9793-395db7d0eff4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b5ab4b73-eac6-4533-9345-35812d475881"
          },
          {
            "type": "lines",
            "id": "41ad84b6-a086-4ae1-b221-52a5218da0e9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9a7b9535-1a6e-49a3-b4e7-63ac42cc12de"
          },
          {
            "type": "plannings",
            "id": "f46d9807-3131-423d-a9a7-bcfb9a48c1c0"
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
      "id": "9f96db80-27f2-488e-9793-395db7d0eff4",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-27T09:26:24.346170+00:00",
        "updated_at": "2024-05-27T09:26:24.833464+00:00",
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
        "starts_at": "2024-05-25T09:15:00.000000+00:00",
        "stops_at": "2024-05-29T09:15:00.000000+00:00",
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
        "start_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532",
        "stop_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532"
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
      "id": "b5ab4b73-eac6-4533-9345-35812d475881",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-27T09:26:24.890950+00:00",
        "updated_at": "2024-05-27T09:26:24.963474+00:00",
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
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
        "item_id": "a993dcfa-016a-4469-a7e0-7ac678b41327",
        "tax_category_id": null,
        "planning_id": "9a7b9535-1a6e-49a3-b4e7-63ac42cc12de",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
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
      "id": "41ad84b6-a086-4ae1-b221-52a5218da0e9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-27T09:26:24.898087+00:00",
        "updated_at": "2024-05-27T09:26:24.963474+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000054 - red",
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
        "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
        "item_id": "11acce08-eb83-4e4c-b860-98526b40fc82",
        "tax_category_id": null,
        "planning_id": "f46d9807-3131-423d-a9a7-bcfb9a48c1c0",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "b5ab4b73-eac6-4533-9345-35812d475881",
        "owner_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
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
      "id": "9a7b9535-1a6e-49a3-b4e7-63ac42cc12de",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:24.812390+00:00",
        "updated_at": "2024-05-27T09:26:24.812390+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-25T09:15:00.000000+00:00",
        "stops_at": "2024-05-29T09:15:00.000000+00:00",
        "reserved_from": "2024-05-25T09:15:00.000000+00:00",
        "reserved_till": "2024-05-29T09:15:00.000000+00:00",
        "reserved": false,
        "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
        "item_id": "a993dcfa-016a-4469-a7e0-7ac678b41327",
        "start_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532",
        "stop_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532",
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
      "id": "f46d9807-3131-423d-a9a7-bcfb9a48c1c0",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:24.812390+00:00",
        "updated_at": "2024-05-27T09:26:24.812390+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-25T09:15:00.000000+00:00",
        "stops_at": "2024-05-29T09:15:00.000000+00:00",
        "reserved_from": "2024-05-25T09:15:00.000000+00:00",
        "reserved_till": "2024-05-29T09:15:00.000000+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "9f96db80-27f2-488e-9793-395db7d0eff4",
        "item_id": "11acce08-eb83-4e4c-b860-98526b40fc82",
        "start_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532",
        "stop_location_id": "d3c7bdec-c850-4f91-9403-07e85b402532",
        "parent_planning_id": "9a7b9535-1a6e-49a3-b4e7-63ac42cc12de",
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
          "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
          "items": [
            {
              "type": "products",
              "id": "cd8276b9-38b3-4629-9fc9-bb25e72dc62e",
              "stock_item_ids": [
                "f9895847-d9c1-4e9a-b134-a8149364ec6d",
                "5a210eeb-c69a-420e-95a0-d8487b5e13e3",
                "c4d8dfcd-7af1-4549-9054-ee58e1d7aeeb"
              ]
            },
            {
              "type": "products",
              "id": "18369a59-6e50-4287-a86f-2f0cf0e0621e",
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
    "id": "8ac08399-9a22-525e-acd4-8bd5fa228277",
    "type": "order_bookings",
    "attributes": {
      "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d4844c93-f9bf-45fd-8bec-2b8a5e008378"
          },
          {
            "type": "lines",
            "id": "084e6dee-024c-401a-9e06-7fc19d80289f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6"
          },
          {
            "type": "plannings",
            "id": "9c2a563c-b607-4401-a188-eb33c40e5c48"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3f71b238-f0af-4bf2-9173-f77c732575fb"
          },
          {
            "type": "stock_item_plannings",
            "id": "976aa043-7d12-4b2e-8206-f3460747bda6"
          },
          {
            "type": "stock_item_plannings",
            "id": "7fef8c8f-fbaf-4925-b9d7-4eb6d3103ca6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-27T09:26:26.431747+00:00",
        "updated_at": "2024-05-27T09:26:29.275683+00:00",
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
        "customer_id": "42781905-39b5-4b51-8c5c-d583b180ff76",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f",
        "stop_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f"
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
      "id": "d4844c93-f9bf-45fd-8bec-2b8a5e008378",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-27T09:26:29.079153+00:00",
        "updated_at": "2024-05-27T09:26:29.325738+00:00",
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
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
        "item_id": "cd8276b9-38b3-4629-9fc9-bb25e72dc62e",
        "tax_category_id": "89c3d10d-467b-48f6-8578-839c87f4c900",
        "planning_id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
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
      "id": "084e6dee-024c-401a-9e06-7fc19d80289f",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-27T09:26:29.079153+00:00",
        "updated_at": "2024-05-27T09:26:29.325738+00:00",
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
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
        "item_id": "18369a59-6e50-4287-a86f-2f0cf0e0621e",
        "tax_category_id": "89c3d10d-467b-48f6-8578-839c87f4c900",
        "planning_id": "9c2a563c-b607-4401-a188-eb33c40e5c48",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
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
      "id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:28.949856+00:00",
        "updated_at": "2024-05-27T09:26:28.949856+00:00",
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
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
        "item_id": "cd8276b9-38b3-4629-9fc9-bb25e72dc62e",
        "start_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f",
        "stop_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f",
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
      "id": "9c2a563c-b607-4401-a188-eb33c40e5c48",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:28.949856+00:00",
        "updated_at": "2024-05-27T09:26:28.949856+00:00",
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
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a",
        "item_id": "18369a59-6e50-4287-a86f-2f0cf0e0621e",
        "start_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f",
        "stop_location_id": "7355c3a4-42b2-45c2-add5-dc408ca0496f",
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
      "id": "3f71b238-f0af-4bf2-9173-f77c732575fb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:28.973615+00:00",
        "updated_at": "2024-05-27T09:26:28.973615+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f9895847-d9c1-4e9a-b134-a8149364ec6d",
        "planning_id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6",
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a"
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
      "id": "976aa043-7d12-4b2e-8206-f3460747bda6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:28.973615+00:00",
        "updated_at": "2024-05-27T09:26:28.973615+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5a210eeb-c69a-420e-95a0-d8487b5e13e3",
        "planning_id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6",
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a"
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
      "id": "7fef8c8f-fbaf-4925-b9d7-4eb6d3103ca6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-27T09:26:28.973615+00:00",
        "updated_at": "2024-05-27T09:26:28.973615+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c4d8dfcd-7af1-4549-9054-ee58e1d7aeeb",
        "planning_id": "4d84f3da-6ea2-4915-acee-d7e8612b2ba6",
        "order_id": "daa400c0-1836-4d09-a5f3-bbb9ae863d6a"
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





