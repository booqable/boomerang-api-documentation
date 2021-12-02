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
          "order_id": "74af12d7-5ead-4221-9a35-dec9a58b1d70",
          "items": [
            {
              "type": "products",
              "id": "f36a712b-8401-46d7-91af-703196bf4b5d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8784d67f-6a42-4dae-a916-a33825487dae",
              "stock_item_ids": [
                "64ed1825-96ce-4d2c-ba02-d9a25355cec6",
                "a9ceba4a-96a2-44f0-8ea8-8634d4b48fbc"
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
            "item_id": "f36a712b-8401-46d7-91af-703196bf4b5d",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "8784d67f-6a42-4dae-a916-a33825487dae",
            "unavailable": [
              "64ed1825-96ce-4d2c-ba02-d9a25355cec6"
            ],
            "available": [
              "a9ceba4a-96a2-44f0-8ea8-8634d4b48fbc"
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
          "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
          "items": [
            {
              "type": "products",
              "id": "92e2fa1f-5f5e-40d5-80e2-3add7bc77706",
              "stock_item_ids": [
                "2f93fe66-2441-4cc9-bf47-7ce3580ae9ed",
                "40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3",
                "94533109-b402-4211-be1d-b3fd79b036e2"
              ]
            },
            {
              "type": "products",
              "id": "ff367d59-90e1-4d7f-8f60-aecc4e56ecc9",
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
    "id": "636c160a-04e7-59c2-8bb6-d709c7dd0914",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1a40bfc1-ff3a-471a-958e-ffed2d3838ac"
          },
          {
            "type": "lines",
            "id": "7cb51194-3efe-430f-9e60-8bdae80d784b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "225472ec-d2bc-4245-90e4-acaf5779fa96"
          },
          {
            "type": "plannings",
            "id": "b2a5bfbd-5eb6-4293-8c3f-bbd00ae93653"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "35218e4c-2c77-4885-a60f-a9a884b26691"
          },
          {
            "type": "stock_item_plannings",
            "id": "7b6f1e3a-9979-4284-bc61-6a5787e4a8d3"
          },
          {
            "type": "stock_item_plannings",
            "id": "3167d4ea-2ed7-4ce7-b908-ac6280ed2538"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T23:49:34+00:00",
        "updated_at": "2021-12-02T23:49:36+00:00",
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
        "customer_id": "048d8bda-0486-408a-9936-eed8e403806c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560",
        "stop_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560"
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
      "id": "1a40bfc1-ff3a-471a-958e-ffed2d3838ac",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T23:49:34+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
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
        "item_id": "ff367d59-90e1-4d7f-8f60-aecc4e56ecc9",
        "tax_category_id": "8f6da497-3bd4-4217-b12b-4ae18e0c4529",
        "parent_line_id": null,
        "owner_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
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
      "id": "7cb51194-3efe-430f-9e60-8bdae80d784b",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T23:49:35+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
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
        "item_id": "92e2fa1f-5f5e-40d5-80e2-3add7bc77706",
        "tax_category_id": "8f6da497-3bd4-4217-b12b-4ae18e0c4529",
        "parent_line_id": null,
        "owner_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
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
      "id": "225472ec-d2bc-4245-90e4-acaf5779fa96",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:35+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
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
        "item_id": "92e2fa1f-5f5e-40d5-80e2-3add7bc77706",
        "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
        "start_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560",
        "stop_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560",
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
      "id": "b2a5bfbd-5eb6-4293-8c3f-bbd00ae93653",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:34+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
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
        "item_id": "ff367d59-90e1-4d7f-8f60-aecc4e56ecc9",
        "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08",
        "start_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560",
        "stop_location_id": "1efa985f-b37b-45df-8fb5-652c4f515560",
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
      "id": "35218e4c-2c77-4885-a60f-a9a884b26691",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:35+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2f93fe66-2441-4cc9-bf47-7ce3580ae9ed",
        "planning_id": "225472ec-d2bc-4245-90e4-acaf5779fa96",
        "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08"
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
      "id": "7b6f1e3a-9979-4284-bc61-6a5787e4a8d3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:35+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3",
        "planning_id": "225472ec-d2bc-4245-90e4-acaf5779fa96",
        "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08"
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
      "id": "3167d4ea-2ed7-4ce7-b908-ac6280ed2538",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:35+00:00",
        "updated_at": "2021-12-02T23:49:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "94533109-b402-4211-be1d-b3fd79b036e2",
        "planning_id": "225472ec-d2bc-4245-90e4-acaf5779fa96",
        "order_id": "c9f1aff1-51a0-436e-9eaa-906bc0cb9d08"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=92e2fa1f-5f5e-40d5-80e2-3add7bc77706&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2f93fe66-2441-4cc9-bf47-7ce3580ae9ed&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=40a9caa7-c1b8-40c8-8d5a-29d56a1f5ca3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=94533109-b402-4211-be1d-b3fd79b036e2&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ff367d59-90e1-4d7f-8f60-aecc4e56ecc9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c9f1aff1-51a0-436e-9eaa-906bc0cb9d08&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb",
          "items": [
            {
              "type": "bundles",
              "id": "0c6207eb-23fd-46d1-b1d0-e77832e6a95b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3822372d-4d18-48c7-a938-994deef27647",
                  "id": "6f24f2dc-99e2-49ea-a24d-310dea09ea7d"
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
    "id": "9c25dd21-9954-575a-ae4a-11a99c847ca9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "36469b3a-3082-469a-ba6b-ce828007ecc9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d49c7cba-c015-4b81-b557-7159d6394c7a"
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
      "id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T23:49:37+00:00",
        "updated_at": "2021-12-02T23:49:38+00:00",
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
        "starts_at": "2021-11-30T23:45:00+00:00",
        "stops_at": "2021-12-04T23:45:00+00:00",
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
        "start_location_id": "0c32bee9-15c6-4644-aa20-35a34ffa84f2",
        "stop_location_id": "0c32bee9-15c6-4644-aa20-35a34ffa84f2"
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
      "id": "36469b3a-3082-469a-ba6b-ce828007ecc9",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T23:49:38+00:00",
        "updated_at": "2021-12-02T23:49:38+00:00",
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
        "item_id": "0c6207eb-23fd-46d1-b1d0-e77832e6a95b",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb",
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
      "id": "d49c7cba-c015-4b81-b557-7159d6394c7a",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T23:49:38+00:00",
        "updated_at": "2021-12-02T23:49:38+00:00",
        "quantity": 1,
        "starts_at": "2021-11-30T23:45:00+00:00",
        "stops_at": "2021-12-04T23:45:00+00:00",
        "reserved_from": "2021-11-30T23:45:00+00:00",
        "reserved_till": "2021-12-04T23:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0c6207eb-23fd-46d1-b1d0-e77832e6a95b",
        "order_id": "3ba9e930-5fe3-4b5b-a74e-b90a302911eb",
        "start_location_id": "0c32bee9-15c6-4644-aa20-35a34ffa84f2",
        "stop_location_id": "0c32bee9-15c6-4644-aa20-35a34ffa84f2",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&data%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&data%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&data%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&data%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0c6207eb-23fd-46d1-b1d0-e77832e6a95b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3822372d-4d18-48c7-a938-994deef27647&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=6f24f2dc-99e2-49ea-a24d-310dea09ea7d&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=3ba9e930-5fe3-4b5b-a74e-b90a302911eb&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





