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
          "order_id": "b6914f5f-aedd-4cda-aff0-2b1425e7f44f",
          "items": [
            {
              "type": "products",
              "id": "654d3f9c-68e5-4d29-8f3a-339d89c70b6d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "61842d43-ff7d-49fd-83f7-d2e441c51315",
              "stock_item_ids": [
                "0538bf7b-4eeb-4c57-ad30-180340882180",
                "4520a799-e0f0-4bcd-9d35-6328419521d3"
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
            "item_id": "654d3f9c-68e5-4d29-8f3a-339d89c70b6d",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "61842d43-ff7d-49fd-83f7-d2e441c51315",
            "unavailable": [
              "0538bf7b-4eeb-4c57-ad30-180340882180"
            ],
            "available": [
              "4520a799-e0f0-4bcd-9d35-6328419521d3"
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
          "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
          "items": [
            {
              "type": "products",
              "id": "befde4b5-db6b-43c7-9b39-e0094816ecd9",
              "stock_item_ids": [
                "3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754",
                "34ff6f8c-c4f6-42fe-842d-53c67925b27c",
                "862ce346-f939-4516-a6f1-968198f85798"
              ]
            },
            {
              "type": "products",
              "id": "7c0699a6-a834-4383-bc88-ccfb83b06273",
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
    "id": "1f6fc946-b7a9-5720-89fd-8d3bfc67e50c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af76c23a-a87e-4c5a-a988-3657a1d0d801"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "89d58399-3c57-4d2c-b029-69c5659e4b70"
          },
          {
            "type": "lines",
            "id": "602d48f9-6d54-41b9-87d2-c8606e2f63e8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "569eca7a-a06b-41a0-b999-94766e9c91c4"
          },
          {
            "type": "plannings",
            "id": "505343f1-8516-4a03-b066-ff47e2e557e9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0b7a34d1-eda5-4485-86f3-184f8181ebde"
          },
          {
            "type": "stock_item_plannings",
            "id": "b892be59-ccbe-4d1d-87ee-3a42417f74d6"
          },
          {
            "type": "stock_item_plannings",
            "id": "64d2951e-3c71-4baf-afcd-4f294f868d04"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-06T14:33:39+00:00",
        "updated_at": "2022-01-06T14:33:42+00:00",
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
        "customer_id": "1f177cbb-748b-43af-9c20-fec36cd06892",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3",
        "stop_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3"
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
      "id": "89d58399-3c57-4d2c-b029-69c5659e4b70",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-06T14:33:40+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
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
        "item_id": "7c0699a6-a834-4383-bc88-ccfb83b06273",
        "tax_category_id": "bce86365-2fe0-4742-8b29-fcda7973a811",
        "planning_id": "569eca7a-a06b-41a0-b999-94766e9c91c4",
        "parent_line_id": null,
        "owner_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
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
      "id": "602d48f9-6d54-41b9-87d2-c8606e2f63e8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-06T14:33:41+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
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
        "item_id": "befde4b5-db6b-43c7-9b39-e0094816ecd9",
        "tax_category_id": "bce86365-2fe0-4742-8b29-fcda7973a811",
        "planning_id": "505343f1-8516-4a03-b066-ff47e2e557e9",
        "parent_line_id": null,
        "owner_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
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
      "id": "569eca7a-a06b-41a0-b999-94766e9c91c4",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:39+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
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
        "item_id": "7c0699a6-a834-4383-bc88-ccfb83b06273",
        "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
        "start_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3",
        "stop_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3",
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
      "id": "505343f1-8516-4a03-b066-ff47e2e557e9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:41+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
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
        "item_id": "befde4b5-db6b-43c7-9b39-e0094816ecd9",
        "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801",
        "start_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3",
        "stop_location_id": "999e3647-fa5a-45cf-bcc7-a46bedfa46e3",
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
      "id": "0b7a34d1-eda5-4485-86f3-184f8181ebde",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:41+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754",
        "planning_id": "505343f1-8516-4a03-b066-ff47e2e557e9",
        "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801"
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
      "id": "b892be59-ccbe-4d1d-87ee-3a42417f74d6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:41+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "34ff6f8c-c4f6-42fe-842d-53c67925b27c",
        "planning_id": "505343f1-8516-4a03-b066-ff47e2e557e9",
        "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801"
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
      "id": "64d2951e-3c71-4baf-afcd-4f294f868d04",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:41+00:00",
        "updated_at": "2022-01-06T14:33:41+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "862ce346-f939-4516-a6f1-968198f85798",
        "planning_id": "505343f1-8516-4a03-b066-ff47e2e557e9",
        "order_id": "af76c23a-a87e-4c5a-a988-3657a1d0d801"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=befde4b5-db6b-43c7-9b39-e0094816ecd9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=3c3ac4e6-a7fb-4e64-aa3a-f0d692ad2754&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=34ff6f8c-c4f6-42fe-842d-53c67925b27c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=862ce346-f939-4516-a6f1-968198f85798&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7c0699a6-a834-4383-bc88-ccfb83b06273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=af76c23a-a87e-4c5a-a988-3657a1d0d801&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "3f69b02c-5d0e-4d57-a795-cf03222564a1",
          "items": [
            {
              "type": "bundles",
              "id": "1ce8b8c3-dd94-47bd-98a5-47a111160c39",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "54e85f76-a3c7-4ef1-bd44-fcd90343c4e7",
                  "id": "7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58"
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
    "id": "947aa3e3-349f-5341-b7ed-b149e25586fe",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3f69b02c-5d0e-4d57-a795-cf03222564a1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3f69b02c-5d0e-4d57-a795-cf03222564a1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ce90011c-21c5-49ae-9e4e-2a3be85dbb52"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "13137db1-6c4d-4b5f-9f47-d009345f3ec0"
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
      "id": "3f69b02c-5d0e-4d57-a795-cf03222564a1",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-06T14:33:44+00:00",
        "updated_at": "2022-01-06T14:33:46+00:00",
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
        "starts_at": "2022-01-04T14:30:00+00:00",
        "stops_at": "2022-01-08T14:30:00+00:00",
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
        "start_location_id": "62b22daa-b94c-479c-bb68-0bb4d1b2ef1d",
        "stop_location_id": "62b22daa-b94c-479c-bb68-0bb4d1b2ef1d"
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
      "id": "ce90011c-21c5-49ae-9e4e-2a3be85dbb52",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-06T14:33:45+00:00",
        "updated_at": "2022-01-06T14:33:45+00:00",
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
        "item_id": "1ce8b8c3-dd94-47bd-98a5-47a111160c39",
        "tax_category_id": null,
        "planning_id": "13137db1-6c4d-4b5f-9f47-d009345f3ec0",
        "parent_line_id": null,
        "owner_id": "3f69b02c-5d0e-4d57-a795-cf03222564a1",
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
      "id": "13137db1-6c4d-4b5f-9f47-d009345f3ec0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-06T14:33:45+00:00",
        "updated_at": "2022-01-06T14:33:45+00:00",
        "quantity": 1,
        "starts_at": "2022-01-04T14:30:00+00:00",
        "stops_at": "2022-01-08T14:30:00+00:00",
        "reserved_from": "2022-01-04T14:30:00+00:00",
        "reserved_till": "2022-01-08T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1ce8b8c3-dd94-47bd-98a5-47a111160c39",
        "order_id": "3f69b02c-5d0e-4d57-a795-cf03222564a1",
        "start_location_id": "62b22daa-b94c-479c-bb68-0bb4d1b2ef1d",
        "stop_location_id": "62b22daa-b94c-479c-bb68-0bb4d1b2ef1d",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&data%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&data%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&data%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&data%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1ce8b8c3-dd94-47bd-98a5-47a111160c39&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=54e85f76-a3c7-4ef1-bd44-fcd90343c4e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=7afa2bb0-28c9-4f45-9d97-7cd06fbe9f58&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3f69b02c-5d0e-4d57-a795-cf03222564a1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





