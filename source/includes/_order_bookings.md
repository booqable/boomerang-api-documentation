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
          "order_id": "e175ae3b-551b-455e-958b-3636251bd427",
          "items": [
            {
              "type": "products",
              "id": "256ae2ef-c253-435b-bc92-3aa8cb0c870d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f1152606-b7e7-44c7-9f46-867f81b3282d",
              "stock_item_ids": [
                "30acf6c3-eb5d-4718-9a0c-cecd1d5acf6e",
                "83f769fc-5830-4470-aa91-9c2673c161b4"
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
          "stock_item_id 30acf6c3-eb5d-4718-9a0c-cecd1d5acf6e has already been booked on this order"
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
          "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
          "items": [
            {
              "type": "products",
              "id": "874a0f04-6a4c-4900-8e8b-a7a785bcec6b",
              "stock_item_ids": [
                "c242c238-c40f-40c1-a268-6b0e93d2da35",
                "5e3e0bde-a9b5-4ed0-840e-1dbe46ab6486",
                "3b9656ff-3c7e-4611-a2db-4067534f5eef"
              ]
            },
            {
              "type": "products",
              "id": "634b6a9b-d5ce-4c4d-9459-703f08dc1c31",
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
    "id": "ace0430e-53da-5247-a463-68444c2c72e5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eb69fc37-fc0f-499f-b804-4725181ea8b3"
          },
          {
            "type": "lines",
            "id": "c476d462-d23c-4001-bd50-ac192621d9cf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "762cc382-146b-441a-8caf-dc8d32c8612d"
          },
          {
            "type": "plannings",
            "id": "f534278c-ef25-444e-9234-c1f408abc555"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "df8010df-96d2-47d7-89a9-0c256fc9d9ec"
          },
          {
            "type": "stock_item_plannings",
            "id": "f0b02f42-7f0f-4ec4-bafc-8136802cfb36"
          },
          {
            "type": "stock_item_plannings",
            "id": "30b73105-f938-4a00-9a7d-ddad79d89fe5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T14:58:14+00:00",
        "updated_at": "2023-02-24T14:58:16+00:00",
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
        "customer_id": "d0adf4a2-d499-4886-9bf1-49dff5e0e5aa",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6930d252-de07-4878-83ab-d656b19ac13f",
        "stop_location_id": "6930d252-de07-4878-83ab-d656b19ac13f"
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
      "id": "eb69fc37-fc0f-499f-b804-4725181ea8b3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:16+00:00",
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
        "item_id": "874a0f04-6a4c-4900-8e8b-a7a785bcec6b",
        "tax_category_id": "ebfd7230-cf20-4334-9be5-73c4a53f8216",
        "planning_id": "762cc382-146b-441a-8caf-dc8d32c8612d",
        "parent_line_id": null,
        "owner_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
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
      "id": "c476d462-d23c-4001-bd50-ac192621d9cf",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:16+00:00",
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
        "item_id": "634b6a9b-d5ce-4c4d-9459-703f08dc1c31",
        "tax_category_id": "ebfd7230-cf20-4334-9be5-73c4a53f8216",
        "planning_id": "f534278c-ef25-444e-9234-c1f408abc555",
        "parent_line_id": null,
        "owner_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
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
      "id": "762cc382-146b-441a-8caf-dc8d32c8612d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:15+00:00",
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
        "item_id": "874a0f04-6a4c-4900-8e8b-a7a785bcec6b",
        "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
        "start_location_id": "6930d252-de07-4878-83ab-d656b19ac13f",
        "stop_location_id": "6930d252-de07-4878-83ab-d656b19ac13f",
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
      "id": "f534278c-ef25-444e-9234-c1f408abc555",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:15+00:00",
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
        "item_id": "634b6a9b-d5ce-4c4d-9459-703f08dc1c31",
        "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b",
        "start_location_id": "6930d252-de07-4878-83ab-d656b19ac13f",
        "stop_location_id": "6930d252-de07-4878-83ab-d656b19ac13f",
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
      "id": "df8010df-96d2-47d7-89a9-0c256fc9d9ec",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c242c238-c40f-40c1-a268-6b0e93d2da35",
        "planning_id": "762cc382-146b-441a-8caf-dc8d32c8612d",
        "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b"
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
      "id": "f0b02f42-7f0f-4ec4-bafc-8136802cfb36",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5e3e0bde-a9b5-4ed0-840e-1dbe46ab6486",
        "planning_id": "762cc382-146b-441a-8caf-dc8d32c8612d",
        "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b"
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
      "id": "30b73105-f938-4a00-9a7d-ddad79d89fe5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:15+00:00",
        "updated_at": "2023-02-24T14:58:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b9656ff-3c7e-4611-a2db-4067534f5eef",
        "planning_id": "762cc382-146b-441a-8caf-dc8d32c8612d",
        "order_id": "0e154f2d-9bee-4703-b4c9-3c538d9a067b"
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
          "order_id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4",
          "items": [
            {
              "type": "bundles",
              "id": "a75f4e6e-351a-48f8-9600-351ddc2ec040",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6b41a6fd-d9f8-4325-a482-05872bd25499",
                  "id": "bc002908-88a8-4a63-b45c-7b5d640d6eed"
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
    "id": "90aaa174-b468-5bc5-8b84-20c10175793f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eb6c0464-46b9-45c2-a1ff-1fcb293cbdd9"
          },
          {
            "type": "lines",
            "id": "d3b1f5da-9ff4-4b11-a944-a06dba0579c6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5582969f-ffb5-4082-9aec-705ba40ebd94"
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
      "id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T14:58:18+00:00",
        "updated_at": "2023-02-24T14:58:19+00:00",
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
        "starts_at": "2023-02-22T14:45:00+00:00",
        "stops_at": "2023-02-26T14:45:00+00:00",
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
        "start_location_id": "d1bab8c4-9e5b-4dd1-afab-77fdb83a4259",
        "stop_location_id": "d1bab8c4-9e5b-4dd1-afab-77fdb83a4259"
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
      "id": "eb6c0464-46b9-45c2-a1ff-1fcb293cbdd9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:58:19+00:00",
        "updated_at": "2023-02-24T14:58:19+00:00",
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
        "item_id": "bc002908-88a8-4a63-b45c-7b5d640d6eed",
        "tax_category_id": null,
        "planning_id": "2e53a2fa-da45-4dca-81d3-958f257df8f1",
        "parent_line_id": "d3b1f5da-9ff4-4b11-a944-a06dba0579c6",
        "owner_id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4",
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
      "id": "d3b1f5da-9ff4-4b11-a944-a06dba0579c6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:58:19+00:00",
        "updated_at": "2023-02-24T14:58:19+00:00",
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
        "item_id": "a75f4e6e-351a-48f8-9600-351ddc2ec040",
        "tax_category_id": null,
        "planning_id": "5582969f-ffb5-4082-9aec-705ba40ebd94",
        "parent_line_id": null,
        "owner_id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4",
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
      "id": "5582969f-ffb5-4082-9aec-705ba40ebd94",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:58:19+00:00",
        "updated_at": "2023-02-24T14:58:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T14:45:00+00:00",
        "stops_at": "2023-02-26T14:45:00+00:00",
        "reserved_from": "2023-02-22T14:45:00+00:00",
        "reserved_till": "2023-02-26T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a75f4e6e-351a-48f8-9600-351ddc2ec040",
        "order_id": "1eebaed0-13e3-4b7b-b264-1f55a530b0e4",
        "start_location_id": "d1bab8c4-9e5b-4dd1-afab-77fdb83a4259",
        "stop_location_id": "d1bab8c4-9e5b-4dd1-afab-77fdb83a4259",
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





