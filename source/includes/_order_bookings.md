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
          "order_id": "417208d5-a3c6-46c4-8043-2b852b73e10f",
          "items": [
            {
              "type": "products",
              "id": "12aedf91-7299-4a98-a743-4a4d976987f9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c094bfd5-ca44-4d07-b41d-42af6cb19663",
              "stock_item_ids": [
                "07261c9d-eb2e-4013-ad62-9f506c0753f8",
                "b7ca53d8-cc35-491f-9bac-fcea0cfc957e"
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
            "item_id": "12aedf91-7299-4a98-a743-4a4d976987f9",
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
          "order_id": "a922a82e-9d84-4666-9c25-71528dec7625",
          "items": [
            {
              "type": "products",
              "id": "9e928c52-eb31-4822-9efd-241daca6e7af",
              "stock_item_ids": [
                "712dccfe-e707-4765-8856-20bfa4dace89",
                "c3e6327c-47f1-4b2f-bfea-bbbf9266e83e",
                "df6699d6-8c93-4fe3-badc-8557512bd99a"
              ]
            },
            {
              "type": "products",
              "id": "558ff85b-2da8-4874-a04b-ad51bfc17b4b",
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
    "id": "7373e4a6-c147-5dd9-a16f-83749101c591",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a922a82e-9d84-4666-9c25-71528dec7625"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a922a82e-9d84-4666-9c25-71528dec7625"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2a0f6664-2d8b-440b-867f-823637497549"
          },
          {
            "type": "lines",
            "id": "3f82d62f-93fd-4a8b-a11a-fcb7a7a258c9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f7387171-c400-4f18-a89c-8bb52032982c"
          },
          {
            "type": "plannings",
            "id": "e285f91a-2263-4a13-859c-113efa4a744d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "30053879-5a23-4497-8c7c-7aeaa1eebade"
          },
          {
            "type": "stock_item_plannings",
            "id": "5c15334f-8619-4070-9807-631fc787326c"
          },
          {
            "type": "stock_item_plannings",
            "id": "840d265a-9a6a-4ad1-99bd-13336152752a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a922a82e-9d84-4666-9c25-71528dec7625",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T10:56:09+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
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
        "customer_id": "0a0cf549-97ed-45f6-b7df-b92467cfb4b8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199",
        "stop_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199"
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
      "id": "2a0f6664-2d8b-440b-867f-823637497549",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:56:10+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
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
        "item_id": "558ff85b-2da8-4874-a04b-ad51bfc17b4b",
        "tax_category_id": "e4637e40-cf32-4184-bee4-c806f174f95d",
        "planning_id": "f7387171-c400-4f18-a89c-8bb52032982c",
        "parent_line_id": null,
        "owner_id": "a922a82e-9d84-4666-9c25-71528dec7625",
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
      "id": "3f82d62f-93fd-4a8b-a11a-fcb7a7a258c9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:56:11+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
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
        "item_id": "9e928c52-eb31-4822-9efd-241daca6e7af",
        "tax_category_id": "e4637e40-cf32-4184-bee4-c806f174f95d",
        "planning_id": "e285f91a-2263-4a13-859c-113efa4a744d",
        "parent_line_id": null,
        "owner_id": "a922a82e-9d84-4666-9c25-71528dec7625",
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
      "id": "f7387171-c400-4f18-a89c-8bb52032982c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:10+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
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
        "item_id": "558ff85b-2da8-4874-a04b-ad51bfc17b4b",
        "order_id": "a922a82e-9d84-4666-9c25-71528dec7625",
        "start_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199",
        "stop_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199",
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
      "id": "e285f91a-2263-4a13-859c-113efa4a744d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:11+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
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
        "item_id": "9e928c52-eb31-4822-9efd-241daca6e7af",
        "order_id": "a922a82e-9d84-4666-9c25-71528dec7625",
        "start_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199",
        "stop_location_id": "d43b1756-4824-4dc5-b01a-c84b47db0199",
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
      "id": "30053879-5a23-4497-8c7c-7aeaa1eebade",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:11+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "712dccfe-e707-4765-8856-20bfa4dace89",
        "planning_id": "e285f91a-2263-4a13-859c-113efa4a744d",
        "order_id": "a922a82e-9d84-4666-9c25-71528dec7625"
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
      "id": "5c15334f-8619-4070-9807-631fc787326c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:11+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c3e6327c-47f1-4b2f-bfea-bbbf9266e83e",
        "planning_id": "e285f91a-2263-4a13-859c-113efa4a744d",
        "order_id": "a922a82e-9d84-4666-9c25-71528dec7625"
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
      "id": "840d265a-9a6a-4ad1-99bd-13336152752a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:11+00:00",
        "updated_at": "2022-01-12T10:56:11+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "df6699d6-8c93-4fe3-badc-8557512bd99a",
        "planning_id": "e285f91a-2263-4a13-859c-113efa4a744d",
        "order_id": "a922a82e-9d84-4666-9c25-71528dec7625"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9e928c52-eb31-4822-9efd-241daca6e7af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=712dccfe-e707-4765-8856-20bfa4dace89&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c3e6327c-47f1-4b2f-bfea-bbbf9266e83e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=df6699d6-8c93-4fe3-badc-8557512bd99a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=558ff85b-2da8-4874-a04b-ad51bfc17b4b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=a922a82e-9d84-4666-9c25-71528dec7625&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "e9617359-f43d-499f-bf3b-e53a5330e0b3",
          "items": [
            {
              "type": "bundles",
              "id": "52a1b5e2-6321-4124-90e3-16a129ce079f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea",
                  "id": "00598070-9914-47cf-8de5-82427c07d894"
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
    "id": "54b577cb-1d0e-5e01-a37b-cb095fd1c84c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e9617359-f43d-499f-bf3b-e53a5330e0b3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e9617359-f43d-499f-bf3b-e53a5330e0b3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b39e4001-74a5-4d2e-aeaf-506d419dcf34"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1fd88744-6edb-4379-95a9-1a9fdb753d5f"
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
      "id": "e9617359-f43d-499f-bf3b-e53a5330e0b3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T10:56:13+00:00",
        "updated_at": "2022-01-12T10:56:14+00:00",
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
        "starts_at": "2022-01-10T10:45:00+00:00",
        "stops_at": "2022-01-14T10:45:00+00:00",
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
        "start_location_id": "85026f48-afe0-433c-8f38-c05488b6efa0",
        "stop_location_id": "85026f48-afe0-433c-8f38-c05488b6efa0"
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
      "id": "b39e4001-74a5-4d2e-aeaf-506d419dcf34",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:56:14+00:00",
        "updated_at": "2022-01-12T10:56:14+00:00",
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
        "item_id": "52a1b5e2-6321-4124-90e3-16a129ce079f",
        "tax_category_id": null,
        "planning_id": "1fd88744-6edb-4379-95a9-1a9fdb753d5f",
        "parent_line_id": null,
        "owner_id": "e9617359-f43d-499f-bf3b-e53a5330e0b3",
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
      "id": "1fd88744-6edb-4379-95a9-1a9fdb753d5f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:56:14+00:00",
        "updated_at": "2022-01-12T10:56:14+00:00",
        "quantity": 1,
        "starts_at": "2022-01-10T10:45:00+00:00",
        "stops_at": "2022-01-14T10:45:00+00:00",
        "reserved_from": "2022-01-10T10:45:00+00:00",
        "reserved_till": "2022-01-14T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "52a1b5e2-6321-4124-90e3-16a129ce079f",
        "order_id": "e9617359-f43d-499f-bf3b-e53a5330e0b3",
        "start_location_id": "85026f48-afe0-433c-8f38-c05488b6efa0",
        "stop_location_id": "85026f48-afe0-433c-8f38-c05488b6efa0",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&data%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&data%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&data%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&data%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=52a1b5e2-6321-4124-90e3-16a129ce079f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c8cdb1a8-3a44-423f-94a8-ce31bf89b4ea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=00598070-9914-47cf-8de5-82427c07d894&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e9617359-f43d-499f-bf3b-e53a5330e0b3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





