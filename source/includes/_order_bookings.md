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
          "order_id": "25ddbcbc-5af3-4a3d-babb-0535e229fbf0",
          "items": [
            {
              "type": "products",
              "id": "104c68bf-db9f-4444-b98b-ae09372d1aa0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "77c524eb-77ba-4c31-a14a-323652c2e5d4",
              "stock_item_ids": [
                "08944210-4aec-4e44-b00c-c9f0262519a6",
                "bd91ce09-7079-4cde-be56-3d408b696cd4"
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
            "item_id": "104c68bf-db9f-4444-b98b-ae09372d1aa0",
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
          "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
          "items": [
            {
              "type": "products",
              "id": "0abe9382-0207-4024-b0a7-1ef64fa822cd",
              "stock_item_ids": [
                "5a7221e4-6af6-4d26-b6e9-87b977628cd7",
                "3880d22e-5af0-4296-a207-c757315912d7",
                "a4e7b426-4779-4c40-9dc2-2a3fcb3cb502"
              ]
            },
            {
              "type": "products",
              "id": "19796e87-8c01-4f37-8d06-c1b1b2978b99",
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
    "id": "48a53322-453b-555a-a773-e19277db9170",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e1f8f74-2c80-49ce-a8c4-41e4477a2315"
          },
          {
            "type": "lines",
            "id": "7bfc9e1d-6885-499a-b7cf-db52ea7d5347"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe"
          },
          {
            "type": "plannings",
            "id": "ec80a8ef-0b05-4f82-b168-524c32c69cdb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5b0af4aa-5214-484e-bf52-b07bf36ce56d"
          },
          {
            "type": "stock_item_plannings",
            "id": "0b585d86-d53a-4330-a3c2-1155ad91e326"
          },
          {
            "type": "stock_item_plannings",
            "id": "9d6acc6a-8840-45b0-a6d7-f913b256a17f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T16:01:30+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
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
        "customer_id": "71aed74c-44e7-4772-9d12-dab50777cfd9",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8",
        "stop_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8"
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
      "id": "5e1f8f74-2c80-49ce-a8c4-41e4477a2315",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
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
        "item_id": "0abe9382-0207-4024-b0a7-1ef64fa822cd",
        "tax_category_id": "4b7977c9-d273-4b15-b772-361903211b7d",
        "planning_id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe",
        "parent_line_id": null,
        "owner_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
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
      "id": "7bfc9e1d-6885-499a-b7cf-db52ea7d5347",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
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
        "item_id": "19796e87-8c01-4f37-8d06-c1b1b2978b99",
        "tax_category_id": "4b7977c9-d273-4b15-b772-361903211b7d",
        "planning_id": "ec80a8ef-0b05-4f82-b168-524c32c69cdb",
        "parent_line_id": null,
        "owner_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
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
      "id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
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
        "item_id": "0abe9382-0207-4024-b0a7-1ef64fa822cd",
        "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
        "start_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8",
        "stop_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8",
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
      "id": "ec80a8ef-0b05-4f82-b168-524c32c69cdb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
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
        "item_id": "19796e87-8c01-4f37-8d06-c1b1b2978b99",
        "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1",
        "start_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8",
        "stop_location_id": "b67155e7-fbec-4554-8f0c-f441908c4cf8",
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
      "id": "5b0af4aa-5214-484e-bf52-b07bf36ce56d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5a7221e4-6af6-4d26-b6e9-87b977628cd7",
        "planning_id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe",
        "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1"
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
      "id": "0b585d86-d53a-4330-a3c2-1155ad91e326",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3880d22e-5af0-4296-a207-c757315912d7",
        "planning_id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe",
        "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1"
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
      "id": "9d6acc6a-8840-45b0-a6d7-f913b256a17f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:32+00:00",
        "updated_at": "2023-02-13T16:01:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a4e7b426-4779-4c40-9dc2-2a3fcb3cb502",
        "planning_id": "0dbb1d8d-1ab1-417b-be19-3de508ae0abe",
        "order_id": "1fc1d40c-e3c5-46e2-9221-2fe71e31c4d1"
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
          "order_id": "044553f3-0296-4035-84eb-204faefe05bf",
          "items": [
            {
              "type": "bundles",
              "id": "3ab4a20b-3398-4a34-af3d-8e3afb64b4df",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6ee2f3f8-18ca-45d1-a3b5-81c64af0830c",
                  "id": "0e707fce-b909-4ca4-9497-d2db807ad670"
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
    "id": "7962d94e-8455-57fe-b37e-c50da5b4f415",
    "type": "order_bookings",
    "attributes": {
      "order_id": "044553f3-0296-4035-84eb-204faefe05bf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "044553f3-0296-4035-84eb-204faefe05bf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0b87160c-8454-45f4-87aa-24a780348633"
          },
          {
            "type": "lines",
            "id": "0d009f01-897d-4e98-bc7f-aeec6d51a8f3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1ccaf932-9085-48a6-a861-25b5086194f4"
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
      "id": "044553f3-0296-4035-84eb-204faefe05bf",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T16:01:39+00:00",
        "updated_at": "2023-02-13T16:01:40+00:00",
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
        "starts_at": "2023-02-11T16:00:00+00:00",
        "stops_at": "2023-02-15T16:00:00+00:00",
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
        "start_location_id": "9b4dbb28-3a21-471d-a04d-2e97659d5e12",
        "stop_location_id": "9b4dbb28-3a21-471d-a04d-2e97659d5e12"
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
      "id": "0b87160c-8454-45f4-87aa-24a780348633",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T16:01:39+00:00",
        "updated_at": "2023-02-13T16:01:39+00:00",
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
        "item_id": "0e707fce-b909-4ca4-9497-d2db807ad670",
        "tax_category_id": null,
        "planning_id": "1bd2ba6e-4d30-4cc8-80ea-be1674de0700",
        "parent_line_id": "0d009f01-897d-4e98-bc7f-aeec6d51a8f3",
        "owner_id": "044553f3-0296-4035-84eb-204faefe05bf",
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
      "id": "0d009f01-897d-4e98-bc7f-aeec6d51a8f3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T16:01:39+00:00",
        "updated_at": "2023-02-13T16:01:39+00:00",
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
        "item_id": "3ab4a20b-3398-4a34-af3d-8e3afb64b4df",
        "tax_category_id": null,
        "planning_id": "1ccaf932-9085-48a6-a861-25b5086194f4",
        "parent_line_id": null,
        "owner_id": "044553f3-0296-4035-84eb-204faefe05bf",
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
      "id": "1ccaf932-9085-48a6-a861-25b5086194f4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T16:01:39+00:00",
        "updated_at": "2023-02-13T16:01:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-11T16:00:00+00:00",
        "stops_at": "2023-02-15T16:00:00+00:00",
        "reserved_from": "2023-02-11T16:00:00+00:00",
        "reserved_till": "2023-02-15T16:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3ab4a20b-3398-4a34-af3d-8e3afb64b4df",
        "order_id": "044553f3-0296-4035-84eb-204faefe05bf",
        "start_location_id": "9b4dbb28-3a21-471d-a04d-2e97659d5e12",
        "stop_location_id": "9b4dbb28-3a21-471d-a04d-2e97659d5e12",
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





