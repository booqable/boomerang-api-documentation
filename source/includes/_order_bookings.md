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
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


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
          "order_id": "81f180e7-6875-452e-8980-848b7f17a3c6",
          "items": [
            {
              "type": "products",
              "id": "be0ba5b7-ae21-4a0c-8c00-6950060a9119",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "db5451b4-e144-4de4-88c7-b4c853e265a7",
              "stock_item_ids": [
                "d20b6cd4-89da-4217-be63-dafb85ff369c",
                "3c9a6684-f8c4-46cb-b355-912585e43960"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id d20b6cd4-89da-4217-be63-dafb85ff369c has already been booked on this order"
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
          "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
          "items": [
            {
              "type": "products",
              "id": "13049020-ea3b-4930-80e0-87257061f08f",
              "stock_item_ids": [
                "f7b42133-c095-4403-8eb4-4153852d7eee",
                "66259ea5-1804-4ccd-a399-949c98162092",
                "d8ae00c2-8481-4a17-9f60-063af24a1691"
              ]
            },
            {
              "type": "products",
              "id": "30476aa5-74ad-4f17-b03d-2d3eb62d1e71",
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
    "id": "396edf5d-26eb-5424-9dec-b8c96cb457fc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b4abadde-0570-4d99-8500-d7fa3e4ad18c"
          },
          {
            "type": "lines",
            "id": "63d2f3e2-bfc0-4dae-8a96-8581d3e85ece"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d"
          },
          {
            "type": "plannings",
            "id": "0b0c5725-8785-418d-9c55-130a31ba6c51"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4b5ae04f-e3db-46d4-be1c-35d6db734ea8"
          },
          {
            "type": "stock_item_plannings",
            "id": "1bc261f1-2d6e-46a4-8e91-950375b4df34"
          },
          {
            "type": "stock_item_plannings",
            "id": "538b5aec-1a2e-40a1-b246-53f36e4b7126"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T10:36:48+00:00",
        "updated_at": "2023-02-22T10:36:50+00:00",
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
        "customer_id": "36f4f45d-03fe-427e-9b1f-9eb2739ee7d2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0",
        "stop_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0"
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
      "id": "b4abadde-0570-4d99-8500-d7fa3e4ad18c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:50+00:00",
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
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "13049020-ea3b-4930-80e0-87257061f08f",
        "tax_category_id": "2cdc6921-994a-499d-9a12-5b88fd587e39",
        "planning_id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d",
        "parent_line_id": null,
        "owner_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
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
      "id": "63d2f3e2-bfc0-4dae-8a96-8581d3e85ece",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:50+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
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
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "30476aa5-74ad-4f17-b03d-2d3eb62d1e71",
        "tax_category_id": "2cdc6921-994a-499d-9a12-5b88fd587e39",
        "planning_id": "0b0c5725-8785-418d-9c55-130a31ba6c51",
        "parent_line_id": null,
        "owner_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
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
      "id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:49+00:00",
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
        "item_id": "13049020-ea3b-4930-80e0-87257061f08f",
        "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
        "start_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0",
        "stop_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0",
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
      "id": "0b0c5725-8785-418d-9c55-130a31ba6c51",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:49+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "30476aa5-74ad-4f17-b03d-2d3eb62d1e71",
        "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6",
        "start_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0",
        "stop_location_id": "b96e1c69-a59c-46df-86ac-2cb5400b1cd0",
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
      "id": "4b5ae04f-e3db-46d4-be1c-35d6db734ea8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f7b42133-c095-4403-8eb4-4153852d7eee",
        "planning_id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d",
        "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6"
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
      "id": "1bc261f1-2d6e-46a4-8e91-950375b4df34",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66259ea5-1804-4ccd-a399-949c98162092",
        "planning_id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d",
        "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6"
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
      "id": "538b5aec-1a2e-40a1-b246-53f36e4b7126",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:49+00:00",
        "updated_at": "2023-02-22T10:36:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d8ae00c2-8481-4a17-9f60-063af24a1691",
        "planning_id": "cb8db2e2-c06a-4def-bf78-5aae8e9a1c3d",
        "order_id": "b8f6fbab-5ecd-42a0-b5e4-d5e7d68c0fd6"
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
          "order_id": "4501c5f1-805f-458e-b57c-b654988361ae",
          "items": [
            {
              "type": "bundles",
              "id": "891795d1-69db-4095-b6b4-525f4414231d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c8991a13-a57c-49ab-82fc-26f0c6c8b6fd",
                  "id": "921cf0b7-90bb-4f92-b861-df53dbff6819"
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
    "id": "66636482-3a2a-5dd5-9a96-4592896e21bf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4501c5f1-805f-458e-b57c-b654988361ae"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4501c5f1-805f-458e-b57c-b654988361ae"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4239f3bb-188d-4083-8958-84a80fb57a44"
          },
          {
            "type": "lines",
            "id": "0fb86974-f262-4fc6-b695-f7f1f399f6c4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "619ea51e-1830-4a0f-88ff-562183acce98"
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
      "id": "4501c5f1-805f-458e-b57c-b654988361ae",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T10:36:52+00:00",
        "updated_at": "2023-02-22T10:36:52+00:00",
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
        "starts_at": "2023-02-20T10:30:00+00:00",
        "stops_at": "2023-02-24T10:30:00+00:00",
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
        "start_location_id": "06eeb777-ab3b-4da6-82e0-bb700521a5db",
        "stop_location_id": "06eeb777-ab3b-4da6-82e0-bb700521a5db"
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
      "id": "4239f3bb-188d-4083-8958-84a80fb57a44",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T10:36:52+00:00",
        "updated_at": "2023-02-22T10:36:52+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 13 - red",
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
        "item_id": "921cf0b7-90bb-4f92-b861-df53dbff6819",
        "tax_category_id": null,
        "planning_id": "1b8115f3-478d-4afa-bec4-268acf8b5a09",
        "parent_line_id": "0fb86974-f262-4fc6-b695-f7f1f399f6c4",
        "owner_id": "4501c5f1-805f-458e-b57c-b654988361ae",
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
      "id": "0fb86974-f262-4fc6-b695-f7f1f399f6c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T10:36:52+00:00",
        "updated_at": "2023-02-22T10:36:52+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
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
        "item_id": "891795d1-69db-4095-b6b4-525f4414231d",
        "tax_category_id": null,
        "planning_id": "619ea51e-1830-4a0f-88ff-562183acce98",
        "parent_line_id": null,
        "owner_id": "4501c5f1-805f-458e-b57c-b654988361ae",
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
      "id": "619ea51e-1830-4a0f-88ff-562183acce98",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T10:36:52+00:00",
        "updated_at": "2023-02-22T10:36:52+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-20T10:30:00+00:00",
        "stops_at": "2023-02-24T10:30:00+00:00",
        "reserved_from": "2023-02-20T10:30:00+00:00",
        "reserved_till": "2023-02-24T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "891795d1-69db-4095-b6b4-525f4414231d",
        "order_id": "4501c5f1-805f-458e-b57c-b654988361ae",
        "start_location_id": "06eeb777-ab3b-4da6-82e0-bb700521a5db",
        "stop_location_id": "06eeb777-ab3b-4da6-82e0-bb700521a5db",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid** <br>
`data[attributes][items][]` | **Array** <br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid** <br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





