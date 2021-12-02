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
          "order_id": "5800967a-cd90-422f-9f2a-bc94b880ead0",
          "items": [
            {
              "type": "products",
              "id": "5172a07e-13f3-4567-b139-e11ce60dc8cd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "68f06d3d-9776-4be2-9651-85f6450f48b3",
              "stock_item_ids": [
                "453e7485-4d0c-4724-8039-4b0a05c22b9f",
                "2d67dc70-3e27-4f96-a0e3-0aa4c253bba6"
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
            "item_id": "5172a07e-13f3-4567-b139-e11ce60dc8cd",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "68f06d3d-9776-4be2-9651-85f6450f48b3",
            "unavailable": [
              "453e7485-4d0c-4724-8039-4b0a05c22b9f"
            ],
            "available": [
              "2d67dc70-3e27-4f96-a0e3-0aa4c253bba6"
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
          "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
          "items": [
            {
              "type": "products",
              "id": "9d147038-8d3b-4ed6-86dc-3dae1fc5308f",
              "stock_item_ids": [
                "2316443b-978e-4696-9213-d8e2ebda5883",
                "66b4be9e-1635-46a2-bf0c-53b1243ea966",
                "f8119364-6959-4b34-ac26-c60de713d69f"
              ]
            },
            {
              "type": "products",
              "id": "06911f97-eee2-4075-ad40-cc97cd80f662",
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
    "id": "ecb51e2a-7623-5784-a2f7-041961b7f49f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8faf3f0f-8328-4648-a079-9e0adfa180c0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c968c75e-a1e2-4d18-80bb-d26b7403ac44"
          },
          {
            "type": "lines",
            "id": "c154efa4-b372-4a9e-b1bb-46ff9ea4c30b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "36098f0a-474a-4ec1-b6e0-4c0c78e28712"
          },
          {
            "type": "plannings",
            "id": "15100c2c-2c75-4784-a3e9-5d7fc9d2cf57"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d2579b97-1fda-4add-8fb8-90426ab8f25e"
          },
          {
            "type": "stock_item_plannings",
            "id": "eac41e74-4aaf-4615-a8d9-15a7143976eb"
          },
          {
            "type": "stock_item_plannings",
            "id": "4d98eca3-73e9-4914-890f-ae8c51667677"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T14:38:24+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
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
        "customer_id": "50444e5b-b49e-4897-9601-71dbec291519",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9",
        "stop_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9"
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
      "id": "c968c75e-a1e2-4d18-80bb-d26b7403ac44",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T14:38:25+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
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
        "item_id": "06911f97-eee2-4075-ad40-cc97cd80f662",
        "tax_category_id": "42ccea47-5abd-458d-aeb9-1b12d9762bc6",
        "parent_line_id": null,
        "owner_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
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
      "id": "c154efa4-b372-4a9e-b1bb-46ff9ea4c30b",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T14:38:26+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
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
        "item_id": "9d147038-8d3b-4ed6-86dc-3dae1fc5308f",
        "tax_category_id": "42ccea47-5abd-458d-aeb9-1b12d9762bc6",
        "parent_line_id": null,
        "owner_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
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
      "id": "36098f0a-474a-4ec1-b6e0-4c0c78e28712",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:25+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
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
        "item_id": "06911f97-eee2-4075-ad40-cc97cd80f662",
        "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
        "start_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9",
        "stop_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9",
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
      "id": "15100c2c-2c75-4784-a3e9-5d7fc9d2cf57",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:26+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
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
        "item_id": "9d147038-8d3b-4ed6-86dc-3dae1fc5308f",
        "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0",
        "start_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9",
        "stop_location_id": "a708a605-0fad-45e5-9c79-13a2e426d1c9",
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
      "id": "d2579b97-1fda-4add-8fb8-90426ab8f25e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:26+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2316443b-978e-4696-9213-d8e2ebda5883",
        "planning_id": "15100c2c-2c75-4784-a3e9-5d7fc9d2cf57",
        "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0"
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
      "id": "eac41e74-4aaf-4615-a8d9-15a7143976eb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:26+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66b4be9e-1635-46a2-bf0c-53b1243ea966",
        "planning_id": "15100c2c-2c75-4784-a3e9-5d7fc9d2cf57",
        "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0"
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
      "id": "4d98eca3-73e9-4914-890f-ae8c51667677",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:26+00:00",
        "updated_at": "2021-12-02T14:38:26+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f8119364-6959-4b34-ac26-c60de713d69f",
        "planning_id": "15100c2c-2c75-4784-a3e9-5d7fc9d2cf57",
        "order_id": "8faf3f0f-8328-4648-a079-9e0adfa180c0"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9d147038-8d3b-4ed6-86dc-3dae1fc5308f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2316443b-978e-4696-9213-d8e2ebda5883&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=66b4be9e-1635-46a2-bf0c-53b1243ea966&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f8119364-6959-4b34-ac26-c60de713d69f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=06911f97-eee2-4075-ad40-cc97cd80f662&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=8faf3f0f-8328-4648-a079-9e0adfa180c0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17",
          "items": [
            {
              "type": "bundles",
              "id": "2f6ebd4a-89d4-4d37-bfd2-d226d3e61480",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c9c08a60-7821-473a-8ac5-f35a84a882e7",
                  "id": "e117872d-84f1-421c-88e0-e0b216b6b245"
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
    "id": "d74dbcc4-8391-552e-ae83-4ad0e0e762b6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "82a27ea9-c72f-4b45-a14c-73516b78db2d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ebff2df0-1c4d-4a5d-94ea-822810e44bcb"
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
      "id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T14:38:29+00:00",
        "updated_at": "2021-12-02T14:38:30+00:00",
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
        "starts_at": "2021-11-30T14:30:00+00:00",
        "stops_at": "2021-12-04T14:30:00+00:00",
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
        "start_location_id": "6e2b4771-14d6-4132-bbca-09ba7af1e18e",
        "stop_location_id": "6e2b4771-14d6-4132-bbca-09ba7af1e18e"
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
      "id": "82a27ea9-c72f-4b45-a14c-73516b78db2d",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T14:38:30+00:00",
        "updated_at": "2021-12-02T14:38:30+00:00",
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
        "item_id": "2f6ebd4a-89d4-4d37-bfd2-d226d3e61480",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17",
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
      "id": "ebff2df0-1c4d-4a5d-94ea-822810e44bcb",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T14:38:30+00:00",
        "updated_at": "2021-12-02T14:38:30+00:00",
        "quantity": 1,
        "starts_at": "2021-11-30T14:30:00+00:00",
        "stops_at": "2021-12-04T14:30:00+00:00",
        "reserved_from": "2021-11-30T14:30:00+00:00",
        "reserved_till": "2021-12-04T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2f6ebd4a-89d4-4d37-bfd2-d226d3e61480",
        "order_id": "4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17",
        "start_location_id": "6e2b4771-14d6-4132-bbca-09ba7af1e18e",
        "stop_location_id": "6e2b4771-14d6-4132-bbca-09ba7af1e18e",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&data%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&data%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&data%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&data%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=2f6ebd4a-89d4-4d37-bfd2-d226d3e61480&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=c9c08a60-7821-473a-8ac5-f35a84a882e7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=e117872d-84f1-421c-88e0-e0b216b6b245&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4b29a70c-6bb3-4ed2-8b1a-7ba1de8ceb17&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





