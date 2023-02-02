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
          "order_id": "98141a4e-b753-41d0-8ce5-2e48e2e96c87",
          "items": [
            {
              "type": "products",
              "id": "fa33b6a1-8f21-414c-b5b2-b58ca19c113c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5330765f-30d2-42fd-a6fc-7b67bacd5d93",
              "stock_item_ids": [
                "d7385482-b4b1-44df-be98-28185edf82d1",
                "48ac43ad-1cac-4e87-9af3-9373004a49d4"
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
            "item_id": "fa33b6a1-8f21-414c-b5b2-b58ca19c113c",
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
          "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
          "items": [
            {
              "type": "products",
              "id": "8d61af35-be3e-4b47-bd81-f41725f85fc3",
              "stock_item_ids": [
                "d1f19fae-6809-4756-88b3-220024cddb21",
                "df215eee-fd55-4ae4-ada2-300474ab69f8",
                "a7dd513d-d5dc-4109-b3f1-0b0419c03867"
              ]
            },
            {
              "type": "products",
              "id": "0a50ac9e-4a4d-4aef-81ba-6cc1baecee9d",
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
    "id": "46af9b98-ee91-5531-8758-c7f306addef9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "02f210ac-8c96-4023-aa43-fb86d58a1997"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d1e32c0f-e09c-40e4-87ab-4a1e1c553e6a"
          },
          {
            "type": "lines",
            "id": "a5cd9789-91ee-4311-b790-2f7470c00783"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fa462835-54b4-4764-a8b1-625a527447e3"
          },
          {
            "type": "plannings",
            "id": "ed818d4e-f440-4927-a6e6-852f17491ab7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c59be57b-6803-401e-ae5b-0051e621e0c4"
          },
          {
            "type": "stock_item_plannings",
            "id": "5af8f8c2-e659-445e-8d39-3714c9763332"
          },
          {
            "type": "stock_item_plannings",
            "id": "bad99cec-4d68-4fc4-a647-6be2ff903b5c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T11:17:06+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
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
        "customer_id": "9a05f686-6fc8-4f45-9ee0-02cf76918d72",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2",
        "stop_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2"
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
      "id": "d1e32c0f-e09c-40e4-87ab-4a1e1c553e6a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
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
        "item_id": "8d61af35-be3e-4b47-bd81-f41725f85fc3",
        "tax_category_id": "003835cb-c1c2-4f82-8198-efbf07a6e940",
        "planning_id": "fa462835-54b4-4764-a8b1-625a527447e3",
        "parent_line_id": null,
        "owner_id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
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
      "id": "a5cd9789-91ee-4311-b790-2f7470c00783",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
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
        "item_id": "0a50ac9e-4a4d-4aef-81ba-6cc1baecee9d",
        "tax_category_id": "003835cb-c1c2-4f82-8198-efbf07a6e940",
        "planning_id": "ed818d4e-f440-4927-a6e6-852f17491ab7",
        "parent_line_id": null,
        "owner_id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
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
      "id": "fa462835-54b4-4764-a8b1-625a527447e3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
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
        "item_id": "8d61af35-be3e-4b47-bd81-f41725f85fc3",
        "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
        "start_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2",
        "stop_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2",
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
      "id": "ed818d4e-f440-4927-a6e6-852f17491ab7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
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
        "item_id": "0a50ac9e-4a4d-4aef-81ba-6cc1baecee9d",
        "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997",
        "start_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2",
        "stop_location_id": "ebcb6f0b-e260-4a99-93da-e271cb35b8f2",
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
      "id": "c59be57b-6803-401e-ae5b-0051e621e0c4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d1f19fae-6809-4756-88b3-220024cddb21",
        "planning_id": "fa462835-54b4-4764-a8b1-625a527447e3",
        "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997"
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
      "id": "5af8f8c2-e659-445e-8d39-3714c9763332",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "df215eee-fd55-4ae4-ada2-300474ab69f8",
        "planning_id": "fa462835-54b4-4764-a8b1-625a527447e3",
        "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997"
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
      "id": "bad99cec-4d68-4fc4-a647-6be2ff903b5c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:08+00:00",
        "updated_at": "2023-02-02T11:17:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a7dd513d-d5dc-4109-b3f1-0b0419c03867",
        "planning_id": "fa462835-54b4-4764-a8b1-625a527447e3",
        "order_id": "02f210ac-8c96-4023-aa43-fb86d58a1997"
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
          "order_id": "dccd4510-a543-462f-858a-de864470b299",
          "items": [
            {
              "type": "bundles",
              "id": "e6da5786-7a1e-4aec-8531-34cbbeda430c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e4ee97eb-5f52-4c0b-9e02-69d2d44dc8d2",
                  "id": "1f967064-7041-415a-a1c8-9aee8531c0ff"
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
    "id": "eb5957ea-c993-5849-8578-2385bfdc9470",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dccd4510-a543-462f-858a-de864470b299"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dccd4510-a543-462f-858a-de864470b299"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6469a79c-a17f-48ae-9af9-dfab92e4d5e8"
          },
          {
            "type": "lines",
            "id": "4653f3a4-a7f5-422c-a642-9b80a62f356d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "28685470-494f-4d23-b2b4-dd5e7b8e4109"
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
      "id": "dccd4510-a543-462f-858a-de864470b299",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T11:17:10+00:00",
        "updated_at": "2023-02-02T11:17:11+00:00",
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
        "starts_at": "2023-01-31T11:15:00+00:00",
        "stops_at": "2023-02-04T11:15:00+00:00",
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
        "start_location_id": "e566490d-5da9-4b43-81d4-fc2c731777e2",
        "stop_location_id": "e566490d-5da9-4b43-81d4-fc2c731777e2"
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
      "id": "6469a79c-a17f-48ae-9af9-dfab92e4d5e8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T11:17:11+00:00",
        "updated_at": "2023-02-02T11:17:11+00:00",
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
        "item_id": "e6da5786-7a1e-4aec-8531-34cbbeda430c",
        "tax_category_id": null,
        "planning_id": "28685470-494f-4d23-b2b4-dd5e7b8e4109",
        "parent_line_id": null,
        "owner_id": "dccd4510-a543-462f-858a-de864470b299",
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
      "id": "4653f3a4-a7f5-422c-a642-9b80a62f356d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T11:17:11+00:00",
        "updated_at": "2023-02-02T11:17:11+00:00",
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
        "item_id": "1f967064-7041-415a-a1c8-9aee8531c0ff",
        "tax_category_id": null,
        "planning_id": "6d019a1c-ab8a-4a37-bc97-d138a654f547",
        "parent_line_id": "6469a79c-a17f-48ae-9af9-dfab92e4d5e8",
        "owner_id": "dccd4510-a543-462f-858a-de864470b299",
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
      "id": "28685470-494f-4d23-b2b4-dd5e7b8e4109",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T11:17:11+00:00",
        "updated_at": "2023-02-02T11:17:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T11:15:00+00:00",
        "stops_at": "2023-02-04T11:15:00+00:00",
        "reserved_from": "2023-01-31T11:15:00+00:00",
        "reserved_till": "2023-02-04T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e6da5786-7a1e-4aec-8531-34cbbeda430c",
        "order_id": "dccd4510-a543-462f-858a-de864470b299",
        "start_location_id": "e566490d-5da9-4b43-81d4-fc2c731777e2",
        "stop_location_id": "e566490d-5da9-4b43-81d4-fc2c731777e2",
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





