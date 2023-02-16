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
          "order_id": "1faff972-45ce-4fe3-9f66-faf2e7c48346",
          "items": [
            {
              "type": "products",
              "id": "ab5f1606-2da5-42b7-972c-a600ddb5e754",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f9c25d55-12e3-4bc3-83ee-18466dba5df6",
              "stock_item_ids": [
                "a5addfa9-ddc8-4c19-a909-3bb81eddb3a0",
                "97978932-b1cb-4703-9412-ba2b5a4850e5"
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
          "stock_item_id a5addfa9-ddc8-4c19-a909-3bb81eddb3a0 has already been booked on this order"
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
          "order_id": "85141179-6f11-4864-b843-8168716bdc3d",
          "items": [
            {
              "type": "products",
              "id": "9be52f70-2851-423b-ba77-bec370e5b150",
              "stock_item_ids": [
                "39b853d3-b53d-4382-94d7-eabf94ff18f0",
                "e9ebf943-30b2-4528-afa8-e7d8dd82693a",
                "471ed229-74f9-410d-9682-a9cc5f46e701"
              ]
            },
            {
              "type": "products",
              "id": "5f2eccb2-fa28-4ddf-81e7-d2cbf52382b5",
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
    "id": "e7b91593-24f2-5e18-940c-727956ceeeb7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "85141179-6f11-4864-b843-8168716bdc3d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "85141179-6f11-4864-b843-8168716bdc3d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "91f46308-73a3-4d71-a377-ac422173b8c4"
          },
          {
            "type": "lines",
            "id": "2d200340-3938-409f-8474-eb08bb431876"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a"
          },
          {
            "type": "plannings",
            "id": "fb0ff9ae-a636-4f3a-a691-a67295de5e24"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2febf021-d226-4e98-a5e4-cd16344662b2"
          },
          {
            "type": "stock_item_plannings",
            "id": "2db33f91-8cd5-4539-978c-b6570f92f484"
          },
          {
            "type": "stock_item_plannings",
            "id": "a11e2be6-cc5e-4844-b832-82575c5ad8f6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "85141179-6f11-4864-b843-8168716bdc3d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T15:36:40+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
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
        "customer_id": "c852a8eb-2cb2-4b02-ae86-21e5b8b54b4d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3",
        "stop_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3"
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
      "id": "91f46308-73a3-4d71-a377-ac422173b8c4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
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
        "item_id": "9be52f70-2851-423b-ba77-bec370e5b150",
        "tax_category_id": "b9cae9b8-1c4c-4ad0-9fea-0fe95238c0f2",
        "planning_id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a",
        "parent_line_id": null,
        "owner_id": "85141179-6f11-4864-b843-8168716bdc3d",
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
      "id": "2d200340-3938-409f-8474-eb08bb431876",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
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
        "item_id": "5f2eccb2-fa28-4ddf-81e7-d2cbf52382b5",
        "tax_category_id": "b9cae9b8-1c4c-4ad0-9fea-0fe95238c0f2",
        "planning_id": "fb0ff9ae-a636-4f3a-a691-a67295de5e24",
        "parent_line_id": null,
        "owner_id": "85141179-6f11-4864-b843-8168716bdc3d",
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
      "id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
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
        "item_id": "9be52f70-2851-423b-ba77-bec370e5b150",
        "order_id": "85141179-6f11-4864-b843-8168716bdc3d",
        "start_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3",
        "stop_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3",
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
      "id": "fb0ff9ae-a636-4f3a-a691-a67295de5e24",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
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
        "item_id": "5f2eccb2-fa28-4ddf-81e7-d2cbf52382b5",
        "order_id": "85141179-6f11-4864-b843-8168716bdc3d",
        "start_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3",
        "stop_location_id": "ca385b78-87e1-45f9-a29a-cbb0503028f3",
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
      "id": "2febf021-d226-4e98-a5e4-cd16344662b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "39b853d3-b53d-4382-94d7-eabf94ff18f0",
        "planning_id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a",
        "order_id": "85141179-6f11-4864-b843-8168716bdc3d"
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
      "id": "2db33f91-8cd5-4539-978c-b6570f92f484",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e9ebf943-30b2-4528-afa8-e7d8dd82693a",
        "planning_id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a",
        "order_id": "85141179-6f11-4864-b843-8168716bdc3d"
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
      "id": "a11e2be6-cc5e-4844-b832-82575c5ad8f6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:42+00:00",
        "updated_at": "2023-02-16T15:36:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "471ed229-74f9-410d-9682-a9cc5f46e701",
        "planning_id": "9e3861d0-5beb-4d56-a8b4-aa2e9d88908a",
        "order_id": "85141179-6f11-4864-b843-8168716bdc3d"
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
          "order_id": "576314be-714f-4e55-890d-0374fd44a4b0",
          "items": [
            {
              "type": "bundles",
              "id": "5b5b47f9-af7f-40fa-8ec3-e188f6dd68c0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "09d33d51-9978-46bd-af12-eb3e4b65fa82",
                  "id": "39b2acb1-8110-4a04-9548-ea5c6dfa5a63"
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
    "id": "8715f07c-380c-55dc-b220-c448109afddb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "576314be-714f-4e55-890d-0374fd44a4b0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "576314be-714f-4e55-890d-0374fd44a4b0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f7f25436-27f8-4fae-86e5-924c8597a990"
          },
          {
            "type": "lines",
            "id": "e03e0330-4d6b-4fdf-9fcb-c4b8dc2f6c8c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f5f7db22-1c53-42a5-aed0-da4d75c410e9"
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
      "id": "576314be-714f-4e55-890d-0374fd44a4b0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T15:36:44+00:00",
        "updated_at": "2023-02-16T15:36:45+00:00",
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
        "starts_at": "2023-02-14T15:30:00+00:00",
        "stops_at": "2023-02-18T15:30:00+00:00",
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
        "start_location_id": "725eca89-35d4-4d90-8bd2-ddebb413f15c",
        "stop_location_id": "725eca89-35d4-4d90-8bd2-ddebb413f15c"
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
      "id": "f7f25436-27f8-4fae-86e5-924c8597a990",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:36:45+00:00",
        "updated_at": "2023-02-16T15:36:45+00:00",
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
        "item_id": "39b2acb1-8110-4a04-9548-ea5c6dfa5a63",
        "tax_category_id": null,
        "planning_id": "d769e1ee-c756-4baa-8569-cce3202b5775",
        "parent_line_id": "e03e0330-4d6b-4fdf-9fcb-c4b8dc2f6c8c",
        "owner_id": "576314be-714f-4e55-890d-0374fd44a4b0",
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
      "id": "e03e0330-4d6b-4fdf-9fcb-c4b8dc2f6c8c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:36:45+00:00",
        "updated_at": "2023-02-16T15:36:45+00:00",
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
        "item_id": "5b5b47f9-af7f-40fa-8ec3-e188f6dd68c0",
        "tax_category_id": null,
        "planning_id": "f5f7db22-1c53-42a5-aed0-da4d75c410e9",
        "parent_line_id": null,
        "owner_id": "576314be-714f-4e55-890d-0374fd44a4b0",
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
      "id": "f5f7db22-1c53-42a5-aed0-da4d75c410e9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:36:45+00:00",
        "updated_at": "2023-02-16T15:36:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T15:30:00+00:00",
        "stops_at": "2023-02-18T15:30:00+00:00",
        "reserved_from": "2023-02-14T15:30:00+00:00",
        "reserved_till": "2023-02-18T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5b5b47f9-af7f-40fa-8ec3-e188f6dd68c0",
        "order_id": "576314be-714f-4e55-890d-0374fd44a4b0",
        "start_location_id": "725eca89-35d4-4d90-8bd2-ddebb413f15c",
        "stop_location_id": "725eca89-35d4-4d90-8bd2-ddebb413f15c",
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





