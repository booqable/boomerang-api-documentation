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
          "order_id": "d7f3cfc2-a9c5-4a1b-922e-821ea77122ee",
          "items": [
            {
              "type": "products",
              "id": "215af51e-e9f2-4866-bed3-7ffc7924d043",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ffbda39c-ce5a-46ac-a952-e6583a8f8d5c",
              "stock_item_ids": [
                "e426e739-c032-495e-a615-0d9d192217f1",
                "a53621dd-64c6-4c25-91f4-bb6992f4a4ca"
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
            "item_id": "215af51e-e9f2-4866-bed3-7ffc7924d043",
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
          "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
          "items": [
            {
              "type": "products",
              "id": "62a61c86-c472-4949-b459-3d9a7d5ebbe4",
              "stock_item_ids": [
                "02170add-9f2f-41fe-8314-953698506dcb",
                "57e6f7da-d27a-4e7e-b89b-1f96cd96e405",
                "68969ddd-7d79-46a0-aeb2-7f75143b1be1"
              ]
            },
            {
              "type": "products",
              "id": "ced64a1c-1e0d-4a59-923f-850114f21991",
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
    "id": "44dcf046-bd76-5613-b477-c28572320696",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f0820239-4ffe-45dd-9989-60890d3b35d9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b68f9f9b-16fa-49b1-8aaa-041a9032bfe0"
          },
          {
            "type": "lines",
            "id": "226870d3-1a4f-46fd-b30a-da3350d4cd57"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3db059d9-238f-4e8a-8e69-5ce8bc304008"
          },
          {
            "type": "plannings",
            "id": "e4ab548a-3fb7-4768-acbf-7080f129337b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "abd284a3-05e9-4be3-beec-d7ddae0d41d7"
          },
          {
            "type": "stock_item_plannings",
            "id": "36b54904-147c-49ce-8360-0fc7348dd12f"
          },
          {
            "type": "stock_item_plannings",
            "id": "a9ccf3d9-3628-48d3-be1b-531072c91299"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-12T14:28:05+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
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
        "customer_id": "87d4de09-b697-4da2-bf6b-3bbc3191da49",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c",
        "stop_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c"
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
      "id": "b68f9f9b-16fa-49b1-8aaa-041a9032bfe0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
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
        "item_id": "62a61c86-c472-4949-b459-3d9a7d5ebbe4",
        "tax_category_id": "b9f24463-adab-49e9-b118-d9f41f6888b3",
        "planning_id": "3db059d9-238f-4e8a-8e69-5ce8bc304008",
        "parent_line_id": null,
        "owner_id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
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
      "id": "226870d3-1a4f-46fd-b30a-da3350d4cd57",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
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
        "item_id": "ced64a1c-1e0d-4a59-923f-850114f21991",
        "tax_category_id": "b9f24463-adab-49e9-b118-d9f41f6888b3",
        "planning_id": "e4ab548a-3fb7-4768-acbf-7080f129337b",
        "parent_line_id": null,
        "owner_id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
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
      "id": "3db059d9-238f-4e8a-8e69-5ce8bc304008",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
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
        "item_id": "62a61c86-c472-4949-b459-3d9a7d5ebbe4",
        "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
        "start_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c",
        "stop_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c",
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
      "id": "e4ab548a-3fb7-4768-acbf-7080f129337b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
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
        "item_id": "ced64a1c-1e0d-4a59-923f-850114f21991",
        "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9",
        "start_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c",
        "stop_location_id": "2ea3730a-5d93-4385-915d-1e5a54cddf3c",
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
      "id": "abd284a3-05e9-4be3-beec-d7ddae0d41d7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "02170add-9f2f-41fe-8314-953698506dcb",
        "planning_id": "3db059d9-238f-4e8a-8e69-5ce8bc304008",
        "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9"
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
      "id": "36b54904-147c-49ce-8360-0fc7348dd12f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "57e6f7da-d27a-4e7e-b89b-1f96cd96e405",
        "planning_id": "3db059d9-238f-4e8a-8e69-5ce8bc304008",
        "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9"
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
      "id": "a9ccf3d9-3628-48d3-be1b-531072c91299",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:07+00:00",
        "updated_at": "2023-01-12T14:28:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "68969ddd-7d79-46a0-aeb2-7f75143b1be1",
        "planning_id": "3db059d9-238f-4e8a-8e69-5ce8bc304008",
        "order_id": "f0820239-4ffe-45dd-9989-60890d3b35d9"
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
          "order_id": "98df529d-10b5-4504-b14c-27a4a0685d58",
          "items": [
            {
              "type": "bundles",
              "id": "93165573-6bac-4902-a156-d40b70f1dd2f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a6a9a928-1a9a-4af5-98d6-f6f856f70e19",
                  "id": "b55f5ea6-1c8f-4e20-b856-6a2847c2b843"
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
    "id": "c8cf2e33-0ef9-5a35-9a51-1872495fc75f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "98df529d-10b5-4504-b14c-27a4a0685d58"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "98df529d-10b5-4504-b14c-27a4a0685d58"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5d215b61-0091-42b0-89fc-35b6e2d3783f"
          },
          {
            "type": "lines",
            "id": "8bcec1c8-2331-4b03-a17e-1312d324d8da"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "83d52586-9ea4-4d01-bbca-8863d8477277"
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
      "id": "98df529d-10b5-4504-b14c-27a4a0685d58",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-12T14:28:11+00:00",
        "updated_at": "2023-01-12T14:28:12+00:00",
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
        "starts_at": "2023-01-10T14:15:00+00:00",
        "stops_at": "2023-01-14T14:15:00+00:00",
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
        "start_location_id": "ea8189b5-f2ea-4e0d-9e1b-3d9eca37e6be",
        "stop_location_id": "ea8189b5-f2ea-4e0d-9e1b-3d9eca37e6be"
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
      "id": "5d215b61-0091-42b0-89fc-35b6e2d3783f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-12T14:28:11+00:00",
        "updated_at": "2023-01-12T14:28:11+00:00",
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
        "item_id": "93165573-6bac-4902-a156-d40b70f1dd2f",
        "tax_category_id": null,
        "planning_id": "83d52586-9ea4-4d01-bbca-8863d8477277",
        "parent_line_id": null,
        "owner_id": "98df529d-10b5-4504-b14c-27a4a0685d58",
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
      "id": "8bcec1c8-2331-4b03-a17e-1312d324d8da",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-12T14:28:11+00:00",
        "updated_at": "2023-01-12T14:28:11+00:00",
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
        "item_id": "b55f5ea6-1c8f-4e20-b856-6a2847c2b843",
        "tax_category_id": null,
        "planning_id": "f96ccd11-733a-4c3d-b7fe-23b67e65cdbf",
        "parent_line_id": "5d215b61-0091-42b0-89fc-35b6e2d3783f",
        "owner_id": "98df529d-10b5-4504-b14c-27a4a0685d58",
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
      "id": "83d52586-9ea4-4d01-bbca-8863d8477277",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-12T14:28:11+00:00",
        "updated_at": "2023-01-12T14:28:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-10T14:15:00+00:00",
        "stops_at": "2023-01-14T14:15:00+00:00",
        "reserved_from": "2023-01-10T14:15:00+00:00",
        "reserved_till": "2023-01-14T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "93165573-6bac-4902-a156-d40b70f1dd2f",
        "order_id": "98df529d-10b5-4504-b14c-27a4a0685d58",
        "start_location_id": "ea8189b5-f2ea-4e0d-9e1b-3d9eca37e6be",
        "stop_location_id": "ea8189b5-f2ea-4e0d-9e1b-3d9eca37e6be",
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





