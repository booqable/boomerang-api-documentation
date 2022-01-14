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
          "order_id": "48072168-6fff-4436-94ef-5b0608be36aa",
          "items": [
            {
              "type": "products",
              "id": "f16f0aad-0e5d-4972-9b5e-d5986de73ba4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d3d33c73-5339-41da-ab85-715a82d9e35a",
              "stock_item_ids": [
                "2561d989-836b-4587-9f27-b4012be64ed0",
                "c1ea952c-0a34-43cc-95e8-3f60305a9895"
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
            "item_id": "f16f0aad-0e5d-4972-9b5e-d5986de73ba4",
            "stock_count": 7,
            "reserved": 0,
            "needed": 10,
            "shortage": 3
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
          "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
          "items": [
            {
              "type": "products",
              "id": "7230e44f-32fb-4ce4-a14d-4bb82e598eca",
              "stock_item_ids": [
                "14de776a-dd67-41f8-b407-3115ca0469ea",
                "743d7f6a-2af9-480f-b43e-82f36aa53ca8",
                "0b0c3083-ad40-42e1-b19f-e6e982d90138"
              ]
            },
            {
              "type": "products",
              "id": "10c77ccd-e53e-4fdd-8c6c-f7d0870f147e",
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
    "id": "6abe4b99-6735-5b0c-914e-545413e30a8f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c09b7783-8f72-4424-8119-22e6eb8448a7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b96a166f-f346-4e6e-aa0a-56979762902f"
          },
          {
            "type": "lines",
            "id": "c3d17d08-ade2-492f-b7a0-f0c95fa25bcf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ae55d803-b02c-4b84-a587-b5975176ec17"
          },
          {
            "type": "plannings",
            "id": "c39eaabb-8bb6-4ea7-8308-602819b7f517"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e4e0c76f-9bdb-48b4-80a1-332228db26a8"
          },
          {
            "type": "stock_item_plannings",
            "id": "71ef0930-447c-4366-932c-adcea6d64af6"
          },
          {
            "type": "stock_item_plannings",
            "id": "a46f7fbf-8200-43e3-a9d8-9cb622b7e663"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-14T18:54:16+00:00",
        "updated_at": "2022-01-14T18:54:19+00:00",
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
        "customer_id": "2ada2c2a-e44d-4840-81f8-19ea89480218",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808",
        "stop_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808"
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
      "id": "b96a166f-f346-4e6e-aa0a-56979762902f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-14T18:54:17+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
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
        "item_id": "10c77ccd-e53e-4fdd-8c6c-f7d0870f147e",
        "tax_category_id": "f960a7b0-d172-4f5c-9253-aad7309f07d8",
        "planning_id": "ae55d803-b02c-4b84-a587-b5975176ec17",
        "parent_line_id": null,
        "owner_id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
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
      "id": "c3d17d08-ade2-492f-b7a0-f0c95fa25bcf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-14T18:54:18+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
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
        "item_id": "7230e44f-32fb-4ce4-a14d-4bb82e598eca",
        "tax_category_id": "f960a7b0-d172-4f5c-9253-aad7309f07d8",
        "planning_id": "c39eaabb-8bb6-4ea7-8308-602819b7f517",
        "parent_line_id": null,
        "owner_id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
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
      "id": "ae55d803-b02c-4b84-a587-b5975176ec17",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:17+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
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
        "item_id": "10c77ccd-e53e-4fdd-8c6c-f7d0870f147e",
        "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
        "start_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808",
        "stop_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808",
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
      "id": "c39eaabb-8bb6-4ea7-8308-602819b7f517",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:18+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
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
        "item_id": "7230e44f-32fb-4ce4-a14d-4bb82e598eca",
        "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7",
        "start_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808",
        "stop_location_id": "5e627f30-c40b-48d2-97f0-d2e6b960a808",
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
      "id": "e4e0c76f-9bdb-48b4-80a1-332228db26a8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:18+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "14de776a-dd67-41f8-b407-3115ca0469ea",
        "planning_id": "c39eaabb-8bb6-4ea7-8308-602819b7f517",
        "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7"
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
      "id": "71ef0930-447c-4366-932c-adcea6d64af6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:18+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "743d7f6a-2af9-480f-b43e-82f36aa53ca8",
        "planning_id": "c39eaabb-8bb6-4ea7-8308-602819b7f517",
        "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7"
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
      "id": "a46f7fbf-8200-43e3-a9d8-9cb622b7e663",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:18+00:00",
        "updated_at": "2022-01-14T18:54:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0b0c3083-ad40-42e1-b19f-e6e982d90138",
        "planning_id": "c39eaabb-8bb6-4ea7-8308-602819b7f517",
        "order_id": "c09b7783-8f72-4424-8119-22e6eb8448a7"
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
          "order_id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7",
          "items": [
            {
              "type": "bundles",
              "id": "bbb0cafc-ead5-4d67-9782-b2b9911ea707",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "27d77e09-3336-4421-ba1b-b3e366dbdf4c",
                  "id": "6265b33c-2d36-4664-931b-26f5f7128948"
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
    "id": "95c7c96c-c44b-58d3-9ea5-0ea8656430a6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e8a777f-f476-455c-ac64-20f7404cc33c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2733496e-a00f-41d7-97bc-c30544744856"
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
      "id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-14T18:54:21+00:00",
        "updated_at": "2022-01-14T18:54:22+00:00",
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
        "starts_at": "2022-01-12T18:45:00+00:00",
        "stops_at": "2022-01-16T18:45:00+00:00",
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
        "start_location_id": "1110863a-b9fd-41bf-ab8a-2808a0f3196f",
        "stop_location_id": "1110863a-b9fd-41bf-ab8a-2808a0f3196f"
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
      "id": "5e8a777f-f476-455c-ac64-20f7404cc33c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-14T18:54:22+00:00",
        "updated_at": "2022-01-14T18:54:22+00:00",
        "title": "Bundle item 1",
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
        "item_id": "bbb0cafc-ead5-4d67-9782-b2b9911ea707",
        "tax_category_id": null,
        "planning_id": "2733496e-a00f-41d7-97bc-c30544744856",
        "parent_line_id": null,
        "owner_id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7",
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
      "id": "2733496e-a00f-41d7-97bc-c30544744856",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-14T18:54:22+00:00",
        "updated_at": "2022-01-14T18:54:22+00:00",
        "quantity": 1,
        "starts_at": "2022-01-12T18:45:00+00:00",
        "stops_at": "2022-01-16T18:45:00+00:00",
        "reserved_from": "2022-01-12T18:45:00+00:00",
        "reserved_till": "2022-01-16T18:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "bbb0cafc-ead5-4d67-9782-b2b9911ea707",
        "order_id": "84666a2d-06e2-4702-8b06-4f1aeffaf3d7",
        "start_location_id": "1110863a-b9fd-41bf-ab8a-2808a0f3196f",
        "stop_location_id": "1110863a-b9fd-41bf-ab8a-2808a0f3196f",
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





