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
          "order_id": "cf8905c0-5937-495b-9e6d-785e20071819",
          "items": [
            {
              "type": "products",
              "id": "3710afe8-6900-4076-bd36-cf32a7ff4ba0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "44df405e-e475-4492-a80e-d638a2d5d1af",
              "stock_item_ids": [
                "06b09d0a-72ad-40a4-9bac-ef25b00bdcda",
                "5f1cd486-6773-4b5d-84e2-a27e1d0e9b63"
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
            "item_id": "3710afe8-6900-4076-bd36-cf32a7ff4ba0",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "44df405e-e475-4492-a80e-d638a2d5d1af",
            "unavailable": [
              "06b09d0a-72ad-40a4-9bac-ef25b00bdcda"
            ],
            "available": [
              "5f1cd486-6773-4b5d-84e2-a27e1d0e9b63"
            ]
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
          "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
          "items": [
            {
              "type": "products",
              "id": "4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422",
              "stock_item_ids": [
                "380f20d4-8426-4a94-a4b2-e93605987bfc",
                "d5e72f78-d05c-435c-9721-57a6467bba8f",
                "ebe799e0-c69b-4235-84ac-de98c3c92e77"
              ]
            },
            {
              "type": "products",
              "id": "cd262035-22a4-45f8-9947-8f277a7b157a",
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
    "id": "251dfd09-6e21-5b18-ae80-eefa8fb7bcd4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "12f9fe54-f99b-4f7e-b689-e36d43bde3cf"
          },
          {
            "type": "lines",
            "id": "bff2c73d-39d0-4784-8e7d-eefaa7f121de"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7ef6c3c3-71bb-4f1a-807e-963dc4d9c266"
          },
          {
            "type": "plannings",
            "id": "d1150e6b-6b29-4e86-b6cf-f5aee145d9b3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3cc7ac9e-b8de-40c9-ad21-82b14487c184"
          },
          {
            "type": "stock_item_plannings",
            "id": "674943dc-334f-40f2-bbf6-7e4b56b1bf63"
          },
          {
            "type": "stock_item_plannings",
            "id": "eae45c56-564d-432e-82f6-5f95b4357601"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-13T08:14:43+00:00",
        "updated_at": "2021-12-13T08:14:45+00:00",
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
        "customer_id": "75cee800-8e0a-46ba-80f4-aa9232f75d0c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b",
        "stop_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b"
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
      "id": "12f9fe54-f99b-4f7e-b689-e36d43bde3cf",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:45+00:00",
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
        "item_id": "cd262035-22a4-45f8-9947-8f277a7b157a",
        "tax_category_id": "898ee68d-dedc-4f20-a190-997a76e523fb",
        "parent_line_id": null,
        "owner_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
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
      "id": "bff2c73d-39d0-4784-8e7d-eefaa7f121de",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:45+00:00",
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
        "item_id": "4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422",
        "tax_category_id": "898ee68d-dedc-4f20-a190-997a76e523fb",
        "parent_line_id": null,
        "owner_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
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
      "id": "7ef6c3c3-71bb-4f1a-807e-963dc4d9c266",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:44+00:00",
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
        "item_id": "4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422",
        "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
        "start_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b",
        "stop_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b",
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
      "id": "d1150e6b-6b29-4e86-b6cf-f5aee145d9b3",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:44+00:00",
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
        "item_id": "cd262035-22a4-45f8-9947-8f277a7b157a",
        "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97",
        "start_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b",
        "stop_location_id": "0558c4bb-5c94-4eeb-b098-33f898cbad9b",
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
      "id": "3cc7ac9e-b8de-40c9-ad21-82b14487c184",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:44+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "380f20d4-8426-4a94-a4b2-e93605987bfc",
        "planning_id": "7ef6c3c3-71bb-4f1a-807e-963dc4d9c266",
        "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97"
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
      "id": "674943dc-334f-40f2-bbf6-7e4b56b1bf63",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:44+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d5e72f78-d05c-435c-9721-57a6467bba8f",
        "planning_id": "7ef6c3c3-71bb-4f1a-807e-963dc4d9c266",
        "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97"
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
      "id": "eae45c56-564d-432e-82f6-5f95b4357601",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:44+00:00",
        "updated_at": "2021-12-13T08:14:44+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ebe799e0-c69b-4235-84ac-de98c3c92e77",
        "planning_id": "7ef6c3c3-71bb-4f1a-807e-963dc4d9c266",
        "order_id": "96bbcd7a-63d0-4c8e-abfc-9502aebd7d97"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4dbeb4e3-1fe6-4fab-98f2-3e4aaeabc422&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=380f20d4-8426-4a94-a4b2-e93605987bfc&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d5e72f78-d05c-435c-9721-57a6467bba8f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=ebe799e0-c69b-4235-84ac-de98c3c92e77&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cd262035-22a4-45f8-9947-8f277a7b157a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=96bbcd7a-63d0-4c8e-abfc-9502aebd7d97&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "a070ab7f-3362-42e0-bc5d-04306d983ae3",
          "items": [
            {
              "type": "bundles",
              "id": "dd63bac3-fe38-48ba-a6e2-1356427f9e20",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "96f6ff5d-1924-4908-929e-4f0da841212c",
                  "id": "a509cbc3-5028-4688-8a96-e5f91956264f"
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
    "id": "ed2b7cb6-11a8-50a7-9998-94c477effc36",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a070ab7f-3362-42e0-bc5d-04306d983ae3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a070ab7f-3362-42e0-bc5d-04306d983ae3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bffe4444-edd5-4208-8bdd-4279296495ec"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "39a151ee-ab32-4ad0-bda1-9d27a54aa877"
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
      "id": "a070ab7f-3362-42e0-bc5d-04306d983ae3",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-13T08:14:47+00:00",
        "updated_at": "2021-12-13T08:14:48+00:00",
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
        "starts_at": "2021-12-11T08:00:00+00:00",
        "stops_at": "2021-12-15T08:00:00+00:00",
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
        "start_location_id": "bd95c2fe-0ba7-4dc2-87fa-66b120529869",
        "stop_location_id": "bd95c2fe-0ba7-4dc2-87fa-66b120529869"
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
      "id": "bffe4444-edd5-4208-8bdd-4279296495ec",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-13T08:14:48+00:00",
        "updated_at": "2021-12-13T08:14:48+00:00",
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
        "item_id": "dd63bac3-fe38-48ba-a6e2-1356427f9e20",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "a070ab7f-3362-42e0-bc5d-04306d983ae3",
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
      "id": "39a151ee-ab32-4ad0-bda1-9d27a54aa877",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-13T08:14:47+00:00",
        "updated_at": "2021-12-13T08:14:47+00:00",
        "quantity": 1,
        "starts_at": "2021-12-11T08:00:00+00:00",
        "stops_at": "2021-12-15T08:00:00+00:00",
        "reserved_from": "2021-12-11T08:00:00+00:00",
        "reserved_till": "2021-12-15T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "dd63bac3-fe38-48ba-a6e2-1356427f9e20",
        "order_id": "a070ab7f-3362-42e0-bc5d-04306d983ae3",
        "start_location_id": "bd95c2fe-0ba7-4dc2-87fa-66b120529869",
        "stop_location_id": "bd95c2fe-0ba7-4dc2-87fa-66b120529869",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&data%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&data%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&data%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&data%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dd63bac3-fe38-48ba-a6e2-1356427f9e20&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=96f6ff5d-1924-4908-929e-4f0da841212c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=a509cbc3-5028-4688-8a96-e5f91956264f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a070ab7f-3362-42e0-bc5d-04306d983ae3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





