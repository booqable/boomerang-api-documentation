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
          "order_id": "c2e8b6c8-809f-493b-b003-5fd5fc70c92a",
          "items": [
            {
              "type": "products",
              "id": "77aa876b-5b0f-487e-8f3a-9eceecbb2bd7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "83bce9a6-8273-4722-b52a-1cdfa6246dfa",
              "stock_item_ids": [
                "ffeb3568-60bd-4059-8169-b718e604f657",
                "d0c29ecb-79c8-4606-995c-6863b7e52b0b"
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
          "stock_item_id ffeb3568-60bd-4059-8169-b718e604f657 has already been booked on this order"
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
          "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
          "items": [
            {
              "type": "products",
              "id": "012ccca6-beb5-440a-94a4-2c2ddd9fa338",
              "stock_item_ids": [
                "a63f75b9-d6c1-47a3-b4b9-edc38f5b2ed1",
                "764f2154-f1b2-4e18-9c5b-37d9cf192035",
                "8b4a273d-3f86-4e0f-821b-8a3245d974ef"
              ]
            },
            {
              "type": "products",
              "id": "8abbfeb4-3dc0-4ccb-b62e-de0e586d28f8",
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
    "id": "471caa3c-5821-5df3-b64c-2889877da70d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "400a35d1-b596-4538-b8f4-76b5c835f08f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "704b1766-8fc8-4abb-8759-f4bdf258797b"
          },
          {
            "type": "lines",
            "id": "2ca90170-1211-4a32-b26c-29a0aa772f57"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3a5d8894-8a36-4502-a676-d32ea8a78126"
          },
          {
            "type": "plannings",
            "id": "2692db0d-eea6-43d7-81c5-73231448dce7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dd703869-0bb7-400d-97d5-74d7202696e7"
          },
          {
            "type": "stock_item_plannings",
            "id": "20d7753d-d411-4494-9b98-b1bd7ea4d623"
          },
          {
            "type": "stock_item_plannings",
            "id": "7c94c754-ed9a-4fa3-afcb-6d01b639f8dc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-27T10:16:28+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
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
        "customer_id": "9689c585-4846-420b-81f6-ad3f8bdb43a4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17",
        "stop_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17"
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
      "id": "704b1766-8fc8-4abb-8759-f4bdf258797b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
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
        "item_id": "012ccca6-beb5-440a-94a4-2c2ddd9fa338",
        "tax_category_id": "a391a4d6-49c3-4f3e-8496-1ae779b1245c",
        "planning_id": "3a5d8894-8a36-4502-a676-d32ea8a78126",
        "parent_line_id": null,
        "owner_id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
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
      "id": "2ca90170-1211-4a32-b26c-29a0aa772f57",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
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
        "item_id": "8abbfeb4-3dc0-4ccb-b62e-de0e586d28f8",
        "tax_category_id": "a391a4d6-49c3-4f3e-8496-1ae779b1245c",
        "planning_id": "2692db0d-eea6-43d7-81c5-73231448dce7",
        "parent_line_id": null,
        "owner_id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
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
      "id": "3a5d8894-8a36-4502-a676-d32ea8a78126",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
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
        "item_id": "012ccca6-beb5-440a-94a4-2c2ddd9fa338",
        "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
        "start_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17",
        "stop_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17",
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
      "id": "2692db0d-eea6-43d7-81c5-73231448dce7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
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
        "item_id": "8abbfeb4-3dc0-4ccb-b62e-de0e586d28f8",
        "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f",
        "start_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17",
        "stop_location_id": "71a1e108-8a21-4d90-874d-839a4ae30f17",
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
      "id": "dd703869-0bb7-400d-97d5-74d7202696e7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a63f75b9-d6c1-47a3-b4b9-edc38f5b2ed1",
        "planning_id": "3a5d8894-8a36-4502-a676-d32ea8a78126",
        "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f"
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
      "id": "20d7753d-d411-4494-9b98-b1bd7ea4d623",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "764f2154-f1b2-4e18-9c5b-37d9cf192035",
        "planning_id": "3a5d8894-8a36-4502-a676-d32ea8a78126",
        "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f"
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
      "id": "7c94c754-ed9a-4fa3-afcb-6d01b639f8dc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:29+00:00",
        "updated_at": "2023-02-27T10:16:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b4a273d-3f86-4e0f-821b-8a3245d974ef",
        "planning_id": "3a5d8894-8a36-4502-a676-d32ea8a78126",
        "order_id": "400a35d1-b596-4538-b8f4-76b5c835f08f"
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
          "order_id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86",
          "items": [
            {
              "type": "bundles",
              "id": "c6241f20-f25e-421c-9d89-558f61228053",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3f0afda1-41cf-4e68-b5d0-03a01bcb87c2",
                  "id": "04e53dcb-2ecc-4ea4-ba35-dfb6b9164542"
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
    "id": "f82e7bd9-7d90-5ee5-8248-8300cc557954",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1153ee1f-48af-4114-b0c0-5b561b027c38"
          },
          {
            "type": "lines",
            "id": "8565c06d-5b1e-49f2-8710-ae8f80395c67"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f57bd62e-6657-4ea4-9225-bb2619880c72"
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
      "id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-27T10:16:31+00:00",
        "updated_at": "2023-02-27T10:16:32+00:00",
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
        "starts_at": "2023-02-25T10:15:00+00:00",
        "stops_at": "2023-03-01T10:15:00+00:00",
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
        "start_location_id": "76e5694b-0065-4a06-b42c-3554fafbb1ce",
        "stop_location_id": "76e5694b-0065-4a06-b42c-3554fafbb1ce"
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
      "id": "1153ee1f-48af-4114-b0c0-5b561b027c38",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:16:32+00:00",
        "updated_at": "2023-02-27T10:16:32+00:00",
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
        "item_id": "04e53dcb-2ecc-4ea4-ba35-dfb6b9164542",
        "tax_category_id": null,
        "planning_id": "eb97c5cc-e373-4bcd-9277-f7735f3ec063",
        "parent_line_id": "8565c06d-5b1e-49f2-8710-ae8f80395c67",
        "owner_id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86",
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
      "id": "8565c06d-5b1e-49f2-8710-ae8f80395c67",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-27T10:16:32+00:00",
        "updated_at": "2023-02-27T10:16:32+00:00",
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
        "item_id": "c6241f20-f25e-421c-9d89-558f61228053",
        "tax_category_id": null,
        "planning_id": "f57bd62e-6657-4ea4-9225-bb2619880c72",
        "parent_line_id": null,
        "owner_id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86",
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
      "id": "f57bd62e-6657-4ea4-9225-bb2619880c72",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-27T10:16:32+00:00",
        "updated_at": "2023-02-27T10:16:32+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-25T10:15:00+00:00",
        "stops_at": "2023-03-01T10:15:00+00:00",
        "reserved_from": "2023-02-25T10:15:00+00:00",
        "reserved_till": "2023-03-01T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c6241f20-f25e-421c-9d89-558f61228053",
        "order_id": "b6b6eeb1-5170-46a7-83d8-4bb842df7c86",
        "start_location_id": "76e5694b-0065-4a06-b42c-3554fafbb1ce",
        "stop_location_id": "76e5694b-0065-4a06-b42c-3554fafbb1ce",
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





