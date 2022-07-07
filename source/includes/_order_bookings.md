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
          "order_id": "c090303e-a7cc-4ac7-9f8a-304659d72f6a",
          "items": [
            {
              "type": "products",
              "id": "7c5e2952-fdec-4b73-a38c-38c34c5f1dab",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2d2c43e6-26dc-4ad8-a1ac-c823a27f96fd",
              "stock_item_ids": [
                "c8f155be-f274-4335-ad1b-919ae686f322",
                "21090f70-a776-438c-bd8c-f7cf4840bdb3"
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
            "item_id": "7c5e2952-fdec-4b73-a38c-38c34c5f1dab",
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
          "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
          "items": [
            {
              "type": "products",
              "id": "483242f8-038d-4fed-a856-746f30644527",
              "stock_item_ids": [
                "7e745640-f319-4972-bd0b-1ae0b5993b92",
                "46896d12-aef7-49b9-8501-ea7004860066",
                "3236c9e2-db7d-4729-b36f-bc6d29daaba7"
              ]
            },
            {
              "type": "products",
              "id": "36302edc-2226-463f-bf83-5c5a3bcfff1e",
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
    "id": "171276ba-cae4-5c0f-b2c6-9bda9e42534d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9dcabbdb-624b-43db-8014-5fd1b757f12d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f1194111-aea0-43f3-8e42-eb493e996db6"
          },
          {
            "type": "lines",
            "id": "b9fdd8cf-2636-4894-88ce-f909437fd108"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8ddf728a-c85e-41a9-ae1d-65871a96ad56"
          },
          {
            "type": "plannings",
            "id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f21d7ec1-6f71-4b6a-bcd5-4f2d77dde566"
          },
          {
            "type": "stock_item_plannings",
            "id": "de3a4d8e-3e52-4013-ae4e-370db403e6b5"
          },
          {
            "type": "stock_item_plannings",
            "id": "4f863a7a-62d1-4069-86c9-99438eaffc4e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-07T12:18:31+00:00",
        "updated_at": "2022-07-07T12:18:34+00:00",
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
        "customer_id": "9775c9a9-1177-46dd-a9bf-c6fb60f930df",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "17a88f26-99f5-4183-8856-04b7f8582839",
        "stop_location_id": "17a88f26-99f5-4183-8856-04b7f8582839"
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
      "id": "f1194111-aea0-43f3-8e42-eb493e996db6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:18:32+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
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
        "item_id": "36302edc-2226-463f-bf83-5c5a3bcfff1e",
        "tax_category_id": "9fb9d711-308c-45cf-bb00-53a4bb48dc9e",
        "planning_id": "8ddf728a-c85e-41a9-ae1d-65871a96ad56",
        "parent_line_id": null,
        "owner_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
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
      "id": "b9fdd8cf-2636-4894-88ce-f909437fd108",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:18:33+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
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
        "item_id": "483242f8-038d-4fed-a856-746f30644527",
        "tax_category_id": "9fb9d711-308c-45cf-bb00-53a4bb48dc9e",
        "planning_id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e",
        "parent_line_id": null,
        "owner_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
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
      "id": "8ddf728a-c85e-41a9-ae1d-65871a96ad56",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:32+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
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
        "item_id": "36302edc-2226-463f-bf83-5c5a3bcfff1e",
        "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
        "start_location_id": "17a88f26-99f5-4183-8856-04b7f8582839",
        "stop_location_id": "17a88f26-99f5-4183-8856-04b7f8582839",
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
      "id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:33+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
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
        "item_id": "483242f8-038d-4fed-a856-746f30644527",
        "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d",
        "start_location_id": "17a88f26-99f5-4183-8856-04b7f8582839",
        "stop_location_id": "17a88f26-99f5-4183-8856-04b7f8582839",
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
      "id": "f21d7ec1-6f71-4b6a-bcd5-4f2d77dde566",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:33+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7e745640-f319-4972-bd0b-1ae0b5993b92",
        "planning_id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e",
        "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d"
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
      "id": "de3a4d8e-3e52-4013-ae4e-370db403e6b5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:33+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "46896d12-aef7-49b9-8501-ea7004860066",
        "planning_id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e",
        "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d"
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
      "id": "4f863a7a-62d1-4069-86c9-99438eaffc4e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:33+00:00",
        "updated_at": "2022-07-07T12:18:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3236c9e2-db7d-4729-b36f-bc6d29daaba7",
        "planning_id": "15bdc48f-54e8-4813-930a-c7a5dd88b76e",
        "order_id": "9dcabbdb-624b-43db-8014-5fd1b757f12d"
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
          "order_id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9",
          "items": [
            {
              "type": "bundles",
              "id": "dff848e5-31d7-423b-9aba-13f363bbb78e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e94071c7-4abc-4ef2-afe0-b574c93f3710",
                  "id": "04811687-9b0b-496a-8d5d-1a6c4463c152"
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
    "id": "ef61ed4b-2224-542f-b8a8-66335fbddfcf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "00aa415a-4a24-426e-aa78-d05b7bcdf014"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "039d5c93-21db-4883-92db-1f2611f8fa57"
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
      "id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-07T12:18:36+00:00",
        "updated_at": "2022-07-07T12:18:37+00:00",
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
        "starts_at": "2022-07-05T12:15:00+00:00",
        "stops_at": "2022-07-09T12:15:00+00:00",
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
        "start_location_id": "93e0ed26-2356-412c-9103-5bd8efd76a87",
        "stop_location_id": "93e0ed26-2356-412c-9103-5bd8efd76a87"
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
      "id": "00aa415a-4a24-426e-aa78-d05b7bcdf014",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-07T12:18:37+00:00",
        "updated_at": "2022-07-07T12:18:37+00:00",
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
        "item_id": "dff848e5-31d7-423b-9aba-13f363bbb78e",
        "tax_category_id": null,
        "planning_id": "039d5c93-21db-4883-92db-1f2611f8fa57",
        "parent_line_id": null,
        "owner_id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9",
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
      "id": "039d5c93-21db-4883-92db-1f2611f8fa57",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-07T12:18:37+00:00",
        "updated_at": "2022-07-07T12:18:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-05T12:15:00+00:00",
        "stops_at": "2022-07-09T12:15:00+00:00",
        "reserved_from": "2022-07-05T12:15:00+00:00",
        "reserved_till": "2022-07-09T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "dff848e5-31d7-423b-9aba-13f363bbb78e",
        "order_id": "3e631967-6b84-400a-8cbe-3a0cb475b4d9",
        "start_location_id": "93e0ed26-2356-412c-9103-5bd8efd76a87",
        "stop_location_id": "93e0ed26-2356-412c-9103-5bd8efd76a87",
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





