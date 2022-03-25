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
          "order_id": "1bcff913-cf42-4c19-80b7-72270c09a05a",
          "items": [
            {
              "type": "products",
              "id": "297de1de-5f6d-4e3d-9226-ab6cbc92246b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "24ddba79-bc53-471b-bfeb-97da57baeec2",
              "stock_item_ids": [
                "d97c2a0a-9fe1-45e0-87b6-3336819458eb",
                "f3d0d3b0-efd5-4f54-ba2e-258804767748"
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
            "item_id": "297de1de-5f6d-4e3d-9226-ab6cbc92246b",
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
          "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
          "items": [
            {
              "type": "products",
              "id": "f3b87fdd-4f39-482d-bd12-34affdfbcb7f",
              "stock_item_ids": [
                "c3c0f02d-f1be-48ca-b285-88924ce5a49b",
                "e2f37619-437a-4dbb-81fe-a51d6fa0601a",
                "2e0e50f8-1c03-4f1f-8ff4-7029b74a629b"
              ]
            },
            {
              "type": "products",
              "id": "dd6a2d0a-e35b-46df-851e-858f9a697417",
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
    "id": "b0a90386-662f-5f86-9f84-bc7c344dd2a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c5badf67-f21a-412d-82fe-9c3ea922a507"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4d693d24-0d12-41f3-a262-0049dd7de166"
          },
          {
            "type": "lines",
            "id": "7e94aff9-d6fa-4923-92d8-bb115df764e5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8e449d4a-3019-462e-bcba-25a07c5be9e5"
          },
          {
            "type": "plannings",
            "id": "2b332543-ce63-4fee-b737-324db4b7b2b8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5ba89097-8fc7-4511-9542-72c0e472e75e"
          },
          {
            "type": "stock_item_plannings",
            "id": "60d5cb6d-3cec-465f-9679-9b827bf7b558"
          },
          {
            "type": "stock_item_plannings",
            "id": "4ee1e48a-9408-4c4b-a88b-5f8d732bf8aa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-25T08:53:47+00:00",
        "updated_at": "2022-03-25T08:53:50+00:00",
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
        "customer_id": "314a6f19-eeb4-44cc-8327-71dfe2a2b8a2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28",
        "stop_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28"
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
      "id": "4d693d24-0d12-41f3-a262-0049dd7de166",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-25T08:53:48+00:00",
        "updated_at": "2022-03-25T08:53:49+00:00",
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
        "item_id": "dd6a2d0a-e35b-46df-851e-858f9a697417",
        "tax_category_id": "0cf81c0f-7b61-4a33-8be2-e270fc6605ad",
        "planning_id": "8e449d4a-3019-462e-bcba-25a07c5be9e5",
        "parent_line_id": null,
        "owner_id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
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
      "id": "7e94aff9-d6fa-4923-92d8-bb115df764e5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-25T08:53:49+00:00",
        "updated_at": "2022-03-25T08:53:49+00:00",
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
        "item_id": "f3b87fdd-4f39-482d-bd12-34affdfbcb7f",
        "tax_category_id": "0cf81c0f-7b61-4a33-8be2-e270fc6605ad",
        "planning_id": "2b332543-ce63-4fee-b737-324db4b7b2b8",
        "parent_line_id": null,
        "owner_id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
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
      "id": "8e449d4a-3019-462e-bcba-25a07c5be9e5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:48+00:00",
        "updated_at": "2022-03-25T08:53:50+00:00",
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
        "item_id": "dd6a2d0a-e35b-46df-851e-858f9a697417",
        "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
        "start_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28",
        "stop_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28",
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
      "id": "2b332543-ce63-4fee-b737-324db4b7b2b8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:49+00:00",
        "updated_at": "2022-03-25T08:53:50+00:00",
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
        "item_id": "f3b87fdd-4f39-482d-bd12-34affdfbcb7f",
        "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507",
        "start_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28",
        "stop_location_id": "81d0ea8d-6748-4644-94e2-0b4df3380e28",
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
      "id": "5ba89097-8fc7-4511-9542-72c0e472e75e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:49+00:00",
        "updated_at": "2022-03-25T08:53:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c3c0f02d-f1be-48ca-b285-88924ce5a49b",
        "planning_id": "2b332543-ce63-4fee-b737-324db4b7b2b8",
        "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507"
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
      "id": "60d5cb6d-3cec-465f-9679-9b827bf7b558",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:49+00:00",
        "updated_at": "2022-03-25T08:53:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e2f37619-437a-4dbb-81fe-a51d6fa0601a",
        "planning_id": "2b332543-ce63-4fee-b737-324db4b7b2b8",
        "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507"
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
      "id": "4ee1e48a-9408-4c4b-a88b-5f8d732bf8aa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:49+00:00",
        "updated_at": "2022-03-25T08:53:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e0e50f8-1c03-4f1f-8ff4-7029b74a629b",
        "planning_id": "2b332543-ce63-4fee-b737-324db4b7b2b8",
        "order_id": "c5badf67-f21a-412d-82fe-9c3ea922a507"
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
          "order_id": "f45f85c6-5455-484f-9162-d9015a3ac84e",
          "items": [
            {
              "type": "bundles",
              "id": "7fcc98c0-05c6-4d22-abf2-8972ad6c3c7a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ecd70c34-bdc3-48be-90ac-ba3e12db2a2f",
                  "id": "03b81fbe-ae17-4d5a-a27e-7b5e3028e3a0"
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
    "id": "46ec5335-57c3-598e-bb99-17e63d81e3ee",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f45f85c6-5455-484f-9162-d9015a3ac84e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f45f85c6-5455-484f-9162-d9015a3ac84e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8809d329-a858-456c-b7cb-4782d4963b22"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "181fa6d3-0717-4e99-ad23-8637944e6a5a"
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
      "id": "f45f85c6-5455-484f-9162-d9015a3ac84e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-25T08:53:52+00:00",
        "updated_at": "2022-03-25T08:53:52+00:00",
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
        "starts_at": "2022-03-23T08:45:00+00:00",
        "stops_at": "2022-03-27T08:45:00+00:00",
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
        "start_location_id": "d335e5bc-1069-4abe-8686-636726ab9533",
        "stop_location_id": "d335e5bc-1069-4abe-8686-636726ab9533"
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
      "id": "8809d329-a858-456c-b7cb-4782d4963b22",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-25T08:53:52+00:00",
        "updated_at": "2022-03-25T08:53:52+00:00",
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
        "item_id": "7fcc98c0-05c6-4d22-abf2-8972ad6c3c7a",
        "tax_category_id": null,
        "planning_id": "181fa6d3-0717-4e99-ad23-8637944e6a5a",
        "parent_line_id": null,
        "owner_id": "f45f85c6-5455-484f-9162-d9015a3ac84e",
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
      "id": "181fa6d3-0717-4e99-ad23-8637944e6a5a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-25T08:53:52+00:00",
        "updated_at": "2022-03-25T08:53:52+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-23T08:45:00+00:00",
        "stops_at": "2022-03-27T08:45:00+00:00",
        "reserved_from": "2022-03-23T08:45:00+00:00",
        "reserved_till": "2022-03-27T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7fcc98c0-05c6-4d22-abf2-8972ad6c3c7a",
        "order_id": "f45f85c6-5455-484f-9162-d9015a3ac84e",
        "start_location_id": "d335e5bc-1069-4abe-8686-636726ab9533",
        "stop_location_id": "d335e5bc-1069-4abe-8686-636726ab9533",
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





