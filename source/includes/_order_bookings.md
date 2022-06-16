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
          "order_id": "213153b5-0910-4e34-8027-043404b1e9d4",
          "items": [
            {
              "type": "products",
              "id": "557c25fe-7d69-4b71-851a-7855063fe67c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "dbf27675-c713-4ac0-9515-53913c97d378",
              "stock_item_ids": [
                "42f73973-2130-4136-9d50-10b819d189d9",
                "5b5c5508-a660-4c10-b24f-59e5347ec4a1"
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
            "item_id": "557c25fe-7d69-4b71-851a-7855063fe67c",
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
          "order_id": "787ce013-336b-4a66-b456-23bceff2745d",
          "items": [
            {
              "type": "products",
              "id": "8488cd61-b2af-4720-ad83-b5f9247d5a58",
              "stock_item_ids": [
                "4bb917ea-5d22-4085-a7aa-2c74b3b611bb",
                "1395cff8-9dc1-4cbb-a1e3-d60d31f88a11",
                "475ff5f3-3998-4910-abf6-37ef47ff52cf"
              ]
            },
            {
              "type": "products",
              "id": "c6d17a15-925b-4bc1-b841-3c579cb9c6af",
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
    "id": "67e2f7e6-bc06-5056-b1bd-be4db3c4f4f6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "787ce013-336b-4a66-b456-23bceff2745d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "787ce013-336b-4a66-b456-23bceff2745d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "15a4d8ad-1273-4f72-9388-1b21b4cef68f"
          },
          {
            "type": "lines",
            "id": "846f09ee-09cd-433e-b416-59c1f9798ac2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "59e7fbb6-0e41-4e05-8e76-6ab1d8c8eb48"
          },
          {
            "type": "plannings",
            "id": "73e486b3-f522-4c21-8a30-84c210aa071d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d4786062-a7ae-4b84-88a3-ba457eb2aa40"
          },
          {
            "type": "stock_item_plannings",
            "id": "879a871e-5440-4e01-9990-7901194f07d5"
          },
          {
            "type": "stock_item_plannings",
            "id": "ec313719-97c1-4980-9833-68053866d5f6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "787ce013-336b-4a66-b456-23bceff2745d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-16T19:32:43+00:00",
        "updated_at": "2022-06-16T19:32:47+00:00",
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
        "customer_id": "110ee71d-1f53-4d59-9a89-3802958bf0d3",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706",
        "stop_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706"
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
      "id": "15a4d8ad-1273-4f72-9388-1b21b4cef68f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-16T19:32:44+00:00",
        "updated_at": "2022-06-16T19:32:47+00:00",
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
        "item_id": "c6d17a15-925b-4bc1-b841-3c579cb9c6af",
        "tax_category_id": "150762cd-49f1-4d26-b9c6-c75dfe87d627",
        "planning_id": "59e7fbb6-0e41-4e05-8e76-6ab1d8c8eb48",
        "parent_line_id": null,
        "owner_id": "787ce013-336b-4a66-b456-23bceff2745d",
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
      "id": "846f09ee-09cd-433e-b416-59c1f9798ac2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-16T19:32:46+00:00",
        "updated_at": "2022-06-16T19:32:47+00:00",
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
        "item_id": "8488cd61-b2af-4720-ad83-b5f9247d5a58",
        "tax_category_id": "150762cd-49f1-4d26-b9c6-c75dfe87d627",
        "planning_id": "73e486b3-f522-4c21-8a30-84c210aa071d",
        "parent_line_id": null,
        "owner_id": "787ce013-336b-4a66-b456-23bceff2745d",
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
      "id": "59e7fbb6-0e41-4e05-8e76-6ab1d8c8eb48",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:44+00:00",
        "updated_at": "2022-06-16T19:32:47+00:00",
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
        "item_id": "c6d17a15-925b-4bc1-b841-3c579cb9c6af",
        "order_id": "787ce013-336b-4a66-b456-23bceff2745d",
        "start_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706",
        "stop_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706",
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
      "id": "73e486b3-f522-4c21-8a30-84c210aa071d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:46+00:00",
        "updated_at": "2022-06-16T19:32:47+00:00",
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
        "item_id": "8488cd61-b2af-4720-ad83-b5f9247d5a58",
        "order_id": "787ce013-336b-4a66-b456-23bceff2745d",
        "start_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706",
        "stop_location_id": "877bc3e5-04b2-4507-8a31-bcf30466a706",
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
      "id": "d4786062-a7ae-4b84-88a3-ba457eb2aa40",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:46+00:00",
        "updated_at": "2022-06-16T19:32:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4bb917ea-5d22-4085-a7aa-2c74b3b611bb",
        "planning_id": "73e486b3-f522-4c21-8a30-84c210aa071d",
        "order_id": "787ce013-336b-4a66-b456-23bceff2745d"
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
      "id": "879a871e-5440-4e01-9990-7901194f07d5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:46+00:00",
        "updated_at": "2022-06-16T19:32:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1395cff8-9dc1-4cbb-a1e3-d60d31f88a11",
        "planning_id": "73e486b3-f522-4c21-8a30-84c210aa071d",
        "order_id": "787ce013-336b-4a66-b456-23bceff2745d"
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
      "id": "ec313719-97c1-4980-9833-68053866d5f6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:46+00:00",
        "updated_at": "2022-06-16T19:32:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "475ff5f3-3998-4910-abf6-37ef47ff52cf",
        "planning_id": "73e486b3-f522-4c21-8a30-84c210aa071d",
        "order_id": "787ce013-336b-4a66-b456-23bceff2745d"
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
          "order_id": "76f84b3b-c387-487b-aae7-27ba06c02de3",
          "items": [
            {
              "type": "bundles",
              "id": "233b920a-0ea0-4ae6-9dba-831051875057",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "60dffa34-9182-464b-aef8-f432d89277bf",
                  "id": "611a73c4-5f37-404c-9976-560060262e61"
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
    "id": "7a000597-9394-5c27-8426-5b095022bd00",
    "type": "order_bookings",
    "attributes": {
      "order_id": "76f84b3b-c387-487b-aae7-27ba06c02de3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "76f84b3b-c387-487b-aae7-27ba06c02de3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2691d84e-af87-4e93-9577-fb2089dbabcf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c56b75ef-33e5-481e-bd7c-e6384149bbe9"
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
      "id": "76f84b3b-c387-487b-aae7-27ba06c02de3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-16T19:32:51+00:00",
        "updated_at": "2022-06-16T19:32:53+00:00",
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
        "starts_at": "2022-06-14T19:30:00+00:00",
        "stops_at": "2022-06-18T19:30:00+00:00",
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
        "start_location_id": "3ba55c93-3089-4303-9231-4a9335ff384d",
        "stop_location_id": "3ba55c93-3089-4303-9231-4a9335ff384d"
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
      "id": "2691d84e-af87-4e93-9577-fb2089dbabcf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-16T19:32:52+00:00",
        "updated_at": "2022-06-16T19:32:53+00:00",
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
        "item_id": "233b920a-0ea0-4ae6-9dba-831051875057",
        "tax_category_id": null,
        "planning_id": "c56b75ef-33e5-481e-bd7c-e6384149bbe9",
        "parent_line_id": null,
        "owner_id": "76f84b3b-c387-487b-aae7-27ba06c02de3",
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
      "id": "c56b75ef-33e5-481e-bd7c-e6384149bbe9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-16T19:32:52+00:00",
        "updated_at": "2022-06-16T19:32:52+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-14T19:30:00+00:00",
        "stops_at": "2022-06-18T19:30:00+00:00",
        "reserved_from": "2022-06-14T19:30:00+00:00",
        "reserved_till": "2022-06-18T19:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "233b920a-0ea0-4ae6-9dba-831051875057",
        "order_id": "76f84b3b-c387-487b-aae7-27ba06c02de3",
        "start_location_id": "3ba55c93-3089-4303-9231-4a9335ff384d",
        "stop_location_id": "3ba55c93-3089-4303-9231-4a9335ff384d",
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





