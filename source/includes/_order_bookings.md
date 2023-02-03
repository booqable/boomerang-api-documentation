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
          "order_id": "a92f8d06-015e-4722-8fea-ef906ade5668",
          "items": [
            {
              "type": "products",
              "id": "288cd349-887e-42bb-93eb-1b50a8d4dfea",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bc26c3bd-6945-4861-93cf-ac065226366a",
              "stock_item_ids": [
                "13b1f1f6-4885-4b8e-a1e4-4a90512f6f2c",
                "bbf06d71-7ada-465f-96b9-fdd732c1e6d3"
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
            "item_id": "288cd349-887e-42bb-93eb-1b50a8d4dfea",
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
          "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
          "items": [
            {
              "type": "products",
              "id": "e4e08ec9-ebf9-4814-a2a3-cd2a9cd1da6a",
              "stock_item_ids": [
                "78247b36-7118-4302-b851-fa57c5259924",
                "b07040b7-0a44-45e6-8d8b-b341240c32ca",
                "3d4df7c3-13da-4edb-861e-15424599ea97"
              ]
            },
            {
              "type": "products",
              "id": "66756ba0-9b49-4169-8b70-f797ca7505bf",
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
    "id": "315607a0-a744-59b0-87b7-9356efad6e8e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "319c8d0d-3f36-4a3d-8da9-cbbd57d314aa"
          },
          {
            "type": "lines",
            "id": "2a67b18a-6ab6-449f-a46f-b88a01dfb0ab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cfc589b0-9026-456d-b1eb-67db96c9abab"
          },
          {
            "type": "plannings",
            "id": "dd8b9099-3a44-4bcb-b296-0bc36e66d691"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b897de2a-c1a2-4d03-b922-d7f1da64b43a"
          },
          {
            "type": "stock_item_plannings",
            "id": "3998de04-97ed-478e-831c-c273eb71c52e"
          },
          {
            "type": "stock_item_plannings",
            "id": "f9227518-6c56-4703-8c30-0a85b052de11"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T13:10:23+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
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
        "customer_id": "777e2391-037f-4fa9-8080-996908ab6d40",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0b284770-b94b-40f3-b766-629d72866be1",
        "stop_location_id": "0b284770-b94b-40f3-b766-629d72866be1"
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
      "id": "319c8d0d-3f36-4a3d-8da9-cbbd57d314aa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
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
        "item_id": "e4e08ec9-ebf9-4814-a2a3-cd2a9cd1da6a",
        "tax_category_id": "e499f075-79de-4593-b5d5-deb8d7f899d4",
        "planning_id": "cfc589b0-9026-456d-b1eb-67db96c9abab",
        "parent_line_id": null,
        "owner_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
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
      "id": "2a67b18a-6ab6-449f-a46f-b88a01dfb0ab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
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
        "item_id": "66756ba0-9b49-4169-8b70-f797ca7505bf",
        "tax_category_id": "e499f075-79de-4593-b5d5-deb8d7f899d4",
        "planning_id": "dd8b9099-3a44-4bcb-b296-0bc36e66d691",
        "parent_line_id": null,
        "owner_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
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
      "id": "cfc589b0-9026-456d-b1eb-67db96c9abab",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
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
        "item_id": "e4e08ec9-ebf9-4814-a2a3-cd2a9cd1da6a",
        "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
        "start_location_id": "0b284770-b94b-40f3-b766-629d72866be1",
        "stop_location_id": "0b284770-b94b-40f3-b766-629d72866be1",
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
      "id": "dd8b9099-3a44-4bcb-b296-0bc36e66d691",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
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
        "item_id": "66756ba0-9b49-4169-8b70-f797ca7505bf",
        "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e",
        "start_location_id": "0b284770-b94b-40f3-b766-629d72866be1",
        "stop_location_id": "0b284770-b94b-40f3-b766-629d72866be1",
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
      "id": "b897de2a-c1a2-4d03-b922-d7f1da64b43a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "78247b36-7118-4302-b851-fa57c5259924",
        "planning_id": "cfc589b0-9026-456d-b1eb-67db96c9abab",
        "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e"
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
      "id": "3998de04-97ed-478e-831c-c273eb71c52e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b07040b7-0a44-45e6-8d8b-b341240c32ca",
        "planning_id": "cfc589b0-9026-456d-b1eb-67db96c9abab",
        "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e"
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
      "id": "f9227518-6c56-4703-8c30-0a85b052de11",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:25+00:00",
        "updated_at": "2023-02-03T13:10:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3d4df7c3-13da-4edb-861e-15424599ea97",
        "planning_id": "cfc589b0-9026-456d-b1eb-67db96c9abab",
        "order_id": "7f31d87e-ce25-437a-962b-df2dc3dcf84e"
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
          "order_id": "958a3b6d-5c20-4006-8020-7f562e989bac",
          "items": [
            {
              "type": "bundles",
              "id": "d1cff09f-7482-41cb-8770-1d3768a67267",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "aba9790c-4f1b-4e52-8a3c-ade5e623ea21",
                  "id": "4f9bc859-c43b-44a4-a590-edf836fa4059"
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
    "id": "ec1741b3-3345-5873-a954-92d10703c94c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "958a3b6d-5c20-4006-8020-7f562e989bac"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "958a3b6d-5c20-4006-8020-7f562e989bac"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "34d79c78-16cd-4efd-8864-a7f563e99a7e"
          },
          {
            "type": "lines",
            "id": "47a56067-8a18-4e4c-a3af-c35820b45084"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ce83216a-d5a3-4a77-b008-6ad15ae7a10d"
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
      "id": "958a3b6d-5c20-4006-8020-7f562e989bac",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T13:10:27+00:00",
        "updated_at": "2023-02-03T13:10:28+00:00",
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
        "starts_at": "2023-02-01T13:00:00+00:00",
        "stops_at": "2023-02-05T13:00:00+00:00",
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
        "start_location_id": "4f94d7b6-7123-4657-91a6-717e13a3b432",
        "stop_location_id": "4f94d7b6-7123-4657-91a6-717e13a3b432"
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
      "id": "34d79c78-16cd-4efd-8864-a7f563e99a7e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T13:10:28+00:00",
        "updated_at": "2023-02-03T13:10:28+00:00",
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
        "item_id": "4f9bc859-c43b-44a4-a590-edf836fa4059",
        "tax_category_id": null,
        "planning_id": "b12f8daa-5e2d-438b-8d2a-74ca3da14289",
        "parent_line_id": "47a56067-8a18-4e4c-a3af-c35820b45084",
        "owner_id": "958a3b6d-5c20-4006-8020-7f562e989bac",
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
      "id": "47a56067-8a18-4e4c-a3af-c35820b45084",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T13:10:28+00:00",
        "updated_at": "2023-02-03T13:10:28+00:00",
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
        "item_id": "d1cff09f-7482-41cb-8770-1d3768a67267",
        "tax_category_id": null,
        "planning_id": "ce83216a-d5a3-4a77-b008-6ad15ae7a10d",
        "parent_line_id": null,
        "owner_id": "958a3b6d-5c20-4006-8020-7f562e989bac",
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
      "id": "ce83216a-d5a3-4a77-b008-6ad15ae7a10d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T13:10:28+00:00",
        "updated_at": "2023-02-03T13:10:28+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T13:00:00+00:00",
        "stops_at": "2023-02-05T13:00:00+00:00",
        "reserved_from": "2023-02-01T13:00:00+00:00",
        "reserved_till": "2023-02-05T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d1cff09f-7482-41cb-8770-1d3768a67267",
        "order_id": "958a3b6d-5c20-4006-8020-7f562e989bac",
        "start_location_id": "4f94d7b6-7123-4657-91a6-717e13a3b432",
        "stop_location_id": "4f94d7b6-7123-4657-91a6-717e13a3b432",
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





