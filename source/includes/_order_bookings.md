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
          "order_id": "f84fb6c2-323c-43b4-9980-f56c708903c0",
          "items": [
            {
              "type": "products",
              "id": "b7692625-d240-43bb-97c0-58166ea296dc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6b42bb63-dca8-4185-a140-96a3c9e597ca",
              "stock_item_ids": [
                "f5061764-ab61-4cf3-9cb3-94526fb88501",
                "a1524ce5-0753-44a4-bf62-2fe8a300e5c7"
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
            "item_id": "b7692625-d240-43bb-97c0-58166ea296dc",
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
          "order_id": "eb003380-e641-4155-8761-1fb32f0987c1",
          "items": [
            {
              "type": "products",
              "id": "91d3b593-0c54-47b9-a16a-38a127039c45",
              "stock_item_ids": [
                "379edc7a-237c-4331-8e97-35abd6ae5057",
                "c0b01ff2-448d-42b9-b87c-a8c10a8bdab6",
                "f2a464e7-0274-4f1f-bf8d-9a35c56a78dc"
              ]
            },
            {
              "type": "products",
              "id": "bce7fe4d-8b77-4921-b542-0a2f39746469",
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
    "id": "c6d5173a-c7c7-5be1-86a5-b6c880983ee2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "eb003380-e641-4155-8761-1fb32f0987c1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "eb003380-e641-4155-8761-1fb32f0987c1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3bac5582-9405-4e1d-8489-bf7790cf3583"
          },
          {
            "type": "lines",
            "id": "eb8e603f-2ee5-4b82-ab94-c6730f2b915e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a80bce0e-2e3a-498b-a118-d4b8fde52870"
          },
          {
            "type": "plannings",
            "id": "218f0096-639f-49b3-9751-7ce47e7aa789"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "591d5bd2-e20e-460c-9708-c15011452477"
          },
          {
            "type": "stock_item_plannings",
            "id": "157f92a0-3be8-4dee-982e-96ab32dbc4a2"
          },
          {
            "type": "stock_item_plannings",
            "id": "25370ea3-3924-40f0-8fd7-deb8ae7fb0bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "eb003380-e641-4155-8761-1fb32f0987c1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T15:19:01+00:00",
        "updated_at": "2023-02-07T15:19:03+00:00",
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
        "customer_id": "89e69f48-031b-4fed-ae4e-6800eb85fd43",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617",
        "stop_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617"
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
      "id": "3bac5582-9405-4e1d-8489-bf7790cf3583",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:02+00:00",
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
        "item_id": "91d3b593-0c54-47b9-a16a-38a127039c45",
        "tax_category_id": "4c77617e-7a08-4866-b0c5-1567ea74aada",
        "planning_id": "a80bce0e-2e3a-498b-a118-d4b8fde52870",
        "parent_line_id": null,
        "owner_id": "eb003380-e641-4155-8761-1fb32f0987c1",
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
      "id": "eb8e603f-2ee5-4b82-ab94-c6730f2b915e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:02+00:00",
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
        "item_id": "bce7fe4d-8b77-4921-b542-0a2f39746469",
        "tax_category_id": "4c77617e-7a08-4866-b0c5-1567ea74aada",
        "planning_id": "218f0096-639f-49b3-9751-7ce47e7aa789",
        "parent_line_id": null,
        "owner_id": "eb003380-e641-4155-8761-1fb32f0987c1",
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
      "id": "a80bce0e-2e3a-498b-a118-d4b8fde52870",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:03+00:00",
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
        "item_id": "91d3b593-0c54-47b9-a16a-38a127039c45",
        "order_id": "eb003380-e641-4155-8761-1fb32f0987c1",
        "start_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617",
        "stop_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617",
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
      "id": "218f0096-639f-49b3-9751-7ce47e7aa789",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:03+00:00",
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
        "item_id": "bce7fe4d-8b77-4921-b542-0a2f39746469",
        "order_id": "eb003380-e641-4155-8761-1fb32f0987c1",
        "start_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617",
        "stop_location_id": "8f9269c0-093e-4202-be24-a6c0b5b73617",
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
      "id": "591d5bd2-e20e-460c-9708-c15011452477",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "379edc7a-237c-4331-8e97-35abd6ae5057",
        "planning_id": "a80bce0e-2e3a-498b-a118-d4b8fde52870",
        "order_id": "eb003380-e641-4155-8761-1fb32f0987c1"
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
      "id": "157f92a0-3be8-4dee-982e-96ab32dbc4a2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c0b01ff2-448d-42b9-b87c-a8c10a8bdab6",
        "planning_id": "a80bce0e-2e3a-498b-a118-d4b8fde52870",
        "order_id": "eb003380-e641-4155-8761-1fb32f0987c1"
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
      "id": "25370ea3-3924-40f0-8fd7-deb8ae7fb0bb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:02+00:00",
        "updated_at": "2023-02-07T15:19:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f2a464e7-0274-4f1f-bf8d-9a35c56a78dc",
        "planning_id": "a80bce0e-2e3a-498b-a118-d4b8fde52870",
        "order_id": "eb003380-e641-4155-8761-1fb32f0987c1"
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
          "order_id": "10091eca-3754-4fb2-8ac2-baf2d2338f53",
          "items": [
            {
              "type": "bundles",
              "id": "136960d4-d10c-4ace-b7c4-f6824d28ed46",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c0e1fd86-8c75-4a2a-b89e-624f3acc41b6",
                  "id": "94335f21-4a10-40aa-9cf2-141add563d0b"
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
    "id": "5698f97f-d8bd-57cc-9130-ee70eb757220",
    "type": "order_bookings",
    "attributes": {
      "order_id": "10091eca-3754-4fb2-8ac2-baf2d2338f53"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "10091eca-3754-4fb2-8ac2-baf2d2338f53"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "58867758-07cc-4306-950d-52ee5eb0661f"
          },
          {
            "type": "lines",
            "id": "b4d870fc-986f-46e7-ad4f-d6aebd014af9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cb1910a0-376d-486f-9d65-4a60adebbfc7"
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
      "id": "10091eca-3754-4fb2-8ac2-baf2d2338f53",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T15:19:05+00:00",
        "updated_at": "2023-02-07T15:19:05+00:00",
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
        "starts_at": "2023-02-05T15:15:00+00:00",
        "stops_at": "2023-02-09T15:15:00+00:00",
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
        "start_location_id": "3aeca72f-933c-4733-a0c0-92eefe4dd97f",
        "stop_location_id": "3aeca72f-933c-4733-a0c0-92eefe4dd97f"
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
      "id": "58867758-07cc-4306-950d-52ee5eb0661f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:19:05+00:00",
        "updated_at": "2023-02-07T15:19:05+00:00",
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
        "item_id": "94335f21-4a10-40aa-9cf2-141add563d0b",
        "tax_category_id": null,
        "planning_id": "818b2665-4c2a-4f3c-8ac0-7ba99ed8e3f8",
        "parent_line_id": "b4d870fc-986f-46e7-ad4f-d6aebd014af9",
        "owner_id": "10091eca-3754-4fb2-8ac2-baf2d2338f53",
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
      "id": "b4d870fc-986f-46e7-ad4f-d6aebd014af9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T15:19:05+00:00",
        "updated_at": "2023-02-07T15:19:05+00:00",
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
        "item_id": "136960d4-d10c-4ace-b7c4-f6824d28ed46",
        "tax_category_id": null,
        "planning_id": "cb1910a0-376d-486f-9d65-4a60adebbfc7",
        "parent_line_id": null,
        "owner_id": "10091eca-3754-4fb2-8ac2-baf2d2338f53",
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
      "id": "cb1910a0-376d-486f-9d65-4a60adebbfc7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T15:19:05+00:00",
        "updated_at": "2023-02-07T15:19:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T15:15:00+00:00",
        "stops_at": "2023-02-09T15:15:00+00:00",
        "reserved_from": "2023-02-05T15:15:00+00:00",
        "reserved_till": "2023-02-09T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "136960d4-d10c-4ace-b7c4-f6824d28ed46",
        "order_id": "10091eca-3754-4fb2-8ac2-baf2d2338f53",
        "start_location_id": "3aeca72f-933c-4733-a0c0-92eefe4dd97f",
        "stop_location_id": "3aeca72f-933c-4733-a0c0-92eefe4dd97f",
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





