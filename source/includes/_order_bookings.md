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
          "order_id": "dd28742a-3031-4175-abee-b91b6d535d67",
          "items": [
            {
              "type": "products",
              "id": "0b2cd198-5c72-4c52-92e7-cc7d5dcb3f97",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1c1188b2-5535-4bdc-bcd2-1f7fa5a639b7",
              "stock_item_ids": [
                "4a1a5e71-3d68-4180-ab3e-45bbc366b689",
                "33d02508-e22f-46d4-9227-7327fc941e79"
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
            "item_id": "0b2cd198-5c72-4c52-92e7-cc7d5dcb3f97",
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
          "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
          "items": [
            {
              "type": "products",
              "id": "e787dbd0-1c25-4e01-ad5a-e237f721356b",
              "stock_item_ids": [
                "eeff048e-5f9d-4336-afca-42b7d976f3ef",
                "f0e22e61-6661-4b50-93e2-8dd8ce52a15b",
                "c1ef6449-51e7-4d78-bbde-b397d4eab864"
              ]
            },
            {
              "type": "products",
              "id": "90d1dc81-ab5b-427c-8106-3119e9c84d71",
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
    "id": "6ad57bb5-8808-5f8d-996e-3a6065a2807e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e06230cc-22a6-4ecc-83c2-d105322a099c"
          },
          {
            "type": "lines",
            "id": "96edb54c-1555-4148-b1bb-14c6d1d53de1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f20cccc6-2595-48e4-a308-ae5e8214f667"
          },
          {
            "type": "plannings",
            "id": "d4da800a-864a-4ec1-89de-a92619afc78c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b315236d-cd51-4f97-b783-0eab43e35046"
          },
          {
            "type": "stock_item_plannings",
            "id": "55d11800-c88e-4a19-8ddf-cf165441f07c"
          },
          {
            "type": "stock_item_plannings",
            "id": "7c1a609a-5d6d-4ed7-b0d4-76454703aa85"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:24:55+00:00",
        "updated_at": "2022-05-24T07:24:57+00:00",
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
        "customer_id": "d5da9fa9-3ae8-4896-a668-303ff8558378",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2",
        "stop_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2"
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
      "id": "e06230cc-22a6-4ecc-83c2-d105322a099c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:24:55+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
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
        "item_id": "90d1dc81-ab5b-427c-8106-3119e9c84d71",
        "tax_category_id": "06b0e06c-6d8c-4361-8c1c-ee4cdfd4b6af",
        "planning_id": "f20cccc6-2595-48e4-a308-ae5e8214f667",
        "parent_line_id": null,
        "owner_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
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
      "id": "96edb54c-1555-4148-b1bb-14c6d1d53de1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:24:56+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
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
        "item_id": "e787dbd0-1c25-4e01-ad5a-e237f721356b",
        "tax_category_id": "06b0e06c-6d8c-4361-8c1c-ee4cdfd4b6af",
        "planning_id": "d4da800a-864a-4ec1-89de-a92619afc78c",
        "parent_line_id": null,
        "owner_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
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
      "id": "f20cccc6-2595-48e4-a308-ae5e8214f667",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:55+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
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
        "item_id": "90d1dc81-ab5b-427c-8106-3119e9c84d71",
        "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
        "start_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2",
        "stop_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2",
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
      "id": "d4da800a-864a-4ec1-89de-a92619afc78c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:56+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
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
        "item_id": "e787dbd0-1c25-4e01-ad5a-e237f721356b",
        "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c",
        "start_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2",
        "stop_location_id": "1364a7c6-8396-481e-a794-837c5a28aac2",
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
      "id": "b315236d-cd51-4f97-b783-0eab43e35046",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:56+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eeff048e-5f9d-4336-afca-42b7d976f3ef",
        "planning_id": "d4da800a-864a-4ec1-89de-a92619afc78c",
        "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c"
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
      "id": "55d11800-c88e-4a19-8ddf-cf165441f07c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:56+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f0e22e61-6661-4b50-93e2-8dd8ce52a15b",
        "planning_id": "d4da800a-864a-4ec1-89de-a92619afc78c",
        "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c"
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
      "id": "7c1a609a-5d6d-4ed7-b0d4-76454703aa85",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:56+00:00",
        "updated_at": "2022-05-24T07:24:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c1ef6449-51e7-4d78-bbde-b397d4eab864",
        "planning_id": "d4da800a-864a-4ec1-89de-a92619afc78c",
        "order_id": "1f6488d9-fe7f-4ddd-9269-4f2d5032668c"
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
          "order_id": "927786e0-c445-423a-b30b-e66df3a6ae77",
          "items": [
            {
              "type": "bundles",
              "id": "1f380b9b-3711-4d0d-92d8-54320db81322",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "08fa0540-f4fa-428a-aef5-ce16af2cccf7",
                  "id": "e44f6997-bb69-43fd-b82d-fdd468ca9a39"
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
    "id": "487d7d40-300c-5c6c-bc18-6f92e53b4d0c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "927786e0-c445-423a-b30b-e66df3a6ae77"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "927786e0-c445-423a-b30b-e66df3a6ae77"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6cffacfd-cb98-4d25-a2f0-4866554c9f6d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "523cbf11-e90c-4ff3-8c9e-3057dfa56199"
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
      "id": "927786e0-c445-423a-b30b-e66df3a6ae77",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:24:58+00:00",
        "updated_at": "2022-05-24T07:24:59+00:00",
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
        "starts_at": "2022-05-22T07:15:00+00:00",
        "stops_at": "2022-05-26T07:15:00+00:00",
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
        "start_location_id": "974b51ab-8f3e-42a8-b452-ed7a8102c2e0",
        "stop_location_id": "974b51ab-8f3e-42a8-b452-ed7a8102c2e0"
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
      "id": "6cffacfd-cb98-4d25-a2f0-4866554c9f6d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:24:59+00:00",
        "updated_at": "2022-05-24T07:24:59+00:00",
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
        "item_id": "1f380b9b-3711-4d0d-92d8-54320db81322",
        "tax_category_id": null,
        "planning_id": "523cbf11-e90c-4ff3-8c9e-3057dfa56199",
        "parent_line_id": null,
        "owner_id": "927786e0-c445-423a-b30b-e66df3a6ae77",
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
      "id": "523cbf11-e90c-4ff3-8c9e-3057dfa56199",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:24:59+00:00",
        "updated_at": "2022-05-24T07:24:59+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-22T07:15:00+00:00",
        "stops_at": "2022-05-26T07:15:00+00:00",
        "reserved_from": "2022-05-22T07:15:00+00:00",
        "reserved_till": "2022-05-26T07:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1f380b9b-3711-4d0d-92d8-54320db81322",
        "order_id": "927786e0-c445-423a-b30b-e66df3a6ae77",
        "start_location_id": "974b51ab-8f3e-42a8-b452-ed7a8102c2e0",
        "stop_location_id": "974b51ab-8f3e-42a8-b452-ed7a8102c2e0",
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





