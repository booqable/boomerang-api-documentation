# Bookings

Add products, bundles and specific stock items to an order.

Items can be added quantitatively or, for trackable products, specific stock items can be specified. Specifying stock items is not required on booking; they can also be defined when transitioning the order status to a `started` state.

> Adding items quantitatively:

```
  "items": [
    {
      "type": "Product",
      "id": "69a6ac18-244e-4b1e-b2e1-c88d155b51e5",
      "quantity": 10
    }
  ]
```

> Adding specific stock items:

```
  "items": [
    {
      "type": "Product",
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

```
  "items": [
    {
      "type": "Bundle",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
    }
  ]
```

> Adding a bundle and specifying a variation (for product that has variations)

```
  "items": [
    {
      "type": "Bundle",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "products": [
        {
          id: ""9bf34d16-2144-45a5-8461-ebae7bf0f4ca"
        }
      }
    }
  ]
```

**When a booking is successful, the price and status information of the order will be updated, and the following resources are created:**

- **Plannings** Quantitative data about the planning of an item.
- **Stock item plannings** Planning for specific stock items (when stock items are specified).
- **Lines** Individual elements on order, which in the case of bookings contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Endpoints
`POST /api/boomerang/bookings`

## Fields
Every booking has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


## Relationships
Bookings have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`lines` | **Lines** `readonly`<br>Associated Lines
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Creating a booking



> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "6c976c08-abf1-424a-af1c-dc553ce0d6a5",
          "items": [
            {
              "type": "Product",
              "id": "75617109-a0da-4dd4-9d13-d1894caa4ac1",
              "quantity": 10
            },
            {
              "type": "Product",
              "id": "5a19cb4f-8100-4758-bc9b-0e7b3c472b6f",
              "stock_item_ids": [
                "726b4c7c-e50c-4ba1-a12a-8087297436c4",
                "ef9fc0f1-15f9-4fac-91cc-56266d6f80a3"
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
            "item_id": "75617109-a0da-4dd4-9d13-d1894caa4ac1",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "5a19cb4f-8100-4758-bc9b-0e7b3c472b6f",
            "unavailable": [
              "726b4c7c-e50c-4ba1-a12a-8087297436c4"
            ],
            "available": [
              "ef9fc0f1-15f9-4fac-91cc-56266d6f80a3"
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
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
          "items": [
            {
              "type": "Product",
              "id": "9ddea90b-a947-4372-9e81-e5cf4cecc8d2",
              "stock_item_ids": [
                "245590f6-692c-4bd0-9ed7-19344b7f11b1",
                "84fa58de-813d-4011-8a1e-cacea03d1bf4",
                "a302a363-d379-4a97-9050-6f9a74500eb9"
              ]
            },
            {
              "type": "Product",
              "id": "dbfbc8a1-2c1d-474c-b66a-37e10df2571b",
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
    "id": "b275e833-fa33-5682-ae4e-da794f49d889",
    "type": "bookings",
    "attributes": {
      "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dd801687-27d5-43ab-8703-f54a6bb2b72b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "06e8cc6f-d07d-489e-8282-115cc38777df"
          },
          {
            "type": "lines",
            "id": "fa182b00-d991-4273-8f73-6fde538884a5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "51495bc2-1e7d-47d6-a76d-0b57163ed5fd"
          },
          {
            "type": "plannings",
            "id": "7b6a985c-2f48-436a-b357-a1b45f56d966"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "74ef8221-ae61-4dae-9a1a-b66b2c89b183"
          },
          {
            "type": "stock_item_plannings",
            "id": "b5409a61-2373-42be-8f11-1a1436e7cf02"
          },
          {
            "type": "stock_item_plannings",
            "id": "d88d56f7-195b-4ffe-b75d-f958b44f8ecb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
      "type": "orders",
      "attributes": {
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
        "customer_id": "4d93e7eb-2959-4fd8-86e2-8866d8cd0367",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c",
        "stop_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c"
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
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "06e8cc6f-d07d-489e-8282-115cc38777df",
      "type": "lines",
      "attributes": {
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
        "owner_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
        "owner_type": "Order",
        "item_id": "dbfbc8a1-2c1d-474c-b66a-37e10df2571b",
        "tax_category_id": "6be3aab0-822c-4804-9dd5-2ef87d8ee765",
        "parent_line_id": null
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
      "id": "fa182b00-d991-4273-8f73-6fde538884a5",
      "type": "lines",
      "attributes": {
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
        "owner_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
        "owner_type": "Order",
        "item_id": "9ddea90b-a947-4372-9e81-e5cf4cecc8d2",
        "tax_category_id": "6be3aab0-822c-4804-9dd5-2ef87d8ee765",
        "parent_line_id": null
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
      "id": "51495bc2-1e7d-47d6-a76d-0b57163ed5fd",
      "type": "plannings",
      "attributes": {
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
        "item_id": "9ddea90b-a947-4372-9e81-e5cf4cecc8d2",
        "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
        "start_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c",
        "stop_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c",
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
      "id": "7b6a985c-2f48-436a-b357-a1b45f56d966",
      "type": "plannings",
      "attributes": {
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
        "item_id": "dbfbc8a1-2c1d-474c-b66a-37e10df2571b",
        "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b",
        "start_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c",
        "stop_location_id": "6a0a9ede-117a-4a51-80a0-a4557d1b010c",
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
      "id": "74ef8221-ae61-4dae-9a1a-b66b2c89b183",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "245590f6-692c-4bd0-9ed7-19344b7f11b1",
        "planning_id": "51495bc2-1e7d-47d6-a76d-0b57163ed5fd",
        "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b"
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
      "id": "b5409a61-2373-42be-8f11-1a1436e7cf02",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "84fa58de-813d-4011-8a1e-cacea03d1bf4",
        "planning_id": "51495bc2-1e7d-47d6-a76d-0b57163ed5fd",
        "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b"
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
      "id": "d88d56f7-195b-4ffe-b75d-f958b44f8ecb",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a302a363-d379-4a97-9050-6f9a74500eb9",
        "planning_id": "51495bc2-1e7d-47d6-a76d-0b57163ed5fd",
        "order_id": "dd801687-27d5-43ab-8703-f54a6bb2b72b"
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9ddea90b-a947-4372-9e81-e5cf4cecc8d2&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=245590f6-692c-4bd0-9ed7-19344b7f11b1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84fa58de-813d-4011-8a1e-cacea03d1bf4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=a302a363-d379-4a97-9050-6f9a74500eb9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=dbfbc8a1-2c1d-474c-b66a-37e10df2571b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=dd801687-27d5-43ab-8703-f54a6bb2b72b&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bookings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bookings]=id,created_at,updated_at`


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


`lines`


`plannings`


`stock_item_plannings`





