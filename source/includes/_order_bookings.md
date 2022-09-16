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
          "order_id": "02606517-613d-499d-8899-86c15392e8df",
          "items": [
            {
              "type": "products",
              "id": "58f7ce3f-2e56-473c-ba85-9a37b2ed1a44",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "498e2b73-a022-43ad-85a1-9ec759cb2b37",
              "stock_item_ids": [
                "0d273831-41a6-46ff-ab7a-d374644d32e6",
                "9e0c424a-c856-4a5a-9242-1592141bcc80"
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
            "item_id": "58f7ce3f-2e56-473c-ba85-9a37b2ed1a44",
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
          "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
          "items": [
            {
              "type": "products",
              "id": "d6140aea-6645-480b-9653-aea81decdea2",
              "stock_item_ids": [
                "4b239bf1-e963-4e79-861c-06fc3f9ee8e0",
                "90695753-ea7e-4227-af7d-9291e4fb2866",
                "9c1de9e3-6a52-4136-a150-b3a30aaa0981"
              ]
            },
            {
              "type": "products",
              "id": "82bd8eec-de9a-4993-b8e0-89f6d0b417d9",
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
    "id": "b2b4af59-be7b-50fa-9c32-766c1ce5e5ba",
    "type": "order_bookings",
    "attributes": {
      "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "74ba7202-ad57-4fee-a22d-db966f0c7925"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2e8d646a-99c9-4ca4-b979-be2578375cff"
          },
          {
            "type": "lines",
            "id": "a0342bcb-7560-47d4-9380-41b8d80dedb8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b"
          },
          {
            "type": "plannings",
            "id": "102b983a-898f-46b0-b60e-4c26079edc43"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f8fc6e63-a651-4239-abd3-1659e4280221"
          },
          {
            "type": "stock_item_plannings",
            "id": "e29bfecd-f36c-4600-a6d4-b9a09a318c05"
          },
          {
            "type": "stock_item_plannings",
            "id": "d1c980c6-cce6-4ecb-818d-68eb86963749"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T09:03:05+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
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
        "customer_id": "1dfdbdc5-bedc-4c8d-b14c-40f42e8a1ffd",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029",
        "stop_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029"
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
      "id": "2e8d646a-99c9-4ca4-b979-be2578375cff",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
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
        "item_id": "d6140aea-6645-480b-9653-aea81decdea2",
        "tax_category_id": "7e0a33c9-c63b-457c-9bbd-948e4352eaf7",
        "planning_id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b",
        "parent_line_id": null,
        "owner_id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
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
      "id": "a0342bcb-7560-47d4-9380-41b8d80dedb8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
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
        "item_id": "82bd8eec-de9a-4993-b8e0-89f6d0b417d9",
        "tax_category_id": "7e0a33c9-c63b-457c-9bbd-948e4352eaf7",
        "planning_id": "102b983a-898f-46b0-b60e-4c26079edc43",
        "parent_line_id": null,
        "owner_id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
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
      "id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
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
        "item_id": "d6140aea-6645-480b-9653-aea81decdea2",
        "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
        "start_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029",
        "stop_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029",
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
      "id": "102b983a-898f-46b0-b60e-4c26079edc43",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
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
        "item_id": "82bd8eec-de9a-4993-b8e0-89f6d0b417d9",
        "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925",
        "start_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029",
        "stop_location_id": "a3967ae0-72f9-41a6-8981-18b3b7b2b029",
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
      "id": "f8fc6e63-a651-4239-abd3-1659e4280221",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4b239bf1-e963-4e79-861c-06fc3f9ee8e0",
        "planning_id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b",
        "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925"
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
      "id": "e29bfecd-f36c-4600-a6d4-b9a09a318c05",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "90695753-ea7e-4227-af7d-9291e4fb2866",
        "planning_id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b",
        "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925"
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
      "id": "d1c980c6-cce6-4ecb-818d-68eb86963749",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:07+00:00",
        "updated_at": "2022-09-16T09:03:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9c1de9e3-6a52-4136-a150-b3a30aaa0981",
        "planning_id": "12d82ba2-d50f-44cf-85ae-fe38161fce8b",
        "order_id": "74ba7202-ad57-4fee-a22d-db966f0c7925"
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
          "order_id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939",
          "items": [
            {
              "type": "bundles",
              "id": "62af6c86-25a3-44fa-a482-3d84de639e72",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "33c50dbf-91de-42b3-9128-e51c032c26e8",
                  "id": "4a8dea65-f450-4723-8d62-d870438f2cf4"
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
    "id": "195f96ba-bf3a-524f-82eb-52fa274d9420",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "76ed875b-74fd-458f-a589-42d6ea8bfa09"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "80a94093-3d09-41d2-93eb-8f57227574d1"
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
      "id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T09:03:09+00:00",
        "updated_at": "2022-09-16T09:03:10+00:00",
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
        "starts_at": "2022-09-14T09:00:00+00:00",
        "stops_at": "2022-09-18T09:00:00+00:00",
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
        "start_location_id": "c3d7dd0f-9270-4b8c-ac6e-fb17780dc792",
        "stop_location_id": "c3d7dd0f-9270-4b8c-ac6e-fb17780dc792"
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
      "id": "76ed875b-74fd-458f-a589-42d6ea8bfa09",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T09:03:10+00:00",
        "updated_at": "2022-09-16T09:03:10+00:00",
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
        "item_id": "62af6c86-25a3-44fa-a482-3d84de639e72",
        "tax_category_id": null,
        "planning_id": "80a94093-3d09-41d2-93eb-8f57227574d1",
        "parent_line_id": null,
        "owner_id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939",
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
      "id": "80a94093-3d09-41d2-93eb-8f57227574d1",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T09:03:10+00:00",
        "updated_at": "2022-09-16T09:03:10+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-14T09:00:00+00:00",
        "stops_at": "2022-09-18T09:00:00+00:00",
        "reserved_from": "2022-09-14T09:00:00+00:00",
        "reserved_till": "2022-09-18T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "62af6c86-25a3-44fa-a482-3d84de639e72",
        "order_id": "a2af78ba-03a6-491d-a6d2-2e6435e1e939",
        "start_location_id": "c3d7dd0f-9270-4b8c-ac6e-fb17780dc792",
        "stop_location_id": "c3d7dd0f-9270-4b8c-ac6e-fb17780dc792",
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





