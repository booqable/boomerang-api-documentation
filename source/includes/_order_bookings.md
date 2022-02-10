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
          "order_id": "ddd36309-b53c-48f1-8ea9-20886a66f683",
          "items": [
            {
              "type": "products",
              "id": "dc1cac04-a4c8-450f-8935-2056c534100e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e0bc964e-7608-4a13-b23f-02b545ddaae2",
              "stock_item_ids": [
                "e6210afb-326e-44f0-9649-7eefb5d0faa7",
                "aaac2c9c-d875-476b-991f-85a9820cd3ec"
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
            "item_id": "dc1cac04-a4c8-450f-8935-2056c534100e",
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
          "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
          "items": [
            {
              "type": "products",
              "id": "332b2ada-6478-47d9-8574-1118cc74a5ed",
              "stock_item_ids": [
                "fcfaa237-5b68-47ad-a5e5-7e0abbe67e5e",
                "b4887597-b056-47b1-905a-677d4735c09d",
                "547a4f40-b79d-4e09-a474-684326d91af4"
              ]
            },
            {
              "type": "products",
              "id": "42f7c230-957a-4b4c-959c-2308668d0b9f",
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
    "id": "eb193735-6027-539d-87f1-1fc56d1b9815",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9b4ddf30-2792-4659-80f8-31326f36c10b"
          },
          {
            "type": "lines",
            "id": "102169e3-cb52-490b-86a8-c2691d38047b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "55f4733b-5bc4-4aec-bf39-08786630ab86"
          },
          {
            "type": "plannings",
            "id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ab2eae69-663e-434f-8d39-3b4d8ea6aa65"
          },
          {
            "type": "stock_item_plannings",
            "id": "af0c0504-69b6-4288-ad73-431b71c33e07"
          },
          {
            "type": "stock_item_plannings",
            "id": "ae9f85e2-106f-4b72-a59d-09f322a10a33"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-10T10:32:19+00:00",
        "updated_at": "2022-02-10T10:32:22+00:00",
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
        "customer_id": "9e885308-ffa4-4d63-8f93-e0d6bfb0c3ce",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f922542b-1223-413c-a406-3fd7e2301374",
        "stop_location_id": "f922542b-1223-413c-a406-3fd7e2301374"
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
      "id": "9b4ddf30-2792-4659-80f8-31326f36c10b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-10T10:32:19+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
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
        "item_id": "42f7c230-957a-4b4c-959c-2308668d0b9f",
        "tax_category_id": "721a2055-6fbf-45aa-93f8-e757c6d84f83",
        "planning_id": "55f4733b-5bc4-4aec-bf39-08786630ab86",
        "parent_line_id": null,
        "owner_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
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
      "id": "102169e3-cb52-490b-86a8-c2691d38047b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-10T10:32:21+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
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
        "item_id": "332b2ada-6478-47d9-8574-1118cc74a5ed",
        "tax_category_id": "721a2055-6fbf-45aa-93f8-e757c6d84f83",
        "planning_id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702",
        "parent_line_id": null,
        "owner_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
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
      "id": "55f4733b-5bc4-4aec-bf39-08786630ab86",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:19+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
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
        "item_id": "42f7c230-957a-4b4c-959c-2308668d0b9f",
        "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
        "start_location_id": "f922542b-1223-413c-a406-3fd7e2301374",
        "stop_location_id": "f922542b-1223-413c-a406-3fd7e2301374",
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
      "id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:21+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
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
        "item_id": "332b2ada-6478-47d9-8574-1118cc74a5ed",
        "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07",
        "start_location_id": "f922542b-1223-413c-a406-3fd7e2301374",
        "stop_location_id": "f922542b-1223-413c-a406-3fd7e2301374",
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
      "id": "ab2eae69-663e-434f-8d39-3b4d8ea6aa65",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:21+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fcfaa237-5b68-47ad-a5e5-7e0abbe67e5e",
        "planning_id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702",
        "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07"
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
      "id": "af0c0504-69b6-4288-ad73-431b71c33e07",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:21+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b4887597-b056-47b1-905a-677d4735c09d",
        "planning_id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702",
        "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07"
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
      "id": "ae9f85e2-106f-4b72-a59d-09f322a10a33",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:21+00:00",
        "updated_at": "2022-02-10T10:32:21+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "547a4f40-b79d-4e09-a474-684326d91af4",
        "planning_id": "b8e69778-aa79-4c5a-83f4-b7ab1c825702",
        "order_id": "a21c8e85-d315-4df5-a97d-e0d8d47afb07"
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
          "order_id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8",
          "items": [
            {
              "type": "bundles",
              "id": "85b9b9bc-844f-46d9-8f81-110c957fc52d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "04cc2341-de04-4df3-b861-6a799972cd47",
                  "id": "633b67b4-dae8-40f5-a1b7-cccb7b7c5107"
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
    "id": "9669115a-67df-504b-9754-c7432639ba51",
    "type": "order_bookings",
    "attributes": {
      "order_id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "00ccc390-6b64-4ca5-9a9b-3369af8829af"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "db15d7a8-5e38-4874-8cef-0c2b4e495896"
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
      "id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-10T10:32:24+00:00",
        "updated_at": "2022-02-10T10:32:25+00:00",
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
        "starts_at": "2022-02-08T10:30:00+00:00",
        "stops_at": "2022-02-12T10:30:00+00:00",
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
        "start_location_id": "0e78d681-fc53-497e-873a-2d3cfa0a187b",
        "stop_location_id": "0e78d681-fc53-497e-873a-2d3cfa0a187b"
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
      "id": "00ccc390-6b64-4ca5-9a9b-3369af8829af",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-10T10:32:25+00:00",
        "updated_at": "2022-02-10T10:32:25+00:00",
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
        "item_id": "85b9b9bc-844f-46d9-8f81-110c957fc52d",
        "tax_category_id": null,
        "planning_id": "db15d7a8-5e38-4874-8cef-0c2b4e495896",
        "parent_line_id": null,
        "owner_id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8",
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
      "id": "db15d7a8-5e38-4874-8cef-0c2b4e495896",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-10T10:32:25+00:00",
        "updated_at": "2022-02-10T10:32:25+00:00",
        "quantity": 1,
        "starts_at": "2022-02-08T10:30:00+00:00",
        "stops_at": "2022-02-12T10:30:00+00:00",
        "reserved_from": "2022-02-08T10:30:00+00:00",
        "reserved_till": "2022-02-12T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "85b9b9bc-844f-46d9-8f81-110c957fc52d",
        "order_id": "08deb92e-6d3f-4a8e-a834-a2e5ef7e27f8",
        "start_location_id": "0e78d681-fc53-497e-873a-2d3cfa0a187b",
        "stop_location_id": "0e78d681-fc53-497e-873a-2d3cfa0a187b",
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





