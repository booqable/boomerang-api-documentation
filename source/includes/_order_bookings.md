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
          "order_id": "1c21809d-f6a4-468b-8f06-6657c25b33d6",
          "items": [
            {
              "type": "products",
              "id": "dd44fd9a-7251-4f3a-bec4-189663e0e09e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "18a5eec0-d7af-4796-90af-df4a21fb75c3",
              "stock_item_ids": [
                "70466e91-889e-4074-901a-a99b09c5e643",
                "a866e851-edec-4df1-8cc0-b201d2fa9b5c"
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
          "stock_item_id 70466e91-889e-4074-901a-a99b09c5e643 has already been booked on this order"
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
          "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
          "items": [
            {
              "type": "products",
              "id": "cf76746b-32e1-4151-9564-3f20daf3c65b",
              "stock_item_ids": [
                "0235639f-9d3d-4e6b-b7e9-f136d52828f1",
                "93337ba1-d7b1-4fe8-9a45-84af1999fde4",
                "31090639-fcd7-4ca1-9f92-ae71ab18bfcf"
              ]
            },
            {
              "type": "products",
              "id": "1a68e35a-7547-40fb-a75c-be2734457e8a",
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
    "id": "be3ce75c-330f-50b4-9161-740b5b9bbc28",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "20028def-3d9c-4c1e-a97e-0e40c38633d5"
          },
          {
            "type": "lines",
            "id": "e1d41ca5-cf04-495f-a74e-05f9e6b63070"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f"
          },
          {
            "type": "plannings",
            "id": "919f8957-93d7-44eb-b97e-6673da5248c1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "997d6f05-1508-4749-93a2-bb2afacca832"
          },
          {
            "type": "stock_item_plannings",
            "id": "e6c395f6-e2a9-4692-8f07-b59876602e1f"
          },
          {
            "type": "stock_item_plannings",
            "id": "af34741a-9d87-4cc6-a26b-c8b41aaaa275"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T11:00:26+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
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
        "customer_id": "99e8201c-0191-4e78-9a0a-68f255058836",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4",
        "stop_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4"
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
      "id": "20028def-3d9c-4c1e-a97e-0e40c38633d5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
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
        "item_id": "cf76746b-32e1-4151-9564-3f20daf3c65b",
        "tax_category_id": "9b6ed1c5-f5a9-4d1e-a9bf-a130b24ebb28",
        "planning_id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f",
        "parent_line_id": null,
        "owner_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
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
      "id": "e1d41ca5-cf04-495f-a74e-05f9e6b63070",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
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
        "item_id": "1a68e35a-7547-40fb-a75c-be2734457e8a",
        "tax_category_id": "9b6ed1c5-f5a9-4d1e-a9bf-a130b24ebb28",
        "planning_id": "919f8957-93d7-44eb-b97e-6673da5248c1",
        "parent_line_id": null,
        "owner_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
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
      "id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
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
        "item_id": "cf76746b-32e1-4151-9564-3f20daf3c65b",
        "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
        "start_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4",
        "stop_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4",
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
      "id": "919f8957-93d7-44eb-b97e-6673da5248c1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
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
        "item_id": "1a68e35a-7547-40fb-a75c-be2734457e8a",
        "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e",
        "start_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4",
        "stop_location_id": "1452f8c7-019e-4e7b-bd21-8b56c56ff8f4",
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
      "id": "997d6f05-1508-4749-93a2-bb2afacca832",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0235639f-9d3d-4e6b-b7e9-f136d52828f1",
        "planning_id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f",
        "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e"
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
      "id": "e6c395f6-e2a9-4692-8f07-b59876602e1f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "93337ba1-d7b1-4fe8-9a45-84af1999fde4",
        "planning_id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f",
        "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e"
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
      "id": "af34741a-9d87-4cc6-a26b-c8b41aaaa275",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:27+00:00",
        "updated_at": "2023-02-16T11:00:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "31090639-fcd7-4ca1-9f92-ae71ab18bfcf",
        "planning_id": "b505b609-1df8-44c5-ba8c-dc915b5cc30f",
        "order_id": "c64e9086-55a1-4e96-9ae0-37d33ccf242e"
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
          "order_id": "5aac8b9f-8148-4c48-9de7-5066184781c4",
          "items": [
            {
              "type": "bundles",
              "id": "eea30b43-493c-4253-8056-ad0155db7491",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fbf0e322-d494-4125-93a3-b921b1b7ecb8",
                  "id": "b2e74cd5-7008-4e26-a087-36ee894e0daa"
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
    "id": "038ba22a-9f08-5fec-86fe-aed2416fc325",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5aac8b9f-8148-4c48-9de7-5066184781c4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5aac8b9f-8148-4c48-9de7-5066184781c4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4d4fec8f-cff6-4ae8-93a2-48e1ec63f212"
          },
          {
            "type": "lines",
            "id": "4e0f78fa-1a19-4e8e-93a8-969f2f30cdb8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7430aa15-c7de-4810-8d49-972b594f263b"
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
      "id": "5aac8b9f-8148-4c48-9de7-5066184781c4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T11:00:29+00:00",
        "updated_at": "2023-02-16T11:00:30+00:00",
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
        "starts_at": "2023-02-14T11:00:00+00:00",
        "stops_at": "2023-02-18T11:00:00+00:00",
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
        "start_location_id": "753386f5-4939-45de-9c98-a609af99df81",
        "stop_location_id": "753386f5-4939-45de-9c98-a609af99df81"
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
      "id": "4d4fec8f-cff6-4ae8-93a2-48e1ec63f212",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:00:29+00:00",
        "updated_at": "2023-02-16T11:00:29+00:00",
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
        "item_id": "b2e74cd5-7008-4e26-a087-36ee894e0daa",
        "tax_category_id": null,
        "planning_id": "28756621-d524-41e2-a392-3685e3642fe2",
        "parent_line_id": "4e0f78fa-1a19-4e8e-93a8-969f2f30cdb8",
        "owner_id": "5aac8b9f-8148-4c48-9de7-5066184781c4",
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
      "id": "4e0f78fa-1a19-4e8e-93a8-969f2f30cdb8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:00:29+00:00",
        "updated_at": "2023-02-16T11:00:29+00:00",
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
        "item_id": "eea30b43-493c-4253-8056-ad0155db7491",
        "tax_category_id": null,
        "planning_id": "7430aa15-c7de-4810-8d49-972b594f263b",
        "parent_line_id": null,
        "owner_id": "5aac8b9f-8148-4c48-9de7-5066184781c4",
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
      "id": "7430aa15-c7de-4810-8d49-972b594f263b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:00:29+00:00",
        "updated_at": "2023-02-16T11:00:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T11:00:00+00:00",
        "stops_at": "2023-02-18T11:00:00+00:00",
        "reserved_from": "2023-02-14T11:00:00+00:00",
        "reserved_till": "2023-02-18T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "eea30b43-493c-4253-8056-ad0155db7491",
        "order_id": "5aac8b9f-8148-4c48-9de7-5066184781c4",
        "start_location_id": "753386f5-4939-45de-9c98-a609af99df81",
        "stop_location_id": "753386f5-4939-45de-9c98-a609af99df81",
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





