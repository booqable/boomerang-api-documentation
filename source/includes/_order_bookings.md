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
          "order_id": "f6a1e392-fb86-4127-8c91-eb4352ded57d",
          "items": [
            {
              "type": "products",
              "id": "a0b27b27-7217-494f-a2a3-b85a08f060c8",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "33656a9d-83b8-4e5b-a568-cb59794e32d2",
              "stock_item_ids": [
                "65de04f2-f2ae-4df5-b17c-38684a9e18fa",
                "06287471-9359-4eeb-906b-100776de5993"
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
          "stock_item_id 65de04f2-f2ae-4df5-b17c-38684a9e18fa has already been booked on this order"
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
          "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
          "items": [
            {
              "type": "products",
              "id": "8ad90547-569a-41f8-a7de-c2bd5e4915fc",
              "stock_item_ids": [
                "77c57ab4-1ef1-4b68-ba17-dcb08fb06662",
                "d751ddf2-fc8e-47d3-8895-2f3c04d568a5",
                "9cc04c5e-5444-4324-a3b7-6c4a346eac4e"
              ]
            },
            {
              "type": "products",
              "id": "8bc46b81-71e2-4284-aea7-23900d015fe6",
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
    "id": "43d4bd56-f17a-5011-97de-be2c96852ee9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "95f9ca92-ee26-4287-8cf0-f0764fa65449"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "40e779bd-ae84-4d28-8973-308e8631b590"
          },
          {
            "type": "lines",
            "id": "60386f8f-8e85-4b13-b7c4-6b727ccb8fda"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df"
          },
          {
            "type": "plannings",
            "id": "34cd1d3d-11e9-4228-8d0e-50ce47412038"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "620c9712-f531-49b2-8287-2c1c47db7796"
          },
          {
            "type": "stock_item_plannings",
            "id": "e687abc0-18cd-4fea-b4aa-1408ed35ee24"
          },
          {
            "type": "stock_item_plannings",
            "id": "fff58b7b-f096-4f10-8f81-6669a713b26d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T10:01:11+00:00",
        "updated_at": "2023-02-16T10:01:14+00:00",
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
        "customer_id": "f86541a2-259c-4d60-ab5e-30dfd024fb40",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb",
        "stop_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb"
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
      "id": "40e779bd-ae84-4d28-8973-308e8631b590",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:14+00:00",
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
        "item_id": "8ad90547-569a-41f8-a7de-c2bd5e4915fc",
        "tax_category_id": "ac8076a9-12dc-4f2b-a78e-3f401166826a",
        "planning_id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df",
        "parent_line_id": null,
        "owner_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
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
      "id": "60386f8f-8e85-4b13-b7c4-6b727ccb8fda",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:14+00:00",
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
        "item_id": "8bc46b81-71e2-4284-aea7-23900d015fe6",
        "tax_category_id": "ac8076a9-12dc-4f2b-a78e-3f401166826a",
        "planning_id": "34cd1d3d-11e9-4228-8d0e-50ce47412038",
        "parent_line_id": null,
        "owner_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
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
      "id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:13+00:00",
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
        "item_id": "8ad90547-569a-41f8-a7de-c2bd5e4915fc",
        "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
        "start_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb",
        "stop_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb",
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
      "id": "34cd1d3d-11e9-4228-8d0e-50ce47412038",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:13+00:00",
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
        "item_id": "8bc46b81-71e2-4284-aea7-23900d015fe6",
        "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449",
        "start_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb",
        "stop_location_id": "33239fa0-8197-4983-8a68-2d1f5d093dfb",
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
      "id": "620c9712-f531-49b2-8287-2c1c47db7796",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "77c57ab4-1ef1-4b68-ba17-dcb08fb06662",
        "planning_id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df",
        "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449"
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
      "id": "e687abc0-18cd-4fea-b4aa-1408ed35ee24",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d751ddf2-fc8e-47d3-8895-2f3c04d568a5",
        "planning_id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df",
        "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449"
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
      "id": "fff58b7b-f096-4f10-8f81-6669a713b26d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:13+00:00",
        "updated_at": "2023-02-16T10:01:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9cc04c5e-5444-4324-a3b7-6c4a346eac4e",
        "planning_id": "f0275f85-6ea5-4213-aa33-b5fe11ddb1df",
        "order_id": "95f9ca92-ee26-4287-8cf0-f0764fa65449"
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
          "order_id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32",
          "items": [
            {
              "type": "bundles",
              "id": "76d186c8-daaa-45af-8971-973d96e9010b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "dc62b7c8-857f-4979-956e-493217d2fefd",
                  "id": "f25456e2-05a1-4420-8a7b-2700cb51b271"
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
    "id": "ca913b0e-2660-5ccf-813e-554ab39016d2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d62066b-ef7a-4279-9cff-15b5a439ee3b"
          },
          {
            "type": "lines",
            "id": "da0ab81e-9b49-4598-972f-7f06c84985f1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b7c78a21-7e34-4896-9c26-a5d8e486d84e"
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
      "id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T10:01:19+00:00",
        "updated_at": "2023-02-16T10:01:20+00:00",
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
        "starts_at": "2023-02-14T10:00:00+00:00",
        "stops_at": "2023-02-18T10:00:00+00:00",
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
        "start_location_id": "fe8a0ea1-0675-4611-a587-4874e9aa6bd6",
        "stop_location_id": "fe8a0ea1-0675-4611-a587-4874e9aa6bd6"
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
      "id": "7d62066b-ef7a-4279-9cff-15b5a439ee3b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T10:01:20+00:00",
        "updated_at": "2023-02-16T10:01:20+00:00",
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
        "item_id": "f25456e2-05a1-4420-8a7b-2700cb51b271",
        "tax_category_id": null,
        "planning_id": "b19380d4-07fe-4be4-a80b-e62340584215",
        "parent_line_id": "da0ab81e-9b49-4598-972f-7f06c84985f1",
        "owner_id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32",
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
      "id": "da0ab81e-9b49-4598-972f-7f06c84985f1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T10:01:20+00:00",
        "updated_at": "2023-02-16T10:01:20+00:00",
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
        "item_id": "76d186c8-daaa-45af-8971-973d96e9010b",
        "tax_category_id": null,
        "planning_id": "b7c78a21-7e34-4896-9c26-a5d8e486d84e",
        "parent_line_id": null,
        "owner_id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32",
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
      "id": "b7c78a21-7e34-4896-9c26-a5d8e486d84e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T10:01:19+00:00",
        "updated_at": "2023-02-16T10:01:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T10:00:00+00:00",
        "stops_at": "2023-02-18T10:00:00+00:00",
        "reserved_from": "2023-02-14T10:00:00+00:00",
        "reserved_till": "2023-02-18T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "76d186c8-daaa-45af-8971-973d96e9010b",
        "order_id": "3167e36e-012d-432d-9f8f-74f6c3b4ea32",
        "start_location_id": "fe8a0ea1-0675-4611-a587-4874e9aa6bd6",
        "stop_location_id": "fe8a0ea1-0675-4611-a587-4874e9aa6bd6",
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





