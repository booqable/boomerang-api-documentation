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
          "order_id": "583dcedd-e23f-4d92-88b9-21c7f635ac6f",
          "items": [
            {
              "type": "products",
              "id": "170bf55d-5bb2-4bc6-8fab-f57e96a7d6ca",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8c669fc9-ec8a-48e5-b726-f9b0bcdba8b7",
              "stock_item_ids": [
                "97fe87af-c8c6-414d-8d4b-8c08fc9f01b3",
                "bc4baf43-7168-411f-91c8-f9ca6b21a34d"
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
            "item_id": "170bf55d-5bb2-4bc6-8fab-f57e96a7d6ca",
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
          "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
          "items": [
            {
              "type": "products",
              "id": "34fcb374-f3bc-4dd4-ae10-64e2c131ed7e",
              "stock_item_ids": [
                "affaca1b-7c5c-4892-8031-e31d59d07d91",
                "cce161b0-c36a-415d-956b-3a89beb9e3a4",
                "f62e0d9c-cb01-4b17-81f1-7c2a731a7d24"
              ]
            },
            {
              "type": "products",
              "id": "a6481d5e-c6ef-4b14-92ad-0273bc767e2b",
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
    "id": "01af3bc1-cf2f-59ac-89f3-fcae22413ee5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b9c2a2a2-70f3-40e8-9a30-bd63fff28758"
          },
          {
            "type": "lines",
            "id": "b054ceda-fc4a-4585-8efe-141d76129c15"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "df39659b-a27e-41dc-81f4-23e196d4dc0a"
          },
          {
            "type": "plannings",
            "id": "97fb8e75-4b66-4bb6-90bf-1db5ef69309e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "285d8020-250b-4948-9722-344a9edfa44f"
          },
          {
            "type": "stock_item_plannings",
            "id": "68e0870e-839e-4b6f-879f-1394a44cbddb"
          },
          {
            "type": "stock_item_plannings",
            "id": "f2d7b0f2-6e1c-4ff8-b95a-1dcbedc7ab5b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T14:01:44+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
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
        "customer_id": "b26d7db7-894f-455b-aac4-3e3f398ee6a0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1",
        "stop_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1"
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
      "id": "b9c2a2a2-70f3-40e8-9a30-bd63fff28758",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
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
        "item_id": "34fcb374-f3bc-4dd4-ae10-64e2c131ed7e",
        "tax_category_id": "a06ce71b-c6de-40fa-a93b-1deb7e03c574",
        "planning_id": "df39659b-a27e-41dc-81f4-23e196d4dc0a",
        "parent_line_id": null,
        "owner_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
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
      "id": "b054ceda-fc4a-4585-8efe-141d76129c15",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
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
        "item_id": "a6481d5e-c6ef-4b14-92ad-0273bc767e2b",
        "tax_category_id": "a06ce71b-c6de-40fa-a93b-1deb7e03c574",
        "planning_id": "97fb8e75-4b66-4bb6-90bf-1db5ef69309e",
        "parent_line_id": null,
        "owner_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
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
      "id": "df39659b-a27e-41dc-81f4-23e196d4dc0a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
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
        "item_id": "34fcb374-f3bc-4dd4-ae10-64e2c131ed7e",
        "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
        "start_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1",
        "stop_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1",
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
      "id": "97fb8e75-4b66-4bb6-90bf-1db5ef69309e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
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
        "item_id": "a6481d5e-c6ef-4b14-92ad-0273bc767e2b",
        "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e",
        "start_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1",
        "stop_location_id": "e1c3f149-d95e-4746-b774-93aa2a6523c1",
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
      "id": "285d8020-250b-4948-9722-344a9edfa44f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "affaca1b-7c5c-4892-8031-e31d59d07d91",
        "planning_id": "df39659b-a27e-41dc-81f4-23e196d4dc0a",
        "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e"
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
      "id": "68e0870e-839e-4b6f-879f-1394a44cbddb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cce161b0-c36a-415d-956b-3a89beb9e3a4",
        "planning_id": "df39659b-a27e-41dc-81f4-23e196d4dc0a",
        "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e"
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
      "id": "f2d7b0f2-6e1c-4ff8-b95a-1dcbedc7ab5b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:45+00:00",
        "updated_at": "2023-01-24T14:01:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f62e0d9c-cb01-4b17-81f1-7c2a731a7d24",
        "planning_id": "df39659b-a27e-41dc-81f4-23e196d4dc0a",
        "order_id": "dafb725a-d857-40d9-ba6d-1e71ca40c76e"
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
          "order_id": "dbd6c6f5-feef-453d-acd7-adf263699623",
          "items": [
            {
              "type": "bundles",
              "id": "a3f3cb69-1a77-44a0-83e4-6fa29f2f612a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4aaea496-a0c3-4962-afa4-b57c1b1fc0ac",
                  "id": "9d870804-ea28-4502-a642-b6daa1e44b48"
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
    "id": "681e891d-495c-52fc-89fc-8244f96a5587",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dbd6c6f5-feef-453d-acd7-adf263699623"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dbd6c6f5-feef-453d-acd7-adf263699623"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "26638c16-9da6-41b8-8131-dcd3ce03dfc9"
          },
          {
            "type": "lines",
            "id": "f8d2c7be-c4ca-48db-b734-af68f171e941"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b7c0770a-e4d7-4982-8c8f-6bd9da511448"
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
      "id": "dbd6c6f5-feef-453d-acd7-adf263699623",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T14:01:47+00:00",
        "updated_at": "2023-01-24T14:01:48+00:00",
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
        "starts_at": "2023-01-22T14:00:00+00:00",
        "stops_at": "2023-01-26T14:00:00+00:00",
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
        "start_location_id": "6d694c18-73c2-458f-87ed-acb9afb4a200",
        "stop_location_id": "6d694c18-73c2-458f-87ed-acb9afb4a200"
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
      "id": "26638c16-9da6-41b8-8131-dcd3ce03dfc9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:48+00:00",
        "updated_at": "2023-01-24T14:01:48+00:00",
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
        "item_id": "9d870804-ea28-4502-a642-b6daa1e44b48",
        "tax_category_id": null,
        "planning_id": "3914be21-9696-486f-bdf7-a740edae3646",
        "parent_line_id": "f8d2c7be-c4ca-48db-b734-af68f171e941",
        "owner_id": "dbd6c6f5-feef-453d-acd7-adf263699623",
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
      "id": "f8d2c7be-c4ca-48db-b734-af68f171e941",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:48+00:00",
        "updated_at": "2023-01-24T14:01:48+00:00",
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
        "item_id": "a3f3cb69-1a77-44a0-83e4-6fa29f2f612a",
        "tax_category_id": null,
        "planning_id": "b7c0770a-e4d7-4982-8c8f-6bd9da511448",
        "parent_line_id": null,
        "owner_id": "dbd6c6f5-feef-453d-acd7-adf263699623",
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
      "id": "b7c0770a-e4d7-4982-8c8f-6bd9da511448",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:48+00:00",
        "updated_at": "2023-01-24T14:01:48+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-22T14:00:00+00:00",
        "stops_at": "2023-01-26T14:00:00+00:00",
        "reserved_from": "2023-01-22T14:00:00+00:00",
        "reserved_till": "2023-01-26T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a3f3cb69-1a77-44a0-83e4-6fa29f2f612a",
        "order_id": "dbd6c6f5-feef-453d-acd7-adf263699623",
        "start_location_id": "6d694c18-73c2-458f-87ed-acb9afb4a200",
        "stop_location_id": "6d694c18-73c2-458f-87ed-acb9afb4a200",
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





