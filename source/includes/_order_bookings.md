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
          "order_id": "ab22d8b3-af22-40e1-bd53-3ebb4a2a68a7",
          "items": [
            {
              "type": "products",
              "id": "a0776a8b-2db9-43ef-b268-f5830839a941",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8b273b4e-d927-4602-9fa9-27f9162df7c0",
              "stock_item_ids": [
                "10a11d52-4e74-41d5-8a5a-9a1e18f9ca85",
                "6b0bc668-23cc-40a5-bbd0-ade8bbb69d6b"
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
            "item_id": "a0776a8b-2db9-43ef-b268-f5830839a941",
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
          "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f",
          "items": [
            {
              "type": "products",
              "id": "cfee1f93-3d9c-4c3e-86f7-59588ca7245e",
              "stock_item_ids": [
                "05f35cf9-14c6-4a21-8f28-da36a496fd63",
                "97022151-e2bb-4015-aa33-c8d2a5644aa0",
                "ce38d7e5-a46b-4254-bf03-5eb433583753"
              ]
            },
            {
              "type": "products",
              "id": "cb12c59e-ce7c-4b7b-9d63-ded9f9fbe4b1",
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
    "id": "d07997fc-c21a-58df-ac42-c6ff87413dbf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af343071-a1f6-4914-acc2-803b871ecb1f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0412ac99-4fd4-4475-b61d-68b4caf6f1c3"
          },
          {
            "type": "lines",
            "id": "cd3fee9b-a1c8-4e7c-8990-777ed4f78005"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "124f710b-1d21-4831-9cf5-1d156796e5a8"
          },
          {
            "type": "plannings",
            "id": "db40c66a-df49-46f5-9ef9-46eed00c7cb8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "cb1959be-a0b5-4cbb-bc3e-f009f26548dc"
          },
          {
            "type": "stock_item_plannings",
            "id": "dbe11449-dd40-4036-88c4-e7e16295e621"
          },
          {
            "type": "stock_item_plannings",
            "id": "11ae7ece-aacd-4cfa-b84d-5841f2e0b028"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af343071-a1f6-4914-acc2-803b871ecb1f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T13:20:41+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
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
        "customer_id": "d099179b-46bf-4081-8a01-1ab6d6d07d33",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "72d7220e-5d71-4284-be64-5594e65cce01",
        "stop_location_id": "72d7220e-5d71-4284-be64-5594e65cce01"
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
      "id": "0412ac99-4fd4-4475-b61d-68b4caf6f1c3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
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
        "item_id": "cfee1f93-3d9c-4c3e-86f7-59588ca7245e",
        "tax_category_id": "9af988ef-30e4-473e-a7ab-7d5227cfdd47",
        "planning_id": "124f710b-1d21-4831-9cf5-1d156796e5a8",
        "parent_line_id": null,
        "owner_id": "af343071-a1f6-4914-acc2-803b871ecb1f",
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
      "id": "cd3fee9b-a1c8-4e7c-8990-777ed4f78005",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
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
        "item_id": "cb12c59e-ce7c-4b7b-9d63-ded9f9fbe4b1",
        "tax_category_id": "9af988ef-30e4-473e-a7ab-7d5227cfdd47",
        "planning_id": "db40c66a-df49-46f5-9ef9-46eed00c7cb8",
        "parent_line_id": null,
        "owner_id": "af343071-a1f6-4914-acc2-803b871ecb1f",
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
      "id": "124f710b-1d21-4831-9cf5-1d156796e5a8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
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
        "item_id": "cfee1f93-3d9c-4c3e-86f7-59588ca7245e",
        "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f",
        "start_location_id": "72d7220e-5d71-4284-be64-5594e65cce01",
        "stop_location_id": "72d7220e-5d71-4284-be64-5594e65cce01",
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
      "id": "db40c66a-df49-46f5-9ef9-46eed00c7cb8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
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
        "item_id": "cb12c59e-ce7c-4b7b-9d63-ded9f9fbe4b1",
        "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f",
        "start_location_id": "72d7220e-5d71-4284-be64-5594e65cce01",
        "stop_location_id": "72d7220e-5d71-4284-be64-5594e65cce01",
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
      "id": "cb1959be-a0b5-4cbb-bc3e-f009f26548dc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "05f35cf9-14c6-4a21-8f28-da36a496fd63",
        "planning_id": "124f710b-1d21-4831-9cf5-1d156796e5a8",
        "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f"
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
      "id": "dbe11449-dd40-4036-88c4-e7e16295e621",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "97022151-e2bb-4015-aa33-c8d2a5644aa0",
        "planning_id": "124f710b-1d21-4831-9cf5-1d156796e5a8",
        "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f"
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
      "id": "11ae7ece-aacd-4cfa-b84d-5841f2e0b028",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:43+00:00",
        "updated_at": "2023-02-09T13:20:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ce38d7e5-a46b-4254-bf03-5eb433583753",
        "planning_id": "124f710b-1d21-4831-9cf5-1d156796e5a8",
        "order_id": "af343071-a1f6-4914-acc2-803b871ecb1f"
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
          "order_id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc",
          "items": [
            {
              "type": "bundles",
              "id": "12c841a0-9687-4384-b45c-acfaff85610c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "46fd6d3e-7dbf-4d95-a997-068c4511dcca",
                  "id": "83cb15fb-d1ca-453f-85f5-b71f9c2eaba1"
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
    "id": "26b63145-f29c-52fa-864c-29af5bae022b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ab8a2d7e-f7f6-4fde-af5f-9d261a9213a5"
          },
          {
            "type": "lines",
            "id": "520b94d5-7d14-4abe-a420-9a9bba77058b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c08bc22a-b859-4412-bf58-e2a837192dcd"
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
      "id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T13:20:45+00:00",
        "updated_at": "2023-02-09T13:20:46+00:00",
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
        "starts_at": "2023-02-07T13:15:00+00:00",
        "stops_at": "2023-02-11T13:15:00+00:00",
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
        "start_location_id": "ccb75c54-0abb-41a9-bf0e-84e8749766cc",
        "stop_location_id": "ccb75c54-0abb-41a9-bf0e-84e8749766cc"
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
      "id": "ab8a2d7e-f7f6-4fde-af5f-9d261a9213a5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:20:45+00:00",
        "updated_at": "2023-02-09T13:20:46+00:00",
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
        "item_id": "12c841a0-9687-4384-b45c-acfaff85610c",
        "tax_category_id": null,
        "planning_id": "c08bc22a-b859-4412-bf58-e2a837192dcd",
        "parent_line_id": null,
        "owner_id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc",
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
      "id": "520b94d5-7d14-4abe-a420-9a9bba77058b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T13:20:45+00:00",
        "updated_at": "2023-02-09T13:20:46+00:00",
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
        "item_id": "83cb15fb-d1ca-453f-85f5-b71f9c2eaba1",
        "tax_category_id": null,
        "planning_id": "e0fdd9d6-be98-4e02-95ea-1658007e9c94",
        "parent_line_id": "ab8a2d7e-f7f6-4fde-af5f-9d261a9213a5",
        "owner_id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc",
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
      "id": "c08bc22a-b859-4412-bf58-e2a837192dcd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T13:20:45+00:00",
        "updated_at": "2023-02-09T13:20:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T13:15:00+00:00",
        "stops_at": "2023-02-11T13:15:00+00:00",
        "reserved_from": "2023-02-07T13:15:00+00:00",
        "reserved_till": "2023-02-11T13:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "12c841a0-9687-4384-b45c-acfaff85610c",
        "order_id": "37ce4447-de02-4b89-896e-dfdcb73fe1dc",
        "start_location_id": "ccb75c54-0abb-41a9-bf0e-84e8749766cc",
        "stop_location_id": "ccb75c54-0abb-41a9-bf0e-84e8749766cc",
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





