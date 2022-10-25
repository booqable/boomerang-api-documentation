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
          "order_id": "8538494f-c772-4cbc-b08f-0c3e350083df",
          "items": [
            {
              "type": "products",
              "id": "8a65613c-5076-432c-afc4-bdebd07e9a8a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7a19b77c-218e-4096-80f1-216d53ed4428",
              "stock_item_ids": [
                "52b73396-b185-4fb7-b1b1-9c8365043a34",
                "175e50f8-eed2-4fb1-8121-87cb677959c6"
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
            "item_id": "8a65613c-5076-432c-afc4-bdebd07e9a8a",
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
          "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
          "items": [
            {
              "type": "products",
              "id": "61c6580d-4ade-47e0-bf5b-f8c4e2c9f80b",
              "stock_item_ids": [
                "8457c93f-d658-43be-a0cf-87d84e1df345",
                "b31b983d-fa2d-40b4-94ab-b21fccf8f7ad",
                "251f4a8d-2884-488b-ba18-69cc8fdac1aa"
              ]
            },
            {
              "type": "products",
              "id": "7cd86352-93b6-453f-b30d-2562ea196840",
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
    "id": "443f73ca-56c0-586d-8502-d5bc084b306b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c5dbbd5a-9470-444b-900b-636fda11b946"
          },
          {
            "type": "lines",
            "id": "4af58afa-f132-47a8-b7b2-734eea9d5e1e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "813e5009-f9a6-4241-9e5d-915ffccde98d"
          },
          {
            "type": "plannings",
            "id": "8d1101db-788e-4172-a967-589da4774302"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8b85cd65-70e3-403a-959a-e5ae03486f43"
          },
          {
            "type": "stock_item_plannings",
            "id": "42932a94-3262-46a3-a34f-820d137a568e"
          },
          {
            "type": "stock_item_plannings",
            "id": "842ba4b4-4806-41d6-9138-bdfcd2d1a267"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T17:53:03+00:00",
        "updated_at": "2022-10-25T17:53:06+00:00",
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
        "customer_id": "c9a98675-8743-4596-be03-f4a8f36ccd4c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b",
        "stop_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b"
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
      "id": "c5dbbd5a-9470-444b-900b-636fda11b946",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
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
        "item_id": "61c6580d-4ade-47e0-bf5b-f8c4e2c9f80b",
        "tax_category_id": "405b66ff-66c0-41ef-813d-9a1f7c18a16c",
        "planning_id": "813e5009-f9a6-4241-9e5d-915ffccde98d",
        "parent_line_id": null,
        "owner_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
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
      "id": "4af58afa-f132-47a8-b7b2-734eea9d5e1e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
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
        "item_id": "7cd86352-93b6-453f-b30d-2562ea196840",
        "tax_category_id": "405b66ff-66c0-41ef-813d-9a1f7c18a16c",
        "planning_id": "8d1101db-788e-4172-a967-589da4774302",
        "parent_line_id": null,
        "owner_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
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
      "id": "813e5009-f9a6-4241-9e5d-915ffccde98d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
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
        "item_id": "61c6580d-4ade-47e0-bf5b-f8c4e2c9f80b",
        "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
        "start_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b",
        "stop_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b",
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
      "id": "8d1101db-788e-4172-a967-589da4774302",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
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
        "item_id": "7cd86352-93b6-453f-b30d-2562ea196840",
        "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72",
        "start_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b",
        "stop_location_id": "3d74e33c-4d06-47dc-8cf2-7ed22080c67b",
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
      "id": "8b85cd65-70e3-403a-959a-e5ae03486f43",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8457c93f-d658-43be-a0cf-87d84e1df345",
        "planning_id": "813e5009-f9a6-4241-9e5d-915ffccde98d",
        "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72"
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
      "id": "42932a94-3262-46a3-a34f-820d137a568e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b31b983d-fa2d-40b4-94ab-b21fccf8f7ad",
        "planning_id": "813e5009-f9a6-4241-9e5d-915ffccde98d",
        "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72"
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
      "id": "842ba4b4-4806-41d6-9138-bdfcd2d1a267",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:05+00:00",
        "updated_at": "2022-10-25T17:53:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "251f4a8d-2884-488b-ba18-69cc8fdac1aa",
        "planning_id": "813e5009-f9a6-4241-9e5d-915ffccde98d",
        "order_id": "52d1a455-46ca-4192-9f9b-c234ee5c5a72"
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
          "order_id": "43f4d433-a682-490a-8d4a-11f10705605a",
          "items": [
            {
              "type": "bundles",
              "id": "e6548b58-1dc2-4b5f-8ba3-e44e4c6914ba",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "69c2d607-21c1-4643-8b7a-67c9ff532756",
                  "id": "0da142e0-cd1d-4f5e-9221-1aac5b3e7f56"
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
    "id": "f5ba65fe-3ba2-5109-9dbe-2b2f6c070552",
    "type": "order_bookings",
    "attributes": {
      "order_id": "43f4d433-a682-490a-8d4a-11f10705605a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "43f4d433-a682-490a-8d4a-11f10705605a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8e56950b-d562-434f-9da3-427a08557c8c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3038ad63-6b80-4c01-bf79-9a967bfaf430"
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
      "id": "43f4d433-a682-490a-8d4a-11f10705605a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T17:53:08+00:00",
        "updated_at": "2022-10-25T17:53:10+00:00",
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
        "starts_at": "2022-10-23T17:45:00+00:00",
        "stops_at": "2022-10-27T17:45:00+00:00",
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
        "start_location_id": "4afd1d74-e72e-4330-ab33-35a9d44d3d11",
        "stop_location_id": "4afd1d74-e72e-4330-ab33-35a9d44d3d11"
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
      "id": "8e56950b-d562-434f-9da3-427a08557c8c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T17:53:09+00:00",
        "updated_at": "2022-10-25T17:53:09+00:00",
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
        "item_id": "e6548b58-1dc2-4b5f-8ba3-e44e4c6914ba",
        "tax_category_id": null,
        "planning_id": "3038ad63-6b80-4c01-bf79-9a967bfaf430",
        "parent_line_id": null,
        "owner_id": "43f4d433-a682-490a-8d4a-11f10705605a",
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
      "id": "3038ad63-6b80-4c01-bf79-9a967bfaf430",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T17:53:09+00:00",
        "updated_at": "2022-10-25T17:53:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T17:45:00+00:00",
        "stops_at": "2022-10-27T17:45:00+00:00",
        "reserved_from": "2022-10-23T17:45:00+00:00",
        "reserved_till": "2022-10-27T17:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e6548b58-1dc2-4b5f-8ba3-e44e4c6914ba",
        "order_id": "43f4d433-a682-490a-8d4a-11f10705605a",
        "start_location_id": "4afd1d74-e72e-4330-ab33-35a9d44d3d11",
        "stop_location_id": "4afd1d74-e72e-4330-ab33-35a9d44d3d11",
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





