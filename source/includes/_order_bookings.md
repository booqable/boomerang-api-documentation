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
          "order_id": "ac234719-0b60-4e4e-9a26-ee20996ce36f",
          "items": [
            {
              "type": "products",
              "id": "37ecfa46-d98b-4e04-95bf-23cff348010e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "25cf3238-6e16-4f4b-87a2-c6c00384cbd2",
              "stock_item_ids": [
                "30c0a98c-f046-4d0e-aa45-9b9b2c2a642d",
                "75527180-c472-4f32-8c65-48c8d2df3ecc"
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
            "item_id": "37ecfa46-d98b-4e04-95bf-23cff348010e",
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
          "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
          "items": [
            {
              "type": "products",
              "id": "d28df997-4d41-4b8c-badd-e976b1fa2fb6",
              "stock_item_ids": [
                "953c6153-79b2-4908-8c4e-1f568ecba1d0",
                "b5e33f58-93a9-45c2-b7e9-3a506cdbcfba",
                "62592226-8349-41fd-a985-617bbdf482f2"
              ]
            },
            {
              "type": "products",
              "id": "156b1d77-7336-4e47-a3e2-d56a98022a41",
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
    "id": "41d92683-3c3d-5ff7-a22a-bf041a5cd201",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e60ace1f-b02c-4192-b150-2cf26a72d872"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "13cfa7a1-d9ce-40e0-955b-e19de3a651b0"
          },
          {
            "type": "lines",
            "id": "3ad0cddb-bde1-4a6d-b1e2-47cbf33aafd9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ea60c646-55ad-49a2-80f5-3b152550ec3c"
          },
          {
            "type": "plannings",
            "id": "9af78ee0-637c-4068-b9b5-5d7df44293e7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fd75df8b-5856-47b9-b326-d259404b5d6f"
          },
          {
            "type": "stock_item_plannings",
            "id": "864f2134-5546-4ad7-8719-0639d77d5458"
          },
          {
            "type": "stock_item_plannings",
            "id": "11685120-8e45-4028-a107-98c6b0e39af6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T10:28:59+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
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
        "customer_id": "07241d8a-af25-43da-a33c-5915396532ab",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55",
        "stop_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55"
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
      "id": "13cfa7a1-d9ce-40e0-955b-e19de3a651b0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
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
        "item_id": "d28df997-4d41-4b8c-badd-e976b1fa2fb6",
        "tax_category_id": "c8a42a11-8e34-4f5b-ad33-7078f6f058fa",
        "planning_id": "ea60c646-55ad-49a2-80f5-3b152550ec3c",
        "parent_line_id": null,
        "owner_id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
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
      "id": "3ad0cddb-bde1-4a6d-b1e2-47cbf33aafd9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
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
        "item_id": "156b1d77-7336-4e47-a3e2-d56a98022a41",
        "tax_category_id": "c8a42a11-8e34-4f5b-ad33-7078f6f058fa",
        "planning_id": "9af78ee0-637c-4068-b9b5-5d7df44293e7",
        "parent_line_id": null,
        "owner_id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
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
      "id": "ea60c646-55ad-49a2-80f5-3b152550ec3c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
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
        "item_id": "d28df997-4d41-4b8c-badd-e976b1fa2fb6",
        "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
        "start_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55",
        "stop_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55",
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
      "id": "9af78ee0-637c-4068-b9b5-5d7df44293e7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
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
        "item_id": "156b1d77-7336-4e47-a3e2-d56a98022a41",
        "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872",
        "start_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55",
        "stop_location_id": "f0385cc2-dd8b-4675-87c1-9dbf21ff0f55",
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
      "id": "fd75df8b-5856-47b9-b326-d259404b5d6f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "953c6153-79b2-4908-8c4e-1f568ecba1d0",
        "planning_id": "ea60c646-55ad-49a2-80f5-3b152550ec3c",
        "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872"
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
      "id": "864f2134-5546-4ad7-8719-0639d77d5458",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b5e33f58-93a9-45c2-b7e9-3a506cdbcfba",
        "planning_id": "ea60c646-55ad-49a2-80f5-3b152550ec3c",
        "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872"
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
      "id": "11685120-8e45-4028-a107-98c6b0e39af6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:01+00:00",
        "updated_at": "2023-02-07T10:29:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "62592226-8349-41fd-a985-617bbdf482f2",
        "planning_id": "ea60c646-55ad-49a2-80f5-3b152550ec3c",
        "order_id": "e60ace1f-b02c-4192-b150-2cf26a72d872"
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
          "order_id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95",
          "items": [
            {
              "type": "bundles",
              "id": "38984283-ee03-4087-a7f1-5af51e351d60",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8eaefb07-23c1-4ae2-afd0-b539c8ffbcfe",
                  "id": "2fe7fdf9-d3a4-42f5-983e-c4d45fb189c6"
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
    "id": "d0c06da9-70ce-5885-a7b6-354f37626382",
    "type": "order_bookings",
    "attributes": {
      "order_id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "873fd0b2-dfa2-4784-8b55-b870408bf124"
          },
          {
            "type": "lines",
            "id": "a8edc767-e0e7-440c-a8ad-d88a96e1608c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5f393ff0-02cf-45d5-999c-7c46474b1c62"
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
      "id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T10:29:04+00:00",
        "updated_at": "2023-02-07T10:29:05+00:00",
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
        "starts_at": "2023-02-05T10:15:00+00:00",
        "stops_at": "2023-02-09T10:15:00+00:00",
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
        "start_location_id": "16ca922b-f721-4d57-9da4-38adb5401fe9",
        "stop_location_id": "16ca922b-f721-4d57-9da4-38adb5401fe9"
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
      "id": "873fd0b2-dfa2-4784-8b55-b870408bf124",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T10:29:04+00:00",
        "updated_at": "2023-02-07T10:29:04+00:00",
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
        "item_id": "2fe7fdf9-d3a4-42f5-983e-c4d45fb189c6",
        "tax_category_id": null,
        "planning_id": "5398ff4a-6d23-4e37-8d7b-e6b1a59cf0d8",
        "parent_line_id": "a8edc767-e0e7-440c-a8ad-d88a96e1608c",
        "owner_id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95",
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
      "id": "a8edc767-e0e7-440c-a8ad-d88a96e1608c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T10:29:04+00:00",
        "updated_at": "2023-02-07T10:29:04+00:00",
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
        "item_id": "38984283-ee03-4087-a7f1-5af51e351d60",
        "tax_category_id": null,
        "planning_id": "5f393ff0-02cf-45d5-999c-7c46474b1c62",
        "parent_line_id": null,
        "owner_id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95",
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
      "id": "5f393ff0-02cf-45d5-999c-7c46474b1c62",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T10:29:04+00:00",
        "updated_at": "2023-02-07T10:29:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T10:15:00+00:00",
        "stops_at": "2023-02-09T10:15:00+00:00",
        "reserved_from": "2023-02-05T10:15:00+00:00",
        "reserved_till": "2023-02-09T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "38984283-ee03-4087-a7f1-5af51e351d60",
        "order_id": "338f1b6c-a098-4cbb-b3ca-cf94d2c9bd95",
        "start_location_id": "16ca922b-f721-4d57-9da4-38adb5401fe9",
        "stop_location_id": "16ca922b-f721-4d57-9da4-38adb5401fe9",
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





