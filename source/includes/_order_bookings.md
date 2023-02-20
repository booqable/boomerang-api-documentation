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
          "order_id": "b3749d01-4d24-4baa-953c-3bf4d4202e3d",
          "items": [
            {
              "type": "products",
              "id": "a0e8819e-f81c-41e0-9a4e-4f01bd800719",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "294d4841-f216-4903-bd6a-8a244fe5b74a",
              "stock_item_ids": [
                "e2d1b760-88dd-4d6c-9ddb-9ee1bb515203",
                "1504b27f-6f79-45f5-9f1b-5e3f8f51f032"
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
          "stock_item_id e2d1b760-88dd-4d6c-9ddb-9ee1bb515203 has already been booked on this order"
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
          "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
          "items": [
            {
              "type": "products",
              "id": "50369aa1-c955-408b-8e07-28db18a58a54",
              "stock_item_ids": [
                "40d53c4c-d830-4c33-a968-12b47145b8db",
                "1dfd084d-4336-4c7d-b437-68d74feed7f9",
                "52df3002-a6dd-40dc-9b74-015aaa4b1bb8"
              ]
            },
            {
              "type": "products",
              "id": "45db6d52-d8b6-418c-8438-098131ac5291",
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
    "id": "014bb005-2c79-533f-9247-0e47e2a5a3f3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "86f58e61-b1fb-4411-a351-eaae919b8bf3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2981238d-63ef-40bf-b54c-1826f319e307"
          },
          {
            "type": "lines",
            "id": "c94dc78e-792a-4d45-85a0-59aeb6b0ae67"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9980e0d3-6e5c-4809-9c79-3160dc87c444"
          },
          {
            "type": "plannings",
            "id": "d8feddb5-8a95-4099-b171-ac63a6adb67e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8823c5d1-d68b-4557-a8f4-2a68f8cc188f"
          },
          {
            "type": "stock_item_plannings",
            "id": "3f1c781e-8857-436f-a74a-ff1fb3249134"
          },
          {
            "type": "stock_item_plannings",
            "id": "37375cbd-1d55-416e-b8a1-c2e8f5b3988d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-20T10:24:37+00:00",
        "updated_at": "2023-02-20T10:24:39+00:00",
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
        "customer_id": "c46f4478-53c0-4870-aeef-0e6de04764cf",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5",
        "stop_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5"
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
      "id": "2981238d-63ef-40bf-b54c-1826f319e307",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
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
        "item_id": "50369aa1-c955-408b-8e07-28db18a58a54",
        "tax_category_id": "401d3940-36ad-483b-bf99-b520718658e0",
        "planning_id": "9980e0d3-6e5c-4809-9c79-3160dc87c444",
        "parent_line_id": null,
        "owner_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
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
      "id": "c94dc78e-792a-4d45-85a0-59aeb6b0ae67",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
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
        "item_id": "45db6d52-d8b6-418c-8438-098131ac5291",
        "tax_category_id": "401d3940-36ad-483b-bf99-b520718658e0",
        "planning_id": "d8feddb5-8a95-4099-b171-ac63a6adb67e",
        "parent_line_id": null,
        "owner_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
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
      "id": "9980e0d3-6e5c-4809-9c79-3160dc87c444",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
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
        "item_id": "50369aa1-c955-408b-8e07-28db18a58a54",
        "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
        "start_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5",
        "stop_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5",
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
      "id": "d8feddb5-8a95-4099-b171-ac63a6adb67e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
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
        "item_id": "45db6d52-d8b6-418c-8438-098131ac5291",
        "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3",
        "start_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5",
        "stop_location_id": "91944d79-0f5d-40e3-87c0-8c10e811e6c5",
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
      "id": "8823c5d1-d68b-4557-a8f4-2a68f8cc188f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "40d53c4c-d830-4c33-a968-12b47145b8db",
        "planning_id": "9980e0d3-6e5c-4809-9c79-3160dc87c444",
        "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3"
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
      "id": "3f1c781e-8857-436f-a74a-ff1fb3249134",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1dfd084d-4336-4c7d-b437-68d74feed7f9",
        "planning_id": "9980e0d3-6e5c-4809-9c79-3160dc87c444",
        "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3"
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
      "id": "37375cbd-1d55-416e-b8a1-c2e8f5b3988d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:38+00:00",
        "updated_at": "2023-02-20T10:24:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "52df3002-a6dd-40dc-9b74-015aaa4b1bb8",
        "planning_id": "9980e0d3-6e5c-4809-9c79-3160dc87c444",
        "order_id": "86f58e61-b1fb-4411-a351-eaae919b8bf3"
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
          "order_id": "d48effc5-0b68-4a2d-9836-76928458d399",
          "items": [
            {
              "type": "bundles",
              "id": "cba9bc14-246d-4180-8677-ca5bfca20689",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9d829a74-df78-4660-aa22-951bfd571841",
                  "id": "2c3a3fe3-0c91-43ac-a7ac-bf79a96afb2d"
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
    "id": "c24f9a6a-7d8f-5b38-9223-e4aac0cada97",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d48effc5-0b68-4a2d-9836-76928458d399"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d48effc5-0b68-4a2d-9836-76928458d399"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f5496d09-995c-44fe-be0b-a03823da93e4"
          },
          {
            "type": "lines",
            "id": "79a5b476-a5ef-4900-9392-70bd8fd854d1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "112ebd68-c6a4-47a0-aecb-d27da30a51c5"
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
      "id": "d48effc5-0b68-4a2d-9836-76928458d399",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-20T10:24:41+00:00",
        "updated_at": "2023-02-20T10:24:42+00:00",
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
        "starts_at": "2023-02-18T10:15:00+00:00",
        "stops_at": "2023-02-22T10:15:00+00:00",
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
        "start_location_id": "2a057390-598a-4abc-b60a-37f3603aa87f",
        "stop_location_id": "2a057390-598a-4abc-b60a-37f3603aa87f"
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
      "id": "f5496d09-995c-44fe-be0b-a03823da93e4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T10:24:41+00:00",
        "updated_at": "2023-02-20T10:24:41+00:00",
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
        "item_id": "2c3a3fe3-0c91-43ac-a7ac-bf79a96afb2d",
        "tax_category_id": null,
        "planning_id": "07d72779-770c-4f06-80a3-c2c61057f1e0",
        "parent_line_id": "79a5b476-a5ef-4900-9392-70bd8fd854d1",
        "owner_id": "d48effc5-0b68-4a2d-9836-76928458d399",
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
      "id": "79a5b476-a5ef-4900-9392-70bd8fd854d1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T10:24:41+00:00",
        "updated_at": "2023-02-20T10:24:41+00:00",
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
        "item_id": "cba9bc14-246d-4180-8677-ca5bfca20689",
        "tax_category_id": null,
        "planning_id": "112ebd68-c6a4-47a0-aecb-d27da30a51c5",
        "parent_line_id": null,
        "owner_id": "d48effc5-0b68-4a2d-9836-76928458d399",
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
      "id": "112ebd68-c6a4-47a0-aecb-d27da30a51c5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T10:24:41+00:00",
        "updated_at": "2023-02-20T10:24:41+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-18T10:15:00+00:00",
        "stops_at": "2023-02-22T10:15:00+00:00",
        "reserved_from": "2023-02-18T10:15:00+00:00",
        "reserved_till": "2023-02-22T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cba9bc14-246d-4180-8677-ca5bfca20689",
        "order_id": "d48effc5-0b68-4a2d-9836-76928458d399",
        "start_location_id": "2a057390-598a-4abc-b60a-37f3603aa87f",
        "stop_location_id": "2a057390-598a-4abc-b60a-37f3603aa87f",
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





