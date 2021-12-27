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
          "order_id": "b25274b0-55ee-468c-9f8b-a11ddcb7f957",
          "items": [
            {
              "type": "products",
              "id": "9d3cf84c-e9c5-47d2-ad04-e582274684b5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0d169d4e-7bca-4571-868e-28e042e09511",
              "stock_item_ids": [
                "1f411b96-ad94-4b25-9716-a28ec8157679",
                "99cb7023-5a0c-4345-9113-ff40b30503fe"
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
            "item_id": "9d3cf84c-e9c5-47d2-ad04-e582274684b5",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "0d169d4e-7bca-4571-868e-28e042e09511",
            "unavailable": [
              "1f411b96-ad94-4b25-9716-a28ec8157679"
            ],
            "available": [
              "99cb7023-5a0c-4345-9113-ff40b30503fe"
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
          "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
          "items": [
            {
              "type": "products",
              "id": "d3e9f868-c4bb-4e5d-b4a8-7f1c88295168",
              "stock_item_ids": [
                "9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8",
                "dc5d2ee7-0267-4d06-a0cc-3b34fce62357",
                "213455d4-e83f-4f92-938f-8199905bb978"
              ]
            },
            {
              "type": "products",
              "id": "1f4515ff-aef0-4af8-9e7c-f1877694d66b",
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
    "id": "a52aa510-c616-5aea-9bbd-80ab4a03b133",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e582483d-ad04-4dcb-b996-d4eb7563ba95"
          },
          {
            "type": "lines",
            "id": "0a4c5708-47a9-459c-818c-fe17a47f7b81"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fede4880-7003-46cc-8933-e05670be232c"
          },
          {
            "type": "plannings",
            "id": "757dd2a1-559c-453a-a31f-99af1c8f0547"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "06219170-eb40-4564-985e-80e2821b9c05"
          },
          {
            "type": "stock_item_plannings",
            "id": "9e7b62f5-7570-4a7b-9294-0031cef0871c"
          },
          {
            "type": "stock_item_plannings",
            "id": "021eefe2-aefe-47c8-8383-e88ddb62a63e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-27T12:58:31+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
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
        "customer_id": "06990389-c200-4d75-b872-19ac433365b5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc",
        "stop_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc"
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
      "id": "e582483d-ad04-4dcb-b996-d4eb7563ba95",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-27T12:58:32+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
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
        "item_id": "1f4515ff-aef0-4af8-9e7c-f1877694d66b",
        "tax_category_id": "bbb7673f-fd51-4596-ba83-01c4bd324873",
        "parent_line_id": null,
        "owner_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
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
      "id": "0a4c5708-47a9-459c-818c-fe17a47f7b81",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-27T12:58:33+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
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
        "item_id": "d3e9f868-c4bb-4e5d-b4a8-7f1c88295168",
        "tax_category_id": "bbb7673f-fd51-4596-ba83-01c4bd324873",
        "parent_line_id": null,
        "owner_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
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
      "id": "fede4880-7003-46cc-8933-e05670be232c",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:32+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
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
        "item_id": "1f4515ff-aef0-4af8-9e7c-f1877694d66b",
        "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
        "start_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc",
        "stop_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc",
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
      "id": "757dd2a1-559c-453a-a31f-99af1c8f0547",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:33+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
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
        "item_id": "d3e9f868-c4bb-4e5d-b4a8-7f1c88295168",
        "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2",
        "start_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc",
        "stop_location_id": "d6db4640-a316-4983-8b8c-f4cb1e3617dc",
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
      "id": "06219170-eb40-4564-985e-80e2821b9c05",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:33+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8",
        "planning_id": "757dd2a1-559c-453a-a31f-99af1c8f0547",
        "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2"
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
      "id": "9e7b62f5-7570-4a7b-9294-0031cef0871c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:33+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dc5d2ee7-0267-4d06-a0cc-3b34fce62357",
        "planning_id": "757dd2a1-559c-453a-a31f-99af1c8f0547",
        "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2"
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
      "id": "021eefe2-aefe-47c8-8383-e88ddb62a63e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:33+00:00",
        "updated_at": "2021-12-27T12:58:33+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "213455d4-e83f-4f92-938f-8199905bb978",
        "planning_id": "757dd2a1-559c-453a-a31f-99af1c8f0547",
        "order_id": "1b2a6019-c3d4-45af-9ecb-a7278299d5c2"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d3e9f868-c4bb-4e5d-b4a8-7f1c88295168&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ebecd06-68d4-4fa0-b1f9-ae8dc4ecb5d8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=dc5d2ee7-0267-4d06-a0cc-3b34fce62357&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=213455d4-e83f-4f92-938f-8199905bb978&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=1f4515ff-aef0-4af8-9e7c-f1877694d66b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1b2a6019-c3d4-45af-9ecb-a7278299d5c2&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505",
          "items": [
            {
              "type": "bundles",
              "id": "b5816771-8b09-4f3b-81a9-528a751f277e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3d167977-15f2-4100-b494-ca6d1b9a9f23",
                  "id": "407050f3-7aaa-4b31-8bc7-daf5ba919c5f"
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
    "id": "abb45438-b8a4-5b05-824c-f3467b4914b0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a245f1a8-7f48-49e4-9c77-8896efb8f0ae"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3b982d49-90fe-44c1-a794-5e9b0aeadd71"
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
      "id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-27T12:58:35+00:00",
        "updated_at": "2021-12-27T12:58:36+00:00",
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
        "starts_at": "2021-12-25T12:45:00+00:00",
        "stops_at": "2021-12-29T12:45:00+00:00",
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
        "start_location_id": "c43655b4-ad2d-4c68-b018-4d21c454ba85",
        "stop_location_id": "c43655b4-ad2d-4c68-b018-4d21c454ba85"
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
      "id": "a245f1a8-7f48-49e4-9c77-8896efb8f0ae",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-27T12:58:36+00:00",
        "updated_at": "2021-12-27T12:58:36+00:00",
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
        "item_id": "b5816771-8b09-4f3b-81a9-528a751f277e",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505",
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
      "id": "3b982d49-90fe-44c1-a794-5e9b0aeadd71",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-27T12:58:36+00:00",
        "updated_at": "2021-12-27T12:58:36+00:00",
        "quantity": 1,
        "starts_at": "2021-12-25T12:45:00+00:00",
        "stops_at": "2021-12-29T12:45:00+00:00",
        "reserved_from": "2021-12-25T12:45:00+00:00",
        "reserved_till": "2021-12-29T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b5816771-8b09-4f3b-81a9-528a751f277e",
        "order_id": "e014b15b-b3ac-4ff9-a9b3-45d651c2c505",
        "start_location_id": "c43655b4-ad2d-4c68-b018-4d21c454ba85",
        "stop_location_id": "c43655b4-ad2d-4c68-b018-4d21c454ba85",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&data%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&data%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&data%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&data%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b5816771-8b09-4f3b-81a9-528a751f277e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=3d167977-15f2-4100-b494-ca6d1b9a9f23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=407050f3-7aaa-4b31-8bc7-daf5ba919c5f&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=e014b15b-b3ac-4ff9-a9b3-45d651c2c505&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





