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
          "order_id": "fd25ce6f-d156-4f07-b2ff-714491fd6123",
          "items": [
            {
              "type": "products",
              "id": "bb9b7567-eb50-42df-ab4b-0c067b60acd3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fc4dbb28-e827-428c-8050-218d7eb65107",
              "stock_item_ids": [
                "cd9fea98-b5bc-4807-8bdb-96ab8e11ef38",
                "e945fcd2-4a57-4b17-872e-89bacd3af0fc"
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
            "item_id": "bb9b7567-eb50-42df-ab4b-0c067b60acd3",
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
          "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
          "items": [
            {
              "type": "products",
              "id": "67802203-140d-4adb-ba28-bc9b3f5b806f",
              "stock_item_ids": [
                "73d0a512-4e7b-4697-b933-3dff04ff088a",
                "b62f9ed0-ae78-4bff-a8d3-cc7d1d03bf12",
                "43b0ebb9-c48a-4304-a441-4a797227ef50"
              ]
            },
            {
              "type": "products",
              "id": "b152bfb0-06ec-48ed-9588-a592893e9a63",
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
    "id": "d05f91c8-fc7a-52d9-a15c-f176d757470f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "95bae40d-f9c3-42ea-8eac-99da9a8ac807"
          },
          {
            "type": "lines",
            "id": "f24d3fb4-34f7-44bf-aa3f-123192131620"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "10b467b0-637e-4595-9cb4-8d9e2736350e"
          },
          {
            "type": "plannings",
            "id": "9fcb7ef4-f3bf-4e7e-9bc0-9a47f0bdb18d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c9e16551-8809-4581-8bea-bc2d9bcb751f"
          },
          {
            "type": "stock_item_plannings",
            "id": "bac000b5-ef20-45e4-b264-c5c2924c6e6d"
          },
          {
            "type": "stock_item_plannings",
            "id": "37db6a1f-2205-4b9a-99b8-b80f9f31249d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T14:15:57+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
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
        "customer_id": "8b8a0d27-50c0-4391-a474-1132066f4927",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3",
        "stop_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3"
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
      "id": "95bae40d-f9c3-42ea-8eac-99da9a8ac807",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
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
        "item_id": "67802203-140d-4adb-ba28-bc9b3f5b806f",
        "tax_category_id": "61a4073c-604e-449e-b342-a88eb4456702",
        "planning_id": "10b467b0-637e-4595-9cb4-8d9e2736350e",
        "parent_line_id": null,
        "owner_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
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
      "id": "f24d3fb4-34f7-44bf-aa3f-123192131620",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
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
        "item_id": "b152bfb0-06ec-48ed-9588-a592893e9a63",
        "tax_category_id": "61a4073c-604e-449e-b342-a88eb4456702",
        "planning_id": "9fcb7ef4-f3bf-4e7e-9bc0-9a47f0bdb18d",
        "parent_line_id": null,
        "owner_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
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
      "id": "10b467b0-637e-4595-9cb4-8d9e2736350e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
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
        "item_id": "67802203-140d-4adb-ba28-bc9b3f5b806f",
        "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
        "start_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3",
        "stop_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3",
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
      "id": "9fcb7ef4-f3bf-4e7e-9bc0-9a47f0bdb18d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
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
        "item_id": "b152bfb0-06ec-48ed-9588-a592893e9a63",
        "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3",
        "start_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3",
        "stop_location_id": "945bd233-4bb0-4de7-a035-acac44abd3e3",
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
      "id": "c9e16551-8809-4581-8bea-bc2d9bcb751f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "73d0a512-4e7b-4697-b933-3dff04ff088a",
        "planning_id": "10b467b0-637e-4595-9cb4-8d9e2736350e",
        "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3"
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
      "id": "bac000b5-ef20-45e4-b264-c5c2924c6e6d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b62f9ed0-ae78-4bff-a8d3-cc7d1d03bf12",
        "planning_id": "10b467b0-637e-4595-9cb4-8d9e2736350e",
        "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3"
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
      "id": "37db6a1f-2205-4b9a-99b8-b80f9f31249d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:15:58+00:00",
        "updated_at": "2023-02-02T14:15:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "43b0ebb9-c48a-4304-a441-4a797227ef50",
        "planning_id": "10b467b0-637e-4595-9cb4-8d9e2736350e",
        "order_id": "9f0bcfae-cbc7-4628-8bc8-e97b297a67f3"
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
          "order_id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53",
          "items": [
            {
              "type": "bundles",
              "id": "c8642f5c-f9c3-4385-9e9c-26b121579de8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "319dccb7-b929-4017-862e-c70ad1215e4e",
                  "id": "22375813-234a-4226-969d-80dbb34c0702"
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
    "id": "abcff1b8-c9cd-5361-b31e-3918ad0f82b7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3954c062-2643-433d-a49d-2c42d77bee78"
          },
          {
            "type": "lines",
            "id": "bcdc3b69-863e-4769-8d68-fa7ae5549ccb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dfee41de-d500-4f24-b3c7-452239ffabcd"
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
      "id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T14:16:00+00:00",
        "updated_at": "2023-02-02T14:16:01+00:00",
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
        "starts_at": "2023-01-31T14:15:00+00:00",
        "stops_at": "2023-02-04T14:15:00+00:00",
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
        "start_location_id": "a4cc9745-cd09-4b49-8943-c827d1ababcc",
        "stop_location_id": "a4cc9745-cd09-4b49-8943-c827d1ababcc"
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
      "id": "3954c062-2643-433d-a49d-2c42d77bee78",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:16:01+00:00",
        "updated_at": "2023-02-02T14:16:01+00:00",
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
        "item_id": "c8642f5c-f9c3-4385-9e9c-26b121579de8",
        "tax_category_id": null,
        "planning_id": "dfee41de-d500-4f24-b3c7-452239ffabcd",
        "parent_line_id": null,
        "owner_id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53",
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
      "id": "bcdc3b69-863e-4769-8d68-fa7ae5549ccb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:16:01+00:00",
        "updated_at": "2023-02-02T14:16:01+00:00",
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
        "item_id": "22375813-234a-4226-969d-80dbb34c0702",
        "tax_category_id": null,
        "planning_id": "eb42f7c5-78fa-4b4f-bb99-355fc7f9987b",
        "parent_line_id": "3954c062-2643-433d-a49d-2c42d77bee78",
        "owner_id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53",
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
      "id": "dfee41de-d500-4f24-b3c7-452239ffabcd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:16:01+00:00",
        "updated_at": "2023-02-02T14:16:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T14:15:00+00:00",
        "stops_at": "2023-02-04T14:15:00+00:00",
        "reserved_from": "2023-01-31T14:15:00+00:00",
        "reserved_till": "2023-02-04T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c8642f5c-f9c3-4385-9e9c-26b121579de8",
        "order_id": "283b8b8f-131c-4a8e-ad98-e9dd1ad4bb53",
        "start_location_id": "a4cc9745-cd09-4b49-8943-c827d1ababcc",
        "stop_location_id": "a4cc9745-cd09-4b49-8943-c827d1ababcc",
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





