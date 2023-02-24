# Order bookings

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

> Adding a bundle:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
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
- | -
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
- | -
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
          "order_id": "5df3678d-dab1-4d57-a76f-4f62e29abd35",
          "items": [
            {
              "type": "products",
              "id": "eacbfc05-7f18-42cb-8cce-727254f2a72a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3e096e87-c5da-4a69-a3ab-3ed24dbee850",
              "stock_item_ids": [
                "05c57f00-2bd2-4c53-bfad-883d75d54d0e",
                "58bcf80a-1e18-42bf-8cba-41c4eaf61bdd"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 05c57f00-2bd2-4c53-bfad-883d75d54d0e has already been booked on this order"
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
          "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
          "items": [
            {
              "type": "products",
              "id": "06521d0d-4fa7-4785-a64c-ccda1f458f42",
              "stock_item_ids": [
                "bf301db8-f2b4-4320-b788-07586bafc520",
                "5b889d97-b2a5-4e23-95cf-94842cc08497",
                "37a5b4f8-27f5-46c9-aca9-d241dd6f7425"
              ]
            },
            {
              "type": "products",
              "id": "1412d1c7-d55d-4ab6-8545-503ccf93268e",
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
    "id": "56a8ba3b-39d2-59ee-9d9e-95b2096c42f9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fbc126bc-e537-44c9-8911-c14ebf1e720a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4b0e1d98-810d-4f4f-ac77-cc85e11091e7"
          },
          {
            "type": "lines",
            "id": "24a20236-e8be-4c68-91de-97aabab7b70d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "275c1bc7-77d8-4203-b60c-e7a271212a9e"
          },
          {
            "type": "plannings",
            "id": "1cbad823-4fb4-4f9b-ac8f-e0fb25c36afa"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "94e04adb-e6b8-4276-b06b-17b3364b06eb"
          },
          {
            "type": "stock_item_plannings",
            "id": "823255fd-a3ad-42df-8930-be42733398bf"
          },
          {
            "type": "stock_item_plannings",
            "id": "e663e339-f1c0-4904-a363-9ed51bdf3ad8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T08:43:59+00:00",
        "updated_at": "2023-02-24T08:44:02+00:00",
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
        "deposit_value": 10,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
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
        "discount_percentage": 10.0,
        "customer_id": "a6e0c26d-d5de-46f1-852a-9ba59e74e40a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b",
        "stop_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b"
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
      "id": "4b0e1d98-810d-4f4f-ac77-cc85e11091e7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z"
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "06521d0d-4fa7-4785-a64c-ccda1f458f42",
        "tax_category_id": "7bb1bc1b-7cae-4c94-8245-e8046ba1d52c",
        "planning_id": "275c1bc7-77d8-4203-b60c-e7a271212a9e",
        "parent_line_id": null,
        "owner_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
        "owner_type": "orders"
      },
      "relationships": {
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
      "id": "24a20236-e8be-4c68-91de-97aabab7b70d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z"
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "1412d1c7-d55d-4ab6-8545-503ccf93268e",
        "tax_category_id": "7bb1bc1b-7cae-4c94-8245-e8046ba1d52c",
        "planning_id": "1cbad823-4fb4-4f9b-ac8f-e0fb25c36afa",
        "parent_line_id": null,
        "owner_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
        "owner_type": "orders"
      },
      "relationships": {
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
      "id": "275c1bc7-77d8-4203-b60c-e7a271212a9e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
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
        "item_id": "06521d0d-4fa7-4785-a64c-ccda1f458f42",
        "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
        "start_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b",
        "stop_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
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
        }
      }
    },
    {
      "id": "1cbad823-4fb4-4f9b-ac8f-e0fb25c36afa",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
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
        "item_id": "1412d1c7-d55d-4ab6-8545-503ccf93268e",
        "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a",
        "start_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b",
        "stop_location_id": "db849d0a-cf50-4288-8e9f-74cebf624d3b",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
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
        }
      }
    },
    {
      "id": "94e04adb-e6b8-4276-b06b-17b3364b06eb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bf301db8-f2b4-4320-b788-07586bafc520",
        "planning_id": "275c1bc7-77d8-4203-b60c-e7a271212a9e",
        "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a"
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
      "id": "823255fd-a3ad-42df-8930-be42733398bf",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5b889d97-b2a5-4e23-95cf-94842cc08497",
        "planning_id": "275c1bc7-77d8-4203-b60c-e7a271212a9e",
        "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a"
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
      "id": "e663e339-f1c0-4904-a363-9ed51bdf3ad8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:01+00:00",
        "updated_at": "2023-02-24T08:44:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "37a5b4f8-27f5-46c9-aca9-d241dd6f7425",
        "planning_id": "275c1bc7-77d8-4203-b60c-e7a271212a9e",
        "order_id": "fbc126bc-e537-44c9-8911-c14ebf1e720a"
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
          "order_id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe",
          "items": [
            {
              "type": "bundles",
              "id": "52cd0246-0ebc-4ee6-9d64-4254f21315f9",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9b408ba8-51f9-4af4-b6d9-1d3198883df2",
                  "id": "85cfdfdc-9b73-40dc-99bc-d103325c599a"
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
    "id": "b97e8604-e9cc-5b6f-b660-8b1ac83cc901",
    "type": "order_bookings",
    "attributes": {
      "order_id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7c2a1f0a-6b8d-4609-b68d-35335d326e53"
          },
          {
            "type": "lines",
            "id": "1a8a198d-e246-4ba9-92bf-5119c540129a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0d0e94cb-c720-4781-9a51-b32e3655aeae"
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
      "id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T08:44:04+00:00",
        "updated_at": "2023-02-24T08:44:05+00:00",
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
        "starts_at": "2023-02-22T08:30:00+00:00",
        "stops_at": "2023-02-26T08:30:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
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
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cdc337d8-c294-4254-a15b-8593ca129f93",
        "stop_location_id": "cdc337d8-c294-4254-a15b-8593ca129f93"
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
      "id": "7c2a1f0a-6b8d-4609-b68d-35335d326e53",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:44:04+00:00",
        "updated_at": "2023-02-24T08:44:04+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
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
        "item_id": "52cd0246-0ebc-4ee6-9d64-4254f21315f9",
        "tax_category_id": null,
        "planning_id": "0d0e94cb-c720-4781-9a51-b32e3655aeae",
        "parent_line_id": null,
        "owner_id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe",
        "owner_type": "orders"
      },
      "relationships": {
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
      "id": "1a8a198d-e246-4ba9-92bf-5119c540129a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T08:44:04+00:00",
        "updated_at": "2023-02-24T08:44:04+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 13 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
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
        "item_id": "85cfdfdc-9b73-40dc-99bc-d103325c599a",
        "tax_category_id": null,
        "planning_id": "fd677df2-47cc-4731-a697-5c7ee4fd5800",
        "parent_line_id": "7c2a1f0a-6b8d-4609-b68d-35335d326e53",
        "owner_id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe",
        "owner_type": "orders"
      },
      "relationships": {
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
      "id": "0d0e94cb-c720-4781-9a51-b32e3655aeae",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T08:44:04+00:00",
        "updated_at": "2023-02-24T08:44:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T08:30:00+00:00",
        "stops_at": "2023-02-26T08:30:00+00:00",
        "reserved_from": "2023-02-22T08:30:00+00:00",
        "reserved_till": "2023-02-26T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "52cd0246-0ebc-4ee6-9d64-4254f21315f9",
        "order_id": "58bbfa7c-f97b-4d13-b0ed-472de4ba23fe",
        "start_location_id": "cdc337d8-c294-4254-a15b-8593ca129f93",
        "stop_location_id": "cdc337d8-c294-4254-a15b-8593ca129f93",
        "parent_planning_id": null
      },
      "relationships": {
        "item": {
          "meta": {
            "included": false
          }
        },
        "order": {
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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





