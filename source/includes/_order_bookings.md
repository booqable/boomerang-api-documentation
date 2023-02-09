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
          "order_id": "05c29ee0-2009-4e34-bdbe-2cb0cc17d391",
          "items": [
            {
              "type": "products",
              "id": "3de95770-979f-4803-922e-d13f13b03d58",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "02eb0d3f-a431-49bc-8ff2-75f88cc9eed3",
              "stock_item_ids": [
                "7d6215d4-7926-438b-acbd-8d9efee63ab9",
                "e121bddd-728b-4965-8ef4-feb98f7e1e97"
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
            "item_id": "3de95770-979f-4803-922e-d13f13b03d58",
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
          "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
          "items": [
            {
              "type": "products",
              "id": "a111aecf-7e5e-4aa1-98a2-e3876fad65cf",
              "stock_item_ids": [
                "145dbbbb-4275-4826-a3c4-a64329781dd3",
                "92117975-e3b6-4d62-a45e-9862d7d7fb3e",
                "2d52a6e1-be5f-481c-94e6-7a78c538dcbd"
              ]
            },
            {
              "type": "products",
              "id": "3f289bd3-68e6-4b92-afd1-2a1514e8f4c7",
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
    "id": "f5c49f1e-e9ad-58ae-bfc1-9a486e234bd9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "82be15d2-fa2c-4b72-9359-face980e5bcc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d37cf2d0-0bac-4f00-be91-eb0b6c994b75"
          },
          {
            "type": "lines",
            "id": "26f574bf-a94d-4f8c-a317-07eb6e886cf8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8"
          },
          {
            "type": "plannings",
            "id": "2947a1af-63cd-4ba5-8c60-e1ffd059bc8e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d06bffa8-531d-437e-aba6-62aac9a05aa2"
          },
          {
            "type": "stock_item_plannings",
            "id": "77d525b4-db6e-4021-bbdd-06a2e636220a"
          },
          {
            "type": "stock_item_plannings",
            "id": "992270c4-d0c3-4b0c-ba73-e78d9b308531"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T15:56:38+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
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
        "customer_id": "84d042b8-fa52-4135-8368-400c88dcae35",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cfebe067-c777-4a41-9f65-25f30836a505",
        "stop_location_id": "cfebe067-c777-4a41-9f65-25f30836a505"
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
      "id": "d37cf2d0-0bac-4f00-be91-eb0b6c994b75",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
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
        "item_id": "a111aecf-7e5e-4aa1-98a2-e3876fad65cf",
        "tax_category_id": "3a3c998f-9f92-4098-97aa-4269816dd256",
        "planning_id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8",
        "parent_line_id": null,
        "owner_id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
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
      "id": "26f574bf-a94d-4f8c-a317-07eb6e886cf8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
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
        "item_id": "3f289bd3-68e6-4b92-afd1-2a1514e8f4c7",
        "tax_category_id": "3a3c998f-9f92-4098-97aa-4269816dd256",
        "planning_id": "2947a1af-63cd-4ba5-8c60-e1ffd059bc8e",
        "parent_line_id": null,
        "owner_id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
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
      "id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
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
        "item_id": "a111aecf-7e5e-4aa1-98a2-e3876fad65cf",
        "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
        "start_location_id": "cfebe067-c777-4a41-9f65-25f30836a505",
        "stop_location_id": "cfebe067-c777-4a41-9f65-25f30836a505",
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
      "id": "2947a1af-63cd-4ba5-8c60-e1ffd059bc8e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
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
        "item_id": "3f289bd3-68e6-4b92-afd1-2a1514e8f4c7",
        "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc",
        "start_location_id": "cfebe067-c777-4a41-9f65-25f30836a505",
        "stop_location_id": "cfebe067-c777-4a41-9f65-25f30836a505",
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
      "id": "d06bffa8-531d-437e-aba6-62aac9a05aa2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "145dbbbb-4275-4826-a3c4-a64329781dd3",
        "planning_id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8",
        "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc"
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
      "id": "77d525b4-db6e-4021-bbdd-06a2e636220a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "92117975-e3b6-4d62-a45e-9862d7d7fb3e",
        "planning_id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8",
        "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc"
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
      "id": "992270c4-d0c3-4b0c-ba73-e78d9b308531",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:39+00:00",
        "updated_at": "2023-02-09T15:56:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2d52a6e1-be5f-481c-94e6-7a78c538dcbd",
        "planning_id": "65b1118c-bbb7-4fec-8e0a-e010f32d14c8",
        "order_id": "82be15d2-fa2c-4b72-9359-face980e5bcc"
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
          "order_id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda",
          "items": [
            {
              "type": "bundles",
              "id": "378b65df-cddf-4ca0-a35c-41f5f78f098c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "dddc7c8a-98b0-4cdd-99cd-bf2cf85a8be1",
                  "id": "6807d8df-1c2a-4b23-941f-61e702d9d3fc"
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
    "id": "5241ff9c-734a-5fda-8e16-e610820c2b9d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6e78149f-25f0-47b0-bf5d-f921a3dbc1c4"
          },
          {
            "type": "lines",
            "id": "29a7101c-fd7b-408f-aadf-ab9e03bdc3ab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c140693b-3551-44f2-8e20-c5cb9ace3b30"
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
      "id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T15:56:41+00:00",
        "updated_at": "2023-02-09T15:56:41+00:00",
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
        "starts_at": "2023-02-07T15:45:00+00:00",
        "stops_at": "2023-02-11T15:45:00+00:00",
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
        "start_location_id": "e0c07362-be80-4da5-b205-f8c7e83c03fa",
        "stop_location_id": "e0c07362-be80-4da5-b205-f8c7e83c03fa"
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
      "id": "6e78149f-25f0-47b0-bf5d-f921a3dbc1c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T15:56:41+00:00",
        "updated_at": "2023-02-09T15:56:41+00:00",
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
        "item_id": "6807d8df-1c2a-4b23-941f-61e702d9d3fc",
        "tax_category_id": null,
        "planning_id": "5e269abc-f9b7-4de1-9d67-535706bd3fef",
        "parent_line_id": "29a7101c-fd7b-408f-aadf-ab9e03bdc3ab",
        "owner_id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda",
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
      "id": "29a7101c-fd7b-408f-aadf-ab9e03bdc3ab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T15:56:41+00:00",
        "updated_at": "2023-02-09T15:56:41+00:00",
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
        "item_id": "378b65df-cddf-4ca0-a35c-41f5f78f098c",
        "tax_category_id": null,
        "planning_id": "c140693b-3551-44f2-8e20-c5cb9ace3b30",
        "parent_line_id": null,
        "owner_id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda",
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
      "id": "c140693b-3551-44f2-8e20-c5cb9ace3b30",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T15:56:41+00:00",
        "updated_at": "2023-02-09T15:56:41+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T15:45:00+00:00",
        "stops_at": "2023-02-11T15:45:00+00:00",
        "reserved_from": "2023-02-07T15:45:00+00:00",
        "reserved_till": "2023-02-11T15:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "378b65df-cddf-4ca0-a35c-41f5f78f098c",
        "order_id": "3ab9d163-e9fc-4dfd-a262-63a9da911eda",
        "start_location_id": "e0c07362-be80-4da5-b205-f8c7e83c03fa",
        "stop_location_id": "e0c07362-be80-4da5-b205-f8c7e83c03fa",
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





