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
          "order_id": "f2006a4a-d31e-4bf6-905e-972625559d61",
          "items": [
            {
              "type": "products",
              "id": "816a0f14-74e1-4f3b-a29c-240455dab539",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7673f53c-5925-4a85-8848-0d2f7540ab19",
              "stock_item_ids": [
                "2e729a28-00d2-4a37-8b8c-8c1c6613ba87",
                "613ba8a4-ac7c-4945-bc29-38dddce19e8a"
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
            "item_id": "816a0f14-74e1-4f3b-a29c-240455dab539",
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
          "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
          "items": [
            {
              "type": "products",
              "id": "ffa14730-7c46-4e24-bb2c-999cbb0945be",
              "stock_item_ids": [
                "d55e51d0-d6d8-432d-af65-d4a15b69916f",
                "5d1618c5-7de4-43d4-9a11-46bb75bd28db",
                "97c3b350-28db-4d42-825b-8d6ffa9e0bf6"
              ]
            },
            {
              "type": "products",
              "id": "ca543119-0f18-4b85-97ac-68a555596498",
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
    "id": "b8897ea4-cb0d-5f42-9b0c-02f0f5dbf0d4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9f37f663-5953-447e-9435-86e86f17cac2"
          },
          {
            "type": "lines",
            "id": "bc369dac-9048-4329-96c2-b515d2ffeea3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2a652b56-6640-425e-b72e-ff357b5d5877"
          },
          {
            "type": "plannings",
            "id": "02501a52-29ce-4bfb-90c8-52b0b4337c50"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ee1a0ed2-0bd8-4b91-af2b-d7431637c72d"
          },
          {
            "type": "stock_item_plannings",
            "id": "6018b344-b651-492d-8bac-62b74eea74c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "0e96dd5e-513e-412c-a0c8-ae095ab62e6a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-29T11:16:04+00:00",
        "updated_at": "2022-01-29T11:16:06+00:00",
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
        "customer_id": "887e79ff-e3cd-443f-8f6c-990f28545a1a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30",
        "stop_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30"
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
      "id": "9f37f663-5953-447e-9435-86e86f17cac2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-29T11:16:04+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
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
        "item_id": "ca543119-0f18-4b85-97ac-68a555596498",
        "tax_category_id": "f2d30079-7659-4e84-af6d-f446034892b2",
        "planning_id": "2a652b56-6640-425e-b72e-ff357b5d5877",
        "parent_line_id": null,
        "owner_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
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
      "id": "bc369dac-9048-4329-96c2-b515d2ffeea3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-29T11:16:05+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
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
        "item_id": "ffa14730-7c46-4e24-bb2c-999cbb0945be",
        "tax_category_id": "f2d30079-7659-4e84-af6d-f446034892b2",
        "planning_id": "02501a52-29ce-4bfb-90c8-52b0b4337c50",
        "parent_line_id": null,
        "owner_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
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
      "id": "2a652b56-6640-425e-b72e-ff357b5d5877",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:04+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
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
        "item_id": "ca543119-0f18-4b85-97ac-68a555596498",
        "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
        "start_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30",
        "stop_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30",
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
      "id": "02501a52-29ce-4bfb-90c8-52b0b4337c50",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:05+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
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
        "item_id": "ffa14730-7c46-4e24-bb2c-999cbb0945be",
        "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b",
        "start_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30",
        "stop_location_id": "9dfa48fd-c01e-4b7d-a315-79946e008f30",
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
      "id": "ee1a0ed2-0bd8-4b91-af2b-d7431637c72d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:05+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d55e51d0-d6d8-432d-af65-d4a15b69916f",
        "planning_id": "02501a52-29ce-4bfb-90c8-52b0b4337c50",
        "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b"
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
      "id": "6018b344-b651-492d-8bac-62b74eea74c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:05+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5d1618c5-7de4-43d4-9a11-46bb75bd28db",
        "planning_id": "02501a52-29ce-4bfb-90c8-52b0b4337c50",
        "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b"
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
      "id": "0e96dd5e-513e-412c-a0c8-ae095ab62e6a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:05+00:00",
        "updated_at": "2022-01-29T11:16:05+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "97c3b350-28db-4d42-825b-8d6ffa9e0bf6",
        "planning_id": "02501a52-29ce-4bfb-90c8-52b0b4337c50",
        "order_id": "9fcd66b7-b646-438e-be30-5a131d3bbf0b"
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
          "order_id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e",
          "items": [
            {
              "type": "bundles",
              "id": "69da94b7-8304-4c1d-944a-f75c98f9789e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "00f0db12-7e67-46ed-bee1-deff454a6059",
                  "id": "7a550e3f-4be8-401b-8a99-27c9a16d6699"
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
    "id": "9958f867-a3c7-5b83-b843-6d65b405462a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "91ac8e64-6b06-4fc6-9a36-66aab43bd80f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "72febe45-2fca-4d5b-b92e-df899e869d19"
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
      "id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-29T11:16:08+00:00",
        "updated_at": "2022-01-29T11:16:09+00:00",
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
        "starts_at": "2022-01-27T11:15:00+00:00",
        "stops_at": "2022-01-31T11:15:00+00:00",
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
        "start_location_id": "817d64a9-dda6-4e25-b41d-cfbe366a7e39",
        "stop_location_id": "817d64a9-dda6-4e25-b41d-cfbe366a7e39"
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
      "id": "91ac8e64-6b06-4fc6-9a36-66aab43bd80f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-29T11:16:08+00:00",
        "updated_at": "2022-01-29T11:16:08+00:00",
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
        "item_id": "69da94b7-8304-4c1d-944a-f75c98f9789e",
        "tax_category_id": null,
        "planning_id": "72febe45-2fca-4d5b-b92e-df899e869d19",
        "parent_line_id": null,
        "owner_id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e",
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
      "id": "72febe45-2fca-4d5b-b92e-df899e869d19",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-29T11:16:08+00:00",
        "updated_at": "2022-01-29T11:16:08+00:00",
        "quantity": 1,
        "starts_at": "2022-01-27T11:15:00+00:00",
        "stops_at": "2022-01-31T11:15:00+00:00",
        "reserved_from": "2022-01-27T11:15:00+00:00",
        "reserved_till": "2022-01-31T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "69da94b7-8304-4c1d-944a-f75c98f9789e",
        "order_id": "9dd69f82-1eaa-442c-a1c1-66545de4af8e",
        "start_location_id": "817d64a9-dda6-4e25-b41d-cfbe366a7e39",
        "stop_location_id": "817d64a9-dda6-4e25-b41d-cfbe366a7e39",
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





