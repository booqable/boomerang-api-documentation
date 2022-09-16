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
          "order_id": "4770551b-4b1e-4c25-8204-424d2a5e73b6",
          "items": [
            {
              "type": "products",
              "id": "42558b26-f41f-477f-bbaf-76dca5d01daf",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2ee88639-2fab-4616-934f-e0626b3e0bcd",
              "stock_item_ids": [
                "cc18e836-9c8c-4ae5-8433-fb1a7576ebf6",
                "2491922f-e10e-487a-ad76-af0239856ff7"
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
            "item_id": "42558b26-f41f-477f-bbaf-76dca5d01daf",
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
          "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
          "items": [
            {
              "type": "products",
              "id": "66580840-33ee-4882-b8d4-284798b68ae3",
              "stock_item_ids": [
                "625a32e6-ddd0-4af0-8cf2-fb85d78542a3",
                "5e9d633b-42b6-4188-a0b3-3e73ccb1f5c2",
                "d6316dc6-bc7f-4d89-b564-526c099ac681"
              ]
            },
            {
              "type": "products",
              "id": "6f0b39ff-c48e-44d6-88b8-4b218adffe1c",
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
    "id": "c8700e1f-adde-5b1b-b13e-34155dae027d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b780b869-3825-4208-88e1-d79600e296a6"
          },
          {
            "type": "lines",
            "id": "7a526e2c-b1d3-4c09-8b6c-1bb06165989e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c"
          },
          {
            "type": "plannings",
            "id": "a46cfc95-ffae-4c62-83f8-37cdf103fba9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f23ccb77-e694-4678-96db-2c9e2ac2d18b"
          },
          {
            "type": "stock_item_plannings",
            "id": "3f0a9cb0-e3ce-4b4b-9098-5c7bb5e1504f"
          },
          {
            "type": "stock_item_plannings",
            "id": "5b79ec04-f797-4ca6-906f-f71b2a906f1d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T12:13:18+00:00",
        "updated_at": "2022-09-16T12:13:21+00:00",
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
        "customer_id": "2f9a97ee-3e50-4ff2-8409-73fb4bbd600f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580",
        "stop_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580"
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
      "id": "b780b869-3825-4208-88e1-d79600e296a6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:21+00:00",
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
        "item_id": "66580840-33ee-4882-b8d4-284798b68ae3",
        "tax_category_id": "87e29c53-9c73-4ebf-8eb5-985f44717ca8",
        "planning_id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c",
        "parent_line_id": null,
        "owner_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
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
      "id": "7a526e2c-b1d3-4c09-8b6c-1bb06165989e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:21+00:00",
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
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "6f0b39ff-c48e-44d6-88b8-4b218adffe1c",
        "tax_category_id": "87e29c53-9c73-4ebf-8eb5-985f44717ca8",
        "planning_id": "a46cfc95-ffae-4c62-83f8-37cdf103fba9",
        "parent_line_id": null,
        "owner_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
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
      "id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:21+00:00",
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
        "item_id": "66580840-33ee-4882-b8d4-284798b68ae3",
        "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
        "start_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580",
        "stop_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580",
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
      "id": "a46cfc95-ffae-4c62-83f8-37cdf103fba9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:21+00:00",
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
        "item_id": "6f0b39ff-c48e-44d6-88b8-4b218adffe1c",
        "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441",
        "start_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580",
        "stop_location_id": "7f4c11d8-0334-4e00-9df8-6e8ebfa14580",
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
      "id": "f23ccb77-e694-4678-96db-2c9e2ac2d18b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "625a32e6-ddd0-4af0-8cf2-fb85d78542a3",
        "planning_id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c",
        "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441"
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
      "id": "3f0a9cb0-e3ce-4b4b-9098-5c7bb5e1504f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5e9d633b-42b6-4188-a0b3-3e73ccb1f5c2",
        "planning_id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c",
        "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441"
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
      "id": "5b79ec04-f797-4ca6-906f-f71b2a906f1d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:20+00:00",
        "updated_at": "2022-09-16T12:13:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d6316dc6-bc7f-4d89-b564-526c099ac681",
        "planning_id": "fae3e2cb-d6cf-4eca-a72d-15a6cc1faf1c",
        "order_id": "d7a97595-cebc-4fb3-a4ca-dda24fb6d441"
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
          "order_id": "54fc487a-dc62-41ee-aa78-af864ecf4600",
          "items": [
            {
              "type": "bundles",
              "id": "2c4a845f-20c2-431c-ab99-d0034144c443",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e6631613-289f-4612-bd22-2819c2c7dfd0",
                  "id": "0f28dfbe-1746-4a8b-a2cf-f39c7e619a9b"
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
    "id": "6b83ebd5-58bf-5d37-86ed-472466933ae8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "54fc487a-dc62-41ee-aa78-af864ecf4600"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "54fc487a-dc62-41ee-aa78-af864ecf4600"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d6dc5838-8d04-4e4c-bbdb-62cf7994fb2a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3b9bc999-4eb5-4352-9099-088f9536565e"
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
      "id": "54fc487a-dc62-41ee-aa78-af864ecf4600",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T12:13:23+00:00",
        "updated_at": "2022-09-16T12:13:24+00:00",
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
        "starts_at": "2022-09-14T12:00:00+00:00",
        "stops_at": "2022-09-18T12:00:00+00:00",
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
        "start_location_id": "3a3c0496-d523-4ea9-97ac-05da018dec1b",
        "stop_location_id": "3a3c0496-d523-4ea9-97ac-05da018dec1b"
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
      "id": "d6dc5838-8d04-4e4c-bbdb-62cf7994fb2a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T12:13:24+00:00",
        "updated_at": "2022-09-16T12:13:24+00:00",
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
        "item_id": "2c4a845f-20c2-431c-ab99-d0034144c443",
        "tax_category_id": null,
        "planning_id": "3b9bc999-4eb5-4352-9099-088f9536565e",
        "parent_line_id": null,
        "owner_id": "54fc487a-dc62-41ee-aa78-af864ecf4600",
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
      "id": "3b9bc999-4eb5-4352-9099-088f9536565e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T12:13:24+00:00",
        "updated_at": "2022-09-16T12:13:24+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-14T12:00:00+00:00",
        "stops_at": "2022-09-18T12:00:00+00:00",
        "reserved_from": "2022-09-14T12:00:00+00:00",
        "reserved_till": "2022-09-18T12:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2c4a845f-20c2-431c-ab99-d0034144c443",
        "order_id": "54fc487a-dc62-41ee-aa78-af864ecf4600",
        "start_location_id": "3a3c0496-d523-4ea9-97ac-05da018dec1b",
        "stop_location_id": "3a3c0496-d523-4ea9-97ac-05da018dec1b",
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





