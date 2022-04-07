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
          "order_id": "ade3cbbc-7b9a-4efc-a79f-93295df87fc8",
          "items": [
            {
              "type": "products",
              "id": "4539cb72-017e-44e7-9bc4-f74bbca22f4b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "845407e3-e265-4fe5-9422-2d9853db8fcd",
              "stock_item_ids": [
                "a0063d57-a97a-439e-a46c-a39d38319cd7",
                "ac086a71-4dc1-4438-a81e-5e63983b103e"
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
            "item_id": "4539cb72-017e-44e7-9bc4-f74bbca22f4b",
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
          "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
          "items": [
            {
              "type": "products",
              "id": "ee172931-7bea-41a9-899a-04d537f2f0a2",
              "stock_item_ids": [
                "79e14ae3-ffa2-4e4b-878e-ab01b6672102",
                "a111b666-c6f2-43e6-9cd6-848ac88b653f",
                "8bbf1012-d47a-430a-9d93-b77d7b66a584"
              ]
            },
            {
              "type": "products",
              "id": "d48c95be-72b3-4cd5-b36a-23806cea4589",
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
    "id": "430a65cd-6acd-54d8-b694-3f67bdb8c6a6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dbc6b9ae-324a-4714-a2f0-e4baab903683"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "36af0862-fa15-42f4-8651-7ee165f187c0"
          },
          {
            "type": "lines",
            "id": "b7e823e8-1ec2-4374-91ef-100b44ca62e0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4e03a8d1-4da7-4bd1-abc4-f5f675bb56bd"
          },
          {
            "type": "plannings",
            "id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "439d7a88-4f7b-4ff8-aeab-1ac478b874ce"
          },
          {
            "type": "stock_item_plannings",
            "id": "910f4f4a-1322-4dfc-94a0-9bdb71ec312c"
          },
          {
            "type": "stock_item_plannings",
            "id": "9a357dff-0adc-4276-a62a-ae1c049b5e4d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T07:03:43+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
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
        "customer_id": "b1536896-1fcb-45d3-a5d2-5e6796095568",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba",
        "stop_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba"
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
      "id": "36af0862-fa15-42f4-8651-7ee165f187c0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T07:03:44+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
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
        "item_id": "d48c95be-72b3-4cd5-b36a-23806cea4589",
        "tax_category_id": "88daec77-fc65-4c60-af70-363e3e5b26d0",
        "planning_id": "4e03a8d1-4da7-4bd1-abc4-f5f675bb56bd",
        "parent_line_id": null,
        "owner_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
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
      "id": "b7e823e8-1ec2-4374-91ef-100b44ca62e0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T07:03:45+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
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
        "item_id": "ee172931-7bea-41a9-899a-04d537f2f0a2",
        "tax_category_id": "88daec77-fc65-4c60-af70-363e3e5b26d0",
        "planning_id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f",
        "parent_line_id": null,
        "owner_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
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
      "id": "4e03a8d1-4da7-4bd1-abc4-f5f675bb56bd",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:44+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
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
        "item_id": "d48c95be-72b3-4cd5-b36a-23806cea4589",
        "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
        "start_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba",
        "stop_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba",
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
      "id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:45+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
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
        "item_id": "ee172931-7bea-41a9-899a-04d537f2f0a2",
        "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683",
        "start_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba",
        "stop_location_id": "b00f5dba-3dd7-4d5d-a9c7-61eaf71af2ba",
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
      "id": "439d7a88-4f7b-4ff8-aeab-1ac478b874ce",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:45+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "79e14ae3-ffa2-4e4b-878e-ab01b6672102",
        "planning_id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f",
        "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683"
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
      "id": "910f4f4a-1322-4dfc-94a0-9bdb71ec312c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:45+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a111b666-c6f2-43e6-9cd6-848ac88b653f",
        "planning_id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f",
        "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683"
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
      "id": "9a357dff-0adc-4276-a62a-ae1c049b5e4d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:45+00:00",
        "updated_at": "2022-04-07T07:03:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8bbf1012-d47a-430a-9d93-b77d7b66a584",
        "planning_id": "978bc4d8-8177-481c-89a6-5b0dd0c1412f",
        "order_id": "dbc6b9ae-324a-4714-a2f0-e4baab903683"
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
          "order_id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06",
          "items": [
            {
              "type": "bundles",
              "id": "0e86cce2-bf09-4008-bfd7-9128188a7adb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1a03e2af-227c-45ab-b8d5-f2f1f0bc2fb7",
                  "id": "ff1793e8-fefe-4507-9d44-bd100cf21a3e"
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
    "id": "6bfd1ead-05d8-575f-97ae-2b92b783bbc9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c8122474-0d06-4533-bc61-86075a732fd1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0e72a894-0c02-4a8e-8c59-6142951f4d38"
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
      "id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T07:03:47+00:00",
        "updated_at": "2022-04-07T07:03:48+00:00",
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
        "starts_at": "2022-04-05T07:00:00+00:00",
        "stops_at": "2022-04-09T07:00:00+00:00",
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
        "start_location_id": "4addd374-bfd3-4061-be49-b046444d35e1",
        "stop_location_id": "4addd374-bfd3-4061-be49-b046444d35e1"
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
      "id": "c8122474-0d06-4533-bc61-86075a732fd1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T07:03:48+00:00",
        "updated_at": "2022-04-07T07:03:48+00:00",
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
        "item_id": "0e86cce2-bf09-4008-bfd7-9128188a7adb",
        "tax_category_id": null,
        "planning_id": "0e72a894-0c02-4a8e-8c59-6142951f4d38",
        "parent_line_id": null,
        "owner_id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06",
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
      "id": "0e72a894-0c02-4a8e-8c59-6142951f4d38",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T07:03:48+00:00",
        "updated_at": "2022-04-07T07:03:48+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-05T07:00:00+00:00",
        "stops_at": "2022-04-09T07:00:00+00:00",
        "reserved_from": "2022-04-05T07:00:00+00:00",
        "reserved_till": "2022-04-09T07:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0e86cce2-bf09-4008-bfd7-9128188a7adb",
        "order_id": "a3e0a83e-9dcb-4457-8068-ba2c4a90cc06",
        "start_location_id": "4addd374-bfd3-4061-be49-b046444d35e1",
        "stop_location_id": "4addd374-bfd3-4061-be49-b046444d35e1",
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





