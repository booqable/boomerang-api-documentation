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
          "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
          "items": [
            {
              "type": "products",
              "id": "dc2ce789-299f-4523-8348-04debc07cb23",
              "stock_item_ids": [
                "35924e3b-ee1d-464a-80a2-dda40022cea3",
                "fa0ec557-6c9d-488e-9fce-6ea966854832",
                "5d0f27ef-43dc-40e6-8ac5-2e4ae4209479"
              ]
            },
            {
              "type": "products",
              "id": "a8ded88f-22c8-4081-8355-016f471ab07c",
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
    "id": "3a528a72-b5c0-543d-8444-3043b1878b12",
    "type": "order_bookings",
    "attributes": {
      "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "eff6fa1d-c360-443c-96cc-0c79250492a7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ba54dd10-42d1-4727-834e-6a63fa84333f"
          },
          {
            "type": "lines",
            "id": "4bd3abc6-d0bf-4a66-b84f-975fae2cf50e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d"
          },
          {
            "type": "plannings",
            "id": "d6854dac-c09c-428d-b917-ac51e5e54e45"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a28a52aa-737f-4b3a-adcf-5bc6cd489b92"
          },
          {
            "type": "stock_item_plannings",
            "id": "ab0236ca-b080-4126-b297-d0ca3fbe91cb"
          },
          {
            "type": "stock_item_plannings",
            "id": "7bf82123-d558-4315-b1c6-6b0d98f044f1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-05T09:15:16+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
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
        "customer_id": "000934d3-e1b1-40bd-a426-30054ab18557",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "70398239-7542-40cc-b12a-6e459affdf67",
        "stop_location_id": "70398239-7542-40cc-b12a-6e459affdf67"
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
      "id": "ba54dd10-42d1-4727-834e-6a63fa84333f",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
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
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
        "item_id": "dc2ce789-299f-4523-8348-04debc07cb23",
        "tax_category_id": "4bd38338-4c33-4226-a911-92fe1bdb7f45",
        "planning_id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d",
        "parent_line_id": null,
        "owner_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
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
      "id": "4bd3abc6-d0bf-4a66-b84f-975fae2cf50e",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
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
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
        "item_id": "a8ded88f-22c8-4081-8355-016f471ab07c",
        "tax_category_id": "4bd38338-4c33-4226-a911-92fe1bdb7f45",
        "planning_id": "d6854dac-c09c-428d-b917-ac51e5e54e45",
        "parent_line_id": null,
        "owner_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
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
      "id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
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
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
        "item_id": "dc2ce789-299f-4523-8348-04debc07cb23",
        "start_location_id": "70398239-7542-40cc-b12a-6e459affdf67",
        "stop_location_id": "70398239-7542-40cc-b12a-6e459affdf67",
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
      "id": "d6854dac-c09c-428d-b917-ac51e5e54e45",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
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
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7",
        "item_id": "a8ded88f-22c8-4081-8355-016f471ab07c",
        "start_location_id": "70398239-7542-40cc-b12a-6e459affdf67",
        "stop_location_id": "70398239-7542-40cc-b12a-6e459affdf67",
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
      "id": "a28a52aa-737f-4b3a-adcf-5bc6cd489b92",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "35924e3b-ee1d-464a-80a2-dda40022cea3",
        "planning_id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d",
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7"
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
      "id": "ab0236ca-b080-4126-b297-d0ca3fbe91cb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fa0ec557-6c9d-488e-9fce-6ea966854832",
        "planning_id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d",
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7"
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
      "id": "7bf82123-d558-4315-b1c6-6b0d98f044f1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:19+00:00",
        "updated_at": "2024-02-05T09:15:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5d0f27ef-43dc-40e6-8ac5-2e4ae4209479",
        "planning_id": "f76f28f0-0a4c-4eaf-965f-1c272e3c671d",
        "order_id": "eff6fa1d-c360-443c-96cc-0c79250492a7"
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
          "order_id": "3a4d5cb3-9b7b-400a-83c8-a6490130acb0",
          "items": [
            {
              "type": "products",
              "id": "73093510-9294-46c4-9aa8-217fea1d96a7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7ea1b21a-deca-42ba-ab57-e985c68dc0cc",
              "stock_item_ids": [
                "90838963-52dc-4fb6-aa8f-d85c06e45452",
                "e1548159-9137-4aec-9924-cccc58421769"
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
          "stock_item_id 90838963-52dc-4fb6-aa8f-d85c06e45452 has already been booked on this order"
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
          "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
          "items": [
            {
              "type": "bundles",
              "id": "be2f17a2-b764-4f60-8050-298b415924a8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d0347287-681f-4352-8bed-598451bb9e62",
                  "id": "bc14a90e-f862-47da-960e-ff2be356a636"
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
    "id": "14ec66e4-b804-5f10-b37a-5eb3066ddf7f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c40c1794-d2ba-475e-afd1-8b8a280f234d"
          },
          {
            "type": "lines",
            "id": "d47d0686-0211-40a6-bff6-0b800125c91d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "39d683c1-5871-4b9a-ad60-b5910ceb4b40"
          },
          {
            "type": "plannings",
            "id": "d3d2d991-e868-4daa-978f-91e55f0cc77f"
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
      "id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-05T09:15:25+00:00",
        "updated_at": "2024-02-05T09:15:25+00:00",
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
        "starts_at": "2024-02-03T09:15:00+00:00",
        "stops_at": "2024-02-07T09:15:00+00:00",
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
        "start_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf",
        "stop_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf"
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
      "id": "c40c1794-d2ba-475e-afd1-8b8a280f234d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-05T09:15:25+00:00",
        "updated_at": "2024-02-05T09:15:25+00:00",
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
        "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
        "item_id": "be2f17a2-b764-4f60-8050-298b415924a8",
        "tax_category_id": null,
        "planning_id": "39d683c1-5871-4b9a-ad60-b5910ceb4b40",
        "parent_line_id": null,
        "owner_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
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
      "id": "d47d0686-0211-40a6-bff6-0b800125c91d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-05T09:15:25+00:00",
        "updated_at": "2024-02-05T09:15:25+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000021 - red",
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
        "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
        "item_id": "bc14a90e-f862-47da-960e-ff2be356a636",
        "tax_category_id": null,
        "planning_id": "d3d2d991-e868-4daa-978f-91e55f0cc77f",
        "parent_line_id": "c40c1794-d2ba-475e-afd1-8b8a280f234d",
        "owner_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
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
      "id": "39d683c1-5871-4b9a-ad60-b5910ceb4b40",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:25+00:00",
        "updated_at": "2024-02-05T09:15:25+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-03T09:15:00+00:00",
        "stops_at": "2024-02-07T09:15:00+00:00",
        "reserved_from": "2024-02-03T09:15:00+00:00",
        "reserved_till": "2024-02-07T09:15:00+00:00",
        "reserved": false,
        "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
        "item_id": "be2f17a2-b764-4f60-8050-298b415924a8",
        "start_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf",
        "stop_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf",
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
      "id": "d3d2d991-e868-4daa-978f-91e55f0cc77f",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-05T09:15:25+00:00",
        "updated_at": "2024-02-05T09:15:25+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-03T09:15:00+00:00",
        "stops_at": "2024-02-07T09:15:00+00:00",
        "reserved_from": "2024-02-03T09:15:00+00:00",
        "reserved_till": "2024-02-07T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "6d3ca5d4-2ea8-498d-8e5c-e42afaf5c1fb",
        "item_id": "bc14a90e-f862-47da-960e-ff2be356a636",
        "start_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf",
        "stop_location_id": "e3da7e2a-b677-487a-aa5b-f50dee3c60cf",
        "parent_planning_id": "39d683c1-5871-4b9a-ad60-b5910ceb4b40",
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





