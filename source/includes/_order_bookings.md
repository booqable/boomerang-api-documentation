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
          "order_id": "e7cd3c85-bb99-4b48-91dd-c23e61748056",
          "items": [
            {
              "type": "products",
              "id": "5b4572b9-6236-44ce-9f8f-1502efa2252c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "dbc32a81-28e9-43c0-a512-87d6c8f02c23",
              "stock_item_ids": [
                "85db3a20-7c40-4458-a813-e8593cb9e367",
                "3c710a79-4243-4635-84cd-1ac375e88558"
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
            "item_id": "5b4572b9-6236-44ce-9f8f-1502efa2252c",
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
          "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
          "items": [
            {
              "type": "products",
              "id": "4a5d7d23-cd53-406c-bc33-c7b3c0afd91c",
              "stock_item_ids": [
                "21bcb2d6-af2d-4ff3-aa35-01e012d6c46f",
                "e60fc446-254d-41a3-91df-7ed38bf24b28",
                "7a0be8ea-88e0-4009-815f-4219e7d7a5cc"
              ]
            },
            {
              "type": "products",
              "id": "3b1266ca-bdfe-49b9-bcee-e28ec828b7a9",
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
    "id": "8f25dfaa-9a3c-596d-9742-5ac8defce48e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "17cd5d58-d7f9-474b-b294-35b531395dbe"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f88d5669-1a89-4197-9869-674a4ed76690"
          },
          {
            "type": "lines",
            "id": "0832cabe-3c71-44f3-8ed0-39200540adaa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c8f97999-807c-4154-a395-fbb31e36f52c"
          },
          {
            "type": "plannings",
            "id": "9b4e5bc3-9379-4dcc-b3c5-8f3aaa7321ca"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e2b0b06b-0e50-467b-8467-3f7ff6d629df"
          },
          {
            "type": "stock_item_plannings",
            "id": "217a91e8-9e15-4e7d-a737-1be7bf2f6e16"
          },
          {
            "type": "stock_item_plannings",
            "id": "5cf48546-201f-4bb0-a0c9-b97b1a8f0b1d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:05:38+00:00",
        "updated_at": "2023-02-14T11:05:41+00:00",
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
        "customer_id": "2ac16f16-1a0b-4ee3-b0cb-148b6be1a49c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b",
        "stop_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b"
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
      "id": "f88d5669-1a89-4197-9869-674a4ed76690",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
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
        "item_id": "4a5d7d23-cd53-406c-bc33-c7b3c0afd91c",
        "tax_category_id": "5cf7c492-fd3e-4719-9c21-796b90b9a924",
        "planning_id": "c8f97999-807c-4154-a395-fbb31e36f52c",
        "parent_line_id": null,
        "owner_id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
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
      "id": "0832cabe-3c71-44f3-8ed0-39200540adaa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
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
        "item_id": "3b1266ca-bdfe-49b9-bcee-e28ec828b7a9",
        "tax_category_id": "5cf7c492-fd3e-4719-9c21-796b90b9a924",
        "planning_id": "9b4e5bc3-9379-4dcc-b3c5-8f3aaa7321ca",
        "parent_line_id": null,
        "owner_id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
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
      "id": "c8f97999-807c-4154-a395-fbb31e36f52c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:41+00:00",
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
        "item_id": "4a5d7d23-cd53-406c-bc33-c7b3c0afd91c",
        "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
        "start_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b",
        "stop_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b",
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
      "id": "9b4e5bc3-9379-4dcc-b3c5-8f3aaa7321ca",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:41+00:00",
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
        "item_id": "3b1266ca-bdfe-49b9-bcee-e28ec828b7a9",
        "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe",
        "start_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b",
        "stop_location_id": "402ba50f-1d60-4b1f-a512-1377102bc45b",
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
      "id": "e2b0b06b-0e50-467b-8467-3f7ff6d629df",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "21bcb2d6-af2d-4ff3-aa35-01e012d6c46f",
        "planning_id": "c8f97999-807c-4154-a395-fbb31e36f52c",
        "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe"
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
      "id": "217a91e8-9e15-4e7d-a737-1be7bf2f6e16",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e60fc446-254d-41a3-91df-7ed38bf24b28",
        "planning_id": "c8f97999-807c-4154-a395-fbb31e36f52c",
        "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe"
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
      "id": "5cf48546-201f-4bb0-a0c9-b97b1a8f0b1d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:40+00:00",
        "updated_at": "2023-02-14T11:05:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7a0be8ea-88e0-4009-815f-4219e7d7a5cc",
        "planning_id": "c8f97999-807c-4154-a395-fbb31e36f52c",
        "order_id": "17cd5d58-d7f9-474b-b294-35b531395dbe"
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
          "order_id": "1218ab7a-c57e-464c-94fb-d94fce5981e8",
          "items": [
            {
              "type": "bundles",
              "id": "fb737c69-b5ae-4e12-85e3-e3d2697a9ce5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "bc813d81-bf26-40dc-b54e-25980694e22e",
                  "id": "92d08675-a1fd-435f-8e57-252f0ebd4754"
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
    "id": "4780f907-ac92-571c-a1da-9decba5da327",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1218ab7a-c57e-464c-94fb-d94fce5981e8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1218ab7a-c57e-464c-94fb-d94fce5981e8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "91f25fc4-fa2e-4d2d-a23c-0605bc588c04"
          },
          {
            "type": "lines",
            "id": "d258956b-191b-48ab-9d0c-85c1311e2a1c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "06e1db28-32cf-4b28-aa6d-d09892378f15"
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
      "id": "1218ab7a-c57e-464c-94fb-d94fce5981e8",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:05:44+00:00",
        "updated_at": "2023-02-14T11:05:44+00:00",
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
        "starts_at": "2023-02-12T11:00:00+00:00",
        "stops_at": "2023-02-16T11:00:00+00:00",
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
        "start_location_id": "69a5601c-edb6-4d20-aaed-2c37a224300c",
        "stop_location_id": "69a5601c-edb6-4d20-aaed-2c37a224300c"
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
      "id": "91f25fc4-fa2e-4d2d-a23c-0605bc588c04",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:44+00:00",
        "updated_at": "2023-02-14T11:05:44+00:00",
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
        "item_id": "fb737c69-b5ae-4e12-85e3-e3d2697a9ce5",
        "tax_category_id": null,
        "planning_id": "06e1db28-32cf-4b28-aa6d-d09892378f15",
        "parent_line_id": null,
        "owner_id": "1218ab7a-c57e-464c-94fb-d94fce5981e8",
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
      "id": "d258956b-191b-48ab-9d0c-85c1311e2a1c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:44+00:00",
        "updated_at": "2023-02-14T11:05:44+00:00",
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
        "item_id": "92d08675-a1fd-435f-8e57-252f0ebd4754",
        "tax_category_id": null,
        "planning_id": "785b408b-1445-4170-bc52-faed1192402b",
        "parent_line_id": "91f25fc4-fa2e-4d2d-a23c-0605bc588c04",
        "owner_id": "1218ab7a-c57e-464c-94fb-d94fce5981e8",
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
      "id": "06e1db28-32cf-4b28-aa6d-d09892378f15",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:44+00:00",
        "updated_at": "2023-02-14T11:05:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-12T11:00:00+00:00",
        "stops_at": "2023-02-16T11:00:00+00:00",
        "reserved_from": "2023-02-12T11:00:00+00:00",
        "reserved_till": "2023-02-16T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "fb737c69-b5ae-4e12-85e3-e3d2697a9ce5",
        "order_id": "1218ab7a-c57e-464c-94fb-d94fce5981e8",
        "start_location_id": "69a5601c-edb6-4d20-aaed-2c37a224300c",
        "stop_location_id": "69a5601c-edb6-4d20-aaed-2c37a224300c",
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





