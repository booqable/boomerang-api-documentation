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
          "order_id": "35941790-db24-445e-886b-d2b4aceb4d54",
          "items": [
            {
              "type": "products",
              "id": "fd51b852-3689-4242-ab94-6fc5f09732f2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "29397a67-7e1a-4421-93ce-70b35b2873be",
              "stock_item_ids": [
                "41b87eb0-e3f1-4e8a-bbc8-5b86ef297a22",
                "d1066931-65a6-4639-8caf-364fa839f172"
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
            "item_id": "fd51b852-3689-4242-ab94-6fc5f09732f2",
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
          "order_id": "96fa7e70-d99b-41b7-9006-617333009f56",
          "items": [
            {
              "type": "products",
              "id": "081298f3-472d-4c5b-9b6d-a3365bc3cc80",
              "stock_item_ids": [
                "3b29c29b-cad3-4eae-a073-4123d63ec71f",
                "d7407e02-1b7f-43b0-bf33-17a3489323b3",
                "8b63583c-d550-4bdc-a79d-8d2e59e43d0c"
              ]
            },
            {
              "type": "products",
              "id": "e37354a6-d082-4508-a5be-33bd6b64e706",
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
    "id": "d89bd873-5b6d-5964-a20a-a62500189320",
    "type": "order_bookings",
    "attributes": {
      "order_id": "96fa7e70-d99b-41b7-9006-617333009f56"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "96fa7e70-d99b-41b7-9006-617333009f56"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "374459b2-b4b6-4ead-8fc5-8d4de51e7858"
          },
          {
            "type": "lines",
            "id": "f0580b0b-4073-49ac-8ca3-952d17e8407f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "271daa3b-5687-4e52-9278-9d25394554dd"
          },
          {
            "type": "plannings",
            "id": "bc79c318-d932-489d-8489-81f87650a79c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "92c027b4-6675-4e40-9abd-e4016a0ed797"
          },
          {
            "type": "stock_item_plannings",
            "id": "be712d9e-b4d5-45a6-8036-4a6ba52d7068"
          },
          {
            "type": "stock_item_plannings",
            "id": "060ab5a0-aa7e-4c1e-a6bc-098e58df12b8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "96fa7e70-d99b-41b7-9006-617333009f56",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T19:30:19+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
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
        "customer_id": "72ea09f7-5f10-471a-beb9-3277e184a190",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "75684186-180a-442d-a57f-ffa702a5704b",
        "stop_location_id": "75684186-180a-442d-a57f-ffa702a5704b"
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
      "id": "374459b2-b4b6-4ead-8fc5-8d4de51e7858",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
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
        "item_id": "081298f3-472d-4c5b-9b6d-a3365bc3cc80",
        "tax_category_id": "a55b5a1c-2e02-42ba-b639-dddf9b749297",
        "planning_id": "271daa3b-5687-4e52-9278-9d25394554dd",
        "parent_line_id": null,
        "owner_id": "96fa7e70-d99b-41b7-9006-617333009f56",
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
      "id": "f0580b0b-4073-49ac-8ca3-952d17e8407f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
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
        "item_id": "e37354a6-d082-4508-a5be-33bd6b64e706",
        "tax_category_id": "a55b5a1c-2e02-42ba-b639-dddf9b749297",
        "planning_id": "bc79c318-d932-489d-8489-81f87650a79c",
        "parent_line_id": null,
        "owner_id": "96fa7e70-d99b-41b7-9006-617333009f56",
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
      "id": "271daa3b-5687-4e52-9278-9d25394554dd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
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
        "item_id": "081298f3-472d-4c5b-9b6d-a3365bc3cc80",
        "order_id": "96fa7e70-d99b-41b7-9006-617333009f56",
        "start_location_id": "75684186-180a-442d-a57f-ffa702a5704b",
        "stop_location_id": "75684186-180a-442d-a57f-ffa702a5704b",
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
      "id": "bc79c318-d932-489d-8489-81f87650a79c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
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
        "item_id": "e37354a6-d082-4508-a5be-33bd6b64e706",
        "order_id": "96fa7e70-d99b-41b7-9006-617333009f56",
        "start_location_id": "75684186-180a-442d-a57f-ffa702a5704b",
        "stop_location_id": "75684186-180a-442d-a57f-ffa702a5704b",
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
      "id": "92c027b4-6675-4e40-9abd-e4016a0ed797",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b29c29b-cad3-4eae-a073-4123d63ec71f",
        "planning_id": "271daa3b-5687-4e52-9278-9d25394554dd",
        "order_id": "96fa7e70-d99b-41b7-9006-617333009f56"
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
      "id": "be712d9e-b4d5-45a6-8036-4a6ba52d7068",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d7407e02-1b7f-43b0-bf33-17a3489323b3",
        "planning_id": "271daa3b-5687-4e52-9278-9d25394554dd",
        "order_id": "96fa7e70-d99b-41b7-9006-617333009f56"
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
      "id": "060ab5a0-aa7e-4c1e-a6bc-098e58df12b8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:21+00:00",
        "updated_at": "2023-02-06T19:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b63583c-d550-4bdc-a79d-8d2e59e43d0c",
        "planning_id": "271daa3b-5687-4e52-9278-9d25394554dd",
        "order_id": "96fa7e70-d99b-41b7-9006-617333009f56"
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
          "order_id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a",
          "items": [
            {
              "type": "bundles",
              "id": "d90ab1da-8ca2-4b07-a8b4-3b8a041d43a7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8185c35b-ec4a-4469-80bb-8d08bc154be9",
                  "id": "d11f2d4e-834b-46bc-ab9a-e2dd5fbb1b9c"
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
    "id": "30a73005-ae58-5640-8739-772379581391",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e59a260f-ec7c-48ba-aa01-8bd74fc9fcc6"
          },
          {
            "type": "lines",
            "id": "f65e9a94-9e1a-43c3-82b6-bfefb5969ca7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bdb832d1-645c-43c6-bf43-5f795de624dc"
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
      "id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T19:30:23+00:00",
        "updated_at": "2023-02-06T19:30:24+00:00",
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
        "starts_at": "2023-02-04T19:30:00+00:00",
        "stops_at": "2023-02-08T19:30:00+00:00",
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
        "start_location_id": "00ae21a2-6e9e-4467-b4ec-b46ef8c6ad27",
        "stop_location_id": "00ae21a2-6e9e-4467-b4ec-b46ef8c6ad27"
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
      "id": "e59a260f-ec7c-48ba-aa01-8bd74fc9fcc6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T19:30:24+00:00",
        "updated_at": "2023-02-06T19:30:24+00:00",
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
        "item_id": "d11f2d4e-834b-46bc-ab9a-e2dd5fbb1b9c",
        "tax_category_id": null,
        "planning_id": "129e9593-2f11-41c1-a3a4-83b502f5ecaa",
        "parent_line_id": "f65e9a94-9e1a-43c3-82b6-bfefb5969ca7",
        "owner_id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a",
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
      "id": "f65e9a94-9e1a-43c3-82b6-bfefb5969ca7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T19:30:24+00:00",
        "updated_at": "2023-02-06T19:30:24+00:00",
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
        "item_id": "d90ab1da-8ca2-4b07-a8b4-3b8a041d43a7",
        "tax_category_id": null,
        "planning_id": "bdb832d1-645c-43c6-bf43-5f795de624dc",
        "parent_line_id": null,
        "owner_id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a",
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
      "id": "bdb832d1-645c-43c6-bf43-5f795de624dc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T19:30:24+00:00",
        "updated_at": "2023-02-06T19:30:24+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-04T19:30:00+00:00",
        "stops_at": "2023-02-08T19:30:00+00:00",
        "reserved_from": "2023-02-04T19:30:00+00:00",
        "reserved_till": "2023-02-08T19:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d90ab1da-8ca2-4b07-a8b4-3b8a041d43a7",
        "order_id": "9021c4f1-04ef-4a51-b008-bc12a2a67d2a",
        "start_location_id": "00ae21a2-6e9e-4467-b4ec-b46ef8c6ad27",
        "stop_location_id": "00ae21a2-6e9e-4467-b4ec-b46ef8c6ad27",
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





