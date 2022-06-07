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
          "order_id": "68206aad-7109-43e7-90f1-5fd93425b21d",
          "items": [
            {
              "type": "products",
              "id": "0d0824c8-2d14-495b-a18f-585ab0ed9559",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f0e74af9-7af2-4bee-8c66-15fd7f657060",
              "stock_item_ids": [
                "096ad469-5008-4352-b3c5-c32943416807",
                "442b6b0d-b19a-4b55-9e9d-d939c8aad943"
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
            "item_id": "0d0824c8-2d14-495b-a18f-585ab0ed9559",
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
          "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174",
          "items": [
            {
              "type": "products",
              "id": "c24d15fe-4af1-46d5-931c-f33d41bbf823",
              "stock_item_ids": [
                "e53454fd-839c-49d4-9892-f539570b383b",
                "f07b594a-a5b7-4f96-aea1-1f0dab3a95f2",
                "e4eaf41c-0873-4113-9c33-a9e49c5eca7f"
              ]
            },
            {
              "type": "products",
              "id": "890248ec-7e51-48fe-8073-a2fabe8bea0c",
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
    "id": "3a587421-cb8c-5409-a03b-dc9eac0f2e1d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c5748a4f-56a5-4277-86c9-2394b394a174"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2b09d15b-d832-4278-8752-749aa41c1c29"
          },
          {
            "type": "lines",
            "id": "8fa628a2-2bb2-4f3e-b6ee-37eb453af1ca"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "76c8c7e7-88da-4006-9191-770c5bfa3498"
          },
          {
            "type": "plannings",
            "id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2482b022-e5b2-4e7b-9265-aa18453c4991"
          },
          {
            "type": "stock_item_plannings",
            "id": "5e67e435-3d99-4129-8727-0444692561cc"
          },
          {
            "type": "stock_item_plannings",
            "id": "1f56d0a7-516f-4e30-9d13-23b8dbe61d7c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c5748a4f-56a5-4277-86c9-2394b394a174",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-07T06:52:08+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
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
        "customer_id": "f0f17d08-fecb-487f-a38e-37c30790e5e1",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7",
        "stop_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7"
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
      "id": "2b09d15b-d832-4278-8752-749aa41c1c29",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-07T06:52:09+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
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
        "item_id": "890248ec-7e51-48fe-8073-a2fabe8bea0c",
        "tax_category_id": "5553c2e3-7b6d-496b-b781-750ed4fd3291",
        "planning_id": "76c8c7e7-88da-4006-9191-770c5bfa3498",
        "parent_line_id": null,
        "owner_id": "c5748a4f-56a5-4277-86c9-2394b394a174",
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
      "id": "8fa628a2-2bb2-4f3e-b6ee-37eb453af1ca",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-07T06:52:10+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
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
        "item_id": "c24d15fe-4af1-46d5-931c-f33d41bbf823",
        "tax_category_id": "5553c2e3-7b6d-496b-b781-750ed4fd3291",
        "planning_id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07",
        "parent_line_id": null,
        "owner_id": "c5748a4f-56a5-4277-86c9-2394b394a174",
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
      "id": "76c8c7e7-88da-4006-9191-770c5bfa3498",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:09+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
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
        "item_id": "890248ec-7e51-48fe-8073-a2fabe8bea0c",
        "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174",
        "start_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7",
        "stop_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7",
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
      "id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:10+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
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
        "item_id": "c24d15fe-4af1-46d5-931c-f33d41bbf823",
        "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174",
        "start_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7",
        "stop_location_id": "e0f4e1be-8dca-429e-9164-87613be181d7",
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
      "id": "2482b022-e5b2-4e7b-9265-aa18453c4991",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:10+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e53454fd-839c-49d4-9892-f539570b383b",
        "planning_id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07",
        "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174"
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
      "id": "5e67e435-3d99-4129-8727-0444692561cc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:10+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f07b594a-a5b7-4f96-aea1-1f0dab3a95f2",
        "planning_id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07",
        "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174"
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
      "id": "1f56d0a7-516f-4e30-9d13-23b8dbe61d7c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:10+00:00",
        "updated_at": "2022-06-07T06:52:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e4eaf41c-0873-4113-9c33-a9e49c5eca7f",
        "planning_id": "9f8931a5-aa23-45b5-bcfd-fb1d02e5bf07",
        "order_id": "c5748a4f-56a5-4277-86c9-2394b394a174"
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
          "order_id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5",
          "items": [
            {
              "type": "bundles",
              "id": "2a075de1-a3a8-484b-add6-bedd44c6e33f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "057f09f3-6ec4-4cad-93e6-a4d9f818703f",
                  "id": "f0c99c48-e07d-4619-9e51-14d1101c638c"
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
    "id": "742f3eb7-4192-53b9-9d26-2977ea4b464d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2cd870c2-79ae-4c70-8896-6c34f5080395"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6e3e80e3-a51c-4341-9f73-3eba7f8f6676"
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
      "id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-07T06:52:12+00:00",
        "updated_at": "2022-06-07T06:52:13+00:00",
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
        "starts_at": "2022-06-05T06:45:00+00:00",
        "stops_at": "2022-06-09T06:45:00+00:00",
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
        "start_location_id": "6f3869d7-4c09-46b7-b36b-70795a6a0541",
        "stop_location_id": "6f3869d7-4c09-46b7-b36b-70795a6a0541"
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
      "id": "2cd870c2-79ae-4c70-8896-6c34f5080395",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-07T06:52:13+00:00",
        "updated_at": "2022-06-07T06:52:13+00:00",
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
        "item_id": "2a075de1-a3a8-484b-add6-bedd44c6e33f",
        "tax_category_id": null,
        "planning_id": "6e3e80e3-a51c-4341-9f73-3eba7f8f6676",
        "parent_line_id": null,
        "owner_id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5",
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
      "id": "6e3e80e3-a51c-4341-9f73-3eba7f8f6676",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-07T06:52:12+00:00",
        "updated_at": "2022-06-07T06:52:12+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-05T06:45:00+00:00",
        "stops_at": "2022-06-09T06:45:00+00:00",
        "reserved_from": "2022-06-05T06:45:00+00:00",
        "reserved_till": "2022-06-09T06:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2a075de1-a3a8-484b-add6-bedd44c6e33f",
        "order_id": "4d9415cd-3c1b-4731-8097-029f1c77a1a5",
        "start_location_id": "6f3869d7-4c09-46b7-b36b-70795a6a0541",
        "stop_location_id": "6f3869d7-4c09-46b7-b36b-70795a6a0541",
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





