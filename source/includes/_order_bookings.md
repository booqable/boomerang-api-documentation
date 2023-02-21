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
          "order_id": "4ee1705b-f6ef-41c5-9d93-a91baca142cb",
          "items": [
            {
              "type": "products",
              "id": "929f0d02-68e0-4a65-805a-5eb1a322a118",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "84e034a6-db9b-4bdd-81e6-b23e48cd41c8",
              "stock_item_ids": [
                "09cc4c1f-7239-4a71-8113-444736247a4b",
                "d708878d-c68d-4372-a807-af0c39698be0"
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
          "stock_item_id 09cc4c1f-7239-4a71-8113-444736247a4b has already been booked on this order"
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
          "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
          "items": [
            {
              "type": "products",
              "id": "a7b801e6-08da-48b4-aeb4-35fe0094f594",
              "stock_item_ids": [
                "e030e7e2-fd7b-4b64-bbf3-ff46caffea7c",
                "916804da-c504-4df2-b4f7-ab00d82aa90e",
                "58170f5c-c57c-45bd-82c6-70ec8e41c774"
              ]
            },
            {
              "type": "products",
              "id": "13e09015-2212-4810-b42e-889a102fc2ef",
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
    "id": "3e5fdd8a-0c5c-544c-a7f1-9e8c5bdcf4b1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "87c121ce-47e5-4248-aefe-90e0144ddf58"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5abea733-f6ea-411c-a676-86766116d2e8"
          },
          {
            "type": "lines",
            "id": "f64997b4-69d1-45a6-bde5-6103201b7ed6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e01cff57-275e-4c63-b575-6a22afe1f863"
          },
          {
            "type": "plannings",
            "id": "a0b492b9-6f1f-4c24-ab39-6e90074e8833"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6a6e1ce7-3e13-4f14-b282-19d6184b8f45"
          },
          {
            "type": "stock_item_plannings",
            "id": "ed0a677c-aa89-4d11-aaa8-7a3aca621382"
          },
          {
            "type": "stock_item_plannings",
            "id": "68b7df19-b8b8-4b17-a262-1e7adb8a1037"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T12:17:24+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
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
        "customer_id": "bbee22ba-d210-4bfc-be87-2772b4c6e56d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2",
        "stop_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2"
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
      "id": "5abea733-f6ea-411c-a676-86766116d2e8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
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
        "item_id": "a7b801e6-08da-48b4-aeb4-35fe0094f594",
        "tax_category_id": "857627a6-c40f-42d7-9bca-356756e2acc8",
        "planning_id": "e01cff57-275e-4c63-b575-6a22afe1f863",
        "parent_line_id": null,
        "owner_id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
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
      "id": "f64997b4-69d1-45a6-bde5-6103201b7ed6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
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
        "item_id": "13e09015-2212-4810-b42e-889a102fc2ef",
        "tax_category_id": "857627a6-c40f-42d7-9bca-356756e2acc8",
        "planning_id": "a0b492b9-6f1f-4c24-ab39-6e90074e8833",
        "parent_line_id": null,
        "owner_id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
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
      "id": "e01cff57-275e-4c63-b575-6a22afe1f863",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
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
        "item_id": "a7b801e6-08da-48b4-aeb4-35fe0094f594",
        "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
        "start_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2",
        "stop_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2",
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
      "id": "a0b492b9-6f1f-4c24-ab39-6e90074e8833",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
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
        "item_id": "13e09015-2212-4810-b42e-889a102fc2ef",
        "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58",
        "start_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2",
        "stop_location_id": "03ed86d6-7a37-429a-bf0a-9f8700645ad2",
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
      "id": "6a6e1ce7-3e13-4f14-b282-19d6184b8f45",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e030e7e2-fd7b-4b64-bbf3-ff46caffea7c",
        "planning_id": "e01cff57-275e-4c63-b575-6a22afe1f863",
        "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58"
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
      "id": "ed0a677c-aa89-4d11-aaa8-7a3aca621382",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "916804da-c504-4df2-b4f7-ab00d82aa90e",
        "planning_id": "e01cff57-275e-4c63-b575-6a22afe1f863",
        "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58"
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
      "id": "68b7df19-b8b8-4b17-a262-1e7adb8a1037",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:26+00:00",
        "updated_at": "2023-02-21T12:17:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "58170f5c-c57c-45bd-82c6-70ec8e41c774",
        "planning_id": "e01cff57-275e-4c63-b575-6a22afe1f863",
        "order_id": "87c121ce-47e5-4248-aefe-90e0144ddf58"
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
          "order_id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16",
          "items": [
            {
              "type": "bundles",
              "id": "ee316a42-8762-4de2-a4a0-6141728206dd",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "526e1c64-3275-4cab-ba9f-62f45e736f0a",
                  "id": "9213a65c-2915-4e07-9640-72e92213d900"
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
    "id": "7a6ae8e5-87a3-5cf6-a911-0989b59c528a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a313e42a-9fd0-4c0a-a29b-2065f1381264"
          },
          {
            "type": "lines",
            "id": "f078b04e-da16-4eef-b295-25fc160be506"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4c0b9709-18e7-489b-9281-ee41a3ff7f1f"
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
      "id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T12:17:28+00:00",
        "updated_at": "2023-02-21T12:17:28+00:00",
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
        "starts_at": "2023-02-19T12:15:00+00:00",
        "stops_at": "2023-02-23T12:15:00+00:00",
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
        "start_location_id": "fca3dd6e-8102-4869-80be-521323fc0d7e",
        "stop_location_id": "fca3dd6e-8102-4869-80be-521323fc0d7e"
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
      "id": "a313e42a-9fd0-4c0a-a29b-2065f1381264",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T12:17:28+00:00",
        "updated_at": "2023-02-21T12:17:28+00:00",
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
        "item_id": "ee316a42-8762-4de2-a4a0-6141728206dd",
        "tax_category_id": null,
        "planning_id": "4c0b9709-18e7-489b-9281-ee41a3ff7f1f",
        "parent_line_id": null,
        "owner_id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16",
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
      "id": "f078b04e-da16-4eef-b295-25fc160be506",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T12:17:28+00:00",
        "updated_at": "2023-02-21T12:17:28+00:00",
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
        "item_id": "9213a65c-2915-4e07-9640-72e92213d900",
        "tax_category_id": null,
        "planning_id": "bb23b335-092f-43c9-9f65-939a55d6472a",
        "parent_line_id": "a313e42a-9fd0-4c0a-a29b-2065f1381264",
        "owner_id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16",
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
      "id": "4c0b9709-18e7-489b-9281-ee41a3ff7f1f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T12:17:28+00:00",
        "updated_at": "2023-02-21T12:17:28+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T12:15:00+00:00",
        "stops_at": "2023-02-23T12:15:00+00:00",
        "reserved_from": "2023-02-19T12:15:00+00:00",
        "reserved_till": "2023-02-23T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ee316a42-8762-4de2-a4a0-6141728206dd",
        "order_id": "8c32edfc-0864-43bb-8f5a-d476f81a3c16",
        "start_location_id": "fca3dd6e-8102-4869-80be-521323fc0d7e",
        "stop_location_id": "fca3dd6e-8102-4869-80be-521323fc0d7e",
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





