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
          "order_id": "1c5e789d-4345-49e8-ae14-eab7a1b1987a",
          "items": [
            {
              "type": "products",
              "id": "f0e617a5-618c-4f5e-be3f-d0824b8e52cd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6deaba25-ca1b-44b9-a1fc-f1724ba8f7ab",
              "stock_item_ids": [
                "63576eae-4018-4b5a-bfdf-2c44dd31c6c8",
                "e8782699-3f2b-45e5-9556-e0c8e2419704"
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
            "item_id": "f0e617a5-618c-4f5e-be3f-d0824b8e52cd",
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
          "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939",
          "items": [
            {
              "type": "products",
              "id": "5183c3da-3e30-4b66-b7d9-46b128aa69a7",
              "stock_item_ids": [
                "2fb8ee5c-1f4f-4c42-8721-a3e91a82ad44",
                "2996d6ec-d9d6-4db1-87a9-f3731bea8e4d",
                "fd6ad143-4ccc-46c2-a356-ed2480b56f68"
              ]
            },
            {
              "type": "products",
              "id": "abbe259f-d903-4d4b-9d0c-e892296eac54",
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
    "id": "e266d79d-2643-5572-b30d-254dedf2d065",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ae065df0-741f-4963-ab04-2fc8f8560939"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a18685b4-99b5-4a72-b23a-816a41737eff"
          },
          {
            "type": "lines",
            "id": "1a9d31f2-ecf4-4ec6-b57f-fa93ab29f897"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "672e74bf-733b-4f31-a3e9-10d1e1c5564b"
          },
          {
            "type": "plannings",
            "id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c382ebc4-8a67-4789-91c8-858328dde922"
          },
          {
            "type": "stock_item_plannings",
            "id": "1b0d5880-8ff5-4a30-a254-2c404f8950c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "301449c4-0a9e-4177-884d-d2f05f1c2100"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ae065df0-741f-4963-ab04-2fc8f8560939",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-24T12:37:24+00:00",
        "updated_at": "2022-03-24T12:37:27+00:00",
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
        "customer_id": "38ce4cfb-b032-4401-ad45-716ea2845ced",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396",
        "stop_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396"
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
      "id": "a18685b4-99b5-4a72-b23a-816a41737eff",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-24T12:37:25+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
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
        "item_id": "abbe259f-d903-4d4b-9d0c-e892296eac54",
        "tax_category_id": "18cbef68-78aa-49d0-8c9f-968161a573bf",
        "planning_id": "672e74bf-733b-4f31-a3e9-10d1e1c5564b",
        "parent_line_id": null,
        "owner_id": "ae065df0-741f-4963-ab04-2fc8f8560939",
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
      "id": "1a9d31f2-ecf4-4ec6-b57f-fa93ab29f897",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-24T12:37:26+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
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
        "item_id": "5183c3da-3e30-4b66-b7d9-46b128aa69a7",
        "tax_category_id": "18cbef68-78aa-49d0-8c9f-968161a573bf",
        "planning_id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9",
        "parent_line_id": null,
        "owner_id": "ae065df0-741f-4963-ab04-2fc8f8560939",
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
      "id": "672e74bf-733b-4f31-a3e9-10d1e1c5564b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:25+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
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
        "item_id": "abbe259f-d903-4d4b-9d0c-e892296eac54",
        "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939",
        "start_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396",
        "stop_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396",
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
      "id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:26+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
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
        "item_id": "5183c3da-3e30-4b66-b7d9-46b128aa69a7",
        "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939",
        "start_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396",
        "stop_location_id": "a5c6dc55-f999-4d6e-8df9-0acf0a927396",
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
      "id": "c382ebc4-8a67-4789-91c8-858328dde922",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:26+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2fb8ee5c-1f4f-4c42-8721-a3e91a82ad44",
        "planning_id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9",
        "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939"
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
      "id": "1b0d5880-8ff5-4a30-a254-2c404f8950c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:26+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2996d6ec-d9d6-4db1-87a9-f3731bea8e4d",
        "planning_id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9",
        "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939"
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
      "id": "301449c4-0a9e-4177-884d-d2f05f1c2100",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:26+00:00",
        "updated_at": "2022-03-24T12:37:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fd6ad143-4ccc-46c2-a356-ed2480b56f68",
        "planning_id": "5c6d9f24-2ba6-488e-bfe4-efb8160ef3d9",
        "order_id": "ae065df0-741f-4963-ab04-2fc8f8560939"
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
          "order_id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd",
          "items": [
            {
              "type": "bundles",
              "id": "65b35f37-e7c8-479b-a28a-91a705d52e90",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5b478249-112f-4cc6-afaa-173396d3588a",
                  "id": "dfba96f7-4a2d-41c9-9587-9f969f3980a2"
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
    "id": "ee7fe4c8-a9ca-5c38-b2fd-0fa740f09f17",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bca26103-38d7-4da5-a4a3-52c6ba37d677"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5fe0ddb2-d47b-4250-baac-f69ff54fc7a0"
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
      "id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-24T12:37:28+00:00",
        "updated_at": "2022-03-24T12:37:29+00:00",
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
        "starts_at": "2022-03-22T12:30:00+00:00",
        "stops_at": "2022-03-26T12:30:00+00:00",
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
        "start_location_id": "3bf32be5-8d5d-4cf6-9528-a4f61b8767c1",
        "stop_location_id": "3bf32be5-8d5d-4cf6-9528-a4f61b8767c1"
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
      "id": "bca26103-38d7-4da5-a4a3-52c6ba37d677",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-24T12:37:29+00:00",
        "updated_at": "2022-03-24T12:37:29+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "65b35f37-e7c8-479b-a28a-91a705d52e90",
        "tax_category_id": null,
        "planning_id": "5fe0ddb2-d47b-4250-baac-f69ff54fc7a0",
        "parent_line_id": null,
        "owner_id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd",
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
      "id": "5fe0ddb2-d47b-4250-baac-f69ff54fc7a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-24T12:37:29+00:00",
        "updated_at": "2022-03-24T12:37:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-22T12:30:00+00:00",
        "stops_at": "2022-03-26T12:30:00+00:00",
        "reserved_from": "2022-03-22T12:30:00+00:00",
        "reserved_till": "2022-03-26T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "65b35f37-e7c8-479b-a28a-91a705d52e90",
        "order_id": "aee57da6-8c8c-43a0-a1d0-0626d7964afd",
        "start_location_id": "3bf32be5-8d5d-4cf6-9528-a4f61b8767c1",
        "stop_location_id": "3bf32be5-8d5d-4cf6-9528-a4f61b8767c1",
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





