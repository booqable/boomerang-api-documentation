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
          "order_id": "db4b2cc8-dd23-4159-af13-693e4048f4db",
          "items": [
            {
              "type": "products",
              "id": "ba78c60e-154f-4bd8-bc7d-34f79db88fe6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "45cc9830-f33c-4292-b7ae-f39f0b265ba3",
              "stock_item_ids": [
                "2e657caa-8e8e-43de-916c-c23943ce3d14",
                "80900ce8-6a85-43d4-8159-6a843566ae4d"
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
          "stock_item_id 2e657caa-8e8e-43de-916c-c23943ce3d14 has already been booked on this order"
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
          "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
          "items": [
            {
              "type": "products",
              "id": "37f2e2e4-4f06-4589-a865-00ade5c6838a",
              "stock_item_ids": [
                "8ff49c77-de37-4c5e-a4cc-3bcee8d02683",
                "eb6d7389-8f6d-4b31-b39d-95f38dcd4cc0",
                "68cd0a71-118e-46fa-888d-f435393923e2"
              ]
            },
            {
              "type": "products",
              "id": "a809da0f-deba-41dc-ba9e-7d53fa73d555",
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
    "id": "a5ffad9e-b21c-5323-ae87-53e84e2e69b8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9fc7412b-92ad-4696-94b7-da0060750fcf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0664df23-6ccf-464f-bb6e-83f72ba75d27"
          },
          {
            "type": "lines",
            "id": "ed79e6f8-d5d9-4fd5-8346-b47d6afb1b70"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0eaa3f93-db61-4535-b926-cfee232fb177"
          },
          {
            "type": "plannings",
            "id": "a74b6498-f613-4eef-b154-1df038b56ed2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5fa989a5-c56f-4b5f-88ef-9ddb997539a4"
          },
          {
            "type": "stock_item_plannings",
            "id": "5f0ce59e-5e3f-4686-9e28-884f36342113"
          },
          {
            "type": "stock_item_plannings",
            "id": "5438001a-0144-4d98-ae44-4cd46fd6efe5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T07:53:44+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
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
        "customer_id": "711a4c5b-d814-4815-9a3b-54f9316b8fd5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889",
        "stop_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889"
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
      "id": "0664df23-6ccf-464f-bb6e-83f72ba75d27",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
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
        "item_id": "37f2e2e4-4f06-4589-a865-00ade5c6838a",
        "tax_category_id": "8981afd2-c711-43d9-9a64-1840a4c6634e",
        "planning_id": "0eaa3f93-db61-4535-b926-cfee232fb177",
        "parent_line_id": null,
        "owner_id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
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
      "id": "ed79e6f8-d5d9-4fd5-8346-b47d6afb1b70",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
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
        "item_id": "a809da0f-deba-41dc-ba9e-7d53fa73d555",
        "tax_category_id": "8981afd2-c711-43d9-9a64-1840a4c6634e",
        "planning_id": "a74b6498-f613-4eef-b154-1df038b56ed2",
        "parent_line_id": null,
        "owner_id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
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
      "id": "0eaa3f93-db61-4535-b926-cfee232fb177",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
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
        "item_id": "37f2e2e4-4f06-4589-a865-00ade5c6838a",
        "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
        "start_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889",
        "stop_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889",
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
      "id": "a74b6498-f613-4eef-b154-1df038b56ed2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
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
        "item_id": "a809da0f-deba-41dc-ba9e-7d53fa73d555",
        "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf",
        "start_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889",
        "stop_location_id": "ddaf04cd-4cb0-467e-8704-4ea96a754889",
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
      "id": "5fa989a5-c56f-4b5f-88ef-9ddb997539a4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8ff49c77-de37-4c5e-a4cc-3bcee8d02683",
        "planning_id": "0eaa3f93-db61-4535-b926-cfee232fb177",
        "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf"
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
      "id": "5f0ce59e-5e3f-4686-9e28-884f36342113",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eb6d7389-8f6d-4b31-b39d-95f38dcd4cc0",
        "planning_id": "0eaa3f93-db61-4535-b926-cfee232fb177",
        "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf"
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
      "id": "5438001a-0144-4d98-ae44-4cd46fd6efe5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:45+00:00",
        "updated_at": "2023-03-08T07:53:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "68cd0a71-118e-46fa-888d-f435393923e2",
        "planning_id": "0eaa3f93-db61-4535-b926-cfee232fb177",
        "order_id": "9fc7412b-92ad-4696-94b7-da0060750fcf"
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
          "order_id": "63274eb7-8514-4a9a-8607-c077f807a749",
          "items": [
            {
              "type": "bundles",
              "id": "b990483d-0e2a-4d91-8390-f30d1886336d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "33e8e5d1-2ca4-4bf2-a21c-378ecd17f3a5",
                  "id": "260f1a14-2355-46aa-9b63-3cff4871817d"
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
    "id": "00a23c5a-a72c-5b66-93da-d1be8c2f56e2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "63274eb7-8514-4a9a-8607-c077f807a749"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "63274eb7-8514-4a9a-8607-c077f807a749"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f7b4297b-cca6-4467-a97e-65d41d9d9b8a"
          },
          {
            "type": "lines",
            "id": "2dedee02-145e-420f-8ce0-0c6075e79d93"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "24eb2997-5edc-4e00-bd6b-a50b7671cf1a"
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
      "id": "63274eb7-8514-4a9a-8607-c077f807a749",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-08T07:53:47+00:00",
        "updated_at": "2023-03-08T07:53:48+00:00",
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
        "starts_at": "2023-03-06T07:45:00+00:00",
        "stops_at": "2023-03-10T07:45:00+00:00",
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
        "start_location_id": "5afe53af-9270-4214-b8bb-88b09ee3b840",
        "stop_location_id": "5afe53af-9270-4214-b8bb-88b09ee3b840"
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
      "id": "f7b4297b-cca6-4467-a97e-65d41d9d9b8a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T07:53:47+00:00",
        "updated_at": "2023-03-08T07:53:47+00:00",
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
        "item_id": "b990483d-0e2a-4d91-8390-f30d1886336d",
        "tax_category_id": null,
        "planning_id": "24eb2997-5edc-4e00-bd6b-a50b7671cf1a",
        "parent_line_id": null,
        "owner_id": "63274eb7-8514-4a9a-8607-c077f807a749",
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
      "id": "2dedee02-145e-420f-8ce0-0c6075e79d93",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-08T07:53:47+00:00",
        "updated_at": "2023-03-08T07:53:47+00:00",
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
        "item_id": "260f1a14-2355-46aa-9b63-3cff4871817d",
        "tax_category_id": null,
        "planning_id": "327518e6-9334-447a-8f64-4f741681e200",
        "parent_line_id": "f7b4297b-cca6-4467-a97e-65d41d9d9b8a",
        "owner_id": "63274eb7-8514-4a9a-8607-c077f807a749",
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
      "id": "24eb2997-5edc-4e00-bd6b-a50b7671cf1a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-08T07:53:47+00:00",
        "updated_at": "2023-03-08T07:53:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-06T07:45:00+00:00",
        "stops_at": "2023-03-10T07:45:00+00:00",
        "reserved_from": "2023-03-06T07:45:00+00:00",
        "reserved_till": "2023-03-10T07:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b990483d-0e2a-4d91-8390-f30d1886336d",
        "order_id": "63274eb7-8514-4a9a-8607-c077f807a749",
        "start_location_id": "5afe53af-9270-4214-b8bb-88b09ee3b840",
        "stop_location_id": "5afe53af-9270-4214-b8bb-88b09ee3b840",
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





