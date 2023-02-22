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
          "order_id": "a7157458-1fa0-4016-a56e-44337a8a0506",
          "items": [
            {
              "type": "products",
              "id": "b69a9060-66f4-4e96-994e-2e8eb1951531",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "01d18ea0-6797-4dac-b5e3-e95cc39d2683",
              "stock_item_ids": [
                "3d07c023-5895-4aae-ba36-9bf2290a724e",
                "433a72fa-5d2b-4464-ae62-c8a99e090491"
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
          "stock_item_id 3d07c023-5895-4aae-ba36-9bf2290a724e has already been booked on this order"
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
          "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
          "items": [
            {
              "type": "products",
              "id": "a556715d-aa30-4bd1-a0c1-881a463d8694",
              "stock_item_ids": [
                "70023e7e-2a41-4690-9a2f-7a089d28748e",
                "5622fe07-626e-4c61-9ac9-c5d95776cb9a",
                "4e0dd2c2-1d08-4d07-9157-6e0a211aa5bc"
              ]
            },
            {
              "type": "products",
              "id": "129b4f4d-abef-4290-bd65-9c832df64e1b",
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
    "id": "31f44615-c8f2-55de-a983-3768c47900eb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "903d0343-0537-48e8-b8ab-e4313555e214"
          },
          {
            "type": "lines",
            "id": "4ff8be26-6154-48e5-b1ea-f1f12969b346"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8"
          },
          {
            "type": "plannings",
            "id": "791e844a-c9de-445f-9c93-2526aa192429"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c0cf0b5f-de52-4626-9a15-ef0a0986ed74"
          },
          {
            "type": "stock_item_plannings",
            "id": "648974c0-26fa-44af-973c-caecca2a012e"
          },
          {
            "type": "stock_item_plannings",
            "id": "47c87f04-c314-44c7-9eb0-00dc77e0e155"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T14:14:31+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
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
        "customer_id": "cd7cb844-a5a6-4166-a5ea-a954db0b1444",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c",
        "stop_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c"
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
      "id": "903d0343-0537-48e8-b8ab-e4313555e214",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
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
        "item_id": "a556715d-aa30-4bd1-a0c1-881a463d8694",
        "tax_category_id": "dd864ccb-203c-434e-a23e-499e77d2391d",
        "planning_id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8",
        "parent_line_id": null,
        "owner_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
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
      "id": "4ff8be26-6154-48e5-b1ea-f1f12969b346",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
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
        "item_id": "129b4f4d-abef-4290-bd65-9c832df64e1b",
        "tax_category_id": "dd864ccb-203c-434e-a23e-499e77d2391d",
        "planning_id": "791e844a-c9de-445f-9c93-2526aa192429",
        "parent_line_id": null,
        "owner_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
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
      "id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
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
        "item_id": "a556715d-aa30-4bd1-a0c1-881a463d8694",
        "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
        "start_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c",
        "stop_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c",
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
      "id": "791e844a-c9de-445f-9c93-2526aa192429",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
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
        "item_id": "129b4f4d-abef-4290-bd65-9c832df64e1b",
        "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9",
        "start_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c",
        "stop_location_id": "5004f0dd-9487-4f3c-8381-1b858a78a32c",
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
      "id": "c0cf0b5f-de52-4626-9a15-ef0a0986ed74",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "70023e7e-2a41-4690-9a2f-7a089d28748e",
        "planning_id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8",
        "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9"
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
      "id": "648974c0-26fa-44af-973c-caecca2a012e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5622fe07-626e-4c61-9ac9-c5d95776cb9a",
        "planning_id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8",
        "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9"
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
      "id": "47c87f04-c314-44c7-9eb0-00dc77e0e155",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:33+00:00",
        "updated_at": "2023-02-22T14:14:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4e0dd2c2-1d08-4d07-9157-6e0a211aa5bc",
        "planning_id": "06e6a458-ce8f-405b-ae7f-09fb7168b9c8",
        "order_id": "16994abf-419c-4799-aeb6-6b2f8ce5d6c9"
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
          "order_id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74",
          "items": [
            {
              "type": "bundles",
              "id": "9a5fcf17-c326-48a7-8ba1-01eaa80e848c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "916e8ec0-2aac-488a-b591-4d7288e6aeda",
                  "id": "0932c6ab-1ecd-4901-aca9-d2180cbe403a"
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
    "id": "74b28a44-225b-59cc-bf54-eb57244d3802",
    "type": "order_bookings",
    "attributes": {
      "order_id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e25e8bda-8aa3-43eb-8ac5-f5dec9f46990"
          },
          {
            "type": "lines",
            "id": "0e632676-d44e-4e46-af2c-67cb1650c73c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "55e7a181-0545-4a42-b5b4-0b7076775c42"
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
      "id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T14:14:36+00:00",
        "updated_at": "2023-02-22T14:14:37+00:00",
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
        "starts_at": "2023-02-20T14:00:00+00:00",
        "stops_at": "2023-02-24T14:00:00+00:00",
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
        "start_location_id": "f1c20571-5694-4edb-bd73-ac4fd3bdbd85",
        "stop_location_id": "f1c20571-5694-4edb-bd73-ac4fd3bdbd85"
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
      "id": "e25e8bda-8aa3-43eb-8ac5-f5dec9f46990",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T14:14:36+00:00",
        "updated_at": "2023-02-22T14:14:36+00:00",
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
        "item_id": "9a5fcf17-c326-48a7-8ba1-01eaa80e848c",
        "tax_category_id": null,
        "planning_id": "55e7a181-0545-4a42-b5b4-0b7076775c42",
        "parent_line_id": null,
        "owner_id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74",
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
      "id": "0e632676-d44e-4e46-af2c-67cb1650c73c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T14:14:36+00:00",
        "updated_at": "2023-02-22T14:14:36+00:00",
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
        "item_id": "0932c6ab-1ecd-4901-aca9-d2180cbe403a",
        "tax_category_id": null,
        "planning_id": "ca6c0da9-4e44-42d0-a85e-7d120c7e5a8c",
        "parent_line_id": "e25e8bda-8aa3-43eb-8ac5-f5dec9f46990",
        "owner_id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74",
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
      "id": "55e7a181-0545-4a42-b5b4-0b7076775c42",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T14:14:36+00:00",
        "updated_at": "2023-02-22T14:14:36+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-20T14:00:00+00:00",
        "stops_at": "2023-02-24T14:00:00+00:00",
        "reserved_from": "2023-02-20T14:00:00+00:00",
        "reserved_till": "2023-02-24T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9a5fcf17-c326-48a7-8ba1-01eaa80e848c",
        "order_id": "461e3f05-d9dd-48ff-a86b-d990ccda7c74",
        "start_location_id": "f1c20571-5694-4edb-bd73-ac4fd3bdbd85",
        "stop_location_id": "f1c20571-5694-4edb-bd73-ac4fd3bdbd85",
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





