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
          "order_id": "b7c96e94-595e-48a1-9280-00c3eaca35cb",
          "items": [
            {
              "type": "products",
              "id": "a05330a4-dee1-49e7-81d9-b95c67845fbd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9380050c-4278-42ae-a3f2-d2f947e70575",
              "stock_item_ids": [
                "74f72d17-bfa6-4c23-8183-211b496af94c",
                "27ab417c-bc90-4bc9-bdd1-30f3a7b3570a"
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
            "item_id": "a05330a4-dee1-49e7-81d9-b95c67845fbd",
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
          "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
          "items": [
            {
              "type": "products",
              "id": "5aeb5cd3-f6e4-4030-a6c1-bfbacd4e06cf",
              "stock_item_ids": [
                "0badd7b4-ff22-4b22-af6e-2207ad640f2e",
                "2c6b97bf-c980-45c8-a1fb-a14d30d93113",
                "37cb5441-b082-461f-994b-270fa9a3da1c"
              ]
            },
            {
              "type": "products",
              "id": "6015836c-9779-4711-aca1-8919f3a06b5a",
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
    "id": "511f9977-3a2a-5db7-bfda-7410139ab80c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "29f98408-4e2e-4fea-bb0a-a35136e94909"
          },
          {
            "type": "lines",
            "id": "01116081-59b7-441c-b493-a30533ce9382"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4a124e36-8e26-4046-a5c1-06713f77a959"
          },
          {
            "type": "plannings",
            "id": "3c5d76d4-cd6a-4c22-bb18-1a9fd5e36f2e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "30bf91b4-5e60-49c0-92ec-a015e1288eea"
          },
          {
            "type": "stock_item_plannings",
            "id": "0fad5617-5e91-4884-8342-cd9d9ee90141"
          },
          {
            "type": "stock_item_plannings",
            "id": "5588f384-a35e-4fb8-ad35-ae7bc1cfa2c0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-06T11:19:29+00:00",
        "updated_at": "2022-12-06T11:19:32+00:00",
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
        "customer_id": "cf9fef52-e68d-4ed3-9600-391da5dbc032",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43",
        "stop_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43"
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
      "id": "29f98408-4e2e-4fea-bb0a-a35136e94909",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
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
        "item_id": "5aeb5cd3-f6e4-4030-a6c1-bfbacd4e06cf",
        "tax_category_id": "e28eb02c-02cb-4ef0-9a01-606918f2c020",
        "planning_id": "4a124e36-8e26-4046-a5c1-06713f77a959",
        "parent_line_id": null,
        "owner_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
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
      "id": "01116081-59b7-441c-b493-a30533ce9382",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
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
        "item_id": "6015836c-9779-4711-aca1-8919f3a06b5a",
        "tax_category_id": "e28eb02c-02cb-4ef0-9a01-606918f2c020",
        "planning_id": "3c5d76d4-cd6a-4c22-bb18-1a9fd5e36f2e",
        "parent_line_id": null,
        "owner_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
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
      "id": "4a124e36-8e26-4046-a5c1-06713f77a959",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
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
        "item_id": "5aeb5cd3-f6e4-4030-a6c1-bfbacd4e06cf",
        "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
        "start_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43",
        "stop_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43",
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
      "id": "3c5d76d4-cd6a-4c22-bb18-1a9fd5e36f2e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
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
        "item_id": "6015836c-9779-4711-aca1-8919f3a06b5a",
        "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87",
        "start_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43",
        "stop_location_id": "790a6f3a-acc7-4283-a03d-4608f30e8b43",
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
      "id": "30bf91b4-5e60-49c0-92ec-a015e1288eea",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0badd7b4-ff22-4b22-af6e-2207ad640f2e",
        "planning_id": "4a124e36-8e26-4046-a5c1-06713f77a959",
        "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87"
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
      "id": "0fad5617-5e91-4884-8342-cd9d9ee90141",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2c6b97bf-c980-45c8-a1fb-a14d30d93113",
        "planning_id": "4a124e36-8e26-4046-a5c1-06713f77a959",
        "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87"
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
      "id": "5588f384-a35e-4fb8-ad35-ae7bc1cfa2c0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:31+00:00",
        "updated_at": "2022-12-06T11:19:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "37cb5441-b082-461f-994b-270fa9a3da1c",
        "planning_id": "4a124e36-8e26-4046-a5c1-06713f77a959",
        "order_id": "31f746d3-b789-4c9c-a8fd-b6c4888bdd87"
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
          "order_id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76",
          "items": [
            {
              "type": "bundles",
              "id": "a4a59cbd-87b8-4ad0-a1f4-cceb8cecdfd1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c34af0c0-b4b4-4027-b492-23aefe758ec1",
                  "id": "ac75f85b-ae66-41cd-a617-9b58a31abf83"
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
    "id": "9d8dc65e-37b3-5b7d-b18a-7f879ab062b0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e4f542e8-9653-4553-93c2-621a32307c7c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "272443ab-4085-4c97-ad50-eddc916279a3"
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
      "id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-06T11:19:35+00:00",
        "updated_at": "2022-12-06T11:19:35+00:00",
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
        "starts_at": "2022-12-04T11:15:00+00:00",
        "stops_at": "2022-12-08T11:15:00+00:00",
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
        "start_location_id": "d79a4552-65e8-42bb-b930-ee1729485bc1",
        "stop_location_id": "d79a4552-65e8-42bb-b930-ee1729485bc1"
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
      "id": "e4f542e8-9653-4553-93c2-621a32307c7c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-06T11:19:35+00:00",
        "updated_at": "2022-12-06T11:19:35+00:00",
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
        "item_id": "a4a59cbd-87b8-4ad0-a1f4-cceb8cecdfd1",
        "tax_category_id": null,
        "planning_id": "272443ab-4085-4c97-ad50-eddc916279a3",
        "parent_line_id": null,
        "owner_id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76",
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
      "id": "272443ab-4085-4c97-ad50-eddc916279a3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-06T11:19:35+00:00",
        "updated_at": "2022-12-06T11:19:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-12-04T11:15:00+00:00",
        "stops_at": "2022-12-08T11:15:00+00:00",
        "reserved_from": "2022-12-04T11:15:00+00:00",
        "reserved_till": "2022-12-08T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a4a59cbd-87b8-4ad0-a1f4-cceb8cecdfd1",
        "order_id": "fcb29572-afa9-4f1c-a08d-8ac3534eda76",
        "start_location_id": "d79a4552-65e8-42bb-b930-ee1729485bc1",
        "stop_location_id": "d79a4552-65e8-42bb-b930-ee1729485bc1",
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





