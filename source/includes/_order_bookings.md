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
          "order_id": "a90c3182-ce7e-49c2-82fa-4c0331784431",
          "items": [
            {
              "type": "products",
              "id": "fd11be97-b126-4ff4-9de0-cc2eeb03a2f9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8ac89428-e130-471f-b355-0db0d2059265",
              "stock_item_ids": [
                "3bb91a27-3d65-4694-9eea-95f118a322bc",
                "239f9332-9e1f-42a1-b0fa-fa6ca07c53af"
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
          "stock_item_id 3bb91a27-3d65-4694-9eea-95f118a322bc has already been booked on this order"
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
          "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
          "items": [
            {
              "type": "products",
              "id": "cce5beb8-8a61-4702-ad18-6ae4f028195d",
              "stock_item_ids": [
                "cbdd7856-f067-49b3-85a8-5650be56c19f",
                "72662303-fce6-4f9c-87a7-c1cda7f2d94d",
                "a9235319-e7f6-4db6-a8fb-c18f735a2d3b"
              ]
            },
            {
              "type": "products",
              "id": "10ac9b09-dbf0-4ba8-a29b-eb7241b4757f",
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
    "id": "929268d2-5862-57a8-a496-22de307ff783",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8cabf12d-417a-4ada-9920-b3406c49a3b6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e99b02af-2e42-4607-865f-d2c019539b97"
          },
          {
            "type": "lines",
            "id": "3a20fa1d-6edb-4582-b000-1a1bcadbb10b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2"
          },
          {
            "type": "plannings",
            "id": "501aa66a-30f5-4345-8543-39f6c4fa7c1b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "290e344f-3398-4027-9230-46d081ace5e7"
          },
          {
            "type": "stock_item_plannings",
            "id": "f155c682-8ab8-4f9c-a3e1-d7eaa54cc17e"
          },
          {
            "type": "stock_item_plannings",
            "id": "67dcc56e-86fc-4182-b14a-1812120a826b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T14:49:44+00:00",
        "updated_at": "2023-03-01T14:49:46+00:00",
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
        "customer_id": "8fdb3f06-84cc-4702-af1e-96040ed46cdc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe",
        "stop_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe"
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
      "id": "e99b02af-2e42-4607-865f-d2c019539b97",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:46+00:00",
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
        "item_id": "cce5beb8-8a61-4702-ad18-6ae4f028195d",
        "tax_category_id": "4d383a73-20d4-4991-a9f0-70d0ac547bf0",
        "planning_id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2",
        "parent_line_id": null,
        "owner_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
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
      "id": "3a20fa1d-6edb-4582-b000-1a1bcadbb10b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:46+00:00",
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
        "item_id": "10ac9b09-dbf0-4ba8-a29b-eb7241b4757f",
        "tax_category_id": "4d383a73-20d4-4991-a9f0-70d0ac547bf0",
        "planning_id": "501aa66a-30f5-4345-8543-39f6c4fa7c1b",
        "parent_line_id": null,
        "owner_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
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
      "id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:45+00:00",
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
        "item_id": "cce5beb8-8a61-4702-ad18-6ae4f028195d",
        "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
        "start_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe",
        "stop_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe",
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
      "id": "501aa66a-30f5-4345-8543-39f6c4fa7c1b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:45+00:00",
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
        "item_id": "10ac9b09-dbf0-4ba8-a29b-eb7241b4757f",
        "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6",
        "start_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe",
        "stop_location_id": "f4b8f3e0-ac0f-458e-af03-d0633e5156fe",
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
      "id": "290e344f-3398-4027-9230-46d081ace5e7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cbdd7856-f067-49b3-85a8-5650be56c19f",
        "planning_id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2",
        "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6"
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
      "id": "f155c682-8ab8-4f9c-a3e1-d7eaa54cc17e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "72662303-fce6-4f9c-87a7-c1cda7f2d94d",
        "planning_id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2",
        "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6"
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
      "id": "67dcc56e-86fc-4182-b14a-1812120a826b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:45+00:00",
        "updated_at": "2023-03-01T14:49:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a9235319-e7f6-4db6-a8fb-c18f735a2d3b",
        "planning_id": "49826f5d-966f-4d8b-b2f2-944a059e9ae2",
        "order_id": "8cabf12d-417a-4ada-9920-b3406c49a3b6"
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
          "order_id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386",
          "items": [
            {
              "type": "bundles",
              "id": "6b928328-fc59-445e-ab0f-f5941d541253",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0706c541-6f1d-4390-acad-553cc86adc50",
                  "id": "7ea7a7da-8311-4a40-b9d6-452918fbf6f7"
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
    "id": "b809454e-441e-5d9e-bfdf-4ba5873d2eea",
    "type": "order_bookings",
    "attributes": {
      "order_id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8f44044f-4654-43cb-873c-2a9a63ee445a"
          },
          {
            "type": "lines",
            "id": "f827163e-3740-4a83-a8ef-9ac92ad55005"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5f167913-2c99-42a7-b693-6e78b64e6069"
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
      "id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T14:49:48+00:00",
        "updated_at": "2023-03-01T14:49:48+00:00",
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
        "starts_at": "2023-02-27T14:45:00+00:00",
        "stops_at": "2023-03-03T14:45:00+00:00",
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
        "start_location_id": "5dec3067-9a35-49c5-b07a-ee8d896a4a78",
        "stop_location_id": "5dec3067-9a35-49c5-b07a-ee8d896a4a78"
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
      "id": "8f44044f-4654-43cb-873c-2a9a63ee445a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:49:48+00:00",
        "updated_at": "2023-03-01T14:49:48+00:00",
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
        "item_id": "6b928328-fc59-445e-ab0f-f5941d541253",
        "tax_category_id": null,
        "planning_id": "5f167913-2c99-42a7-b693-6e78b64e6069",
        "parent_line_id": null,
        "owner_id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386",
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
      "id": "f827163e-3740-4a83-a8ef-9ac92ad55005",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:49:48+00:00",
        "updated_at": "2023-03-01T14:49:48+00:00",
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
        "item_id": "7ea7a7da-8311-4a40-b9d6-452918fbf6f7",
        "tax_category_id": null,
        "planning_id": "e1903b11-0a24-46af-8815-26e4f42ec617",
        "parent_line_id": "8f44044f-4654-43cb-873c-2a9a63ee445a",
        "owner_id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386",
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
      "id": "5f167913-2c99-42a7-b693-6e78b64e6069",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:49:48+00:00",
        "updated_at": "2023-03-01T14:49:48+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-27T14:45:00+00:00",
        "stops_at": "2023-03-03T14:45:00+00:00",
        "reserved_from": "2023-02-27T14:45:00+00:00",
        "reserved_till": "2023-03-03T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6b928328-fc59-445e-ab0f-f5941d541253",
        "order_id": "34ac3215-5f72-4f73-ba7e-bf1bd58b5386",
        "start_location_id": "5dec3067-9a35-49c5-b07a-ee8d896a4a78",
        "stop_location_id": "5dec3067-9a35-49c5-b07a-ee8d896a4a78",
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





