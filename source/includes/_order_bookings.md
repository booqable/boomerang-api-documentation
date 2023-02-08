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
          "order_id": "bb3b4863-da3a-4bb7-957f-06783ebea593",
          "items": [
            {
              "type": "products",
              "id": "a43f0c73-58ab-4208-91b7-c18676cba72b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "796737fa-1f30-4c92-8047-6a401fc887bc",
              "stock_item_ids": [
                "b026473f-0e98-4b71-b063-13fa1701eb96",
                "f7832804-3404-4a8b-a7e3-d826112fefd7"
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
            "item_id": "a43f0c73-58ab-4208-91b7-c18676cba72b",
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
          "order_id": "5686808e-4039-4c96-844b-22d03d37bf06",
          "items": [
            {
              "type": "products",
              "id": "3f4b30d2-8a8e-45a3-b228-f1c1e89d4395",
              "stock_item_ids": [
                "5b53d03e-e3c3-405b-b04b-7eb3114cad6e",
                "1e0d6269-d65b-4e7a-9dee-d365bfe17d3a",
                "eea43989-740e-447a-9cc5-0ea031a84fb8"
              ]
            },
            {
              "type": "products",
              "id": "23927796-7748-48aa-8d43-7ab8ddc203e4",
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
    "id": "cafc3da8-8abd-5d80-ab56-8094f9f3151d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5686808e-4039-4c96-844b-22d03d37bf06"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5686808e-4039-4c96-844b-22d03d37bf06"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "949a66ca-5648-47b8-9cb8-25eb314ebd48"
          },
          {
            "type": "lines",
            "id": "521904c5-7a36-42af-8af0-1ffeda7ed380"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7"
          },
          {
            "type": "plannings",
            "id": "d0e8977b-2c78-4f9d-ab5a-f6f5712588de"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e022b347-3ef8-46bf-8b1f-7c45026f5f76"
          },
          {
            "type": "stock_item_plannings",
            "id": "df2e7044-3c82-4ab8-a934-24b3654f0fc0"
          },
          {
            "type": "stock_item_plannings",
            "id": "354c3bfa-b3c6-488e-bdd7-f8ed7faee5f2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5686808e-4039-4c96-844b-22d03d37bf06",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:00:27+00:00",
        "updated_at": "2023-02-08T15:00:29+00:00",
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
        "customer_id": "0966f5ab-2b1b-4cc3-bb34-6dd6843062d6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9",
        "stop_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9"
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
      "id": "949a66ca-5648-47b8-9cb8-25eb314ebd48",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:28+00:00",
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
        "item_id": "3f4b30d2-8a8e-45a3-b228-f1c1e89d4395",
        "tax_category_id": "aafa43b1-6bb4-4eb5-9005-9ad9d00365b4",
        "planning_id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7",
        "parent_line_id": null,
        "owner_id": "5686808e-4039-4c96-844b-22d03d37bf06",
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
      "id": "521904c5-7a36-42af-8af0-1ffeda7ed380",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:28+00:00",
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
        "item_id": "23927796-7748-48aa-8d43-7ab8ddc203e4",
        "tax_category_id": "aafa43b1-6bb4-4eb5-9005-9ad9d00365b4",
        "planning_id": "d0e8977b-2c78-4f9d-ab5a-f6f5712588de",
        "parent_line_id": null,
        "owner_id": "5686808e-4039-4c96-844b-22d03d37bf06",
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
      "id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:29+00:00",
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
        "item_id": "3f4b30d2-8a8e-45a3-b228-f1c1e89d4395",
        "order_id": "5686808e-4039-4c96-844b-22d03d37bf06",
        "start_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9",
        "stop_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9",
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
      "id": "d0e8977b-2c78-4f9d-ab5a-f6f5712588de",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:29+00:00",
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
        "item_id": "23927796-7748-48aa-8d43-7ab8ddc203e4",
        "order_id": "5686808e-4039-4c96-844b-22d03d37bf06",
        "start_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9",
        "stop_location_id": "d7122876-d3ed-47a8-99d0-ee2230d64cd9",
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
      "id": "e022b347-3ef8-46bf-8b1f-7c45026f5f76",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5b53d03e-e3c3-405b-b04b-7eb3114cad6e",
        "planning_id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7",
        "order_id": "5686808e-4039-4c96-844b-22d03d37bf06"
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
      "id": "df2e7044-3c82-4ab8-a934-24b3654f0fc0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1e0d6269-d65b-4e7a-9dee-d365bfe17d3a",
        "planning_id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7",
        "order_id": "5686808e-4039-4c96-844b-22d03d37bf06"
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
      "id": "354c3bfa-b3c6-488e-bdd7-f8ed7faee5f2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:28+00:00",
        "updated_at": "2023-02-08T15:00:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eea43989-740e-447a-9cc5-0ea031a84fb8",
        "planning_id": "ca0e63d6-979b-41b9-b8b4-f264649db3e7",
        "order_id": "5686808e-4039-4c96-844b-22d03d37bf06"
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
          "order_id": "aa21b167-746d-4533-87cc-7001197c242d",
          "items": [
            {
              "type": "bundles",
              "id": "c2dfffce-f8a4-4c26-98ec-f8a761ab82c1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "785d5ccb-d5f0-466a-923c-cf18ade374c2",
                  "id": "6a70149e-3cd2-40ac-9729-5e8dd26191a6"
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
    "id": "3a02cbea-9bff-572d-b02f-8cc8c2685956",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aa21b167-746d-4533-87cc-7001197c242d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aa21b167-746d-4533-87cc-7001197c242d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5754e88d-cea0-4d65-a14a-fffd44eae686"
          },
          {
            "type": "lines",
            "id": "249327ed-b669-4869-bcea-aa7a59f3b699"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3941c297-7146-4e38-9672-01ada12af46d"
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
      "id": "aa21b167-746d-4533-87cc-7001197c242d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:00:31+00:00",
        "updated_at": "2023-02-08T15:00:32+00:00",
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
        "starts_at": "2023-02-06T15:00:00+00:00",
        "stops_at": "2023-02-10T15:00:00+00:00",
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
        "start_location_id": "9647b1f7-0167-45ed-9edf-dd693f3f3814",
        "stop_location_id": "9647b1f7-0167-45ed-9edf-dd693f3f3814"
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
      "id": "5754e88d-cea0-4d65-a14a-fffd44eae686",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:31+00:00",
        "updated_at": "2023-02-08T15:00:31+00:00",
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
        "item_id": "c2dfffce-f8a4-4c26-98ec-f8a761ab82c1",
        "tax_category_id": null,
        "planning_id": "3941c297-7146-4e38-9672-01ada12af46d",
        "parent_line_id": null,
        "owner_id": "aa21b167-746d-4533-87cc-7001197c242d",
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
      "id": "249327ed-b669-4869-bcea-aa7a59f3b699",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:31+00:00",
        "updated_at": "2023-02-08T15:00:31+00:00",
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
        "item_id": "6a70149e-3cd2-40ac-9729-5e8dd26191a6",
        "tax_category_id": null,
        "planning_id": "a7320611-3a44-4264-8645-44a1b60dc0f2",
        "parent_line_id": "5754e88d-cea0-4d65-a14a-fffd44eae686",
        "owner_id": "aa21b167-746d-4533-87cc-7001197c242d",
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
      "id": "3941c297-7146-4e38-9672-01ada12af46d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:31+00:00",
        "updated_at": "2023-02-08T15:00:31+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T15:00:00+00:00",
        "stops_at": "2023-02-10T15:00:00+00:00",
        "reserved_from": "2023-02-06T15:00:00+00:00",
        "reserved_till": "2023-02-10T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c2dfffce-f8a4-4c26-98ec-f8a761ab82c1",
        "order_id": "aa21b167-746d-4533-87cc-7001197c242d",
        "start_location_id": "9647b1f7-0167-45ed-9edf-dd693f3f3814",
        "stop_location_id": "9647b1f7-0167-45ed-9edf-dd693f3f3814",
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





