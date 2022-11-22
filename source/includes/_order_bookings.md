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
          "order_id": "4f6f0626-10c2-4433-a80d-b35e64bfacee",
          "items": [
            {
              "type": "products",
              "id": "3e2640d4-74de-45e5-8832-48ebe3c16619",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f0a4dae8-d58e-4060-b494-69f3b49857aa",
              "stock_item_ids": [
                "0419004e-0828-4167-8528-6eb1ad38557e",
                "ac45ec9e-cc16-4e52-a175-fd2e78dd0372"
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
            "item_id": "3e2640d4-74de-45e5-8832-48ebe3c16619",
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
          "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
          "items": [
            {
              "type": "products",
              "id": "3444f90c-33c3-4150-8bb5-c6135922f23e",
              "stock_item_ids": [
                "fb03c433-46b7-4ca3-b220-2c537bb703b7",
                "80ffcb55-3d1a-4ba4-b6cb-17f96f3423d6",
                "a141f6b7-334d-4d8b-8a77-b261e71eec36"
              ]
            },
            {
              "type": "products",
              "id": "b392b1a3-9470-40c7-9739-2c420e290b4f",
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
    "id": "9cb3c9aa-9f18-56ca-a998-94708eb7a8bb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1ef23c9c-2190-4feb-8a6e-f5e0811e4cbf"
          },
          {
            "type": "lines",
            "id": "94a279d0-d1c2-4095-bea0-125011f94e9d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ec609786-5878-43d1-9fab-de338c1cdce3"
          },
          {
            "type": "plannings",
            "id": "77a0363b-4d57-46c9-bd3d-ff061b8448ef"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8fad37cf-2288-4e4d-b8a5-2eef1d4d7cd7"
          },
          {
            "type": "stock_item_plannings",
            "id": "743bcb68-34f0-491e-8cce-85b077056327"
          },
          {
            "type": "stock_item_plannings",
            "id": "6d1b6ad6-1236-49ac-b0ae-9bafbeec5ebe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T15:51:18+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
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
        "customer_id": "f0632847-db3e-4553-b9ed-c1be2ab548c9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb",
        "stop_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb"
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
      "id": "1ef23c9c-2190-4feb-8a6e-f5e0811e4cbf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
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
        "item_id": "3444f90c-33c3-4150-8bb5-c6135922f23e",
        "tax_category_id": "b2c63036-9ca0-40ae-a41a-85ca006b658f",
        "planning_id": "ec609786-5878-43d1-9fab-de338c1cdce3",
        "parent_line_id": null,
        "owner_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
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
      "id": "94a279d0-d1c2-4095-bea0-125011f94e9d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
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
        "item_id": "b392b1a3-9470-40c7-9739-2c420e290b4f",
        "tax_category_id": "b2c63036-9ca0-40ae-a41a-85ca006b658f",
        "planning_id": "77a0363b-4d57-46c9-bd3d-ff061b8448ef",
        "parent_line_id": null,
        "owner_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
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
      "id": "ec609786-5878-43d1-9fab-de338c1cdce3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
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
        "item_id": "3444f90c-33c3-4150-8bb5-c6135922f23e",
        "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
        "start_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb",
        "stop_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb",
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
      "id": "77a0363b-4d57-46c9-bd3d-ff061b8448ef",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
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
        "item_id": "b392b1a3-9470-40c7-9739-2c420e290b4f",
        "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e",
        "start_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb",
        "stop_location_id": "003e1818-99b4-47b4-8cab-0279b39befcb",
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
      "id": "8fad37cf-2288-4e4d-b8a5-2eef1d4d7cd7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fb03c433-46b7-4ca3-b220-2c537bb703b7",
        "planning_id": "ec609786-5878-43d1-9fab-de338c1cdce3",
        "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e"
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
      "id": "743bcb68-34f0-491e-8cce-85b077056327",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "80ffcb55-3d1a-4ba4-b6cb-17f96f3423d6",
        "planning_id": "ec609786-5878-43d1-9fab-de338c1cdce3",
        "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e"
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
      "id": "6d1b6ad6-1236-49ac-b0ae-9bafbeec5ebe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:20+00:00",
        "updated_at": "2022-11-22T15:51:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a141f6b7-334d-4d8b-8a77-b261e71eec36",
        "planning_id": "ec609786-5878-43d1-9fab-de338c1cdce3",
        "order_id": "ec67bdc2-4be1-4fdb-91c4-650fac279f5e"
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
          "order_id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c",
          "items": [
            {
              "type": "bundles",
              "id": "8974fd40-d7e1-4ed2-89f6-0b331ab3f394",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b1a9ea3d-95ad-48e9-a456-e90449d7cb57",
                  "id": "8118f9f6-f25a-4434-8d54-f480c8f168d7"
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
    "id": "97a7584b-b336-54e5-8748-d425a9cee323",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9ba84c33-4ba1-4dce-b3cb-00148f418e05"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "88f2e793-d6b4-4e84-be56-1dfb4bd4bd5c"
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
      "id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T15:51:22+00:00",
        "updated_at": "2022-11-22T15:51:23+00:00",
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
        "starts_at": "2022-11-20T15:45:00+00:00",
        "stops_at": "2022-11-24T15:45:00+00:00",
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
        "start_location_id": "c055e80d-c7f1-4f68-9f0a-2958a2768076",
        "stop_location_id": "c055e80d-c7f1-4f68-9f0a-2958a2768076"
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
      "id": "9ba84c33-4ba1-4dce-b3cb-00148f418e05",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:51:23+00:00",
        "updated_at": "2022-11-22T15:51:23+00:00",
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
        "item_id": "8974fd40-d7e1-4ed2-89f6-0b331ab3f394",
        "tax_category_id": null,
        "planning_id": "88f2e793-d6b4-4e84-be56-1dfb4bd4bd5c",
        "parent_line_id": null,
        "owner_id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c",
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
      "id": "88f2e793-d6b4-4e84-be56-1dfb4bd4bd5c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:51:22+00:00",
        "updated_at": "2022-11-22T15:51:22+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T15:45:00+00:00",
        "stops_at": "2022-11-24T15:45:00+00:00",
        "reserved_from": "2022-11-20T15:45:00+00:00",
        "reserved_till": "2022-11-24T15:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8974fd40-d7e1-4ed2-89f6-0b331ab3f394",
        "order_id": "8c2da3f5-2846-4e3c-afbb-5002ad2ab92c",
        "start_location_id": "c055e80d-c7f1-4f68-9f0a-2958a2768076",
        "stop_location_id": "c055e80d-c7f1-4f68-9f0a-2958a2768076",
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





