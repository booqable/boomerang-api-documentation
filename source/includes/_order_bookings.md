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
          "order_id": "32d632e2-7c4d-4a1e-9390-ac676f774424",
          "items": [
            {
              "type": "products",
              "id": "48b8854f-47de-497e-9f9b-9c2b9822f4a8",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b9db66e0-67c0-4187-8f68-d238352193b3",
              "stock_item_ids": [
                "fc784950-bf98-4412-b34d-031762171af3",
                "6a5f56d2-5d54-4cfc-a166-6f1b12c0c89c"
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
            "item_id": "48b8854f-47de-497e-9f9b-9c2b9822f4a8",
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
          "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
          "items": [
            {
              "type": "products",
              "id": "3294ccd1-b600-4c56-a441-d6ad58ea5167",
              "stock_item_ids": [
                "1b25d611-840d-4409-9617-d3310e220fac",
                "d93b9ef7-d1b5-4682-b55d-a16b3822300f",
                "cf02aebd-b1cc-41b2-ac32-81595ab60de0"
              ]
            },
            {
              "type": "products",
              "id": "e935992e-bb29-4509-b4d4-2fdd2120cb76",
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
    "id": "79b97306-e003-5858-925d-0bdf021f5845",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "70fd4a5f-64b9-4341-a666-14b8820499b8"
          },
          {
            "type": "lines",
            "id": "75cfa253-b2db-45a1-a319-8fdef8b71fc6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2b24bd4f-16f8-4bb7-8e9c-44b0ec8eef77"
          },
          {
            "type": "plannings",
            "id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "133f2c8a-7e1d-4be8-bea6-5e680e0d4d8b"
          },
          {
            "type": "stock_item_plannings",
            "id": "73ee4fc9-94b9-44dc-81b5-35bc0e42cea8"
          },
          {
            "type": "stock_item_plannings",
            "id": "c90983b8-d927-453e-ba20-19429d0f734a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T10:17:28+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
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
        "customer_id": "ded8e433-3da4-4058-8992-aa782fc04b9b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3",
        "stop_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3"
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
      "id": "70fd4a5f-64b9-4341-a666-14b8820499b8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:17:29+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
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
        "item_id": "e935992e-bb29-4509-b4d4-2fdd2120cb76",
        "tax_category_id": "cf423093-cb5c-4063-8ca3-310436d1e3d7",
        "planning_id": "2b24bd4f-16f8-4bb7-8e9c-44b0ec8eef77",
        "parent_line_id": null,
        "owner_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
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
      "id": "75cfa253-b2db-45a1-a319-8fdef8b71fc6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:17:30+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
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
        "item_id": "3294ccd1-b600-4c56-a441-d6ad58ea5167",
        "tax_category_id": "cf423093-cb5c-4063-8ca3-310436d1e3d7",
        "planning_id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12",
        "parent_line_id": null,
        "owner_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
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
      "id": "2b24bd4f-16f8-4bb7-8e9c-44b0ec8eef77",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:29+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
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
        "item_id": "e935992e-bb29-4509-b4d4-2fdd2120cb76",
        "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
        "start_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3",
        "stop_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3",
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
      "id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:30+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
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
        "item_id": "3294ccd1-b600-4c56-a441-d6ad58ea5167",
        "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7",
        "start_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3",
        "stop_location_id": "73978a15-8e28-4a19-9bff-adac2d2b4ac3",
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
      "id": "133f2c8a-7e1d-4be8-bea6-5e680e0d4d8b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:30+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1b25d611-840d-4409-9617-d3310e220fac",
        "planning_id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12",
        "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7"
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
      "id": "73ee4fc9-94b9-44dc-81b5-35bc0e42cea8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:30+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d93b9ef7-d1b5-4682-b55d-a16b3822300f",
        "planning_id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12",
        "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7"
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
      "id": "c90983b8-d927-453e-ba20-19429d0f734a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:30+00:00",
        "updated_at": "2022-04-07T10:17:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cf02aebd-b1cc-41b2-ac32-81595ab60de0",
        "planning_id": "3c6d03e5-c501-4453-86bd-99dd1d95eb12",
        "order_id": "d5bf529a-034c-4db5-aa5c-e803d27d2ba7"
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
          "order_id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c",
          "items": [
            {
              "type": "bundles",
              "id": "8161aa5d-8607-4dac-bd2c-ad6d5590db37",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c1c1da62-aa58-4e75-8a2b-8c4800af17ba",
                  "id": "4c31edb1-0ccb-4a5f-bf59-f5e3fe39e144"
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
    "id": "15a00c19-521d-5ea8-90bf-7251e24f9fc7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "091ed2a4-1f7f-42e8-b2a7-15dd4e94edf1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d2e56db7-ad86-4ca6-af06-ed6e264aa894"
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
      "id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T10:17:32+00:00",
        "updated_at": "2022-04-07T10:17:33+00:00",
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
        "starts_at": "2022-04-05T10:15:00+00:00",
        "stops_at": "2022-04-09T10:15:00+00:00",
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
        "start_location_id": "39bc8851-a392-46e4-92bf-470aa36ef2c7",
        "stop_location_id": "39bc8851-a392-46e4-92bf-470aa36ef2c7"
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
      "id": "091ed2a4-1f7f-42e8-b2a7-15dd4e94edf1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:17:33+00:00",
        "updated_at": "2022-04-07T10:17:33+00:00",
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
        "item_id": "8161aa5d-8607-4dac-bd2c-ad6d5590db37",
        "tax_category_id": null,
        "planning_id": "d2e56db7-ad86-4ca6-af06-ed6e264aa894",
        "parent_line_id": null,
        "owner_id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c",
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
      "id": "d2e56db7-ad86-4ca6-af06-ed6e264aa894",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:17:33+00:00",
        "updated_at": "2022-04-07T10:17:33+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-05T10:15:00+00:00",
        "stops_at": "2022-04-09T10:15:00+00:00",
        "reserved_from": "2022-04-05T10:15:00+00:00",
        "reserved_till": "2022-04-09T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8161aa5d-8607-4dac-bd2c-ad6d5590db37",
        "order_id": "8abb185e-8910-4f70-ad11-d1a15a5b0c1c",
        "start_location_id": "39bc8851-a392-46e4-92bf-470aa36ef2c7",
        "stop_location_id": "39bc8851-a392-46e4-92bf-470aa36ef2c7",
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





