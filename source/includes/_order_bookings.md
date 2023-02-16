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
          "order_id": "8ed22af5-e72d-4146-b907-83f2f428a2ee",
          "items": [
            {
              "type": "products",
              "id": "d56386fa-971f-4bad-a609-eb12638f7275",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "53f39264-fc42-44d5-b87f-76ef684e68b6",
              "stock_item_ids": [
                "908a5155-0eb0-4421-9fb9-783c798d89d8",
                "54f49c0d-8f75-4d21-a948-d713754abf2f"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 908a5155-0eb0-4421-9fb9-783c798d89d8 has already been booked on this order"
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
          "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
          "items": [
            {
              "type": "products",
              "id": "403d9790-510d-423c-86c0-03f11a7ed328",
              "stock_item_ids": [
                "f56bb469-1f35-42f1-a62e-07d46be81116",
                "433f6d08-fa27-4731-b7f5-985012e62157",
                "2098c131-fd9e-47a6-a7af-92a408364f86"
              ]
            },
            {
              "type": "products",
              "id": "d7da97b5-629b-40d0-bb4e-797fed03e927",
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
    "id": "f87cb5fc-d6f5-56fd-a750-e5fea136f6a1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ceccfd35-3586-4654-822e-96efa3f1a34f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "101b502b-4677-4c98-af05-8c8b1ebbc5a4"
          },
          {
            "type": "lines",
            "id": "dd132e5d-16ba-4178-a593-1aee7de9e02b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5"
          },
          {
            "type": "plannings",
            "id": "69dd97ed-29f1-495f-9fb1-a9c827b6a099"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fe7e856a-2ccb-49b4-9029-6b2f0b90c859"
          },
          {
            "type": "stock_item_plannings",
            "id": "8022b773-8d5c-4377-b451-a9af21fb5e53"
          },
          {
            "type": "stock_item_plannings",
            "id": "5c0e6185-2a97-438f-b1f8-f7d41af5b7b8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T09:22:21+00:00",
        "updated_at": "2023-02-16T09:22:23+00:00",
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
        "customer_id": "74200313-ed22-48da-b7e0-dfad5bb44902",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326",
        "stop_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326"
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
      "id": "101b502b-4677-4c98-af05-8c8b1ebbc5a4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:23+00:00",
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
        "item_id": "403d9790-510d-423c-86c0-03f11a7ed328",
        "tax_category_id": "8a0fec4e-70b3-4a09-af4e-4a4487720d35",
        "planning_id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5",
        "parent_line_id": null,
        "owner_id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
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
      "id": "dd132e5d-16ba-4178-a593-1aee7de9e02b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:23+00:00",
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
        "item_id": "d7da97b5-629b-40d0-bb4e-797fed03e927",
        "tax_category_id": "8a0fec4e-70b3-4a09-af4e-4a4487720d35",
        "planning_id": "69dd97ed-29f1-495f-9fb1-a9c827b6a099",
        "parent_line_id": null,
        "owner_id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
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
      "id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:22+00:00",
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
        "item_id": "403d9790-510d-423c-86c0-03f11a7ed328",
        "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
        "start_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326",
        "stop_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326",
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
      "id": "69dd97ed-29f1-495f-9fb1-a9c827b6a099",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:22+00:00",
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
        "item_id": "d7da97b5-629b-40d0-bb4e-797fed03e927",
        "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f",
        "start_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326",
        "stop_location_id": "5f5d9b69-963d-481f-9966-ef523d30c326",
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
      "id": "fe7e856a-2ccb-49b4-9029-6b2f0b90c859",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f56bb469-1f35-42f1-a62e-07d46be81116",
        "planning_id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5",
        "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f"
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
      "id": "8022b773-8d5c-4377-b451-a9af21fb5e53",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "433f6d08-fa27-4731-b7f5-985012e62157",
        "planning_id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5",
        "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f"
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
      "id": "5c0e6185-2a97-438f-b1f8-f7d41af5b7b8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:22+00:00",
        "updated_at": "2023-02-16T09:22:22+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2098c131-fd9e-47a6-a7af-92a408364f86",
        "planning_id": "f5c4f08b-c402-48b6-b0f1-588f5a11d1b5",
        "order_id": "ceccfd35-3586-4654-822e-96efa3f1a34f"
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
          "order_id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a",
          "items": [
            {
              "type": "bundles",
              "id": "541d4ff5-6c47-4783-ac3d-c4d387f0e6a3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6e5b1f66-b1df-4d60-b778-a1a3c75200c6",
                  "id": "621af3c0-ad7f-475e-9b73-2f1e2dcb505d"
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
    "id": "2dd258c4-994c-53bf-bfb8-7343f9cba33e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4daba684-02e3-490b-90fd-6528b8941fe4"
          },
          {
            "type": "lines",
            "id": "5a88de7b-091b-4de7-87d1-ee71c4415dc4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3f1d1a49-91fb-4ff5-a056-1ea9e88ac51b"
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
      "id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T09:22:25+00:00",
        "updated_at": "2023-02-16T09:22:26+00:00",
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
        "starts_at": "2023-02-14T09:15:00+00:00",
        "stops_at": "2023-02-18T09:15:00+00:00",
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
        "start_location_id": "0afea70e-9d97-4f9e-9447-b7f30824794d",
        "stop_location_id": "0afea70e-9d97-4f9e-9447-b7f30824794d"
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
      "id": "4daba684-02e3-490b-90fd-6528b8941fe4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:22:26+00:00",
        "updated_at": "2023-02-16T09:22:26+00:00",
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
        "item_id": "621af3c0-ad7f-475e-9b73-2f1e2dcb505d",
        "tax_category_id": null,
        "planning_id": "1759902b-dbaa-42be-b609-d21bc06d0be9",
        "parent_line_id": "5a88de7b-091b-4de7-87d1-ee71c4415dc4",
        "owner_id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a",
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
      "id": "5a88de7b-091b-4de7-87d1-ee71c4415dc4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:22:26+00:00",
        "updated_at": "2023-02-16T09:22:26+00:00",
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
        "item_id": "541d4ff5-6c47-4783-ac3d-c4d387f0e6a3",
        "tax_category_id": null,
        "planning_id": "3f1d1a49-91fb-4ff5-a056-1ea9e88ac51b",
        "parent_line_id": null,
        "owner_id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a",
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
      "id": "3f1d1a49-91fb-4ff5-a056-1ea9e88ac51b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:22:26+00:00",
        "updated_at": "2023-02-16T09:22:26+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T09:15:00+00:00",
        "stops_at": "2023-02-18T09:15:00+00:00",
        "reserved_from": "2023-02-14T09:15:00+00:00",
        "reserved_till": "2023-02-18T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "541d4ff5-6c47-4783-ac3d-c4d387f0e6a3",
        "order_id": "0ff19bc0-6007-46ab-8867-b80b6ff45a2a",
        "start_location_id": "0afea70e-9d97-4f9e-9447-b7f30824794d",
        "stop_location_id": "0afea70e-9d97-4f9e-9447-b7f30824794d",
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





