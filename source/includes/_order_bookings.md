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
          "order_id": "79f69a0c-b4c5-4f27-95ac-6ea0838b39e9",
          "items": [
            {
              "type": "products",
              "id": "e294b8f4-b436-4fdc-8548-f1efb1a224b1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9e8639db-3a5a-4359-ab06-942e78a0535f",
              "stock_item_ids": [
                "348db6be-1e0f-4c0c-9187-e699b5b5784a",
                "30a23ca7-a779-4843-8b55-ee4e7793496e"
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
            "item_id": "e294b8f4-b436-4fdc-8548-f1efb1a224b1",
            "stock_count": 7,
            "reserved": 0,
            "needed": 10,
            "shortage": 3
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
          "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
          "items": [
            {
              "type": "products",
              "id": "f78b636b-7cd7-4d42-b755-160213a41f3c",
              "stock_item_ids": [
                "03569578-c5b6-4e38-9c33-de2665ef7a76",
                "da442364-0c33-44cc-9787-b0dfaa259977",
                "932d2d50-f568-416c-8be5-86572025b37b"
              ]
            },
            {
              "type": "products",
              "id": "19992224-b095-4704-b63d-d5c7dc42875c",
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
    "id": "5f0c37d8-02aa-5f6d-92ee-5eacd90afdc7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e00f8843-0086-4cfc-88b6-fc56f4ab0577"
          },
          {
            "type": "lines",
            "id": "9e5d5b20-52f0-46cc-b274-6d4722ed32e1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "021cadbe-7738-4d5c-9e46-4b304da59c87"
          },
          {
            "type": "plannings",
            "id": "3913b763-2f66-43cd-aebc-24128c4f322f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "aedcb0b9-e763-4633-9aab-6f60d8dc9294"
          },
          {
            "type": "stock_item_plannings",
            "id": "f79455dc-85b6-4e0e-91e9-1cde47ec1d6e"
          },
          {
            "type": "stock_item_plannings",
            "id": "077f0997-f78f-45e5-bc7e-48ce1aa8b2b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-20T12:34:15+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
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
        "customer_id": "e1fb277f-5d98-49bd-b41a-42020de71225",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e",
        "stop_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e"
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
      "id": "e00f8843-0086-4cfc-88b6-fc56f4ab0577",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-20T12:34:16+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
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
        "item_id": "19992224-b095-4704-b63d-d5c7dc42875c",
        "tax_category_id": "2a1bf77b-003e-4688-ba3b-d62039d73f27",
        "planning_id": "021cadbe-7738-4d5c-9e46-4b304da59c87",
        "parent_line_id": null,
        "owner_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
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
      "id": "9e5d5b20-52f0-46cc-b274-6d4722ed32e1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-20T12:34:17+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
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
        "item_id": "f78b636b-7cd7-4d42-b755-160213a41f3c",
        "tax_category_id": "2a1bf77b-003e-4688-ba3b-d62039d73f27",
        "planning_id": "3913b763-2f66-43cd-aebc-24128c4f322f",
        "parent_line_id": null,
        "owner_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
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
      "id": "021cadbe-7738-4d5c-9e46-4b304da59c87",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:16+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
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
        "item_id": "19992224-b095-4704-b63d-d5c7dc42875c",
        "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
        "start_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e",
        "stop_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e",
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
      "id": "3913b763-2f66-43cd-aebc-24128c4f322f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:17+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
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
        "item_id": "f78b636b-7cd7-4d42-b755-160213a41f3c",
        "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553",
        "start_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e",
        "stop_location_id": "5524bdde-4f6f-4edd-a86d-105bc15c838e",
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
      "id": "aedcb0b9-e763-4633-9aab-6f60d8dc9294",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:17+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "03569578-c5b6-4e38-9c33-de2665ef7a76",
        "planning_id": "3913b763-2f66-43cd-aebc-24128c4f322f",
        "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553"
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
      "id": "f79455dc-85b6-4e0e-91e9-1cde47ec1d6e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:17+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "da442364-0c33-44cc-9787-b0dfaa259977",
        "planning_id": "3913b763-2f66-43cd-aebc-24128c4f322f",
        "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553"
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
      "id": "077f0997-f78f-45e5-bc7e-48ce1aa8b2b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:17+00:00",
        "updated_at": "2022-01-20T12:34:17+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "932d2d50-f568-416c-8be5-86572025b37b",
        "planning_id": "3913b763-2f66-43cd-aebc-24128c4f322f",
        "order_id": "da6b7dce-03f2-4e6e-a7e6-a74208ae0553"
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
          "order_id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b",
          "items": [
            {
              "type": "bundles",
              "id": "cd587b9e-d6d7-4e58-87ca-51bf9492fcb5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "145127b0-4558-48e9-ad9d-8bb2f947e22a",
                  "id": "c360207b-b78a-4a7e-be2f-a2eb066c9d3f"
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
    "id": "b8d74117-6ba4-504f-9dee-fe34b293e5ec",
    "type": "order_bookings",
    "attributes": {
      "order_id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6ee750a8-d1d4-4108-849f-403d67b8e3e8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cfe6383e-e6e8-4ac6-a2c3-73d978cc568a"
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
      "id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-20T12:34:19+00:00",
        "updated_at": "2022-01-20T12:34:20+00:00",
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
        "starts_at": "2022-01-18T12:30:00+00:00",
        "stops_at": "2022-01-22T12:30:00+00:00",
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
        "start_location_id": "349beb63-6f5a-41b8-993a-3bad98c3f4d4",
        "stop_location_id": "349beb63-6f5a-41b8-993a-3bad98c3f4d4"
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
      "id": "6ee750a8-d1d4-4108-849f-403d67b8e3e8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-20T12:34:20+00:00",
        "updated_at": "2022-01-20T12:34:20+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "cd587b9e-d6d7-4e58-87ca-51bf9492fcb5",
        "tax_category_id": null,
        "planning_id": "cfe6383e-e6e8-4ac6-a2c3-73d978cc568a",
        "parent_line_id": null,
        "owner_id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b",
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
      "id": "cfe6383e-e6e8-4ac6-a2c3-73d978cc568a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-20T12:34:20+00:00",
        "updated_at": "2022-01-20T12:34:20+00:00",
        "quantity": 1,
        "starts_at": "2022-01-18T12:30:00+00:00",
        "stops_at": "2022-01-22T12:30:00+00:00",
        "reserved_from": "2022-01-18T12:30:00+00:00",
        "reserved_till": "2022-01-22T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cd587b9e-d6d7-4e58-87ca-51bf9492fcb5",
        "order_id": "814b38e2-b55c-426c-acd2-53f9ee6cb60b",
        "start_location_id": "349beb63-6f5a-41b8-993a-3bad98c3f4d4",
        "stop_location_id": "349beb63-6f5a-41b8-993a-3bad98c3f4d4",
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





