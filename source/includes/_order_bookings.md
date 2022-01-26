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
          "order_id": "d169be1e-46e3-4360-b7d1-3d09a3a09a7a",
          "items": [
            {
              "type": "products",
              "id": "3e77350f-d05f-40ad-97cd-d1990cbda696",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "75d10305-d30c-4dc5-97f0-e9b305f6b4b3",
              "stock_item_ids": [
                "0f20dbde-46a9-41e2-a74a-6cab3a466237",
                "9e2ab924-a179-473b-9353-c8b296dc49f6"
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
            "item_id": "3e77350f-d05f-40ad-97cd-d1990cbda696",
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
          "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511",
          "items": [
            {
              "type": "products",
              "id": "07b34302-31d3-40f9-bca1-4314e7ea6e17",
              "stock_item_ids": [
                "b437374e-3d34-49cb-a8bf-e50aab0af576",
                "8bc758b2-2ffe-48e3-96ca-bfd8f8556861",
                "7b252476-362e-4ba1-afc5-5e9d878a1f0e"
              ]
            },
            {
              "type": "products",
              "id": "a3970098-1455-4b53-9692-03d43b462c41",
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
    "id": "4876da74-d4ef-5706-9dc2-dc0fdb560345",
    "type": "order_bookings",
    "attributes": {
      "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "77773038-a653-4aaf-afe2-016cb7dcd511"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bb6bd345-9ea3-4ec1-9ecf-90264fb89405"
          },
          {
            "type": "lines",
            "id": "6e8a2ef0-404f-4297-b203-9cbe174e8432"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1b14543a-523c-4d6a-aebb-3ffce8d9898a"
          },
          {
            "type": "plannings",
            "id": "31859193-90b5-427c-ab2c-9ef993a6575d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0019352e-dd0d-41ff-8ccc-fc73334d8417"
          },
          {
            "type": "stock_item_plannings",
            "id": "98a184e3-05c6-4c4c-a0c0-37907850670d"
          },
          {
            "type": "stock_item_plannings",
            "id": "98e774df-4543-4d58-aa05-d6b8ecbdf75e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "77773038-a653-4aaf-afe2-016cb7dcd511",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-26T14:24:47+00:00",
        "updated_at": "2022-01-26T14:24:50+00:00",
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
        "customer_id": "2a140604-95dc-47f7-b5d3-f86663f48504",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5",
        "stop_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5"
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
      "id": "bb6bd345-9ea3-4ec1-9ecf-90264fb89405",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-26T14:24:48+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
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
        "item_id": "a3970098-1455-4b53-9692-03d43b462c41",
        "tax_category_id": "71e1d87f-16db-442b-a622-ce5d70c5f576",
        "planning_id": "1b14543a-523c-4d6a-aebb-3ffce8d9898a",
        "parent_line_id": null,
        "owner_id": "77773038-a653-4aaf-afe2-016cb7dcd511",
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
      "id": "6e8a2ef0-404f-4297-b203-9cbe174e8432",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-26T14:24:49+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
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
        "item_id": "07b34302-31d3-40f9-bca1-4314e7ea6e17",
        "tax_category_id": "71e1d87f-16db-442b-a622-ce5d70c5f576",
        "planning_id": "31859193-90b5-427c-ab2c-9ef993a6575d",
        "parent_line_id": null,
        "owner_id": "77773038-a653-4aaf-afe2-016cb7dcd511",
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
      "id": "1b14543a-523c-4d6a-aebb-3ffce8d9898a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:48+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
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
        "item_id": "a3970098-1455-4b53-9692-03d43b462c41",
        "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511",
        "start_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5",
        "stop_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5",
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
      "id": "31859193-90b5-427c-ab2c-9ef993a6575d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:49+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
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
        "item_id": "07b34302-31d3-40f9-bca1-4314e7ea6e17",
        "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511",
        "start_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5",
        "stop_location_id": "0d776459-ec38-4c24-a5c7-8b99fc17b1c5",
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
      "id": "0019352e-dd0d-41ff-8ccc-fc73334d8417",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:49+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b437374e-3d34-49cb-a8bf-e50aab0af576",
        "planning_id": "31859193-90b5-427c-ab2c-9ef993a6575d",
        "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511"
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
      "id": "98a184e3-05c6-4c4c-a0c0-37907850670d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:49+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8bc758b2-2ffe-48e3-96ca-bfd8f8556861",
        "planning_id": "31859193-90b5-427c-ab2c-9ef993a6575d",
        "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511"
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
      "id": "98e774df-4543-4d58-aa05-d6b8ecbdf75e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:49+00:00",
        "updated_at": "2022-01-26T14:24:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7b252476-362e-4ba1-afc5-5e9d878a1f0e",
        "planning_id": "31859193-90b5-427c-ab2c-9ef993a6575d",
        "order_id": "77773038-a653-4aaf-afe2-016cb7dcd511"
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
          "order_id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b",
          "items": [
            {
              "type": "bundles",
              "id": "402b01d0-2e0c-4051-bac3-6e376e690b70",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6ebcdccd-e6b3-4a60-bbb9-3f5140930db0",
                  "id": "78d9c107-08ba-41ec-885b-af952c7d8c40"
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
    "id": "4cabf114-7b86-5800-8d71-4f8d4465ba82",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d08d8dc9-1b3a-41a6-a323-7224f64bb95f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1128bb7f-29af-4c35-ab9d-6b44a0719e8e"
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
      "id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-26T14:24:52+00:00",
        "updated_at": "2022-01-26T14:24:54+00:00",
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
        "starts_at": "2022-01-24T14:15:00+00:00",
        "stops_at": "2022-01-28T14:15:00+00:00",
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
        "start_location_id": "46737dee-41b7-46c8-b3dc-f6932cb6d4aa",
        "stop_location_id": "46737dee-41b7-46c8-b3dc-f6932cb6d4aa"
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
      "id": "d08d8dc9-1b3a-41a6-a323-7224f64bb95f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-26T14:24:53+00:00",
        "updated_at": "2022-01-26T14:24:53+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "402b01d0-2e0c-4051-bac3-6e376e690b70",
        "tax_category_id": null,
        "planning_id": "1128bb7f-29af-4c35-ab9d-6b44a0719e8e",
        "parent_line_id": null,
        "owner_id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b",
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
      "id": "1128bb7f-29af-4c35-ab9d-6b44a0719e8e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-26T14:24:53+00:00",
        "updated_at": "2022-01-26T14:24:53+00:00",
        "quantity": 1,
        "starts_at": "2022-01-24T14:15:00+00:00",
        "stops_at": "2022-01-28T14:15:00+00:00",
        "reserved_from": "2022-01-24T14:15:00+00:00",
        "reserved_till": "2022-01-28T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "402b01d0-2e0c-4051-bac3-6e376e690b70",
        "order_id": "f4031b46-bab0-43c8-9934-977fe7fd0e9b",
        "start_location_id": "46737dee-41b7-46c8-b3dc-f6932cb6d4aa",
        "stop_location_id": "46737dee-41b7-46c8-b3dc-f6932cb6d4aa",
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





