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
          "order_id": "7d63b95b-836d-428f-841e-b8b8d3975688",
          "items": [
            {
              "type": "products",
              "id": "a3814fcb-d914-4db1-b5a6-1a16c6b6db20",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1f8e9889-ecb8-43b4-adcd-a89d3b30c82f",
              "stock_item_ids": [
                "813df607-f367-46f0-9308-9005ba2954b0",
                "e264279c-1e9e-443d-95d1-0b5d071caf9e"
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
            "item_id": "a3814fcb-d914-4db1-b5a6-1a16c6b6db20",
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
          "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
          "items": [
            {
              "type": "products",
              "id": "a7da7368-bda1-465d-8fa1-1265e9a971fd",
              "stock_item_ids": [
                "413f3ef4-8478-497f-a260-c0daa0f4efbb",
                "2261817a-6146-420e-aa32-29771a66e084",
                "582daba2-cb17-4832-847c-0e38fe790f6e"
              ]
            },
            {
              "type": "products",
              "id": "4293e2fa-3bcb-449a-828a-c301bde3d0c3",
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
    "id": "1929aded-6c03-52aa-b9fd-ed8ca6d75ae8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2dc8bfd7-5555-4f71-9dfe-852a50e19409"
          },
          {
            "type": "lines",
            "id": "204e2caa-fabe-49a6-aa34-e8cb77142069"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "48b95ec5-dbb5-43f1-9925-3dbcc715396b"
          },
          {
            "type": "plannings",
            "id": "7bf54a51-15b8-480a-a22c-32a251ac036d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "72d3cc11-c99e-4f24-8e6f-97b24a6b1711"
          },
          {
            "type": "stock_item_plannings",
            "id": "31671e0f-1167-4f75-850f-096daef6ec11"
          },
          {
            "type": "stock_item_plannings",
            "id": "6ccdd5b5-75cd-4c58-872d-af792cdbc24a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T21:14:57+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
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
        "customer_id": "ea53b302-9c86-4425-b60f-e10b3a7978b9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51",
        "stop_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51"
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
      "id": "2dc8bfd7-5555-4f71-9dfe-852a50e19409",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T21:14:58+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
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
        "item_id": "4293e2fa-3bcb-449a-828a-c301bde3d0c3",
        "tax_category_id": "62cd1ace-2aad-4921-80ac-0ed00446027a",
        "planning_id": "48b95ec5-dbb5-43f1-9925-3dbcc715396b",
        "parent_line_id": null,
        "owner_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
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
      "id": "204e2caa-fabe-49a6-aa34-e8cb77142069",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T21:14:59+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
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
        "item_id": "a7da7368-bda1-465d-8fa1-1265e9a971fd",
        "tax_category_id": "62cd1ace-2aad-4921-80ac-0ed00446027a",
        "planning_id": "7bf54a51-15b8-480a-a22c-32a251ac036d",
        "parent_line_id": null,
        "owner_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
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
      "id": "48b95ec5-dbb5-43f1-9925-3dbcc715396b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T21:14:58+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
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
        "item_id": "4293e2fa-3bcb-449a-828a-c301bde3d0c3",
        "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
        "start_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51",
        "stop_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51",
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
      "id": "7bf54a51-15b8-480a-a22c-32a251ac036d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T21:14:58+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
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
        "item_id": "a7da7368-bda1-465d-8fa1-1265e9a971fd",
        "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3",
        "start_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51",
        "stop_location_id": "45d6329b-ea5c-4107-9f44-8dc19e71df51",
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
      "id": "72d3cc11-c99e-4f24-8e6f-97b24a6b1711",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T21:14:59+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "413f3ef4-8478-497f-a260-c0daa0f4efbb",
        "planning_id": "7bf54a51-15b8-480a-a22c-32a251ac036d",
        "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3"
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
      "id": "31671e0f-1167-4f75-850f-096daef6ec11",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T21:14:59+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2261817a-6146-420e-aa32-29771a66e084",
        "planning_id": "7bf54a51-15b8-480a-a22c-32a251ac036d",
        "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3"
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
      "id": "6ccdd5b5-75cd-4c58-872d-af792cdbc24a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T21:14:59+00:00",
        "updated_at": "2022-07-14T21:14:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "582daba2-cb17-4832-847c-0e38fe790f6e",
        "planning_id": "7bf54a51-15b8-480a-a22c-32a251ac036d",
        "order_id": "2ae13e6f-d548-4bae-b8af-6b7b9db26af3"
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
          "order_id": "f4669712-aa20-4169-8880-5ba8efc18b30",
          "items": [
            {
              "type": "bundles",
              "id": "01c80451-4a89-4449-8740-f4286e713062",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f688d738-c486-4006-92fe-afffcdb88210",
                  "id": "15826efd-f939-428f-8661-fc4dfa7dec6b"
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
    "id": "5f752959-4758-5a04-8a95-b2f36a17bae1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f4669712-aa20-4169-8880-5ba8efc18b30"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f4669712-aa20-4169-8880-5ba8efc18b30"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "16e1c813-5841-4571-88e6-e7483491ba85"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2f8ad4f0-dba1-4604-9e95-359df48a43c7"
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
      "id": "f4669712-aa20-4169-8880-5ba8efc18b30",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T21:15:03+00:00",
        "updated_at": "2022-07-14T21:15:04+00:00",
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
        "starts_at": "2022-07-12T21:15:00+00:00",
        "stops_at": "2022-07-16T21:15:00+00:00",
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
        "start_location_id": "022d8726-6bbe-41d8-9f58-8dc154bff25c",
        "stop_location_id": "022d8726-6bbe-41d8-9f58-8dc154bff25c"
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
      "id": "16e1c813-5841-4571-88e6-e7483491ba85",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T21:15:04+00:00",
        "updated_at": "2022-07-14T21:15:04+00:00",
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
        "item_id": "01c80451-4a89-4449-8740-f4286e713062",
        "tax_category_id": null,
        "planning_id": "2f8ad4f0-dba1-4604-9e95-359df48a43c7",
        "parent_line_id": null,
        "owner_id": "f4669712-aa20-4169-8880-5ba8efc18b30",
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
      "id": "2f8ad4f0-dba1-4604-9e95-359df48a43c7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T21:15:04+00:00",
        "updated_at": "2022-07-14T21:15:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T21:15:00+00:00",
        "stops_at": "2022-07-16T21:15:00+00:00",
        "reserved_from": "2022-07-12T21:15:00+00:00",
        "reserved_till": "2022-07-16T21:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "01c80451-4a89-4449-8740-f4286e713062",
        "order_id": "f4669712-aa20-4169-8880-5ba8efc18b30",
        "start_location_id": "022d8726-6bbe-41d8-9f58-8dc154bff25c",
        "stop_location_id": "022d8726-6bbe-41d8-9f58-8dc154bff25c",
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





