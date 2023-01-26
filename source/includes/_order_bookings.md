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
          "order_id": "25ba77f4-b201-420c-a907-bd4e241d7d0c",
          "items": [
            {
              "type": "products",
              "id": "54e3abd0-2808-4ac8-9166-18dfeca744ef",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5febd679-66e0-47f4-ae49-0ee309feeeca",
              "stock_item_ids": [
                "c5aadaee-f76e-466e-96ea-326a0f59923d",
                "8bb5e865-d240-4677-9c4a-ab1d30794991"
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
            "item_id": "54e3abd0-2808-4ac8-9166-18dfeca744ef",
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
          "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
          "items": [
            {
              "type": "products",
              "id": "035c46af-3461-4572-a765-5fb22576e9ad",
              "stock_item_ids": [
                "c09e18e9-5e61-43d4-b87f-391b9b4929d5",
                "f5f9a595-b40e-4093-9c25-9052d16c9c2d",
                "10a978a5-d96d-4b21-bdd7-9d48ae2b311a"
              ]
            },
            {
              "type": "products",
              "id": "b294cd2e-039d-4db6-9428-23121de35bb7",
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
    "id": "fe5927bf-a91c-5d8c-9c8b-473889ea2cce",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9ee2e5af-038b-4a63-afe4-64f54d12e246"
          },
          {
            "type": "lines",
            "id": "288c1b03-1eb9-4370-8d30-28ad98884c4b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9f25aae1-2d67-4c5b-81be-aac9dc591514"
          },
          {
            "type": "plannings",
            "id": "fc644f71-9b1c-4f7a-ad8c-9832f9809d80"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a54877d2-9ead-4a7d-809e-14fa9f9c77a2"
          },
          {
            "type": "stock_item_plannings",
            "id": "d36212ad-4404-4a86-a84e-bdbd74031181"
          },
          {
            "type": "stock_item_plannings",
            "id": "269f48ac-c24b-47e0-b73c-f30f52d03a52"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T12:17:56+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
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
        "customer_id": "2ba5ac7f-6271-4052-bf05-c55212d08fd1",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "03f33e21-a868-4846-b820-0e21faabd986",
        "stop_location_id": "03f33e21-a868-4846-b820-0e21faabd986"
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
      "id": "9ee2e5af-038b-4a63-afe4-64f54d12e246",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
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
        "item_id": "035c46af-3461-4572-a765-5fb22576e9ad",
        "tax_category_id": "f329166c-1239-4bcb-87eb-67f0019fab0a",
        "planning_id": "9f25aae1-2d67-4c5b-81be-aac9dc591514",
        "parent_line_id": null,
        "owner_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
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
      "id": "288c1b03-1eb9-4370-8d30-28ad98884c4b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
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
        "item_id": "b294cd2e-039d-4db6-9428-23121de35bb7",
        "tax_category_id": "f329166c-1239-4bcb-87eb-67f0019fab0a",
        "planning_id": "fc644f71-9b1c-4f7a-ad8c-9832f9809d80",
        "parent_line_id": null,
        "owner_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
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
      "id": "9f25aae1-2d67-4c5b-81be-aac9dc591514",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
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
        "item_id": "035c46af-3461-4572-a765-5fb22576e9ad",
        "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
        "start_location_id": "03f33e21-a868-4846-b820-0e21faabd986",
        "stop_location_id": "03f33e21-a868-4846-b820-0e21faabd986",
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
      "id": "fc644f71-9b1c-4f7a-ad8c-9832f9809d80",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
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
        "item_id": "b294cd2e-039d-4db6-9428-23121de35bb7",
        "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915",
        "start_location_id": "03f33e21-a868-4846-b820-0e21faabd986",
        "stop_location_id": "03f33e21-a868-4846-b820-0e21faabd986",
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
      "id": "a54877d2-9ead-4a7d-809e-14fa9f9c77a2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c09e18e9-5e61-43d4-b87f-391b9b4929d5",
        "planning_id": "9f25aae1-2d67-4c5b-81be-aac9dc591514",
        "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915"
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
      "id": "d36212ad-4404-4a86-a84e-bdbd74031181",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f5f9a595-b40e-4093-9c25-9052d16c9c2d",
        "planning_id": "9f25aae1-2d67-4c5b-81be-aac9dc591514",
        "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915"
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
      "id": "269f48ac-c24b-47e0-b73c-f30f52d03a52",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T12:17:58+00:00",
        "updated_at": "2023-01-26T12:17:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "10a978a5-d96d-4b21-bdd7-9d48ae2b311a",
        "planning_id": "9f25aae1-2d67-4c5b-81be-aac9dc591514",
        "order_id": "bb6d4b4d-f7c2-4b07-a4e3-754782e71915"
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
          "order_id": "4aca22d2-9d23-4a12-b391-31e73c260256",
          "items": [
            {
              "type": "bundles",
              "id": "9d0c7627-64ec-417c-b329-15445b8950c9",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9c39f2b2-8025-49fa-9018-023ca6880655",
                  "id": "fd606853-73ca-4e1c-8ad9-50322849df84"
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
    "id": "6af04839-41bd-5709-9198-3115c71f43bc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4aca22d2-9d23-4a12-b391-31e73c260256"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4aca22d2-9d23-4a12-b391-31e73c260256"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5cbf21d4-592a-4d4f-a49a-e759fecdba9f"
          },
          {
            "type": "lines",
            "id": "af3c3229-c21f-4e01-b7b9-299378a366aa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4d13365c-7f20-4168-860d-d445c0d22012"
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
      "id": "4aca22d2-9d23-4a12-b391-31e73c260256",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T12:18:00+00:00",
        "updated_at": "2023-01-26T12:18:01+00:00",
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
        "starts_at": "2023-01-24T12:15:00+00:00",
        "stops_at": "2023-01-28T12:15:00+00:00",
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
        "start_location_id": "45cac1f3-b987-4645-b516-dbdc0ba83e81",
        "stop_location_id": "45cac1f3-b987-4645-b516-dbdc0ba83e81"
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
      "id": "5cbf21d4-592a-4d4f-a49a-e759fecdba9f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T12:18:01+00:00",
        "updated_at": "2023-01-26T12:18:01+00:00",
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
        "item_id": "9d0c7627-64ec-417c-b329-15445b8950c9",
        "tax_category_id": null,
        "planning_id": "4d13365c-7f20-4168-860d-d445c0d22012",
        "parent_line_id": null,
        "owner_id": "4aca22d2-9d23-4a12-b391-31e73c260256",
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
      "id": "af3c3229-c21f-4e01-b7b9-299378a366aa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T12:18:01+00:00",
        "updated_at": "2023-01-26T12:18:01+00:00",
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
        "item_id": "fd606853-73ca-4e1c-8ad9-50322849df84",
        "tax_category_id": null,
        "planning_id": "55af095a-e3ad-4ace-a7e2-033488456fb7",
        "parent_line_id": "5cbf21d4-592a-4d4f-a49a-e759fecdba9f",
        "owner_id": "4aca22d2-9d23-4a12-b391-31e73c260256",
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
      "id": "4d13365c-7f20-4168-860d-d445c0d22012",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T12:18:00+00:00",
        "updated_at": "2023-01-26T12:18:00+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-24T12:15:00+00:00",
        "stops_at": "2023-01-28T12:15:00+00:00",
        "reserved_from": "2023-01-24T12:15:00+00:00",
        "reserved_till": "2023-01-28T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9d0c7627-64ec-417c-b329-15445b8950c9",
        "order_id": "4aca22d2-9d23-4a12-b391-31e73c260256",
        "start_location_id": "45cac1f3-b987-4645-b516-dbdc0ba83e81",
        "stop_location_id": "45cac1f3-b987-4645-b516-dbdc0ba83e81",
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





