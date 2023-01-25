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
          "order_id": "bebeafe2-1bc7-4727-a3d7-5b33297cc090",
          "items": [
            {
              "type": "products",
              "id": "2510a8e9-0a04-46fa-a84f-39302cd50686",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d8f3f1b0-a06b-4cf3-9e7d-1c3b00d34033",
              "stock_item_ids": [
                "7e129b2e-ddc7-487b-86d6-0256689ffa54",
                "bac37f63-93c9-4e40-a0e8-93adceedbe85"
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
            "item_id": "2510a8e9-0a04-46fa-a84f-39302cd50686",
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
          "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
          "items": [
            {
              "type": "products",
              "id": "0af6f855-57c3-45dd-b7fd-29b4c7823aff",
              "stock_item_ids": [
                "899cfc79-c204-4188-8b97-a58af8f0671b",
                "1cf0ddee-625a-4b4e-82c4-54cbaffaeb67",
                "a35f034e-0c69-4cbf-b244-ce88bd3b8240"
              ]
            },
            {
              "type": "products",
              "id": "8c8c2c89-04b8-4349-8482-7f7a6d4c2720",
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
    "id": "0ae02b49-1f4a-5e25-8357-1239ed060d5a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ab18817b-5620-4a71-9037-c0abf22ecd99"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "56badf25-999d-45b6-a724-ae03f32befcd"
          },
          {
            "type": "lines",
            "id": "3c96a2fa-a528-4048-9ac8-d4928e6fe87d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "91f6cbf6-6aee-4abc-8504-80846a60afcd"
          },
          {
            "type": "plannings",
            "id": "b2afe537-2778-4fa3-8f05-2008dde4113f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7409c6e3-a3fc-44e1-b7d6-1cc1f3882695"
          },
          {
            "type": "stock_item_plannings",
            "id": "bc0cbd92-b671-4d54-8512-93cdcf16d7b4"
          },
          {
            "type": "stock_item_plannings",
            "id": "32e62087-560b-4ff1-bd62-dba8cfa272b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-25T12:36:01+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
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
        "customer_id": "f5f0a1a7-d5b1-43f2-8c9f-06a386c79d21",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba",
        "stop_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba"
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
      "id": "56badf25-999d-45b6-a724-ae03f32befcd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
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
        "item_id": "0af6f855-57c3-45dd-b7fd-29b4c7823aff",
        "tax_category_id": "ee403bda-ce4d-4fa5-8217-5d0bdcaae620",
        "planning_id": "91f6cbf6-6aee-4abc-8504-80846a60afcd",
        "parent_line_id": null,
        "owner_id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
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
      "id": "3c96a2fa-a528-4048-9ac8-d4928e6fe87d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
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
        "item_id": "8c8c2c89-04b8-4349-8482-7f7a6d4c2720",
        "tax_category_id": "ee403bda-ce4d-4fa5-8217-5d0bdcaae620",
        "planning_id": "b2afe537-2778-4fa3-8f05-2008dde4113f",
        "parent_line_id": null,
        "owner_id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
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
      "id": "91f6cbf6-6aee-4abc-8504-80846a60afcd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
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
        "item_id": "0af6f855-57c3-45dd-b7fd-29b4c7823aff",
        "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
        "start_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba",
        "stop_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba",
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
      "id": "b2afe537-2778-4fa3-8f05-2008dde4113f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
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
        "item_id": "8c8c2c89-04b8-4349-8482-7f7a6d4c2720",
        "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99",
        "start_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba",
        "stop_location_id": "f8db80ad-6cbd-425d-ad5a-59f91dccabba",
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
      "id": "7409c6e3-a3fc-44e1-b7d6-1cc1f3882695",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "899cfc79-c204-4188-8b97-a58af8f0671b",
        "planning_id": "91f6cbf6-6aee-4abc-8504-80846a60afcd",
        "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99"
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
      "id": "bc0cbd92-b671-4d54-8512-93cdcf16d7b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1cf0ddee-625a-4b4e-82c4-54cbaffaeb67",
        "planning_id": "91f6cbf6-6aee-4abc-8504-80846a60afcd",
        "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99"
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
      "id": "32e62087-560b-4ff1-bd62-dba8cfa272b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:03+00:00",
        "updated_at": "2023-01-25T12:36:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a35f034e-0c69-4cbf-b244-ce88bd3b8240",
        "planning_id": "91f6cbf6-6aee-4abc-8504-80846a60afcd",
        "order_id": "ab18817b-5620-4a71-9037-c0abf22ecd99"
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
          "order_id": "fed7a73e-f883-4b4b-87c3-7af843328b5b",
          "items": [
            {
              "type": "bundles",
              "id": "d1440681-c5b8-4ccf-8bcb-bf610ec809eb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a35d1d05-f68b-4c34-bb49-556b55275319",
                  "id": "3b2a195d-98fb-4bb8-8cd8-875f7771887a"
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
    "id": "f0ac270c-e6a9-5d87-929d-7b81a6750c3b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fed7a73e-f883-4b4b-87c3-7af843328b5b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fed7a73e-f883-4b4b-87c3-7af843328b5b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "deeb8fb8-1ff6-4b4c-9269-30cbd64e03a5"
          },
          {
            "type": "lines",
            "id": "62b146bd-3a4a-46bd-a704-2baf94db1cd6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5a032dda-fcb4-4b31-a73d-477276ba7f40"
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
      "id": "fed7a73e-f883-4b4b-87c3-7af843328b5b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-25T12:36:05+00:00",
        "updated_at": "2023-01-25T12:36:06+00:00",
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
        "starts_at": "2023-01-23T12:30:00+00:00",
        "stops_at": "2023-01-27T12:30:00+00:00",
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
        "start_location_id": "22aa094d-00a4-4fc8-a212-467ba7d2dcc1",
        "stop_location_id": "22aa094d-00a4-4fc8-a212-467ba7d2dcc1"
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
      "id": "deeb8fb8-1ff6-4b4c-9269-30cbd64e03a5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-25T12:36:05+00:00",
        "updated_at": "2023-01-25T12:36:05+00:00",
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
        "item_id": "d1440681-c5b8-4ccf-8bcb-bf610ec809eb",
        "tax_category_id": null,
        "planning_id": "5a032dda-fcb4-4b31-a73d-477276ba7f40",
        "parent_line_id": null,
        "owner_id": "fed7a73e-f883-4b4b-87c3-7af843328b5b",
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
      "id": "62b146bd-3a4a-46bd-a704-2baf94db1cd6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-25T12:36:05+00:00",
        "updated_at": "2023-01-25T12:36:05+00:00",
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
        "item_id": "3b2a195d-98fb-4bb8-8cd8-875f7771887a",
        "tax_category_id": null,
        "planning_id": "7114f5a1-0385-401f-b318-d4c1c6f81bc4",
        "parent_line_id": "deeb8fb8-1ff6-4b4c-9269-30cbd64e03a5",
        "owner_id": "fed7a73e-f883-4b4b-87c3-7af843328b5b",
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
      "id": "5a032dda-fcb4-4b31-a73d-477276ba7f40",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-25T12:36:05+00:00",
        "updated_at": "2023-01-25T12:36:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-23T12:30:00+00:00",
        "stops_at": "2023-01-27T12:30:00+00:00",
        "reserved_from": "2023-01-23T12:30:00+00:00",
        "reserved_till": "2023-01-27T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d1440681-c5b8-4ccf-8bcb-bf610ec809eb",
        "order_id": "fed7a73e-f883-4b4b-87c3-7af843328b5b",
        "start_location_id": "22aa094d-00a4-4fc8-a212-467ba7d2dcc1",
        "stop_location_id": "22aa094d-00a4-4fc8-a212-467ba7d2dcc1",
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





