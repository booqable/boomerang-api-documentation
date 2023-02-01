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
          "order_id": "4a14a648-7e02-4d73-ba1e-dd08d67c2a2a",
          "items": [
            {
              "type": "products",
              "id": "1116aeac-a5be-48dd-a7d1-8df6b6a1ea20",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "413c25a9-4601-4dac-990f-197b4a32d19b",
              "stock_item_ids": [
                "124e4c33-cbfc-40b7-8bb3-7f1e7d619b2b",
                "a9011478-7b5d-41b8-bd94-3e9611408c26"
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
            "item_id": "1116aeac-a5be-48dd-a7d1-8df6b6a1ea20",
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
          "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df",
          "items": [
            {
              "type": "products",
              "id": "41925247-da08-46b7-b031-4fbd0abb959b",
              "stock_item_ids": [
                "aa9c7181-06a8-4a69-8597-8053c07538a3",
                "eee74eb1-3274-4c89-928c-06b2bbf8116a",
                "2ae8fadb-c258-408d-9ade-f9a978d9de47"
              ]
            },
            {
              "type": "products",
              "id": "cab5a397-1555-4894-a16c-4ca3d84daba7",
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
    "id": "928d92dc-f51f-53bb-be5a-98cad1f0ba6a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "65d5f781-acdf-4d85-a024-043f6475e1df"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a3bb6460-b327-4577-9418-ef523d2a69b8"
          },
          {
            "type": "lines",
            "id": "478295ef-663b-4c45-a774-bda8cacbe4c4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8"
          },
          {
            "type": "plannings",
            "id": "1199978e-6a06-4b3c-9e28-638510472009"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dfba86cb-f4e4-4f20-86e4-b9201fd49963"
          },
          {
            "type": "stock_item_plannings",
            "id": "d4c6b68e-9077-4114-adcf-da4121e5150c"
          },
          {
            "type": "stock_item_plannings",
            "id": "3aa4b000-3629-4a43-ab63-63330e01626f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65d5f781-acdf-4d85-a024-043f6475e1df",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T15:15:46+00:00",
        "updated_at": "2023-02-01T15:15:48+00:00",
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
        "customer_id": "59df0dd9-32da-40fc-8620-91eecc17af67",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2",
        "stop_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2"
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
      "id": "a3bb6460-b327-4577-9418-ef523d2a69b8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:48+00:00",
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
        "item_id": "41925247-da08-46b7-b031-4fbd0abb959b",
        "tax_category_id": "4c01f525-5921-4b76-af3d-d969a7e555d1",
        "planning_id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8",
        "parent_line_id": null,
        "owner_id": "65d5f781-acdf-4d85-a024-043f6475e1df",
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
      "id": "478295ef-663b-4c45-a774-bda8cacbe4c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:48+00:00",
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
        "item_id": "cab5a397-1555-4894-a16c-4ca3d84daba7",
        "tax_category_id": "4c01f525-5921-4b76-af3d-d969a7e555d1",
        "planning_id": "1199978e-6a06-4b3c-9e28-638510472009",
        "parent_line_id": null,
        "owner_id": "65d5f781-acdf-4d85-a024-043f6475e1df",
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
      "id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:48+00:00",
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
        "item_id": "41925247-da08-46b7-b031-4fbd0abb959b",
        "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df",
        "start_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2",
        "stop_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2",
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
      "id": "1199978e-6a06-4b3c-9e28-638510472009",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:48+00:00",
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
        "item_id": "cab5a397-1555-4894-a16c-4ca3d84daba7",
        "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df",
        "start_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2",
        "stop_location_id": "6e88a8c6-39e0-4fa0-828b-6f971056afa2",
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
      "id": "dfba86cb-f4e4-4f20-86e4-b9201fd49963",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "aa9c7181-06a8-4a69-8597-8053c07538a3",
        "planning_id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8",
        "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df"
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
      "id": "d4c6b68e-9077-4114-adcf-da4121e5150c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eee74eb1-3274-4c89-928c-06b2bbf8116a",
        "planning_id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8",
        "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df"
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
      "id": "3aa4b000-3629-4a43-ab63-63330e01626f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:47+00:00",
        "updated_at": "2023-02-01T15:15:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2ae8fadb-c258-408d-9ade-f9a978d9de47",
        "planning_id": "73288f4c-ec3e-40a5-bfe4-58f94c752af8",
        "order_id": "65d5f781-acdf-4d85-a024-043f6475e1df"
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
          "order_id": "37a05149-de89-4a64-a929-f459484bccc6",
          "items": [
            {
              "type": "bundles",
              "id": "4f4ad3f6-a491-4296-93db-375c692db080",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5c15cd10-6404-47d4-9330-a30d2531d95c",
                  "id": "49e2cf3b-7d8f-4d9d-b316-835bc7fee616"
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
    "id": "94f96ea8-51cd-51af-8e9d-27615744df3d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "37a05149-de89-4a64-a929-f459484bccc6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "37a05149-de89-4a64-a929-f459484bccc6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f48fcb99-65ad-40dd-baa3-486db8b8f635"
          },
          {
            "type": "lines",
            "id": "d85dc288-62ac-4be6-9012-2a5c94818c7a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2e85b6a5-9874-4798-a7d2-aa0b3b5c9f1b"
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
      "id": "37a05149-de89-4a64-a929-f459484bccc6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T15:15:50+00:00",
        "updated_at": "2023-02-01T15:15:51+00:00",
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
        "starts_at": "2023-01-30T15:15:00+00:00",
        "stops_at": "2023-02-03T15:15:00+00:00",
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
        "start_location_id": "998f6320-7ee5-4eb0-9c86-36f14598dcf2",
        "stop_location_id": "998f6320-7ee5-4eb0-9c86-36f14598dcf2"
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
      "id": "f48fcb99-65ad-40dd-baa3-486db8b8f635",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:15:51+00:00",
        "updated_at": "2023-02-01T15:15:51+00:00",
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
        "item_id": "4f4ad3f6-a491-4296-93db-375c692db080",
        "tax_category_id": null,
        "planning_id": "2e85b6a5-9874-4798-a7d2-aa0b3b5c9f1b",
        "parent_line_id": null,
        "owner_id": "37a05149-de89-4a64-a929-f459484bccc6",
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
      "id": "d85dc288-62ac-4be6-9012-2a5c94818c7a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T15:15:51+00:00",
        "updated_at": "2023-02-01T15:15:51+00:00",
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
        "item_id": "49e2cf3b-7d8f-4d9d-b316-835bc7fee616",
        "tax_category_id": null,
        "planning_id": "eafc1204-a118-4210-af92-a22bdfa242f9",
        "parent_line_id": "f48fcb99-65ad-40dd-baa3-486db8b8f635",
        "owner_id": "37a05149-de89-4a64-a929-f459484bccc6",
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
      "id": "2e85b6a5-9874-4798-a7d2-aa0b3b5c9f1b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T15:15:51+00:00",
        "updated_at": "2023-02-01T15:15:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-30T15:15:00+00:00",
        "stops_at": "2023-02-03T15:15:00+00:00",
        "reserved_from": "2023-01-30T15:15:00+00:00",
        "reserved_till": "2023-02-03T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4f4ad3f6-a491-4296-93db-375c692db080",
        "order_id": "37a05149-de89-4a64-a929-f459484bccc6",
        "start_location_id": "998f6320-7ee5-4eb0-9c86-36f14598dcf2",
        "stop_location_id": "998f6320-7ee5-4eb0-9c86-36f14598dcf2",
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





