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
          "order_id": "29acf113-3862-4337-8ea9-6f84163d1482",
          "items": [
            {
              "type": "products",
              "id": "e13a9cb8-4264-4c46-97ad-62b35a22d3f5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c68626ef-6d92-4218-8aac-f033910f42b7",
              "stock_item_ids": [
                "e8630033-a8ed-4024-9a67-d2d3265a42ad",
                "991c0892-55a8-4dcb-b115-228221afef9d"
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
            "item_id": "e13a9cb8-4264-4c46-97ad-62b35a22d3f5",
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
          "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
          "items": [
            {
              "type": "products",
              "id": "c1affd72-c806-4b0d-81b3-c4b5baebfd39",
              "stock_item_ids": [
                "68d0e968-4dc3-4d8d-9dde-35b5b0e934d6",
                "9ce1cb18-f7dd-43ec-b85e-5cfc3e0a5075",
                "7b1eef06-dd9a-438b-8312-949eb4529b83"
              ]
            },
            {
              "type": "products",
              "id": "7d2012b8-575c-43c2-89c7-2d9d17c085e5",
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
    "id": "0e4fd148-41a0-5677-a409-c1f3fc8d1aba",
    "type": "order_bookings",
    "attributes": {
      "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "36a311d2-0b36-42f2-9276-645d3b1860ba"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a2ccfdcf-1ac4-440b-9e9b-081712ac9e35"
          },
          {
            "type": "lines",
            "id": "70808c0e-2d81-487f-bdb3-dbe7e5fb6184"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8774a608-d107-4509-8fe9-3258a6786d18"
          },
          {
            "type": "plannings",
            "id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "57b604a1-4c9f-40bc-8095-68b0345f8d88"
          },
          {
            "type": "stock_item_plannings",
            "id": "8ebd3826-a10d-4cc1-9d72-97416d36798a"
          },
          {
            "type": "stock_item_plannings",
            "id": "3fa1e32b-4961-432b-9618-d7271f07a381"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T14:13:21+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
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
        "customer_id": "99726cad-d44f-4166-b4c7-c8c9a137f636",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "84029660-0452-4e85-a389-cd818234f0bc",
        "stop_location_id": "84029660-0452-4e85-a389-cd818234f0bc"
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
      "id": "a2ccfdcf-1ac4-440b-9e9b-081712ac9e35",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:13:21+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
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
        "item_id": "7d2012b8-575c-43c2-89c7-2d9d17c085e5",
        "tax_category_id": "dcdfb70e-c646-4b6f-a3f4-90a4890ea68c",
        "planning_id": "8774a608-d107-4509-8fe9-3258a6786d18",
        "parent_line_id": null,
        "owner_id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
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
      "id": "70808c0e-2d81-487f-bdb3-dbe7e5fb6184",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:13:23+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
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
        "item_id": "c1affd72-c806-4b0d-81b3-c4b5baebfd39",
        "tax_category_id": "dcdfb70e-c646-4b6f-a3f4-90a4890ea68c",
        "planning_id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c",
        "parent_line_id": null,
        "owner_id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
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
      "id": "8774a608-d107-4509-8fe9-3258a6786d18",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:21+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
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
        "item_id": "7d2012b8-575c-43c2-89c7-2d9d17c085e5",
        "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
        "start_location_id": "84029660-0452-4e85-a389-cd818234f0bc",
        "stop_location_id": "84029660-0452-4e85-a389-cd818234f0bc",
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
      "id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:23+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
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
        "item_id": "c1affd72-c806-4b0d-81b3-c4b5baebfd39",
        "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba",
        "start_location_id": "84029660-0452-4e85-a389-cd818234f0bc",
        "stop_location_id": "84029660-0452-4e85-a389-cd818234f0bc",
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
      "id": "57b604a1-4c9f-40bc-8095-68b0345f8d88",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:23+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "68d0e968-4dc3-4d8d-9dde-35b5b0e934d6",
        "planning_id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c",
        "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba"
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
      "id": "8ebd3826-a10d-4cc1-9d72-97416d36798a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:23+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ce1cb18-f7dd-43ec-b85e-5cfc3e0a5075",
        "planning_id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c",
        "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba"
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
      "id": "3fa1e32b-4961-432b-9618-d7271f07a381",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:23+00:00",
        "updated_at": "2022-07-12T14:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7b1eef06-dd9a-438b-8312-949eb4529b83",
        "planning_id": "ab6b4f51-00fa-42c6-a843-a7a8ff389b5c",
        "order_id": "36a311d2-0b36-42f2-9276-645d3b1860ba"
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
          "order_id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266",
          "items": [
            {
              "type": "bundles",
              "id": "91ef8572-59f0-4aaa-9f22-047c804e87ea",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6240a17d-8c4f-488b-a597-4bb30d09160e",
                  "id": "6bc86aa5-f244-4f57-a183-0e1465a827e4"
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
    "id": "3c8de70e-5bf6-5861-851f-d5faadfab7d8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6f5ebd80-5eea-4025-986a-647d57912386"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e990a32e-da84-42f2-a220-a4fd966a9c4a"
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
      "id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T14:13:27+00:00",
        "updated_at": "2022-07-12T14:13:28+00:00",
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
        "starts_at": "2022-07-10T14:00:00+00:00",
        "stops_at": "2022-07-14T14:00:00+00:00",
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
        "start_location_id": "c682d51e-c6be-4a40-9865-63c4639b1e44",
        "stop_location_id": "c682d51e-c6be-4a40-9865-63c4639b1e44"
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
      "id": "6f5ebd80-5eea-4025-986a-647d57912386",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:13:27+00:00",
        "updated_at": "2022-07-12T14:13:27+00:00",
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
        "item_id": "91ef8572-59f0-4aaa-9f22-047c804e87ea",
        "tax_category_id": null,
        "planning_id": "e990a32e-da84-42f2-a220-a4fd966a9c4a",
        "parent_line_id": null,
        "owner_id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266",
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
      "id": "e990a32e-da84-42f2-a220-a4fd966a9c4a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:13:27+00:00",
        "updated_at": "2022-07-12T14:13:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-10T14:00:00+00:00",
        "stops_at": "2022-07-14T14:00:00+00:00",
        "reserved_from": "2022-07-10T14:00:00+00:00",
        "reserved_till": "2022-07-14T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "91ef8572-59f0-4aaa-9f22-047c804e87ea",
        "order_id": "b55992b7-afb4-4623-b31b-0b7ba6e3f266",
        "start_location_id": "c682d51e-c6be-4a40-9865-63c4639b1e44",
        "stop_location_id": "c682d51e-c6be-4a40-9865-63c4639b1e44",
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





