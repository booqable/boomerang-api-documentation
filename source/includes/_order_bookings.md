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
          "order_id": "7fa1cd5d-9b62-4430-9ace-60fc75e9878c",
          "items": [
            {
              "type": "products",
              "id": "e8a7acab-b0d2-4a34-b6cb-1bc1123eb4f2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3a5675fe-fde5-49cb-bba7-b8223f73525f",
              "stock_item_ids": [
                "f552aca9-cf52-4d97-8715-7f227fa319a6",
                "86d17cdd-baf2-4bbf-ad1d-c36eac460f23"
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
            "item_id": "e8a7acab-b0d2-4a34-b6cb-1bc1123eb4f2",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "3a5675fe-fde5-49cb-bba7-b8223f73525f",
            "unavailable": [
              "f552aca9-cf52-4d97-8715-7f227fa319a6"
            ],
            "available": [
              "86d17cdd-baf2-4bbf-ad1d-c36eac460f23"
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
          "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
          "items": [
            {
              "type": "products",
              "id": "cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea",
              "stock_item_ids": [
                "a3b78af5-e032-4cbc-8129-607c42a58238",
                "470f9329-e100-4a8c-8214-b9c3f70e32e5",
                "c1dc95d1-8aab-455b-aab9-d66ed1ef9621"
              ]
            },
            {
              "type": "products",
              "id": "77d27dc7-e72a-47d7-a80a-820a459821d3",
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
    "id": "e8d00a32-1be8-50eb-a080-9138bf7860a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f0254339-c02c-404b-9ac5-49e93c51f97f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e5ec4b0a-a49c-4d82-8fbe-0cf0ec259635"
          },
          {
            "type": "lines",
            "id": "e954556c-648a-4f0b-b5c2-eb06f2f87bfb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f87368b0-349a-4a84-8219-371b94cbb90a"
          },
          {
            "type": "plannings",
            "id": "26fe83c1-0414-444b-bdfe-686f555361ad"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c57e6b4e-f616-4ed4-8efc-2d8d1ae6b212"
          },
          {
            "type": "stock_item_plannings",
            "id": "d6be8cae-dec3-4eff-b301-9321ed69331b"
          },
          {
            "type": "stock_item_plannings",
            "id": "b855e7cd-0a08-4bfb-9294-de225e42fe1e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-05T12:40:18+00:00",
        "updated_at": "2022-01-05T12:40:20+00:00",
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
        "customer_id": "9fdd30fd-d500-48f9-bc0b-20a78c062dbc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4",
        "stop_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4"
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
      "id": "e5ec4b0a-a49c-4d82-8fbe-0cf0ec259635",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-05T12:40:18+00:00",
        "updated_at": "2022-01-05T12:40:20+00:00",
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
        "item_id": "77d27dc7-e72a-47d7-a80a-820a459821d3",
        "tax_category_id": "a2eda0c0-3697-4654-80e9-1544db882dc5",
        "parent_line_id": null,
        "owner_id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
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
      "id": "e954556c-648a-4f0b-b5c2-eb06f2f87bfb",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-05T12:40:19+00:00",
        "updated_at": "2022-01-05T12:40:20+00:00",
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
        "item_id": "cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea",
        "tax_category_id": "a2eda0c0-3697-4654-80e9-1544db882dc5",
        "parent_line_id": null,
        "owner_id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
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
      "id": "f87368b0-349a-4a84-8219-371b94cbb90a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:18+00:00",
        "updated_at": "2022-01-05T12:40:19+00:00",
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
        "item_id": "77d27dc7-e72a-47d7-a80a-820a459821d3",
        "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
        "start_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4",
        "stop_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4",
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
      "id": "26fe83c1-0414-444b-bdfe-686f555361ad",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:19+00:00",
        "updated_at": "2022-01-05T12:40:19+00:00",
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
        "item_id": "cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea",
        "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f",
        "start_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4",
        "stop_location_id": "cbb32cd2-1b04-4fc5-98f8-92f36abc35a4",
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
      "id": "c57e6b4e-f616-4ed4-8efc-2d8d1ae6b212",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:19+00:00",
        "updated_at": "2022-01-05T12:40:19+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a3b78af5-e032-4cbc-8129-607c42a58238",
        "planning_id": "26fe83c1-0414-444b-bdfe-686f555361ad",
        "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f"
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
      "id": "d6be8cae-dec3-4eff-b301-9321ed69331b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:19+00:00",
        "updated_at": "2022-01-05T12:40:19+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "470f9329-e100-4a8c-8214-b9c3f70e32e5",
        "planning_id": "26fe83c1-0414-444b-bdfe-686f555361ad",
        "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f"
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
      "id": "b855e7cd-0a08-4bfb-9294-de225e42fe1e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:19+00:00",
        "updated_at": "2022-01-05T12:40:19+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c1dc95d1-8aab-455b-aab9-d66ed1ef9621",
        "planning_id": "26fe83c1-0414-444b-bdfe-686f555361ad",
        "order_id": "f0254339-c02c-404b-9ac5-49e93c51f97f"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=cb3d8b07-d5fe-4ebc-8576-ebf0c4372fea&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a3b78af5-e032-4cbc-8129-607c42a58238&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=470f9329-e100-4a8c-8214-b9c3f70e32e5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c1dc95d1-8aab-455b-aab9-d66ed1ef9621&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=77d27dc7-e72a-47d7-a80a-820a459821d3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f0254339-c02c-404b-9ac5-49e93c51f97f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "1a30f1eb-4747-4161-a727-dd2670aea5e3",
          "items": [
            {
              "type": "bundles",
              "id": "b2df452d-c6c3-4a92-b1d5-b58af6631ab4",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "65add10a-7ec1-405e-9d1d-c0583dac68b4",
                  "id": "ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a"
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
    "id": "5c90e0f9-3659-55b2-ae08-beb390355cd3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1a30f1eb-4747-4161-a727-dd2670aea5e3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1a30f1eb-4747-4161-a727-dd2670aea5e3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0a3daf92-7c95-44ee-91b4-9636cd8b384e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a5738461-4d9d-43c9-a5d6-b03dc1c28d86"
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
      "id": "1a30f1eb-4747-4161-a727-dd2670aea5e3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-05T12:40:22+00:00",
        "updated_at": "2022-01-05T12:40:23+00:00",
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
        "starts_at": "2022-01-03T12:30:00+00:00",
        "stops_at": "2022-01-07T12:30:00+00:00",
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
        "start_location_id": "e5aec2f4-2780-4fb0-be48-889b0a267907",
        "stop_location_id": "e5aec2f4-2780-4fb0-be48-889b0a267907"
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
      "id": "0a3daf92-7c95-44ee-91b4-9636cd8b384e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-05T12:40:23+00:00",
        "updated_at": "2022-01-05T12:40:23+00:00",
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
        "item_id": "b2df452d-c6c3-4a92-b1d5-b58af6631ab4",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "1a30f1eb-4747-4161-a727-dd2670aea5e3",
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
      "id": "a5738461-4d9d-43c9-a5d6-b03dc1c28d86",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-05T12:40:23+00:00",
        "updated_at": "2022-01-05T12:40:23+00:00",
        "quantity": 1,
        "starts_at": "2022-01-03T12:30:00+00:00",
        "stops_at": "2022-01-07T12:30:00+00:00",
        "reserved_from": "2022-01-03T12:30:00+00:00",
        "reserved_till": "2022-01-07T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b2df452d-c6c3-4a92-b1d5-b58af6631ab4",
        "order_id": "1a30f1eb-4747-4161-a727-dd2670aea5e3",
        "start_location_id": "e5aec2f4-2780-4fb0-be48-889b0a267907",
        "stop_location_id": "e5aec2f4-2780-4fb0-be48-889b0a267907",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&data%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&data%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&data%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&data%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=b2df452d-c6c3-4a92-b1d5-b58af6631ab4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=65add10a-7ec1-405e-9d1d-c0583dac68b4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=ac2f1b6e-2cb4-4bb8-9269-8217889a7c6a&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1a30f1eb-4747-4161-a727-dd2670aea5e3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





