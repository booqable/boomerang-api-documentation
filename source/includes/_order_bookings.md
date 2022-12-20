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
          "order_id": "f050181e-924c-4a09-b6db-f4b68085389d",
          "items": [
            {
              "type": "products",
              "id": "74484362-e4eb-45fe-b352-5f5f4841e7e3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "aadbe275-bd2e-49f6-8392-ca9d4c773401",
              "stock_item_ids": [
                "2c462339-6fbe-42b9-acd7-4497010eedac",
                "e95a43d5-d2f8-419d-9a88-6e2e599696c9"
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
            "item_id": "74484362-e4eb-45fe-b352-5f5f4841e7e3",
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
          "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
          "items": [
            {
              "type": "products",
              "id": "c3e9e951-c27d-42f2-9cfc-c51b8636b201",
              "stock_item_ids": [
                "4190b706-a8df-41b6-93b6-f3b978a35b5c",
                "333b1830-19db-44dd-a55d-1762fead0d28",
                "474915f1-7c0b-4e01-9460-10486c25c8fd"
              ]
            },
            {
              "type": "products",
              "id": "401040d8-407e-45d3-bca3-216a43154be9",
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
    "id": "3f1691bb-5141-537e-9abe-a881beeee699",
    "type": "order_bookings",
    "attributes": {
      "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3a34c8ed-557f-47b1-a54e-4c758ed00fc9"
          },
          {
            "type": "lines",
            "id": "3e12d726-0051-48bc-a6af-1cafa913ee6a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2"
          },
          {
            "type": "plannings",
            "id": "5fb60035-bff1-4001-aba5-a3186f1c93da"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d88fce8b-6bd2-4335-8044-8ea5b5c166db"
          },
          {
            "type": "stock_item_plannings",
            "id": "5f8ba188-aacc-449e-8f68-0b5ea7890e87"
          },
          {
            "type": "stock_item_plannings",
            "id": "29b91d7c-7119-4cc7-add9-7871246607c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-20T14:49:58+00:00",
        "updated_at": "2022-12-20T14:50:00+00:00",
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
        "customer_id": "b96df409-940c-4e37-9859-fa975b37c559",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f36cc09d-df20-426d-981a-acec459c05fc",
        "stop_location_id": "f36cc09d-df20-426d-981a-acec459c05fc"
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
      "id": "3a34c8ed-557f-47b1-a54e-4c758ed00fc9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:49:59+00:00",
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
        "item_id": "c3e9e951-c27d-42f2-9cfc-c51b8636b201",
        "tax_category_id": "ef01784b-3e0a-4ee0-9d68-37e187e8c611",
        "planning_id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2",
        "parent_line_id": null,
        "owner_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
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
      "id": "3e12d726-0051-48bc-a6af-1cafa913ee6a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:49:59+00:00",
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
        "item_id": "401040d8-407e-45d3-bca3-216a43154be9",
        "tax_category_id": "ef01784b-3e0a-4ee0-9d68-37e187e8c611",
        "planning_id": "5fb60035-bff1-4001-aba5-a3186f1c93da",
        "parent_line_id": null,
        "owner_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
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
      "id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:50:00+00:00",
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
        "item_id": "c3e9e951-c27d-42f2-9cfc-c51b8636b201",
        "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
        "start_location_id": "f36cc09d-df20-426d-981a-acec459c05fc",
        "stop_location_id": "f36cc09d-df20-426d-981a-acec459c05fc",
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
      "id": "5fb60035-bff1-4001-aba5-a3186f1c93da",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:50:00+00:00",
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
        "item_id": "401040d8-407e-45d3-bca3-216a43154be9",
        "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a",
        "start_location_id": "f36cc09d-df20-426d-981a-acec459c05fc",
        "stop_location_id": "f36cc09d-df20-426d-981a-acec459c05fc",
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
      "id": "d88fce8b-6bd2-4335-8044-8ea5b5c166db",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:49:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4190b706-a8df-41b6-93b6-f3b978a35b5c",
        "planning_id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2",
        "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a"
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
      "id": "5f8ba188-aacc-449e-8f68-0b5ea7890e87",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:49:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "333b1830-19db-44dd-a55d-1762fead0d28",
        "planning_id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2",
        "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a"
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
      "id": "29b91d7c-7119-4cc7-add9-7871246607c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-20T14:49:59+00:00",
        "updated_at": "2022-12-20T14:49:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "474915f1-7c0b-4e01-9460-10486c25c8fd",
        "planning_id": "84ecc03a-890a-4a37-9d83-df2c794e5fa2",
        "order_id": "73e066c9-c4d3-4cd5-a023-51b3b8f7c62a"
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
          "order_id": "7be80eb2-2aee-43d3-9114-a31b07e339c9",
          "items": [
            {
              "type": "bundles",
              "id": "a6ea83f0-bc76-460a-86a0-d4b5e630d9c4",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "72d18eed-323a-470c-954c-0b627157e088",
                  "id": "6ef8f78e-d3fa-4155-a258-426b99dfdc96"
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
    "id": "6a3f4656-a655-5bff-bf6c-fd8bde7a1a4f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7be80eb2-2aee-43d3-9114-a31b07e339c9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7be80eb2-2aee-43d3-9114-a31b07e339c9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "663307fe-17e5-4c57-b256-79cb05bca78d"
          },
          {
            "type": "lines",
            "id": "5fc8c5c8-f99a-4b76-a73e-56e43288921a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "57cd04a4-2e8a-4071-849e-a5edcbddfa83"
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
      "id": "7be80eb2-2aee-43d3-9114-a31b07e339c9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-20T14:50:02+00:00",
        "updated_at": "2022-12-20T14:50:03+00:00",
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
        "starts_at": "2022-12-18T14:45:00+00:00",
        "stops_at": "2022-12-22T14:45:00+00:00",
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
        "start_location_id": "efb59810-0e6f-4b1f-b4d1-a42e5eba8acc",
        "stop_location_id": "efb59810-0e6f-4b1f-b4d1-a42e5eba8acc"
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
      "id": "663307fe-17e5-4c57-b256-79cb05bca78d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-20T14:50:02+00:00",
        "updated_at": "2022-12-20T14:50:02+00:00",
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
        "item_id": "a6ea83f0-bc76-460a-86a0-d4b5e630d9c4",
        "tax_category_id": null,
        "planning_id": "57cd04a4-2e8a-4071-849e-a5edcbddfa83",
        "parent_line_id": null,
        "owner_id": "7be80eb2-2aee-43d3-9114-a31b07e339c9",
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
      "id": "5fc8c5c8-f99a-4b76-a73e-56e43288921a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-20T14:50:02+00:00",
        "updated_at": "2022-12-20T14:50:02+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 9 - red",
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
        "item_id": "6ef8f78e-d3fa-4155-a258-426b99dfdc96",
        "tax_category_id": null,
        "planning_id": "7665a4fa-d5b8-4a3a-b68f-f35ef605c445",
        "parent_line_id": "663307fe-17e5-4c57-b256-79cb05bca78d",
        "owner_id": "7be80eb2-2aee-43d3-9114-a31b07e339c9",
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
      "id": "57cd04a4-2e8a-4071-849e-a5edcbddfa83",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-20T14:50:02+00:00",
        "updated_at": "2022-12-20T14:50:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-12-18T14:45:00+00:00",
        "stops_at": "2022-12-22T14:45:00+00:00",
        "reserved_from": "2022-12-18T14:45:00+00:00",
        "reserved_till": "2022-12-22T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a6ea83f0-bc76-460a-86a0-d4b5e630d9c4",
        "order_id": "7be80eb2-2aee-43d3-9114-a31b07e339c9",
        "start_location_id": "efb59810-0e6f-4b1f-b4d1-a42e5eba8acc",
        "stop_location_id": "efb59810-0e6f-4b1f-b4d1-a42e5eba8acc",
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





