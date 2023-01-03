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
          "order_id": "66f39deb-bdfb-4b89-a0e9-ff47bc637631",
          "items": [
            {
              "type": "products",
              "id": "468b1965-a9ab-4235-bb80-8a2a41bac22f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8cce378b-7c52-45a4-8b59-69ee235f2180",
              "stock_item_ids": [
                "c26b629f-4765-4391-b75a-3f694dcec917",
                "c2d3b93d-73d4-4f83-ad69-316bf0e7dfb6"
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
            "item_id": "468b1965-a9ab-4235-bb80-8a2a41bac22f",
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
          "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
          "items": [
            {
              "type": "products",
              "id": "da6b36fb-8245-4c6f-8082-0e1b73d38804",
              "stock_item_ids": [
                "1344bf74-4e66-4a86-809c-4cc2d66fe2a9",
                "6f141f91-96c0-4d92-9009-6986b20f1c9c",
                "a97e19d8-00cb-4035-94a2-63f3f13948c2"
              ]
            },
            {
              "type": "products",
              "id": "e137d2d9-23fb-40ad-824c-7efed01f1d88",
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
    "id": "8a9c41c0-d7f0-5a33-911a-e481fd86a89f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "28c0c558-0b82-499c-884a-1dad2b78fe05"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b71151f7-751c-47f2-a059-e2c088605dd1"
          },
          {
            "type": "lines",
            "id": "0f7e6448-9135-4fd6-a8ea-14251a2951d6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f"
          },
          {
            "type": "plannings",
            "id": "3e761005-cfbc-4aa2-b520-f5c9616efe28"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b26c9807-a78a-44eb-94e5-9bc214968c73"
          },
          {
            "type": "stock_item_plannings",
            "id": "cb338c6e-b444-4453-b06d-ea4695fd036e"
          },
          {
            "type": "stock_item_plannings",
            "id": "5a587036-f01f-4c78-aa7c-6f07d4b2b306"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-03T12:13:22+00:00",
        "updated_at": "2023-01-03T12:13:24+00:00",
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
        "customer_id": "bf01a107-8dbc-4126-a6f5-5e99d5538975",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2c607aea-b680-49de-8766-0b03db095cb7",
        "stop_location_id": "2c607aea-b680-49de-8766-0b03db095cb7"
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
      "id": "b71151f7-751c-47f2-a059-e2c088605dd1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:23+00:00",
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
        "item_id": "da6b36fb-8245-4c6f-8082-0e1b73d38804",
        "tax_category_id": "54c58a18-94d0-4930-80c0-94fceb26daab",
        "planning_id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f",
        "parent_line_id": null,
        "owner_id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
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
      "id": "0f7e6448-9135-4fd6-a8ea-14251a2951d6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:23+00:00",
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
        "item_id": "e137d2d9-23fb-40ad-824c-7efed01f1d88",
        "tax_category_id": "54c58a18-94d0-4930-80c0-94fceb26daab",
        "planning_id": "3e761005-cfbc-4aa2-b520-f5c9616efe28",
        "parent_line_id": null,
        "owner_id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
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
      "id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:24+00:00",
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
        "item_id": "da6b36fb-8245-4c6f-8082-0e1b73d38804",
        "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
        "start_location_id": "2c607aea-b680-49de-8766-0b03db095cb7",
        "stop_location_id": "2c607aea-b680-49de-8766-0b03db095cb7",
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
      "id": "3e761005-cfbc-4aa2-b520-f5c9616efe28",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:24+00:00",
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
        "item_id": "e137d2d9-23fb-40ad-824c-7efed01f1d88",
        "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05",
        "start_location_id": "2c607aea-b680-49de-8766-0b03db095cb7",
        "stop_location_id": "2c607aea-b680-49de-8766-0b03db095cb7",
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
      "id": "b26c9807-a78a-44eb-94e5-9bc214968c73",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1344bf74-4e66-4a86-809c-4cc2d66fe2a9",
        "planning_id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f",
        "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05"
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
      "id": "cb338c6e-b444-4453-b06d-ea4695fd036e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6f141f91-96c0-4d92-9009-6986b20f1c9c",
        "planning_id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f",
        "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05"
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
      "id": "5a587036-f01f-4c78-aa7c-6f07d4b2b306",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:23+00:00",
        "updated_at": "2023-01-03T12:13:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a97e19d8-00cb-4035-94a2-63f3f13948c2",
        "planning_id": "941bb459-fd46-4cbf-a1aa-a75cf5b4f03f",
        "order_id": "28c0c558-0b82-499c-884a-1dad2b78fe05"
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
          "order_id": "dc3fb848-308f-4225-9661-34ce6ace1a46",
          "items": [
            {
              "type": "bundles",
              "id": "cbf8a0a1-45b6-40a5-95bf-6af8fa7ef80b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c834ceab-823a-4f2d-8db8-0ea5d1456e1d",
                  "id": "13e1b66b-e130-45ca-9bba-3681193e8402"
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
    "id": "8fb53342-0989-5ffe-b797-d156e98c664e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dc3fb848-308f-4225-9661-34ce6ace1a46"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dc3fb848-308f-4225-9661-34ce6ace1a46"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d9d26849-7dc0-4bf4-862f-28fd4c9a0b3a"
          },
          {
            "type": "lines",
            "id": "7426dc5e-bc44-4793-b5da-b10eef161441"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d44084b3-d1f9-49f4-8182-920d3247dd4a"
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
      "id": "dc3fb848-308f-4225-9661-34ce6ace1a46",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-03T12:13:26+00:00",
        "updated_at": "2023-01-03T12:13:27+00:00",
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
        "starts_at": "2023-01-01T12:00:00+00:00",
        "stops_at": "2023-01-05T12:00:00+00:00",
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
        "start_location_id": "2cbbe10d-c7a1-4abb-bb81-5b229c85b3d7",
        "stop_location_id": "2cbbe10d-c7a1-4abb-bb81-5b229c85b3d7"
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
      "id": "d9d26849-7dc0-4bf4-862f-28fd4c9a0b3a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-03T12:13:27+00:00",
        "updated_at": "2023-01-03T12:13:27+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 9 - red",
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
        "item_id": "13e1b66b-e130-45ca-9bba-3681193e8402",
        "tax_category_id": null,
        "planning_id": "004ad670-f14e-43f5-b3fe-3441e6d453ad",
        "parent_line_id": "7426dc5e-bc44-4793-b5da-b10eef161441",
        "owner_id": "dc3fb848-308f-4225-9661-34ce6ace1a46",
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
      "id": "7426dc5e-bc44-4793-b5da-b10eef161441",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-03T12:13:27+00:00",
        "updated_at": "2023-01-03T12:13:27+00:00",
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
        "item_id": "cbf8a0a1-45b6-40a5-95bf-6af8fa7ef80b",
        "tax_category_id": null,
        "planning_id": "d44084b3-d1f9-49f4-8182-920d3247dd4a",
        "parent_line_id": null,
        "owner_id": "dc3fb848-308f-4225-9661-34ce6ace1a46",
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
      "id": "d44084b3-d1f9-49f4-8182-920d3247dd4a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-03T12:13:27+00:00",
        "updated_at": "2023-01-03T12:13:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-01T12:00:00+00:00",
        "stops_at": "2023-01-05T12:00:00+00:00",
        "reserved_from": "2023-01-01T12:00:00+00:00",
        "reserved_till": "2023-01-05T12:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cbf8a0a1-45b6-40a5-95bf-6af8fa7ef80b",
        "order_id": "dc3fb848-308f-4225-9661-34ce6ace1a46",
        "start_location_id": "2cbbe10d-c7a1-4abb-bb81-5b229c85b3d7",
        "stop_location_id": "2cbbe10d-c7a1-4abb-bb81-5b229c85b3d7",
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





