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
          "order_id": "ea23feb2-af95-467d-becd-431e4edae23c",
          "items": [
            {
              "type": "products",
              "id": "ad7c90a1-6e7c-4d78-97c9-b16f5abc52ac",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ad112249-9123-4cde-bcc1-3dd9326fa032",
              "stock_item_ids": [
                "22ca83f6-12d1-4ee7-b7c4-74fda320c99f",
                "b5adcfa3-4d98-450d-bef9-f2929bad9c5e"
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
          "stock_item_id 22ca83f6-12d1-4ee7-b7c4-74fda320c99f has already been booked on this order"
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
          "order_id": "64045076-1c3a-4135-99b0-f108401d14f3",
          "items": [
            {
              "type": "products",
              "id": "6702e5ff-0d8c-455a-9e76-150ea4bd1d78",
              "stock_item_ids": [
                "f7e60404-af7f-4223-9f5a-c2d547e4155f",
                "78726eac-9322-41c7-bd4e-6fe4096d65cd",
                "b74722d4-5edd-45ad-a0b6-5c900a421dfd"
              ]
            },
            {
              "type": "products",
              "id": "7fe318ff-498d-4c59-8987-c5965ebb362c",
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
    "id": "fafa6aa7-71b2-53eb-bd36-faba10b33be7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "64045076-1c3a-4135-99b0-f108401d14f3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "64045076-1c3a-4135-99b0-f108401d14f3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "15e9d544-0462-477c-849c-1921d437c6a3"
          },
          {
            "type": "lines",
            "id": "b87a6365-d6ab-4113-ad45-c2147813b9b5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc"
          },
          {
            "type": "plannings",
            "id": "1da165b2-b7f7-4df0-8edf-a8d741d67bc7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e91c5e0b-74a7-4e98-b2cb-ef04735bbf6a"
          },
          {
            "type": "stock_item_plannings",
            "id": "674bae40-10bf-4fd7-880d-da4a8971efb8"
          },
          {
            "type": "stock_item_plannings",
            "id": "099879c6-fc8f-4a28-9023-9f3ec1dc9e81"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "64045076-1c3a-4135-99b0-f108401d14f3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T15:24:41+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
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
        "customer_id": "6fa75210-386a-4a17-a388-91c45afb0d16",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687",
        "stop_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687"
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
      "id": "15e9d544-0462-477c-849c-1921d437c6a3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
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
        "item_id": "6702e5ff-0d8c-455a-9e76-150ea4bd1d78",
        "tax_category_id": "9bba51c7-acaf-457a-8040-e3089251ee8e",
        "planning_id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc",
        "parent_line_id": null,
        "owner_id": "64045076-1c3a-4135-99b0-f108401d14f3",
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
      "id": "b87a6365-d6ab-4113-ad45-c2147813b9b5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
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
        "item_id": "7fe318ff-498d-4c59-8987-c5965ebb362c",
        "tax_category_id": "9bba51c7-acaf-457a-8040-e3089251ee8e",
        "planning_id": "1da165b2-b7f7-4df0-8edf-a8d741d67bc7",
        "parent_line_id": null,
        "owner_id": "64045076-1c3a-4135-99b0-f108401d14f3",
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
      "id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
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
        "item_id": "6702e5ff-0d8c-455a-9e76-150ea4bd1d78",
        "order_id": "64045076-1c3a-4135-99b0-f108401d14f3",
        "start_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687",
        "stop_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687",
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
      "id": "1da165b2-b7f7-4df0-8edf-a8d741d67bc7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
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
        "item_id": "7fe318ff-498d-4c59-8987-c5965ebb362c",
        "order_id": "64045076-1c3a-4135-99b0-f108401d14f3",
        "start_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687",
        "stop_location_id": "cb22c2ea-a2a7-408a-bc85-1e9131894687",
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
      "id": "e91c5e0b-74a7-4e98-b2cb-ef04735bbf6a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f7e60404-af7f-4223-9f5a-c2d547e4155f",
        "planning_id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc",
        "order_id": "64045076-1c3a-4135-99b0-f108401d14f3"
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
      "id": "674bae40-10bf-4fd7-880d-da4a8971efb8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "78726eac-9322-41c7-bd4e-6fe4096d65cd",
        "planning_id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc",
        "order_id": "64045076-1c3a-4135-99b0-f108401d14f3"
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
      "id": "099879c6-fc8f-4a28-9023-9f3ec1dc9e81",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:43+00:00",
        "updated_at": "2023-03-08T15:24:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b74722d4-5edd-45ad-a0b6-5c900a421dfd",
        "planning_id": "20e3bd9c-7088-48ba-914f-6affe3eaf9dc",
        "order_id": "64045076-1c3a-4135-99b0-f108401d14f3"
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
          "order_id": "cabe02bc-fec1-4d41-98a4-9b2729da69af",
          "items": [
            {
              "type": "bundles",
              "id": "b71331a4-bffa-48b3-83ab-6615c2274e81",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6d170e2e-0240-47c4-81f1-21f6e74cf8ca",
                  "id": "73186746-bf6a-4dc5-8d76-033881578fa0"
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
    "id": "ac1131e6-abde-5510-b438-ee6a58e26136",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cabe02bc-fec1-4d41-98a4-9b2729da69af"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cabe02bc-fec1-4d41-98a4-9b2729da69af"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "66394456-3538-42ee-b27f-5b5d442db11e"
          },
          {
            "type": "lines",
            "id": "0350b5f6-1b26-4c6d-a236-83f6422072ca"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3056f2a6-8072-4c07-83c9-d5f82af7a8dc"
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
      "id": "cabe02bc-fec1-4d41-98a4-9b2729da69af",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T15:24:46+00:00",
        "updated_at": "2023-03-08T15:24:47+00:00",
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
        "starts_at": "2023-03-06T15:15:00+00:00",
        "stops_at": "2023-03-10T15:15:00+00:00",
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
        "start_location_id": "a16d4c59-afa1-49d0-86e0-2360c0b81b51",
        "stop_location_id": "a16d4c59-afa1-49d0-86e0-2360c0b81b51"
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
      "id": "66394456-3538-42ee-b27f-5b5d442db11e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T15:24:47+00:00",
        "updated_at": "2023-03-08T15:24:47+00:00",
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
        "item_id": "b71331a4-bffa-48b3-83ab-6615c2274e81",
        "tax_category_id": null,
        "planning_id": "3056f2a6-8072-4c07-83c9-d5f82af7a8dc",
        "parent_line_id": null,
        "owner_id": "cabe02bc-fec1-4d41-98a4-9b2729da69af",
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
      "id": "0350b5f6-1b26-4c6d-a236-83f6422072ca",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T15:24:47+00:00",
        "updated_at": "2023-03-08T15:24:47+00:00",
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
        "item_id": "73186746-bf6a-4dc5-8d76-033881578fa0",
        "tax_category_id": null,
        "planning_id": "9b69563b-95f7-4d92-af60-ab0fdd6995a6",
        "parent_line_id": "66394456-3538-42ee-b27f-5b5d442db11e",
        "owner_id": "cabe02bc-fec1-4d41-98a4-9b2729da69af",
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
      "id": "3056f2a6-8072-4c07-83c9-d5f82af7a8dc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T15:24:47+00:00",
        "updated_at": "2023-03-08T15:24:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-06T15:15:00+00:00",
        "stops_at": "2023-03-10T15:15:00+00:00",
        "reserved_from": "2023-03-06T15:15:00+00:00",
        "reserved_till": "2023-03-10T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b71331a4-bffa-48b3-83ab-6615c2274e81",
        "order_id": "cabe02bc-fec1-4d41-98a4-9b2729da69af",
        "start_location_id": "a16d4c59-afa1-49d0-86e0-2360c0b81b51",
        "stop_location_id": "a16d4c59-afa1-49d0-86e0-2360c0b81b51",
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





