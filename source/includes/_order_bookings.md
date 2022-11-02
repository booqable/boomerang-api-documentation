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
          "order_id": "57697601-928e-420a-8745-67d664b3e3b7",
          "items": [
            {
              "type": "products",
              "id": "1ec31f9c-1257-4de3-8db5-3632c02cd841",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e97c562f-76e0-4be0-99d7-15ad58fa8bca",
              "stock_item_ids": [
                "06824f98-bc51-485c-a89a-b6b22eecc80f",
                "dda133c5-861f-4b22-9b75-7685e5fd0642"
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
            "item_id": "1ec31f9c-1257-4de3-8db5-3632c02cd841",
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
          "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
          "items": [
            {
              "type": "products",
              "id": "78622f97-0673-42b1-86a8-429df4095185",
              "stock_item_ids": [
                "776daadd-e723-4111-9b8f-654413e8970e",
                "08b06326-c1fe-406d-9901-343d75d61fdf",
                "0c666aad-9323-4aa7-8d3c-7237c64ed18e"
              ]
            },
            {
              "type": "products",
              "id": "cf9181b0-d69b-4eb6-8156-a0d54c46e06e",
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
    "id": "d6d634d5-c372-58db-9cbc-3d040518e1ac",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "640956f8-ac0f-4905-a8e6-0596ab7a9c1c"
          },
          {
            "type": "lines",
            "id": "1fad1c45-cc45-4d0b-8eb2-c9b1b9cd0bc6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0"
          },
          {
            "type": "plannings",
            "id": "f6f6506a-9535-47f0-a742-1f6522679fcc"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0c1c0918-2717-4fe8-9e10-61a33357f489"
          },
          {
            "type": "stock_item_plannings",
            "id": "aa1dc5d8-c75d-4511-b567-fd0680714d85"
          },
          {
            "type": "stock_item_plannings",
            "id": "42e2168c-e52d-4ecd-bdae-a79da0c4dc00"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-02T10:20:03+00:00",
        "updated_at": "2022-11-02T10:20:06+00:00",
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
        "customer_id": "50724d9e-3f99-4866-8bac-a7baf01567f9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb",
        "stop_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb"
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
      "id": "640956f8-ac0f-4905-a8e6-0596ab7a9c1c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
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
        "item_id": "78622f97-0673-42b1-86a8-429df4095185",
        "tax_category_id": "00ff42e1-5010-4a98-96d1-b908d72c85cd",
        "planning_id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0",
        "parent_line_id": null,
        "owner_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
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
      "id": "1fad1c45-cc45-4d0b-8eb2-c9b1b9cd0bc6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
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
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "cf9181b0-d69b-4eb6-8156-a0d54c46e06e",
        "tax_category_id": "00ff42e1-5010-4a98-96d1-b908d72c85cd",
        "planning_id": "f6f6506a-9535-47f0-a742-1f6522679fcc",
        "parent_line_id": null,
        "owner_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
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
      "id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
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
        "item_id": "78622f97-0673-42b1-86a8-429df4095185",
        "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
        "start_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb",
        "stop_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb",
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
      "id": "f6f6506a-9535-47f0-a742-1f6522679fcc",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
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
        "item_id": "cf9181b0-d69b-4eb6-8156-a0d54c46e06e",
        "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59",
        "start_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb",
        "stop_location_id": "553232f3-69ae-41dc-bcf1-9f97e9510fcb",
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
      "id": "0c1c0918-2717-4fe8-9e10-61a33357f489",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "776daadd-e723-4111-9b8f-654413e8970e",
        "planning_id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0",
        "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59"
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
      "id": "aa1dc5d8-c75d-4511-b567-fd0680714d85",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "08b06326-c1fe-406d-9901-343d75d61fdf",
        "planning_id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0",
        "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59"
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
      "id": "42e2168c-e52d-4ecd-bdae-a79da0c4dc00",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:05+00:00",
        "updated_at": "2022-11-02T10:20:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0c666aad-9323-4aa7-8d3c-7237c64ed18e",
        "planning_id": "a3ec45ae-f56b-4ac0-bc53-9eab2d88e1c0",
        "order_id": "c73b94b6-fdf6-4d82-9745-dad4c9634a59"
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
          "order_id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf",
          "items": [
            {
              "type": "bundles",
              "id": "7393bbbf-ee26-42b6-85da-6bed63afee08",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "020428c5-9037-43c4-aed9-d3ef67945963",
                  "id": "ec2bbf3d-5956-4d9e-8d87-f346a4751e45"
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
    "id": "36827f7e-fc62-58dd-8f31-cc56de08182e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "19a5ac8b-aad0-4b2c-b121-134e9bf355b7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9f11fa12-c6db-4c34-8682-638d575f14fb"
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
      "id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-02T10:20:08+00:00",
        "updated_at": "2022-11-02T10:20:09+00:00",
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
        "starts_at": "2022-10-31T10:15:00+00:00",
        "stops_at": "2022-11-04T10:15:00+00:00",
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
        "start_location_id": "c1967ca9-e1b0-4cda-907a-cacb4e2e635b",
        "stop_location_id": "c1967ca9-e1b0-4cda-907a-cacb4e2e635b"
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
      "id": "19a5ac8b-aad0-4b2c-b121-134e9bf355b7",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-02T10:20:09+00:00",
        "updated_at": "2022-11-02T10:20:09+00:00",
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
        "item_id": "7393bbbf-ee26-42b6-85da-6bed63afee08",
        "tax_category_id": null,
        "planning_id": "9f11fa12-c6db-4c34-8682-638d575f14fb",
        "parent_line_id": null,
        "owner_id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf",
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
      "id": "9f11fa12-c6db-4c34-8682-638d575f14fb",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-02T10:20:09+00:00",
        "updated_at": "2022-11-02T10:20:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-31T10:15:00+00:00",
        "stops_at": "2022-11-04T10:15:00+00:00",
        "reserved_from": "2022-10-31T10:15:00+00:00",
        "reserved_till": "2022-11-04T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7393bbbf-ee26-42b6-85da-6bed63afee08",
        "order_id": "b9b64cee-c989-4d51-a0da-ebc8fad592cf",
        "start_location_id": "c1967ca9-e1b0-4cda-907a-cacb4e2e635b",
        "stop_location_id": "c1967ca9-e1b0-4cda-907a-cacb4e2e635b",
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





