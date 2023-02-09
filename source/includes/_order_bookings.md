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
          "order_id": "72b2d988-cfec-4a7c-a3f3-3d9f0b1e8e34",
          "items": [
            {
              "type": "products",
              "id": "374fa06f-ca72-4af7-aabc-942d675ed936",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "cc5ed856-4a90-4fb5-b975-4b4c2b217045",
              "stock_item_ids": [
                "b15a466a-f50d-439a-8357-01b96da20e05",
                "b6f37579-3dfc-4b6e-b10a-1a4303227ffb"
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
            "item_id": "374fa06f-ca72-4af7-aabc-942d675ed936",
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
          "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
          "items": [
            {
              "type": "products",
              "id": "0c54ac52-3f65-44e4-9cfa-bc32327af43f",
              "stock_item_ids": [
                "0b811861-120a-4bf0-94a7-a990874ef167",
                "afcb7428-c053-419b-87f7-4f0f7ea5e2e4",
                "0963f682-07f2-4df7-ad32-ad443e431920"
              ]
            },
            {
              "type": "products",
              "id": "951f485e-d4e2-4575-b953-3ff173205fda",
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
    "id": "2dd3c6fb-20fe-57d4-818d-c580e8d74149",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6333112c-1f63-48fa-b837-18c6d7fb7cc8"
          },
          {
            "type": "lines",
            "id": "a16546a5-43dd-494d-8919-ae21dd24862e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5b167503-254f-4db6-a017-4312c1da1c51"
          },
          {
            "type": "plannings",
            "id": "789caeb0-8682-4fa4-9f76-cb0ce4635fd0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a4e6d3cd-82cc-487c-8a9a-0275f4dbb6ce"
          },
          {
            "type": "stock_item_plannings",
            "id": "50b34d53-1211-40aa-bd8a-c1d9b8c8c5e9"
          },
          {
            "type": "stock_item_plannings",
            "id": "0e5cd042-090a-479e-88a1-378fdbbd5c1d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T12:19:55+00:00",
        "updated_at": "2023-02-09T12:19:58+00:00",
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
        "customer_id": "3533a517-cd3c-4879-baec-da6e81459f3a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc",
        "stop_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc"
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
      "id": "6333112c-1f63-48fa-b837-18c6d7fb7cc8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:58+00:00",
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
        "item_id": "0c54ac52-3f65-44e4-9cfa-bc32327af43f",
        "tax_category_id": "8909ce6b-2515-457c-a5f8-db8738628e2d",
        "planning_id": "5b167503-254f-4db6-a017-4312c1da1c51",
        "parent_line_id": null,
        "owner_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
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
      "id": "a16546a5-43dd-494d-8919-ae21dd24862e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:58+00:00",
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
        "item_id": "951f485e-d4e2-4575-b953-3ff173205fda",
        "tax_category_id": "8909ce6b-2515-457c-a5f8-db8738628e2d",
        "planning_id": "789caeb0-8682-4fa4-9f76-cb0ce4635fd0",
        "parent_line_id": null,
        "owner_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
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
      "id": "5b167503-254f-4db6-a017-4312c1da1c51",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:58+00:00",
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
        "item_id": "0c54ac52-3f65-44e4-9cfa-bc32327af43f",
        "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
        "start_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc",
        "stop_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc",
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
      "id": "789caeb0-8682-4fa4-9f76-cb0ce4635fd0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:58+00:00",
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
        "item_id": "951f485e-d4e2-4575-b953-3ff173205fda",
        "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1",
        "start_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc",
        "stop_location_id": "bfa002f1-8bc4-4349-acae-59a1e97295fc",
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
      "id": "a4e6d3cd-82cc-487c-8a9a-0275f4dbb6ce",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0b811861-120a-4bf0-94a7-a990874ef167",
        "planning_id": "5b167503-254f-4db6-a017-4312c1da1c51",
        "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1"
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
      "id": "50b34d53-1211-40aa-bd8a-c1d9b8c8c5e9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "afcb7428-c053-419b-87f7-4f0f7ea5e2e4",
        "planning_id": "5b167503-254f-4db6-a017-4312c1da1c51",
        "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1"
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
      "id": "0e5cd042-090a-479e-88a1-378fdbbd5c1d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:19:57+00:00",
        "updated_at": "2023-02-09T12:19:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0963f682-07f2-4df7-ad32-ad443e431920",
        "planning_id": "5b167503-254f-4db6-a017-4312c1da1c51",
        "order_id": "e89f4302-a4c9-4c13-b37d-3df31e7976f1"
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
          "order_id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2",
          "items": [
            {
              "type": "bundles",
              "id": "af0f4524-2793-4c9e-801d-7b05962030fb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "44b5b07d-5c3d-4085-9255-6b9cfd67d0a7",
                  "id": "5db959cd-2e48-4911-a0fa-e537896dd98f"
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
    "id": "211c3663-6186-5462-bdac-02a19dc5d9bf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1b78e95f-9898-4ab6-81f1-a1d4bcc2814b"
          },
          {
            "type": "lines",
            "id": "e6f5256d-a643-406c-b73d-a29ddb0bec4c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e23b95fe-995b-4e06-b276-dc4e34294340"
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
      "id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T12:20:01+00:00",
        "updated_at": "2023-02-09T12:20:02+00:00",
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
        "starts_at": "2023-02-07T12:15:00+00:00",
        "stops_at": "2023-02-11T12:15:00+00:00",
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
        "start_location_id": "589d3940-66f3-4b83-922e-265a983adb99",
        "stop_location_id": "589d3940-66f3-4b83-922e-265a983adb99"
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
      "id": "1b78e95f-9898-4ab6-81f1-a1d4bcc2814b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:20:02+00:00",
        "updated_at": "2023-02-09T12:20:02+00:00",
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
        "item_id": "5db959cd-2e48-4911-a0fa-e537896dd98f",
        "tax_category_id": null,
        "planning_id": "d913d87a-9716-4cf0-a777-9dcec08e6848",
        "parent_line_id": "e6f5256d-a643-406c-b73d-a29ddb0bec4c",
        "owner_id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2",
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
      "id": "e6f5256d-a643-406c-b73d-a29ddb0bec4c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:20:02+00:00",
        "updated_at": "2023-02-09T12:20:02+00:00",
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
        "item_id": "af0f4524-2793-4c9e-801d-7b05962030fb",
        "tax_category_id": null,
        "planning_id": "e23b95fe-995b-4e06-b276-dc4e34294340",
        "parent_line_id": null,
        "owner_id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2",
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
      "id": "e23b95fe-995b-4e06-b276-dc4e34294340",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:20:02+00:00",
        "updated_at": "2023-02-09T12:20:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T12:15:00+00:00",
        "stops_at": "2023-02-11T12:15:00+00:00",
        "reserved_from": "2023-02-07T12:15:00+00:00",
        "reserved_till": "2023-02-11T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "af0f4524-2793-4c9e-801d-7b05962030fb",
        "order_id": "95b0b91b-b789-4d15-9ea3-0451b824a6a2",
        "start_location_id": "589d3940-66f3-4b83-922e-265a983adb99",
        "stop_location_id": "589d3940-66f3-4b83-922e-265a983adb99",
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





