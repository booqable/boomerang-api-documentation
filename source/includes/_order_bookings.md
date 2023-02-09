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
          "order_id": "02dd4377-b4b3-4b90-87fa-0740e46ab453",
          "items": [
            {
              "type": "products",
              "id": "6dd2ac8c-e01b-40db-9ae4-29ca21314b50",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "84f0424d-e89f-42c0-939f-9fb919032021",
              "stock_item_ids": [
                "d38ac6ca-6963-4868-a0f5-baf6f5829f7d",
                "7aecf8db-034e-4321-93bf-1b6e520be952"
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
            "item_id": "6dd2ac8c-e01b-40db-9ae4-29ca21314b50",
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
          "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
          "items": [
            {
              "type": "products",
              "id": "3a06030e-47ad-4845-bc06-337b9bd99914",
              "stock_item_ids": [
                "b5e051a5-48f6-4111-a7e4-3a38db37fdcd",
                "c19dc215-6c06-42a7-8adf-87e93c88f10a",
                "6174e431-32e0-454c-9c29-e6ac7e029109"
              ]
            },
            {
              "type": "products",
              "id": "be7214d1-13e6-40f7-8f24-d87561ff3910",
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
    "id": "b5b2a113-3532-5303-b953-7dfcb7e5678f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "de4acd00-42c4-4d43-859f-021cda53ddf3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "333d9ff6-4f66-4315-a429-17c0c4bc7275"
          },
          {
            "type": "lines",
            "id": "ea3eeb29-a197-42a7-9196-297d55fd333b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5"
          },
          {
            "type": "plannings",
            "id": "fb65e1ad-54e2-4d1b-9aaa-13cb78390881"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "85c1955d-2c4b-4049-b2f6-07446caa708f"
          },
          {
            "type": "stock_item_plannings",
            "id": "36a51704-4d5f-4f6e-ab39-30fc1d082dde"
          },
          {
            "type": "stock_item_plannings",
            "id": "e293319c-8254-47fd-ab09-c92710d998cf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T11:03:35+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
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
        "customer_id": "491d5bc3-af4e-44fd-9b40-b0183d26611e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "90455675-9253-4c38-9153-c4eab3d71368",
        "stop_location_id": "90455675-9253-4c38-9153-c4eab3d71368"
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
      "id": "333d9ff6-4f66-4315-a429-17c0c4bc7275",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
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
        "item_id": "3a06030e-47ad-4845-bc06-337b9bd99914",
        "tax_category_id": "492fb274-25b4-4dd5-9aee-8e69cc6bfaba",
        "planning_id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5",
        "parent_line_id": null,
        "owner_id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
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
      "id": "ea3eeb29-a197-42a7-9196-297d55fd333b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
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
        "item_id": "be7214d1-13e6-40f7-8f24-d87561ff3910",
        "tax_category_id": "492fb274-25b4-4dd5-9aee-8e69cc6bfaba",
        "planning_id": "fb65e1ad-54e2-4d1b-9aaa-13cb78390881",
        "parent_line_id": null,
        "owner_id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
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
      "id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
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
        "item_id": "3a06030e-47ad-4845-bc06-337b9bd99914",
        "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
        "start_location_id": "90455675-9253-4c38-9153-c4eab3d71368",
        "stop_location_id": "90455675-9253-4c38-9153-c4eab3d71368",
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
      "id": "fb65e1ad-54e2-4d1b-9aaa-13cb78390881",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
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
        "item_id": "be7214d1-13e6-40f7-8f24-d87561ff3910",
        "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3",
        "start_location_id": "90455675-9253-4c38-9153-c4eab3d71368",
        "stop_location_id": "90455675-9253-4c38-9153-c4eab3d71368",
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
      "id": "85c1955d-2c4b-4049-b2f6-07446caa708f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b5e051a5-48f6-4111-a7e4-3a38db37fdcd",
        "planning_id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5",
        "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3"
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
      "id": "36a51704-4d5f-4f6e-ab39-30fc1d082dde",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c19dc215-6c06-42a7-8adf-87e93c88f10a",
        "planning_id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5",
        "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3"
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
      "id": "e293319c-8254-47fd-ab09-c92710d998cf",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:37+00:00",
        "updated_at": "2023-02-09T11:03:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6174e431-32e0-454c-9c29-e6ac7e029109",
        "planning_id": "f2f26f88-7f79-4fbd-8281-fd3fb8897ff5",
        "order_id": "de4acd00-42c4-4d43-859f-021cda53ddf3"
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
          "order_id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3",
          "items": [
            {
              "type": "bundles",
              "id": "9dc8e48c-e91d-41d1-bbe6-57a8c86b2e55",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "95c96e60-a380-43f3-bb15-bd3c448f4175",
                  "id": "6a2a83fc-9e41-43d4-a8ea-cba6fbf22779"
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
    "id": "02205450-df94-53ba-8de2-27a512c7e2b3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dee369e7-2988-4019-a684-31225e81ead5"
          },
          {
            "type": "lines",
            "id": "c9cc8d18-8e1d-4b82-b1ce-878c62dc3d59"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "93663a5d-b00d-4302-a70e-6c1830ba1b72"
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
      "id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T11:03:39+00:00",
        "updated_at": "2023-02-09T11:03:40+00:00",
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
        "starts_at": "2023-02-07T11:00:00+00:00",
        "stops_at": "2023-02-11T11:00:00+00:00",
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
        "start_location_id": "86c340c4-067e-4010-883a-71a772e858f1",
        "stop_location_id": "86c340c4-067e-4010-883a-71a772e858f1"
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
      "id": "dee369e7-2988-4019-a684-31225e81ead5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:03:40+00:00",
        "updated_at": "2023-02-09T11:03:40+00:00",
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
        "item_id": "9dc8e48c-e91d-41d1-bbe6-57a8c86b2e55",
        "tax_category_id": null,
        "planning_id": "93663a5d-b00d-4302-a70e-6c1830ba1b72",
        "parent_line_id": null,
        "owner_id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3",
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
      "id": "c9cc8d18-8e1d-4b82-b1ce-878c62dc3d59",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:03:40+00:00",
        "updated_at": "2023-02-09T11:03:40+00:00",
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
        "item_id": "6a2a83fc-9e41-43d4-a8ea-cba6fbf22779",
        "tax_category_id": null,
        "planning_id": "98bc15b2-c00f-4061-9f9c-d460a80c6e5a",
        "parent_line_id": "dee369e7-2988-4019-a684-31225e81ead5",
        "owner_id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3",
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
      "id": "93663a5d-b00d-4302-a70e-6c1830ba1b72",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:03:40+00:00",
        "updated_at": "2023-02-09T11:03:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T11:00:00+00:00",
        "stops_at": "2023-02-11T11:00:00+00:00",
        "reserved_from": "2023-02-07T11:00:00+00:00",
        "reserved_till": "2023-02-11T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9dc8e48c-e91d-41d1-bbe6-57a8c86b2e55",
        "order_id": "25deb0ec-e394-47c0-99c7-6bfafb20c5c3",
        "start_location_id": "86c340c4-067e-4010-883a-71a772e858f1",
        "stop_location_id": "86c340c4-067e-4010-883a-71a772e858f1",
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





