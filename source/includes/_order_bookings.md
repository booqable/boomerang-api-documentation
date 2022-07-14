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
          "order_id": "0eb97b57-a1fb-44bd-843d-010ea5373dd5",
          "items": [
            {
              "type": "products",
              "id": "725139ec-8f3e-4fd9-95b7-2f92241eb825",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c29b5f32-691a-4103-9904-36441a961dbc",
              "stock_item_ids": [
                "49b64ee7-8fb1-403c-a81f-91f4c39060cc",
                "62ca3ece-af48-4d5d-93a4-079ccba5c92f"
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
            "item_id": "725139ec-8f3e-4fd9-95b7-2f92241eb825",
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
          "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
          "items": [
            {
              "type": "products",
              "id": "2c853e1f-ab87-41b8-98ef-65eabb948993",
              "stock_item_ids": [
                "1c2e8b9a-e4ba-4c6a-9423-612e1801bde5",
                "a4bfe798-abea-4989-85f8-93d49ea0e838",
                "dc4c4dde-7704-442c-bb8f-6ead9bed4428"
              ]
            },
            {
              "type": "products",
              "id": "59145b5f-4e72-4de8-b1c3-53bd9f1bf7e5",
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
    "id": "f5106aca-2c9c-5df9-95c1-3466c68f7d4b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a714de43-2f83-4a3a-a4a4-c8172509f67d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6e595d7f-664c-4059-b057-cbbaad0b219b"
          },
          {
            "type": "lines",
            "id": "be48c74e-8e68-4951-9473-c3d06491f6a2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "592f0bb5-dd13-4eac-a5cf-ef85435da19b"
          },
          {
            "type": "plannings",
            "id": "61d94f93-16e2-4958-9b64-8cf5cf76d881"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "73805784-f700-456d-bcc1-e667f9b4d0a7"
          },
          {
            "type": "stock_item_plannings",
            "id": "7cfddc40-f7b2-4154-aebe-8daadb9ff76d"
          },
          {
            "type": "stock_item_plannings",
            "id": "f548be7d-247c-40af-aeb0-34fc89dd52e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T10:50:33+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
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
        "customer_id": "dd83a90d-e524-4e79-8dd9-9dfeb9e8a057",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db",
        "stop_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db"
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
      "id": "6e595d7f-664c-4059-b057-cbbaad0b219b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:50:34+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
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
        "item_id": "59145b5f-4e72-4de8-b1c3-53bd9f1bf7e5",
        "tax_category_id": "5946552d-b2ec-4d40-a87c-9f61522fafda",
        "planning_id": "592f0bb5-dd13-4eac-a5cf-ef85435da19b",
        "parent_line_id": null,
        "owner_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
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
      "id": "be48c74e-8e68-4951-9473-c3d06491f6a2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:50:36+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
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
        "item_id": "2c853e1f-ab87-41b8-98ef-65eabb948993",
        "tax_category_id": "5946552d-b2ec-4d40-a87c-9f61522fafda",
        "planning_id": "61d94f93-16e2-4958-9b64-8cf5cf76d881",
        "parent_line_id": null,
        "owner_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
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
      "id": "592f0bb5-dd13-4eac-a5cf-ef85435da19b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:34+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
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
        "item_id": "59145b5f-4e72-4de8-b1c3-53bd9f1bf7e5",
        "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
        "start_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db",
        "stop_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db",
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
      "id": "61d94f93-16e2-4958-9b64-8cf5cf76d881",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:35+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
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
        "item_id": "2c853e1f-ab87-41b8-98ef-65eabb948993",
        "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d",
        "start_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db",
        "stop_location_id": "002fc615-3aee-43fc-91a4-6281cad6e3db",
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
      "id": "73805784-f700-456d-bcc1-e667f9b4d0a7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:35+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1c2e8b9a-e4ba-4c6a-9423-612e1801bde5",
        "planning_id": "61d94f93-16e2-4958-9b64-8cf5cf76d881",
        "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d"
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
      "id": "7cfddc40-f7b2-4154-aebe-8daadb9ff76d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:35+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a4bfe798-abea-4989-85f8-93d49ea0e838",
        "planning_id": "61d94f93-16e2-4958-9b64-8cf5cf76d881",
        "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d"
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
      "id": "f548be7d-247c-40af-aeb0-34fc89dd52e3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:35+00:00",
        "updated_at": "2022-07-14T10:50:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dc4c4dde-7704-442c-bb8f-6ead9bed4428",
        "planning_id": "61d94f93-16e2-4958-9b64-8cf5cf76d881",
        "order_id": "a714de43-2f83-4a3a-a4a4-c8172509f67d"
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
          "order_id": "ad06a90e-7317-4325-94bb-5815662f483f",
          "items": [
            {
              "type": "bundles",
              "id": "e53c6386-ec86-4518-84c5-b04eec44423c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "08c5717c-fe5c-46d4-a5f3-46f35830df14",
                  "id": "e53ae17f-b638-43cb-901e-1e2337f3892d"
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
    "id": "f53dff2a-745b-5494-a219-d60793efd123",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ad06a90e-7317-4325-94bb-5815662f483f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ad06a90e-7317-4325-94bb-5815662f483f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dba094de-3a6a-497a-845f-39a2b4de13a6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "64b3f3a6-99e3-4296-b3a9-51cc16acf217"
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
      "id": "ad06a90e-7317-4325-94bb-5815662f483f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T10:50:39+00:00",
        "updated_at": "2022-07-14T10:50:40+00:00",
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
        "starts_at": "2022-07-12T10:45:00+00:00",
        "stops_at": "2022-07-16T10:45:00+00:00",
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
        "start_location_id": "bd9281a4-aee2-49de-a220-4effdd6777c4",
        "stop_location_id": "bd9281a4-aee2-49de-a220-4effdd6777c4"
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
      "id": "dba094de-3a6a-497a-845f-39a2b4de13a6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:50:40+00:00",
        "updated_at": "2022-07-14T10:50:40+00:00",
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
        "item_id": "e53c6386-ec86-4518-84c5-b04eec44423c",
        "tax_category_id": null,
        "planning_id": "64b3f3a6-99e3-4296-b3a9-51cc16acf217",
        "parent_line_id": null,
        "owner_id": "ad06a90e-7317-4325-94bb-5815662f483f",
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
      "id": "64b3f3a6-99e3-4296-b3a9-51cc16acf217",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:50:40+00:00",
        "updated_at": "2022-07-14T10:50:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T10:45:00+00:00",
        "stops_at": "2022-07-16T10:45:00+00:00",
        "reserved_from": "2022-07-12T10:45:00+00:00",
        "reserved_till": "2022-07-16T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e53c6386-ec86-4518-84c5-b04eec44423c",
        "order_id": "ad06a90e-7317-4325-94bb-5815662f483f",
        "start_location_id": "bd9281a4-aee2-49de-a220-4effdd6777c4",
        "stop_location_id": "bd9281a4-aee2-49de-a220-4effdd6777c4",
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





