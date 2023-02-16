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
          "order_id": "0718f6e1-3e61-4507-b597-c776d5706a67",
          "items": [
            {
              "type": "products",
              "id": "e7d23900-cf34-4a9a-8ad2-5664df85904b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "44d3c08a-7fd4-4c6a-9bd3-bfab4a4eae35",
              "stock_item_ids": [
                "e921165c-5f7d-454c-b36d-b1c412d58cfb",
                "497f260d-45d1-439f-8203-c67d7b721423"
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
          "stock_item_id e921165c-5f7d-454c-b36d-b1c412d58cfb has already been booked on this order"
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
          "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
          "items": [
            {
              "type": "products",
              "id": "36647e52-b202-4644-99a9-22eec6c58362",
              "stock_item_ids": [
                "5fa3c9b9-8619-41fe-9c2b-0fa08e905adf",
                "0234d92c-61e2-4ad0-84a1-8c3be76515ab",
                "2a86c1eb-5b79-42b9-b329-43ff13ae8557"
              ]
            },
            {
              "type": "products",
              "id": "83ddcee6-9c66-4546-a077-7587fe7adbae",
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
    "id": "b7492afa-e55b-5c88-9859-da8cce62d76a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cba3b8af-d3f3-42d1-a013-e096e20122f5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dd87f93e-4a7e-4f3a-a631-20281be1a828"
          },
          {
            "type": "lines",
            "id": "72b8eedb-b0d6-4599-a055-1bf7b61f45f6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0"
          },
          {
            "type": "plannings",
            "id": "96fc44e3-ed49-43f8-a384-17b143be6492"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4a65fe3a-0380-4399-8c3d-f5a637d152fc"
          },
          {
            "type": "stock_item_plannings",
            "id": "c639ed4b-d4f1-49e5-bb11-53522403a2dd"
          },
          {
            "type": "stock_item_plannings",
            "id": "02599e0d-224b-42c9-a7e8-6bac5b2e280d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T23:13:37+00:00",
        "updated_at": "2023-02-16T23:13:39+00:00",
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
        "customer_id": "0ca9a38f-298a-4234-95d0-ffb5c52a4f54",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4f8632e4-f114-4033-9026-4198bc69d712",
        "stop_location_id": "4f8632e4-f114-4033-9026-4198bc69d712"
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
      "id": "dd87f93e-4a7e-4f3a-a631-20281be1a828",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:39+00:00",
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
        "item_id": "36647e52-b202-4644-99a9-22eec6c58362",
        "tax_category_id": "00698920-e3e8-48b7-890d-444cfbdbcc6b",
        "planning_id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0",
        "parent_line_id": null,
        "owner_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
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
      "id": "72b8eedb-b0d6-4599-a055-1bf7b61f45f6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:39+00:00",
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
        "item_id": "83ddcee6-9c66-4546-a077-7587fe7adbae",
        "tax_category_id": "00698920-e3e8-48b7-890d-444cfbdbcc6b",
        "planning_id": "96fc44e3-ed49-43f8-a384-17b143be6492",
        "parent_line_id": null,
        "owner_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
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
      "id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:38+00:00",
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
        "item_id": "36647e52-b202-4644-99a9-22eec6c58362",
        "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
        "start_location_id": "4f8632e4-f114-4033-9026-4198bc69d712",
        "stop_location_id": "4f8632e4-f114-4033-9026-4198bc69d712",
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
      "id": "96fc44e3-ed49-43f8-a384-17b143be6492",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:38+00:00",
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
        "item_id": "83ddcee6-9c66-4546-a077-7587fe7adbae",
        "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5",
        "start_location_id": "4f8632e4-f114-4033-9026-4198bc69d712",
        "stop_location_id": "4f8632e4-f114-4033-9026-4198bc69d712",
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
      "id": "4a65fe3a-0380-4399-8c3d-f5a637d152fc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5fa3c9b9-8619-41fe-9c2b-0fa08e905adf",
        "planning_id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0",
        "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5"
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
      "id": "c639ed4b-d4f1-49e5-bb11-53522403a2dd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0234d92c-61e2-4ad0-84a1-8c3be76515ab",
        "planning_id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0",
        "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5"
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
      "id": "02599e0d-224b-42c9-a7e8-6bac5b2e280d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:38+00:00",
        "updated_at": "2023-02-16T23:13:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2a86c1eb-5b79-42b9-b329-43ff13ae8557",
        "planning_id": "bac8732e-644b-4aa5-8a14-f8b1694a93f0",
        "order_id": "cba3b8af-d3f3-42d1-a013-e096e20122f5"
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
          "order_id": "c8c25901-4bea-492c-9ee2-1826746a8383",
          "items": [
            {
              "type": "bundles",
              "id": "1eb20194-979b-4798-8b4c-ed8744a83f06",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f94fe28c-7052-4220-997d-63e4a476ff65",
                  "id": "55e56317-8cc4-4ac0-ad81-973b6db0244c"
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
    "id": "18266f1e-6f2f-5c89-86ce-d9f1c82b31a7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c8c25901-4bea-492c-9ee2-1826746a8383"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c8c25901-4bea-492c-9ee2-1826746a8383"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5c90dd19-7a25-404a-815d-b2ef31a41993"
          },
          {
            "type": "lines",
            "id": "386c01cb-c24b-4ab4-81ad-ffd933dfd401"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "85ee2376-0812-4150-8a97-e2b8edb1d28a"
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
      "id": "c8c25901-4bea-492c-9ee2-1826746a8383",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T23:13:41+00:00",
        "updated_at": "2023-02-16T23:13:42+00:00",
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
        "starts_at": "2023-02-14T23:00:00+00:00",
        "stops_at": "2023-02-18T23:00:00+00:00",
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
        "start_location_id": "2dc4ad7b-4a44-49b4-8700-e956acc05df1",
        "stop_location_id": "2dc4ad7b-4a44-49b4-8700-e956acc05df1"
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
      "id": "5c90dd19-7a25-404a-815d-b2ef31a41993",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T23:13:41+00:00",
        "updated_at": "2023-02-16T23:13:41+00:00",
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
        "item_id": "1eb20194-979b-4798-8b4c-ed8744a83f06",
        "tax_category_id": null,
        "planning_id": "85ee2376-0812-4150-8a97-e2b8edb1d28a",
        "parent_line_id": null,
        "owner_id": "c8c25901-4bea-492c-9ee2-1826746a8383",
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
      "id": "386c01cb-c24b-4ab4-81ad-ffd933dfd401",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T23:13:41+00:00",
        "updated_at": "2023-02-16T23:13:41+00:00",
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
        "item_id": "55e56317-8cc4-4ac0-ad81-973b6db0244c",
        "tax_category_id": null,
        "planning_id": "d066eeef-cdf0-456d-930d-b2b3a733cca0",
        "parent_line_id": "5c90dd19-7a25-404a-815d-b2ef31a41993",
        "owner_id": "c8c25901-4bea-492c-9ee2-1826746a8383",
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
      "id": "85ee2376-0812-4150-8a97-e2b8edb1d28a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T23:13:41+00:00",
        "updated_at": "2023-02-16T23:13:41+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T23:00:00+00:00",
        "stops_at": "2023-02-18T23:00:00+00:00",
        "reserved_from": "2023-02-14T23:00:00+00:00",
        "reserved_till": "2023-02-18T23:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1eb20194-979b-4798-8b4c-ed8744a83f06",
        "order_id": "c8c25901-4bea-492c-9ee2-1826746a8383",
        "start_location_id": "2dc4ad7b-4a44-49b4-8700-e956acc05df1",
        "stop_location_id": "2dc4ad7b-4a44-49b4-8700-e956acc05df1",
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





