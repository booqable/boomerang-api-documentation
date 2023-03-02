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
          "order_id": "4941e6db-b239-4158-bec3-9c725e6afed1",
          "items": [
            {
              "type": "products",
              "id": "cf728b2f-5b80-4c48-9d1f-6d44f06a2d3c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "cca4ff46-a8ef-4372-a528-d66bd453117b",
              "stock_item_ids": [
                "94d16b6e-4997-445e-a89a-10a1694f81b3",
                "452a898c-0ba0-499b-acd0-2c307cac724d"
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
          "stock_item_id 94d16b6e-4997-445e-a89a-10a1694f81b3 has already been booked on this order"
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
          "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e",
          "items": [
            {
              "type": "products",
              "id": "32c39290-2b81-4477-b0c6-83b09026920f",
              "stock_item_ids": [
                "dd151622-7741-46c5-87bb-f88da1a7e152",
                "8b2b176c-9327-423e-8d80-4dd978962b1d",
                "693c6f9e-a08d-41e4-b24d-f0b6a4e2418e"
              ]
            },
            {
              "type": "products",
              "id": "01070a7d-2be4-419e-b4b6-983452d845ba",
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
    "id": "3882ea02-862a-5ea5-b37a-b8a7b4b759e4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e538fe85-3ab8-41d7-ae57-94592289278e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "68a0f382-1b2d-4be0-9081-d92891ec11ad"
          },
          {
            "type": "lines",
            "id": "27616e48-f802-46fb-81ea-8c3353286c2b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9360f4df-61d2-4aef-9b73-da760ac953a7"
          },
          {
            "type": "plannings",
            "id": "738af6e4-cc8c-4c44-8b38-63bbcb084495"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1109ef84-6dd0-4ef8-bbb0-8902506939a5"
          },
          {
            "type": "stock_item_plannings",
            "id": "bdc6dfc6-b7e1-4bdc-b5dc-34725159defe"
          },
          {
            "type": "stock_item_plannings",
            "id": "8dc07ca1-ff15-49b1-8115-ee891505fbe4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e538fe85-3ab8-41d7-ae57-94592289278e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T12:21:28+00:00",
        "updated_at": "2023-03-02T12:21:30+00:00",
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
        "customer_id": "28641cc8-fa7e-4a0d-b3fc-a34ca73a7af2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d",
        "stop_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d"
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
      "id": "68a0f382-1b2d-4be0-9081-d92891ec11ad",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:30+00:00",
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
        "item_id": "32c39290-2b81-4477-b0c6-83b09026920f",
        "tax_category_id": "df57d66c-94fd-4078-b6de-77fd437bbdad",
        "planning_id": "9360f4df-61d2-4aef-9b73-da760ac953a7",
        "parent_line_id": null,
        "owner_id": "e538fe85-3ab8-41d7-ae57-94592289278e",
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
      "id": "27616e48-f802-46fb-81ea-8c3353286c2b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:30+00:00",
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
        "item_id": "01070a7d-2be4-419e-b4b6-983452d845ba",
        "tax_category_id": "df57d66c-94fd-4078-b6de-77fd437bbdad",
        "planning_id": "738af6e4-cc8c-4c44-8b38-63bbcb084495",
        "parent_line_id": null,
        "owner_id": "e538fe85-3ab8-41d7-ae57-94592289278e",
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
      "id": "9360f4df-61d2-4aef-9b73-da760ac953a7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:29+00:00",
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
        "item_id": "32c39290-2b81-4477-b0c6-83b09026920f",
        "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e",
        "start_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d",
        "stop_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d",
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
      "id": "738af6e4-cc8c-4c44-8b38-63bbcb084495",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:29+00:00",
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
        "item_id": "01070a7d-2be4-419e-b4b6-983452d845ba",
        "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e",
        "start_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d",
        "stop_location_id": "ca4ef0c9-75e8-45f9-9288-de287b10f44d",
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
      "id": "1109ef84-6dd0-4ef8-bbb0-8902506939a5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dd151622-7741-46c5-87bb-f88da1a7e152",
        "planning_id": "9360f4df-61d2-4aef-9b73-da760ac953a7",
        "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e"
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
      "id": "bdc6dfc6-b7e1-4bdc-b5dc-34725159defe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b2b176c-9327-423e-8d80-4dd978962b1d",
        "planning_id": "9360f4df-61d2-4aef-9b73-da760ac953a7",
        "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e"
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
      "id": "8dc07ca1-ff15-49b1-8115-ee891505fbe4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:29+00:00",
        "updated_at": "2023-03-02T12:21:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "693c6f9e-a08d-41e4-b24d-f0b6a4e2418e",
        "planning_id": "9360f4df-61d2-4aef-9b73-da760ac953a7",
        "order_id": "e538fe85-3ab8-41d7-ae57-94592289278e"
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
          "order_id": "10dae532-fef2-46de-b8fb-63a64dd02618",
          "items": [
            {
              "type": "bundles",
              "id": "7627ae05-86a1-42ef-8447-542360d6a6c1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a6e106ed-2076-4f60-a5cd-75c232c51473",
                  "id": "94b10d8c-db95-4bf9-be61-c4327fc5acf7"
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
    "id": "de8535e2-bf11-57bc-b4b2-b7c182c6d612",
    "type": "order_bookings",
    "attributes": {
      "order_id": "10dae532-fef2-46de-b8fb-63a64dd02618"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "10dae532-fef2-46de-b8fb-63a64dd02618"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3cc901d9-d9ce-437e-912b-41a09039acf6"
          },
          {
            "type": "lines",
            "id": "2f782acf-0177-46e9-b13e-4308d0a9a612"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e5f3900c-34e9-4d93-814e-4ddab2bae5a7"
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
      "id": "10dae532-fef2-46de-b8fb-63a64dd02618",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T12:21:32+00:00",
        "updated_at": "2023-03-02T12:21:32+00:00",
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
        "starts_at": "2023-02-28T12:15:00+00:00",
        "stops_at": "2023-03-04T12:15:00+00:00",
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
        "start_location_id": "97bf43f5-5038-43c3-ac89-52a264a6d139",
        "stop_location_id": "97bf43f5-5038-43c3-ac89-52a264a6d139"
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
      "id": "3cc901d9-d9ce-437e-912b-41a09039acf6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:21:32+00:00",
        "updated_at": "2023-03-02T12:21:32+00:00",
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
        "item_id": "94b10d8c-db95-4bf9-be61-c4327fc5acf7",
        "tax_category_id": null,
        "planning_id": "1156606a-d56d-4622-8df4-29566fcf8a1c",
        "parent_line_id": "2f782acf-0177-46e9-b13e-4308d0a9a612",
        "owner_id": "10dae532-fef2-46de-b8fb-63a64dd02618",
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
      "id": "2f782acf-0177-46e9-b13e-4308d0a9a612",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:21:32+00:00",
        "updated_at": "2023-03-02T12:21:32+00:00",
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
        "item_id": "7627ae05-86a1-42ef-8447-542360d6a6c1",
        "tax_category_id": null,
        "planning_id": "e5f3900c-34e9-4d93-814e-4ddab2bae5a7",
        "parent_line_id": null,
        "owner_id": "10dae532-fef2-46de-b8fb-63a64dd02618",
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
      "id": "e5f3900c-34e9-4d93-814e-4ddab2bae5a7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:21:32+00:00",
        "updated_at": "2023-03-02T12:21:32+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-28T12:15:00+00:00",
        "stops_at": "2023-03-04T12:15:00+00:00",
        "reserved_from": "2023-02-28T12:15:00+00:00",
        "reserved_till": "2023-03-04T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7627ae05-86a1-42ef-8447-542360d6a6c1",
        "order_id": "10dae532-fef2-46de-b8fb-63a64dd02618",
        "start_location_id": "97bf43f5-5038-43c3-ac89-52a264a6d139",
        "stop_location_id": "97bf43f5-5038-43c3-ac89-52a264a6d139",
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





