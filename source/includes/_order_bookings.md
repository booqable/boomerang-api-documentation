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
          "order_id": "6bb703c4-072f-475c-83ff-a43ed3206c87",
          "items": [
            {
              "type": "products",
              "id": "5aeab0f3-cd53-42e2-88b7-316fcf55b68d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f83869c9-2c31-404f-af8f-58b0a185ac1e",
              "stock_item_ids": [
                "34721253-f427-404e-a47d-07e4ac018377",
                "bfa72614-b182-4d1a-a583-b44f668454a2"
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
            "item_id": "5aeab0f3-cd53-42e2-88b7-316fcf55b68d",
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
          "order_id": "b7375848-e085-4f94-9167-39de790efe29",
          "items": [
            {
              "type": "products",
              "id": "b2c287c9-90bc-4119-8e1e-8e0c22f28359",
              "stock_item_ids": [
                "5cba51d2-ef26-4768-9272-d524a96a97de",
                "3c1d3ec5-dd14-4246-a5c9-10152f02badb",
                "127d3de6-6371-4a5a-b0bf-537c1b2cf4aa"
              ]
            },
            {
              "type": "products",
              "id": "a5d494af-864e-427e-b7c5-43b0e22227c9",
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
    "id": "84e96a49-69d8-55e4-aa1a-50186cb3a84b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b7375848-e085-4f94-9167-39de790efe29"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b7375848-e085-4f94-9167-39de790efe29"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e5ad914e-92a7-43be-b33b-da6f04fc8730"
          },
          {
            "type": "lines",
            "id": "1291b584-a2e2-4eb2-b530-e393b0b24a7f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a"
          },
          {
            "type": "plannings",
            "id": "342c087d-4bf2-4633-972c-a75455d4bccc"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "bb83c584-6b3f-4436-a229-c689b778f507"
          },
          {
            "type": "stock_item_plannings",
            "id": "720ed258-0826-4811-9f15-cb6035d82885"
          },
          {
            "type": "stock_item_plannings",
            "id": "f2515855-0119-46f3-904a-73fd58f35d3d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b7375848-e085-4f94-9167-39de790efe29",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T16:19:14+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
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
        "customer_id": "01a87ee6-b9c5-47c6-9621-e686338738c0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231",
        "stop_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231"
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
      "id": "e5ad914e-92a7-43be-b33b-da6f04fc8730",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
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
        "item_id": "b2c287c9-90bc-4119-8e1e-8e0c22f28359",
        "tax_category_id": "7fa31a23-dcd8-44a6-96b0-dbc1ea719c2f",
        "planning_id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a",
        "parent_line_id": null,
        "owner_id": "b7375848-e085-4f94-9167-39de790efe29",
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
      "id": "1291b584-a2e2-4eb2-b530-e393b0b24a7f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
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
        "item_id": "a5d494af-864e-427e-b7c5-43b0e22227c9",
        "tax_category_id": "7fa31a23-dcd8-44a6-96b0-dbc1ea719c2f",
        "planning_id": "342c087d-4bf2-4633-972c-a75455d4bccc",
        "parent_line_id": null,
        "owner_id": "b7375848-e085-4f94-9167-39de790efe29",
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
      "id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
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
        "item_id": "b2c287c9-90bc-4119-8e1e-8e0c22f28359",
        "order_id": "b7375848-e085-4f94-9167-39de790efe29",
        "start_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231",
        "stop_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231",
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
      "id": "342c087d-4bf2-4633-972c-a75455d4bccc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
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
        "item_id": "a5d494af-864e-427e-b7c5-43b0e22227c9",
        "order_id": "b7375848-e085-4f94-9167-39de790efe29",
        "start_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231",
        "stop_location_id": "633ef1fb-480d-4a90-9f3a-693b7ab8d231",
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
      "id": "bb83c584-6b3f-4436-a229-c689b778f507",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5cba51d2-ef26-4768-9272-d524a96a97de",
        "planning_id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a",
        "order_id": "b7375848-e085-4f94-9167-39de790efe29"
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
      "id": "720ed258-0826-4811-9f15-cb6035d82885",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3c1d3ec5-dd14-4246-a5c9-10152f02badb",
        "planning_id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a",
        "order_id": "b7375848-e085-4f94-9167-39de790efe29"
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
      "id": "f2515855-0119-46f3-904a-73fd58f35d3d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:16+00:00",
        "updated_at": "2023-02-08T16:19:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "127d3de6-6371-4a5a-b0bf-537c1b2cf4aa",
        "planning_id": "3d32e89c-10b2-431e-8e3e-51eaf05ec53a",
        "order_id": "b7375848-e085-4f94-9167-39de790efe29"
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
          "order_id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755",
          "items": [
            {
              "type": "bundles",
              "id": "a015c309-6d8a-40ff-83aa-9118919471bc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3c2fe4e3-82c5-4c0e-94a7-03a491cd0665",
                  "id": "7d658624-673d-4122-9390-aade712390ac"
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
    "id": "acaa5ba7-6977-5467-9332-4a665254a8cd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "52fa92ac-2af4-4c1c-950a-19a53c2261fc"
          },
          {
            "type": "lines",
            "id": "2515c00a-24f8-4b0a-a80e-ab33745fc5b3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "00a7c520-85f1-4feb-a3c9-1c02afbd7101"
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
      "id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T16:19:18+00:00",
        "updated_at": "2023-02-08T16:19:19+00:00",
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
        "starts_at": "2023-02-06T16:15:00+00:00",
        "stops_at": "2023-02-10T16:15:00+00:00",
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
        "start_location_id": "02e9847d-427f-4993-ad24-ee70656b5880",
        "stop_location_id": "02e9847d-427f-4993-ad24-ee70656b5880"
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
      "id": "52fa92ac-2af4-4c1c-950a-19a53c2261fc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T16:19:19+00:00",
        "updated_at": "2023-02-08T16:19:19+00:00",
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
        "item_id": "a015c309-6d8a-40ff-83aa-9118919471bc",
        "tax_category_id": null,
        "planning_id": "00a7c520-85f1-4feb-a3c9-1c02afbd7101",
        "parent_line_id": null,
        "owner_id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755",
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
      "id": "2515c00a-24f8-4b0a-a80e-ab33745fc5b3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T16:19:19+00:00",
        "updated_at": "2023-02-08T16:19:19+00:00",
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
        "item_id": "7d658624-673d-4122-9390-aade712390ac",
        "tax_category_id": null,
        "planning_id": "5d959229-6b6a-4dfc-a8d5-e6b94616a4fa",
        "parent_line_id": "52fa92ac-2af4-4c1c-950a-19a53c2261fc",
        "owner_id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755",
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
      "id": "00a7c520-85f1-4feb-a3c9-1c02afbd7101",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T16:19:19+00:00",
        "updated_at": "2023-02-08T16:19:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T16:15:00+00:00",
        "stops_at": "2023-02-10T16:15:00+00:00",
        "reserved_from": "2023-02-06T16:15:00+00:00",
        "reserved_till": "2023-02-10T16:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a015c309-6d8a-40ff-83aa-9118919471bc",
        "order_id": "48a4ac68-840e-49d5-8cd2-b3f7794dd755",
        "start_location_id": "02e9847d-427f-4993-ad24-ee70656b5880",
        "stop_location_id": "02e9847d-427f-4993-ad24-ee70656b5880",
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





