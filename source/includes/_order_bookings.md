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
          "order_id": "1d68d2d8-96cd-4541-abfd-5fde6fc5cdff",
          "items": [
            {
              "type": "products",
              "id": "7d63c373-95e6-489d-adcf-4321849940ab",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8fc80076-158c-4c24-82ef-da8bec24d7a0",
              "stock_item_ids": [
                "a61357be-b1e8-476a-81eb-00c83a1c4ee4",
                "0df592e5-2f3f-4f77-8ab8-9c166d8772f9"
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
          "stock_item_id a61357be-b1e8-476a-81eb-00c83a1c4ee4 has already been booked on this order"
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
          "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
          "items": [
            {
              "type": "products",
              "id": "4243da79-a27f-4c76-af12-d26bba77e76e",
              "stock_item_ids": [
                "c9f4b57b-2546-4813-a2a8-1e1fbe29271d",
                "657f47cc-fad3-4a1f-b76d-2b563943cb88",
                "e495353b-805e-4801-a80d-0f66fdf6ee45"
              ]
            },
            {
              "type": "products",
              "id": "21e4bc5c-d6c9-4075-b480-236287896ea3",
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
    "id": "41b1596b-9372-5818-b5fa-a4632b4dfa4d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "708e9fcb-159b-4860-ad49-610cb3a723c2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c90d1218-4e3e-4fdb-be65-9c189a5d1769"
          },
          {
            "type": "lines",
            "id": "500a1954-fc94-4190-80d1-f1e3b2ae85d1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3d036f33-9458-4503-bc40-07aea3a64129"
          },
          {
            "type": "plannings",
            "id": "3fbe31ec-269c-40c0-8533-8f1470051477"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ad2dd17d-980d-4c99-8950-817616b61245"
          },
          {
            "type": "stock_item_plannings",
            "id": "eaf92b2f-86a2-437d-bf74-26b66fab12d8"
          },
          {
            "type": "stock_item_plannings",
            "id": "03f95d05-1482-4f06-8fc7-c2db66676c11"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T16:15:39+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
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
        "customer_id": "3b65fc3f-5ba3-41d1-9e77-75b7cbce5737",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441",
        "stop_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441"
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
      "id": "c90d1218-4e3e-4fdb-be65-9c189a5d1769",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
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
        "item_id": "4243da79-a27f-4c76-af12-d26bba77e76e",
        "tax_category_id": "53c988db-05c9-4865-ac1f-2353d96819cb",
        "planning_id": "3d036f33-9458-4503-bc40-07aea3a64129",
        "parent_line_id": null,
        "owner_id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
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
      "id": "500a1954-fc94-4190-80d1-f1e3b2ae85d1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
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
        "item_id": "21e4bc5c-d6c9-4075-b480-236287896ea3",
        "tax_category_id": "53c988db-05c9-4865-ac1f-2353d96819cb",
        "planning_id": "3fbe31ec-269c-40c0-8533-8f1470051477",
        "parent_line_id": null,
        "owner_id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
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
      "id": "3d036f33-9458-4503-bc40-07aea3a64129",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
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
        "item_id": "4243da79-a27f-4c76-af12-d26bba77e76e",
        "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
        "start_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441",
        "stop_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441",
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
      "id": "3fbe31ec-269c-40c0-8533-8f1470051477",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
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
        "item_id": "21e4bc5c-d6c9-4075-b480-236287896ea3",
        "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2",
        "start_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441",
        "stop_location_id": "1667341e-de9e-4c6b-9490-97e181fc6441",
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
      "id": "ad2dd17d-980d-4c99-8950-817616b61245",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c9f4b57b-2546-4813-a2a8-1e1fbe29271d",
        "planning_id": "3d036f33-9458-4503-bc40-07aea3a64129",
        "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2"
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
      "id": "eaf92b2f-86a2-437d-bf74-26b66fab12d8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "657f47cc-fad3-4a1f-b76d-2b563943cb88",
        "planning_id": "3d036f33-9458-4503-bc40-07aea3a64129",
        "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2"
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
      "id": "03f95d05-1482-4f06-8fc7-c2db66676c11",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:41+00:00",
        "updated_at": "2023-02-21T16:15:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e495353b-805e-4801-a80d-0f66fdf6ee45",
        "planning_id": "3d036f33-9458-4503-bc40-07aea3a64129",
        "order_id": "708e9fcb-159b-4860-ad49-610cb3a723c2"
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
          "order_id": "41927efd-55c6-4278-964b-953086d291f4",
          "items": [
            {
              "type": "bundles",
              "id": "c5df08af-2ae5-45a0-b24d-8e9a9a5a699c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f473c7fe-f037-4ff5-890a-ae6cf9c6c844",
                  "id": "e481e06e-355b-4f93-bd51-54e17ebb6e20"
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
    "id": "59aca2c6-899c-5830-878c-dc1af3d6877f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "41927efd-55c6-4278-964b-953086d291f4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "41927efd-55c6-4278-964b-953086d291f4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6125a525-82da-4281-864f-9add385ec506"
          },
          {
            "type": "lines",
            "id": "dc48d405-a718-448d-be22-842a11892124"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d4351734-0b41-436a-b4d5-42a6298c4aad"
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
      "id": "41927efd-55c6-4278-964b-953086d291f4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T16:15:43+00:00",
        "updated_at": "2023-02-21T16:15:44+00:00",
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
        "starts_at": "2023-02-19T16:15:00+00:00",
        "stops_at": "2023-02-23T16:15:00+00:00",
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
        "start_location_id": "72a75282-cc06-4b39-8bed-9e0883d45d99",
        "stop_location_id": "72a75282-cc06-4b39-8bed-9e0883d45d99"
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
      "id": "6125a525-82da-4281-864f-9add385ec506",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:15:44+00:00",
        "updated_at": "2023-02-21T16:15:44+00:00",
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
        "item_id": "c5df08af-2ae5-45a0-b24d-8e9a9a5a699c",
        "tax_category_id": null,
        "planning_id": "d4351734-0b41-436a-b4d5-42a6298c4aad",
        "parent_line_id": null,
        "owner_id": "41927efd-55c6-4278-964b-953086d291f4",
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
      "id": "dc48d405-a718-448d-be22-842a11892124",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T16:15:44+00:00",
        "updated_at": "2023-02-21T16:15:44+00:00",
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
        "item_id": "e481e06e-355b-4f93-bd51-54e17ebb6e20",
        "tax_category_id": null,
        "planning_id": "29ab6c4b-d20e-4f21-8e42-5268809f531c",
        "parent_line_id": "6125a525-82da-4281-864f-9add385ec506",
        "owner_id": "41927efd-55c6-4278-964b-953086d291f4",
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
      "id": "d4351734-0b41-436a-b4d5-42a6298c4aad",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T16:15:44+00:00",
        "updated_at": "2023-02-21T16:15:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T16:15:00+00:00",
        "stops_at": "2023-02-23T16:15:00+00:00",
        "reserved_from": "2023-02-19T16:15:00+00:00",
        "reserved_till": "2023-02-23T16:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c5df08af-2ae5-45a0-b24d-8e9a9a5a699c",
        "order_id": "41927efd-55c6-4278-964b-953086d291f4",
        "start_location_id": "72a75282-cc06-4b39-8bed-9e0883d45d99",
        "stop_location_id": "72a75282-cc06-4b39-8bed-9e0883d45d99",
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





