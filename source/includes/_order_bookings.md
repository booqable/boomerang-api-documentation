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
          "order_id": "31ac4e07-0e3c-41f7-bba6-fddc88a82352",
          "items": [
            {
              "type": "products",
              "id": "8046705a-ab98-4a6c-8213-afd2047d4ffc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5bdda0f4-f722-44a3-a55c-ae67164dc65a",
              "stock_item_ids": [
                "71be06c7-af05-49f0-b332-6d4a9b76fa22",
                "836a9756-329c-4c6a-b4df-af35279e8af8"
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
          "stock_item_id 71be06c7-af05-49f0-b332-6d4a9b76fa22 has already been booked on this order"
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
          "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
          "items": [
            {
              "type": "products",
              "id": "2dca4950-5173-4084-a582-b5ebe22ce552",
              "stock_item_ids": [
                "0be7e485-a5ff-46df-8142-7b3582965291",
                "7ac59ca4-96ba-4f14-a6b2-660cd3fb5fc4",
                "f920cc63-41e9-4a25-b095-3bc3bb317982"
              ]
            },
            {
              "type": "products",
              "id": "afa91a9a-b1ba-43c8-b454-1925700054a1",
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
    "id": "3b4b2eb0-3b14-57d6-8bc0-e1cdf8e03739",
    "type": "order_bookings",
    "attributes": {
      "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "07da936b-9f3e-4c12-ad7c-7bfd37361336"
          },
          {
            "type": "lines",
            "id": "56db32f1-06ea-4e85-9c8a-326e80c72451"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dc294b68-5b66-4ce1-8197-d0643d721f67"
          },
          {
            "type": "plannings",
            "id": "7d63da22-2109-4a18-8523-d58a3c4b1af0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "62f327a4-af9f-40fc-a8a6-fb7310df35b8"
          },
          {
            "type": "stock_item_plannings",
            "id": "7a0113f3-b447-46e4-9398-d2aad5357705"
          },
          {
            "type": "stock_item_plannings",
            "id": "5598966a-6842-4695-b1f2-a473ff60277e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T08:13:28+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
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
        "customer_id": "dbd3a520-7088-49c2-bc04-8822eb23c654",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c",
        "stop_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c"
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
      "id": "07da936b-9f3e-4c12-ad7c-7bfd37361336",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
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
        "item_id": "2dca4950-5173-4084-a582-b5ebe22ce552",
        "tax_category_id": "6c07f0e8-c95c-4a53-b878-e4b24961b2e5",
        "planning_id": "dc294b68-5b66-4ce1-8197-d0643d721f67",
        "parent_line_id": null,
        "owner_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
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
      "id": "56db32f1-06ea-4e85-9c8a-326e80c72451",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
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
        "item_id": "afa91a9a-b1ba-43c8-b454-1925700054a1",
        "tax_category_id": "6c07f0e8-c95c-4a53-b878-e4b24961b2e5",
        "planning_id": "7d63da22-2109-4a18-8523-d58a3c4b1af0",
        "parent_line_id": null,
        "owner_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
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
      "id": "dc294b68-5b66-4ce1-8197-d0643d721f67",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
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
        "item_id": "2dca4950-5173-4084-a582-b5ebe22ce552",
        "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
        "start_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c",
        "stop_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c",
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
      "id": "7d63da22-2109-4a18-8523-d58a3c4b1af0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
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
        "item_id": "afa91a9a-b1ba-43c8-b454-1925700054a1",
        "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa",
        "start_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c",
        "stop_location_id": "ccdbae3f-1975-44db-9003-fd4a247fa83c",
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
      "id": "62f327a4-af9f-40fc-a8a6-fb7310df35b8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0be7e485-a5ff-46df-8142-7b3582965291",
        "planning_id": "dc294b68-5b66-4ce1-8197-d0643d721f67",
        "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa"
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
      "id": "7a0113f3-b447-46e4-9398-d2aad5357705",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7ac59ca4-96ba-4f14-a6b2-660cd3fb5fc4",
        "planning_id": "dc294b68-5b66-4ce1-8197-d0643d721f67",
        "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa"
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
      "id": "5598966a-6842-4695-b1f2-a473ff60277e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:30+00:00",
        "updated_at": "2023-02-16T08:13:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f920cc63-41e9-4a25-b095-3bc3bb317982",
        "planning_id": "dc294b68-5b66-4ce1-8197-d0643d721f67",
        "order_id": "37caacc1-73c6-4cfc-acf0-3aca2c92e8aa"
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
          "order_id": "8694744f-a153-4165-9355-e230fbd8d41f",
          "items": [
            {
              "type": "bundles",
              "id": "da4ae740-a289-4844-91fd-e55904e5a8b5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c1a53481-5c63-4ccb-8d45-60f528901f5d",
                  "id": "331e2f51-190c-4319-a260-357e105874ce"
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
    "id": "3d252f64-e1ad-5913-aa54-6014e5a70a0e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8694744f-a153-4165-9355-e230fbd8d41f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8694744f-a153-4165-9355-e230fbd8d41f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "52327395-22ad-4639-96de-b40537c73db4"
          },
          {
            "type": "lines",
            "id": "cbff3577-cea7-475d-b7b8-89b04fd87c7d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e35eaa26-7823-4b07-96f5-6adcd5c76dce"
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
      "id": "8694744f-a153-4165-9355-e230fbd8d41f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T08:13:32+00:00",
        "updated_at": "2023-02-16T08:13:33+00:00",
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
        "starts_at": "2023-02-14T08:00:00+00:00",
        "stops_at": "2023-02-18T08:00:00+00:00",
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
        "start_location_id": "bc206a4d-99d2-4e37-8b39-009d7f95f39c",
        "stop_location_id": "bc206a4d-99d2-4e37-8b39-009d7f95f39c"
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
      "id": "52327395-22ad-4639-96de-b40537c73db4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T08:13:33+00:00",
        "updated_at": "2023-02-16T08:13:33+00:00",
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
        "item_id": "da4ae740-a289-4844-91fd-e55904e5a8b5",
        "tax_category_id": null,
        "planning_id": "e35eaa26-7823-4b07-96f5-6adcd5c76dce",
        "parent_line_id": null,
        "owner_id": "8694744f-a153-4165-9355-e230fbd8d41f",
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
      "id": "cbff3577-cea7-475d-b7b8-89b04fd87c7d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T08:13:33+00:00",
        "updated_at": "2023-02-16T08:13:33+00:00",
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
        "item_id": "331e2f51-190c-4319-a260-357e105874ce",
        "tax_category_id": null,
        "planning_id": "e6345355-4211-4c51-897a-47257bddd640",
        "parent_line_id": "52327395-22ad-4639-96de-b40537c73db4",
        "owner_id": "8694744f-a153-4165-9355-e230fbd8d41f",
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
      "id": "e35eaa26-7823-4b07-96f5-6adcd5c76dce",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T08:13:32+00:00",
        "updated_at": "2023-02-16T08:13:32+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T08:00:00+00:00",
        "stops_at": "2023-02-18T08:00:00+00:00",
        "reserved_from": "2023-02-14T08:00:00+00:00",
        "reserved_till": "2023-02-18T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "da4ae740-a289-4844-91fd-e55904e5a8b5",
        "order_id": "8694744f-a153-4165-9355-e230fbd8d41f",
        "start_location_id": "bc206a4d-99d2-4e37-8b39-009d7f95f39c",
        "stop_location_id": "bc206a4d-99d2-4e37-8b39-009d7f95f39c",
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





