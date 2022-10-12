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
          "order_id": "572c5738-718b-4193-b7d8-faafc7df70d5",
          "items": [
            {
              "type": "products",
              "id": "77933687-5acb-44d2-96b4-fe252b91bc56",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a0fcbcfa-a578-43ff-91d9-034d1adc3e5f",
              "stock_item_ids": [
                "ce196389-d602-436e-b5cb-ed11d2f76326",
                "e134bb8b-af2e-4501-8f57-4220642f4308"
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
            "item_id": "77933687-5acb-44d2-96b4-fe252b91bc56",
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
          "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
          "items": [
            {
              "type": "products",
              "id": "550a723e-bcba-4cb7-9f4d-8e968533725d",
              "stock_item_ids": [
                "489bf894-1a87-4d85-9969-faa431c2d225",
                "cb3097bc-f9c3-4f4e-bd84-b9d1ead23719",
                "927fdf42-824b-46db-97da-601e3504ddd0"
              ]
            },
            {
              "type": "products",
              "id": "2947f54f-f533-4e69-8b61-08c6f496e06f",
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
    "id": "79c8e82b-7e23-5396-8377-e2d1ff620249",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5643dafc-050e-4c0c-8722-0cdba53f5cae"
          },
          {
            "type": "lines",
            "id": "5fac5f86-8f38-45f4-915f-0b9bd2ebea88"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24"
          },
          {
            "type": "plannings",
            "id": "cb0a02c9-a725-4077-946c-caf9e7dc8d13"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b1589fbf-8130-4408-95a9-1f56ea74ae97"
          },
          {
            "type": "stock_item_plannings",
            "id": "831c2c3e-8c2c-45ac-8fc4-c34845063c81"
          },
          {
            "type": "stock_item_plannings",
            "id": "d9d4c5bc-386b-4116-a9f4-171aa9fd1059"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-12T12:58:37+00:00",
        "updated_at": "2022-10-12T12:58:40+00:00",
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
        "customer_id": "e15abbc3-b94e-4267-a2d1-e9c6086388e0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db",
        "stop_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db"
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
      "id": "5643dafc-050e-4c0c-8722-0cdba53f5cae",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:39+00:00",
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
        "item_id": "550a723e-bcba-4cb7-9f4d-8e968533725d",
        "tax_category_id": "5114f808-4faf-4bc3-b025-af291ce47064",
        "planning_id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24",
        "parent_line_id": null,
        "owner_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
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
      "id": "5fac5f86-8f38-45f4-915f-0b9bd2ebea88",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:39+00:00",
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
        "item_id": "2947f54f-f533-4e69-8b61-08c6f496e06f",
        "tax_category_id": "5114f808-4faf-4bc3-b025-af291ce47064",
        "planning_id": "cb0a02c9-a725-4077-946c-caf9e7dc8d13",
        "parent_line_id": null,
        "owner_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
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
      "id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:40+00:00",
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
        "item_id": "550a723e-bcba-4cb7-9f4d-8e968533725d",
        "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
        "start_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db",
        "stop_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db",
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
      "id": "cb0a02c9-a725-4077-946c-caf9e7dc8d13",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:40+00:00",
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
        "item_id": "2947f54f-f533-4e69-8b61-08c6f496e06f",
        "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c",
        "start_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db",
        "stop_location_id": "f3a1737a-c662-4310-ab77-f8311707b4db",
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
      "id": "b1589fbf-8130-4408-95a9-1f56ea74ae97",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "489bf894-1a87-4d85-9969-faa431c2d225",
        "planning_id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24",
        "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c"
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
      "id": "831c2c3e-8c2c-45ac-8fc4-c34845063c81",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cb3097bc-f9c3-4f4e-bd84-b9d1ead23719",
        "planning_id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24",
        "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c"
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
      "id": "d9d4c5bc-386b-4116-a9f4-171aa9fd1059",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:39+00:00",
        "updated_at": "2022-10-12T12:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "927fdf42-824b-46db-97da-601e3504ddd0",
        "planning_id": "2a9c2eda-3ad0-407c-b1b7-cd6dd5711b24",
        "order_id": "fd2b0b1e-4f46-457c-bc72-e2f24755d38c"
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
          "order_id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4",
          "items": [
            {
              "type": "bundles",
              "id": "76c3adfd-079a-4465-9113-cf95f8a9182f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "39000a9c-5fb5-462f-a638-da71f50f0bbb",
                  "id": "3cde13d2-871d-4962-9ff5-4e1ebd775e77"
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
    "id": "f2a6ee05-523e-5f74-a7c3-287e571c029c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bbfff942-554f-4cc0-a3db-dfe7ba1bab24"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "03ad294d-a94a-4e7b-b986-bb991cbc64ea"
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
      "id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-12T12:58:43+00:00",
        "updated_at": "2022-10-12T12:58:44+00:00",
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
        "starts_at": "2022-10-10T12:45:00+00:00",
        "stops_at": "2022-10-14T12:45:00+00:00",
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
        "start_location_id": "0c43b175-02ab-4c58-920f-d46c6ea91122",
        "stop_location_id": "0c43b175-02ab-4c58-920f-d46c6ea91122"
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
      "id": "bbfff942-554f-4cc0-a3db-dfe7ba1bab24",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-12T12:58:43+00:00",
        "updated_at": "2022-10-12T12:58:43+00:00",
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
        "item_id": "76c3adfd-079a-4465-9113-cf95f8a9182f",
        "tax_category_id": null,
        "planning_id": "03ad294d-a94a-4e7b-b986-bb991cbc64ea",
        "parent_line_id": null,
        "owner_id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4",
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
      "id": "03ad294d-a94a-4e7b-b986-bb991cbc64ea",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-12T12:58:43+00:00",
        "updated_at": "2022-10-12T12:58:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-10T12:45:00+00:00",
        "stops_at": "2022-10-14T12:45:00+00:00",
        "reserved_from": "2022-10-10T12:45:00+00:00",
        "reserved_till": "2022-10-14T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "76c3adfd-079a-4465-9113-cf95f8a9182f",
        "order_id": "965c186d-df6e-4b18-81cf-ca90fce5d9b4",
        "start_location_id": "0c43b175-02ab-4c58-920f-d46c6ea91122",
        "stop_location_id": "0c43b175-02ab-4c58-920f-d46c6ea91122",
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





