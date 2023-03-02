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
          "order_id": "ab0e04c8-edcf-4b27-8eb4-450e2d20d983",
          "items": [
            {
              "type": "products",
              "id": "8dac62df-2866-4f0c-b4b0-f1de86934ee3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e39b968c-c8b0-49be-bc96-870b090f6570",
              "stock_item_ids": [
                "3ef9fc75-86ff-4523-9b6f-9a8318fd70a0",
                "a59e48aa-3865-45e9-903d-0c87f07456fc"
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
          "stock_item_id 3ef9fc75-86ff-4523-9b6f-9a8318fd70a0 has already been booked on this order"
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
          "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b",
          "items": [
            {
              "type": "products",
              "id": "328a56b0-6a11-46e9-9128-66536e5216d5",
              "stock_item_ids": [
                "0ce1b3d7-ac28-4078-a824-9cb64a026d9a",
                "c39a862e-0487-4619-a882-f215cfd94fcd",
                "d4770e7f-ce00-4e46-8963-7fcffa38d68d"
              ]
            },
            {
              "type": "products",
              "id": "c4201794-2aec-4a60-9200-0a87c604f8c0",
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
    "id": "957fc474-d14d-5f39-8a91-e16da8b55dbd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "603ef185-0f5d-461b-91ab-309c1ced886b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0dde2e0e-94f3-4488-9807-9061c3b65646"
          },
          {
            "type": "lines",
            "id": "c2e8a752-2047-4ce8-a390-708522b4c057"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "64d71bbe-1775-4c85-9c43-6daa004246c2"
          },
          {
            "type": "plannings",
            "id": "0ca93218-9d0e-4d52-b2dc-7ecdca3d527a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "21e26e5a-0217-4abc-a617-f182acd7c377"
          },
          {
            "type": "stock_item_plannings",
            "id": "3cfef7cc-5a03-4941-9480-7b0a23bd2cd8"
          },
          {
            "type": "stock_item_plannings",
            "id": "4e6a19fe-4859-4254-ab91-d5a93d348abd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "603ef185-0f5d-461b-91ab-309c1ced886b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T09:25:14+00:00",
        "updated_at": "2023-03-02T09:25:17+00:00",
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
        "customer_id": "050acf49-5be2-402a-afaf-60c145bde0dc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471",
        "stop_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471"
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
      "id": "0dde2e0e-94f3-4488-9807-9061c3b65646",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
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
        "item_id": "328a56b0-6a11-46e9-9128-66536e5216d5",
        "tax_category_id": "9e0705fc-b8b5-4d68-a034-172f25e5478d",
        "planning_id": "64d71bbe-1775-4c85-9c43-6daa004246c2",
        "parent_line_id": null,
        "owner_id": "603ef185-0f5d-461b-91ab-309c1ced886b",
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
      "id": "c2e8a752-2047-4ce8-a390-708522b4c057",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
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
        "item_id": "c4201794-2aec-4a60-9200-0a87c604f8c0",
        "tax_category_id": "9e0705fc-b8b5-4d68-a034-172f25e5478d",
        "planning_id": "0ca93218-9d0e-4d52-b2dc-7ecdca3d527a",
        "parent_line_id": null,
        "owner_id": "603ef185-0f5d-461b-91ab-309c1ced886b",
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
      "id": "64d71bbe-1775-4c85-9c43-6daa004246c2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
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
        "item_id": "328a56b0-6a11-46e9-9128-66536e5216d5",
        "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b",
        "start_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471",
        "stop_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471",
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
      "id": "0ca93218-9d0e-4d52-b2dc-7ecdca3d527a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
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
        "item_id": "c4201794-2aec-4a60-9200-0a87c604f8c0",
        "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b",
        "start_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471",
        "stop_location_id": "71ac5389-9dd1-4c4c-b89a-475da863a471",
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
      "id": "21e26e5a-0217-4abc-a617-f182acd7c377",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0ce1b3d7-ac28-4078-a824-9cb64a026d9a",
        "planning_id": "64d71bbe-1775-4c85-9c43-6daa004246c2",
        "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b"
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
      "id": "3cfef7cc-5a03-4941-9480-7b0a23bd2cd8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c39a862e-0487-4619-a882-f215cfd94fcd",
        "planning_id": "64d71bbe-1775-4c85-9c43-6daa004246c2",
        "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b"
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
      "id": "4e6a19fe-4859-4254-ab91-d5a93d348abd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:16+00:00",
        "updated_at": "2023-03-02T09:25:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d4770e7f-ce00-4e46-8963-7fcffa38d68d",
        "planning_id": "64d71bbe-1775-4c85-9c43-6daa004246c2",
        "order_id": "603ef185-0f5d-461b-91ab-309c1ced886b"
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
          "order_id": "f434309b-1f51-48f1-98e7-0666ee379b68",
          "items": [
            {
              "type": "bundles",
              "id": "f795bbe6-451e-47c8-a0d2-f85044ff5db1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5afaa73f-d0ac-4c2a-b1ee-470d95b3406c",
                  "id": "c21f1757-1456-475f-99e9-15bf9fe47729"
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
    "id": "5ce42642-5f9b-543d-83e6-197982b0e2a2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f434309b-1f51-48f1-98e7-0666ee379b68"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f434309b-1f51-48f1-98e7-0666ee379b68"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6496a1da-4b65-4b38-960a-327d070f5132"
          },
          {
            "type": "lines",
            "id": "ecc77c4f-c88c-47b8-be09-e7c4f22e38d0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9f283c29-0f70-4ffd-8653-e6e7dd79862a"
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
      "id": "f434309b-1f51-48f1-98e7-0666ee379b68",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T09:25:19+00:00",
        "updated_at": "2023-03-02T09:25:20+00:00",
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
        "starts_at": "2023-02-28T09:15:00+00:00",
        "stops_at": "2023-03-04T09:15:00+00:00",
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
        "start_location_id": "7c8d9a71-a7b5-4e95-9bea-1b6fe9cd04b1",
        "stop_location_id": "7c8d9a71-a7b5-4e95-9bea-1b6fe9cd04b1"
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
      "id": "6496a1da-4b65-4b38-960a-327d070f5132",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T09:25:20+00:00",
        "updated_at": "2023-03-02T09:25:20+00:00",
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
        "item_id": "f795bbe6-451e-47c8-a0d2-f85044ff5db1",
        "tax_category_id": null,
        "planning_id": "9f283c29-0f70-4ffd-8653-e6e7dd79862a",
        "parent_line_id": null,
        "owner_id": "f434309b-1f51-48f1-98e7-0666ee379b68",
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
      "id": "ecc77c4f-c88c-47b8-be09-e7c4f22e38d0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T09:25:20+00:00",
        "updated_at": "2023-03-02T09:25:20+00:00",
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
        "item_id": "c21f1757-1456-475f-99e9-15bf9fe47729",
        "tax_category_id": null,
        "planning_id": "d139d7f1-267c-4958-bb74-9d9d0c2dcfe5",
        "parent_line_id": "6496a1da-4b65-4b38-960a-327d070f5132",
        "owner_id": "f434309b-1f51-48f1-98e7-0666ee379b68",
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
      "id": "9f283c29-0f70-4ffd-8653-e6e7dd79862a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T09:25:20+00:00",
        "updated_at": "2023-03-02T09:25:20+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-28T09:15:00+00:00",
        "stops_at": "2023-03-04T09:15:00+00:00",
        "reserved_from": "2023-02-28T09:15:00+00:00",
        "reserved_till": "2023-03-04T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f795bbe6-451e-47c8-a0d2-f85044ff5db1",
        "order_id": "f434309b-1f51-48f1-98e7-0666ee379b68",
        "start_location_id": "7c8d9a71-a7b5-4e95-9bea-1b6fe9cd04b1",
        "stop_location_id": "7c8d9a71-a7b5-4e95-9bea-1b6fe9cd04b1",
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





