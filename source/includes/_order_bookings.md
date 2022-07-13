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
          "order_id": "cd9a4bf0-b6d2-470f-a682-5b372152768c",
          "items": [
            {
              "type": "products",
              "id": "61737d64-05a9-4164-a37d-3af592ee7125",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "557c7c35-8fd9-44ae-9dde-0119d8401e68",
              "stock_item_ids": [
                "7feeb22e-e942-4747-ab9d-dbc1dfea6a60",
                "773a6604-80b2-484e-8b23-578b5214408c"
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
            "item_id": "61737d64-05a9-4164-a37d-3af592ee7125",
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
          "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
          "items": [
            {
              "type": "products",
              "id": "3225f4a7-0aa9-4676-b731-ef4648a709ba",
              "stock_item_ids": [
                "a6bc42d7-4ba6-49e0-ab31-cdb29a987041",
                "a436b078-7851-4da3-a035-c8beed639e78",
                "90144027-6db9-4b81-9381-ae0d054b9e5a"
              ]
            },
            {
              "type": "products",
              "id": "59325868-2d7a-4e7c-a214-1c5f606fcb4d",
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
    "id": "96bbf4ad-e0fa-545e-ad4d-0f3ffdb77959",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e4c691a6-4e24-4126-957e-90da2b34f84e"
          },
          {
            "type": "lines",
            "id": "5adffcf8-6cfe-452f-beff-a298273b8eff"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6b53faad-fe47-46ed-8290-3157d29f155b"
          },
          {
            "type": "plannings",
            "id": "2aebad2c-3e17-4847-ba31-f74d48b557ca"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4122f8e8-46b9-4153-a843-4e5d445fd40c"
          },
          {
            "type": "stock_item_plannings",
            "id": "93206ba9-a4f8-4f2e-afca-b2f66ccc3e10"
          },
          {
            "type": "stock_item_plannings",
            "id": "95866fd7-1307-4d74-8e68-b81ea3721cc7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-13T08:19:02+00:00",
        "updated_at": "2022-07-13T08:19:04+00:00",
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
        "customer_id": "5178a015-9706-444f-8b9d-41eb2f496bb6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9",
        "stop_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9"
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
      "id": "e4c691a6-4e24-4126-957e-90da2b34f84e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T08:19:02+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
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
        "item_id": "59325868-2d7a-4e7c-a214-1c5f606fcb4d",
        "tax_category_id": "4e1042a0-ccf3-442f-aa64-51bd624aca38",
        "planning_id": "6b53faad-fe47-46ed-8290-3157d29f155b",
        "parent_line_id": null,
        "owner_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
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
      "id": "5adffcf8-6cfe-452f-beff-a298273b8eff",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T08:19:03+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
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
        "item_id": "3225f4a7-0aa9-4676-b731-ef4648a709ba",
        "tax_category_id": "4e1042a0-ccf3-442f-aa64-51bd624aca38",
        "planning_id": "2aebad2c-3e17-4847-ba31-f74d48b557ca",
        "parent_line_id": null,
        "owner_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
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
      "id": "6b53faad-fe47-46ed-8290-3157d29f155b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:02+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
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
        "item_id": "59325868-2d7a-4e7c-a214-1c5f606fcb4d",
        "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
        "start_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9",
        "stop_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9",
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
      "id": "2aebad2c-3e17-4847-ba31-f74d48b557ca",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:03+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
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
        "item_id": "3225f4a7-0aa9-4676-b731-ef4648a709ba",
        "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b",
        "start_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9",
        "stop_location_id": "e7029248-1656-4851-93bb-6e8eb69f5fd9",
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
      "id": "4122f8e8-46b9-4153-a843-4e5d445fd40c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:03+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a6bc42d7-4ba6-49e0-ab31-cdb29a987041",
        "planning_id": "2aebad2c-3e17-4847-ba31-f74d48b557ca",
        "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b"
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
      "id": "93206ba9-a4f8-4f2e-afca-b2f66ccc3e10",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:03+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a436b078-7851-4da3-a035-c8beed639e78",
        "planning_id": "2aebad2c-3e17-4847-ba31-f74d48b557ca",
        "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b"
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
      "id": "95866fd7-1307-4d74-8e68-b81ea3721cc7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:03+00:00",
        "updated_at": "2022-07-13T08:19:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "90144027-6db9-4b81-9381-ae0d054b9e5a",
        "planning_id": "2aebad2c-3e17-4847-ba31-f74d48b557ca",
        "order_id": "7cf70c67-ee74-4fb1-87a9-2efbbfe4f65b"
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
          "order_id": "fddd9c6d-a63d-4e04-9273-503cb994a032",
          "items": [
            {
              "type": "bundles",
              "id": "72f4ab02-1754-4cd2-b0ec-d276ec2b91dc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "445d0c5c-b057-4761-ad5a-907ae0c899ec",
                  "id": "a28ce0df-a01f-447e-a33c-ccd2814317eb"
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
    "id": "0bf0ce64-3ceb-513e-83de-6539998545c3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fddd9c6d-a63d-4e04-9273-503cb994a032"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fddd9c6d-a63d-4e04-9273-503cb994a032"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7515a5fa-0202-41f7-90c0-9ae199b82058"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "84d0f9f7-4b18-4bf5-a690-1c6c39b29413"
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
      "id": "fddd9c6d-a63d-4e04-9273-503cb994a032",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-13T08:19:06+00:00",
        "updated_at": "2022-07-13T08:19:07+00:00",
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
        "starts_at": "2022-07-11T08:15:00+00:00",
        "stops_at": "2022-07-15T08:15:00+00:00",
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
        "start_location_id": "2905a85e-0e98-49e5-8e00-ad4b2d3f061e",
        "stop_location_id": "2905a85e-0e98-49e5-8e00-ad4b2d3f061e"
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
      "id": "7515a5fa-0202-41f7-90c0-9ae199b82058",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T08:19:07+00:00",
        "updated_at": "2022-07-13T08:19:07+00:00",
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
        "item_id": "72f4ab02-1754-4cd2-b0ec-d276ec2b91dc",
        "tax_category_id": null,
        "planning_id": "84d0f9f7-4b18-4bf5-a690-1c6c39b29413",
        "parent_line_id": null,
        "owner_id": "fddd9c6d-a63d-4e04-9273-503cb994a032",
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
      "id": "84d0f9f7-4b18-4bf5-a690-1c6c39b29413",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T08:19:06+00:00",
        "updated_at": "2022-07-13T08:19:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-11T08:15:00+00:00",
        "stops_at": "2022-07-15T08:15:00+00:00",
        "reserved_from": "2022-07-11T08:15:00+00:00",
        "reserved_till": "2022-07-15T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "72f4ab02-1754-4cd2-b0ec-d276ec2b91dc",
        "order_id": "fddd9c6d-a63d-4e04-9273-503cb994a032",
        "start_location_id": "2905a85e-0e98-49e5-8e00-ad4b2d3f061e",
        "stop_location_id": "2905a85e-0e98-49e5-8e00-ad4b2d3f061e",
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





