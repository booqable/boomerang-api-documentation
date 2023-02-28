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
          "order_id": "19ac8d55-d21e-4f1b-b568-10b69e640324",
          "items": [
            {
              "type": "products",
              "id": "d17814c3-02f8-477d-b24e-2e86e0fb7c80",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7243d231-1908-45b1-a1bb-cf6210be2633",
              "stock_item_ids": [
                "1f7ca8b5-5b99-4f95-8900-d5b1239bbe9b",
                "04ff2bf5-f39b-4186-821e-d61afd70a679"
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
          "stock_item_id 1f7ca8b5-5b99-4f95-8900-d5b1239bbe9b has already been booked on this order"
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
          "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
          "items": [
            {
              "type": "products",
              "id": "69c87f6c-5c98-4d12-8c25-71fffbc900eb",
              "stock_item_ids": [
                "6e63ba2d-292a-4218-85d8-1f80b41d8881",
                "486c4d25-49d1-455b-9bb6-80a93028925a",
                "2f73b40c-7583-46ca-a333-e88c0b0cd49e"
              ]
            },
            {
              "type": "products",
              "id": "46178446-fb72-453f-8a85-2253698b1e25",
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
    "id": "7691b924-b27b-5291-a6d1-b9b41e00e2ed",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "264a2bac-5a04-4a46-82da-6e3cfb5197e0"
          },
          {
            "type": "lines",
            "id": "14e16ef9-e807-4eaa-9791-b18d97be5526"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb"
          },
          {
            "type": "plannings",
            "id": "026bef17-b926-4aeb-a71f-4629bfb81eb8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "682f0ce2-5e23-4bbf-8f3b-d7ca726aba24"
          },
          {
            "type": "stock_item_plannings",
            "id": "0a96af79-4068-4779-ae3b-851a1f840606"
          },
          {
            "type": "stock_item_plannings",
            "id": "6aa43d9a-a6d9-435b-99d1-33b99fa1ea0f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T07:30:58+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
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
        "customer_id": "0653981a-5b9e-4798-84ef-59fbc6c87dbc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607",
        "stop_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607"
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
      "id": "264a2bac-5a04-4a46-82da-6e3cfb5197e0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
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
        "item_id": "69c87f6c-5c98-4d12-8c25-71fffbc900eb",
        "tax_category_id": "1ff5ec34-b82c-4767-b902-cc1227328647",
        "planning_id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb",
        "parent_line_id": null,
        "owner_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
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
      "id": "14e16ef9-e807-4eaa-9791-b18d97be5526",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
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
        "item_id": "46178446-fb72-453f-8a85-2253698b1e25",
        "tax_category_id": "1ff5ec34-b82c-4767-b902-cc1227328647",
        "planning_id": "026bef17-b926-4aeb-a71f-4629bfb81eb8",
        "parent_line_id": null,
        "owner_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
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
      "id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
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
        "item_id": "69c87f6c-5c98-4d12-8c25-71fffbc900eb",
        "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
        "start_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607",
        "stop_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607",
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
      "id": "026bef17-b926-4aeb-a71f-4629bfb81eb8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
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
        "item_id": "46178446-fb72-453f-8a85-2253698b1e25",
        "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb",
        "start_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607",
        "stop_location_id": "05151074-fe2d-4b96-800b-06b9f34cb607",
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
      "id": "682f0ce2-5e23-4bbf-8f3b-d7ca726aba24",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6e63ba2d-292a-4218-85d8-1f80b41d8881",
        "planning_id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb",
        "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb"
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
      "id": "0a96af79-4068-4779-ae3b-851a1f840606",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "486c4d25-49d1-455b-9bb6-80a93028925a",
        "planning_id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb",
        "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb"
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
      "id": "6aa43d9a-a6d9-435b-99d1-33b99fa1ea0f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T07:30:59+00:00",
        "updated_at": "2023-02-28T07:30:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2f73b40c-7583-46ca-a333-e88c0b0cd49e",
        "planning_id": "1db2721d-b4cf-4b3a-8c1d-2738245edecb",
        "order_id": "bffd2e3b-5d71-413d-ad07-9cdcf557cddb"
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
          "order_id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df",
          "items": [
            {
              "type": "bundles",
              "id": "923395d0-abc4-4144-9669-03c74f39fa8a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "96df3728-38d4-4060-b9c1-eaf6e478d8a5",
                  "id": "3b2807a0-6c9e-4aa9-af85-a32f00bb0135"
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
    "id": "5609ff6f-bab5-5d2e-afd0-f3d46f4826eb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "591d9348-1953-402a-98e6-c83ff55e0a09"
          },
          {
            "type": "lines",
            "id": "6b09a707-40b7-4812-a159-bf76611e5739"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1119594d-2eba-4f94-8da0-dbaf74ba40e1"
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
      "id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T07:31:01+00:00",
        "updated_at": "2023-02-28T07:31:02+00:00",
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
        "starts_at": "2023-02-26T07:30:00+00:00",
        "stops_at": "2023-03-02T07:30:00+00:00",
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
        "start_location_id": "46a34fb9-659d-4997-bd69-15539e1b4b65",
        "stop_location_id": "46a34fb9-659d-4997-bd69-15539e1b4b65"
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
      "id": "591d9348-1953-402a-98e6-c83ff55e0a09",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T07:31:02+00:00",
        "updated_at": "2023-02-28T07:31:02+00:00",
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
        "item_id": "923395d0-abc4-4144-9669-03c74f39fa8a",
        "tax_category_id": null,
        "planning_id": "1119594d-2eba-4f94-8da0-dbaf74ba40e1",
        "parent_line_id": null,
        "owner_id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df",
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
      "id": "6b09a707-40b7-4812-a159-bf76611e5739",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T07:31:02+00:00",
        "updated_at": "2023-02-28T07:31:02+00:00",
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
        "item_id": "3b2807a0-6c9e-4aa9-af85-a32f00bb0135",
        "tax_category_id": null,
        "planning_id": "9b044834-422b-4656-a6bf-7fc1807b56d0",
        "parent_line_id": "591d9348-1953-402a-98e6-c83ff55e0a09",
        "owner_id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df",
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
      "id": "1119594d-2eba-4f94-8da0-dbaf74ba40e1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T07:31:01+00:00",
        "updated_at": "2023-02-28T07:31:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-26T07:30:00+00:00",
        "stops_at": "2023-03-02T07:30:00+00:00",
        "reserved_from": "2023-02-26T07:30:00+00:00",
        "reserved_till": "2023-03-02T07:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "923395d0-abc4-4144-9669-03c74f39fa8a",
        "order_id": "0bbd343b-4ab5-40f8-aa00-4cd41142d8df",
        "start_location_id": "46a34fb9-659d-4997-bd69-15539e1b4b65",
        "stop_location_id": "46a34fb9-659d-4997-bd69-15539e1b4b65",
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





