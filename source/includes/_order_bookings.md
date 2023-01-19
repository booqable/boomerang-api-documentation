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
          "order_id": "85a99933-7513-4210-b5b9-bd5a25ead469",
          "items": [
            {
              "type": "products",
              "id": "d962d9da-5a4c-4d03-b4eb-14caa87d9d97",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "33b0272d-bab6-478a-9ad8-bf60dc388cdd",
              "stock_item_ids": [
                "0dae50db-ec37-48e5-8c3a-0c57af82e833",
                "ae5ab440-50a0-4384-95d8-786fbb646378"
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
            "item_id": "d962d9da-5a4c-4d03-b4eb-14caa87d9d97",
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
          "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
          "items": [
            {
              "type": "products",
              "id": "26bb39ce-0219-48c4-90c4-7440493b963d",
              "stock_item_ids": [
                "5dcf4684-3a91-42a0-9e6a-7566593f1cde",
                "f0ef1bd7-9165-4372-87af-52761d39bbcf",
                "ebf049c6-c97a-4851-9782-b1d5ef07ca1b"
              ]
            },
            {
              "type": "products",
              "id": "b81f6968-ea11-49d2-ab0a-bd996fe624ce",
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
    "id": "16018a7e-1389-5561-a3fe-de7f7466ac84",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cc44f49d-d747-4d3a-bf50-15564434e41c"
          },
          {
            "type": "lines",
            "id": "115b4d25-b3f2-450e-9bf1-97fbb319275f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c"
          },
          {
            "type": "plannings",
            "id": "7929310e-0a0c-490a-97b7-c259f8e52d79"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "02a7d2b6-d487-4abe-a842-40e3c9bf29e5"
          },
          {
            "type": "stock_item_plannings",
            "id": "60b24f18-c0c1-4ff3-a5af-0ab52fc3d17b"
          },
          {
            "type": "stock_item_plannings",
            "id": "d2fd1915-9d8a-489e-817f-088470fe37d8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-19T10:46:53+00:00",
        "updated_at": "2023-01-19T10:46:55+00:00",
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
        "customer_id": "204ea842-8ab0-47e5-a105-cebc04fedf06",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca",
        "stop_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca"
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
      "id": "cc44f49d-d747-4d3a-bf50-15564434e41c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:55+00:00",
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
        "item_id": "26bb39ce-0219-48c4-90c4-7440493b963d",
        "tax_category_id": "bb4dc653-c57b-44c1-a74a-1e113a62a547",
        "planning_id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c",
        "parent_line_id": null,
        "owner_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
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
      "id": "115b4d25-b3f2-450e-9bf1-97fbb319275f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:55+00:00",
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
        "item_id": "b81f6968-ea11-49d2-ab0a-bd996fe624ce",
        "tax_category_id": "bb4dc653-c57b-44c1-a74a-1e113a62a547",
        "planning_id": "7929310e-0a0c-490a-97b7-c259f8e52d79",
        "parent_line_id": null,
        "owner_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
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
      "id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:55+00:00",
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
        "item_id": "26bb39ce-0219-48c4-90c4-7440493b963d",
        "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
        "start_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca",
        "stop_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca",
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
      "id": "7929310e-0a0c-490a-97b7-c259f8e52d79",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:55+00:00",
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
        "item_id": "b81f6968-ea11-49d2-ab0a-bd996fe624ce",
        "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a",
        "start_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca",
        "stop_location_id": "f0220520-1a79-45ea-9d9d-9023f51f96ca",
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
      "id": "02a7d2b6-d487-4abe-a842-40e3c9bf29e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5dcf4684-3a91-42a0-9e6a-7566593f1cde",
        "planning_id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c",
        "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a"
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
      "id": "60b24f18-c0c1-4ff3-a5af-0ab52fc3d17b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f0ef1bd7-9165-4372-87af-52761d39bbcf",
        "planning_id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c",
        "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a"
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
      "id": "d2fd1915-9d8a-489e-817f-088470fe37d8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:54+00:00",
        "updated_at": "2023-01-19T10:46:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ebf049c6-c97a-4851-9782-b1d5ef07ca1b",
        "planning_id": "2e9215fe-d27a-4e89-bbba-e2f442e96e1c",
        "order_id": "cc4c37e7-40e4-4d2c-b88f-b5b6bf56ba2a"
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
          "order_id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925",
          "items": [
            {
              "type": "bundles",
              "id": "124646a8-ec06-4883-ada0-65626653e16a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "10ce427a-cd43-4420-b6c6-dab507b8d063",
                  "id": "3b0382b0-d278-4125-a17e-532a238251f9"
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
    "id": "7e2d9c5c-ecd0-5494-b4bb-13602369b079",
    "type": "order_bookings",
    "attributes": {
      "order_id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "87e772dc-6a1f-4dd1-a624-6e13c25e251d"
          },
          {
            "type": "lines",
            "id": "478eb804-423b-4e0f-a9a7-12abf5b06dba"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a29da1a1-b801-4c5e-9c17-c72af4de3ea7"
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
      "id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-19T10:46:57+00:00",
        "updated_at": "2023-01-19T10:46:57+00:00",
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
        "starts_at": "2023-01-17T10:45:00+00:00",
        "stops_at": "2023-01-21T10:45:00+00:00",
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
        "start_location_id": "32ca2ca6-492d-45a3-9485-9d998fa57518",
        "stop_location_id": "32ca2ca6-492d-45a3-9485-9d998fa57518"
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
      "id": "87e772dc-6a1f-4dd1-a624-6e13c25e251d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:46:57+00:00",
        "updated_at": "2023-01-19T10:46:57+00:00",
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
        "item_id": "3b0382b0-d278-4125-a17e-532a238251f9",
        "tax_category_id": null,
        "planning_id": "302d43cc-aebe-4b19-85a2-25e45f6cad2f",
        "parent_line_id": "478eb804-423b-4e0f-a9a7-12abf5b06dba",
        "owner_id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925",
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
      "id": "478eb804-423b-4e0f-a9a7-12abf5b06dba",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:46:57+00:00",
        "updated_at": "2023-01-19T10:46:57+00:00",
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
        "item_id": "124646a8-ec06-4883-ada0-65626653e16a",
        "tax_category_id": null,
        "planning_id": "a29da1a1-b801-4c5e-9c17-c72af4de3ea7",
        "parent_line_id": null,
        "owner_id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925",
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
      "id": "a29da1a1-b801-4c5e-9c17-c72af4de3ea7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:46:57+00:00",
        "updated_at": "2023-01-19T10:46:57+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-17T10:45:00+00:00",
        "stops_at": "2023-01-21T10:45:00+00:00",
        "reserved_from": "2023-01-17T10:45:00+00:00",
        "reserved_till": "2023-01-21T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "124646a8-ec06-4883-ada0-65626653e16a",
        "order_id": "784d1f60-cfb7-4d2d-9dcc-cc1a1c0e4925",
        "start_location_id": "32ca2ca6-492d-45a3-9485-9d998fa57518",
        "stop_location_id": "32ca2ca6-492d-45a3-9485-9d998fa57518",
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





