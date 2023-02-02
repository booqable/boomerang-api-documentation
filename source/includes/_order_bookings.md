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
          "order_id": "784607a4-e801-4166-b2de-6e3d990f5bbb",
          "items": [
            {
              "type": "products",
              "id": "0933ba69-4e7e-4ca2-8b78-32dc329ee022",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bb3e9cc1-3a07-4e5e-a0b6-10743378e5c6",
              "stock_item_ids": [
                "c57470cb-4f22-4edd-ae1e-3a4826d29499",
                "77aad3b1-4a48-4bfd-b3fb-a047c9330a7a"
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
            "item_id": "0933ba69-4e7e-4ca2-8b78-32dc329ee022",
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
          "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
          "items": [
            {
              "type": "products",
              "id": "e6407f6b-4a19-4d6e-a272-bb02747784e5",
              "stock_item_ids": [
                "84add3da-7e72-4b14-9000-ffaa777efba0",
                "90e3e8b0-0269-416c-bcaf-7b5583e917aa",
                "c2f284c0-7d36-4489-b2d6-b681d4eb424a"
              ]
            },
            {
              "type": "products",
              "id": "20cd920d-3890-4376-8852-7095a8cc609a",
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
    "id": "de9412d4-9e6e-5d97-8d32-35b643d80587",
    "type": "order_bookings",
    "attributes": {
      "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "67a35583-0597-48a9-b47d-c3872d9eb74d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5ef9a9c0-3da1-4d9c-b537-fb5a31296f38"
          },
          {
            "type": "lines",
            "id": "23bf52f7-7c2c-4b3a-99ff-a8f16cb3982c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc"
          },
          {
            "type": "plannings",
            "id": "65ab61cb-c621-4acb-8da4-ab64429afe2e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fd37fa0f-f2a3-40cf-9a2e-8a8b857365a7"
          },
          {
            "type": "stock_item_plannings",
            "id": "1cff7476-e1fa-4ca3-9049-9b13ba934825"
          },
          {
            "type": "stock_item_plannings",
            "id": "d14f2a5b-2223-456d-ad5f-d3a47b64cb20"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T19:27:33+00:00",
        "updated_at": "2023-02-02T19:27:36+00:00",
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
        "customer_id": "add599d9-af92-4c71-a4a9-33ba6723e678",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65",
        "stop_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65"
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
      "id": "5ef9a9c0-3da1-4d9c-b537-fb5a31296f38",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:36+00:00",
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
        "item_id": "e6407f6b-4a19-4d6e-a272-bb02747784e5",
        "tax_category_id": "f484c61a-76f6-41fd-91f5-16fc49e6b867",
        "planning_id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc",
        "parent_line_id": null,
        "owner_id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
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
      "id": "23bf52f7-7c2c-4b3a-99ff-a8f16cb3982c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:36+00:00",
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
        "item_id": "20cd920d-3890-4376-8852-7095a8cc609a",
        "tax_category_id": "f484c61a-76f6-41fd-91f5-16fc49e6b867",
        "planning_id": "65ab61cb-c621-4acb-8da4-ab64429afe2e",
        "parent_line_id": null,
        "owner_id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
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
      "id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:36+00:00",
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
        "item_id": "e6407f6b-4a19-4d6e-a272-bb02747784e5",
        "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
        "start_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65",
        "stop_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65",
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
      "id": "65ab61cb-c621-4acb-8da4-ab64429afe2e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:36+00:00",
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
        "item_id": "20cd920d-3890-4376-8852-7095a8cc609a",
        "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d",
        "start_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65",
        "stop_location_id": "d5fe7ca4-cac0-48a9-82ae-6739e8b65c65",
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
      "id": "fd37fa0f-f2a3-40cf-9a2e-8a8b857365a7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "84add3da-7e72-4b14-9000-ffaa777efba0",
        "planning_id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc",
        "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d"
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
      "id": "1cff7476-e1fa-4ca3-9049-9b13ba934825",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "90e3e8b0-0269-416c-bcaf-7b5583e917aa",
        "planning_id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc",
        "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d"
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
      "id": "d14f2a5b-2223-456d-ad5f-d3a47b64cb20",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:35+00:00",
        "updated_at": "2023-02-02T19:27:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c2f284c0-7d36-4489-b2d6-b681d4eb424a",
        "planning_id": "37f3bdff-79c8-4dc9-ad8e-685982e91bdc",
        "order_id": "67a35583-0597-48a9-b47d-c3872d9eb74d"
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
          "order_id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d",
          "items": [
            {
              "type": "bundles",
              "id": "c1d91de1-42ee-496c-afbd-8248d73ecf2b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c2c25795-e4f6-4b0b-95b9-b66bc15c32c5",
                  "id": "b0568efa-20ef-45da-9bc0-f44e3a689663"
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
    "id": "8d5f6d14-e659-55ed-b89a-2ffacfb38297",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6f0c99f1-9b43-4e3e-bfb9-898c55473be5"
          },
          {
            "type": "lines",
            "id": "23308e2c-b234-442a-b062-b55b03ee9561"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "eeb239a6-5376-4df9-a918-0406d0c3beaa"
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
      "id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T19:27:39+00:00",
        "updated_at": "2023-02-02T19:27:40+00:00",
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
        "starts_at": "2023-01-31T19:15:00+00:00",
        "stops_at": "2023-02-04T19:15:00+00:00",
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
        "start_location_id": "fe0617e7-aed0-4421-9db0-aab0ba312d7d",
        "stop_location_id": "fe0617e7-aed0-4421-9db0-aab0ba312d7d"
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
      "id": "6f0c99f1-9b43-4e3e-bfb9-898c55473be5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T19:27:40+00:00",
        "updated_at": "2023-02-02T19:27:40+00:00",
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
        "item_id": "b0568efa-20ef-45da-9bc0-f44e3a689663",
        "tax_category_id": null,
        "planning_id": "9579cdf1-e549-41e3-b84a-66b56f4038b8",
        "parent_line_id": "23308e2c-b234-442a-b062-b55b03ee9561",
        "owner_id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d",
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
      "id": "23308e2c-b234-442a-b062-b55b03ee9561",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T19:27:40+00:00",
        "updated_at": "2023-02-02T19:27:40+00:00",
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
        "item_id": "c1d91de1-42ee-496c-afbd-8248d73ecf2b",
        "tax_category_id": null,
        "planning_id": "eeb239a6-5376-4df9-a918-0406d0c3beaa",
        "parent_line_id": null,
        "owner_id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d",
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
      "id": "eeb239a6-5376-4df9-a918-0406d0c3beaa",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T19:27:39+00:00",
        "updated_at": "2023-02-02T19:27:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T19:15:00+00:00",
        "stops_at": "2023-02-04T19:15:00+00:00",
        "reserved_from": "2023-01-31T19:15:00+00:00",
        "reserved_till": "2023-02-04T19:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c1d91de1-42ee-496c-afbd-8248d73ecf2b",
        "order_id": "8420fcfd-48b8-4fab-bbc0-978bcb39350d",
        "start_location_id": "fe0617e7-aed0-4421-9db0-aab0ba312d7d",
        "stop_location_id": "fe0617e7-aed0-4421-9db0-aab0ba312d7d",
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





