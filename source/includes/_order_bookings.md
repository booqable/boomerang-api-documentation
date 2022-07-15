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
          "order_id": "6bf7da23-58ae-411e-b7f8-f5631e26a1e4",
          "items": [
            {
              "type": "products",
              "id": "a673670b-7173-4982-99fd-301a204315a1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1406b0eb-107a-4ab2-a163-d604affada2c",
              "stock_item_ids": [
                "33335788-7a64-4233-95f1-c4a39c282d3c",
                "deeb720a-3f9c-40ce-9f61-f24df8b73360"
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
            "item_id": "a673670b-7173-4982-99fd-301a204315a1",
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
          "order_id": "36219d96-bc25-4708-a299-5b8757f01821",
          "items": [
            {
              "type": "products",
              "id": "f9d7416c-60b3-4b00-8553-1a2dda48727f",
              "stock_item_ids": [
                "a5a57af6-3376-4d09-870f-94150de96973",
                "0d3c898a-d8b2-4ab4-aa5c-d117fa372e6f",
                "edb8c37d-fea7-4d6d-af04-8e2881a0bf8f"
              ]
            },
            {
              "type": "products",
              "id": "cc23341c-14a7-4b17-bcb4-f9fab1450918",
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
    "id": "87ad5131-850d-55d7-b174-3e4febd17eae",
    "type": "order_bookings",
    "attributes": {
      "order_id": "36219d96-bc25-4708-a299-5b8757f01821"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "36219d96-bc25-4708-a299-5b8757f01821"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0dccb177-43c3-4685-ba61-93822b12009b"
          },
          {
            "type": "lines",
            "id": "ea907070-98e4-4826-a5a7-884a7ac2f60d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5e0dc6f0-a298-41ee-94be-002dde951ded"
          },
          {
            "type": "plannings",
            "id": "e4630604-84ad-4b26-8595-a0ebd8004749"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "109bd412-3d19-460f-88bd-02ff642f03b5"
          },
          {
            "type": "stock_item_plannings",
            "id": "15711f92-3bd5-4eea-bf09-5d2b846867f0"
          },
          {
            "type": "stock_item_plannings",
            "id": "875160db-4b4c-4348-a310-99ce23a5cba3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "36219d96-bc25-4708-a299-5b8757f01821",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-15T09:25:07+00:00",
        "updated_at": "2022-07-15T09:25:10+00:00",
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
        "customer_id": "849d46a9-f635-4634-9de8-9a6e1e9eb972",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6",
        "stop_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6"
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
      "id": "0dccb177-43c3-4685-ba61-93822b12009b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:25:08+00:00",
        "updated_at": "2022-07-15T09:25:09+00:00",
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
        "item_id": "cc23341c-14a7-4b17-bcb4-f9fab1450918",
        "tax_category_id": "95b560be-7428-4be9-b188-d4ae7d498788",
        "planning_id": "5e0dc6f0-a298-41ee-94be-002dde951ded",
        "parent_line_id": null,
        "owner_id": "36219d96-bc25-4708-a299-5b8757f01821",
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
      "id": "ea907070-98e4-4826-a5a7-884a7ac2f60d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:25:09+00:00",
        "updated_at": "2022-07-15T09:25:09+00:00",
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
        "item_id": "f9d7416c-60b3-4b00-8553-1a2dda48727f",
        "tax_category_id": "95b560be-7428-4be9-b188-d4ae7d498788",
        "planning_id": "e4630604-84ad-4b26-8595-a0ebd8004749",
        "parent_line_id": null,
        "owner_id": "36219d96-bc25-4708-a299-5b8757f01821",
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
      "id": "5e0dc6f0-a298-41ee-94be-002dde951ded",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:08+00:00",
        "updated_at": "2022-07-15T09:25:10+00:00",
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
        "item_id": "cc23341c-14a7-4b17-bcb4-f9fab1450918",
        "order_id": "36219d96-bc25-4708-a299-5b8757f01821",
        "start_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6",
        "stop_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6",
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
      "id": "e4630604-84ad-4b26-8595-a0ebd8004749",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:09+00:00",
        "updated_at": "2022-07-15T09:25:10+00:00",
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
        "item_id": "f9d7416c-60b3-4b00-8553-1a2dda48727f",
        "order_id": "36219d96-bc25-4708-a299-5b8757f01821",
        "start_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6",
        "stop_location_id": "25d33c7b-9687-451d-8975-9c3c660831f6",
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
      "id": "109bd412-3d19-460f-88bd-02ff642f03b5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:09+00:00",
        "updated_at": "2022-07-15T09:25:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a5a57af6-3376-4d09-870f-94150de96973",
        "planning_id": "e4630604-84ad-4b26-8595-a0ebd8004749",
        "order_id": "36219d96-bc25-4708-a299-5b8757f01821"
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
      "id": "15711f92-3bd5-4eea-bf09-5d2b846867f0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:09+00:00",
        "updated_at": "2022-07-15T09:25:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0d3c898a-d8b2-4ab4-aa5c-d117fa372e6f",
        "planning_id": "e4630604-84ad-4b26-8595-a0ebd8004749",
        "order_id": "36219d96-bc25-4708-a299-5b8757f01821"
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
      "id": "875160db-4b4c-4348-a310-99ce23a5cba3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:09+00:00",
        "updated_at": "2022-07-15T09:25:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "edb8c37d-fea7-4d6d-af04-8e2881a0bf8f",
        "planning_id": "e4630604-84ad-4b26-8595-a0ebd8004749",
        "order_id": "36219d96-bc25-4708-a299-5b8757f01821"
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
          "order_id": "3bf28048-a36e-4182-b016-c34defd405fb",
          "items": [
            {
              "type": "bundles",
              "id": "7c4506c7-03f3-4ef7-9f72-5f0de2f6788d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b07d5ba3-1015-450c-94ee-3d107f49ece9",
                  "id": "833caf1b-0b49-4bbf-8a62-1c2d1093938f"
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
    "id": "5bba3493-4721-5b71-95dd-1a7ac7dc2502",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3bf28048-a36e-4182-b016-c34defd405fb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3bf28048-a36e-4182-b016-c34defd405fb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "af11b13a-a8ef-4498-92f0-31aa61ba515b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "257fc589-fe87-451a-acd4-3c6aaca26630"
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
      "id": "3bf28048-a36e-4182-b016-c34defd405fb",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-15T09:25:12+00:00",
        "updated_at": "2022-07-15T09:25:13+00:00",
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
        "starts_at": "2022-07-13T09:15:00+00:00",
        "stops_at": "2022-07-17T09:15:00+00:00",
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
        "start_location_id": "0e99f4b5-fc6d-40ae-801d-d0ede35dc960",
        "stop_location_id": "0e99f4b5-fc6d-40ae-801d-d0ede35dc960"
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
      "id": "af11b13a-a8ef-4498-92f0-31aa61ba515b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:25:13+00:00",
        "updated_at": "2022-07-15T09:25:13+00:00",
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
        "item_id": "7c4506c7-03f3-4ef7-9f72-5f0de2f6788d",
        "tax_category_id": null,
        "planning_id": "257fc589-fe87-451a-acd4-3c6aaca26630",
        "parent_line_id": null,
        "owner_id": "3bf28048-a36e-4182-b016-c34defd405fb",
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
      "id": "257fc589-fe87-451a-acd4-3c6aaca26630",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:25:13+00:00",
        "updated_at": "2022-07-15T09:25:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-13T09:15:00+00:00",
        "stops_at": "2022-07-17T09:15:00+00:00",
        "reserved_from": "2022-07-13T09:15:00+00:00",
        "reserved_till": "2022-07-17T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7c4506c7-03f3-4ef7-9f72-5f0de2f6788d",
        "order_id": "3bf28048-a36e-4182-b016-c34defd405fb",
        "start_location_id": "0e99f4b5-fc6d-40ae-801d-d0ede35dc960",
        "stop_location_id": "0e99f4b5-fc6d-40ae-801d-d0ede35dc960",
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





