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
          "order_id": "fa3544d4-fd2b-485a-bdbd-8bb0e6491b4d",
          "items": [
            {
              "type": "products",
              "id": "f1d0f454-630d-4056-83c4-31a7838d9984",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0f989c7e-dd1d-487d-8870-c58b41ce37f2",
              "stock_item_ids": [
                "e1786f81-9f20-4657-9508-8df9b8d01605",
                "fa0ad000-8db1-438b-a92e-ad9a445bd816"
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
            "item_id": "f1d0f454-630d-4056-83c4-31a7838d9984",
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
          "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
          "items": [
            {
              "type": "products",
              "id": "7ac72905-c767-49d5-ab20-faa582ba05c4",
              "stock_item_ids": [
                "c95ab352-c66b-4048-ab7e-baa2177fe100",
                "79ed2ca6-3ef3-4207-8da6-f520ff37be87",
                "26a90836-d69b-42b1-ba5d-3d789b32aa88"
              ]
            },
            {
              "type": "products",
              "id": "1b2a6826-2e83-46e8-a1fc-c519edd2e88e",
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
    "id": "39ff9057-b0e7-523c-ab26-c7b48e53ca72",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7e45d1e9-7154-4411-92b5-7a05adc398e5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e89402fc-0d74-4989-b61a-d0f500f33da0"
          },
          {
            "type": "lines",
            "id": "a31138f7-f879-4548-872e-ce42abd2fa34"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8"
          },
          {
            "type": "plannings",
            "id": "3d638393-5e41-4106-a286-a25559a8fba2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b38ae31c-3a4c-4ec7-a130-e80c4ffc0a3c"
          },
          {
            "type": "stock_item_plannings",
            "id": "040a307a-4153-407e-a50d-2abaa2aa4572"
          },
          {
            "type": "stock_item_plannings",
            "id": "e334e49c-2453-4a74-a8b8-59826ca47f23"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T11:04:07+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
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
        "customer_id": "29fe0567-4970-4c3a-9b6d-3338beac3895",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc",
        "stop_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc"
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
      "id": "e89402fc-0d74-4989-b61a-d0f500f33da0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
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
        "item_id": "7ac72905-c767-49d5-ab20-faa582ba05c4",
        "tax_category_id": "1735610a-8442-491b-a5d7-db58adda6c1f",
        "planning_id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8",
        "parent_line_id": null,
        "owner_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
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
      "id": "a31138f7-f879-4548-872e-ce42abd2fa34",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
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
        "item_id": "1b2a6826-2e83-46e8-a1fc-c519edd2e88e",
        "tax_category_id": "1735610a-8442-491b-a5d7-db58adda6c1f",
        "planning_id": "3d638393-5e41-4106-a286-a25559a8fba2",
        "parent_line_id": null,
        "owner_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
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
      "id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
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
        "item_id": "7ac72905-c767-49d5-ab20-faa582ba05c4",
        "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
        "start_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc",
        "stop_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc",
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
      "id": "3d638393-5e41-4106-a286-a25559a8fba2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
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
        "item_id": "1b2a6826-2e83-46e8-a1fc-c519edd2e88e",
        "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5",
        "start_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc",
        "stop_location_id": "59f85132-b3f6-497f-b8b9-bc6c17f956fc",
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
      "id": "b38ae31c-3a4c-4ec7-a130-e80c4ffc0a3c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c95ab352-c66b-4048-ab7e-baa2177fe100",
        "planning_id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8",
        "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5"
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
      "id": "040a307a-4153-407e-a50d-2abaa2aa4572",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "79ed2ca6-3ef3-4207-8da6-f520ff37be87",
        "planning_id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8",
        "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5"
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
      "id": "e334e49c-2453-4a74-a8b8-59826ca47f23",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:08+00:00",
        "updated_at": "2023-01-05T11:04:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "26a90836-d69b-42b1-ba5d-3d789b32aa88",
        "planning_id": "e2cf154b-cfcc-4305-aa05-ed863030cdd8",
        "order_id": "7e45d1e9-7154-4411-92b5-7a05adc398e5"
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
          "order_id": "00cad82f-4346-4885-b22e-2f520cdd05bf",
          "items": [
            {
              "type": "bundles",
              "id": "fea9f4da-41ca-4c06-bd6c-f5448a0fdea4",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "068e939a-8451-490b-be30-c57f56c08603",
                  "id": "0e1d1539-259a-47fe-806b-c8fbcf4ef1fa"
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
    "id": "a476b47e-0f4c-576b-99bf-dc316373f1c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "00cad82f-4346-4885-b22e-2f520cdd05bf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "00cad82f-4346-4885-b22e-2f520cdd05bf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "297c3d8f-bb98-4638-be7f-bd5a6b93c7df"
          },
          {
            "type": "lines",
            "id": "80e09735-9fe5-4229-8515-565cf90a9846"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1a690031-5a85-4151-87c9-8db3cabf79f9"
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
      "id": "00cad82f-4346-4885-b22e-2f520cdd05bf",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T11:04:10+00:00",
        "updated_at": "2023-01-05T11:04:11+00:00",
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
        "starts_at": "2023-01-03T11:00:00+00:00",
        "stops_at": "2023-01-07T11:00:00+00:00",
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
        "start_location_id": "4136e8c5-f97b-49ee-b54a-31072e632e7b",
        "stop_location_id": "4136e8c5-f97b-49ee-b54a-31072e632e7b"
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
      "id": "297c3d8f-bb98-4638-be7f-bd5a6b93c7df",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:04:10+00:00",
        "updated_at": "2023-01-05T11:04:10+00:00",
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
        "item_id": "fea9f4da-41ca-4c06-bd6c-f5448a0fdea4",
        "tax_category_id": null,
        "planning_id": "1a690031-5a85-4151-87c9-8db3cabf79f9",
        "parent_line_id": null,
        "owner_id": "00cad82f-4346-4885-b22e-2f520cdd05bf",
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
      "id": "80e09735-9fe5-4229-8515-565cf90a9846",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:04:10+00:00",
        "updated_at": "2023-01-05T11:04:10+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 9 - red",
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
        "item_id": "0e1d1539-259a-47fe-806b-c8fbcf4ef1fa",
        "tax_category_id": null,
        "planning_id": "f0919b03-95cc-43c5-afd1-3c69691e6b26",
        "parent_line_id": "297c3d8f-bb98-4638-be7f-bd5a6b93c7df",
        "owner_id": "00cad82f-4346-4885-b22e-2f520cdd05bf",
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
      "id": "1a690031-5a85-4151-87c9-8db3cabf79f9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:04:10+00:00",
        "updated_at": "2023-01-05T11:04:10+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T11:00:00+00:00",
        "stops_at": "2023-01-07T11:00:00+00:00",
        "reserved_from": "2023-01-03T11:00:00+00:00",
        "reserved_till": "2023-01-07T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "fea9f4da-41ca-4c06-bd6c-f5448a0fdea4",
        "order_id": "00cad82f-4346-4885-b22e-2f520cdd05bf",
        "start_location_id": "4136e8c5-f97b-49ee-b54a-31072e632e7b",
        "stop_location_id": "4136e8c5-f97b-49ee-b54a-31072e632e7b",
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





