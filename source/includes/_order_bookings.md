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
          "order_id": "5e4b3ef6-ec5c-47a1-9e20-09fa36bf3a56",
          "items": [
            {
              "type": "products",
              "id": "dfb20dbb-f71c-495f-b1d0-71b999f018c6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "06110813-f0a3-4d64-a55e-0f5753fe4fd1",
              "stock_item_ids": [
                "8fe638e2-f3c6-41ab-bc8b-822c22005dc2",
                "4f394fc4-6309-4d27-ab74-f75875b4aaba"
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
            "item_id": "dfb20dbb-f71c-495f-b1d0-71b999f018c6",
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
          "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
          "items": [
            {
              "type": "products",
              "id": "f9f5b132-cf99-4c7c-9f55-4938c6221d31",
              "stock_item_ids": [
                "fedfa7ee-81d1-4fd2-9f6f-832e8efa1d80",
                "e7099a0f-113b-4d3b-8ce3-5c24d1be5a2b",
                "b80e918a-ee06-49a2-bcdd-477d6b101981"
              ]
            },
            {
              "type": "products",
              "id": "9b785150-d721-4f95-b419-f321a60fa2cc",
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
    "id": "27fe3590-a4f8-5b6a-ac97-284695820620",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fdcb6641-9270-4bb2-bd72-19b47c61156d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9b99a8ce-6da5-4f56-a211-5b7542ac57cf"
          },
          {
            "type": "lines",
            "id": "3e6c5d4d-d342-4644-aba9-9fe0e916f94f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fe785ed7-71b1-4f44-863d-f63e406533c5"
          },
          {
            "type": "plannings",
            "id": "85f32b01-52ce-46b9-a079-ab13794518d1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "22392207-317f-41b0-a6f8-d9e4638201f8"
          },
          {
            "type": "stock_item_plannings",
            "id": "2ee58d35-ddd8-478f-b05b-576278123a64"
          },
          {
            "type": "stock_item_plannings",
            "id": "cbd68d3a-db35-413f-b083-78b6e295d859"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:46:33+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
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
        "customer_id": "ee66e039-2a77-4a69-91bb-603e70e590b0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6",
        "stop_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6"
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
      "id": "9b99a8ce-6da5-4f56-a211-5b7542ac57cf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:46:34+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
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
        "item_id": "9b785150-d721-4f95-b419-f321a60fa2cc",
        "tax_category_id": "90e35754-65e9-43ef-8196-ce92829aa5aa",
        "planning_id": "fe785ed7-71b1-4f44-863d-f63e406533c5",
        "parent_line_id": null,
        "owner_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
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
      "id": "3e6c5d4d-d342-4644-aba9-9fe0e916f94f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:46:35+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
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
        "item_id": "f9f5b132-cf99-4c7c-9f55-4938c6221d31",
        "tax_category_id": "90e35754-65e9-43ef-8196-ce92829aa5aa",
        "planning_id": "85f32b01-52ce-46b9-a079-ab13794518d1",
        "parent_line_id": null,
        "owner_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
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
      "id": "fe785ed7-71b1-4f44-863d-f63e406533c5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:34+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "9b785150-d721-4f95-b419-f321a60fa2cc",
        "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
        "start_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6",
        "stop_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6",
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
      "id": "85f32b01-52ce-46b9-a079-ab13794518d1",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:35+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
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
        "item_id": "f9f5b132-cf99-4c7c-9f55-4938c6221d31",
        "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d",
        "start_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6",
        "stop_location_id": "b7b9eff8-7723-4387-8526-8dc9c98a44d6",
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
      "id": "22392207-317f-41b0-a6f8-d9e4638201f8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:35+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fedfa7ee-81d1-4fd2-9f6f-832e8efa1d80",
        "planning_id": "85f32b01-52ce-46b9-a079-ab13794518d1",
        "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d"
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
      "id": "2ee58d35-ddd8-478f-b05b-576278123a64",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:35+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e7099a0f-113b-4d3b-8ce3-5c24d1be5a2b",
        "planning_id": "85f32b01-52ce-46b9-a079-ab13794518d1",
        "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d"
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
      "id": "cbd68d3a-db35-413f-b083-78b6e295d859",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:35+00:00",
        "updated_at": "2022-05-24T07:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b80e918a-ee06-49a2-bcdd-477d6b101981",
        "planning_id": "85f32b01-52ce-46b9-a079-ab13794518d1",
        "order_id": "fdcb6641-9270-4bb2-bd72-19b47c61156d"
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
          "order_id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735",
          "items": [
            {
              "type": "bundles",
              "id": "200c681e-796e-499e-8061-c519e15a7fb5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "09c11d86-7aa3-4ae7-af4d-7a8c876fc0c1",
                  "id": "83f622f7-d372-4cf3-8d20-b091a3672d09"
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
    "id": "8fb66a14-f593-5f50-86c9-1d194f95f0f3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "799429aa-ee40-464d-b859-17dcb1812773"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0179f3ff-bb89-46bc-92b8-4c81538206a4"
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
      "id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:46:37+00:00",
        "updated_at": "2022-05-24T07:46:39+00:00",
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
        "starts_at": "2022-05-22T07:45:00+00:00",
        "stops_at": "2022-05-26T07:45:00+00:00",
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
        "start_location_id": "3860bb77-5b8f-482b-8b87-4cfe2f23c551",
        "stop_location_id": "3860bb77-5b8f-482b-8b87-4cfe2f23c551"
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
      "id": "799429aa-ee40-464d-b859-17dcb1812773",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:46:39+00:00",
        "updated_at": "2022-05-24T07:46:39+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "200c681e-796e-499e-8061-c519e15a7fb5",
        "tax_category_id": null,
        "planning_id": "0179f3ff-bb89-46bc-92b8-4c81538206a4",
        "parent_line_id": null,
        "owner_id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735",
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
      "id": "0179f3ff-bb89-46bc-92b8-4c81538206a4",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:46:38+00:00",
        "updated_at": "2022-05-24T07:46:38+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-22T07:45:00+00:00",
        "stops_at": "2022-05-26T07:45:00+00:00",
        "reserved_from": "2022-05-22T07:45:00+00:00",
        "reserved_till": "2022-05-26T07:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "200c681e-796e-499e-8061-c519e15a7fb5",
        "order_id": "2e320e4c-b77b-4b18-bd57-86ebf9d0d735",
        "start_location_id": "3860bb77-5b8f-482b-8b87-4cfe2f23c551",
        "stop_location_id": "3860bb77-5b8f-482b-8b87-4cfe2f23c551",
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





