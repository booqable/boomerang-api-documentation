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
          "order_id": "2a734f1e-573b-4355-b024-6403c1181c1a",
          "items": [
            {
              "type": "products",
              "id": "861c6ca2-7820-433f-944f-9cfa075f09e3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d561f816-dff9-4bc3-88ff-7d3513ba8376",
              "stock_item_ids": [
                "c48833f2-d034-459b-868e-fb41b6b3b8b3",
                "1adfe1ff-f3df-42b2-a857-aed21818586d"
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
            "item_id": "861c6ca2-7820-433f-944f-9cfa075f09e3",
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
          "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
          "items": [
            {
              "type": "products",
              "id": "7f46b723-4c7f-4f4b-931f-ccefbaa533e6",
              "stock_item_ids": [
                "8dc8fc59-8b59-435f-b08a-a927fc9f4f60",
                "5b156356-222e-480c-8c5c-6d780a7466a8",
                "7bd72bf6-116c-4fa3-b5d7-07de7bf54e48"
              ]
            },
            {
              "type": "products",
              "id": "786353ab-d0ee-4f8c-9fd2-d5e5909239a4",
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
    "id": "0c935b7d-b56e-5caa-948f-41e8840b87a6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7f65ca07-d832-47b0-80ef-0bd365c03da0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8edd63ec-6a63-409d-bba1-9966da294000"
          },
          {
            "type": "lines",
            "id": "656b2feb-d6c2-41eb-b09a-d2ffc46b6e5e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5c8702f0-558d-4c75-89c9-7f787dcf389e"
          },
          {
            "type": "plannings",
            "id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fa32fd60-e356-4733-aecd-61e43b5d7af7"
          },
          {
            "type": "stock_item_plannings",
            "id": "856c4503-fb11-4f71-80ad-17c9fc9f5bb4"
          },
          {
            "type": "stock_item_plannings",
            "id": "a4b0f3b8-3527-4cb0-a556-f5ad60fd0b9b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T10:14:04+00:00",
        "updated_at": "2022-01-12T10:14:07+00:00",
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
        "customer_id": "c9220b14-3c6b-4e24-a94c-c2ae3f8a0c61",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5",
        "stop_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5"
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
      "id": "8edd63ec-6a63-409d-bba1-9966da294000",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:14:05+00:00",
        "updated_at": "2022-01-12T10:14:07+00:00",
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
        "item_id": "786353ab-d0ee-4f8c-9fd2-d5e5909239a4",
        "tax_category_id": "172e3835-25d3-44d1-8fe0-a49ec562ebb1",
        "planning_id": "5c8702f0-558d-4c75-89c9-7f787dcf389e",
        "parent_line_id": null,
        "owner_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
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
      "id": "656b2feb-d6c2-41eb-b09a-d2ffc46b6e5e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:14:06+00:00",
        "updated_at": "2022-01-12T10:14:07+00:00",
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
        "item_id": "7f46b723-4c7f-4f4b-931f-ccefbaa533e6",
        "tax_category_id": "172e3835-25d3-44d1-8fe0-a49ec562ebb1",
        "planning_id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8",
        "parent_line_id": null,
        "owner_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
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
      "id": "5c8702f0-558d-4c75-89c9-7f787dcf389e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:05+00:00",
        "updated_at": "2022-01-12T10:14:06+00:00",
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
        "item_id": "786353ab-d0ee-4f8c-9fd2-d5e5909239a4",
        "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
        "start_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5",
        "stop_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5",
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
      "id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:06+00:00",
        "updated_at": "2022-01-12T10:14:06+00:00",
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
        "item_id": "7f46b723-4c7f-4f4b-931f-ccefbaa533e6",
        "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0",
        "start_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5",
        "stop_location_id": "d54233d5-5181-4bbe-8e5f-adac89d1eba5",
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
      "id": "fa32fd60-e356-4733-aecd-61e43b5d7af7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:06+00:00",
        "updated_at": "2022-01-12T10:14:06+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8dc8fc59-8b59-435f-b08a-a927fc9f4f60",
        "planning_id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8",
        "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0"
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
      "id": "856c4503-fb11-4f71-80ad-17c9fc9f5bb4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:06+00:00",
        "updated_at": "2022-01-12T10:14:06+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5b156356-222e-480c-8c5c-6d780a7466a8",
        "planning_id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8",
        "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0"
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
      "id": "a4b0f3b8-3527-4cb0-a556-f5ad60fd0b9b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:06+00:00",
        "updated_at": "2022-01-12T10:14:06+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7bd72bf6-116c-4fa3-b5d7-07de7bf54e48",
        "planning_id": "aeec176b-4e9b-4d22-907a-d5fbf3d6b2e8",
        "order_id": "7f65ca07-d832-47b0-80ef-0bd365c03da0"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7f46b723-4c7f-4f4b-931f-ccefbaa533e6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8dc8fc59-8b59-435f-b08a-a927fc9f4f60&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5b156356-222e-480c-8c5c-6d780a7466a8&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7bd72bf6-116c-4fa3-b5d7-07de7bf54e48&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=786353ab-d0ee-4f8c-9fd2-d5e5909239a4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=7f65ca07-d832-47b0-80ef-0bd365c03da0&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a",
          "items": [
            {
              "type": "bundles",
              "id": "8f87b942-2e7d-4b9a-b948-ac919c78e9af",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "63824d31-fdab-45cf-aba9-8a6bbe667bf6",
                  "id": "4a19f25e-6210-42b0-8e26-44b9008c846c"
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
    "id": "fe98d06a-a9d6-5bb6-b2ab-66b378b5823d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "06a57e33-62d5-4884-9a98-8067dbf8f236"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5cd6e554-cb19-433a-b853-47f3967aa596"
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
      "id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-12T10:14:09+00:00",
        "updated_at": "2022-01-12T10:14:11+00:00",
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
        "starts_at": "2022-01-10T10:00:00+00:00",
        "stops_at": "2022-01-14T10:00:00+00:00",
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
        "start_location_id": "7be2b6bb-ff33-435b-87b1-5ed874a6bc2b",
        "stop_location_id": "7be2b6bb-ff33-435b-87b1-5ed874a6bc2b"
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
      "id": "06a57e33-62d5-4884-9a98-8067dbf8f236",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-12T10:14:10+00:00",
        "updated_at": "2022-01-12T10:14:10+00:00",
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
        "item_id": "8f87b942-2e7d-4b9a-b948-ac919c78e9af",
        "tax_category_id": null,
        "planning_id": "5cd6e554-cb19-433a-b853-47f3967aa596",
        "parent_line_id": null,
        "owner_id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a",
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
      "id": "5cd6e554-cb19-433a-b853-47f3967aa596",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-12T10:14:10+00:00",
        "updated_at": "2022-01-12T10:14:10+00:00",
        "quantity": 1,
        "starts_at": "2022-01-10T10:00:00+00:00",
        "stops_at": "2022-01-14T10:00:00+00:00",
        "reserved_from": "2022-01-10T10:00:00+00:00",
        "reserved_till": "2022-01-14T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8f87b942-2e7d-4b9a-b948-ac919c78e9af",
        "order_id": "5c0bef26-76d3-4c01-bee9-048dd1dc1e8a",
        "start_location_id": "7be2b6bb-ff33-435b-87b1-5ed874a6bc2b",
        "stop_location_id": "7be2b6bb-ff33-435b-87b1-5ed874a6bc2b",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&data%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&data%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&data%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&data%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=8f87b942-2e7d-4b9a-b948-ac919c78e9af&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=63824d31-fdab-45cf-aba9-8a6bbe667bf6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=4a19f25e-6210-42b0-8e26-44b9008c846c&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5c0bef26-76d3-4c01-bee9-048dd1dc1e8a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





