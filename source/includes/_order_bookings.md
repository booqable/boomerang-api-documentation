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
          "order_id": "289868f6-fda0-44cd-9cc7-719b19ee7460",
          "items": [
            {
              "type": "products",
              "id": "16d4acfb-8bd1-46db-8134-956794974dc6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1612aa05-5fc6-4b41-bd59-f7b737ddbb2e",
              "stock_item_ids": [
                "89837370-3170-487d-86a9-ed085360ea0e",
                "bc831d6d-754f-4b6c-93d7-b35ea5f22745"
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
            "item_id": "16d4acfb-8bd1-46db-8134-956794974dc6",
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
          "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902",
          "items": [
            {
              "type": "products",
              "id": "c70c6e7c-29e7-4367-9e9d-cbeb7ce9f8b5",
              "stock_item_ids": [
                "8808f832-e790-4951-9e06-d2e79245b47e",
                "f2c98e58-31fb-480b-808d-55f1a160bdef",
                "6aed4a2e-515c-4013-8e26-432dfcbd13cf"
              ]
            },
            {
              "type": "products",
              "id": "a361f9b5-c248-4969-84b1-45d0ae8c9731",
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
    "id": "abf49a6d-36a6-567f-99db-adca5379887d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bfbe83e5-0636-4073-99f6-a5550c843902"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c62c3888-251b-4629-af4b-305222d7fc02"
          },
          {
            "type": "lines",
            "id": "a43d334d-dda7-4aab-96a4-fbc9eeb8b425"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "218b0ebe-486c-461c-8a83-345eb1e04712"
          },
          {
            "type": "plannings",
            "id": "8c59cc07-7dc7-4144-863a-610e88a145e7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "65816f97-8a4c-42d0-8cf5-481d6ecd07f4"
          },
          {
            "type": "stock_item_plannings",
            "id": "0bb7496d-f212-4096-80ea-dda12cbf024a"
          },
          {
            "type": "stock_item_plannings",
            "id": "cee1e3c2-6890-437a-b2f2-aeabcdf4b8c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bfbe83e5-0636-4073-99f6-a5550c843902",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T13:01:40+00:00",
        "updated_at": "2023-02-08T13:01:42+00:00",
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
        "customer_id": "f54f60b9-9016-44d5-9846-62b5a5a10f2f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c",
        "stop_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c"
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
      "id": "c62c3888-251b-4629-af4b-305222d7fc02",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:41+00:00",
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
        "item_id": "c70c6e7c-29e7-4367-9e9d-cbeb7ce9f8b5",
        "tax_category_id": "32886abc-1571-4d51-a8f6-2fb77dfc3cc8",
        "planning_id": "218b0ebe-486c-461c-8a83-345eb1e04712",
        "parent_line_id": null,
        "owner_id": "bfbe83e5-0636-4073-99f6-a5550c843902",
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
      "id": "a43d334d-dda7-4aab-96a4-fbc9eeb8b425",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:41+00:00",
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
        "item_id": "a361f9b5-c248-4969-84b1-45d0ae8c9731",
        "tax_category_id": "32886abc-1571-4d51-a8f6-2fb77dfc3cc8",
        "planning_id": "8c59cc07-7dc7-4144-863a-610e88a145e7",
        "parent_line_id": null,
        "owner_id": "bfbe83e5-0636-4073-99f6-a5550c843902",
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
      "id": "218b0ebe-486c-461c-8a83-345eb1e04712",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:42+00:00",
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
        "item_id": "c70c6e7c-29e7-4367-9e9d-cbeb7ce9f8b5",
        "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902",
        "start_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c",
        "stop_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c",
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
      "id": "8c59cc07-7dc7-4144-863a-610e88a145e7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:42+00:00",
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
        "item_id": "a361f9b5-c248-4969-84b1-45d0ae8c9731",
        "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902",
        "start_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c",
        "stop_location_id": "127b9e50-e51a-4245-8353-29b1b9553c5c",
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
      "id": "65816f97-8a4c-42d0-8cf5-481d6ecd07f4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8808f832-e790-4951-9e06-d2e79245b47e",
        "planning_id": "218b0ebe-486c-461c-8a83-345eb1e04712",
        "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902"
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
      "id": "0bb7496d-f212-4096-80ea-dda12cbf024a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f2c98e58-31fb-480b-808d-55f1a160bdef",
        "planning_id": "218b0ebe-486c-461c-8a83-345eb1e04712",
        "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902"
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
      "id": "cee1e3c2-6890-437a-b2f2-aeabcdf4b8c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:41+00:00",
        "updated_at": "2023-02-08T13:01:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6aed4a2e-515c-4013-8e26-432dfcbd13cf",
        "planning_id": "218b0ebe-486c-461c-8a83-345eb1e04712",
        "order_id": "bfbe83e5-0636-4073-99f6-a5550c843902"
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
          "order_id": "ac4ff842-19c0-453a-b383-1ff12a18e264",
          "items": [
            {
              "type": "bundles",
              "id": "12a56e63-4053-46e1-bb43-27eaffe9b76b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2cf07d63-b362-438a-836b-b7d0ac30b495",
                  "id": "d95077bb-8f1d-4841-adfc-3e3b0f6e40a4"
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
    "id": "609b09cb-222a-597c-8113-e16fedd622c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ac4ff842-19c0-453a-b383-1ff12a18e264"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ac4ff842-19c0-453a-b383-1ff12a18e264"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "933861e9-cd20-484b-aacd-f79a4d634b7d"
          },
          {
            "type": "lines",
            "id": "4fd499d4-fe7c-4441-8f45-827e64e269c0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2a2518b8-1424-42d3-a210-e9339e3f7b92"
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
      "id": "ac4ff842-19c0-453a-b383-1ff12a18e264",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T13:01:43+00:00",
        "updated_at": "2023-02-08T13:01:44+00:00",
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
        "starts_at": "2023-02-06T13:00:00+00:00",
        "stops_at": "2023-02-10T13:00:00+00:00",
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
        "start_location_id": "225d606d-e1f0-4dc0-b75a-eb4083204daf",
        "stop_location_id": "225d606d-e1f0-4dc0-b75a-eb4083204daf"
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
      "id": "933861e9-cd20-484b-aacd-f79a4d634b7d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:01:44+00:00",
        "updated_at": "2023-02-08T13:01:44+00:00",
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
        "item_id": "12a56e63-4053-46e1-bb43-27eaffe9b76b",
        "tax_category_id": null,
        "planning_id": "2a2518b8-1424-42d3-a210-e9339e3f7b92",
        "parent_line_id": null,
        "owner_id": "ac4ff842-19c0-453a-b383-1ff12a18e264",
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
      "id": "4fd499d4-fe7c-4441-8f45-827e64e269c0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:01:44+00:00",
        "updated_at": "2023-02-08T13:01:44+00:00",
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
        "item_id": "d95077bb-8f1d-4841-adfc-3e3b0f6e40a4",
        "tax_category_id": null,
        "planning_id": "d9eac80c-9b0c-484a-bc87-c5009d42026f",
        "parent_line_id": "933861e9-cd20-484b-aacd-f79a4d634b7d",
        "owner_id": "ac4ff842-19c0-453a-b383-1ff12a18e264",
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
      "id": "2a2518b8-1424-42d3-a210-e9339e3f7b92",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:01:44+00:00",
        "updated_at": "2023-02-08T13:01:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T13:00:00+00:00",
        "stops_at": "2023-02-10T13:00:00+00:00",
        "reserved_from": "2023-02-06T13:00:00+00:00",
        "reserved_till": "2023-02-10T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "12a56e63-4053-46e1-bb43-27eaffe9b76b",
        "order_id": "ac4ff842-19c0-453a-b383-1ff12a18e264",
        "start_location_id": "225d606d-e1f0-4dc0-b75a-eb4083204daf",
        "stop_location_id": "225d606d-e1f0-4dc0-b75a-eb4083204daf",
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





