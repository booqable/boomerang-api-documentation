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
          "order_id": "3818531c-c3b4-4333-93f9-25f4dcc99335",
          "items": [
            {
              "type": "products",
              "id": "c0f36c90-8d1f-46f5-a951-ef3949327fd7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c8800a56-bf32-4c3f-b856-239501139d80",
              "stock_item_ids": [
                "99bd9df9-8908-40e6-81d5-caf7f3c22232",
                "c9973b91-cd02-4577-8570-b7da56596896"
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
            "item_id": "c0f36c90-8d1f-46f5-a951-ef3949327fd7",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "c8800a56-bf32-4c3f-b856-239501139d80",
            "unavailable": [
              "99bd9df9-8908-40e6-81d5-caf7f3c22232"
            ],
            "available": [
              "c9973b91-cd02-4577-8570-b7da56596896"
            ]
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
          "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
          "items": [
            {
              "type": "products",
              "id": "4bde1e7b-395c-49cb-af85-2f6958c1547a",
              "stock_item_ids": [
                "cbab8430-4b1c-4f3c-b5c1-a57425153142",
                "c78774f5-972e-4291-89d8-ab4fe1b3efad",
                "84bf334e-bcd6-4e15-b78e-99f01229cb90"
              ]
            },
            {
              "type": "products",
              "id": "d44cab78-082c-42d1-8141-e052bf45e577",
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
    "id": "64138bcb-80a7-5fc4-973d-687b7b52ca25",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e33645d-8b02-4503-b98f-70a88d5b72bf"
          },
          {
            "type": "lines",
            "id": "2a683ee0-1560-4360-ab10-d6b48051353f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1437f6f0-a512-4eae-95df-96978086eaf6"
          },
          {
            "type": "plannings",
            "id": "b7fe92dd-22c1-47a1-a43d-b9f51b94fb62"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1c98ce60-626b-4e1e-8fc4-645961c136f8"
          },
          {
            "type": "stock_item_plannings",
            "id": "a16f9473-e99c-43e0-8997-9b2bf2a50a14"
          },
          {
            "type": "stock_item_plannings",
            "id": "db1290f1-107e-4844-ae8a-dae0683f5bfb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-30T11:22:13+00:00",
        "updated_at": "2021-12-30T11:22:15+00:00",
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
        "customer_id": "8a3b1559-aa23-437c-bf86-6a4baf4fe057",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d",
        "stop_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d"
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
      "id": "5e33645d-8b02-4503-b98f-70a88d5b72bf",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-30T11:22:13+00:00",
        "updated_at": "2021-12-30T11:22:15+00:00",
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
        "item_id": "d44cab78-082c-42d1-8141-e052bf45e577",
        "tax_category_id": "f4108cec-99b2-4a41-b61e-17cff9083460",
        "parent_line_id": null,
        "owner_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
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
      "id": "2a683ee0-1560-4360-ab10-d6b48051353f",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-30T11:22:14+00:00",
        "updated_at": "2021-12-30T11:22:15+00:00",
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
        "item_id": "4bde1e7b-395c-49cb-af85-2f6958c1547a",
        "tax_category_id": "f4108cec-99b2-4a41-b61e-17cff9083460",
        "parent_line_id": null,
        "owner_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
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
      "id": "1437f6f0-a512-4eae-95df-96978086eaf6",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:13+00:00",
        "updated_at": "2021-12-30T11:22:14+00:00",
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
        "item_id": "d44cab78-082c-42d1-8141-e052bf45e577",
        "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
        "start_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d",
        "stop_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d",
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
      "id": "b7fe92dd-22c1-47a1-a43d-b9f51b94fb62",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:14+00:00",
        "updated_at": "2021-12-30T11:22:14+00:00",
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
        "item_id": "4bde1e7b-395c-49cb-af85-2f6958c1547a",
        "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a",
        "start_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d",
        "stop_location_id": "bb1a24a5-c294-46f4-82d0-0306ffd9983d",
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
      "id": "1c98ce60-626b-4e1e-8fc4-645961c136f8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:14+00:00",
        "updated_at": "2021-12-30T11:22:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cbab8430-4b1c-4f3c-b5c1-a57425153142",
        "planning_id": "b7fe92dd-22c1-47a1-a43d-b9f51b94fb62",
        "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a"
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
      "id": "a16f9473-e99c-43e0-8997-9b2bf2a50a14",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:14+00:00",
        "updated_at": "2021-12-30T11:22:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c78774f5-972e-4291-89d8-ab4fe1b3efad",
        "planning_id": "b7fe92dd-22c1-47a1-a43d-b9f51b94fb62",
        "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a"
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
      "id": "db1290f1-107e-4844-ae8a-dae0683f5bfb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:14+00:00",
        "updated_at": "2021-12-30T11:22:14+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "84bf334e-bcd6-4e15-b78e-99f01229cb90",
        "planning_id": "b7fe92dd-22c1-47a1-a43d-b9f51b94fb62",
        "order_id": "f6cb4c2b-b27b-46a9-8366-fcba193d147a"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=4bde1e7b-395c-49cb-af85-2f6958c1547a&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=cbab8430-4b1c-4f3c-b5c1-a57425153142&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=c78774f5-972e-4291-89d8-ab4fe1b3efad&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=84bf334e-bcd6-4e15-b78e-99f01229cb90&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d44cab78-082c-42d1-8141-e052bf45e577&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f6cb4c2b-b27b-46a9-8366-fcba193d147a&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "1f70eaac-b097-4328-8575-aaed02e546ec",
          "items": [
            {
              "type": "bundles",
              "id": "da66bfe7-a624-4b3b-af4b-b6f79395bd21",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5",
                  "id": "da92446e-67f5-4e67-81d8-36a6a4143b42"
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
    "id": "3f0ec51f-f783-55dd-8bc7-a9c05373fbbb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1f70eaac-b097-4328-8575-aaed02e546ec"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1f70eaac-b097-4328-8575-aaed02e546ec"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "862c0004-19d3-4b5e-810d-de041f571493"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "31adb35c-e9ea-4e32-93d9-e1ab1e556c68"
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
      "id": "1f70eaac-b097-4328-8575-aaed02e546ec",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-30T11:22:17+00:00",
        "updated_at": "2021-12-30T11:22:18+00:00",
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
        "starts_at": "2021-12-28T11:15:00+00:00",
        "stops_at": "2022-01-01T11:15:00+00:00",
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
        "start_location_id": "9ba476d5-a4c3-4b9e-87a0-49e5073b4681",
        "stop_location_id": "9ba476d5-a4c3-4b9e-87a0-49e5073b4681"
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
      "id": "862c0004-19d3-4b5e-810d-de041f571493",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-30T11:22:18+00:00",
        "updated_at": "2021-12-30T11:22:18+00:00",
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
        "item_id": "da66bfe7-a624-4b3b-af4b-b6f79395bd21",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "1f70eaac-b097-4328-8575-aaed02e546ec",
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
      "id": "31adb35c-e9ea-4e32-93d9-e1ab1e556c68",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-30T11:22:18+00:00",
        "updated_at": "2021-12-30T11:22:18+00:00",
        "quantity": 1,
        "starts_at": "2021-12-28T11:15:00+00:00",
        "stops_at": "2022-01-01T11:15:00+00:00",
        "reserved_from": "2021-12-28T11:15:00+00:00",
        "reserved_till": "2022-01-01T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "da66bfe7-a624-4b3b-af4b-b6f79395bd21",
        "order_id": "1f70eaac-b097-4328-8575-aaed02e546ec",
        "start_location_id": "9ba476d5-a4c3-4b9e-87a0-49e5073b4681",
        "stop_location_id": "9ba476d5-a4c3-4b9e-87a0-49e5073b4681",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&data%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&data%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&data%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&data%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=da66bfe7-a624-4b3b-af4b-b6f79395bd21&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=f2dcd5f5-e4f0-458d-b02e-ca57fefdb8f5&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=da92446e-67f5-4e67-81d8-36a6a4143b42&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=1f70eaac-b097-4328-8575-aaed02e546ec&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





