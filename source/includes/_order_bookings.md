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
          "order_id": "1f4b6d15-4722-46a0-ae52-889d8beb40dd",
          "items": [
            {
              "type": "products",
              "id": "be91d06e-2829-4270-85d1-510a2b722de0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0b027fd3-7364-438b-9906-7fbfddcff375",
              "stock_item_ids": [
                "8033fac1-87b4-416b-8101-75ea3706d9a3",
                "1ad1bc16-ec48-4dfe-afe1-fa3c5038aeb4"
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
          "stock_item_id 8033fac1-87b4-416b-8101-75ea3706d9a3 has already been booked on this order"
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
          "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
          "items": [
            {
              "type": "products",
              "id": "19c66281-3b3b-4e79-85c8-2a1061eac038",
              "stock_item_ids": [
                "e5e4d3ce-a0a7-4f3e-a314-f31c5d6f4f07",
                "bbcd2f39-460d-4b68-a6d8-82d61f74301c",
                "46de20f0-ee33-481f-a8cc-4254db6d90ff"
              ]
            },
            {
              "type": "products",
              "id": "0f38fa64-5b05-42fd-8c7c-f7134e24b087",
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
    "id": "c047be24-197e-5151-bec7-1f8699d1db0c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d9887a03-42ca-4562-8530-b40cc85c6fef"
          },
          {
            "type": "lines",
            "id": "6cd5e560-50ce-4e7b-8ddf-350af36f4bdc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e04c68d6-b946-4026-801e-fa3f020999f4"
          },
          {
            "type": "plannings",
            "id": "615367b8-5b5d-4610-b711-5686cef7677f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a70e3bc6-e3d6-49fa-a962-1f23d2662c3c"
          },
          {
            "type": "stock_item_plannings",
            "id": "28dbcbc5-1a33-4d90-858e-11fba92bf77c"
          },
          {
            "type": "stock_item_plannings",
            "id": "0ee5e906-feec-472b-9c5f-fdfd99b852d9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T15:49:45+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
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
        "customer_id": "8c7ae5cc-6b2d-4640-9a35-8ef99fcd7a9e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3",
        "stop_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3"
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
      "id": "d9887a03-42ca-4562-8530-b40cc85c6fef",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
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
        "item_id": "19c66281-3b3b-4e79-85c8-2a1061eac038",
        "tax_category_id": "31fdb79b-d1fc-49fd-82d6-1b8869f0ec30",
        "planning_id": "e04c68d6-b946-4026-801e-fa3f020999f4",
        "parent_line_id": null,
        "owner_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
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
      "id": "6cd5e560-50ce-4e7b-8ddf-350af36f4bdc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
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
        "item_id": "0f38fa64-5b05-42fd-8c7c-f7134e24b087",
        "tax_category_id": "31fdb79b-d1fc-49fd-82d6-1b8869f0ec30",
        "planning_id": "615367b8-5b5d-4610-b711-5686cef7677f",
        "parent_line_id": null,
        "owner_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
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
      "id": "e04c68d6-b946-4026-801e-fa3f020999f4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
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
        "item_id": "19c66281-3b3b-4e79-85c8-2a1061eac038",
        "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
        "start_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3",
        "stop_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3",
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
      "id": "615367b8-5b5d-4610-b711-5686cef7677f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
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
        "item_id": "0f38fa64-5b05-42fd-8c7c-f7134e24b087",
        "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270",
        "start_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3",
        "stop_location_id": "807095f3-47e5-4b0c-b35e-e35cb05801d3",
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
      "id": "a70e3bc6-e3d6-49fa-a962-1f23d2662c3c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e5e4d3ce-a0a7-4f3e-a314-f31c5d6f4f07",
        "planning_id": "e04c68d6-b946-4026-801e-fa3f020999f4",
        "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270"
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
      "id": "28dbcbc5-1a33-4d90-858e-11fba92bf77c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bbcd2f39-460d-4b68-a6d8-82d61f74301c",
        "planning_id": "e04c68d6-b946-4026-801e-fa3f020999f4",
        "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270"
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
      "id": "0ee5e906-feec-472b-9c5f-fdfd99b852d9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:46+00:00",
        "updated_at": "2023-02-16T15:49:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "46de20f0-ee33-481f-a8cc-4254db6d90ff",
        "planning_id": "e04c68d6-b946-4026-801e-fa3f020999f4",
        "order_id": "d16645c8-5dd3-4375-8a8f-54e8c61bc270"
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
          "order_id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e",
          "items": [
            {
              "type": "bundles",
              "id": "00f357bd-e68e-4907-b29a-d49f8f444fa3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "436fb3ea-e44a-43e3-9295-1ad1a01398f6",
                  "id": "38630e9e-027c-4996-9eb0-8b1d106d1dd1"
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
    "id": "5cd3382f-60a8-5b7d-9ed4-cb8550fad72c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "654ad628-e36d-4905-ad61-0c1c2b873bc8"
          },
          {
            "type": "lines",
            "id": "0aa49ae9-dd87-4cd5-ab07-e3e2b046a78e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "898a989f-adf1-4978-9a90-e69a6bf188bc"
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
      "id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T15:49:49+00:00",
        "updated_at": "2023-02-16T15:49:49+00:00",
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
        "starts_at": "2023-02-14T15:45:00+00:00",
        "stops_at": "2023-02-18T15:45:00+00:00",
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
        "start_location_id": "c981648e-80c5-4026-9a6c-9f077b5351d9",
        "stop_location_id": "c981648e-80c5-4026-9a6c-9f077b5351d9"
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
      "id": "654ad628-e36d-4905-ad61-0c1c2b873bc8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:49:49+00:00",
        "updated_at": "2023-02-16T15:49:49+00:00",
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
        "item_id": "38630e9e-027c-4996-9eb0-8b1d106d1dd1",
        "tax_category_id": null,
        "planning_id": "27212c03-8b77-430e-a8e2-9594ae46b0ee",
        "parent_line_id": "0aa49ae9-dd87-4cd5-ab07-e3e2b046a78e",
        "owner_id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e",
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
      "id": "0aa49ae9-dd87-4cd5-ab07-e3e2b046a78e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T15:49:49+00:00",
        "updated_at": "2023-02-16T15:49:49+00:00",
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
        "item_id": "00f357bd-e68e-4907-b29a-d49f8f444fa3",
        "tax_category_id": null,
        "planning_id": "898a989f-adf1-4978-9a90-e69a6bf188bc",
        "parent_line_id": null,
        "owner_id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e",
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
      "id": "898a989f-adf1-4978-9a90-e69a6bf188bc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T15:49:49+00:00",
        "updated_at": "2023-02-16T15:49:49+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T15:45:00+00:00",
        "stops_at": "2023-02-18T15:45:00+00:00",
        "reserved_from": "2023-02-14T15:45:00+00:00",
        "reserved_till": "2023-02-18T15:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "00f357bd-e68e-4907-b29a-d49f8f444fa3",
        "order_id": "ce247e5b-3668-4a6c-83f5-ecac3a06798e",
        "start_location_id": "c981648e-80c5-4026-9a6c-9f077b5351d9",
        "stop_location_id": "c981648e-80c5-4026-9a6c-9f077b5351d9",
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





