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
          "order_id": "0e401b33-fd21-4d3f-81c4-eaa95dcd2fd8",
          "items": [
            {
              "type": "products",
              "id": "a434dbfd-8b03-45bf-a58c-72df43bf844f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "17c93aeb-2a44-4050-8700-e631acc96223",
              "stock_item_ids": [
                "72109924-d3ab-462f-a36d-4b3f50b955f4",
                "8aab975f-86a8-4466-8322-d4beb547925c"
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
            "item_id": "a434dbfd-8b03-45bf-a58c-72df43bf844f",
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
          "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
          "items": [
            {
              "type": "products",
              "id": "de3e71b9-e3ed-48fd-8302-0411dc249340",
              "stock_item_ids": [
                "009c7968-04d2-4cc7-8531-c62157000b7a",
                "055d23d9-1dd4-4d3f-9e02-70f8c19704a1",
                "c8b6ad05-2143-47fa-bdba-e4a0a3841a81"
              ]
            },
            {
              "type": "products",
              "id": "7552450d-d5e8-4da9-ac73-d09e27c14ac6",
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
    "id": "940e03db-ca4d-5cbd-970d-e57f5cafaef8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4670478d-068f-41ea-8ea9-e846ff166a1c"
          },
          {
            "type": "lines",
            "id": "3138ceaf-223d-47f8-9932-8e31330ac174"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9d617d20-b159-48b0-b8b3-897b12bd05a0"
          },
          {
            "type": "plannings",
            "id": "ec284372-b09f-4687-a00c-91d6ab49f909"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "221609bc-f1a7-4e75-b6a8-16e7f77ab809"
          },
          {
            "type": "stock_item_plannings",
            "id": "c51e0719-9968-4948-91c8-40bf006a15d6"
          },
          {
            "type": "stock_item_plannings",
            "id": "f97551d8-4c06-403e-a967-523495063c8d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-04T10:58:41+00:00",
        "updated_at": "2022-03-04T10:58:43+00:00",
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
        "customer_id": "c36b3853-d484-4932-8c15-e9e7d99eb0c1",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6",
        "stop_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6"
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
      "id": "4670478d-068f-41ea-8ea9-e846ff166a1c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:58:41+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
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
        "item_id": "7552450d-d5e8-4da9-ac73-d09e27c14ac6",
        "tax_category_id": "55b48e8b-819a-4cc0-a5f8-dcaffb5f3b77",
        "planning_id": "9d617d20-b159-48b0-b8b3-897b12bd05a0",
        "parent_line_id": null,
        "owner_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
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
      "id": "3138ceaf-223d-47f8-9932-8e31330ac174",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:58:42+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
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
        "item_id": "de3e71b9-e3ed-48fd-8302-0411dc249340",
        "tax_category_id": "55b48e8b-819a-4cc0-a5f8-dcaffb5f3b77",
        "planning_id": "ec284372-b09f-4687-a00c-91d6ab49f909",
        "parent_line_id": null,
        "owner_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
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
      "id": "9d617d20-b159-48b0-b8b3-897b12bd05a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:41+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
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
        "item_id": "7552450d-d5e8-4da9-ac73-d09e27c14ac6",
        "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
        "start_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6",
        "stop_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6",
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
      "id": "ec284372-b09f-4687-a00c-91d6ab49f909",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:42+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
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
        "item_id": "de3e71b9-e3ed-48fd-8302-0411dc249340",
        "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3",
        "start_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6",
        "stop_location_id": "e32c85d3-2b7f-443c-aba7-6e4d9919d1c6",
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
      "id": "221609bc-f1a7-4e75-b6a8-16e7f77ab809",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:42+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "009c7968-04d2-4cc7-8531-c62157000b7a",
        "planning_id": "ec284372-b09f-4687-a00c-91d6ab49f909",
        "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3"
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
      "id": "c51e0719-9968-4948-91c8-40bf006a15d6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:42+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "055d23d9-1dd4-4d3f-9e02-70f8c19704a1",
        "planning_id": "ec284372-b09f-4687-a00c-91d6ab49f909",
        "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3"
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
      "id": "f97551d8-4c06-403e-a967-523495063c8d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:42+00:00",
        "updated_at": "2022-03-04T10:58:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c8b6ad05-2143-47fa-bdba-e4a0a3841a81",
        "planning_id": "ec284372-b09f-4687-a00c-91d6ab49f909",
        "order_id": "73d5beb1-037f-4d5d-9f8f-be30a8ccbbc3"
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
          "order_id": "281e2882-d30e-4c1e-ad66-844f7f7233cd",
          "items": [
            {
              "type": "bundles",
              "id": "da9eb2e2-d3cf-416f-92f9-d1af9bfbad3a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "22f9632b-daca-4db7-8c03-fdf8a979af14",
                  "id": "c68d5ba4-eac3-4af1-abfa-b2a3820f1ef6"
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
    "id": "f2c98d1e-679f-55ac-a6ac-756b30452d46",
    "type": "order_bookings",
    "attributes": {
      "order_id": "281e2882-d30e-4c1e-ad66-844f7f7233cd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "281e2882-d30e-4c1e-ad66-844f7f7233cd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b32094b7-ba20-4a1a-a0fc-2d12ec2700ab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "703cee2d-ced1-4c67-9ca1-72c8f3314748"
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
      "id": "281e2882-d30e-4c1e-ad66-844f7f7233cd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-04T10:58:44+00:00",
        "updated_at": "2022-03-04T10:58:45+00:00",
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
        "starts_at": "2022-03-02T10:45:00+00:00",
        "stops_at": "2022-03-06T10:45:00+00:00",
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
        "start_location_id": "34ef7b5b-55f7-409a-b354-64e7ecf6c577",
        "stop_location_id": "34ef7b5b-55f7-409a-b354-64e7ecf6c577"
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
      "id": "b32094b7-ba20-4a1a-a0fc-2d12ec2700ab",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:58:45+00:00",
        "updated_at": "2022-03-04T10:58:45+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "da9eb2e2-d3cf-416f-92f9-d1af9bfbad3a",
        "tax_category_id": null,
        "planning_id": "703cee2d-ced1-4c67-9ca1-72c8f3314748",
        "parent_line_id": null,
        "owner_id": "281e2882-d30e-4c1e-ad66-844f7f7233cd",
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
      "id": "703cee2d-ced1-4c67-9ca1-72c8f3314748",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:58:45+00:00",
        "updated_at": "2022-03-04T10:58:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-02T10:45:00+00:00",
        "stops_at": "2022-03-06T10:45:00+00:00",
        "reserved_from": "2022-03-02T10:45:00+00:00",
        "reserved_till": "2022-03-06T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "da9eb2e2-d3cf-416f-92f9-d1af9bfbad3a",
        "order_id": "281e2882-d30e-4c1e-ad66-844f7f7233cd",
        "start_location_id": "34ef7b5b-55f7-409a-b354-64e7ecf6c577",
        "stop_location_id": "34ef7b5b-55f7-409a-b354-64e7ecf6c577",
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





