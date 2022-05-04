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
          "order_id": "aeeeae76-d054-4751-b13c-2abf64c88073",
          "items": [
            {
              "type": "products",
              "id": "ca40cb37-1151-4300-9fee-437c4349b757",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "07fc1b88-4ebe-467c-a066-635f7477920a",
              "stock_item_ids": [
                "96d08695-0268-4e13-8662-38565c873e9d",
                "39180c6c-999f-49ec-81f4-6307f11336fc"
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
            "item_id": "ca40cb37-1151-4300-9fee-437c4349b757",
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
          "order_id": "2e16891d-e574-492e-a283-1ad973752abf",
          "items": [
            {
              "type": "products",
              "id": "eac90817-e4da-4601-b094-e5a6a62db881",
              "stock_item_ids": [
                "f830c832-7cce-4f43-b5b9-76c1abea17ff",
                "0a8ea8b2-acf6-4a8f-909f-3fc950b37cca",
                "14b25c8f-fb27-47d5-9fc1-01cb9504df6f"
              ]
            },
            {
              "type": "products",
              "id": "bed5cdd8-176b-4bdd-affe-2aff0c3e5b67",
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
    "id": "82c05044-f5c0-5754-85ac-eef7a45f640b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2e16891d-e574-492e-a283-1ad973752abf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2e16891d-e574-492e-a283-1ad973752abf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "078e20ca-83a2-439b-95d9-d0382ddc6c94"
          },
          {
            "type": "lines",
            "id": "3da937d9-f11b-48d2-9973-c8bc08486bbd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8a05844b-aaf5-49c5-a63b-4c9fcf9fa403"
          },
          {
            "type": "plannings",
            "id": "70858d41-a51e-49ba-b90d-658975d5eca5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4c9b8cf2-885a-4fed-8658-5fbd6c74e179"
          },
          {
            "type": "stock_item_plannings",
            "id": "a7993ab6-46d9-4b9a-a5be-33e0eb3b3341"
          },
          {
            "type": "stock_item_plannings",
            "id": "d29a2517-7710-4852-9ab6-46dbdcaa281a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2e16891d-e574-492e-a283-1ad973752abf",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-04T10:05:39+00:00",
        "updated_at": "2022-05-04T10:05:42+00:00",
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
        "customer_id": "466cce66-de1f-48de-be44-1dcc690dea4e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f45ec895-5035-40f4-aac0-654285f832bd",
        "stop_location_id": "f45ec895-5035-40f4-aac0-654285f832bd"
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
      "id": "078e20ca-83a2-439b-95d9-d0382ddc6c94",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-04T10:05:40+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
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
        "item_id": "bed5cdd8-176b-4bdd-affe-2aff0c3e5b67",
        "tax_category_id": "9d118d29-c572-4e41-968f-9a5cfba1595b",
        "planning_id": "8a05844b-aaf5-49c5-a63b-4c9fcf9fa403",
        "parent_line_id": null,
        "owner_id": "2e16891d-e574-492e-a283-1ad973752abf",
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
      "id": "3da937d9-f11b-48d2-9973-c8bc08486bbd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-04T10:05:41+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
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
        "item_id": "eac90817-e4da-4601-b094-e5a6a62db881",
        "tax_category_id": "9d118d29-c572-4e41-968f-9a5cfba1595b",
        "planning_id": "70858d41-a51e-49ba-b90d-658975d5eca5",
        "parent_line_id": null,
        "owner_id": "2e16891d-e574-492e-a283-1ad973752abf",
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
      "id": "8a05844b-aaf5-49c5-a63b-4c9fcf9fa403",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:40+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
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
        "item_id": "bed5cdd8-176b-4bdd-affe-2aff0c3e5b67",
        "order_id": "2e16891d-e574-492e-a283-1ad973752abf",
        "start_location_id": "f45ec895-5035-40f4-aac0-654285f832bd",
        "stop_location_id": "f45ec895-5035-40f4-aac0-654285f832bd",
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
      "id": "70858d41-a51e-49ba-b90d-658975d5eca5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:41+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
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
        "item_id": "eac90817-e4da-4601-b094-e5a6a62db881",
        "order_id": "2e16891d-e574-492e-a283-1ad973752abf",
        "start_location_id": "f45ec895-5035-40f4-aac0-654285f832bd",
        "stop_location_id": "f45ec895-5035-40f4-aac0-654285f832bd",
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
      "id": "4c9b8cf2-885a-4fed-8658-5fbd6c74e179",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:41+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f830c832-7cce-4f43-b5b9-76c1abea17ff",
        "planning_id": "70858d41-a51e-49ba-b90d-658975d5eca5",
        "order_id": "2e16891d-e574-492e-a283-1ad973752abf"
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
      "id": "a7993ab6-46d9-4b9a-a5be-33e0eb3b3341",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:41+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0a8ea8b2-acf6-4a8f-909f-3fc950b37cca",
        "planning_id": "70858d41-a51e-49ba-b90d-658975d5eca5",
        "order_id": "2e16891d-e574-492e-a283-1ad973752abf"
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
      "id": "d29a2517-7710-4852-9ab6-46dbdcaa281a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:41+00:00",
        "updated_at": "2022-05-04T10:05:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "14b25c8f-fb27-47d5-9fc1-01cb9504df6f",
        "planning_id": "70858d41-a51e-49ba-b90d-658975d5eca5",
        "order_id": "2e16891d-e574-492e-a283-1ad973752abf"
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
          "order_id": "19d256f7-8682-4508-9457-8947fb3cf139",
          "items": [
            {
              "type": "bundles",
              "id": "4726ce15-9da8-4a9c-82f4-cdc232df59b0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "25669828-65e2-44d4-a993-0cedbcf6e9e9",
                  "id": "50a9bec1-7a50-46b4-8230-236a94518847"
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
    "id": "3cd55655-ae1d-5536-8b78-4a2bb40ec8b9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "19d256f7-8682-4508-9457-8947fb3cf139"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "19d256f7-8682-4508-9457-8947fb3cf139"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1dff4174-9c57-4248-a33e-940033003129"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dda16365-8d6b-463c-92ff-21864a4d3598"
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
      "id": "19d256f7-8682-4508-9457-8947fb3cf139",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-04T10:05:44+00:00",
        "updated_at": "2022-05-04T10:05:46+00:00",
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
        "starts_at": "2022-05-02T10:00:00+00:00",
        "stops_at": "2022-05-06T10:00:00+00:00",
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
        "start_location_id": "052270c8-e4bc-477f-8599-301e7bd8ebc9",
        "stop_location_id": "052270c8-e4bc-477f-8599-301e7bd8ebc9"
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
      "id": "1dff4174-9c57-4248-a33e-940033003129",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-04T10:05:46+00:00",
        "updated_at": "2022-05-04T10:05:46+00:00",
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
        "item_id": "4726ce15-9da8-4a9c-82f4-cdc232df59b0",
        "tax_category_id": null,
        "planning_id": "dda16365-8d6b-463c-92ff-21864a4d3598",
        "parent_line_id": null,
        "owner_id": "19d256f7-8682-4508-9457-8947fb3cf139",
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
      "id": "dda16365-8d6b-463c-92ff-21864a4d3598",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-04T10:05:46+00:00",
        "updated_at": "2022-05-04T10:05:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-02T10:00:00+00:00",
        "stops_at": "2022-05-06T10:00:00+00:00",
        "reserved_from": "2022-05-02T10:00:00+00:00",
        "reserved_till": "2022-05-06T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4726ce15-9da8-4a9c-82f4-cdc232df59b0",
        "order_id": "19d256f7-8682-4508-9457-8947fb3cf139",
        "start_location_id": "052270c8-e4bc-477f-8599-301e7bd8ebc9",
        "stop_location_id": "052270c8-e4bc-477f-8599-301e7bd8ebc9",
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





