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
          "order_id": "e57fcb39-c11a-4138-9314-9ff11a909c40",
          "items": [
            {
              "type": "products",
              "id": "088aaa41-86a2-40d3-b6f0-fe4cde7ee6a6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a8db0f6f-0be1-4782-a1a3-1bf88554692a",
              "stock_item_ids": [
                "e30fc323-ad75-4ab3-965d-ce5cde58277f",
                "844a52ea-34a8-4973-964b-38ba9b0f021e"
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
            "item_id": "088aaa41-86a2-40d3-b6f0-fe4cde7ee6a6",
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
          "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
          "items": [
            {
              "type": "products",
              "id": "6da084a8-3b3d-4aa4-bae7-46f6c874b9bd",
              "stock_item_ids": [
                "2f95d3fc-df53-495a-83e2-6628a18e252e",
                "bf0d1bfb-8ec9-4718-923d-d9120dc1e33d",
                "8cb1f29f-532f-49a6-aa58-638f7431f76e"
              ]
            },
            {
              "type": "products",
              "id": "5cc04e05-f5b1-4235-acaa-5fd195c6bf7c",
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
    "id": "963e0bb2-e4a1-51cb-827e-f6ed7c024403",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0ddce5fb-af98-449f-82b5-680863a59c1d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5ba66ecb-7ecc-4866-8a1b-473cbb3cda8b"
          },
          {
            "type": "lines",
            "id": "f6c67f95-77f2-456d-91e6-a7063e0b2154"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef"
          },
          {
            "type": "plannings",
            "id": "206b3e9b-f99e-4d4b-8831-a8258e69b5c1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "72c321be-e112-4a63-b27e-a0b78987e838"
          },
          {
            "type": "stock_item_plannings",
            "id": "76db2b50-d373-440e-833f-1b6a21a80c25"
          },
          {
            "type": "stock_item_plannings",
            "id": "cf6a827f-4802-4a29-ade0-b8e2f18c474b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:38:32+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
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
        "customer_id": "53ec2eab-aa40-4521-b5c1-d06a690b6cca",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc",
        "stop_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc"
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
      "id": "5ba66ecb-7ecc-4866-8a1b-473cbb3cda8b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
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
        "item_id": "6da084a8-3b3d-4aa4-bae7-46f6c874b9bd",
        "tax_category_id": "e65f44a5-8ea3-4056-b71b-53b5a89cdd49",
        "planning_id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef",
        "parent_line_id": null,
        "owner_id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
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
      "id": "f6c67f95-77f2-456d-91e6-a7063e0b2154",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
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
        "item_id": "5cc04e05-f5b1-4235-acaa-5fd195c6bf7c",
        "tax_category_id": "e65f44a5-8ea3-4056-b71b-53b5a89cdd49",
        "planning_id": "206b3e9b-f99e-4d4b-8831-a8258e69b5c1",
        "parent_line_id": null,
        "owner_id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
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
      "id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
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
        "item_id": "6da084a8-3b3d-4aa4-bae7-46f6c874b9bd",
        "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
        "start_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc",
        "stop_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc",
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
      "id": "206b3e9b-f99e-4d4b-8831-a8258e69b5c1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
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
        "item_id": "5cc04e05-f5b1-4235-acaa-5fd195c6bf7c",
        "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d",
        "start_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc",
        "stop_location_id": "31d19a74-874c-4b7d-86bc-8e4c092c89bc",
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
      "id": "72c321be-e112-4a63-b27e-a0b78987e838",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2f95d3fc-df53-495a-83e2-6628a18e252e",
        "planning_id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef",
        "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d"
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
      "id": "76db2b50-d373-440e-833f-1b6a21a80c25",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bf0d1bfb-8ec9-4718-923d-d9120dc1e33d",
        "planning_id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef",
        "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d"
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
      "id": "cf6a827f-4802-4a29-ade0-b8e2f18c474b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:34+00:00",
        "updated_at": "2023-02-02T16:38:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8cb1f29f-532f-49a6-aa58-638f7431f76e",
        "planning_id": "16cd0c7e-cf93-4b11-ac1f-b0db0f7e9fef",
        "order_id": "0ddce5fb-af98-449f-82b5-680863a59c1d"
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
          "order_id": "c857f132-ae78-45c0-a8e6-abd010a3f106",
          "items": [
            {
              "type": "bundles",
              "id": "69568406-4ee5-48bd-b644-59bd26679e5b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "14b143eb-9225-493f-87f2-bc1f767673ed",
                  "id": "ff607d1c-d6a3-49b5-91bd-a0883988a9c9"
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
    "id": "e9e66761-7a7f-55ab-9390-4d5b2aac73aa",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c857f132-ae78-45c0-a8e6-abd010a3f106"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c857f132-ae78-45c0-a8e6-abd010a3f106"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "da73e529-e29c-4d5e-8f09-702a96402348"
          },
          {
            "type": "lines",
            "id": "338782de-e4c3-4037-8f1b-3920ac2e4785"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cb5812f1-2e4b-4bb7-b013-5e75b9d2dfdb"
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
      "id": "c857f132-ae78-45c0-a8e6-abd010a3f106",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:38:37+00:00",
        "updated_at": "2023-02-02T16:38:37+00:00",
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
        "starts_at": "2023-01-31T16:30:00+00:00",
        "stops_at": "2023-02-04T16:30:00+00:00",
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
        "start_location_id": "9046a889-bdc6-48d6-a80c-8a5a8ed01dbb",
        "stop_location_id": "9046a889-bdc6-48d6-a80c-8a5a8ed01dbb"
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
      "id": "da73e529-e29c-4d5e-8f09-702a96402348",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:38:37+00:00",
        "updated_at": "2023-02-02T16:38:37+00:00",
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
        "item_id": "69568406-4ee5-48bd-b644-59bd26679e5b",
        "tax_category_id": null,
        "planning_id": "cb5812f1-2e4b-4bb7-b013-5e75b9d2dfdb",
        "parent_line_id": null,
        "owner_id": "c857f132-ae78-45c0-a8e6-abd010a3f106",
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
      "id": "338782de-e4c3-4037-8f1b-3920ac2e4785",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:38:37+00:00",
        "updated_at": "2023-02-02T16:38:37+00:00",
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
        "item_id": "ff607d1c-d6a3-49b5-91bd-a0883988a9c9",
        "tax_category_id": null,
        "planning_id": "fc7da819-e080-4804-b78a-453d7e4bd0a1",
        "parent_line_id": "da73e529-e29c-4d5e-8f09-702a96402348",
        "owner_id": "c857f132-ae78-45c0-a8e6-abd010a3f106",
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
      "id": "cb5812f1-2e4b-4bb7-b013-5e75b9d2dfdb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:38:37+00:00",
        "updated_at": "2023-02-02T16:38:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T16:30:00+00:00",
        "stops_at": "2023-02-04T16:30:00+00:00",
        "reserved_from": "2023-01-31T16:30:00+00:00",
        "reserved_till": "2023-02-04T16:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "69568406-4ee5-48bd-b644-59bd26679e5b",
        "order_id": "c857f132-ae78-45c0-a8e6-abd010a3f106",
        "start_location_id": "9046a889-bdc6-48d6-a80c-8a5a8ed01dbb",
        "stop_location_id": "9046a889-bdc6-48d6-a80c-8a5a8ed01dbb",
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





