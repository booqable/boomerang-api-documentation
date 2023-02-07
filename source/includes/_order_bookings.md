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
          "order_id": "e2e73140-8d74-4207-b37a-439a45da7e50",
          "items": [
            {
              "type": "products",
              "id": "8e6d09e0-f5cb-474f-a4d3-33e54e1a0b79",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2ef9cdf3-a395-468b-a742-290db6832430",
              "stock_item_ids": [
                "a9bb2f3a-3f0a-4563-a935-2bfcd8147b6f",
                "1fb4be23-a237-4574-a0d9-11ae453c18bb"
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
            "item_id": "8e6d09e0-f5cb-474f-a4d3-33e54e1a0b79",
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
          "order_id": "086fa39b-15e9-4298-87b0-6f1908202151",
          "items": [
            {
              "type": "products",
              "id": "46a7bb7e-bbab-4b84-bf32-544fca0ad3ee",
              "stock_item_ids": [
                "f36d01fd-3046-443d-bfc1-db25392d200f",
                "2455b5dc-96a4-453a-890d-b3576ec3621f",
                "0ff4d6f8-86a8-46bc-a924-a269c400c5ac"
              ]
            },
            {
              "type": "products",
              "id": "1f4d7856-be5a-4021-9eda-91ccf0bb6a42",
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
    "id": "4517457d-0a06-5b22-89f3-61f83d2f90d1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "086fa39b-15e9-4298-87b0-6f1908202151"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "086fa39b-15e9-4298-87b0-6f1908202151"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "577dbd93-a3ce-4629-bd44-778a99308e46"
          },
          {
            "type": "lines",
            "id": "4a8e1c61-f97f-4f18-b80a-3b4d2a48b830"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "71715d91-bf60-44f1-8038-74066cbfc18f"
          },
          {
            "type": "plannings",
            "id": "dc48c192-9994-4ce1-996a-f91ee4054cec"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0ad1bda5-d611-4a2f-ad66-3a7eb72b9232"
          },
          {
            "type": "stock_item_plannings",
            "id": "f6c3b898-84dd-4f15-9449-dd19f7b85d7a"
          },
          {
            "type": "stock_item_plannings",
            "id": "f84ef58c-0fe5-4111-9c86-f32424d258c9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "086fa39b-15e9-4298-87b0-6f1908202151",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T15:01:15+00:00",
        "updated_at": "2023-02-07T15:01:17+00:00",
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
        "customer_id": "324771d0-9980-4893-af7b-abcf2b79c7d4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773",
        "stop_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773"
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
      "id": "577dbd93-a3ce-4629-bd44-778a99308e46",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:17+00:00",
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
        "item_id": "46a7bb7e-bbab-4b84-bf32-544fca0ad3ee",
        "tax_category_id": "77e78a70-9df7-4234-9e4e-1a50a4c9f898",
        "planning_id": "71715d91-bf60-44f1-8038-74066cbfc18f",
        "parent_line_id": null,
        "owner_id": "086fa39b-15e9-4298-87b0-6f1908202151",
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
      "id": "4a8e1c61-f97f-4f18-b80a-3b4d2a48b830",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:17+00:00",
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
        "item_id": "1f4d7856-be5a-4021-9eda-91ccf0bb6a42",
        "tax_category_id": "77e78a70-9df7-4234-9e4e-1a50a4c9f898",
        "planning_id": "dc48c192-9994-4ce1-996a-f91ee4054cec",
        "parent_line_id": null,
        "owner_id": "086fa39b-15e9-4298-87b0-6f1908202151",
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
      "id": "71715d91-bf60-44f1-8038-74066cbfc18f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:17+00:00",
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
        "item_id": "46a7bb7e-bbab-4b84-bf32-544fca0ad3ee",
        "order_id": "086fa39b-15e9-4298-87b0-6f1908202151",
        "start_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773",
        "stop_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773",
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
      "id": "dc48c192-9994-4ce1-996a-f91ee4054cec",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:17+00:00",
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
        "item_id": "1f4d7856-be5a-4021-9eda-91ccf0bb6a42",
        "order_id": "086fa39b-15e9-4298-87b0-6f1908202151",
        "start_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773",
        "stop_location_id": "65f2c54a-67b6-497d-b96f-6a308e1e1773",
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
      "id": "0ad1bda5-d611-4a2f-ad66-3a7eb72b9232",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f36d01fd-3046-443d-bfc1-db25392d200f",
        "planning_id": "71715d91-bf60-44f1-8038-74066cbfc18f",
        "order_id": "086fa39b-15e9-4298-87b0-6f1908202151"
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
      "id": "f6c3b898-84dd-4f15-9449-dd19f7b85d7a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2455b5dc-96a4-453a-890d-b3576ec3621f",
        "planning_id": "71715d91-bf60-44f1-8038-74066cbfc18f",
        "order_id": "086fa39b-15e9-4298-87b0-6f1908202151"
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
      "id": "f84ef58c-0fe5-4111-9c86-f32424d258c9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:16+00:00",
        "updated_at": "2023-02-07T15:01:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0ff4d6f8-86a8-46bc-a924-a269c400c5ac",
        "planning_id": "71715d91-bf60-44f1-8038-74066cbfc18f",
        "order_id": "086fa39b-15e9-4298-87b0-6f1908202151"
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
          "order_id": "c31756af-830e-430b-8ea8-aba6dc7e77cd",
          "items": [
            {
              "type": "bundles",
              "id": "58835379-9415-47cb-8c37-d01b11664b7b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "51a5e21a-98cc-451b-b39f-5c9ee4e48b7f",
                  "id": "7feeb15e-8774-4594-aed5-bcbaaba04e56"
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
    "id": "7d1969df-45ab-5c8f-b275-3cda038b6c4c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c31756af-830e-430b-8ea8-aba6dc7e77cd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c31756af-830e-430b-8ea8-aba6dc7e77cd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "41b4908f-b55f-459a-b788-09e24b0a1425"
          },
          {
            "type": "lines",
            "id": "596848ea-db8d-43c8-91d4-6915871f6700"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f91c18ca-8a22-4234-a25e-dc9807eb20cc"
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
      "id": "c31756af-830e-430b-8ea8-aba6dc7e77cd",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T15:01:19+00:00",
        "updated_at": "2023-02-07T15:01:20+00:00",
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
        "starts_at": "2023-02-05T15:00:00+00:00",
        "stops_at": "2023-02-09T15:00:00+00:00",
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
        "start_location_id": "9f201b14-54e0-49c9-8a45-4d9e739d318c",
        "stop_location_id": "9f201b14-54e0-49c9-8a45-4d9e739d318c"
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
      "id": "41b4908f-b55f-459a-b788-09e24b0a1425",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:01:19+00:00",
        "updated_at": "2023-02-07T15:01:19+00:00",
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
        "item_id": "7feeb15e-8774-4594-aed5-bcbaaba04e56",
        "tax_category_id": null,
        "planning_id": "ac870ef3-f9fb-4b73-bc40-96e58e552d54",
        "parent_line_id": "596848ea-db8d-43c8-91d4-6915871f6700",
        "owner_id": "c31756af-830e-430b-8ea8-aba6dc7e77cd",
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
      "id": "596848ea-db8d-43c8-91d4-6915871f6700",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:01:19+00:00",
        "updated_at": "2023-02-07T15:01:19+00:00",
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
        "item_id": "58835379-9415-47cb-8c37-d01b11664b7b",
        "tax_category_id": null,
        "planning_id": "f91c18ca-8a22-4234-a25e-dc9807eb20cc",
        "parent_line_id": null,
        "owner_id": "c31756af-830e-430b-8ea8-aba6dc7e77cd",
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
      "id": "f91c18ca-8a22-4234-a25e-dc9807eb20cc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:01:19+00:00",
        "updated_at": "2023-02-07T15:01:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T15:00:00+00:00",
        "stops_at": "2023-02-09T15:00:00+00:00",
        "reserved_from": "2023-02-05T15:00:00+00:00",
        "reserved_till": "2023-02-09T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "58835379-9415-47cb-8c37-d01b11664b7b",
        "order_id": "c31756af-830e-430b-8ea8-aba6dc7e77cd",
        "start_location_id": "9f201b14-54e0-49c9-8a45-4d9e739d318c",
        "stop_location_id": "9f201b14-54e0-49c9-8a45-4d9e739d318c",
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





