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
          "order_id": "5a7390f1-cf22-4dce-9861-1ec060f28ee5",
          "items": [
            {
              "type": "products",
              "id": "2e7ff329-e910-4995-a9f7-1c80c0619f5a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b8d0ee5f-ae02-4775-9bcf-6c1199f1d59d",
              "stock_item_ids": [
                "abb7d377-d932-49d4-83dc-79dd1ab48169",
                "24dd3597-b9da-4d93-a707-7a7821082c80"
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
            "item_id": "2e7ff329-e910-4995-a9f7-1c80c0619f5a",
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
          "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
          "items": [
            {
              "type": "products",
              "id": "39731036-3f97-474f-b14b-10d520073af9",
              "stock_item_ids": [
                "02ac01be-cdcb-46e8-9b09-b539b7eced9f",
                "449400ea-bf0b-4886-91ab-9d56d1e5b387",
                "d289adbe-0d8d-4cc9-8f6d-5e6854ccebe4"
              ]
            },
            {
              "type": "products",
              "id": "f24b1cac-fbcc-4451-866f-38884fa678e1",
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
    "id": "b7226732-aae1-5668-a9eb-d019d2ce8a4a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "073651be-d492-4722-903e-4694bf0da4ac"
          },
          {
            "type": "lines",
            "id": "8ae8a00c-1276-42b1-8e10-5980e6b124f7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c90f3615-596d-488f-8f91-a3e969f87010"
          },
          {
            "type": "plannings",
            "id": "aea3371e-8107-4a35-900f-504d5a5e3912"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7127a530-fa90-4a1a-976b-5d77ebaebf69"
          },
          {
            "type": "stock_item_plannings",
            "id": "2686dbe0-f1d1-485c-be78-4955510efe79"
          },
          {
            "type": "stock_item_plannings",
            "id": "95bcc1d0-eec8-4232-8749-3c633f2e9a5a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T10:18:01+00:00",
        "updated_at": "2022-07-14T10:18:03+00:00",
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
        "customer_id": "565386c9-da03-434c-a1ea-28c0b3edf35f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e",
        "stop_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e"
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
      "id": "073651be-d492-4722-903e-4694bf0da4ac",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:18:01+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
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
        "item_id": "f24b1cac-fbcc-4451-866f-38884fa678e1",
        "tax_category_id": "dfa68bc7-fbc3-4074-accd-aa4e5142cb74",
        "planning_id": "c90f3615-596d-488f-8f91-a3e969f87010",
        "parent_line_id": null,
        "owner_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
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
      "id": "8ae8a00c-1276-42b1-8e10-5980e6b124f7",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:18:02+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
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
        "item_id": "39731036-3f97-474f-b14b-10d520073af9",
        "tax_category_id": "dfa68bc7-fbc3-4074-accd-aa4e5142cb74",
        "planning_id": "aea3371e-8107-4a35-900f-504d5a5e3912",
        "parent_line_id": null,
        "owner_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
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
      "id": "c90f3615-596d-488f-8f91-a3e969f87010",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:01+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
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
        "item_id": "f24b1cac-fbcc-4451-866f-38884fa678e1",
        "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
        "start_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e",
        "stop_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e",
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
      "id": "aea3371e-8107-4a35-900f-504d5a5e3912",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:02+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
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
        "item_id": "39731036-3f97-474f-b14b-10d520073af9",
        "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18",
        "start_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e",
        "stop_location_id": "4b0571e9-ff04-4015-b0fa-e7c711e7960e",
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
      "id": "7127a530-fa90-4a1a-976b-5d77ebaebf69",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:02+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "02ac01be-cdcb-46e8-9b09-b539b7eced9f",
        "planning_id": "aea3371e-8107-4a35-900f-504d5a5e3912",
        "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18"
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
      "id": "2686dbe0-f1d1-485c-be78-4955510efe79",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:02+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "449400ea-bf0b-4886-91ab-9d56d1e5b387",
        "planning_id": "aea3371e-8107-4a35-900f-504d5a5e3912",
        "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18"
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
      "id": "95bcc1d0-eec8-4232-8749-3c633f2e9a5a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:02+00:00",
        "updated_at": "2022-07-14T10:18:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d289adbe-0d8d-4cc9-8f6d-5e6854ccebe4",
        "planning_id": "aea3371e-8107-4a35-900f-504d5a5e3912",
        "order_id": "58f9a56b-9d43-4bfd-9a49-af4ef027bc18"
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
          "order_id": "c245b376-518a-4aa7-a48b-745c7316cde8",
          "items": [
            {
              "type": "bundles",
              "id": "ae55efe2-7304-43ec-b184-20609f3fe45d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b28dfe28-b650-41ea-8e18-dccaeca0ca3e",
                  "id": "2bdb0ede-bd3c-46cd-8b60-0cdb3897642e"
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
    "id": "11d6edbf-6c96-57d1-b565-deb7f767ed30",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c245b376-518a-4aa7-a48b-745c7316cde8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c245b376-518a-4aa7-a48b-745c7316cde8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ff2559d6-eecb-4c9a-a95e-356b7f64d1aa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bff5f52c-80c3-4575-aef9-1dcbcebb6295"
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
      "id": "c245b376-518a-4aa7-a48b-745c7316cde8",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T10:18:04+00:00",
        "updated_at": "2022-07-14T10:18:05+00:00",
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
        "starts_at": "2022-07-12T10:15:00+00:00",
        "stops_at": "2022-07-16T10:15:00+00:00",
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
        "start_location_id": "e27e92c4-a6a0-4125-acca-51e5780de76e",
        "stop_location_id": "e27e92c4-a6a0-4125-acca-51e5780de76e"
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
      "id": "ff2559d6-eecb-4c9a-a95e-356b7f64d1aa",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T10:18:05+00:00",
        "updated_at": "2022-07-14T10:18:05+00:00",
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
        "item_id": "ae55efe2-7304-43ec-b184-20609f3fe45d",
        "tax_category_id": null,
        "planning_id": "bff5f52c-80c3-4575-aef9-1dcbcebb6295",
        "parent_line_id": null,
        "owner_id": "c245b376-518a-4aa7-a48b-745c7316cde8",
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
      "id": "bff5f52c-80c3-4575-aef9-1dcbcebb6295",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T10:18:05+00:00",
        "updated_at": "2022-07-14T10:18:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T10:15:00+00:00",
        "stops_at": "2022-07-16T10:15:00+00:00",
        "reserved_from": "2022-07-12T10:15:00+00:00",
        "reserved_till": "2022-07-16T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ae55efe2-7304-43ec-b184-20609f3fe45d",
        "order_id": "c245b376-518a-4aa7-a48b-745c7316cde8",
        "start_location_id": "e27e92c4-a6a0-4125-acca-51e5780de76e",
        "stop_location_id": "e27e92c4-a6a0-4125-acca-51e5780de76e",
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





