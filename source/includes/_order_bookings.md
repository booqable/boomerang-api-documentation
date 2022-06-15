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
          "order_id": "50491c26-5817-4129-a68e-a511657c3c04",
          "items": [
            {
              "type": "products",
              "id": "f6287f77-dfb9-4b81-8ed1-b0e57178abbb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e3d696c8-b6ed-4b47-ae7c-3066802ddf75",
              "stock_item_ids": [
                "7e0db2cd-e908-4c37-bb12-5fae63fff09b",
                "f90f3538-4954-42cf-ad2c-1c31be073ee5"
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
            "item_id": "f6287f77-dfb9-4b81-8ed1-b0e57178abbb",
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
          "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
          "items": [
            {
              "type": "products",
              "id": "f05ebb97-cf57-45cb-9705-a9c1a788559e",
              "stock_item_ids": [
                "68c9defb-10ec-4ef0-989b-5b2be1c20672",
                "c93408d2-003c-4f37-9e00-da8bbda3ec14",
                "9ea18f99-107c-4a87-a1bd-dea1d34fe072"
              ]
            },
            {
              "type": "products",
              "id": "e8e428dc-be60-4b65-a427-300ffc3067be",
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
    "id": "3d45920d-555f-5a8e-82e7-260cee4f89f8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f0a5e555-5ca6-4577-ba97-4db784e44e73"
          },
          {
            "type": "lines",
            "id": "5c50b88f-9ffe-4bae-a243-664bfc5426eb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "01822333-2462-481b-9f79-c12247bb1b46"
          },
          {
            "type": "plannings",
            "id": "b66143f3-ed39-4256-94b9-012ae05403e7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4435ccdc-ee95-4d2f-b99b-e34c7f607a45"
          },
          {
            "type": "stock_item_plannings",
            "id": "fa64377b-1438-436f-b85c-dd324dd05610"
          },
          {
            "type": "stock_item_plannings",
            "id": "b6a54723-be4b-410b-8c01-3bd4b02f9606"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-15T09:35:46+00:00",
        "updated_at": "2022-06-15T09:35:49+00:00",
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
        "customer_id": "6e9c3a96-4e1b-40f1-8c9e-904a0dbc04bc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "978022b7-c360-4027-acbc-b8a69e061298",
        "stop_location_id": "978022b7-c360-4027-acbc-b8a69e061298"
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
      "id": "f0a5e555-5ca6-4577-ba97-4db784e44e73",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-15T09:35:47+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
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
        "item_id": "e8e428dc-be60-4b65-a427-300ffc3067be",
        "tax_category_id": "ce2aa258-0664-4249-abc2-05f69b048488",
        "planning_id": "01822333-2462-481b-9f79-c12247bb1b46",
        "parent_line_id": null,
        "owner_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
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
      "id": "5c50b88f-9ffe-4bae-a243-664bfc5426eb",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-15T09:35:48+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
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
        "item_id": "f05ebb97-cf57-45cb-9705-a9c1a788559e",
        "tax_category_id": "ce2aa258-0664-4249-abc2-05f69b048488",
        "planning_id": "b66143f3-ed39-4256-94b9-012ae05403e7",
        "parent_line_id": null,
        "owner_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
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
      "id": "01822333-2462-481b-9f79-c12247bb1b46",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:47+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
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
        "item_id": "e8e428dc-be60-4b65-a427-300ffc3067be",
        "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
        "start_location_id": "978022b7-c360-4027-acbc-b8a69e061298",
        "stop_location_id": "978022b7-c360-4027-acbc-b8a69e061298",
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
      "id": "b66143f3-ed39-4256-94b9-012ae05403e7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:48+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
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
        "item_id": "f05ebb97-cf57-45cb-9705-a9c1a788559e",
        "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b",
        "start_location_id": "978022b7-c360-4027-acbc-b8a69e061298",
        "stop_location_id": "978022b7-c360-4027-acbc-b8a69e061298",
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
      "id": "4435ccdc-ee95-4d2f-b99b-e34c7f607a45",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:48+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "68c9defb-10ec-4ef0-989b-5b2be1c20672",
        "planning_id": "b66143f3-ed39-4256-94b9-012ae05403e7",
        "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b"
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
      "id": "fa64377b-1438-436f-b85c-dd324dd05610",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:48+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c93408d2-003c-4f37-9e00-da8bbda3ec14",
        "planning_id": "b66143f3-ed39-4256-94b9-012ae05403e7",
        "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b"
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
      "id": "b6a54723-be4b-410b-8c01-3bd4b02f9606",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:48+00:00",
        "updated_at": "2022-06-15T09:35:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ea18f99-107c-4a87-a1bd-dea1d34fe072",
        "planning_id": "b66143f3-ed39-4256-94b9-012ae05403e7",
        "order_id": "c7bd1cec-90a0-4d99-b9fd-bb23ea478d9b"
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
          "order_id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca",
          "items": [
            {
              "type": "bundles",
              "id": "0c886eae-5825-4ea0-ab2c-dd75645e7ffe",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "91e78cc6-83e1-40c5-b1a8-0ff0d90f5b6e",
                  "id": "2d99f2c2-60ad-41d1-862d-ed1dfdc2b585"
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
    "id": "07c0f869-82a5-5e50-b87f-c2e35a28c60e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "90c7bc21-c250-4086-8ff8-133ce1cbd4c2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ec3bd721-118d-49e2-b50c-4b0c7775c033"
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
      "id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-15T09:35:50+00:00",
        "updated_at": "2022-06-15T09:35:51+00:00",
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
        "starts_at": "2022-06-13T09:30:00+00:00",
        "stops_at": "2022-06-17T09:30:00+00:00",
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
        "start_location_id": "3a61d012-f475-4218-a68e-08edab3fddc0",
        "stop_location_id": "3a61d012-f475-4218-a68e-08edab3fddc0"
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
      "id": "90c7bc21-c250-4086-8ff8-133ce1cbd4c2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-15T09:35:51+00:00",
        "updated_at": "2022-06-15T09:35:51+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "0c886eae-5825-4ea0-ab2c-dd75645e7ffe",
        "tax_category_id": null,
        "planning_id": "ec3bd721-118d-49e2-b50c-4b0c7775c033",
        "parent_line_id": null,
        "owner_id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca",
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
      "id": "ec3bd721-118d-49e2-b50c-4b0c7775c033",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-15T09:35:51+00:00",
        "updated_at": "2022-06-15T09:35:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-13T09:30:00+00:00",
        "stops_at": "2022-06-17T09:30:00+00:00",
        "reserved_from": "2022-06-13T09:30:00+00:00",
        "reserved_till": "2022-06-17T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0c886eae-5825-4ea0-ab2c-dd75645e7ffe",
        "order_id": "34ac4ff2-cc73-4d95-8e4b-d1a04bd80fca",
        "start_location_id": "3a61d012-f475-4218-a68e-08edab3fddc0",
        "stop_location_id": "3a61d012-f475-4218-a68e-08edab3fddc0",
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





