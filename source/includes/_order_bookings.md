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
          "order_id": "abe080bb-78bc-49a0-9de0-4e9cd036ff62",
          "items": [
            {
              "type": "products",
              "id": "4f3f2b15-2d8e-4ede-b27f-d0a4a38a7fa1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "92974605-6260-4355-a17f-8be5551cca50",
              "stock_item_ids": [
                "23acdecd-008f-47f6-a393-3ffbfd0cd35a",
                "4d82b457-3b8b-432b-87d6-c1f0e6d7bbcc"
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
          "stock_item_id 23acdecd-008f-47f6-a393-3ffbfd0cd35a has already been booked on this order"
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
          "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
          "items": [
            {
              "type": "products",
              "id": "51b9cb92-0947-4cdb-b037-8cd3d9e05b69",
              "stock_item_ids": [
                "706b8d84-de1c-4c60-b009-caf377faa1e7",
                "44b8c964-c102-49c3-9959-ba62d7ed4649",
                "44ecfdad-e48e-4e15-84e9-503e79476963"
              ]
            },
            {
              "type": "products",
              "id": "e7635a3a-ac4c-46f3-9f19-8143c1fda3fa",
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
    "id": "dfc1e9d6-7eab-5d48-a302-22d7f62e3a67",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a1201f90-3835-4f4c-b8b7-14a093fbb441"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4dc56ca8-a310-4a7c-8b5d-e977672b2438"
          },
          {
            "type": "lines",
            "id": "d7e27295-fd32-4a1f-966b-3ae8115ceb74"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "87f64f31-fb42-44d6-8896-927116aebd01"
          },
          {
            "type": "plannings",
            "id": "11b5a494-21b6-4b52-9cf8-ef0079ae6ffb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "73ec8ac8-8e03-4716-b45f-90f661ad4c6f"
          },
          {
            "type": "stock_item_plannings",
            "id": "622a014e-5d90-4c99-9472-dc7eb44e0eaa"
          },
          {
            "type": "stock_item_plannings",
            "id": "3d11ee42-a844-4360-a65b-e1a14bde2948"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-27T10:47:56+00:00",
        "updated_at": "2023-02-27T10:47:59+00:00",
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
        "customer_id": "902e02ff-20e7-4031-95a9-6bcb9c7d8e7e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2",
        "stop_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2"
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
      "id": "4dc56ca8-a310-4a7c-8b5d-e977672b2438",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:59+00:00",
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
        "item_id": "51b9cb92-0947-4cdb-b037-8cd3d9e05b69",
        "tax_category_id": "40c3e26a-7098-4911-a090-59ad9b070798",
        "planning_id": "87f64f31-fb42-44d6-8896-927116aebd01",
        "parent_line_id": null,
        "owner_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
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
      "id": "d7e27295-fd32-4a1f-966b-3ae8115ceb74",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:59+00:00",
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
        "item_id": "e7635a3a-ac4c-46f3-9f19-8143c1fda3fa",
        "tax_category_id": "40c3e26a-7098-4911-a090-59ad9b070798",
        "planning_id": "11b5a494-21b6-4b52-9cf8-ef0079ae6ffb",
        "parent_line_id": null,
        "owner_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
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
      "id": "87f64f31-fb42-44d6-8896-927116aebd01",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:58+00:00",
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
        "item_id": "51b9cb92-0947-4cdb-b037-8cd3d9e05b69",
        "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
        "start_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2",
        "stop_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2",
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
      "id": "11b5a494-21b6-4b52-9cf8-ef0079ae6ffb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:58+00:00",
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
        "item_id": "e7635a3a-ac4c-46f3-9f19-8143c1fda3fa",
        "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441",
        "start_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2",
        "stop_location_id": "7e965882-0ea8-4faa-88c6-9a05dda47ef2",
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
      "id": "73ec8ac8-8e03-4716-b45f-90f661ad4c6f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "706b8d84-de1c-4c60-b009-caf377faa1e7",
        "planning_id": "87f64f31-fb42-44d6-8896-927116aebd01",
        "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441"
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
      "id": "622a014e-5d90-4c99-9472-dc7eb44e0eaa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "44b8c964-c102-49c3-9959-ba62d7ed4649",
        "planning_id": "87f64f31-fb42-44d6-8896-927116aebd01",
        "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441"
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
      "id": "3d11ee42-a844-4360-a65b-e1a14bde2948",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:47:58+00:00",
        "updated_at": "2023-02-27T10:47:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "44ecfdad-e48e-4e15-84e9-503e79476963",
        "planning_id": "87f64f31-fb42-44d6-8896-927116aebd01",
        "order_id": "a1201f90-3835-4f4c-b8b7-14a093fbb441"
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
          "order_id": "1c809e10-742a-4b81-99fb-df74d44ecaeb",
          "items": [
            {
              "type": "bundles",
              "id": "1c3cabe5-2958-4271-8129-4fe751bc1730",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "09dae9f3-b507-4bfb-afb5-a08a3604a1f9",
                  "id": "15f7d72e-c755-4685-ae89-32b109329ad8"
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
    "id": "cc5592cc-b12d-56a3-b585-49c15de08861",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1c809e10-742a-4b81-99fb-df74d44ecaeb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1c809e10-742a-4b81-99fb-df74d44ecaeb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f7048a23-1e71-41cc-9a5d-62af95e808e7"
          },
          {
            "type": "lines",
            "id": "5d6c79c8-daed-4ddc-837d-a435199072ab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "55ac73cf-978e-42d9-9530-9d6a9d40cf88"
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
      "id": "1c809e10-742a-4b81-99fb-df74d44ecaeb",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-27T10:48:01+00:00",
        "updated_at": "2023-02-27T10:48:02+00:00",
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
        "starts_at": "2023-02-25T10:45:00+00:00",
        "stops_at": "2023-03-01T10:45:00+00:00",
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
        "start_location_id": "952f59dc-facb-46f0-897e-16e114ead818",
        "stop_location_id": "952f59dc-facb-46f0-897e-16e114ead818"
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
      "id": "f7048a23-1e71-41cc-9a5d-62af95e808e7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:48:01+00:00",
        "updated_at": "2023-02-27T10:48:02+00:00",
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
        "item_id": "15f7d72e-c755-4685-ae89-32b109329ad8",
        "tax_category_id": null,
        "planning_id": "268da4c2-f813-48f9-8577-17e80c934053",
        "parent_line_id": "5d6c79c8-daed-4ddc-837d-a435199072ab",
        "owner_id": "1c809e10-742a-4b81-99fb-df74d44ecaeb",
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
      "id": "5d6c79c8-daed-4ddc-837d-a435199072ab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:48:01+00:00",
        "updated_at": "2023-02-27T10:48:02+00:00",
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
        "item_id": "1c3cabe5-2958-4271-8129-4fe751bc1730",
        "tax_category_id": null,
        "planning_id": "55ac73cf-978e-42d9-9530-9d6a9d40cf88",
        "parent_line_id": null,
        "owner_id": "1c809e10-742a-4b81-99fb-df74d44ecaeb",
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
      "id": "55ac73cf-978e-42d9-9530-9d6a9d40cf88",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:48:01+00:00",
        "updated_at": "2023-02-27T10:48:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-25T10:45:00+00:00",
        "stops_at": "2023-03-01T10:45:00+00:00",
        "reserved_from": "2023-02-25T10:45:00+00:00",
        "reserved_till": "2023-03-01T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1c3cabe5-2958-4271-8129-4fe751bc1730",
        "order_id": "1c809e10-742a-4b81-99fb-df74d44ecaeb",
        "start_location_id": "952f59dc-facb-46f0-897e-16e114ead818",
        "stop_location_id": "952f59dc-facb-46f0-897e-16e114ead818",
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





