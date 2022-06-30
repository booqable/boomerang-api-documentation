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
          "order_id": "9a0799b7-3e33-47a4-87dd-a91994d39a41",
          "items": [
            {
              "type": "products",
              "id": "1aba7ae6-4f7f-4bfb-9aa7-91120ad6b3c6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a19d2459-6801-4743-a596-78926e5c1edc",
              "stock_item_ids": [
                "1fd96453-853f-46b2-9b9d-4a4c93bdc463",
                "9dbb96b2-6f6e-4ff8-9098-d46553aae01b"
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
            "item_id": "1aba7ae6-4f7f-4bfb-9aa7-91120ad6b3c6",
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
          "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
          "items": [
            {
              "type": "products",
              "id": "8c23908c-ee77-4433-abda-ae69e6d27d7f",
              "stock_item_ids": [
                "2e956d12-18c0-4869-bd39-f5d08e443422",
                "09b5bf94-ed79-453f-a143-513d88a0b1c2",
                "2a99e0d1-69c7-4113-9d29-3043c0000fa7"
              ]
            },
            {
              "type": "products",
              "id": "39b3cd67-7bdf-4108-b1d0-e89371124301",
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
    "id": "fee6c1f2-0537-53fe-88ab-8fc1b2346043",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cb6964ca-de77-4495-9fd5-d3d8e0a975f6"
          },
          {
            "type": "lines",
            "id": "bf074e83-7d44-4e28-a905-72cd24514fb6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cc308ae1-44a6-422c-9915-18b0f17e2136"
          },
          {
            "type": "plannings",
            "id": "6c5484f9-a58d-4299-8746-d16bd3fb1541"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f5848b2b-9145-4ba5-ac07-7f6d96c23a03"
          },
          {
            "type": "stock_item_plannings",
            "id": "5230a37a-209c-454c-94ff-94cc4fbc766a"
          },
          {
            "type": "stock_item_plannings",
            "id": "bf62085c-4a80-400b-bc66-16b524991bd2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T13:12:01+00:00",
        "updated_at": "2022-06-30T13:12:04+00:00",
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
        "customer_id": "41dd6fd6-1296-4ba1-9b39-a684d557b84f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad",
        "stop_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad"
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
      "id": "cb6964ca-de77-4495-9fd5-d3d8e0a975f6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T13:12:02+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
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
        "item_id": "39b3cd67-7bdf-4108-b1d0-e89371124301",
        "tax_category_id": "158d58ae-0809-4ac4-9666-fa27a3d39756",
        "planning_id": "cc308ae1-44a6-422c-9915-18b0f17e2136",
        "parent_line_id": null,
        "owner_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
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
      "id": "bf074e83-7d44-4e28-a905-72cd24514fb6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T13:12:03+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
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
        "item_id": "8c23908c-ee77-4433-abda-ae69e6d27d7f",
        "tax_category_id": "158d58ae-0809-4ac4-9666-fa27a3d39756",
        "planning_id": "6c5484f9-a58d-4299-8746-d16bd3fb1541",
        "parent_line_id": null,
        "owner_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
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
      "id": "cc308ae1-44a6-422c-9915-18b0f17e2136",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:02+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
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
        "item_id": "39b3cd67-7bdf-4108-b1d0-e89371124301",
        "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
        "start_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad",
        "stop_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad",
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
      "id": "6c5484f9-a58d-4299-8746-d16bd3fb1541",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:03+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
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
        "item_id": "8c23908c-ee77-4433-abda-ae69e6d27d7f",
        "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d",
        "start_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad",
        "stop_location_id": "0e4f9245-6aba-422d-9b80-723238b063ad",
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
      "id": "f5848b2b-9145-4ba5-ac07-7f6d96c23a03",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:03+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e956d12-18c0-4869-bd39-f5d08e443422",
        "planning_id": "6c5484f9-a58d-4299-8746-d16bd3fb1541",
        "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d"
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
      "id": "5230a37a-209c-454c-94ff-94cc4fbc766a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:03+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "09b5bf94-ed79-453f-a143-513d88a0b1c2",
        "planning_id": "6c5484f9-a58d-4299-8746-d16bd3fb1541",
        "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d"
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
      "id": "bf62085c-4a80-400b-bc66-16b524991bd2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:03+00:00",
        "updated_at": "2022-06-30T13:12:03+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2a99e0d1-69c7-4113-9d29-3043c0000fa7",
        "planning_id": "6c5484f9-a58d-4299-8746-d16bd3fb1541",
        "order_id": "3b9eb4aa-dbf2-41b7-8ffa-b0d40912e91d"
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
          "order_id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126",
          "items": [
            {
              "type": "bundles",
              "id": "662b90ee-1ed5-4c74-b06a-aeebc14a2c8d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "84b824d3-504b-4012-a7c0-a11f786dcf29",
                  "id": "0e50f989-5d92-4e4f-9477-0e3b05b1d7d9"
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
    "id": "e6ca6622-c2cc-5e18-8306-4492aac04222",
    "type": "order_bookings",
    "attributes": {
      "order_id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1b9406c7-7d01-4d25-a1dc-9557f538069b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e2570b87-195f-4fb6-b16d-76ae09e92b91"
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
      "id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-30T13:12:06+00:00",
        "updated_at": "2022-06-30T13:12:07+00:00",
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
        "starts_at": "2022-06-28T13:00:00+00:00",
        "stops_at": "2022-07-02T13:00:00+00:00",
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
        "start_location_id": "17584f3a-5059-4b2b-ad62-429100ee2f01",
        "stop_location_id": "17584f3a-5059-4b2b-ad62-429100ee2f01"
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
      "id": "1b9406c7-7d01-4d25-a1dc-9557f538069b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-30T13:12:06+00:00",
        "updated_at": "2022-06-30T13:12:06+00:00",
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
        "item_id": "662b90ee-1ed5-4c74-b06a-aeebc14a2c8d",
        "tax_category_id": null,
        "planning_id": "e2570b87-195f-4fb6-b16d-76ae09e92b91",
        "parent_line_id": null,
        "owner_id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126",
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
      "id": "e2570b87-195f-4fb6-b16d-76ae09e92b91",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-30T13:12:06+00:00",
        "updated_at": "2022-06-30T13:12:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-28T13:00:00+00:00",
        "stops_at": "2022-07-02T13:00:00+00:00",
        "reserved_from": "2022-06-28T13:00:00+00:00",
        "reserved_till": "2022-07-02T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "662b90ee-1ed5-4c74-b06a-aeebc14a2c8d",
        "order_id": "95cf570d-3a97-4c6e-ba86-9fbf3a3d5126",
        "start_location_id": "17584f3a-5059-4b2b-ad62-429100ee2f01",
        "stop_location_id": "17584f3a-5059-4b2b-ad62-429100ee2f01",
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





