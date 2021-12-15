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
          "order_id": "eb1d84c6-175c-494f-997c-21d0098f1e60",
          "items": [
            {
              "type": "products",
              "id": "d4a2ee8f-c1d1-4dc3-9601-cef155b98d49",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "919b1d09-cb1c-456f-967f-ec803509e97b",
              "stock_item_ids": [
                "6bf2471a-05b4-41ba-aa2c-878cfbc2df60",
                "f6e93bae-7a4b-47b5-a71d-3f1374bfc174"
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
            "item_id": "d4a2ee8f-c1d1-4dc3-9601-cef155b98d49",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "919b1d09-cb1c-456f-967f-ec803509e97b",
            "unavailable": [
              "6bf2471a-05b4-41ba-aa2c-878cfbc2df60"
            ],
            "available": [
              "f6e93bae-7a4b-47b5-a71d-3f1374bfc174"
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
          "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
          "items": [
            {
              "type": "products",
              "id": "6f563677-34c7-4352-b758-6857ec2e0f6c",
              "stock_item_ids": [
                "e216f61b-09eb-4d2e-ae67-e197a003a241",
                "f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b",
                "b80f967c-affd-4cf0-903c-d3ae38e678c1"
              ]
            },
            {
              "type": "products",
              "id": "876aaf99-5596-42fe-947f-743bece37702",
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
    "id": "5212243f-6a3d-552b-9b06-07c38e575dfa",
    "type": "order_bookings",
    "attributes": {
      "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "996558fa-208a-4ab4-8fc7-d630286bcb5d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4c2514e9-2102-45e0-8de7-7e0811a16150"
          },
          {
            "type": "lines",
            "id": "e1f3bac5-6e8b-41d7-8d6e-62e0332ffb6c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bce7b6f6-e9f1-4249-91c5-f5645d13b8ea"
          },
          {
            "type": "plannings",
            "id": "e51cd540-2ae7-4398-bddd-ae96370dfa66"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e0eeb3a9-50ae-4b42-8c91-6f1be7f19122"
          },
          {
            "type": "stock_item_plannings",
            "id": "17d60eb8-4602-40f7-8f51-a15a82a3d945"
          },
          {
            "type": "stock_item_plannings",
            "id": "d4452062-885d-4525-8135-400765e2b8cd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-15T11:44:50+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
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
        "customer_id": "40be38fd-0fac-4a35-b165-ab9f2b2c3c68",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7",
        "stop_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7"
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
      "id": "4c2514e9-2102-45e0-8de7-7e0811a16150",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-15T11:44:51+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
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
        "item_id": "876aaf99-5596-42fe-947f-743bece37702",
        "tax_category_id": "42bf47e4-f532-422f-b2fd-9cfef1c93cfb",
        "parent_line_id": null,
        "owner_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
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
      "id": "e1f3bac5-6e8b-41d7-8d6e-62e0332ffb6c",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-15T11:44:52+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
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
        "item_id": "6f563677-34c7-4352-b758-6857ec2e0f6c",
        "tax_category_id": "42bf47e4-f532-422f-b2fd-9cfef1c93cfb",
        "parent_line_id": null,
        "owner_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
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
      "id": "bce7b6f6-e9f1-4249-91c5-f5645d13b8ea",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:51+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
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
        "item_id": "876aaf99-5596-42fe-947f-743bece37702",
        "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
        "start_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7",
        "stop_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7",
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
      "id": "e51cd540-2ae7-4398-bddd-ae96370dfa66",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:52+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
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
        "item_id": "6f563677-34c7-4352-b758-6857ec2e0f6c",
        "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d",
        "start_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7",
        "stop_location_id": "a9ac65a3-afb0-4703-929d-ccb8500c88a7",
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
      "id": "e0eeb3a9-50ae-4b42-8c91-6f1be7f19122",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:52+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e216f61b-09eb-4d2e-ae67-e197a003a241",
        "planning_id": "e51cd540-2ae7-4398-bddd-ae96370dfa66",
        "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d"
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
      "id": "17d60eb8-4602-40f7-8f51-a15a82a3d945",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:52+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b",
        "planning_id": "e51cd540-2ae7-4398-bddd-ae96370dfa66",
        "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d"
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
      "id": "d4452062-885d-4525-8135-400765e2b8cd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:52+00:00",
        "updated_at": "2021-12-15T11:44:52+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b80f967c-affd-4cf0-903c-d3ae38e678c1",
        "planning_id": "e51cd540-2ae7-4398-bddd-ae96370dfa66",
        "order_id": "996558fa-208a-4ab4-8fc7-d630286bcb5d"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6f563677-34c7-4352-b758-6857ec2e0f6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=e216f61b-09eb-4d2e-ae67-e197a003a241&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f4b948c2-a4ed-4b92-8d38-e0b97eadaa9b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b80f967c-affd-4cf0-903c-d3ae38e678c1&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=876aaf99-5596-42fe-947f-743bece37702&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=996558fa-208a-4ab4-8fc7-d630286bcb5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1",
          "items": [
            {
              "type": "bundles",
              "id": "290d0490-40f1-454e-bf3b-2268b352256b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b5e91861-7eee-4a00-ac1d-d11c759ca68e",
                  "id": "59650135-f16f-4a81-9e30-939af7b3d10b"
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
    "id": "b0373547-15bb-5d79-8e80-04d9a688ae91",
    "type": "order_bookings",
    "attributes": {
      "order_id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e723fdef-789c-4538-960b-90751224c3d5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cf0567b8-bf0b-49b8-9e52-7cdf36e4673d"
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
      "id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-15T11:44:55+00:00",
        "updated_at": "2021-12-15T11:44:56+00:00",
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
        "starts_at": "2021-12-13T11:30:00+00:00",
        "stops_at": "2021-12-17T11:30:00+00:00",
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
        "start_location_id": "76540cbc-0143-4dca-acdf-05cf121866d5",
        "stop_location_id": "76540cbc-0143-4dca-acdf-05cf121866d5"
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
      "id": "e723fdef-789c-4538-960b-90751224c3d5",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-15T11:44:56+00:00",
        "updated_at": "2021-12-15T11:44:56+00:00",
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
        "item_id": "290d0490-40f1-454e-bf3b-2268b352256b",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1",
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
      "id": "cf0567b8-bf0b-49b8-9e52-7cdf36e4673d",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-15T11:44:56+00:00",
        "updated_at": "2021-12-15T11:44:56+00:00",
        "quantity": 1,
        "starts_at": "2021-12-13T11:30:00+00:00",
        "stops_at": "2021-12-17T11:30:00+00:00",
        "reserved_from": "2021-12-13T11:30:00+00:00",
        "reserved_till": "2021-12-17T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "290d0490-40f1-454e-bf3b-2268b352256b",
        "order_id": "eaebdb1a-c6a4-47b3-b983-ce0d0053cce1",
        "start_location_id": "76540cbc-0143-4dca-acdf-05cf121866d5",
        "stop_location_id": "76540cbc-0143-4dca-acdf-05cf121866d5",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&data%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&data%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&data%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&data%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=290d0490-40f1-454e-bf3b-2268b352256b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=b5e91861-7eee-4a00-ac1d-d11c759ca68e&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=59650135-f16f-4a81-9e30-939af7b3d10b&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=eaebdb1a-c6a4-47b3-b983-ce0d0053cce1&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





