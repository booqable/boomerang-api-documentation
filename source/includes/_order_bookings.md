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
          "order_id": "9d84cf6e-f016-4566-988c-539eb8244221",
          "items": [
            {
              "type": "products",
              "id": "df756eea-5e55-4035-9440-abf2522a530d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "746bfb7d-620c-406f-91f0-a5502ed7ba23",
              "stock_item_ids": [
                "42174f1b-d9c4-43a4-ab1d-b9cabf6ee21b",
                "46534135-a5f6-4409-90f5-f078a73c6547"
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
            "item_id": "df756eea-5e55-4035-9440-abf2522a530d",
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
          "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
          "items": [
            {
              "type": "products",
              "id": "88c8e10e-88dd-4f00-9f01-ff19ecdbe0c8",
              "stock_item_ids": [
                "716a89c3-4e72-442e-a7cf-4e7af50c32d5",
                "8c68fcba-3b50-49be-ad78-d073e7f8ec2b",
                "bbbac257-5c8d-4b72-82e8-612ba23f0a14"
              ]
            },
            {
              "type": "products",
              "id": "36b0a7ed-67cb-4d9a-b9de-5492d1947837",
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
    "id": "d2e0e2c9-c7cf-5f3a-9894-610b9e11b339",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9cd0273d-a45a-4d00-ae00-b9f0db1008a1"
          },
          {
            "type": "lines",
            "id": "14e05168-72de-4595-905f-65c844cde8d7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "65d73f55-90c4-4c80-a1b2-482961c9e057"
          },
          {
            "type": "plannings",
            "id": "88126ecd-4038-405e-9192-e6185cdf3576"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a21cde5c-f116-48e4-a90a-a9f7c1836fce"
          },
          {
            "type": "stock_item_plannings",
            "id": "17dd7bf8-8ccc-438a-91ab-9c71acdfcff2"
          },
          {
            "type": "stock_item_plannings",
            "id": "4d3bd63f-195d-4824-9318-1e692ea6b4e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T09:41:10+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
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
        "customer_id": "421a89bf-4040-4aaf-8ed7-d126fab11d3d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187",
        "stop_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187"
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
      "id": "9cd0273d-a45a-4d00-ae00-b9f0db1008a1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
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
        "item_id": "88c8e10e-88dd-4f00-9f01-ff19ecdbe0c8",
        "tax_category_id": "f1f392ee-d413-476a-af69-28e09f5a1906",
        "planning_id": "65d73f55-90c4-4c80-a1b2-482961c9e057",
        "parent_line_id": null,
        "owner_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
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
      "id": "14e05168-72de-4595-905f-65c844cde8d7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
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
        "item_id": "36b0a7ed-67cb-4d9a-b9de-5492d1947837",
        "tax_category_id": "f1f392ee-d413-476a-af69-28e09f5a1906",
        "planning_id": "88126ecd-4038-405e-9192-e6185cdf3576",
        "parent_line_id": null,
        "owner_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
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
      "id": "65d73f55-90c4-4c80-a1b2-482961c9e057",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
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
        "item_id": "88c8e10e-88dd-4f00-9f01-ff19ecdbe0c8",
        "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
        "start_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187",
        "stop_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187",
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
      "id": "88126ecd-4038-405e-9192-e6185cdf3576",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
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
        "item_id": "36b0a7ed-67cb-4d9a-b9de-5492d1947837",
        "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2",
        "start_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187",
        "stop_location_id": "a158a5e0-6fea-4904-862c-54ecfe2a1187",
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
      "id": "a21cde5c-f116-48e4-a90a-a9f7c1836fce",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "716a89c3-4e72-442e-a7cf-4e7af50c32d5",
        "planning_id": "65d73f55-90c4-4c80-a1b2-482961c9e057",
        "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2"
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
      "id": "17dd7bf8-8ccc-438a-91ab-9c71acdfcff2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8c68fcba-3b50-49be-ad78-d073e7f8ec2b",
        "planning_id": "65d73f55-90c4-4c80-a1b2-482961c9e057",
        "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2"
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
      "id": "4d3bd63f-195d-4824-9318-1e692ea6b4e4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:12+00:00",
        "updated_at": "2023-02-09T09:41:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bbbac257-5c8d-4b72-82e8-612ba23f0a14",
        "planning_id": "65d73f55-90c4-4c80-a1b2-482961c9e057",
        "order_id": "aa19b3fc-e6c8-4dbe-ae07-f9f7a68468f2"
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
          "order_id": "f9606016-4576-4bb0-b068-411e2c73db49",
          "items": [
            {
              "type": "bundles",
              "id": "997067a1-9b09-4ee4-b52c-cfc6cb171618",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "869bf1fb-6706-4799-a7fd-4ac66256b272",
                  "id": "2684cc6e-a013-412a-9f75-87754ec30be3"
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
    "id": "20dac347-3470-5e49-a8d7-acba522ad8fd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f9606016-4576-4bb0-b068-411e2c73db49"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f9606016-4576-4bb0-b068-411e2c73db49"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "47c4c39b-8d52-4830-a993-88bdaaed2b50"
          },
          {
            "type": "lines",
            "id": "8f9254e5-6759-4c15-896f-7e165856cb33"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3af14e30-e81c-466e-a0cf-9620ab86f099"
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
      "id": "f9606016-4576-4bb0-b068-411e2c73db49",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T09:41:15+00:00",
        "updated_at": "2023-02-09T09:41:15+00:00",
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
        "starts_at": "2023-02-07T09:30:00+00:00",
        "stops_at": "2023-02-11T09:30:00+00:00",
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
        "start_location_id": "ee3144f5-c569-4b43-9f82-df6292608201",
        "stop_location_id": "ee3144f5-c569-4b43-9f82-df6292608201"
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
      "id": "47c4c39b-8d52-4830-a993-88bdaaed2b50",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:41:15+00:00",
        "updated_at": "2023-02-09T09:41:15+00:00",
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
        "item_id": "997067a1-9b09-4ee4-b52c-cfc6cb171618",
        "tax_category_id": null,
        "planning_id": "3af14e30-e81c-466e-a0cf-9620ab86f099",
        "parent_line_id": null,
        "owner_id": "f9606016-4576-4bb0-b068-411e2c73db49",
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
      "id": "8f9254e5-6759-4c15-896f-7e165856cb33",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T09:41:15+00:00",
        "updated_at": "2023-02-09T09:41:15+00:00",
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
        "item_id": "2684cc6e-a013-412a-9f75-87754ec30be3",
        "tax_category_id": null,
        "planning_id": "66f7c4c3-8784-449d-b56b-b287894285a6",
        "parent_line_id": "47c4c39b-8d52-4830-a993-88bdaaed2b50",
        "owner_id": "f9606016-4576-4bb0-b068-411e2c73db49",
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
      "id": "3af14e30-e81c-466e-a0cf-9620ab86f099",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T09:41:15+00:00",
        "updated_at": "2023-02-09T09:41:15+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T09:30:00+00:00",
        "stops_at": "2023-02-11T09:30:00+00:00",
        "reserved_from": "2023-02-07T09:30:00+00:00",
        "reserved_till": "2023-02-11T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "997067a1-9b09-4ee4-b52c-cfc6cb171618",
        "order_id": "f9606016-4576-4bb0-b068-411e2c73db49",
        "start_location_id": "ee3144f5-c569-4b43-9f82-df6292608201",
        "stop_location_id": "ee3144f5-c569-4b43-9f82-df6292608201",
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





