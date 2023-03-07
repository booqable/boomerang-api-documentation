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
          "order_id": "9f14d9b9-15e2-43e1-ba99-6c75a1aa2ba6",
          "items": [
            {
              "type": "products",
              "id": "ff49b62a-774b-4b99-8026-850f10bc9898",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a4808d76-8d26-4379-819e-b15e2e03caca",
              "stock_item_ids": [
                "ff4b6f76-6573-4f71-b9f6-212d41d6ffb1",
                "3ade53fc-3262-4ce6-88f5-057cbf3673e4"
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
          "stock_item_id ff4b6f76-6573-4f71-b9f6-212d41d6ffb1 has already been booked on this order"
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
          "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306",
          "items": [
            {
              "type": "products",
              "id": "eac56924-7f6c-4838-ab76-885d5b59560c",
              "stock_item_ids": [
                "cd511a01-7857-4b84-a186-b48e0039c2d1",
                "66bed442-441a-4ced-a7e7-b0bbfd356f82",
                "45e0abf0-af29-4f8c-9d5e-d5aba8f6b23c"
              ]
            },
            {
              "type": "products",
              "id": "31358a08-d37e-408d-b95c-99a6578183cf",
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
    "id": "9dae18b9-250d-5854-8d86-8b99d4d05851",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fd09039d-70a0-41b4-897a-d47fcb519306"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c12cbf79-9f23-44e3-a9ac-6edbcac3b66d"
          },
          {
            "type": "lines",
            "id": "947d2bb9-1af6-47d8-a570-6c6264b84593"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2"
          },
          {
            "type": "plannings",
            "id": "20e072de-ef26-4e90-ab52-3310ebfc29e8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dd736118-0b34-4b77-8ccb-869eb6f37704"
          },
          {
            "type": "stock_item_plannings",
            "id": "43d528ff-4a61-400a-b544-8328e6097658"
          },
          {
            "type": "stock_item_plannings",
            "id": "e498ba7e-18b8-460e-a993-1e042e48c845"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fd09039d-70a0-41b4-897a-d47fcb519306",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T08:09:58+00:00",
        "updated_at": "2023-03-07T08:10:01+00:00",
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
        "customer_id": "7117c01f-06fe-4d9c-8d12-00e1000ef91d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2",
        "stop_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2"
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
      "id": "c12cbf79-9f23-44e3-a9ac-6edbcac3b66d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:01+00:00",
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
        "item_id": "eac56924-7f6c-4838-ab76-885d5b59560c",
        "tax_category_id": "015195f0-064a-45f6-b930-064d844219a0",
        "planning_id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2",
        "parent_line_id": null,
        "owner_id": "fd09039d-70a0-41b4-897a-d47fcb519306",
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
      "id": "947d2bb9-1af6-47d8-a570-6c6264b84593",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:01+00:00",
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
        "item_id": "31358a08-d37e-408d-b95c-99a6578183cf",
        "tax_category_id": "015195f0-064a-45f6-b930-064d844219a0",
        "planning_id": "20e072de-ef26-4e90-ab52-3310ebfc29e8",
        "parent_line_id": null,
        "owner_id": "fd09039d-70a0-41b4-897a-d47fcb519306",
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
      "id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:00+00:00",
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
        "item_id": "eac56924-7f6c-4838-ab76-885d5b59560c",
        "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306",
        "start_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2",
        "stop_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2",
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
      "id": "20e072de-ef26-4e90-ab52-3310ebfc29e8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:00+00:00",
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
        "item_id": "31358a08-d37e-408d-b95c-99a6578183cf",
        "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306",
        "start_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2",
        "stop_location_id": "3d076bff-4a42-4840-b449-1af2acebc2d2",
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
      "id": "dd736118-0b34-4b77-8ccb-869eb6f37704",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cd511a01-7857-4b84-a186-b48e0039c2d1",
        "planning_id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2",
        "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306"
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
      "id": "43d528ff-4a61-400a-b544-8328e6097658",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66bed442-441a-4ced-a7e7-b0bbfd356f82",
        "planning_id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2",
        "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306"
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
      "id": "e498ba7e-18b8-460e-a993-1e042e48c845",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:00+00:00",
        "updated_at": "2023-03-07T08:10:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "45e0abf0-af29-4f8c-9d5e-d5aba8f6b23c",
        "planning_id": "4dae8f06-8bbf-427b-ae3e-0b30f631dac2",
        "order_id": "fd09039d-70a0-41b4-897a-d47fcb519306"
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
          "order_id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0",
          "items": [
            {
              "type": "bundles",
              "id": "4c37ecc4-70aa-4740-811f-5fd1ba100750",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "43f4f92b-1aba-4735-bb62-91a8ef195df2",
                  "id": "27a425dc-3304-4a03-9f81-6ad1620fdd4b"
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
    "id": "7f2efd63-c56d-5e91-b291-4a8d50fed450",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "232bad03-4016-49b1-a0f4-4a0ae016e06f"
          },
          {
            "type": "lines",
            "id": "6730d425-e7e4-4379-afa6-2fc32798c314"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4590d3d5-9a75-4362-8108-9d2c4529e160"
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
      "id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T08:10:04+00:00",
        "updated_at": "2023-03-07T08:10:05+00:00",
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
        "starts_at": "2023-03-05T08:00:00+00:00",
        "stops_at": "2023-03-09T08:00:00+00:00",
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
        "start_location_id": "26503002-b58e-4daf-b790-6aa5ea9e909c",
        "stop_location_id": "26503002-b58e-4daf-b790-6aa5ea9e909c"
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
      "id": "232bad03-4016-49b1-a0f4-4a0ae016e06f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:10:04+00:00",
        "updated_at": "2023-03-07T08:10:04+00:00",
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
        "item_id": "4c37ecc4-70aa-4740-811f-5fd1ba100750",
        "tax_category_id": null,
        "planning_id": "4590d3d5-9a75-4362-8108-9d2c4529e160",
        "parent_line_id": null,
        "owner_id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0",
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
      "id": "6730d425-e7e4-4379-afa6-2fc32798c314",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:10:04+00:00",
        "updated_at": "2023-03-07T08:10:04+00:00",
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
        "item_id": "27a425dc-3304-4a03-9f81-6ad1620fdd4b",
        "tax_category_id": null,
        "planning_id": "9c0017d3-6a62-499d-978a-9d64852d32f1",
        "parent_line_id": "232bad03-4016-49b1-a0f4-4a0ae016e06f",
        "owner_id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0",
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
      "id": "4590d3d5-9a75-4362-8108-9d2c4529e160",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:10:04+00:00",
        "updated_at": "2023-03-07T08:10:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-05T08:00:00+00:00",
        "stops_at": "2023-03-09T08:00:00+00:00",
        "reserved_from": "2023-03-05T08:00:00+00:00",
        "reserved_till": "2023-03-09T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4c37ecc4-70aa-4740-811f-5fd1ba100750",
        "order_id": "0b73a1b8-b86b-4cb9-ae50-1330355b5ec0",
        "start_location_id": "26503002-b58e-4daf-b790-6aa5ea9e909c",
        "stop_location_id": "26503002-b58e-4daf-b790-6aa5ea9e909c",
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





