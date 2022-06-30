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
          "order_id": "485debe9-1c4d-403b-8df2-0ec54ed9325c",
          "items": [
            {
              "type": "products",
              "id": "2db14809-c808-4b10-b8c1-cfb00846a9f8",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "09bd1ac1-700f-4944-8472-3b7392d554aa",
              "stock_item_ids": [
                "d229a425-1f79-4a9e-ac22-b87533cc7e98",
                "ec155f5f-a44b-4751-833d-94fb5f8b8a6e"
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
            "item_id": "2db14809-c808-4b10-b8c1-cfb00846a9f8",
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
          "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
          "items": [
            {
              "type": "products",
              "id": "7c8458ba-0cb1-42c8-a996-4519c279c3cb",
              "stock_item_ids": [
                "c8ae0732-4853-4f73-826d-3b0471598c43",
                "fcb66530-650c-4ffa-b395-a8ab095d216b",
                "bf4217ef-196a-4e94-b0b6-81dc41b1e2cb"
              ]
            },
            {
              "type": "products",
              "id": "0edc1d96-7e9a-4fbe-9615-c6274567e6a7",
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
    "id": "93842c54-7237-526c-ba59-f7c1c0f3ebcb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f7882d40-e566-48bc-b0ac-4f5efdbc203c"
          },
          {
            "type": "lines",
            "id": "608575cc-6678-482a-a2a4-9db5de1a07c0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "525d4fa7-c238-4147-ae00-25276475e23b"
          },
          {
            "type": "plannings",
            "id": "c753a4cb-7c92-4156-b791-ec3493522c4d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "de7b2c4c-4734-448e-860c-8f0b26179822"
          },
          {
            "type": "stock_item_plannings",
            "id": "41351be1-bb2c-423f-a75a-9028e9bffe0d"
          },
          {
            "type": "stock_item_plannings",
            "id": "5e34c7dc-f150-405f-8bc5-bf6a0747868b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T12:42:23+00:00",
        "updated_at": "2022-06-30T12:42:25+00:00",
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
        "customer_id": "e039f4ac-1e5e-4bdf-907c-4cdb287bf042",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4",
        "stop_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4"
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
      "id": "f7882d40-e566-48bc-b0ac-4f5efdbc203c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T12:42:23+00:00",
        "updated_at": "2022-06-30T12:42:24+00:00",
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
        "item_id": "0edc1d96-7e9a-4fbe-9615-c6274567e6a7",
        "tax_category_id": "3aa4f3c1-02f7-48d0-9f86-88c36f9dc880",
        "planning_id": "525d4fa7-c238-4147-ae00-25276475e23b",
        "parent_line_id": null,
        "owner_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
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
      "id": "608575cc-6678-482a-a2a4-9db5de1a07c0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T12:42:24+00:00",
        "updated_at": "2022-06-30T12:42:24+00:00",
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
        "item_id": "7c8458ba-0cb1-42c8-a996-4519c279c3cb",
        "tax_category_id": "3aa4f3c1-02f7-48d0-9f86-88c36f9dc880",
        "planning_id": "c753a4cb-7c92-4156-b791-ec3493522c4d",
        "parent_line_id": null,
        "owner_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
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
      "id": "525d4fa7-c238-4147-ae00-25276475e23b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:23+00:00",
        "updated_at": "2022-06-30T12:42:25+00:00",
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
        "item_id": "0edc1d96-7e9a-4fbe-9615-c6274567e6a7",
        "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
        "start_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4",
        "stop_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4",
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
      "id": "c753a4cb-7c92-4156-b791-ec3493522c4d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:24+00:00",
        "updated_at": "2022-06-30T12:42:25+00:00",
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
        "item_id": "7c8458ba-0cb1-42c8-a996-4519c279c3cb",
        "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550",
        "start_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4",
        "stop_location_id": "8cd10b18-094d-4193-a56e-51e33a3654a4",
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
      "id": "de7b2c4c-4734-448e-860c-8f0b26179822",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:24+00:00",
        "updated_at": "2022-06-30T12:42:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c8ae0732-4853-4f73-826d-3b0471598c43",
        "planning_id": "c753a4cb-7c92-4156-b791-ec3493522c4d",
        "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550"
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
      "id": "41351be1-bb2c-423f-a75a-9028e9bffe0d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:24+00:00",
        "updated_at": "2022-06-30T12:42:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fcb66530-650c-4ffa-b395-a8ab095d216b",
        "planning_id": "c753a4cb-7c92-4156-b791-ec3493522c4d",
        "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550"
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
      "id": "5e34c7dc-f150-405f-8bc5-bf6a0747868b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:24+00:00",
        "updated_at": "2022-06-30T12:42:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bf4217ef-196a-4e94-b0b6-81dc41b1e2cb",
        "planning_id": "c753a4cb-7c92-4156-b791-ec3493522c4d",
        "order_id": "8d8e34c7-076a-4d96-a1c3-33b3b3ba5550"
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
          "order_id": "5477d09a-672c-47d1-8b0b-e469eb26a691",
          "items": [
            {
              "type": "bundles",
              "id": "5a2ae778-5875-4342-8aa0-96e20d316170",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7d8f5890-2096-4e6c-8570-7660e9536f1b",
                  "id": "e580e1b2-1006-499b-9797-0c2d1bf04798"
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
    "id": "6086fa13-b6d5-5be7-ac68-f4b52c4a55be",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5477d09a-672c-47d1-8b0b-e469eb26a691"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5477d09a-672c-47d1-8b0b-e469eb26a691"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7a9db8b1-fa5a-4afa-a21b-a2959dcbff80"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "eda05cae-b34d-4071-949c-773ec667ecc7"
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
      "id": "5477d09a-672c-47d1-8b0b-e469eb26a691",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T12:42:27+00:00",
        "updated_at": "2022-06-30T12:42:28+00:00",
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
        "starts_at": "2022-06-28T12:30:00+00:00",
        "stops_at": "2022-07-02T12:30:00+00:00",
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
        "start_location_id": "93b95a26-7975-42d2-a08f-eda678ff2345",
        "stop_location_id": "93b95a26-7975-42d2-a08f-eda678ff2345"
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
      "id": "7a9db8b1-fa5a-4afa-a21b-a2959dcbff80",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T12:42:28+00:00",
        "updated_at": "2022-06-30T12:42:28+00:00",
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
        "item_id": "5a2ae778-5875-4342-8aa0-96e20d316170",
        "tax_category_id": null,
        "planning_id": "eda05cae-b34d-4071-949c-773ec667ecc7",
        "parent_line_id": null,
        "owner_id": "5477d09a-672c-47d1-8b0b-e469eb26a691",
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
      "id": "eda05cae-b34d-4071-949c-773ec667ecc7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T12:42:28+00:00",
        "updated_at": "2022-06-30T12:42:28+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-28T12:30:00+00:00",
        "stops_at": "2022-07-02T12:30:00+00:00",
        "reserved_from": "2022-06-28T12:30:00+00:00",
        "reserved_till": "2022-07-02T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5a2ae778-5875-4342-8aa0-96e20d316170",
        "order_id": "5477d09a-672c-47d1-8b0b-e469eb26a691",
        "start_location_id": "93b95a26-7975-42d2-a08f-eda678ff2345",
        "stop_location_id": "93b95a26-7975-42d2-a08f-eda678ff2345",
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





