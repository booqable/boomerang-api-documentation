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
          "order_id": "e95e5e00-e96a-4b43-bf18-e3580eaa5beb",
          "items": [
            {
              "type": "products",
              "id": "a5b65693-6a46-4cbe-93a5-d7b79385271a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "76107ab6-babb-43f0-90a5-f192598635c5",
              "stock_item_ids": [
                "5fba8cc3-16b0-4a67-ab46-35c1efc61269",
                "2776a244-7e3d-49e6-8846-cd45fcd905bf"
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
            "item_id": "a5b65693-6a46-4cbe-93a5-d7b79385271a",
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
          "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
          "items": [
            {
              "type": "products",
              "id": "91297216-4c5e-4d6c-bff0-8ead37e79494",
              "stock_item_ids": [
                "66b206a3-7cd5-449d-8d8f-36e31f774d33",
                "5a0db0bc-196b-40a3-b63c-a627d78abb87",
                "e01ab247-9c8d-4ca5-973a-7a188a4c2046"
              ]
            },
            {
              "type": "products",
              "id": "97c34b04-a603-40a6-a5ad-05b9aa5a9097",
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
    "id": "48e538f6-7f18-50bd-8008-bd50e47fab8d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "de556c03-dd5a-40aa-9c8a-1587a6196c09"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0534b001-58cb-465f-b12a-5f11b994c1f5"
          },
          {
            "type": "lines",
            "id": "994cb1e2-2df2-4274-9f86-7835bee21a91"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ac7754b3-5d76-4fb8-b651-cf5854eca298"
          },
          {
            "type": "plannings",
            "id": "3b665968-8042-425d-be4a-4f6daebfd188"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d7cc38bc-4a5e-4f5e-b264-613f8f799b30"
          },
          {
            "type": "stock_item_plannings",
            "id": "8e219d42-6786-4b72-bd29-460269aa779d"
          },
          {
            "type": "stock_item_plannings",
            "id": "de7e9183-7f00-415a-81d8-25f591b6f8d6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-13T13:10:12+00:00",
        "updated_at": "2022-01-13T13:10:15+00:00",
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
        "customer_id": "8dda7252-07fc-4213-99f3-d82413ade7da",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b",
        "stop_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b"
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
      "id": "0534b001-58cb-465f-b12a-5f11b994c1f5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T13:10:13+00:00",
        "updated_at": "2022-01-13T13:10:15+00:00",
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
        "item_id": "97c34b04-a603-40a6-a5ad-05b9aa5a9097",
        "tax_category_id": "25f46f25-6f7b-4a38-aeb5-fc4c40b34dfe",
        "planning_id": "ac7754b3-5d76-4fb8-b651-cf5854eca298",
        "parent_line_id": null,
        "owner_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
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
      "id": "994cb1e2-2df2-4274-9f86-7835bee21a91",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T13:10:14+00:00",
        "updated_at": "2022-01-13T13:10:15+00:00",
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
        "item_id": "91297216-4c5e-4d6c-bff0-8ead37e79494",
        "tax_category_id": "25f46f25-6f7b-4a38-aeb5-fc4c40b34dfe",
        "planning_id": "3b665968-8042-425d-be4a-4f6daebfd188",
        "parent_line_id": null,
        "owner_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
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
      "id": "ac7754b3-5d76-4fb8-b651-cf5854eca298",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:13+00:00",
        "updated_at": "2022-01-13T13:10:14+00:00",
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
        "item_id": "97c34b04-a603-40a6-a5ad-05b9aa5a9097",
        "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
        "start_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b",
        "stop_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b",
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
      "id": "3b665968-8042-425d-be4a-4f6daebfd188",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:14+00:00",
        "updated_at": "2022-01-13T13:10:14+00:00",
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
        "item_id": "91297216-4c5e-4d6c-bff0-8ead37e79494",
        "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09",
        "start_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b",
        "stop_location_id": "63d42bb1-0d68-4a3e-91ae-6e63c9df957b",
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
      "id": "d7cc38bc-4a5e-4f5e-b264-613f8f799b30",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:14+00:00",
        "updated_at": "2022-01-13T13:10:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66b206a3-7cd5-449d-8d8f-36e31f774d33",
        "planning_id": "3b665968-8042-425d-be4a-4f6daebfd188",
        "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09"
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
      "id": "8e219d42-6786-4b72-bd29-460269aa779d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:14+00:00",
        "updated_at": "2022-01-13T13:10:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5a0db0bc-196b-40a3-b63c-a627d78abb87",
        "planning_id": "3b665968-8042-425d-be4a-4f6daebfd188",
        "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09"
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
      "id": "de7e9183-7f00-415a-81d8-25f591b6f8d6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:14+00:00",
        "updated_at": "2022-01-13T13:10:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e01ab247-9c8d-4ca5-973a-7a188a4c2046",
        "planning_id": "3b665968-8042-425d-be4a-4f6daebfd188",
        "order_id": "de556c03-dd5a-40aa-9c8a-1587a6196c09"
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
          "order_id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a",
          "items": [
            {
              "type": "bundles",
              "id": "a6e28281-ae5e-4184-a44c-8d1d1df84b46",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "72f28324-ed61-4cb1-ac49-1891d8bfed59",
                  "id": "c966f806-f836-49e6-9972-7f2ef4f25ee7"
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
    "id": "fed34a99-a263-5925-9a9a-85cf7c8bdd21",
    "type": "order_bookings",
    "attributes": {
      "order_id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eb91f8c1-9b46-4bbc-9d62-9f9f63556527"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7e25c85d-ea54-45ca-a15d-0ca5f4ac394f"
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
      "id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-13T13:10:18+00:00",
        "updated_at": "2022-01-13T13:10:19+00:00",
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
        "starts_at": "2022-01-11T13:00:00+00:00",
        "stops_at": "2022-01-15T13:00:00+00:00",
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
        "start_location_id": "09bf45df-6c03-457c-b15f-16fe97c2b4f6",
        "stop_location_id": "09bf45df-6c03-457c-b15f-16fe97c2b4f6"
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
      "id": "eb91f8c1-9b46-4bbc-9d62-9f9f63556527",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T13:10:19+00:00",
        "updated_at": "2022-01-13T13:10:19+00:00",
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
        "item_id": "a6e28281-ae5e-4184-a44c-8d1d1df84b46",
        "tax_category_id": null,
        "planning_id": "7e25c85d-ea54-45ca-a15d-0ca5f4ac394f",
        "parent_line_id": null,
        "owner_id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a",
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
      "id": "7e25c85d-ea54-45ca-a15d-0ca5f4ac394f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T13:10:19+00:00",
        "updated_at": "2022-01-13T13:10:19+00:00",
        "quantity": 1,
        "starts_at": "2022-01-11T13:00:00+00:00",
        "stops_at": "2022-01-15T13:00:00+00:00",
        "reserved_from": "2022-01-11T13:00:00+00:00",
        "reserved_till": "2022-01-15T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a6e28281-ae5e-4184-a44c-8d1d1df84b46",
        "order_id": "55c91bed-6e2d-47d9-baba-8f2f2f20487a",
        "start_location_id": "09bf45df-6c03-457c-b15f-16fe97c2b4f6",
        "stop_location_id": "09bf45df-6c03-457c-b15f-16fe97c2b4f6",
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





