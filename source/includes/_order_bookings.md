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
          "order_id": "5a66e911-d4d9-4d5f-ac73-ba12847e1fe1",
          "items": [
            {
              "type": "products",
              "id": "aaf6514f-0014-499c-b01e-3edea8b9d200",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2e9e3e79-6489-48fb-9716-0430bac0475b",
              "stock_item_ids": [
                "4c08f7da-52d8-47c1-a34f-0f70b03adfcc",
                "8042638d-4055-4856-9cf2-c7209688bf6d"
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
            "item_id": "aaf6514f-0014-499c-b01e-3edea8b9d200",
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
          "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
          "items": [
            {
              "type": "products",
              "id": "66816863-15be-4c53-be76-881f0b6fc58b",
              "stock_item_ids": [
                "56a7a1b5-cfca-4139-9ceb-55b8e1a96c7f",
                "2e491bd5-6367-4ab0-85ab-bafafda0d5c0",
                "6eb289b7-ea5e-4450-bcfa-daa7c9016a91"
              ]
            },
            {
              "type": "products",
              "id": "6881c333-38ff-40a2-a3c0-3c001cccef7a",
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
    "id": "36f2d9ea-50cc-57fb-921b-5394d604edbf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7ae6e011-2410-4213-a785-8e42b3a25e42"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "628483b3-4875-45e0-a9eb-187b33afc435"
          },
          {
            "type": "lines",
            "id": "ecca947e-2325-4297-b4f2-a4ec997ed59b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c"
          },
          {
            "type": "plannings",
            "id": "6fe8aa48-344f-4147-9af2-f0879932d763"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1c7693b1-130d-475d-84aa-28b3b12e6133"
          },
          {
            "type": "stock_item_plannings",
            "id": "d8c543fe-4320-4089-917a-ace2aaf3c362"
          },
          {
            "type": "stock_item_plannings",
            "id": "2499dd13-c121-4619-a728-9591961a9956"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
      "type": "orders",
      "attributes": {
        "created_at": "2022-08-22T15:52:08+00:00",
        "updated_at": "2022-08-22T15:52:10+00:00",
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
        "customer_id": "155bc1d3-e83b-46e8-9ccc-6d401946e2f7",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517",
        "stop_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517"
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
      "id": "628483b3-4875-45e0-a9eb-187b33afc435",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:10+00:00",
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
        "item_id": "66816863-15be-4c53-be76-881f0b6fc58b",
        "tax_category_id": "72fb870f-d38e-4783-a899-ee5b5beba786",
        "planning_id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c",
        "parent_line_id": null,
        "owner_id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
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
      "id": "ecca947e-2325-4297-b4f2-a4ec997ed59b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:10+00:00",
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
        "item_id": "6881c333-38ff-40a2-a3c0-3c001cccef7a",
        "tax_category_id": "72fb870f-d38e-4783-a899-ee5b5beba786",
        "planning_id": "6fe8aa48-344f-4147-9af2-f0879932d763",
        "parent_line_id": null,
        "owner_id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
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
      "id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:10+00:00",
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
        "item_id": "66816863-15be-4c53-be76-881f0b6fc58b",
        "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
        "start_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517",
        "stop_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517",
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
      "id": "6fe8aa48-344f-4147-9af2-f0879932d763",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:10+00:00",
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
        "item_id": "6881c333-38ff-40a2-a3c0-3c001cccef7a",
        "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42",
        "start_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517",
        "stop_location_id": "7aef8e1f-e6f9-4b06-9b09-bc7eb5134517",
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
      "id": "1c7693b1-130d-475d-84aa-28b3b12e6133",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "56a7a1b5-cfca-4139-9ceb-55b8e1a96c7f",
        "planning_id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c",
        "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42"
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
      "id": "d8c543fe-4320-4089-917a-ace2aaf3c362",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e491bd5-6367-4ab0-85ab-bafafda0d5c0",
        "planning_id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c",
        "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42"
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
      "id": "2499dd13-c121-4619-a728-9591961a9956",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:09+00:00",
        "updated_at": "2022-08-22T15:52:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6eb289b7-ea5e-4450-bcfa-daa7c9016a91",
        "planning_id": "f72f8e97-8997-4ef3-ae32-3c536d598d9c",
        "order_id": "7ae6e011-2410-4213-a785-8e42b3a25e42"
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
          "order_id": "3756091e-8159-4b41-b6d8-a3e03db19713",
          "items": [
            {
              "type": "bundles",
              "id": "a78caf25-f0c2-42ea-a192-e5c95789a716",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "34930b1a-1138-4a55-9c21-e407890a8fcf",
                  "id": "adc875fe-98ca-43d1-a748-799730017904"
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
    "id": "4f93b6ff-e24a-5d57-afc6-d80d2a471e39",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3756091e-8159-4b41-b6d8-a3e03db19713"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3756091e-8159-4b41-b6d8-a3e03db19713"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "abc05449-2140-4a8f-b20b-c83783888806"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "532c4832-e747-4846-b835-f3a20cdc95e5"
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
      "id": "3756091e-8159-4b41-b6d8-a3e03db19713",
      "type": "orders",
      "attributes": {
        "created_at": "2022-08-22T15:52:12+00:00",
        "updated_at": "2022-08-22T15:52:14+00:00",
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
        "starts_at": "2022-08-20T15:45:00+00:00",
        "stops_at": "2022-08-24T15:45:00+00:00",
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
        "start_location_id": "78c9dd16-16a6-45b0-980f-aba403654b09",
        "stop_location_id": "78c9dd16-16a6-45b0-980f-aba403654b09"
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
      "id": "abc05449-2140-4a8f-b20b-c83783888806",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-22T15:52:13+00:00",
        "updated_at": "2022-08-22T15:52:13+00:00",
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
        "item_id": "a78caf25-f0c2-42ea-a192-e5c95789a716",
        "tax_category_id": null,
        "planning_id": "532c4832-e747-4846-b835-f3a20cdc95e5",
        "parent_line_id": null,
        "owner_id": "3756091e-8159-4b41-b6d8-a3e03db19713",
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
      "id": "532c4832-e747-4846-b835-f3a20cdc95e5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-22T15:52:13+00:00",
        "updated_at": "2022-08-22T15:52:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-08-20T15:45:00+00:00",
        "stops_at": "2022-08-24T15:45:00+00:00",
        "reserved_from": "2022-08-20T15:45:00+00:00",
        "reserved_till": "2022-08-24T15:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a78caf25-f0c2-42ea-a192-e5c95789a716",
        "order_id": "3756091e-8159-4b41-b6d8-a3e03db19713",
        "start_location_id": "78c9dd16-16a6-45b0-980f-aba403654b09",
        "stop_location_id": "78c9dd16-16a6-45b0-980f-aba403654b09",
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





