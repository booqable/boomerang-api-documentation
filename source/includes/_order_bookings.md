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
          "order_id": "cbe296fa-b757-4669-a052-4a9ced02ce53",
          "items": [
            {
              "type": "products",
              "id": "b87c5e56-f8a7-473a-a2ef-a5b1be37bf4f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3ab662ea-5932-4630-946a-bb069fd990f0",
              "stock_item_ids": [
                "f23e8572-a12d-4953-b563-3173ef436a72",
                "b5d07c7f-ecde-4be8-a3bd-059f159d337e"
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
            "item_id": "b87c5e56-f8a7-473a-a2ef-a5b1be37bf4f",
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
          "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
          "items": [
            {
              "type": "products",
              "id": "62fdb337-87bf-4519-9b27-adcb5516014a",
              "stock_item_ids": [
                "10e66f2c-5f2c-43d4-98f2-0ce220dbaf83",
                "314fb3b2-789d-4ba9-93c2-6a51bce764bc",
                "be1936a6-ec0e-48c7-82e0-a35ad0605148"
              ]
            },
            {
              "type": "products",
              "id": "ef9d900e-2bc9-490c-acca-eec85afa8d40",
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
    "id": "9a293cd3-cc84-5360-a476-e118d3003390",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "aa964113-3631-4063-8597-d2ea8a6a65a9"
          },
          {
            "type": "lines",
            "id": "5f06dfd2-3d2a-4e27-9245-5ed709455335"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c"
          },
          {
            "type": "plannings",
            "id": "d3370bda-b130-4b4f-b0ef-5fef8b094233"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "73bf2c94-a657-4aac-9bbd-ab26e4c8f9a5"
          },
          {
            "type": "stock_item_plannings",
            "id": "901885e8-8015-467c-b7b8-e09f0b4c8643"
          },
          {
            "type": "stock_item_plannings",
            "id": "1530823f-e59f-47a4-8e18-7d1d3662881d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T15:26:34+00:00",
        "updated_at": "2023-02-02T15:26:36+00:00",
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
        "customer_id": "a62d0fef-ab0a-4c63-bb5b-d4d731c86ed0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443",
        "stop_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443"
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
      "id": "aa964113-3631-4063-8597-d2ea8a6a65a9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
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
        "item_id": "62fdb337-87bf-4519-9b27-adcb5516014a",
        "tax_category_id": "c97b6b7a-0942-42cb-93d3-3e13d167a70e",
        "planning_id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c",
        "parent_line_id": null,
        "owner_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
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
      "id": "5f06dfd2-3d2a-4e27-9245-5ed709455335",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
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
        "item_id": "ef9d900e-2bc9-490c-acca-eec85afa8d40",
        "tax_category_id": "c97b6b7a-0942-42cb-93d3-3e13d167a70e",
        "planning_id": "d3370bda-b130-4b4f-b0ef-5fef8b094233",
        "parent_line_id": null,
        "owner_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
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
      "id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
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
        "item_id": "62fdb337-87bf-4519-9b27-adcb5516014a",
        "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
        "start_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443",
        "stop_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443",
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
      "id": "d3370bda-b130-4b4f-b0ef-5fef8b094233",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
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
        "item_id": "ef9d900e-2bc9-490c-acca-eec85afa8d40",
        "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1",
        "start_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443",
        "stop_location_id": "1a8101cc-5c6a-47a1-8398-ae3b29241443",
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
      "id": "73bf2c94-a657-4aac-9bbd-ab26e4c8f9a5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "10e66f2c-5f2c-43d4-98f2-0ce220dbaf83",
        "planning_id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c",
        "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1"
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
      "id": "901885e8-8015-467c-b7b8-e09f0b4c8643",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "314fb3b2-789d-4ba9-93c2-6a51bce764bc",
        "planning_id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c",
        "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1"
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
      "id": "1530823f-e59f-47a4-8e18-7d1d3662881d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:35+00:00",
        "updated_at": "2023-02-02T15:26:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "be1936a6-ec0e-48c7-82e0-a35ad0605148",
        "planning_id": "b8662c75-8e0c-4e22-bd4c-fa6085b6724c",
        "order_id": "2a839cd0-fa65-4b3f-a857-758f2ff434b1"
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
          "order_id": "eefaacf6-4025-477e-8aba-27a5a50a0138",
          "items": [
            {
              "type": "bundles",
              "id": "31ab4f09-718e-4262-b95e-f8ee2cfbb0ee",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "524d1e4b-5422-4683-b480-388ad7208bf6",
                  "id": "f2888a21-4649-4565-b022-4e03b0e5659c"
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
    "id": "0652cde8-b010-5112-b017-3a8b637fd866",
    "type": "order_bookings",
    "attributes": {
      "order_id": "eefaacf6-4025-477e-8aba-27a5a50a0138"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "eefaacf6-4025-477e-8aba-27a5a50a0138"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "efa6946d-7b39-4693-9245-d35cecfc93ab"
          },
          {
            "type": "lines",
            "id": "5e61b867-c081-44aa-b1a0-eaf8c756c633"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b8f0be89-14d1-499c-b252-b019b2f89455"
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
      "id": "eefaacf6-4025-477e-8aba-27a5a50a0138",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T15:26:37+00:00",
        "updated_at": "2023-02-02T15:26:38+00:00",
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
        "starts_at": "2023-01-31T15:15:00+00:00",
        "stops_at": "2023-02-04T15:15:00+00:00",
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
        "start_location_id": "8f71171e-de35-45f1-b982-c7d90de1f04b",
        "stop_location_id": "8f71171e-de35-45f1-b982-c7d90de1f04b"
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
      "id": "efa6946d-7b39-4693-9245-d35cecfc93ab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T15:26:38+00:00",
        "updated_at": "2023-02-02T15:26:38+00:00",
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
        "item_id": "31ab4f09-718e-4262-b95e-f8ee2cfbb0ee",
        "tax_category_id": null,
        "planning_id": "b8f0be89-14d1-499c-b252-b019b2f89455",
        "parent_line_id": null,
        "owner_id": "eefaacf6-4025-477e-8aba-27a5a50a0138",
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
      "id": "5e61b867-c081-44aa-b1a0-eaf8c756c633",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T15:26:38+00:00",
        "updated_at": "2023-02-02T15:26:38+00:00",
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
        "item_id": "f2888a21-4649-4565-b022-4e03b0e5659c",
        "tax_category_id": null,
        "planning_id": "ed574e2d-9165-4d4c-a61a-92bba3f85179",
        "parent_line_id": "efa6946d-7b39-4693-9245-d35cecfc93ab",
        "owner_id": "eefaacf6-4025-477e-8aba-27a5a50a0138",
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
      "id": "b8f0be89-14d1-499c-b252-b019b2f89455",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T15:26:38+00:00",
        "updated_at": "2023-02-02T15:26:38+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T15:15:00+00:00",
        "stops_at": "2023-02-04T15:15:00+00:00",
        "reserved_from": "2023-01-31T15:15:00+00:00",
        "reserved_till": "2023-02-04T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "31ab4f09-718e-4262-b95e-f8ee2cfbb0ee",
        "order_id": "eefaacf6-4025-477e-8aba-27a5a50a0138",
        "start_location_id": "8f71171e-de35-45f1-b982-c7d90de1f04b",
        "stop_location_id": "8f71171e-de35-45f1-b982-c7d90de1f04b",
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





