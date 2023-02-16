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
          "order_id": "b045abfd-4805-46de-b971-49f3cb00bdfe",
          "items": [
            {
              "type": "products",
              "id": "0e0fda5b-48b5-4404-83b0-99817f248748",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e68b22af-1e62-404b-a929-1a765b7cbafb",
              "stock_item_ids": [
                "b958e835-b1e4-42e3-894d-7c58ba402566",
                "3a2c709f-87ab-4a14-8ec8-276e75c90c8a"
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
          "stock_item_id b958e835-b1e4-42e3-894d-7c58ba402566 has already been booked on this order"
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
          "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
          "items": [
            {
              "type": "products",
              "id": "5e1912c7-5f0d-4eaa-94ef-b722cc600f3c",
              "stock_item_ids": [
                "af3026bb-f7d3-412c-a589-f149f2b851fe",
                "ee4e7a45-8544-49c4-9141-aebce740b86f",
                "d1ffa6cf-24e5-4505-8608-002d846e338b"
              ]
            },
            {
              "type": "products",
              "id": "42b12e1b-a12d-42b1-aedf-78b8bdde6563",
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
    "id": "d5bec9e6-7cb4-5aa8-8672-78dfe8dde4a9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d613d79-5880-43ff-9770-846cb99d7a06"
          },
          {
            "type": "lines",
            "id": "f9cfe7b8-bd49-4598-b5f0-ddb9eea85d5a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda"
          },
          {
            "type": "plannings",
            "id": "64c8d931-3d08-44f6-95c5-a9f7e5cb6058"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d599e065-7ee9-4ad8-967f-7a239825aeff"
          },
          {
            "type": "stock_item_plannings",
            "id": "5ace9fcc-6866-4b7a-9cae-0c70b012f8c0"
          },
          {
            "type": "stock_item_plannings",
            "id": "b622917f-2ff2-479f-8cd6-527d38e7f7bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T22:57:21+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
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
        "customer_id": "0dd8e56e-7796-4b90-a853-96bd7110d56c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c",
        "stop_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c"
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
      "id": "7d613d79-5880-43ff-9770-846cb99d7a06",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
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
        "item_id": "5e1912c7-5f0d-4eaa-94ef-b722cc600f3c",
        "tax_category_id": "d25531e1-d045-4a49-b97c-fd899fb38e88",
        "planning_id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda",
        "parent_line_id": null,
        "owner_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
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
      "id": "f9cfe7b8-bd49-4598-b5f0-ddb9eea85d5a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
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
        "item_id": "42b12e1b-a12d-42b1-aedf-78b8bdde6563",
        "tax_category_id": "d25531e1-d045-4a49-b97c-fd899fb38e88",
        "planning_id": "64c8d931-3d08-44f6-95c5-a9f7e5cb6058",
        "parent_line_id": null,
        "owner_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
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
      "id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
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
        "item_id": "5e1912c7-5f0d-4eaa-94ef-b722cc600f3c",
        "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
        "start_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c",
        "stop_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c",
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
      "id": "64c8d931-3d08-44f6-95c5-a9f7e5cb6058",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
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
        "item_id": "42b12e1b-a12d-42b1-aedf-78b8bdde6563",
        "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf",
        "start_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c",
        "stop_location_id": "d872a1aa-b0f9-4ce8-bde1-bf0ddec7fa6c",
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
      "id": "d599e065-7ee9-4ad8-967f-7a239825aeff",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af3026bb-f7d3-412c-a589-f149f2b851fe",
        "planning_id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda",
        "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf"
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
      "id": "5ace9fcc-6866-4b7a-9cae-0c70b012f8c0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ee4e7a45-8544-49c4-9141-aebce740b86f",
        "planning_id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda",
        "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf"
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
      "id": "b622917f-2ff2-479f-8cd6-527d38e7f7bb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:22+00:00",
        "updated_at": "2023-02-16T22:57:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d1ffa6cf-24e5-4505-8608-002d846e338b",
        "planning_id": "f1fcea91-0157-446a-b80c-a8a86fcc0cda",
        "order_id": "40d8c45f-8617-4ab2-bc34-0e841caa6bdf"
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
          "order_id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc",
          "items": [
            {
              "type": "bundles",
              "id": "c9ab366e-5b03-4294-9c48-8755de2aee60",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a15270df-53fc-422e-82d8-7f240ed40c5b",
                  "id": "212c5a75-fcb6-46e4-8086-24807d9c569d"
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
    "id": "60b60512-e177-560b-8b64-69248c5aa49a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cfce59f3-41a9-4a8c-879b-c2725b8758e8"
          },
          {
            "type": "lines",
            "id": "92f1047f-e11e-4384-a254-866d9947755a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d2c01616-1e6d-4363-bfcf-1a2c036a5ba9"
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
      "id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T22:57:24+00:00",
        "updated_at": "2023-02-16T22:57:25+00:00",
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
        "starts_at": "2023-02-14T22:45:00+00:00",
        "stops_at": "2023-02-18T22:45:00+00:00",
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
        "start_location_id": "7fa6a3c8-59a3-43a4-9418-67971321473a",
        "stop_location_id": "7fa6a3c8-59a3-43a4-9418-67971321473a"
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
      "id": "cfce59f3-41a9-4a8c-879b-c2725b8758e8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T22:57:25+00:00",
        "updated_at": "2023-02-16T22:57:25+00:00",
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
        "item_id": "c9ab366e-5b03-4294-9c48-8755de2aee60",
        "tax_category_id": null,
        "planning_id": "d2c01616-1e6d-4363-bfcf-1a2c036a5ba9",
        "parent_line_id": null,
        "owner_id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc",
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
      "id": "92f1047f-e11e-4384-a254-866d9947755a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T22:57:25+00:00",
        "updated_at": "2023-02-16T22:57:25+00:00",
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
        "item_id": "212c5a75-fcb6-46e4-8086-24807d9c569d",
        "tax_category_id": null,
        "planning_id": "fc96b986-9db2-4ba8-a735-d589e032b32a",
        "parent_line_id": "cfce59f3-41a9-4a8c-879b-c2725b8758e8",
        "owner_id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc",
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
      "id": "d2c01616-1e6d-4363-bfcf-1a2c036a5ba9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T22:57:25+00:00",
        "updated_at": "2023-02-16T22:57:25+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T22:45:00+00:00",
        "stops_at": "2023-02-18T22:45:00+00:00",
        "reserved_from": "2023-02-14T22:45:00+00:00",
        "reserved_till": "2023-02-18T22:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c9ab366e-5b03-4294-9c48-8755de2aee60",
        "order_id": "60942aeb-17bb-4ba0-9faf-0a02c25ac6fc",
        "start_location_id": "7fa6a3c8-59a3-43a4-9418-67971321473a",
        "stop_location_id": "7fa6a3c8-59a3-43a4-9418-67971321473a",
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





