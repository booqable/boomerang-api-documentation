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
          "order_id": "cb934213-95e8-4df5-8752-68d9446921db",
          "items": [
            {
              "type": "products",
              "id": "d52d52b2-a6e6-483a-b997-6bd2196a89ea",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bb269654-d552-41eb-b717-36ee11d5d184",
              "stock_item_ids": [
                "033907df-78d3-4500-b9fa-247e366ee02d",
                "3e37fd2c-20fc-4089-b31a-96c19a09c855"
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
          "stock_item_id 033907df-78d3-4500-b9fa-247e366ee02d has already been booked on this order"
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
          "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
          "items": [
            {
              "type": "products",
              "id": "5bbbb640-bf75-49ce-952e-cf878634e23f",
              "stock_item_ids": [
                "47b0d655-f48a-44fa-bf2f-0dbf08eb4bf8",
                "8ce10abf-a48f-426a-accd-51065b2e8c60",
                "e6fd3e4d-f0a3-4bca-bab0-f9552cde891d"
              ]
            },
            {
              "type": "products",
              "id": "7776c68d-4ad6-4f60-9cde-e967f2261c54",
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
    "id": "2d9d4dd5-05f9-5191-a1bc-25e36c08542c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c0f7024e-4563-49f0-8cb1-b364d6a55023"
          },
          {
            "type": "lines",
            "id": "6850549f-d734-45d1-a83e-f8aa0276c27f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "aba09501-ab50-48ac-b7cc-bafaa8386bff"
          },
          {
            "type": "plannings",
            "id": "45798ab5-3de5-487a-87a9-6cb2eda54e2b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "15df093f-3926-4205-9f24-2ec7960e6754"
          },
          {
            "type": "stock_item_plannings",
            "id": "533cad37-84a1-40b7-9285-1256a1a6b717"
          },
          {
            "type": "stock_item_plannings",
            "id": "a2123ad2-59ab-467e-b239-79e642cf9775"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T08:41:36+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
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
        "customer_id": "ce9958dd-ad75-4584-970e-c1e12213aac8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920",
        "stop_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920"
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
      "id": "c0f7024e-4563-49f0-8cb1-b364d6a55023",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
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
        "item_id": "5bbbb640-bf75-49ce-952e-cf878634e23f",
        "tax_category_id": "8cf5c83d-8955-4ad2-84b1-a926f5cfe3e0",
        "planning_id": "aba09501-ab50-48ac-b7cc-bafaa8386bff",
        "parent_line_id": null,
        "owner_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
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
      "id": "6850549f-d734-45d1-a83e-f8aa0276c27f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
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
        "item_id": "7776c68d-4ad6-4f60-9cde-e967f2261c54",
        "tax_category_id": "8cf5c83d-8955-4ad2-84b1-a926f5cfe3e0",
        "planning_id": "45798ab5-3de5-487a-87a9-6cb2eda54e2b",
        "parent_line_id": null,
        "owner_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
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
      "id": "aba09501-ab50-48ac-b7cc-bafaa8386bff",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
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
        "item_id": "5bbbb640-bf75-49ce-952e-cf878634e23f",
        "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
        "start_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920",
        "stop_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920",
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
      "id": "45798ab5-3de5-487a-87a9-6cb2eda54e2b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
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
        "item_id": "7776c68d-4ad6-4f60-9cde-e967f2261c54",
        "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb",
        "start_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920",
        "stop_location_id": "f3ee8f4f-c53f-433e-8139-59fd2dcf0920",
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
      "id": "15df093f-3926-4205-9f24-2ec7960e6754",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "47b0d655-f48a-44fa-bf2f-0dbf08eb4bf8",
        "planning_id": "aba09501-ab50-48ac-b7cc-bafaa8386bff",
        "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb"
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
      "id": "533cad37-84a1-40b7-9285-1256a1a6b717",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8ce10abf-a48f-426a-accd-51065b2e8c60",
        "planning_id": "aba09501-ab50-48ac-b7cc-bafaa8386bff",
        "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb"
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
      "id": "a2123ad2-59ab-467e-b239-79e642cf9775",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:38+00:00",
        "updated_at": "2023-02-22T08:41:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e6fd3e4d-f0a3-4bca-bab0-f9552cde891d",
        "planning_id": "aba09501-ab50-48ac-b7cc-bafaa8386bff",
        "order_id": "3dcc1de0-0cdf-4e1c-b335-ce4fc26621cb"
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
          "order_id": "846cdca6-2e1a-499c-af09-de54f7c463ad",
          "items": [
            {
              "type": "bundles",
              "id": "ec19acbc-a7ac-40bb-9bcb-6ba2322bec39",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "062bee1e-d02b-432c-b971-62d59d4abade",
                  "id": "690a66d3-dd10-4396-88c2-3c00dd14a807"
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
    "id": "977b46dd-0ac1-5211-9efc-d50a8ecf6e1f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "846cdca6-2e1a-499c-af09-de54f7c463ad"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "846cdca6-2e1a-499c-af09-de54f7c463ad"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e1e4faed-bf7a-427f-adc9-7e650b77dca5"
          },
          {
            "type": "lines",
            "id": "ef507841-755a-4491-9eac-6dd79a390c77"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "061d15ed-72d2-4274-9488-b1460f457cc7"
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
      "id": "846cdca6-2e1a-499c-af09-de54f7c463ad",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T08:41:40+00:00",
        "updated_at": "2023-02-22T08:41:41+00:00",
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
        "starts_at": "2023-02-20T08:30:00+00:00",
        "stops_at": "2023-02-24T08:30:00+00:00",
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
        "start_location_id": "e9fe9daf-812b-4140-a1dd-4a693a0a683a",
        "stop_location_id": "e9fe9daf-812b-4140-a1dd-4a693a0a683a"
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
      "id": "e1e4faed-bf7a-427f-adc9-7e650b77dca5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T08:41:41+00:00",
        "updated_at": "2023-02-22T08:41:41+00:00",
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
        "item_id": "ec19acbc-a7ac-40bb-9bcb-6ba2322bec39",
        "tax_category_id": null,
        "planning_id": "061d15ed-72d2-4274-9488-b1460f457cc7",
        "parent_line_id": null,
        "owner_id": "846cdca6-2e1a-499c-af09-de54f7c463ad",
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
      "id": "ef507841-755a-4491-9eac-6dd79a390c77",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T08:41:41+00:00",
        "updated_at": "2023-02-22T08:41:41+00:00",
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
        "item_id": "690a66d3-dd10-4396-88c2-3c00dd14a807",
        "tax_category_id": null,
        "planning_id": "6e9bb975-0758-4418-b37c-f8d1cea49e65",
        "parent_line_id": "e1e4faed-bf7a-427f-adc9-7e650b77dca5",
        "owner_id": "846cdca6-2e1a-499c-af09-de54f7c463ad",
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
      "id": "061d15ed-72d2-4274-9488-b1460f457cc7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T08:41:41+00:00",
        "updated_at": "2023-02-22T08:41:41+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-20T08:30:00+00:00",
        "stops_at": "2023-02-24T08:30:00+00:00",
        "reserved_from": "2023-02-20T08:30:00+00:00",
        "reserved_till": "2023-02-24T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ec19acbc-a7ac-40bb-9bcb-6ba2322bec39",
        "order_id": "846cdca6-2e1a-499c-af09-de54f7c463ad",
        "start_location_id": "e9fe9daf-812b-4140-a1dd-4a693a0a683a",
        "stop_location_id": "e9fe9daf-812b-4140-a1dd-4a693a0a683a",
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





