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
          "order_id": "6f8d1b4c-e921-45f2-bc19-047cc4aac5ab",
          "items": [
            {
              "type": "products",
              "id": "1171c3f5-edc9-4e40-92d7-716355210a5e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "89a8e922-73a2-4765-9db7-719e88c0e723",
              "stock_item_ids": [
                "7033aaba-1ea4-4360-a64f-382d0235452b",
                "cca3ebab-87a9-4d90-8073-a83b5ed7cd38"
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
            "item_id": "1171c3f5-edc9-4e40-92d7-716355210a5e",
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
          "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
          "items": [
            {
              "type": "products",
              "id": "849e7bc6-f687-4453-95bd-78fe4e37fb4e",
              "stock_item_ids": [
                "4a3216e7-6b9c-4a94-8983-dfb0346e0b34",
                "97c1e257-f659-42f4-b59e-cc08f5523e2d",
                "b9d429a1-5bd6-47b0-acac-39206b58a7b5"
              ]
            },
            {
              "type": "products",
              "id": "fb44c2b5-a7c5-4e96-ba10-7b4f392230ea",
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
    "id": "9374cc71-dbba-522f-b006-ebb8b9784c70",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bd3fec52-04b1-4820-9e59-7515e64c1dca"
          },
          {
            "type": "lines",
            "id": "4f052ac0-8411-4ff4-ae8a-b1346eaa89f7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6"
          },
          {
            "type": "plannings",
            "id": "8c7d3c21-c11b-4635-99a2-7b189dcc8369"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "286b26df-8bd4-4843-bbbb-31e08a1f1c89"
          },
          {
            "type": "stock_item_plannings",
            "id": "1865eea8-7cb0-4474-9b54-2a47159555c3"
          },
          {
            "type": "stock_item_plannings",
            "id": "de56641f-ba2e-4df0-988b-0cf83c4f0196"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T13:33:13+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
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
        "customer_id": "de129e4c-339a-4c3d-aff4-634b3fc41a3d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326",
        "stop_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326"
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
      "id": "bd3fec52-04b1-4820-9e59-7515e64c1dca",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
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
        "item_id": "849e7bc6-f687-4453-95bd-78fe4e37fb4e",
        "tax_category_id": "d960e4fd-56a0-41eb-b6c1-5c476422c31a",
        "planning_id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6",
        "parent_line_id": null,
        "owner_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
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
      "id": "4f052ac0-8411-4ff4-ae8a-b1346eaa89f7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
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
        "item_id": "fb44c2b5-a7c5-4e96-ba10-7b4f392230ea",
        "tax_category_id": "d960e4fd-56a0-41eb-b6c1-5c476422c31a",
        "planning_id": "8c7d3c21-c11b-4635-99a2-7b189dcc8369",
        "parent_line_id": null,
        "owner_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
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
      "id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
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
        "item_id": "849e7bc6-f687-4453-95bd-78fe4e37fb4e",
        "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
        "start_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326",
        "stop_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326",
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
      "id": "8c7d3c21-c11b-4635-99a2-7b189dcc8369",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
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
        "item_id": "fb44c2b5-a7c5-4e96-ba10-7b4f392230ea",
        "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d",
        "start_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326",
        "stop_location_id": "11a63bc3-fd71-4367-9ccc-f51ed5306326",
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
      "id": "286b26df-8bd4-4843-bbbb-31e08a1f1c89",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4a3216e7-6b9c-4a94-8983-dfb0346e0b34",
        "planning_id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6",
        "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d"
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
      "id": "1865eea8-7cb0-4474-9b54-2a47159555c3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "97c1e257-f659-42f4-b59e-cc08f5523e2d",
        "planning_id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6",
        "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d"
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
      "id": "de56641f-ba2e-4df0-988b-0cf83c4f0196",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:15+00:00",
        "updated_at": "2023-02-01T13:33:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b9d429a1-5bd6-47b0-acac-39206b58a7b5",
        "planning_id": "e7e9a75d-5553-4f8c-9083-24a93c4b5de6",
        "order_id": "6d959544-3ac0-4d45-8ff9-ac9242eb247d"
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
          "order_id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418",
          "items": [
            {
              "type": "bundles",
              "id": "988f2273-b3b9-4ecf-bc04-edaff5714ed9",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ca365ec5-85f0-45be-ae93-baec1b4902ea",
                  "id": "d0e2418b-191c-40d2-bb0f-49b799c6e49e"
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
    "id": "bba1eda3-045a-5605-b79e-7a548d5ee894",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1c19a798-42c4-4c61-b17f-5f1c568dbd59"
          },
          {
            "type": "lines",
            "id": "fe2fcbfe-6412-4afc-b677-52a18560ecd9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "87087538-9d8a-4df1-ba2e-c7fdca046484"
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
      "id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-01T13:33:17+00:00",
        "updated_at": "2023-02-01T13:33:18+00:00",
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
        "starts_at": "2023-01-30T13:30:00+00:00",
        "stops_at": "2023-02-03T13:30:00+00:00",
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
        "start_location_id": "fd111cfd-67ca-401d-a224-cbed5fba2edb",
        "stop_location_id": "fd111cfd-67ca-401d-a224-cbed5fba2edb"
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
      "id": "1c19a798-42c4-4c61-b17f-5f1c568dbd59",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:33:18+00:00",
        "updated_at": "2023-02-01T13:33:18+00:00",
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
        "item_id": "988f2273-b3b9-4ecf-bc04-edaff5714ed9",
        "tax_category_id": null,
        "planning_id": "87087538-9d8a-4df1-ba2e-c7fdca046484",
        "parent_line_id": null,
        "owner_id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418",
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
      "id": "fe2fcbfe-6412-4afc-b677-52a18560ecd9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-01T13:33:18+00:00",
        "updated_at": "2023-02-01T13:33:18+00:00",
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
        "item_id": "d0e2418b-191c-40d2-bb0f-49b799c6e49e",
        "tax_category_id": null,
        "planning_id": "be475cd1-f454-4a65-81f2-9d67ba37e269",
        "parent_line_id": "1c19a798-42c4-4c61-b17f-5f1c568dbd59",
        "owner_id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418",
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
      "id": "87087538-9d8a-4df1-ba2e-c7fdca046484",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-01T13:33:18+00:00",
        "updated_at": "2023-02-01T13:33:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-30T13:30:00+00:00",
        "stops_at": "2023-02-03T13:30:00+00:00",
        "reserved_from": "2023-01-30T13:30:00+00:00",
        "reserved_till": "2023-02-03T13:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "988f2273-b3b9-4ecf-bc04-edaff5714ed9",
        "order_id": "5d0b5a9a-a65d-4c5b-ac9c-d0e2fdc74418",
        "start_location_id": "fd111cfd-67ca-401d-a224-cbed5fba2edb",
        "stop_location_id": "fd111cfd-67ca-401d-a224-cbed5fba2edb",
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





