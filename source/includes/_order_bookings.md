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
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


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
          "order_id": "d868314d-7700-43e0-9e86-f421b7557fcb",
          "items": [
            {
              "type": "products",
              "id": "f3da9c75-8533-4ab9-9468-0077c87617b2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "23aeca6b-84c1-4585-baec-06ec00ec469a",
              "stock_item_ids": [
                "03f6c443-c1c5-4857-b14a-4ef66b0d7a41",
                "00296dfd-a0e2-46c2-b3b8-b1d10d4672fb"
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
      "code": "items_not_available",
      "status": "422",
      "title": "Items not available",
      "detail": "One or more items are not available",
      "meta": {
        "warning": [],
        "blocking": [
          {
            "reason": "shortage",
            "item_id": "f3da9c75-8533-4ab9-9468-0077c87617b2",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          }
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
          "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
          "items": [
            {
              "type": "products",
              "id": "97bf9e9f-86e1-4ccf-a2a8-ed26a54d5f17",
              "stock_item_ids": [
                "0fbccb3c-7068-49e4-81d8-08481bf59e13",
                "9f48c50c-8d9a-4194-9f3c-7f7a1656a37d",
                "3a5109a2-ea3c-4be3-805c-efe3365b2812"
              ]
            },
            {
              "type": "products",
              "id": "1122f79e-431d-46f0-9fae-f6768f1a7d69",
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
    "id": "9ebc8bdb-66ae-5800-b89e-5f60396a9685",
    "type": "order_bookings",
    "attributes": {
      "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d64bff51-5bbb-48c3-9448-aec32c5f52cf"
          },
          {
            "type": "lines",
            "id": "2a8bb1ae-660b-4bb0-8f02-eb09b6fa7e62"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "12382c01-1797-4d73-bf4b-8be956103e1f"
          },
          {
            "type": "plannings",
            "id": "44ced35f-c5d0-4c20-ac99-45b4600a1899"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "62522108-4ce1-4c2b-8748-efa985175615"
          },
          {
            "type": "stock_item_plannings",
            "id": "9cd7b913-f049-428a-99c5-871aae4ee2c3"
          },
          {
            "type": "stock_item_plannings",
            "id": "dc1e5a04-6d0d-4c2d-999b-0f96941fbaa7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-05T12:27:35+00:00",
        "updated_at": "2022-05-05T12:27:37+00:00",
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
        "customer_id": "8613b52b-deea-4877-bc90-983fd5fae8b9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9",
        "stop_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9"
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
      "id": "d64bff51-5bbb-48c3-9448-aec32c5f52cf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-05T12:27:35+00:00",
        "updated_at": "2022-05-05T12:27:37+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 2,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 160500,
        "position": 1,
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
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "1122f79e-431d-46f0-9fae-f6768f1a7d69",
        "tax_category_id": "402c4797-01d6-4e0f-b6ea-5d6aacada949",
        "planning_id": "12382c01-1797-4d73-bf4b-8be956103e1f",
        "parent_line_id": null,
        "owner_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
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
      "id": "2a8bb1ae-660b-4bb0-8f02-eb09b6fa7e62",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-05T12:27:36+00:00",
        "updated_at": "2022-05-05T12:27:37+00:00",
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
              "price_in_cents": "3100.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "97bf9e9f-86e1-4ccf-a2a8-ed26a54d5f17",
        "tax_category_id": "402c4797-01d6-4e0f-b6ea-5d6aacada949",
        "planning_id": "44ced35f-c5d0-4c20-ac99-45b4600a1899",
        "parent_line_id": null,
        "owner_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
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
      "id": "12382c01-1797-4d73-bf4b-8be956103e1f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:35+00:00",
        "updated_at": "2022-05-05T12:27:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1122f79e-431d-46f0-9fae-f6768f1a7d69",
        "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
        "start_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9",
        "stop_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9",
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
      "id": "44ced35f-c5d0-4c20-ac99-45b4600a1899",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:36+00:00",
        "updated_at": "2022-05-05T12:27:37+00:00",
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
        "item_id": "97bf9e9f-86e1-4ccf-a2a8-ed26a54d5f17",
        "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a",
        "start_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9",
        "stop_location_id": "aa7bb6da-be86-4d88-a206-0ed756d777c9",
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
      "id": "62522108-4ce1-4c2b-8748-efa985175615",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:36+00:00",
        "updated_at": "2022-05-05T12:27:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0fbccb3c-7068-49e4-81d8-08481bf59e13",
        "planning_id": "44ced35f-c5d0-4c20-ac99-45b4600a1899",
        "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a"
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
      "id": "9cd7b913-f049-428a-99c5-871aae4ee2c3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:36+00:00",
        "updated_at": "2022-05-05T12:27:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9f48c50c-8d9a-4194-9f3c-7f7a1656a37d",
        "planning_id": "44ced35f-c5d0-4c20-ac99-45b4600a1899",
        "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a"
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
      "id": "dc1e5a04-6d0d-4c2d-999b-0f96941fbaa7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:36+00:00",
        "updated_at": "2022-05-05T12:27:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3a5109a2-ea3c-4be3-805c-efe3365b2812",
        "planning_id": "44ced35f-c5d0-4c20-ac99-45b4600a1899",
        "order_id": "50d3b22c-5fee-4624-a0a3-79f6cc29864a"
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
          "order_id": "c9648977-7c24-4065-9590-901831892d13",
          "items": [
            {
              "type": "bundles",
              "id": "d9371330-822b-4aa8-a438-a7734bfbd363",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8fd84118-1e8d-4638-b3c6-4b7fa255821b",
                  "id": "efa750cd-4abb-40de-9c45-f3d82e8873fd"
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
    "id": "87c655a6-b4fe-54f7-a62f-e67b23908a5c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c9648977-7c24-4065-9590-901831892d13"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c9648977-7c24-4065-9590-901831892d13"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "881f93b3-c837-40ee-aac9-ef933c3d5388"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "68b1c948-ee82-43de-b9ce-ff78b76bb8c9"
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
      "id": "c9648977-7c24-4065-9590-901831892d13",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-05T12:27:39+00:00",
        "updated_at": "2022-05-05T12:27:40+00:00",
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
        "starts_at": "2022-05-03T12:15:00+00:00",
        "stops_at": "2022-05-07T12:15:00+00:00",
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
        "start_location_id": "523bea42-b587-4518-9e3a-9d9a4ba14c68",
        "stop_location_id": "523bea42-b587-4518-9e3a-9d9a4ba14c68"
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
      "id": "881f93b3-c837-40ee-aac9-ef933c3d5388",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-05T12:27:40+00:00",
        "updated_at": "2022-05-05T12:27:40+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "d9371330-822b-4aa8-a438-a7734bfbd363",
        "tax_category_id": null,
        "planning_id": "68b1c948-ee82-43de-b9ce-ff78b76bb8c9",
        "parent_line_id": null,
        "owner_id": "c9648977-7c24-4065-9590-901831892d13",
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
      "id": "68b1c948-ee82-43de-b9ce-ff78b76bb8c9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-05T12:27:40+00:00",
        "updated_at": "2022-05-05T12:27:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-03T12:15:00+00:00",
        "stops_at": "2022-05-07T12:15:00+00:00",
        "reserved_from": "2022-05-03T12:15:00+00:00",
        "reserved_till": "2022-05-07T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d9371330-822b-4aa8-a438-a7734bfbd363",
        "order_id": "c9648977-7c24-4065-9590-901831892d13",
        "start_location_id": "523bea42-b587-4518-9e3a-9d9a4ba14c68",
        "stop_location_id": "523bea42-b587-4518-9e3a-9d9a4ba14c68",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>
`data[attributes][items][]` | **Array**<br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





