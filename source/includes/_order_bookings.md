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
          "order_id": "45097601-a76b-473a-bb24-a64356225a9d",
          "items": [
            {
              "type": "products",
              "id": "d83af6c1-cf85-47ba-82e2-f31be312f32e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "800739ae-994e-4571-aaa1-ee799796cdc3",
              "stock_item_ids": [
                "f2cb409f-a3b1-4ad0-815d-043f5477fe9d",
                "07923f0a-9c10-4e95-b2ba-6b9cdba046a3"
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
            "item_id": "d83af6c1-cf85-47ba-82e2-f31be312f32e",
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
          "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
          "items": [
            {
              "type": "products",
              "id": "2e5a4c0f-5af4-435d-9b3d-ae73c5fdde38",
              "stock_item_ids": [
                "107f8b9e-b4a4-4ded-9e0c-050903e2cb9b",
                "c95ce8e2-e3ea-4e49-97aa-be4e1b10c013",
                "78cde65e-22c6-4344-8206-871e93ebcfa9"
              ]
            },
            {
              "type": "products",
              "id": "d92e6f60-5383-4208-b80d-af311e129f2c",
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
    "id": "6eac9d4b-52f9-527a-923f-732842aa3fab",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2e784a12-d790-4019-87e9-406e1cdcaecc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b5339a1b-6471-4aac-bf43-63808e33ae39"
          },
          {
            "type": "lines",
            "id": "262047ed-5e4c-4224-9a1b-92c9cae9b979"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "453609ba-989c-45a6-9582-c1946c5d9ffc"
          },
          {
            "type": "plannings",
            "id": "197de82a-da3f-4a08-a72e-066bf32a8d29"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "71187d55-273d-44bd-bbe4-21b9e170f354"
          },
          {
            "type": "stock_item_plannings",
            "id": "1d5550d1-06ad-4c8e-86c0-d5a20c6f495a"
          },
          {
            "type": "stock_item_plannings",
            "id": "091829f0-38b0-43bb-9132-5eafc2544553"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-16T10:50:44+00:00",
        "updated_at": "2022-02-16T10:50:47+00:00",
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
        "customer_id": "8d1d2813-1590-426f-8811-41f41a1872dc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f",
        "stop_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f"
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
      "id": "b5339a1b-6471-4aac-bf43-63808e33ae39",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-16T10:50:45+00:00",
        "updated_at": "2022-02-16T10:50:46+00:00",
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
        "item_id": "d92e6f60-5383-4208-b80d-af311e129f2c",
        "tax_category_id": "8419b3da-37eb-4f6e-8d87-31d8a337cb5e",
        "planning_id": "453609ba-989c-45a6-9582-c1946c5d9ffc",
        "parent_line_id": null,
        "owner_id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
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
      "id": "262047ed-5e4c-4224-9a1b-92c9cae9b979",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-16T10:50:46+00:00",
        "updated_at": "2022-02-16T10:50:46+00:00",
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
        "item_id": "2e5a4c0f-5af4-435d-9b3d-ae73c5fdde38",
        "tax_category_id": "8419b3da-37eb-4f6e-8d87-31d8a337cb5e",
        "planning_id": "197de82a-da3f-4a08-a72e-066bf32a8d29",
        "parent_line_id": null,
        "owner_id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
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
      "id": "453609ba-989c-45a6-9582-c1946c5d9ffc",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:45+00:00",
        "updated_at": "2022-02-16T10:50:47+00:00",
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
        "item_id": "d92e6f60-5383-4208-b80d-af311e129f2c",
        "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
        "start_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f",
        "stop_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f",
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
      "id": "197de82a-da3f-4a08-a72e-066bf32a8d29",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:46+00:00",
        "updated_at": "2022-02-16T10:50:47+00:00",
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
        "item_id": "2e5a4c0f-5af4-435d-9b3d-ae73c5fdde38",
        "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc",
        "start_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f",
        "stop_location_id": "eebf26f5-aac2-478f-b66d-36abd7414a5f",
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
      "id": "71187d55-273d-44bd-bbe4-21b9e170f354",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:46+00:00",
        "updated_at": "2022-02-16T10:50:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "107f8b9e-b4a4-4ded-9e0c-050903e2cb9b",
        "planning_id": "197de82a-da3f-4a08-a72e-066bf32a8d29",
        "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc"
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
      "id": "1d5550d1-06ad-4c8e-86c0-d5a20c6f495a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:46+00:00",
        "updated_at": "2022-02-16T10:50:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c95ce8e2-e3ea-4e49-97aa-be4e1b10c013",
        "planning_id": "197de82a-da3f-4a08-a72e-066bf32a8d29",
        "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc"
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
      "id": "091829f0-38b0-43bb-9132-5eafc2544553",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:46+00:00",
        "updated_at": "2022-02-16T10:50:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "78cde65e-22c6-4344-8206-871e93ebcfa9",
        "planning_id": "197de82a-da3f-4a08-a72e-066bf32a8d29",
        "order_id": "2e784a12-d790-4019-87e9-406e1cdcaecc"
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
          "order_id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004",
          "items": [
            {
              "type": "bundles",
              "id": "4926ab4d-c0a7-43e4-ae23-dae031287a2c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9e9d3ee6-f8b2-437f-85e3-8b4a758a3e47",
                  "id": "5e91db73-825b-4f88-96db-58aa1ceb2283"
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
    "id": "1cddf884-988f-5978-be49-39f4bb192971",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6c435ff0-73cf-4ac2-bcba-001d40034311"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "35e53dde-1519-45d3-b355-447f5741de71"
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
      "id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-16T10:50:51+00:00",
        "updated_at": "2022-02-16T10:50:52+00:00",
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
        "starts_at": "2022-02-14T10:45:00+00:00",
        "stops_at": "2022-02-18T10:45:00+00:00",
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
        "start_location_id": "7190b8bb-f6ba-4065-975c-6270adfb1a84",
        "stop_location_id": "7190b8bb-f6ba-4065-975c-6270adfb1a84"
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
      "id": "6c435ff0-73cf-4ac2-bcba-001d40034311",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-16T10:50:52+00:00",
        "updated_at": "2022-02-16T10:50:52+00:00",
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
        "item_id": "4926ab4d-c0a7-43e4-ae23-dae031287a2c",
        "tax_category_id": null,
        "planning_id": "35e53dde-1519-45d3-b355-447f5741de71",
        "parent_line_id": null,
        "owner_id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004",
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
      "id": "35e53dde-1519-45d3-b355-447f5741de71",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-16T10:50:52+00:00",
        "updated_at": "2022-02-16T10:50:52+00:00",
        "quantity": 1,
        "starts_at": "2022-02-14T10:45:00+00:00",
        "stops_at": "2022-02-18T10:45:00+00:00",
        "reserved_from": "2022-02-14T10:45:00+00:00",
        "reserved_till": "2022-02-18T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4926ab4d-c0a7-43e4-ae23-dae031287a2c",
        "order_id": "b9b89fab-6b28-4c88-9fad-94f6e4c4a004",
        "start_location_id": "7190b8bb-f6ba-4065-975c-6270adfb1a84",
        "stop_location_id": "7190b8bb-f6ba-4065-975c-6270adfb1a84",
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





