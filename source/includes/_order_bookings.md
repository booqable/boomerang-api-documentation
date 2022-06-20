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
          "order_id": "e869da96-cabe-4c6d-b46d-901e9153511a",
          "items": [
            {
              "type": "products",
              "id": "92210f34-c81a-4a28-867a-a4ea7d015efe",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0592b3d8-5850-4e2d-8e1b-07df970ad123",
              "stock_item_ids": [
                "f1e4988f-82db-4b4b-ad22-f549ba0c0267",
                "8946630b-ccbf-4866-a1ee-8738ddf7b4d5"
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
            "item_id": "92210f34-c81a-4a28-867a-a4ea7d015efe",
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
          "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba",
          "items": [
            {
              "type": "products",
              "id": "05c5551d-5c73-45fa-84ee-b7fca3854877",
              "stock_item_ids": [
                "d74c9cba-90dc-4d6b-b196-71e77ae85ec3",
                "3fa7d8a0-69d9-4c1e-850a-cf36374fef39",
                "ddd51caa-6002-4ff6-b0c9-09b3874a4c49"
              ]
            },
            {
              "type": "products",
              "id": "c29e3511-65a5-429d-aca6-83f3c7ef1351",
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
    "id": "dc8d8f2d-ef70-5482-81f6-7796c1492132",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c0ea7042-4142-475c-8922-21dffdc558ba"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "472dd130-913f-4b02-9038-0a71d03c3e04"
          },
          {
            "type": "lines",
            "id": "9df553dd-7354-4c97-a437-2943b20e1722"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "26650ab6-4e74-4d7c-a9f0-434f481c5bd3"
          },
          {
            "type": "plannings",
            "id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5b8c9c41-28e2-40bb-8347-82ac372a192d"
          },
          {
            "type": "stock_item_plannings",
            "id": "a594fcf7-2a43-45a5-a4c2-1f40547c1402"
          },
          {
            "type": "stock_item_plannings",
            "id": "ec2ac3b1-a12b-48df-88e2-75c44a24820e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c0ea7042-4142-475c-8922-21dffdc558ba",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-08T18:20:39+00:00",
        "updated_at": "2022-04-08T18:20:42+00:00",
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
        "customer_id": "cca79d91-566b-478b-a689-55e3ccaea64e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c",
        "stop_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c"
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
      "id": "472dd130-913f-4b02-9038-0a71d03c3e04",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-08T18:20:40+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
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
        "item_id": "c29e3511-65a5-429d-aca6-83f3c7ef1351",
        "tax_category_id": "83cbaded-8300-479c-be18-3aa9c6088b16",
        "planning_id": "26650ab6-4e74-4d7c-a9f0-434f481c5bd3",
        "parent_line_id": null,
        "owner_id": "c0ea7042-4142-475c-8922-21dffdc558ba",
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
      "id": "9df553dd-7354-4c97-a437-2943b20e1722",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-08T18:20:41+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
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
        "item_id": "05c5551d-5c73-45fa-84ee-b7fca3854877",
        "tax_category_id": "83cbaded-8300-479c-be18-3aa9c6088b16",
        "planning_id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d",
        "parent_line_id": null,
        "owner_id": "c0ea7042-4142-475c-8922-21dffdc558ba",
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
      "id": "26650ab6-4e74-4d7c-a9f0-434f481c5bd3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:40+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
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
        "item_id": "c29e3511-65a5-429d-aca6-83f3c7ef1351",
        "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba",
        "start_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c",
        "stop_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c",
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
      "id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:41+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
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
        "item_id": "05c5551d-5c73-45fa-84ee-b7fca3854877",
        "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba",
        "start_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c",
        "stop_location_id": "51c826f4-3334-41e7-9cde-f5fc0e8e269c",
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
      "id": "5b8c9c41-28e2-40bb-8347-82ac372a192d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:41+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d74c9cba-90dc-4d6b-b196-71e77ae85ec3",
        "planning_id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d",
        "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba"
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
      "id": "a594fcf7-2a43-45a5-a4c2-1f40547c1402",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:41+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3fa7d8a0-69d9-4c1e-850a-cf36374fef39",
        "planning_id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d",
        "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba"
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
      "id": "ec2ac3b1-a12b-48df-88e2-75c44a24820e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:41+00:00",
        "updated_at": "2022-04-08T18:20:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ddd51caa-6002-4ff6-b0c9-09b3874a4c49",
        "planning_id": "c92e08f6-1cd2-461a-ada3-2d3895ddfe8d",
        "order_id": "c0ea7042-4142-475c-8922-21dffdc558ba"
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
          "order_id": "50cd6365-453f-4ed6-a0df-9483ee577623",
          "items": [
            {
              "type": "bundles",
              "id": "645bde50-5b18-463e-a640-8e29374e7fb8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6cd0560c-1fd1-4d0b-925a-ee0e5fff4b26",
                  "id": "a5411195-0b09-46c2-8757-4710b8e9d5a6"
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
    "id": "a2890016-8264-5691-92bb-a0444631e1c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "50cd6365-453f-4ed6-a0df-9483ee577623"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "50cd6365-453f-4ed6-a0df-9483ee577623"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8932e2e2-09f0-45c0-a1fa-8981e184781f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f46f4d61-2fe7-4e5c-8a4e-2c44d6f40254"
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
      "id": "50cd6365-453f-4ed6-a0df-9483ee577623",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-08T18:20:44+00:00",
        "updated_at": "2022-04-08T18:20:45+00:00",
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
        "starts_at": "2022-04-06T18:15:00+00:00",
        "stops_at": "2022-04-10T18:15:00+00:00",
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
        "start_location_id": "97dd7e52-6cda-4222-8895-908a8718426d",
        "stop_location_id": "97dd7e52-6cda-4222-8895-908a8718426d"
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
      "id": "8932e2e2-09f0-45c0-a1fa-8981e184781f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-08T18:20:45+00:00",
        "updated_at": "2022-04-08T18:20:45+00:00",
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
        "item_id": "645bde50-5b18-463e-a640-8e29374e7fb8",
        "tax_category_id": null,
        "planning_id": "f46f4d61-2fe7-4e5c-8a4e-2c44d6f40254",
        "parent_line_id": null,
        "owner_id": "50cd6365-453f-4ed6-a0df-9483ee577623",
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
      "id": "f46f4d61-2fe7-4e5c-8a4e-2c44d6f40254",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-08T18:20:45+00:00",
        "updated_at": "2022-04-08T18:20:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-06T18:15:00+00:00",
        "stops_at": "2022-04-10T18:15:00+00:00",
        "reserved_from": "2022-04-06T18:15:00+00:00",
        "reserved_till": "2022-04-10T18:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "645bde50-5b18-463e-a640-8e29374e7fb8",
        "order_id": "50cd6365-453f-4ed6-a0df-9483ee577623",
        "start_location_id": "97dd7e52-6cda-4222-8895-908a8718426d",
        "stop_location_id": "97dd7e52-6cda-4222-8895-908a8718426d",
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





