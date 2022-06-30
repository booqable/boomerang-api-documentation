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
          "order_id": "32e683f3-8ff6-4fec-8e9c-72929a049a3b",
          "items": [
            {
              "type": "products",
              "id": "c7ad4722-c47f-48ee-9103-8f32414f0684",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "76edb7d5-9d2c-43ea-be80-fe3374cd97c1",
              "stock_item_ids": [
                "124263f9-ef2e-4657-ac0d-1d3e05e0bd3a",
                "745a3fd9-7eb5-4a0f-a597-81cad25802ed"
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
            "item_id": "c7ad4722-c47f-48ee-9103-8f32414f0684",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
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
          "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
          "items": [
            {
              "type": "products",
              "id": "e783b6b1-8bd2-4f79-8a8b-e8ead0dfd9b6",
              "stock_item_ids": [
                "6ac1cf8b-1a1c-495d-8c44-895f6bfd6d6a",
                "ff6149a3-12e5-49bd-bc41-880d825cd8d5",
                "a88ea0f7-758d-42f1-89d5-1fa0f569669f"
              ]
            },
            {
              "type": "products",
              "id": "94019ec7-9635-48a3-99ee-0e21c9894b27",
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
    "id": "a527feb5-f2fb-52f3-872d-1511b920909f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ecff0be4-7280-4c68-90c9-3f304848c0a4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4dc058ef-acdd-442b-9bcf-021bdf667adc"
          },
          {
            "type": "lines",
            "id": "2c57f7de-bfea-4b92-a032-b595d67eb49c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b41ea618-af02-42fc-9873-c04380b43cea"
          },
          {
            "type": "plannings",
            "id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dc3e3164-b8d1-40ad-ad8e-8284d105f915"
          },
          {
            "type": "stock_item_plannings",
            "id": "beb49ba3-28bd-4443-8b6c-5b70fe2878fd"
          },
          {
            "type": "stock_item_plannings",
            "id": "b1f252f3-8ca0-4957-8eaf-14c5ed4039ef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T09:45:47+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
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
        "customer_id": "a3d0562a-d945-449e-8bec-ef115f657c55",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64",
        "stop_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64"
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
      "id": "4dc058ef-acdd-442b-9bcf-021bdf667adc",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T09:45:48+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "94019ec7-9635-48a3-99ee-0e21c9894b27",
        "tax_category_id": "d30400ce-1089-46c7-a8fd-1b57f4b50805",
        "planning_id": "b41ea618-af02-42fc-9873-c04380b43cea",
        "parent_line_id": null,
        "owner_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
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
      "id": "2c57f7de-bfea-4b92-a032-b595d67eb49c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T09:45:50+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "e783b6b1-8bd2-4f79-8a8b-e8ead0dfd9b6",
        "tax_category_id": "d30400ce-1089-46c7-a8fd-1b57f4b50805",
        "planning_id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271",
        "parent_line_id": null,
        "owner_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
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
      "id": "b41ea618-af02-42fc-9873-c04380b43cea",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:48+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "94019ec7-9635-48a3-99ee-0e21c9894b27",
        "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
        "start_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64",
        "stop_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64",
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
      "id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:50+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "e783b6b1-8bd2-4f79-8a8b-e8ead0dfd9b6",
        "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4",
        "start_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64",
        "stop_location_id": "7997ef9c-ceb1-49c5-85b6-0fd72b547c64",
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
      "id": "dc3e3164-b8d1-40ad-ad8e-8284d105f915",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:50+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6ac1cf8b-1a1c-495d-8c44-895f6bfd6d6a",
        "planning_id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271",
        "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4"
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
      "id": "beb49ba3-28bd-4443-8b6c-5b70fe2878fd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:50+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ff6149a3-12e5-49bd-bc41-880d825cd8d5",
        "planning_id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271",
        "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4"
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
      "id": "b1f252f3-8ca0-4957-8eaf-14c5ed4039ef",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:50+00:00",
        "updated_at": "2022-06-30T09:45:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a88ea0f7-758d-42f1-89d5-1fa0f569669f",
        "planning_id": "50fb4a13-b01d-4c77-84b7-3b5907ef4271",
        "order_id": "ecff0be4-7280-4c68-90c9-3f304848c0a4"
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
          "order_id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c",
          "items": [
            {
              "type": "bundles",
              "id": "3edf67f9-6dff-4f02-85a8-0519384d7623",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6dbacb1e-e0ac-44b6-9d87-0b713e015ba0",
                  "id": "7c77ef0f-3f71-4dbe-bf1e-4e3d3a3ef6d4"
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
    "id": "ceec7da7-b97d-5ee1-b43d-662081c30c92",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7f4ccc62-f898-4235-b66d-a853d63bc3be"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9f57ccbf-c6a6-4ed8-9f15-b4c2718ade79"
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
      "id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T09:45:52+00:00",
        "updated_at": "2022-06-30T09:45:53+00:00",
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
        "starts_at": "2022-06-28T09:45:00+00:00",
        "stops_at": "2022-07-02T09:45:00+00:00",
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
        "start_location_id": "16b23c7a-c670-4733-9763-514433201494",
        "stop_location_id": "16b23c7a-c670-4733-9763-514433201494"
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
      "id": "7f4ccc62-f898-4235-b66d-a853d63bc3be",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T09:45:53+00:00",
        "updated_at": "2022-06-30T09:45:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "3edf67f9-6dff-4f02-85a8-0519384d7623",
        "tax_category_id": null,
        "planning_id": "9f57ccbf-c6a6-4ed8-9f15-b4c2718ade79",
        "parent_line_id": null,
        "owner_id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c",
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
      "id": "9f57ccbf-c6a6-4ed8-9f15-b4c2718ade79",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T09:45:53+00:00",
        "updated_at": "2022-06-30T09:45:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-28T09:45:00+00:00",
        "stops_at": "2022-07-02T09:45:00+00:00",
        "reserved_from": "2022-06-28T09:45:00+00:00",
        "reserved_till": "2022-07-02T09:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3edf67f9-6dff-4f02-85a8-0519384d7623",
        "order_id": "a7670fdb-9078-4c1b-bb3f-ada85ad0453c",
        "start_location_id": "16b23c7a-c670-4733-9763-514433201494",
        "stop_location_id": "16b23c7a-c670-4733-9763-514433201494",
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





