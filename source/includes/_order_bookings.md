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
          "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
          "items": [
            {
              "type": "bundles",
              "id": "0e60fce6-0e8d-415b-9a0b-a86f18e67e4b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "cbd57ff0-de5d-4b21-88eb-b5ab0417f9e2",
                  "id": "ed1a7e98-8f97-4056-8a1c-7a56fa94fe5b"
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
    "id": "8278f719-2f78-5619-8f24-afdf2934977b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c8b3b808-d81c-4056-8ce1-7aec4f739702"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1c352fa8-8be6-4ce5-bec0-43a4fde4d65c"
          },
          {
            "type": "lines",
            "id": "cd675474-74e1-4fc7-9dec-104c320a1844"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ee8e9de3-72f8-4116-b9ae-032a8f9ba23a"
          },
          {
            "type": "plannings",
            "id": "9685d43a-17be-42e1-bc91-b4f3fec3cf4e"
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
      "id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-15T09:28:19+00:00",
        "updated_at": "2024-04-15T09:28:19+00:00",
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
        "starts_at": "2024-04-13T09:15:00+00:00",
        "stops_at": "2024-04-17T09:15:00+00:00",
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
        "start_location_id": "d2510019-8fdb-4106-890c-858f094ee64f",
        "stop_location_id": "d2510019-8fdb-4106-890c-858f094ee64f"
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
      "id": "1c352fa8-8be6-4ce5-bec0-43a4fde4d65c",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-15T09:28:19+00:00",
        "updated_at": "2024-04-15T09:28:20+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000072 - red",
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
        "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
        "item_id": "ed1a7e98-8f97-4056-8a1c-7a56fa94fe5b",
        "tax_category_id": null,
        "planning_id": "9685d43a-17be-42e1-bc91-b4f3fec3cf4e",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "cd675474-74e1-4fc7-9dec-104c320a1844",
        "owner_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
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
      "id": "cd675474-74e1-4fc7-9dec-104c320a1844",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-15T09:28:19+00:00",
        "updated_at": "2024-04-15T09:28:20+00:00",
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
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
        "item_id": "0e60fce6-0e8d-415b-9a0b-a86f18e67e4b",
        "tax_category_id": null,
        "planning_id": "ee8e9de3-72f8-4116-b9ae-032a8f9ba23a",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
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
      "id": "ee8e9de3-72f8-4116-b9ae-032a8f9ba23a",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:19+00:00",
        "updated_at": "2024-04-15T09:28:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-13T09:15:00+00:00",
        "stops_at": "2024-04-17T09:15:00+00:00",
        "reserved_from": "2024-04-13T09:15:00+00:00",
        "reserved_till": "2024-04-17T09:15:00+00:00",
        "reserved": false,
        "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
        "item_id": "0e60fce6-0e8d-415b-9a0b-a86f18e67e4b",
        "start_location_id": "d2510019-8fdb-4106-890c-858f094ee64f",
        "stop_location_id": "d2510019-8fdb-4106-890c-858f094ee64f",
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
      "id": "9685d43a-17be-42e1-bc91-b4f3fec3cf4e",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:19+00:00",
        "updated_at": "2024-04-15T09:28:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-13T09:15:00+00:00",
        "stops_at": "2024-04-17T09:15:00+00:00",
        "reserved_from": "2024-04-13T09:15:00+00:00",
        "reserved_till": "2024-04-17T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "c8b3b808-d81c-4056-8ce1-7aec4f739702",
        "item_id": "ed1a7e98-8f97-4056-8a1c-7a56fa94fe5b",
        "start_location_id": "d2510019-8fdb-4106-890c-858f094ee64f",
        "stop_location_id": "d2510019-8fdb-4106-890c-858f094ee64f",
        "parent_planning_id": "ee8e9de3-72f8-4116-b9ae-032a8f9ba23a",
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
          "order_id": "4efcca51-80c8-4832-910a-3b43bcc86717",
          "items": [
            {
              "type": "products",
              "id": "29d23a7c-2398-4f85-a3b8-e7bd98e28607",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5452d5ef-0045-494c-8957-897fc40ecfb2",
              "stock_item_ids": [
                "3878297f-ad79-4ad2-adf9-a16c1615abc1",
                "86a5f7cd-4766-402d-9107-4cc5a13d4df6"
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
          "stock_item_id 3878297f-ad79-4ad2-adf9-a16c1615abc1 has already been booked on this order"
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
          "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
          "items": [
            {
              "type": "products",
              "id": "77a26a8d-9c23-493b-a5be-eedaa244fe45",
              "stock_item_ids": [
                "dd60724b-a0f2-4aba-9311-76d98782f503",
                "c54047db-5c19-471d-81a6-775a6d20e5f5",
                "8be7a6d6-4930-4cb5-ad01-c05e0e15bee4"
              ]
            },
            {
              "type": "products",
              "id": "09024bff-b865-447b-a1fa-9d4638a15b25",
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
    "id": "d38cdae9-7eb6-54f8-ac19-e3fb22df8070",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8d2362e9-2850-4e48-b518-cad610790c5d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0892b51c-23c5-4d4b-ad55-6ad89a67ea8b"
          },
          {
            "type": "lines",
            "id": "fb905d95-2463-4992-9d52-89b30bf43363"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f6237d7f-a924-4b92-bca6-64bb2d278806"
          },
          {
            "type": "plannings",
            "id": "89575bcb-1be5-4c20-8d34-baf3bdea4edf"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0b079022-4aac-4398-8129-cefd2f8e226b"
          },
          {
            "type": "stock_item_plannings",
            "id": "88509327-5c14-4469-ab0e-a6b506296887"
          },
          {
            "type": "stock_item_plannings",
            "id": "8795cfc4-62b1-401b-a845-2619b2d3e67e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8d2362e9-2850-4e48-b518-cad610790c5d",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-15T09:28:26+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
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
        "customer_id": "1be57179-90ce-4924-a671-870c08781b5f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "14559406-de48-435f-95a1-541c9cc2acbf",
        "stop_location_id": "14559406-de48-435f-95a1-541c9cc2acbf"
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
      "id": "0892b51c-23c5-4d4b-ad55-6ad89a67ea8b",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
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
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
        "item_id": "77a26a8d-9c23-493b-a5be-eedaa244fe45",
        "tax_category_id": "85d52547-c4a2-4b5a-83bb-c6fcbd5e14c7",
        "planning_id": "f6237d7f-a924-4b92-bca6-64bb2d278806",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
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
      "id": "fb905d95-2463-4992-9d52-89b30bf43363",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
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
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
        "item_id": "09024bff-b865-447b-a1fa-9d4638a15b25",
        "tax_category_id": "85d52547-c4a2-4b5a-83bb-c6fcbd5e14c7",
        "planning_id": "89575bcb-1be5-4c20-8d34-baf3bdea4edf",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
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
      "id": "f6237d7f-a924-4b92-bca6-64bb2d278806",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
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
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
        "item_id": "77a26a8d-9c23-493b-a5be-eedaa244fe45",
        "start_location_id": "14559406-de48-435f-95a1-541c9cc2acbf",
        "stop_location_id": "14559406-de48-435f-95a1-541c9cc2acbf",
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
      "id": "89575bcb-1be5-4c20-8d34-baf3bdea4edf",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
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
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d",
        "item_id": "09024bff-b865-447b-a1fa-9d4638a15b25",
        "start_location_id": "14559406-de48-435f-95a1-541c9cc2acbf",
        "stop_location_id": "14559406-de48-435f-95a1-541c9cc2acbf",
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
      "id": "0b079022-4aac-4398-8129-cefd2f8e226b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dd60724b-a0f2-4aba-9311-76d98782f503",
        "planning_id": "f6237d7f-a924-4b92-bca6-64bb2d278806",
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d"
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
      "id": "88509327-5c14-4469-ab0e-a6b506296887",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c54047db-5c19-471d-81a6-775a6d20e5f5",
        "planning_id": "f6237d7f-a924-4b92-bca6-64bb2d278806",
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d"
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
      "id": "8795cfc4-62b1-401b-a845-2619b2d3e67e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-15T09:28:28+00:00",
        "updated_at": "2024-04-15T09:28:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8be7a6d6-4930-4cb5-ad01-c05e0e15bee4",
        "planning_id": "f6237d7f-a924-4b92-bca6-64bb2d278806",
        "order_id": "8d2362e9-2850-4e48-b518-cad610790c5d"
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





