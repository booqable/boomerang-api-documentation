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
          "order_id": "51f94058-28c2-4d7a-adaa-fb614425689e",
          "items": [
            {
              "type": "products",
              "id": "3e359fca-98ed-48b1-905e-365af1c76a2b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7553e27d-c295-4ec0-af1d-462138b7a246",
              "stock_item_ids": [
                "324871d3-e5fd-4e85-b208-b893b5217077",
                "fa99a72b-3038-4ad9-aa0d-f7f34537c53a"
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
            "item_id": "3e359fca-98ed-48b1-905e-365af1c76a2b",
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
          "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
          "items": [
            {
              "type": "products",
              "id": "f7ebf7ff-35f0-4f69-8db2-137a72b82dfd",
              "stock_item_ids": [
                "ae809a83-19c3-4447-9d97-1fcf2424cc9d",
                "92fdae2d-107e-466b-86c8-368eba1c91b6",
                "197bf10c-7226-4ca5-90f8-f36fdf8f2ecd"
              ]
            },
            {
              "type": "products",
              "id": "c89516e6-6406-445e-94b1-1f789b28b7d2",
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
    "id": "a878a8f6-141a-5f2d-8360-2e637e99a68d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "712a26b6-b8bd-482e-bddb-6cb017c38c02"
          },
          {
            "type": "lines",
            "id": "a277e26e-30fd-48da-a80c-c717232631fd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540"
          },
          {
            "type": "plannings",
            "id": "74354b20-b6a3-422b-a20a-659901dfca39"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ec8c674e-5fdc-4fae-a4df-5417dacb282d"
          },
          {
            "type": "stock_item_plannings",
            "id": "baeb6bbe-bd29-4263-9fec-416a87a213d6"
          },
          {
            "type": "stock_item_plannings",
            "id": "72474202-cdb6-4349-93ea-790bacb8e672"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-30T08:58:54+00:00",
        "updated_at": "2022-11-30T08:58:56+00:00",
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
        "customer_id": "55833b44-adac-4dcf-9314-cafbb094be38",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd",
        "stop_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd"
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
      "id": "712a26b6-b8bd-482e-bddb-6cb017c38c02",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
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
        "item_id": "f7ebf7ff-35f0-4f69-8db2-137a72b82dfd",
        "tax_category_id": "0ff01cdf-3436-4b32-99e9-6272933e70dd",
        "planning_id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540",
        "parent_line_id": null,
        "owner_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
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
      "id": "a277e26e-30fd-48da-a80c-c717232631fd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
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
        "item_id": "c89516e6-6406-445e-94b1-1f789b28b7d2",
        "tax_category_id": "0ff01cdf-3436-4b32-99e9-6272933e70dd",
        "planning_id": "74354b20-b6a3-422b-a20a-659901dfca39",
        "parent_line_id": null,
        "owner_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
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
      "id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
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
        "item_id": "f7ebf7ff-35f0-4f69-8db2-137a72b82dfd",
        "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
        "start_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd",
        "stop_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd",
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
      "id": "74354b20-b6a3-422b-a20a-659901dfca39",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
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
        "item_id": "c89516e6-6406-445e-94b1-1f789b28b7d2",
        "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0",
        "start_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd",
        "stop_location_id": "23b9be6b-dcb3-43ba-8530-8a634d578ddd",
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
      "id": "ec8c674e-5fdc-4fae-a4df-5417dacb282d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ae809a83-19c3-4447-9d97-1fcf2424cc9d",
        "planning_id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540",
        "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0"
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
      "id": "baeb6bbe-bd29-4263-9fec-416a87a213d6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "92fdae2d-107e-466b-86c8-368eba1c91b6",
        "planning_id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540",
        "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0"
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
      "id": "72474202-cdb6-4349-93ea-790bacb8e672",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:55+00:00",
        "updated_at": "2022-11-30T08:58:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "197bf10c-7226-4ca5-90f8-f36fdf8f2ecd",
        "planning_id": "9b41c38d-c5f2-42de-93fa-dda3cbeec540",
        "order_id": "e03d82c5-8019-4706-aa52-0b1b2282d6a0"
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
          "order_id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc",
          "items": [
            {
              "type": "bundles",
              "id": "0dcced2a-5c1e-444e-8cc6-f5c170f38768",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "05bda091-95c4-4f9c-bdcb-d79335d172ce",
                  "id": "2e49f546-da3b-45e8-baad-305c99ef4ca2"
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
    "id": "d4a2ced4-c12c-530a-b150-d7f075bd37c3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7cef94c8-39cb-4d68-8118-9c2df9d8337e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "797c9fb5-720a-4f55-8b3f-90e770e46f38"
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
      "id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-30T08:58:58+00:00",
        "updated_at": "2022-11-30T08:58:58+00:00",
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
        "starts_at": "2022-11-28T08:45:00+00:00",
        "stops_at": "2022-12-02T08:45:00+00:00",
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
        "start_location_id": "ad2cb09c-b84f-4f8c-af1f-8d670d38efb6",
        "stop_location_id": "ad2cb09c-b84f-4f8c-af1f-8d670d38efb6"
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
      "id": "7cef94c8-39cb-4d68-8118-9c2df9d8337e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-30T08:58:58+00:00",
        "updated_at": "2022-11-30T08:58:58+00:00",
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
        "item_id": "0dcced2a-5c1e-444e-8cc6-f5c170f38768",
        "tax_category_id": null,
        "planning_id": "797c9fb5-720a-4f55-8b3f-90e770e46f38",
        "parent_line_id": null,
        "owner_id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc",
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
      "id": "797c9fb5-720a-4f55-8b3f-90e770e46f38",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-30T08:58:58+00:00",
        "updated_at": "2022-11-30T08:58:58+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-28T08:45:00+00:00",
        "stops_at": "2022-12-02T08:45:00+00:00",
        "reserved_from": "2022-11-28T08:45:00+00:00",
        "reserved_till": "2022-12-02T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0dcced2a-5c1e-444e-8cc6-f5c170f38768",
        "order_id": "fdf160ef-e572-463f-bd2a-4e6c25064ecc",
        "start_location_id": "ad2cb09c-b84f-4f8c-af1f-8d670d38efb6",
        "stop_location_id": "ad2cb09c-b84f-4f8c-af1f-8d670d38efb6",
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





