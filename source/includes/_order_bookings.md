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
          "order_id": "f571843c-4a93-46f6-be91-5de268515c37",
          "items": [
            {
              "type": "products",
              "id": "d4bd96b6-e206-4af5-bf61-ac22a9436886",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "81f65fd8-c534-4f8d-8a6a-523b318afdb0",
              "stock_item_ids": [
                "b52ab409-afc3-4797-a815-734996ad3aaf",
                "60f6ab21-4d17-48a9-ae51-75a02da886b5"
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
            "item_id": "d4bd96b6-e206-4af5-bf61-ac22a9436886",
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
          "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
          "items": [
            {
              "type": "products",
              "id": "c2f67acd-9aef-40b0-9720-b93fe487d7c4",
              "stock_item_ids": [
                "35cb17ae-5b14-4b89-b6e8-9ed1e78fff06",
                "82a19ee8-3300-4b9b-8eec-910dd175eeea",
                "9ba84117-912f-4080-92f7-a21f64c3a61d"
              ]
            },
            {
              "type": "products",
              "id": "1b104f45-42e8-49d2-9bc3-a41194514373",
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
    "id": "a7ad73a4-dee1-5c80-8b61-19ca1e4520d9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "32afa426-1810-4829-a020-f7bf0d8460da"
          },
          {
            "type": "lines",
            "id": "89c057ba-f1f1-445f-a758-3ba15f84c29e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1bfbf070-a545-4000-8cc0-5e0240433638"
          },
          {
            "type": "plannings",
            "id": "8f4c6c84-ed24-4192-b51c-45e0ae6db25b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ec4145fd-7bfb-475d-9b18-fd756aa44a7f"
          },
          {
            "type": "stock_item_plannings",
            "id": "21419755-94c4-4ca5-a2b3-62402e115774"
          },
          {
            "type": "stock_item_plannings",
            "id": "3831a8f8-e8ed-4f97-a96b-f7eab2df2cc3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T14:23:35+00:00",
        "updated_at": "2023-02-09T14:23:38+00:00",
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
        "customer_id": "bbad074b-22de-46f3-abad-8bfb9179efd6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c",
        "stop_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c"
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
      "id": "32afa426-1810-4829-a020-f7bf0d8460da",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:38+00:00",
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
        "item_id": "c2f67acd-9aef-40b0-9720-b93fe487d7c4",
        "tax_category_id": "9226bdd2-b099-4361-9ddf-06c74837f079",
        "planning_id": "1bfbf070-a545-4000-8cc0-5e0240433638",
        "parent_line_id": null,
        "owner_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
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
      "id": "89c057ba-f1f1-445f-a758-3ba15f84c29e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:38+00:00",
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
        "item_id": "1b104f45-42e8-49d2-9bc3-a41194514373",
        "tax_category_id": "9226bdd2-b099-4361-9ddf-06c74837f079",
        "planning_id": "8f4c6c84-ed24-4192-b51c-45e0ae6db25b",
        "parent_line_id": null,
        "owner_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
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
      "id": "1bfbf070-a545-4000-8cc0-5e0240433638",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:38+00:00",
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
        "item_id": "c2f67acd-9aef-40b0-9720-b93fe487d7c4",
        "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
        "start_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c",
        "stop_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c",
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
      "id": "8f4c6c84-ed24-4192-b51c-45e0ae6db25b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:38+00:00",
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
        "item_id": "1b104f45-42e8-49d2-9bc3-a41194514373",
        "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307",
        "start_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c",
        "stop_location_id": "164a4142-b64a-4de5-af59-90fd963d4a9c",
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
      "id": "ec4145fd-7bfb-475d-9b18-fd756aa44a7f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "35cb17ae-5b14-4b89-b6e8-9ed1e78fff06",
        "planning_id": "1bfbf070-a545-4000-8cc0-5e0240433638",
        "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307"
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
      "id": "21419755-94c4-4ca5-a2b3-62402e115774",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "82a19ee8-3300-4b9b-8eec-910dd175eeea",
        "planning_id": "1bfbf070-a545-4000-8cc0-5e0240433638",
        "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307"
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
      "id": "3831a8f8-e8ed-4f97-a96b-f7eab2df2cc3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:37+00:00",
        "updated_at": "2023-02-09T14:23:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ba84117-912f-4080-92f7-a21f64c3a61d",
        "planning_id": "1bfbf070-a545-4000-8cc0-5e0240433638",
        "order_id": "cd31dfd0-e778-44d0-a0dd-6eab262e5307"
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
          "order_id": "2b008b94-ca7d-48db-8884-4b61f5292ef0",
          "items": [
            {
              "type": "bundles",
              "id": "4ab61455-a68d-4c77-b90e-2619f4920a00",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b57a7059-d10b-468f-add7-a4b5ce859ce9",
                  "id": "18e82319-5818-4c10-b5fd-7e712ab386d1"
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
    "id": "6ab428fc-d7cb-52a2-9ef9-780aec07ef2e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2b008b94-ca7d-48db-8884-4b61f5292ef0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2b008b94-ca7d-48db-8884-4b61f5292ef0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8d023358-b02f-4346-a989-76486af70f22"
          },
          {
            "type": "lines",
            "id": "2b595cf3-e765-4d8f-a79d-45d33c70644f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e0818e58-38b7-4460-98e7-17f5d687cf03"
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
      "id": "2b008b94-ca7d-48db-8884-4b61f5292ef0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T14:23:41+00:00",
        "updated_at": "2023-02-09T14:23:42+00:00",
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
        "starts_at": "2023-02-07T14:15:00+00:00",
        "stops_at": "2023-02-11T14:15:00+00:00",
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
        "start_location_id": "aef7a9d1-b003-409a-90d3-de9a84f2e9d0",
        "stop_location_id": "aef7a9d1-b003-409a-90d3-de9a84f2e9d0"
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
      "id": "8d023358-b02f-4346-a989-76486af70f22",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T14:23:42+00:00",
        "updated_at": "2023-02-09T14:23:42+00:00",
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
        "item_id": "18e82319-5818-4c10-b5fd-7e712ab386d1",
        "tax_category_id": null,
        "planning_id": "85d04ce9-4c0b-427b-b66a-00237b258e1d",
        "parent_line_id": "2b595cf3-e765-4d8f-a79d-45d33c70644f",
        "owner_id": "2b008b94-ca7d-48db-8884-4b61f5292ef0",
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
      "id": "2b595cf3-e765-4d8f-a79d-45d33c70644f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T14:23:42+00:00",
        "updated_at": "2023-02-09T14:23:42+00:00",
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
        "item_id": "4ab61455-a68d-4c77-b90e-2619f4920a00",
        "tax_category_id": null,
        "planning_id": "e0818e58-38b7-4460-98e7-17f5d687cf03",
        "parent_line_id": null,
        "owner_id": "2b008b94-ca7d-48db-8884-4b61f5292ef0",
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
      "id": "e0818e58-38b7-4460-98e7-17f5d687cf03",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T14:23:42+00:00",
        "updated_at": "2023-02-09T14:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T14:15:00+00:00",
        "stops_at": "2023-02-11T14:15:00+00:00",
        "reserved_from": "2023-02-07T14:15:00+00:00",
        "reserved_till": "2023-02-11T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4ab61455-a68d-4c77-b90e-2619f4920a00",
        "order_id": "2b008b94-ca7d-48db-8884-4b61f5292ef0",
        "start_location_id": "aef7a9d1-b003-409a-90d3-de9a84f2e9d0",
        "stop_location_id": "aef7a9d1-b003-409a-90d3-de9a84f2e9d0",
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





