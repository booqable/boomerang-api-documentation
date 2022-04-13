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
          "order_id": "5f137373-29fb-42ab-a61d-6fe22ad286ea",
          "items": [
            {
              "type": "products",
              "id": "e6003d51-43f7-4e9b-b5bc-d4277229676e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8f447688-b56b-4f84-94ee-d0c042541e7f",
              "stock_item_ids": [
                "843e0bb2-e6db-496b-bdc8-572b834d05a2",
                "b982aee8-e53d-4011-ab02-25ea1d0f8d54"
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
            "item_id": "e6003d51-43f7-4e9b-b5bc-d4277229676e",
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
          "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
          "items": [
            {
              "type": "products",
              "id": "ee9b21a2-4399-4cfb-9b90-061135102801",
              "stock_item_ids": [
                "42917324-14c6-4539-8bec-072da51e6492",
                "7d554754-64ba-4f6f-a3d3-17de7079b84f",
                "170d6aee-28a7-429c-814f-5a86043f4379"
              ]
            },
            {
              "type": "products",
              "id": "49e3e521-9a36-4838-a259-4a664703f923",
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
    "id": "af10ae73-1987-54e7-87e9-d8206c7b9e4c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c9e236ff-112c-4e93-a5c6-ad643d3c4d6b"
          },
          {
            "type": "lines",
            "id": "363cc9ef-1fb6-44c5-8b4e-ea9305e92fd3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8570b400-aa66-490d-bc23-e12f4d6a3593"
          },
          {
            "type": "plannings",
            "id": "74f7f741-a292-42fd-88ad-f90183374e46"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "50fe7ece-4b4d-4c28-8f5e-8c9cda8f5d47"
          },
          {
            "type": "stock_item_plannings",
            "id": "489a1dc4-1db9-42f4-8d16-4885241d73d9"
          },
          {
            "type": "stock_item_plannings",
            "id": "7489ce18-cea4-4fdb-8b3d-38a38f2dbc35"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T07:11:30+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
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
        "customer_id": "fdd8f025-0fe5-44f9-86a6-c0a0b96b17f8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8",
        "stop_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8"
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
      "id": "c9e236ff-112c-4e93-a5c6-ad643d3c4d6b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
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
        "item_id": "49e3e521-9a36-4838-a259-4a664703f923",
        "tax_category_id": "21bd2eae-a5da-4225-aee0-a9850ea65ebb",
        "planning_id": "8570b400-aa66-490d-bc23-e12f4d6a3593",
        "parent_line_id": null,
        "owner_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
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
      "id": "363cc9ef-1fb6-44c5-8b4e-ea9305e92fd3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T07:11:32+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
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
        "item_id": "ee9b21a2-4399-4cfb-9b90-061135102801",
        "tax_category_id": "21bd2eae-a5da-4225-aee0-a9850ea65ebb",
        "planning_id": "74f7f741-a292-42fd-88ad-f90183374e46",
        "parent_line_id": null,
        "owner_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
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
      "id": "8570b400-aa66-490d-bc23-e12f4d6a3593",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
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
        "item_id": "49e3e521-9a36-4838-a259-4a664703f923",
        "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
        "start_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8",
        "stop_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8",
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
      "id": "74f7f741-a292-42fd-88ad-f90183374e46",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
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
        "item_id": "ee9b21a2-4399-4cfb-9b90-061135102801",
        "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613",
        "start_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8",
        "stop_location_id": "a6c29727-e17e-4cf1-a3a1-0dc5f545c9e8",
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
      "id": "50fe7ece-4b4d-4c28-8f5e-8c9cda8f5d47",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "42917324-14c6-4539-8bec-072da51e6492",
        "planning_id": "74f7f741-a292-42fd-88ad-f90183374e46",
        "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613"
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
      "id": "489a1dc4-1db9-42f4-8d16-4885241d73d9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7d554754-64ba-4f6f-a3d3-17de7079b84f",
        "planning_id": "74f7f741-a292-42fd-88ad-f90183374e46",
        "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613"
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
      "id": "7489ce18-cea4-4fdb-8b3d-38a38f2dbc35",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:31+00:00",
        "updated_at": "2022-04-13T07:11:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "170d6aee-28a7-429c-814f-5a86043f4379",
        "planning_id": "74f7f741-a292-42fd-88ad-f90183374e46",
        "order_id": "9ebecbf1-0340-4a58-86fd-bdbdac0cd613"
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
          "order_id": "053d880e-e542-4df4-93c5-033cfab4e886",
          "items": [
            {
              "type": "bundles",
              "id": "01d6963a-dcf4-455a-9569-6be7143f13c6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a04b1be2-6b62-4e99-a786-1cb089218c47",
                  "id": "deb6c84d-3754-4c92-80bd-8915b95c9f34"
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
    "id": "75ccee24-94ca-5694-a7c0-f483a2bdb38c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "053d880e-e542-4df4-93c5-033cfab4e886"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "053d880e-e542-4df4-93c5-033cfab4e886"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4c7917a5-1cdb-435b-852b-3f09e1563333"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3fbb7268-56a0-4ed6-bb59-3c33e3f0fb3d"
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
      "id": "053d880e-e542-4df4-93c5-033cfab4e886",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T07:11:34+00:00",
        "updated_at": "2022-04-13T07:11:36+00:00",
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
        "starts_at": "2022-04-11T07:00:00+00:00",
        "stops_at": "2022-04-15T07:00:00+00:00",
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
        "start_location_id": "cb3e17cf-859e-4bd6-acc1-8e08e56a74a2",
        "stop_location_id": "cb3e17cf-859e-4bd6-acc1-8e08e56a74a2"
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
      "id": "4c7917a5-1cdb-435b-852b-3f09e1563333",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T07:11:35+00:00",
        "updated_at": "2022-04-13T07:11:35+00:00",
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
        "item_id": "01d6963a-dcf4-455a-9569-6be7143f13c6",
        "tax_category_id": null,
        "planning_id": "3fbb7268-56a0-4ed6-bb59-3c33e3f0fb3d",
        "parent_line_id": null,
        "owner_id": "053d880e-e542-4df4-93c5-033cfab4e886",
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
      "id": "3fbb7268-56a0-4ed6-bb59-3c33e3f0fb3d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T07:11:35+00:00",
        "updated_at": "2022-04-13T07:11:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-11T07:00:00+00:00",
        "stops_at": "2022-04-15T07:00:00+00:00",
        "reserved_from": "2022-04-11T07:00:00+00:00",
        "reserved_till": "2022-04-15T07:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "01d6963a-dcf4-455a-9569-6be7143f13c6",
        "order_id": "053d880e-e542-4df4-93c5-033cfab4e886",
        "start_location_id": "cb3e17cf-859e-4bd6-acc1-8e08e56a74a2",
        "stop_location_id": "cb3e17cf-859e-4bd6-acc1-8e08e56a74a2",
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





