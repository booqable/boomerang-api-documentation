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
          "order_id": "8eb4a95b-136e-4747-aaa2-d7cb93679d5b",
          "items": [
            {
              "type": "products",
              "id": "0a875d44-37e0-4020-b0e5-d4a3cbf6da67",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "db3baba2-115c-403f-b411-b80e31a8ed3e",
              "stock_item_ids": [
                "d0752fc6-6291-40b6-8b64-9f391d9f174c",
                "6561906d-0930-44d7-9ddb-8f91e6d26f43"
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
          "stock_item_id d0752fc6-6291-40b6-8b64-9f391d9f174c has already been booked on this order"
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
          "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
          "items": [
            {
              "type": "products",
              "id": "38c38505-90be-496d-b2f5-346959271695",
              "stock_item_ids": [
                "53d8ed6d-080b-463a-9295-5cb191a08cae",
                "9860d574-c192-49a9-bf17-a47ede834f23",
                "34ef827d-6e48-4f89-8d9c-6bb8c4c29a29"
              ]
            },
            {
              "type": "products",
              "id": "64969cd7-88bd-4356-b0ec-b1f10649a204",
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
    "id": "1bf45cba-05d3-59da-81fd-990b6939c3a5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dbae337c-14c5-48f0-8dc0-190d05b8f417"
          },
          {
            "type": "lines",
            "id": "9aa10ab4-2a97-4882-8471-a4aef1ce1d48"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e65dc48c-6479-4132-b6aa-96c1821c0d02"
          },
          {
            "type": "plannings",
            "id": "89caf38a-02cc-4f44-adc4-5b9dd122e39f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "474b7d23-27d9-4758-99c0-b2cb9aeff421"
          },
          {
            "type": "stock_item_plannings",
            "id": "5f49556c-853a-4884-b422-061155861847"
          },
          {
            "type": "stock_item_plannings",
            "id": "be6860b8-3dfd-4722-8843-f83d825ca414"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T12:41:02+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
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
        "customer_id": "5878dbf3-317b-4172-844c-dcc31c660aa7",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f",
        "stop_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f"
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
      "id": "dbae337c-14c5-48f0-8dc0-190d05b8f417",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
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
        "item_id": "38c38505-90be-496d-b2f5-346959271695",
        "tax_category_id": "bb0290c6-0f8f-4c4b-8483-ff2be13ad3f8",
        "planning_id": "e65dc48c-6479-4132-b6aa-96c1821c0d02",
        "parent_line_id": null,
        "owner_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
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
      "id": "9aa10ab4-2a97-4882-8471-a4aef1ce1d48",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
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
        "item_id": "64969cd7-88bd-4356-b0ec-b1f10649a204",
        "tax_category_id": "bb0290c6-0f8f-4c4b-8483-ff2be13ad3f8",
        "planning_id": "89caf38a-02cc-4f44-adc4-5b9dd122e39f",
        "parent_line_id": null,
        "owner_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
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
      "id": "e65dc48c-6479-4132-b6aa-96c1821c0d02",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
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
        "item_id": "38c38505-90be-496d-b2f5-346959271695",
        "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
        "start_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f",
        "stop_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f",
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
      "id": "89caf38a-02cc-4f44-adc4-5b9dd122e39f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
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
        "item_id": "64969cd7-88bd-4356-b0ec-b1f10649a204",
        "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c",
        "start_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f",
        "stop_location_id": "cf435fb7-aca4-4819-ae57-c322e6fc6a9f",
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
      "id": "474b7d23-27d9-4758-99c0-b2cb9aeff421",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "53d8ed6d-080b-463a-9295-5cb191a08cae",
        "planning_id": "e65dc48c-6479-4132-b6aa-96c1821c0d02",
        "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c"
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
      "id": "5f49556c-853a-4884-b422-061155861847",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9860d574-c192-49a9-bf17-a47ede834f23",
        "planning_id": "e65dc48c-6479-4132-b6aa-96c1821c0d02",
        "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c"
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
      "id": "be6860b8-3dfd-4722-8843-f83d825ca414",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:04+00:00",
        "updated_at": "2023-03-02T12:41:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "34ef827d-6e48-4f89-8d9c-6bb8c4c29a29",
        "planning_id": "e65dc48c-6479-4132-b6aa-96c1821c0d02",
        "order_id": "87b17d96-76a4-410a-8ff7-fb439f96eb6c"
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
          "order_id": "48c72c10-f23c-4972-8071-e61ed51323c0",
          "items": [
            {
              "type": "bundles",
              "id": "8c55b742-4617-47fc-aa53-868ce5585ee1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "068b959b-b230-47cc-ba9e-c6f191681b40",
                  "id": "32978420-6cf9-4dcc-b3b4-2367ad946938"
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
    "id": "3dbd13ff-13eb-5a28-b102-37147d7b7be6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "48c72c10-f23c-4972-8071-e61ed51323c0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "48c72c10-f23c-4972-8071-e61ed51323c0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "60043edc-1469-4141-be2e-6ffb582b071b"
          },
          {
            "type": "lines",
            "id": "0ce873b8-3173-4bf4-9466-d0effed70ad7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cc98dcac-84e7-4ecc-a175-d3634bcd5346"
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
      "id": "48c72c10-f23c-4972-8071-e61ed51323c0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T12:41:06+00:00",
        "updated_at": "2023-03-02T12:41:07+00:00",
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
        "starts_at": "2023-02-28T12:30:00+00:00",
        "stops_at": "2023-03-04T12:30:00+00:00",
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
        "start_location_id": "951060fc-474e-4b0d-b3ed-cc265304d7c1",
        "stop_location_id": "951060fc-474e-4b0d-b3ed-cc265304d7c1"
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
      "id": "60043edc-1469-4141-be2e-6ffb582b071b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:41:07+00:00",
        "updated_at": "2023-03-02T12:41:07+00:00",
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
        "item_id": "8c55b742-4617-47fc-aa53-868ce5585ee1",
        "tax_category_id": null,
        "planning_id": "cc98dcac-84e7-4ecc-a175-d3634bcd5346",
        "parent_line_id": null,
        "owner_id": "48c72c10-f23c-4972-8071-e61ed51323c0",
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
      "id": "0ce873b8-3173-4bf4-9466-d0effed70ad7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T12:41:07+00:00",
        "updated_at": "2023-03-02T12:41:07+00:00",
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
        "item_id": "32978420-6cf9-4dcc-b3b4-2367ad946938",
        "tax_category_id": null,
        "planning_id": "e2ac0d62-4e01-4478-a03f-68ddb24cd971",
        "parent_line_id": "60043edc-1469-4141-be2e-6ffb582b071b",
        "owner_id": "48c72c10-f23c-4972-8071-e61ed51323c0",
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
      "id": "cc98dcac-84e7-4ecc-a175-d3634bcd5346",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T12:41:07+00:00",
        "updated_at": "2023-03-02T12:41:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-28T12:30:00+00:00",
        "stops_at": "2023-03-04T12:30:00+00:00",
        "reserved_from": "2023-02-28T12:30:00+00:00",
        "reserved_till": "2023-03-04T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8c55b742-4617-47fc-aa53-868ce5585ee1",
        "order_id": "48c72c10-f23c-4972-8071-e61ed51323c0",
        "start_location_id": "951060fc-474e-4b0d-b3ed-cc265304d7c1",
        "stop_location_id": "951060fc-474e-4b0d-b3ed-cc265304d7c1",
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





