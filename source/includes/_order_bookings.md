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
          "order_id": "7ff1c9f4-2b4d-4d0d-9830-bbbf5d4a1aa2",
          "items": [
            {
              "type": "products",
              "id": "d1f54bd6-46ee-43d9-bfd8-c0f4e191d79f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c32df877-508a-4d18-87f7-b15f9958cb8e",
              "stock_item_ids": [
                "8f5d3f24-5152-49e1-a64c-7d824ab89c14",
                "cd542972-e611-4b6c-8cc0-7e4916100d11"
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
            "item_id": "d1f54bd6-46ee-43d9-bfd8-c0f4e191d79f",
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
          "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
          "items": [
            {
              "type": "products",
              "id": "653dbd84-a7f5-4e67-aa36-f45087280988",
              "stock_item_ids": [
                "b84b467c-4b55-4395-909b-3a670007a521",
                "cbf219a7-39a3-4615-99c8-679ec2f0d6f7",
                "1c4f9f86-4f22-4e49-b826-9fdc72baf6f3"
              ]
            },
            {
              "type": "products",
              "id": "8210c17d-3801-461a-9939-fd692d272906",
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
    "id": "c414e680-427e-5715-a924-ae7bbbc25277",
    "type": "order_bookings",
    "attributes": {
      "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4bb13a00-9625-463a-be3c-fea1a6748788"
          },
          {
            "type": "lines",
            "id": "e1602230-d46e-40cd-a25f-1be6526a014d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9c563f13-14cd-45b4-b22f-c52076da1cd5"
          },
          {
            "type": "plannings",
            "id": "8ef35943-0fd5-435b-9386-c5cd8e0c73da"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ab678b21-b03a-4a63-bb7c-c58590094fa6"
          },
          {
            "type": "stock_item_plannings",
            "id": "3f0840cb-3aa4-40ea-8de0-4ab8d97b4898"
          },
          {
            "type": "stock_item_plannings",
            "id": "fa34446c-8dfb-49bd-94cf-0de2f8f590f8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-19T10:29:18+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
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
        "customer_id": "13271704-2f07-48ea-bf04-388afb0b790f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642",
        "stop_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642"
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
      "id": "4bb13a00-9625-463a-be3c-fea1a6748788",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
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
        "item_id": "653dbd84-a7f5-4e67-aa36-f45087280988",
        "tax_category_id": "0b6e8065-360e-47b5-8fe1-502ffea30296",
        "planning_id": "9c563f13-14cd-45b4-b22f-c52076da1cd5",
        "parent_line_id": null,
        "owner_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
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
      "id": "e1602230-d46e-40cd-a25f-1be6526a014d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
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
        "item_id": "8210c17d-3801-461a-9939-fd692d272906",
        "tax_category_id": "0b6e8065-360e-47b5-8fe1-502ffea30296",
        "planning_id": "8ef35943-0fd5-435b-9386-c5cd8e0c73da",
        "parent_line_id": null,
        "owner_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
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
      "id": "9c563f13-14cd-45b4-b22f-c52076da1cd5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
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
        "item_id": "653dbd84-a7f5-4e67-aa36-f45087280988",
        "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
        "start_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642",
        "stop_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642",
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
      "id": "8ef35943-0fd5-435b-9386-c5cd8e0c73da",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
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
        "item_id": "8210c17d-3801-461a-9939-fd692d272906",
        "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe",
        "start_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642",
        "stop_location_id": "066b3f73-1e2a-4b97-8f57-884c5de5a642",
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
      "id": "ab678b21-b03a-4a63-bb7c-c58590094fa6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b84b467c-4b55-4395-909b-3a670007a521",
        "planning_id": "9c563f13-14cd-45b4-b22f-c52076da1cd5",
        "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe"
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
      "id": "3f0840cb-3aa4-40ea-8de0-4ab8d97b4898",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cbf219a7-39a3-4615-99c8-679ec2f0d6f7",
        "planning_id": "9c563f13-14cd-45b4-b22f-c52076da1cd5",
        "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe"
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
      "id": "fa34446c-8dfb-49bd-94cf-0de2f8f590f8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:20+00:00",
        "updated_at": "2023-01-19T10:29:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1c4f9f86-4f22-4e49-b826-9fdc72baf6f3",
        "planning_id": "9c563f13-14cd-45b4-b22f-c52076da1cd5",
        "order_id": "05ec8ad2-d14f-4730-8d65-81c9e8059bbe"
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
          "order_id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227",
          "items": [
            {
              "type": "bundles",
              "id": "cdd6491d-7b14-4b03-9636-4d46f1bc7940",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7363e58e-50b6-439b-a447-c4901291d6e9",
                  "id": "405edc8c-f8f5-49fa-94fd-3715cb3f2ef3"
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
    "id": "247035f9-610f-52c6-a170-0db3df4f5658",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b76e99d2-18be-4ee1-ab6d-a022e2f36a80"
          },
          {
            "type": "lines",
            "id": "732b76ca-7e6b-4956-a9ac-5d82ce84f353"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "459af78e-7d78-4f82-b6ec-8a294a786908"
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
      "id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-19T10:29:23+00:00",
        "updated_at": "2023-01-19T10:29:23+00:00",
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
        "starts_at": "2023-01-17T10:15:00+00:00",
        "stops_at": "2023-01-21T10:15:00+00:00",
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
        "start_location_id": "090966e8-449d-492b-9f10-d3ccb42cd648",
        "stop_location_id": "090966e8-449d-492b-9f10-d3ccb42cd648"
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
      "id": "b76e99d2-18be-4ee1-ab6d-a022e2f36a80",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:29:23+00:00",
        "updated_at": "2023-01-19T10:29:23+00:00",
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
        "item_id": "cdd6491d-7b14-4b03-9636-4d46f1bc7940",
        "tax_category_id": null,
        "planning_id": "459af78e-7d78-4f82-b6ec-8a294a786908",
        "parent_line_id": null,
        "owner_id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227",
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
      "id": "732b76ca-7e6b-4956-a9ac-5d82ce84f353",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-19T10:29:23+00:00",
        "updated_at": "2023-01-19T10:29:23+00:00",
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
        "item_id": "405edc8c-f8f5-49fa-94fd-3715cb3f2ef3",
        "tax_category_id": null,
        "planning_id": "a2924bc0-4d28-4bfb-b0b3-5471fdc0dbad",
        "parent_line_id": "b76e99d2-18be-4ee1-ab6d-a022e2f36a80",
        "owner_id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227",
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
      "id": "459af78e-7d78-4f82-b6ec-8a294a786908",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-19T10:29:23+00:00",
        "updated_at": "2023-01-19T10:29:23+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-17T10:15:00+00:00",
        "stops_at": "2023-01-21T10:15:00+00:00",
        "reserved_from": "2023-01-17T10:15:00+00:00",
        "reserved_till": "2023-01-21T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cdd6491d-7b14-4b03-9636-4d46f1bc7940",
        "order_id": "3ebcd8de-71cb-49eb-9d75-08ef3b426227",
        "start_location_id": "090966e8-449d-492b-9f10-d3ccb42cd648",
        "stop_location_id": "090966e8-449d-492b-9f10-d3ccb42cd648",
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





