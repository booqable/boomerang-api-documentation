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
          "order_id": "66256160-6bb7-4669-ad23-a0e3a7ff14eb",
          "items": [
            {
              "type": "products",
              "id": "88299d3f-3bef-4b6c-a05f-45fc631b7b85",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4a903876-115b-4e78-beb3-963f8d3b71c6",
              "stock_item_ids": [
                "a248e635-5e66-4a68-8b53-f403109867e0",
                "108238fc-ea97-479b-89d1-c7ed61de1525"
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
            "item_id": "88299d3f-3bef-4b6c-a05f-45fc631b7b85",
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
          "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
          "items": [
            {
              "type": "products",
              "id": "da3bdd6e-d7b5-44af-8843-48ded9c28565",
              "stock_item_ids": [
                "3b0b04e6-eda9-4919-b4b3-eae27e239b25",
                "5930cc51-39f8-43c9-a75c-c0856e0745ad",
                "7562332f-b636-441b-9bf9-dd33bdab1de3"
              ]
            },
            {
              "type": "products",
              "id": "d9b32bb5-2727-4738-91a6-586e1f8ebb2b",
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
    "id": "122c84b5-688f-5861-8f3e-5adcd5b791f2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5328273a-6a7c-4182-963b-4bba93a6605a"
          },
          {
            "type": "lines",
            "id": "9edb29ad-b49b-40a9-bad3-0e1885581353"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f"
          },
          {
            "type": "plannings",
            "id": "34e2bd0d-5073-4fb6-9fb9-55c7ac272d4e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c2f6f535-59f1-4a17-966c-8b7da612f95c"
          },
          {
            "type": "stock_item_plannings",
            "id": "9cbdaa01-84b1-485d-ac6e-6498055e7de3"
          },
          {
            "type": "stock_item_plannings",
            "id": "738ce97a-4aa8-4f5a-976d-f9f93f2fb548"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:44:46+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
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
        "customer_id": "fa087605-6d29-43c5-aa3e-45662577888f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696",
        "stop_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696"
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
      "id": "5328273a-6a7c-4182-963b-4bba93a6605a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
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
        "item_id": "da3bdd6e-d7b5-44af-8843-48ded9c28565",
        "tax_category_id": "b83f16d5-0745-4270-ab03-fe1edfcbf653",
        "planning_id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f",
        "parent_line_id": null,
        "owner_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
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
      "id": "9edb29ad-b49b-40a9-bad3-0e1885581353",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
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
        "item_id": "d9b32bb5-2727-4738-91a6-586e1f8ebb2b",
        "tax_category_id": "b83f16d5-0745-4270-ab03-fe1edfcbf653",
        "planning_id": "34e2bd0d-5073-4fb6-9fb9-55c7ac272d4e",
        "parent_line_id": null,
        "owner_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
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
      "id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
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
        "item_id": "da3bdd6e-d7b5-44af-8843-48ded9c28565",
        "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
        "start_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696",
        "stop_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696",
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
      "id": "34e2bd0d-5073-4fb6-9fb9-55c7ac272d4e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
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
        "item_id": "d9b32bb5-2727-4738-91a6-586e1f8ebb2b",
        "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362",
        "start_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696",
        "stop_location_id": "27177bd5-d9c8-4fb5-a392-9ab8eb815696",
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
      "id": "c2f6f535-59f1-4a17-966c-8b7da612f95c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b0b04e6-eda9-4919-b4b3-eae27e239b25",
        "planning_id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f",
        "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362"
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
      "id": "9cbdaa01-84b1-485d-ac6e-6498055e7de3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5930cc51-39f8-43c9-a75c-c0856e0745ad",
        "planning_id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f",
        "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362"
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
      "id": "738ce97a-4aa8-4f5a-976d-f9f93f2fb548",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:48+00:00",
        "updated_at": "2023-01-05T13:44:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7562332f-b636-441b-9bf9-dd33bdab1de3",
        "planning_id": "24ea9ea1-3d40-462e-b547-2b102a6ade5f",
        "order_id": "2f840973-2fbc-4d53-bb7b-90e75e0c4362"
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
          "order_id": "df166670-83ea-47ec-bbd3-8d924533210b",
          "items": [
            {
              "type": "bundles",
              "id": "8c29a9b0-ca4d-466f-9cf9-20c39d3e77c2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1012f26d-30b4-4996-a120-7818119935d7",
                  "id": "50fa5b75-cec2-42c6-8733-2c3e7ffb452a"
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
    "id": "87f2b362-3ac2-586e-a1c5-2cd3f0aafd88",
    "type": "order_bookings",
    "attributes": {
      "order_id": "df166670-83ea-47ec-bbd3-8d924533210b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "df166670-83ea-47ec-bbd3-8d924533210b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c1b52a50-b1cb-4232-aea3-80b3e83d2fdd"
          },
          {
            "type": "lines",
            "id": "f9001c06-72f6-4275-9693-03c22d34ee0d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "461deb03-06b0-42a1-9c1d-553864951042"
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
      "id": "df166670-83ea-47ec-bbd3-8d924533210b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:44:51+00:00",
        "updated_at": "2023-01-05T13:44:51+00:00",
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
        "starts_at": "2023-01-03T13:30:00+00:00",
        "stops_at": "2023-01-07T13:30:00+00:00",
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
        "start_location_id": "a25666bf-1f1a-41d7-aeec-1f0a143f6f8a",
        "stop_location_id": "a25666bf-1f1a-41d7-aeec-1f0a143f6f8a"
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
      "id": "c1b52a50-b1cb-4232-aea3-80b3e83d2fdd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:44:51+00:00",
        "updated_at": "2023-01-05T13:44:51+00:00",
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
        "item_id": "8c29a9b0-ca4d-466f-9cf9-20c39d3e77c2",
        "tax_category_id": null,
        "planning_id": "461deb03-06b0-42a1-9c1d-553864951042",
        "parent_line_id": null,
        "owner_id": "df166670-83ea-47ec-bbd3-8d924533210b",
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
      "id": "f9001c06-72f6-4275-9693-03c22d34ee0d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:44:51+00:00",
        "updated_at": "2023-01-05T13:44:51+00:00",
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
        "item_id": "50fa5b75-cec2-42c6-8733-2c3e7ffb452a",
        "tax_category_id": null,
        "planning_id": "73795d4c-5382-4e06-9586-d1322576853b",
        "parent_line_id": "c1b52a50-b1cb-4232-aea3-80b3e83d2fdd",
        "owner_id": "df166670-83ea-47ec-bbd3-8d924533210b",
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
      "id": "461deb03-06b0-42a1-9c1d-553864951042",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:44:51+00:00",
        "updated_at": "2023-01-05T13:44:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T13:30:00+00:00",
        "stops_at": "2023-01-07T13:30:00+00:00",
        "reserved_from": "2023-01-03T13:30:00+00:00",
        "reserved_till": "2023-01-07T13:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8c29a9b0-ca4d-466f-9cf9-20c39d3e77c2",
        "order_id": "df166670-83ea-47ec-bbd3-8d924533210b",
        "start_location_id": "a25666bf-1f1a-41d7-aeec-1f0a143f6f8a",
        "stop_location_id": "a25666bf-1f1a-41d7-aeec-1f0a143f6f8a",
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





