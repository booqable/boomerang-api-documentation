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
          "order_id": "9fcc5c66-3acf-4fcd-bdf1-765927197d9b",
          "items": [
            {
              "type": "products",
              "id": "5ddb1263-14db-4db5-97b5-54898cf7ee83",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "74f9e348-ac66-4c23-a12b-47864bd08138",
              "stock_item_ids": [
                "dff5af6a-a841-4597-a050-33a06206a1e2",
                "67918f7a-002d-43cc-b29b-62cea1894f4f"
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
          "stock_item_id dff5af6a-a841-4597-a050-33a06206a1e2 has already been booked on this order"
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
          "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
          "items": [
            {
              "type": "products",
              "id": "4fc97818-c0e0-4c92-8157-1f7ce20db063",
              "stock_item_ids": [
                "1bace793-4e97-434d-9a3b-ce263b10d450",
                "cc7bd93b-4767-459d-bfba-20d8f08ff091",
                "9e909179-68f2-4833-b4a2-0243da9bf1c0"
              ]
            },
            {
              "type": "products",
              "id": "75ab4a59-95fc-4f48-9c9d-a1a4e424aa43",
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
    "id": "50810bec-216a-5fe6-908f-3cd0809991d9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "be7a87f4-621a-4bbb-be93-c3fd4c7bac59"
          },
          {
            "type": "lines",
            "id": "6c566cf4-2599-49f1-a86e-2578700919e3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76"
          },
          {
            "type": "plannings",
            "id": "6557afdc-2ba1-4c96-91c6-00491c8d1adf"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "189e19c8-65db-43c6-8c1c-0689bcb69c9f"
          },
          {
            "type": "stock_item_plannings",
            "id": "9dc8ddbb-47ce-4fb0-8ebb-b802ec274798"
          },
          {
            "type": "stock_item_plannings",
            "id": "02c387bd-54a8-43fb-8cc3-de291773a3e1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T16:22:57+00:00",
        "updated_at": "2023-02-21T16:22:59+00:00",
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
        "customer_id": "db237145-ebea-4172-88c3-d8cbaf268385",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc",
        "stop_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc"
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
      "id": "be7a87f4-621a-4bbb-be93-c3fd4c7bac59",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:59+00:00",
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
        "item_id": "4fc97818-c0e0-4c92-8157-1f7ce20db063",
        "tax_category_id": "bd9073cd-7e52-4542-b08a-57577015fcb4",
        "planning_id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76",
        "parent_line_id": null,
        "owner_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
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
      "id": "6c566cf4-2599-49f1-a86e-2578700919e3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:59+00:00",
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
        "item_id": "75ab4a59-95fc-4f48-9c9d-a1a4e424aa43",
        "tax_category_id": "bd9073cd-7e52-4542-b08a-57577015fcb4",
        "planning_id": "6557afdc-2ba1-4c96-91c6-00491c8d1adf",
        "parent_line_id": null,
        "owner_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
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
      "id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:58+00:00",
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
        "item_id": "4fc97818-c0e0-4c92-8157-1f7ce20db063",
        "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
        "start_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc",
        "stop_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc",
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
      "id": "6557afdc-2ba1-4c96-91c6-00491c8d1adf",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:58+00:00",
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
        "item_id": "75ab4a59-95fc-4f48-9c9d-a1a4e424aa43",
        "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b",
        "start_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc",
        "stop_location_id": "57e9a087-a835-4222-a1f6-8d0c82248adc",
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
      "id": "189e19c8-65db-43c6-8c1c-0689bcb69c9f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1bace793-4e97-434d-9a3b-ce263b10d450",
        "planning_id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76",
        "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b"
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
      "id": "9dc8ddbb-47ce-4fb0-8ebb-b802ec274798",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cc7bd93b-4767-459d-bfba-20d8f08ff091",
        "planning_id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76",
        "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b"
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
      "id": "02c387bd-54a8-43fb-8cc3-de291773a3e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:22:58+00:00",
        "updated_at": "2023-02-21T16:22:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9e909179-68f2-4833-b4a2-0243da9bf1c0",
        "planning_id": "fe49bfa7-46cb-4fb9-a781-833f240eeb76",
        "order_id": "7b28abfe-7a4d-46de-a1d3-6126c76da71b"
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
          "order_id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd",
          "items": [
            {
              "type": "bundles",
              "id": "643cca45-1863-4819-9039-eb86964266a5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8ac76552-0be6-4d11-9c5a-e0eb54b15068",
                  "id": "be70e2de-9039-40dd-bc81-eab9fbb50a42"
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
    "id": "d2fff36a-0730-5353-9452-8fa1862feddc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "87e1df12-2ab5-4e22-b527-3f4aeb914e7d"
          },
          {
            "type": "lines",
            "id": "81aa972e-95f6-4c14-a9ca-0a1ec9885c9c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d1e1fc2c-f506-4c2b-b8df-4a5a58df4ebe"
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
      "id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T16:23:01+00:00",
        "updated_at": "2023-02-21T16:23:02+00:00",
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
        "starts_at": "2023-02-19T16:15:00+00:00",
        "stops_at": "2023-02-23T16:15:00+00:00",
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
        "start_location_id": "cfc2733d-1c3e-42e0-a0a9-c6b29471b193",
        "stop_location_id": "cfc2733d-1c3e-42e0-a0a9-c6b29471b193"
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
      "id": "87e1df12-2ab5-4e22-b527-3f4aeb914e7d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:23:02+00:00",
        "updated_at": "2023-02-21T16:23:02+00:00",
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
        "item_id": "be70e2de-9039-40dd-bc81-eab9fbb50a42",
        "tax_category_id": null,
        "planning_id": "78505398-cfa8-4884-81a1-d1f6610dc165",
        "parent_line_id": "81aa972e-95f6-4c14-a9ca-0a1ec9885c9c",
        "owner_id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd",
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
      "id": "81aa972e-95f6-4c14-a9ca-0a1ec9885c9c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:23:02+00:00",
        "updated_at": "2023-02-21T16:23:02+00:00",
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
        "item_id": "643cca45-1863-4819-9039-eb86964266a5",
        "tax_category_id": null,
        "planning_id": "d1e1fc2c-f506-4c2b-b8df-4a5a58df4ebe",
        "parent_line_id": null,
        "owner_id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd",
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
      "id": "d1e1fc2c-f506-4c2b-b8df-4a5a58df4ebe",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:23:02+00:00",
        "updated_at": "2023-02-21T16:23:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T16:15:00+00:00",
        "stops_at": "2023-02-23T16:15:00+00:00",
        "reserved_from": "2023-02-19T16:15:00+00:00",
        "reserved_till": "2023-02-23T16:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "643cca45-1863-4819-9039-eb86964266a5",
        "order_id": "669d5daf-1bab-4eb1-ac0e-0d02f8e310bd",
        "start_location_id": "cfc2733d-1c3e-42e0-a0a9-c6b29471b193",
        "stop_location_id": "cfc2733d-1c3e-42e0-a0a9-c6b29471b193",
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





