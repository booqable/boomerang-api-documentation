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
          "order_id": "dbf1bbe7-3f0e-447d-8fe2-abaaa94c8401",
          "items": [
            {
              "type": "products",
              "id": "fce64633-652e-4e7b-b0ec-67f6f5cb9463",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6c734488-6ce7-443e-a26b-4042f9ff6fa8",
              "stock_item_ids": [
                "d78b3cf8-67fe-4934-b820-28e0c60636d9",
                "3b425c35-8464-4b73-b643-bdacaaf819ef"
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
          "stock_item_id d78b3cf8-67fe-4934-b820-28e0c60636d9 has already been booked on this order"
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
          "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922",
          "items": [
            {
              "type": "products",
              "id": "0c8d97cf-efb1-4e87-920a-aafb7ed9e221",
              "stock_item_ids": [
                "c0c117f9-804b-4d1e-bc12-e554ec4a7969",
                "93a3bdac-5d05-4bca-bb0a-0d5f44e7b3ba",
                "de825d9d-afaa-43e3-8005-2d3733bb55ee"
              ]
            },
            {
              "type": "products",
              "id": "143d3528-4186-4f24-801c-94bc7445734e",
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
    "id": "8d829aad-d6b6-5743-8819-7b690119a0b8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3b408ab5-4459-420e-81f1-a45a2b628922"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "db8ab6c5-eee3-463f-a481-53117ea19497"
          },
          {
            "type": "lines",
            "id": "075e46e8-d517-45a0-b1fe-7b8abbd49ccc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d1317cdc-9c00-400f-8d0e-113fafd9283d"
          },
          {
            "type": "plannings",
            "id": "9ce7c37c-8394-4587-8cba-744d8b6c680c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4cce2764-317b-42e9-ad49-fb28804e67de"
          },
          {
            "type": "stock_item_plannings",
            "id": "8494e6fb-fc69-4d67-84d2-b6ea54b9c8d4"
          },
          {
            "type": "stock_item_plannings",
            "id": "83c3403f-4cfe-4699-bcf5-913d231fdda5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3b408ab5-4459-420e-81f1-a45a2b628922",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T09:41:59+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
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
        "customer_id": "98f7ef08-ccd8-4780-bbfb-7581eebcec4a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde",
        "stop_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde"
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
      "id": "db8ab6c5-eee3-463f-a481-53117ea19497",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
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
        "item_id": "0c8d97cf-efb1-4e87-920a-aafb7ed9e221",
        "tax_category_id": "2d4da0ea-4c2f-4193-8d1f-ae453e3e1ebe",
        "planning_id": "d1317cdc-9c00-400f-8d0e-113fafd9283d",
        "parent_line_id": null,
        "owner_id": "3b408ab5-4459-420e-81f1-a45a2b628922",
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
      "id": "075e46e8-d517-45a0-b1fe-7b8abbd49ccc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
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
        "item_id": "143d3528-4186-4f24-801c-94bc7445734e",
        "tax_category_id": "2d4da0ea-4c2f-4193-8d1f-ae453e3e1ebe",
        "planning_id": "9ce7c37c-8394-4587-8cba-744d8b6c680c",
        "parent_line_id": null,
        "owner_id": "3b408ab5-4459-420e-81f1-a45a2b628922",
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
      "id": "d1317cdc-9c00-400f-8d0e-113fafd9283d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
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
        "item_id": "0c8d97cf-efb1-4e87-920a-aafb7ed9e221",
        "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922",
        "start_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde",
        "stop_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde",
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
      "id": "9ce7c37c-8394-4587-8cba-744d8b6c680c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
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
        "item_id": "143d3528-4186-4f24-801c-94bc7445734e",
        "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922",
        "start_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde",
        "stop_location_id": "0a607016-0e83-4f5d-be42-59295d4fafde",
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
      "id": "4cce2764-317b-42e9-ad49-fb28804e67de",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c0c117f9-804b-4d1e-bc12-e554ec4a7969",
        "planning_id": "d1317cdc-9c00-400f-8d0e-113fafd9283d",
        "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922"
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
      "id": "8494e6fb-fc69-4d67-84d2-b6ea54b9c8d4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "93a3bdac-5d05-4bca-bb0a-0d5f44e7b3ba",
        "planning_id": "d1317cdc-9c00-400f-8d0e-113fafd9283d",
        "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922"
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
      "id": "83c3403f-4cfe-4699-bcf5-913d231fdda5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:01+00:00",
        "updated_at": "2023-03-08T09:42:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "de825d9d-afaa-43e3-8005-2d3733bb55ee",
        "planning_id": "d1317cdc-9c00-400f-8d0e-113fafd9283d",
        "order_id": "3b408ab5-4459-420e-81f1-a45a2b628922"
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
          "order_id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8",
          "items": [
            {
              "type": "bundles",
              "id": "52fa79d4-af4d-41d6-8c2e-0bf53e5f2922",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f9ea47a7-58a3-4c28-ad7f-05262c93cd59",
                  "id": "7a013953-c4a2-45a9-85ad-98942dac7a03"
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
    "id": "11b39803-fc41-542b-9064-b7d5cfd95bbd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0c120eef-986a-48ea-9aaa-37d1c64ebb73"
          },
          {
            "type": "lines",
            "id": "193d4130-2028-493f-bae2-3154025d3ac7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "86964aff-9581-4cc7-afbe-3f069da0b12f"
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
      "id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T09:42:04+00:00",
        "updated_at": "2023-03-08T09:42:04+00:00",
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
        "starts_at": "2023-03-06T09:30:00+00:00",
        "stops_at": "2023-03-10T09:30:00+00:00",
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
        "start_location_id": "20a9b30d-120d-4942-95db-97ff8263f95a",
        "stop_location_id": "20a9b30d-120d-4942-95db-97ff8263f95a"
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
      "id": "0c120eef-986a-48ea-9aaa-37d1c64ebb73",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:42:04+00:00",
        "updated_at": "2023-03-08T09:42:04+00:00",
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
        "item_id": "52fa79d4-af4d-41d6-8c2e-0bf53e5f2922",
        "tax_category_id": null,
        "planning_id": "86964aff-9581-4cc7-afbe-3f069da0b12f",
        "parent_line_id": null,
        "owner_id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8",
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
      "id": "193d4130-2028-493f-bae2-3154025d3ac7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T09:42:04+00:00",
        "updated_at": "2023-03-08T09:42:04+00:00",
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
        "item_id": "7a013953-c4a2-45a9-85ad-98942dac7a03",
        "tax_category_id": null,
        "planning_id": "98baf06b-3b83-4692-9cab-15b0cb9e8692",
        "parent_line_id": "0c120eef-986a-48ea-9aaa-37d1c64ebb73",
        "owner_id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8",
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
      "id": "86964aff-9581-4cc7-afbe-3f069da0b12f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T09:42:04+00:00",
        "updated_at": "2023-03-08T09:42:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-06T09:30:00+00:00",
        "stops_at": "2023-03-10T09:30:00+00:00",
        "reserved_from": "2023-03-06T09:30:00+00:00",
        "reserved_till": "2023-03-10T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "52fa79d4-af4d-41d6-8c2e-0bf53e5f2922",
        "order_id": "d4a34b4c-b017-42c2-af9c-36e996c3e4a8",
        "start_location_id": "20a9b30d-120d-4942-95db-97ff8263f95a",
        "stop_location_id": "20a9b30d-120d-4942-95db-97ff8263f95a",
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





