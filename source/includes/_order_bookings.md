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
          "order_id": "97020522-527b-49e9-bfb8-66bfe89238ca",
          "items": [
            {
              "type": "products",
              "id": "2980e455-0411-44ac-9930-1e737b7cad58",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b839c41e-2774-4b0a-9122-b1a656f2d1a6",
              "stock_item_ids": [
                "ca73641f-f1d2-4e19-9c9a-3b21951a1341",
                "14cc0c37-657c-4f21-81b2-19fac48929ed"
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
            "item_id": "2980e455-0411-44ac-9930-1e737b7cad58",
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
          "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
          "items": [
            {
              "type": "products",
              "id": "8609fc80-310c-4918-96af-ee6f6dbeb170",
              "stock_item_ids": [
                "bbdf0dee-7c2f-4b87-a596-84c4788175b3",
                "693cec8f-23c6-431e-a430-50f9407bf562",
                "6b30971e-ac52-41eb-89b7-5cc2daea45c8"
              ]
            },
            {
              "type": "products",
              "id": "ff386798-73fe-4bc6-b70d-3de2fc939220",
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
    "id": "ba365881-92e4-547b-a9f0-50483d378185",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c456bf58-0753-4021-ae36-7dedb4a4a88e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8fbd2268-a403-45de-ae24-d94abb7c5880"
          },
          {
            "type": "lines",
            "id": "2c747e90-9bd9-4873-b0e3-b995271422ed"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6f782e03-a562-451a-8c32-bb65736930de"
          },
          {
            "type": "plannings",
            "id": "da2f32f2-37b1-48e0-88f9-f3d07b1c8b50"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "94b3f3d4-2661-4ae6-9975-976d33c70039"
          },
          {
            "type": "stock_item_plannings",
            "id": "ae331dae-3e59-4062-9bc5-32b63bcf819f"
          },
          {
            "type": "stock_item_plannings",
            "id": "786b3704-431a-4ed8-bacf-80343ded94f2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T09:53:10+00:00",
        "updated_at": "2023-02-03T09:53:12+00:00",
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
        "customer_id": "4aefa9dc-97eb-4f11-b822-99a06d88b157",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f",
        "stop_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f"
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
      "id": "8fbd2268-a403-45de-ae24-d94abb7c5880",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:12+00:00",
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
        "item_id": "8609fc80-310c-4918-96af-ee6f6dbeb170",
        "tax_category_id": "e9ab7f96-ee3a-4b64-93ca-c59d948bbeec",
        "planning_id": "6f782e03-a562-451a-8c32-bb65736930de",
        "parent_line_id": null,
        "owner_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
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
      "id": "2c747e90-9bd9-4873-b0e3-b995271422ed",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:12+00:00",
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
        "item_id": "ff386798-73fe-4bc6-b70d-3de2fc939220",
        "tax_category_id": "e9ab7f96-ee3a-4b64-93ca-c59d948bbeec",
        "planning_id": "da2f32f2-37b1-48e0-88f9-f3d07b1c8b50",
        "parent_line_id": null,
        "owner_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
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
      "id": "6f782e03-a562-451a-8c32-bb65736930de",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:12+00:00",
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
        "item_id": "8609fc80-310c-4918-96af-ee6f6dbeb170",
        "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
        "start_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f",
        "stop_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f",
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
      "id": "da2f32f2-37b1-48e0-88f9-f3d07b1c8b50",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:12+00:00",
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
        "item_id": "ff386798-73fe-4bc6-b70d-3de2fc939220",
        "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e",
        "start_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f",
        "stop_location_id": "87838dfe-17be-46b7-abdb-3f68e81cd89f",
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
      "id": "94b3f3d4-2661-4ae6-9975-976d33c70039",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bbdf0dee-7c2f-4b87-a596-84c4788175b3",
        "planning_id": "6f782e03-a562-451a-8c32-bb65736930de",
        "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e"
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
      "id": "ae331dae-3e59-4062-9bc5-32b63bcf819f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "693cec8f-23c6-431e-a430-50f9407bf562",
        "planning_id": "6f782e03-a562-451a-8c32-bb65736930de",
        "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e"
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
      "id": "786b3704-431a-4ed8-bacf-80343ded94f2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:11+00:00",
        "updated_at": "2023-02-03T09:53:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6b30971e-ac52-41eb-89b7-5cc2daea45c8",
        "planning_id": "6f782e03-a562-451a-8c32-bb65736930de",
        "order_id": "c456bf58-0753-4021-ae36-7dedb4a4a88e"
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
          "order_id": "594b57ea-9f8b-4932-b01e-684f2c7b949e",
          "items": [
            {
              "type": "bundles",
              "id": "47543f5c-e520-4197-a4c7-f4552f4ef644",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a2dfc1e6-66f2-42d2-a1be-c0c57f2f9f3d",
                  "id": "4044873d-eebf-4a98-ac8e-6eeca9c31229"
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
    "id": "983e1457-5f91-5f65-bf57-f7650659dab9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "594b57ea-9f8b-4932-b01e-684f2c7b949e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "594b57ea-9f8b-4932-b01e-684f2c7b949e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "86d0cfdb-3e46-4085-8593-82ffcbcdb381"
          },
          {
            "type": "lines",
            "id": "09f7cc2f-87ac-4bc5-b185-7fab59ed278f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7c70a527-b59c-49a3-852d-02f1878c313d"
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
      "id": "594b57ea-9f8b-4932-b01e-684f2c7b949e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T09:53:15+00:00",
        "updated_at": "2023-02-03T09:53:15+00:00",
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
        "starts_at": "2023-02-01T09:45:00+00:00",
        "stops_at": "2023-02-05T09:45:00+00:00",
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
        "start_location_id": "04e51685-e71c-472b-921e-dd040d312193",
        "stop_location_id": "04e51685-e71c-472b-921e-dd040d312193"
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
      "id": "86d0cfdb-3e46-4085-8593-82ffcbcdb381",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T09:53:15+00:00",
        "updated_at": "2023-02-03T09:53:15+00:00",
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
        "item_id": "47543f5c-e520-4197-a4c7-f4552f4ef644",
        "tax_category_id": null,
        "planning_id": "7c70a527-b59c-49a3-852d-02f1878c313d",
        "parent_line_id": null,
        "owner_id": "594b57ea-9f8b-4932-b01e-684f2c7b949e",
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
      "id": "09f7cc2f-87ac-4bc5-b185-7fab59ed278f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T09:53:15+00:00",
        "updated_at": "2023-02-03T09:53:15+00:00",
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
        "item_id": "4044873d-eebf-4a98-ac8e-6eeca9c31229",
        "tax_category_id": null,
        "planning_id": "d02eefce-abed-443f-83c9-dce3325c642c",
        "parent_line_id": "86d0cfdb-3e46-4085-8593-82ffcbcdb381",
        "owner_id": "594b57ea-9f8b-4932-b01e-684f2c7b949e",
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
      "id": "7c70a527-b59c-49a3-852d-02f1878c313d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T09:53:15+00:00",
        "updated_at": "2023-02-03T09:53:15+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T09:45:00+00:00",
        "stops_at": "2023-02-05T09:45:00+00:00",
        "reserved_from": "2023-02-01T09:45:00+00:00",
        "reserved_till": "2023-02-05T09:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "47543f5c-e520-4197-a4c7-f4552f4ef644",
        "order_id": "594b57ea-9f8b-4932-b01e-684f2c7b949e",
        "start_location_id": "04e51685-e71c-472b-921e-dd040d312193",
        "stop_location_id": "04e51685-e71c-472b-921e-dd040d312193",
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





