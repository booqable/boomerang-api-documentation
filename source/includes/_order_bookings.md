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
          "order_id": "ee81d275-cb3a-475c-aa5e-37694e94c140",
          "items": [
            {
              "type": "products",
              "id": "3fbb8c80-d168-4502-a8a1-978fad454a4f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7a5ee4a0-6d81-4e60-acd5-b818abc80b99",
              "stock_item_ids": [
                "159a7825-766d-4a84-955b-ae645442f28b",
                "4400792e-6e06-4308-b528-4eb316142933"
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
            "item_id": "3fbb8c80-d168-4502-a8a1-978fad454a4f",
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
          "order_id": "da46a113-5a62-467a-acea-2e591f70f674",
          "items": [
            {
              "type": "products",
              "id": "37fa0d6d-d3d7-4117-a73b-b05a94f51a3a",
              "stock_item_ids": [
                "117d0dd6-bac4-4a14-8db1-3b38134c4147",
                "9460b4c1-96d2-4be4-aad5-d55ef821afaf",
                "22c64bf6-5b02-41e6-9de2-c6bf74e98bd1"
              ]
            },
            {
              "type": "products",
              "id": "c53989b6-94fc-4b4c-adc5-7d53c8485d8f",
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
    "id": "bee99da8-0cbb-5b6a-82ce-3019fad8b07f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "da46a113-5a62-467a-acea-2e591f70f674"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "da46a113-5a62-467a-acea-2e591f70f674"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1cf0071b-36f0-4ba1-9c73-a6e7247f71df"
          },
          {
            "type": "lines",
            "id": "0e83d80e-d1a2-4f44-829e-0043b8552c34"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e7e4bcdb-a244-4363-8bbe-c26a8dca7649"
          },
          {
            "type": "plannings",
            "id": "86411ac1-b42c-47d7-8318-13cea227f692"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e1a33cef-0c3f-4938-bdad-a2c00c00258d"
          },
          {
            "type": "stock_item_plannings",
            "id": "8f0fea2f-8d3c-4256-9c3e-380d30e2c102"
          },
          {
            "type": "stock_item_plannings",
            "id": "f2f7c3d7-2bd5-48bb-80da-ee472f25a22e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da46a113-5a62-467a-acea-2e591f70f674",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T13:11:49+00:00",
        "updated_at": "2022-07-08T13:11:51+00:00",
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
        "customer_id": "e90e0af4-9c9f-448a-b11d-42fe3216f3b8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a",
        "stop_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a"
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
      "id": "1cf0071b-36f0-4ba1-9c73-a6e7247f71df",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:51+00:00",
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
        "item_id": "c53989b6-94fc-4b4c-adc5-7d53c8485d8f",
        "tax_category_id": "f3be03ba-79bd-4e7f-9b7b-b8e5ab21ad29",
        "planning_id": "e7e4bcdb-a244-4363-8bbe-c26a8dca7649",
        "parent_line_id": null,
        "owner_id": "da46a113-5a62-467a-acea-2e591f70f674",
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
      "id": "0e83d80e-d1a2-4f44-829e-0043b8552c34",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:51+00:00",
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
        "item_id": "37fa0d6d-d3d7-4117-a73b-b05a94f51a3a",
        "tax_category_id": "f3be03ba-79bd-4e7f-9b7b-b8e5ab21ad29",
        "planning_id": "86411ac1-b42c-47d7-8318-13cea227f692",
        "parent_line_id": null,
        "owner_id": "da46a113-5a62-467a-acea-2e591f70f674",
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
      "id": "e7e4bcdb-a244-4363-8bbe-c26a8dca7649",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:51+00:00",
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
        "item_id": "c53989b6-94fc-4b4c-adc5-7d53c8485d8f",
        "order_id": "da46a113-5a62-467a-acea-2e591f70f674",
        "start_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a",
        "stop_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a",
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
      "id": "86411ac1-b42c-47d7-8318-13cea227f692",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:51+00:00",
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
        "item_id": "37fa0d6d-d3d7-4117-a73b-b05a94f51a3a",
        "order_id": "da46a113-5a62-467a-acea-2e591f70f674",
        "start_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a",
        "stop_location_id": "a95ae53a-21f9-4dfb-9b48-fa842206333a",
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
      "id": "e1a33cef-0c3f-4938-bdad-a2c00c00258d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "117d0dd6-bac4-4a14-8db1-3b38134c4147",
        "planning_id": "86411ac1-b42c-47d7-8318-13cea227f692",
        "order_id": "da46a113-5a62-467a-acea-2e591f70f674"
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
      "id": "8f0fea2f-8d3c-4256-9c3e-380d30e2c102",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9460b4c1-96d2-4be4-aad5-d55ef821afaf",
        "planning_id": "86411ac1-b42c-47d7-8318-13cea227f692",
        "order_id": "da46a113-5a62-467a-acea-2e591f70f674"
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
      "id": "f2f7c3d7-2bd5-48bb-80da-ee472f25a22e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:50+00:00",
        "updated_at": "2022-07-08T13:11:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "22c64bf6-5b02-41e6-9de2-c6bf74e98bd1",
        "planning_id": "86411ac1-b42c-47d7-8318-13cea227f692",
        "order_id": "da46a113-5a62-467a-acea-2e591f70f674"
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
          "order_id": "dd25f715-8964-4463-8e54-9db176e70d33",
          "items": [
            {
              "type": "bundles",
              "id": "7a808e39-e54b-4ea2-9b5f-bceaa0bb1dc2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f971c1e4-4f92-441f-91ae-e8ca611a243a",
                  "id": "2a593155-d831-47e5-947a-a782ac51991f"
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
    "id": "d17964c1-6909-5c21-afa7-13cea98778c2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dd25f715-8964-4463-8e54-9db176e70d33"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dd25f715-8964-4463-8e54-9db176e70d33"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "faad742f-2775-409e-b439-ef4e10fdf404"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "df45f18a-0817-4f5b-ab47-2fcb61021c1c"
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
      "id": "dd25f715-8964-4463-8e54-9db176e70d33",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T13:11:53+00:00",
        "updated_at": "2022-07-08T13:11:54+00:00",
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
        "starts_at": "2022-07-06T13:00:00+00:00",
        "stops_at": "2022-07-10T13:00:00+00:00",
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
        "start_location_id": "74515de2-828c-4487-8ca6-2e4f47636801",
        "stop_location_id": "74515de2-828c-4487-8ca6-2e4f47636801"
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
      "id": "faad742f-2775-409e-b439-ef4e10fdf404",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T13:11:53+00:00",
        "updated_at": "2022-07-08T13:11:53+00:00",
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
        "item_id": "7a808e39-e54b-4ea2-9b5f-bceaa0bb1dc2",
        "tax_category_id": null,
        "planning_id": "df45f18a-0817-4f5b-ab47-2fcb61021c1c",
        "parent_line_id": null,
        "owner_id": "dd25f715-8964-4463-8e54-9db176e70d33",
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
      "id": "df45f18a-0817-4f5b-ab47-2fcb61021c1c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T13:11:53+00:00",
        "updated_at": "2022-07-08T13:11:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-06T13:00:00+00:00",
        "stops_at": "2022-07-10T13:00:00+00:00",
        "reserved_from": "2022-07-06T13:00:00+00:00",
        "reserved_till": "2022-07-10T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7a808e39-e54b-4ea2-9b5f-bceaa0bb1dc2",
        "order_id": "dd25f715-8964-4463-8e54-9db176e70d33",
        "start_location_id": "74515de2-828c-4487-8ca6-2e4f47636801",
        "stop_location_id": "74515de2-828c-4487-8ca6-2e4f47636801",
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





