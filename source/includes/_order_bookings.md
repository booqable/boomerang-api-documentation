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
          "order_id": "e9511b8f-cb48-40a2-b11c-d935475ca72b",
          "items": [
            {
              "type": "products",
              "id": "52a44471-1542-436d-a16d-bf9b75e898a1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d4267f18-ea12-44aa-8afc-532d1310bb03",
              "stock_item_ids": [
                "3fe61926-efae-41d5-b4c9-012ae2bdee07",
                "90297d00-0473-4bee-9b3c-ecb1a310f0e1"
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
            "item_id": "52a44471-1542-436d-a16d-bf9b75e898a1",
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
          "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
          "items": [
            {
              "type": "products",
              "id": "a81569af-38a9-480a-a94d-c170c392ccb2",
              "stock_item_ids": [
                "de513bc1-6ba3-4d01-802e-3fd706049b1f",
                "377428a2-bf34-4c9d-8e0f-f7db2a96d01e",
                "2ac3b527-4806-46b8-ae5a-203a8196d4e9"
              ]
            },
            {
              "type": "products",
              "id": "e56e3b04-34a1-43e1-9205-21ee94ad69c7",
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
    "id": "d9e81c99-4c12-5c47-93e1-fc2e01ba4354",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "757b053a-c091-4f63-812f-c0d0069079a9"
          },
          {
            "type": "lines",
            "id": "965216c6-7d72-4cea-a793-4cce65f28f55"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21"
          },
          {
            "type": "plannings",
            "id": "b085d057-4e72-4368-a5cf-36947175f2c7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "08f0cdc1-efb1-456d-ac18-54dd7a1da9e3"
          },
          {
            "type": "stock_item_plannings",
            "id": "a6babdbb-264b-4809-9405-6ffb04892b72"
          },
          {
            "type": "stock_item_plannings",
            "id": "b98120e0-d52e-4687-a0b5-8c7eb53a74cd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T08:16:01+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
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
        "customer_id": "9d6f3dad-ecd9-49e4-ae6b-0290a85ba467",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725",
        "stop_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725"
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
      "id": "757b053a-c091-4f63-812f-c0d0069079a9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
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
        "item_id": "a81569af-38a9-480a-a94d-c170c392ccb2",
        "tax_category_id": "957d6724-1cea-403b-b09c-cc79ac8c65c9",
        "planning_id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21",
        "parent_line_id": null,
        "owner_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
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
      "id": "965216c6-7d72-4cea-a793-4cce65f28f55",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
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
        "item_id": "e56e3b04-34a1-43e1-9205-21ee94ad69c7",
        "tax_category_id": "957d6724-1cea-403b-b09c-cc79ac8c65c9",
        "planning_id": "b085d057-4e72-4368-a5cf-36947175f2c7",
        "parent_line_id": null,
        "owner_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
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
      "id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
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
        "item_id": "a81569af-38a9-480a-a94d-c170c392ccb2",
        "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
        "start_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725",
        "stop_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725",
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
      "id": "b085d057-4e72-4368-a5cf-36947175f2c7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
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
        "item_id": "e56e3b04-34a1-43e1-9205-21ee94ad69c7",
        "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b",
        "start_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725",
        "stop_location_id": "5c0c5170-966c-4170-a9b6-5bbb832a6725",
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
      "id": "08f0cdc1-efb1-456d-ac18-54dd7a1da9e3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "de513bc1-6ba3-4d01-802e-3fd706049b1f",
        "planning_id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21",
        "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b"
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
      "id": "a6babdbb-264b-4809-9405-6ffb04892b72",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "377428a2-bf34-4c9d-8e0f-f7db2a96d01e",
        "planning_id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21",
        "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b"
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
      "id": "b98120e0-d52e-4687-a0b5-8c7eb53a74cd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:03+00:00",
        "updated_at": "2023-02-13T08:16:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2ac3b527-4806-46b8-ae5a-203a8196d4e9",
        "planning_id": "1ce2cf89-812d-4e4d-8ade-03bea768cb21",
        "order_id": "ffe038ab-ebd9-428a-86c1-6210f9ea013b"
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
          "order_id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb",
          "items": [
            {
              "type": "bundles",
              "id": "780f820d-ae5b-45b2-9e54-c95cbb39d7e5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3b0932ea-d170-4a25-b4cd-751fd002c6d4",
                  "id": "d15dc823-f965-4346-8f63-9c43073482af"
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
    "id": "945a858c-81da-55a5-9db6-02e8f9522c7c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6eb28525-a970-451d-83e9-6793f490d534"
          },
          {
            "type": "lines",
            "id": "117e143a-55e4-4286-9562-024bbf5afd01"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "16e5cbfe-3429-488f-89f4-55f03a90bc6a"
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
      "id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T08:16:05+00:00",
        "updated_at": "2023-02-13T08:16:06+00:00",
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
        "starts_at": "2023-02-11T08:15:00+00:00",
        "stops_at": "2023-02-15T08:15:00+00:00",
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
        "start_location_id": "ef8fd76e-6476-42fb-ab02-89cd30819f47",
        "stop_location_id": "ef8fd76e-6476-42fb-ab02-89cd30819f47"
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
      "id": "6eb28525-a970-451d-83e9-6793f490d534",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T08:16:06+00:00",
        "updated_at": "2023-02-13T08:16:06+00:00",
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
        "item_id": "780f820d-ae5b-45b2-9e54-c95cbb39d7e5",
        "tax_category_id": null,
        "planning_id": "16e5cbfe-3429-488f-89f4-55f03a90bc6a",
        "parent_line_id": null,
        "owner_id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb",
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
      "id": "117e143a-55e4-4286-9562-024bbf5afd01",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T08:16:06+00:00",
        "updated_at": "2023-02-13T08:16:06+00:00",
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
        "item_id": "d15dc823-f965-4346-8f63-9c43073482af",
        "tax_category_id": null,
        "planning_id": "7bd26808-4d56-4004-8f21-f1f61eb64958",
        "parent_line_id": "6eb28525-a970-451d-83e9-6793f490d534",
        "owner_id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb",
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
      "id": "16e5cbfe-3429-488f-89f4-55f03a90bc6a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T08:16:06+00:00",
        "updated_at": "2023-02-13T08:16:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-11T08:15:00+00:00",
        "stops_at": "2023-02-15T08:15:00+00:00",
        "reserved_from": "2023-02-11T08:15:00+00:00",
        "reserved_till": "2023-02-15T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "780f820d-ae5b-45b2-9e54-c95cbb39d7e5",
        "order_id": "3dd727eb-faf4-4ceb-a876-d28efb1b6cdb",
        "start_location_id": "ef8fd76e-6476-42fb-ab02-89cd30819f47",
        "stop_location_id": "ef8fd76e-6476-42fb-ab02-89cd30819f47",
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





