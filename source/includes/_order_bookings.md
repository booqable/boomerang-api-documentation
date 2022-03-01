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
          "order_id": "d89b3fd3-3758-4259-b256-99b92fbe05fb",
          "items": [
            {
              "type": "products",
              "id": "a49a9dd8-7dc0-4a91-bd12-18d299716a18",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5b9db2d2-1f2a-49b3-8b81-a89f1eb4c52c",
              "stock_item_ids": [
                "d7a10947-c04d-47d7-9e8e-708b10e389f3",
                "352ba479-303b-41d8-a998-2e2f67f14fec"
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
            "item_id": "a49a9dd8-7dc0-4a91-bd12-18d299716a18",
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
          "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
          "items": [
            {
              "type": "products",
              "id": "cfe51845-2563-4f71-8215-a8c41d23fbb7",
              "stock_item_ids": [
                "b3935763-acfe-4411-bd33-bc67adb90204",
                "6b2391e1-a45b-47c9-9c2f-ebfefa7c7447",
                "42c7d6c1-6a60-4f62-a85d-efbc74d11e3a"
              ]
            },
            {
              "type": "products",
              "id": "c4b43830-8dd7-49ae-bdb9-6b362b32236d",
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
    "id": "972a1d6e-426f-56e5-ab1d-8717687b0e83",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1565c538-6b99-4523-8cfe-f06a45f2d744"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c1d40313-1ced-4ebe-8096-1a0b73a94e30"
          },
          {
            "type": "lines",
            "id": "de42042f-e86d-447d-888e-137c85ae7847"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5b811bcb-f551-4b2b-bf9b-642006ae481d"
          },
          {
            "type": "plannings",
            "id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3c195ac8-2d1f-4a5a-8227-8e63591ec739"
          },
          {
            "type": "stock_item_plannings",
            "id": "460d7b80-6224-4554-b748-8b74da2b6ae4"
          },
          {
            "type": "stock_item_plannings",
            "id": "61ad718f-39df-42af-8ddf-2d3913cff1cc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-01T09:36:31+00:00",
        "updated_at": "2022-03-01T09:36:34+00:00",
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
        "customer_id": "b3b3e18d-0272-4ad3-a95a-6eed7dabdee7",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e",
        "stop_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e"
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
      "id": "c1d40313-1ced-4ebe-8096-1a0b73a94e30",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-01T09:36:32+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
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
        "item_id": "c4b43830-8dd7-49ae-bdb9-6b362b32236d",
        "tax_category_id": "ed71233f-8cc1-4b80-9591-74f314207ac4",
        "planning_id": "5b811bcb-f551-4b2b-bf9b-642006ae481d",
        "parent_line_id": null,
        "owner_id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
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
      "id": "de42042f-e86d-447d-888e-137c85ae7847",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-01T09:36:33+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
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
        "item_id": "cfe51845-2563-4f71-8215-a8c41d23fbb7",
        "tax_category_id": "ed71233f-8cc1-4b80-9591-74f314207ac4",
        "planning_id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8",
        "parent_line_id": null,
        "owner_id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
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
      "id": "5b811bcb-f551-4b2b-bf9b-642006ae481d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:31+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
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
        "item_id": "c4b43830-8dd7-49ae-bdb9-6b362b32236d",
        "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
        "start_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e",
        "stop_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e",
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
      "id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:33+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
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
        "item_id": "cfe51845-2563-4f71-8215-a8c41d23fbb7",
        "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744",
        "start_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e",
        "stop_location_id": "b5d4a9a6-3673-4b67-b59e-875d0c08ba4e",
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
      "id": "3c195ac8-2d1f-4a5a-8227-8e63591ec739",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:33+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b3935763-acfe-4411-bd33-bc67adb90204",
        "planning_id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8",
        "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744"
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
      "id": "460d7b80-6224-4554-b748-8b74da2b6ae4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:33+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6b2391e1-a45b-47c9-9c2f-ebfefa7c7447",
        "planning_id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8",
        "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744"
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
      "id": "61ad718f-39df-42af-8ddf-2d3913cff1cc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:33+00:00",
        "updated_at": "2022-03-01T09:36:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "42c7d6c1-6a60-4f62-a85d-efbc74d11e3a",
        "planning_id": "0c3bbe2f-7cb6-42eb-ab0e-1ac1b45678a8",
        "order_id": "1565c538-6b99-4523-8cfe-f06a45f2d744"
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
          "order_id": "1414a2b8-9148-49a1-ba25-39b2e87badb1",
          "items": [
            {
              "type": "bundles",
              "id": "47e9aaf7-8075-46f9-8f4a-7870b5462adb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9059787e-aabd-43a5-b2bc-6718511ccdca",
                  "id": "632e3fce-5727-43c2-b7ee-db340cc273d2"
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
    "id": "a311c736-4bb1-55ce-a966-3a60e2fdf0b1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1414a2b8-9148-49a1-ba25-39b2e87badb1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1414a2b8-9148-49a1-ba25-39b2e87badb1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a297d60e-bb3f-4a14-bad2-a4fbb4041f15"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "56d8489f-a46a-4e13-a2de-fed4f8422244"
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
      "id": "1414a2b8-9148-49a1-ba25-39b2e87badb1",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-01T09:36:37+00:00",
        "updated_at": "2022-03-01T09:36:38+00:00",
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
        "starts_at": "2022-02-27T09:30:00+00:00",
        "stops_at": "2022-03-03T09:30:00+00:00",
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
        "start_location_id": "55754254-7e1d-43e4-adb3-603e67531a28",
        "stop_location_id": "55754254-7e1d-43e4-adb3-603e67531a28"
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
      "id": "a297d60e-bb3f-4a14-bad2-a4fbb4041f15",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-01T09:36:38+00:00",
        "updated_at": "2022-03-01T09:36:38+00:00",
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
        "item_id": "47e9aaf7-8075-46f9-8f4a-7870b5462adb",
        "tax_category_id": null,
        "planning_id": "56d8489f-a46a-4e13-a2de-fed4f8422244",
        "parent_line_id": null,
        "owner_id": "1414a2b8-9148-49a1-ba25-39b2e87badb1",
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
      "id": "56d8489f-a46a-4e13-a2de-fed4f8422244",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-01T09:36:38+00:00",
        "updated_at": "2022-03-01T09:36:38+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-02-27T09:30:00+00:00",
        "stops_at": "2022-03-03T09:30:00+00:00",
        "reserved_from": "2022-02-27T09:30:00+00:00",
        "reserved_till": "2022-03-03T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "47e9aaf7-8075-46f9-8f4a-7870b5462adb",
        "order_id": "1414a2b8-9148-49a1-ba25-39b2e87badb1",
        "start_location_id": "55754254-7e1d-43e4-adb3-603e67531a28",
        "stop_location_id": "55754254-7e1d-43e4-adb3-603e67531a28",
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





