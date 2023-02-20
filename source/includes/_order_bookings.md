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
          "order_id": "58e9aafb-e6d4-4aab-8213-536eae34faf9",
          "items": [
            {
              "type": "products",
              "id": "b015c72b-85c4-4d70-ab00-82222df3a666",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1fc836f4-c613-46aa-a54e-f17dee904b71",
              "stock_item_ids": [
                "0f75ff2b-2ee0-4665-b23a-efaa12684846",
                "92f86594-c16b-43a0-978f-a54babb0fcb7"
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
          "stock_item_id 0f75ff2b-2ee0-4665-b23a-efaa12684846 has already been booked on this order"
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
          "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd",
          "items": [
            {
              "type": "products",
              "id": "8ddc9544-29cd-4e82-a838-16b3e871c1c6",
              "stock_item_ids": [
                "c07a8714-aeb0-4322-bbec-3c3c5c7276a9",
                "7fa7d362-85c6-4565-8220-e0fe713e0861",
                "078c25e6-1f72-455a-a4e0-ef8e5263caf4"
              ]
            },
            {
              "type": "products",
              "id": "5309dccf-3110-490f-857e-a795d3d54790",
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
    "id": "9758ad82-b35f-5e7f-b048-985a46384aaf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bd940903-787d-4ce9-b99d-f1972b445efd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dfe0c7a9-fbf0-435e-884c-34d4d2454b5d"
          },
          {
            "type": "lines",
            "id": "500577d9-e148-42b1-a9f2-13eaac571066"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6133a56b-d214-42cc-9017-cdffc14ca2ee"
          },
          {
            "type": "plannings",
            "id": "773931cd-c0a8-4853-a8f0-47426344fc70"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "78820d77-9292-40f5-a45d-57f0a9120b84"
          },
          {
            "type": "stock_item_plannings",
            "id": "4bfe382f-b1be-4689-9d7b-7accbdfe6672"
          },
          {
            "type": "stock_item_plannings",
            "id": "dce068c9-15a4-4ca1-a6ae-3be1e4bc66bd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bd940903-787d-4ce9-b99d-f1972b445efd",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-20T11:47:51+00:00",
        "updated_at": "2023-02-20T11:47:53+00:00",
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
        "customer_id": "3fb76e9e-4d9a-4b80-9010-575540bcc52c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb",
        "stop_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb"
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
      "id": "dfe0c7a9-fbf0-435e-884c-34d4d2454b5d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:53+00:00",
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
        "item_id": "8ddc9544-29cd-4e82-a838-16b3e871c1c6",
        "tax_category_id": "dde069f0-eb6e-43c2-87c4-6e9f759b303e",
        "planning_id": "6133a56b-d214-42cc-9017-cdffc14ca2ee",
        "parent_line_id": null,
        "owner_id": "bd940903-787d-4ce9-b99d-f1972b445efd",
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
      "id": "500577d9-e148-42b1-a9f2-13eaac571066",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:53+00:00",
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
        "item_id": "5309dccf-3110-490f-857e-a795d3d54790",
        "tax_category_id": "dde069f0-eb6e-43c2-87c4-6e9f759b303e",
        "planning_id": "773931cd-c0a8-4853-a8f0-47426344fc70",
        "parent_line_id": null,
        "owner_id": "bd940903-787d-4ce9-b99d-f1972b445efd",
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
      "id": "6133a56b-d214-42cc-9017-cdffc14ca2ee",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:52+00:00",
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
        "item_id": "8ddc9544-29cd-4e82-a838-16b3e871c1c6",
        "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd",
        "start_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb",
        "stop_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb",
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
      "id": "773931cd-c0a8-4853-a8f0-47426344fc70",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:52+00:00",
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
        "item_id": "5309dccf-3110-490f-857e-a795d3d54790",
        "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd",
        "start_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb",
        "stop_location_id": "5eef4e86-64cd-487e-8cae-b20a6ba07bfb",
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
      "id": "78820d77-9292-40f5-a45d-57f0a9120b84",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c07a8714-aeb0-4322-bbec-3c3c5c7276a9",
        "planning_id": "6133a56b-d214-42cc-9017-cdffc14ca2ee",
        "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd"
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
      "id": "4bfe382f-b1be-4689-9d7b-7accbdfe6672",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7fa7d362-85c6-4565-8220-e0fe713e0861",
        "planning_id": "6133a56b-d214-42cc-9017-cdffc14ca2ee",
        "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd"
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
      "id": "dce068c9-15a4-4ca1-a6ae-3be1e4bc66bd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:52+00:00",
        "updated_at": "2023-02-20T11:47:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "078c25e6-1f72-455a-a4e0-ef8e5263caf4",
        "planning_id": "6133a56b-d214-42cc-9017-cdffc14ca2ee",
        "order_id": "bd940903-787d-4ce9-b99d-f1972b445efd"
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
          "order_id": "ec2b1922-bebf-4468-8093-407810c688fd",
          "items": [
            {
              "type": "bundles",
              "id": "f94dff4d-fa75-4837-815c-0756517f925e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "255ac1d1-8a69-4d55-9120-1d1f3ea5abde",
                  "id": "b2d596f9-9935-4210-8f46-0c6722a58b8e"
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
    "id": "685f4d83-8eac-503d-ae6b-8be9b88ceef5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ec2b1922-bebf-4468-8093-407810c688fd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ec2b1922-bebf-4468-8093-407810c688fd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "16d9fb64-60d4-4521-8a50-84c2e2e9043f"
          },
          {
            "type": "lines",
            "id": "0d50cde1-5d08-455c-9e55-277b54a2d53e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f5e252aa-8e6d-48c7-97eb-2fa4d227866f"
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
      "id": "ec2b1922-bebf-4468-8093-407810c688fd",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-20T11:47:55+00:00",
        "updated_at": "2023-02-20T11:47:56+00:00",
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
        "starts_at": "2023-02-18T11:45:00+00:00",
        "stops_at": "2023-02-22T11:45:00+00:00",
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
        "start_location_id": "acad62f2-c2ba-495a-9c94-bf5ba6536cbd",
        "stop_location_id": "acad62f2-c2ba-495a-9c94-bf5ba6536cbd"
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
      "id": "16d9fb64-60d4-4521-8a50-84c2e2e9043f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T11:47:55+00:00",
        "updated_at": "2023-02-20T11:47:55+00:00",
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
        "item_id": "b2d596f9-9935-4210-8f46-0c6722a58b8e",
        "tax_category_id": null,
        "planning_id": "eb65b32a-ffad-4470-88f8-b75cee30519b",
        "parent_line_id": "0d50cde1-5d08-455c-9e55-277b54a2d53e",
        "owner_id": "ec2b1922-bebf-4468-8093-407810c688fd",
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
      "id": "0d50cde1-5d08-455c-9e55-277b54a2d53e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-20T11:47:55+00:00",
        "updated_at": "2023-02-20T11:47:55+00:00",
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
        "item_id": "f94dff4d-fa75-4837-815c-0756517f925e",
        "tax_category_id": null,
        "planning_id": "f5e252aa-8e6d-48c7-97eb-2fa4d227866f",
        "parent_line_id": null,
        "owner_id": "ec2b1922-bebf-4468-8093-407810c688fd",
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
      "id": "f5e252aa-8e6d-48c7-97eb-2fa4d227866f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-20T11:47:55+00:00",
        "updated_at": "2023-02-20T11:47:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-18T11:45:00+00:00",
        "stops_at": "2023-02-22T11:45:00+00:00",
        "reserved_from": "2023-02-18T11:45:00+00:00",
        "reserved_till": "2023-02-22T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f94dff4d-fa75-4837-815c-0756517f925e",
        "order_id": "ec2b1922-bebf-4468-8093-407810c688fd",
        "start_location_id": "acad62f2-c2ba-495a-9c94-bf5ba6536cbd",
        "stop_location_id": "acad62f2-c2ba-495a-9c94-bf5ba6536cbd",
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





