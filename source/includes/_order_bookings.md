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
          "order_id": "c98860e0-e61f-4458-90f0-9ac80cf390bc",
          "items": [
            {
              "type": "products",
              "id": "3cb68aac-82f5-4932-a399-401ab1f621f7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ad233c0b-b15b-4a30-9ace-53561b562b3e",
              "stock_item_ids": [
                "a664b323-800f-4050-bfc0-a84a1c94cef4",
                "1a51dd6b-a025-4ba2-ab4d-0be0e9d56e47"
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
          "stock_item_id a664b323-800f-4050-bfc0-a84a1c94cef4 has already been booked on this order"
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
          "order_id": "6a95620b-1642-414c-832d-5438b95f3f03",
          "items": [
            {
              "type": "products",
              "id": "f54da0ab-ab03-4a37-a0cb-ce6cde3c45fa",
              "stock_item_ids": [
                "c456c034-e777-49d9-9ebd-a26b063fb242",
                "753bddd0-54a3-4bb4-bd0a-a4c092af9eaa",
                "ba17f907-7440-4b18-b00e-af550b79f326"
              ]
            },
            {
              "type": "products",
              "id": "9a649c0d-55dc-494b-b6c2-7abb8864df72",
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
    "id": "3a9f3315-a45e-5a78-9bc7-79c5919f3fa5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6a95620b-1642-414c-832d-5438b95f3f03"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6a95620b-1642-414c-832d-5438b95f3f03"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b54c12b1-1643-4c78-88ef-c73571405e3b"
          },
          {
            "type": "lines",
            "id": "6c45991b-c941-4590-8a88-1fb55737ce13"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b774030a-503f-45a4-95d8-7a4af311956a"
          },
          {
            "type": "plannings",
            "id": "d71ef4f1-3d13-4650-b54a-513380ff62bf"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ec2f3412-0c63-407b-8e15-aa477461af48"
          },
          {
            "type": "stock_item_plannings",
            "id": "7705727a-3c27-48ac-a361-f0f8b8743661"
          },
          {
            "type": "stock_item_plannings",
            "id": "c2bf4991-c4ee-4a01-9358-e4bbb38df6e4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6a95620b-1642-414c-832d-5438b95f3f03",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T10:57:47+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
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
        "customer_id": "99b3722a-0402-4b2f-80ee-c0657f93e573",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4",
        "stop_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4"
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
      "id": "b54c12b1-1643-4c78-88ef-c73571405e3b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
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
        "item_id": "f54da0ab-ab03-4a37-a0cb-ce6cde3c45fa",
        "tax_category_id": "cf64a113-15b2-46bf-b47e-a96aeec9b0c3",
        "planning_id": "b774030a-503f-45a4-95d8-7a4af311956a",
        "parent_line_id": null,
        "owner_id": "6a95620b-1642-414c-832d-5438b95f3f03",
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
      "id": "6c45991b-c941-4590-8a88-1fb55737ce13",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
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
        "item_id": "9a649c0d-55dc-494b-b6c2-7abb8864df72",
        "tax_category_id": "cf64a113-15b2-46bf-b47e-a96aeec9b0c3",
        "planning_id": "d71ef4f1-3d13-4650-b54a-513380ff62bf",
        "parent_line_id": null,
        "owner_id": "6a95620b-1642-414c-832d-5438b95f3f03",
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
      "id": "b774030a-503f-45a4-95d8-7a4af311956a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
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
        "item_id": "f54da0ab-ab03-4a37-a0cb-ce6cde3c45fa",
        "order_id": "6a95620b-1642-414c-832d-5438b95f3f03",
        "start_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4",
        "stop_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4",
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
      "id": "d71ef4f1-3d13-4650-b54a-513380ff62bf",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
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
        "item_id": "9a649c0d-55dc-494b-b6c2-7abb8864df72",
        "order_id": "6a95620b-1642-414c-832d-5438b95f3f03",
        "start_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4",
        "stop_location_id": "2f790677-d507-46ef-bc44-1ffa014efae4",
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
      "id": "ec2f3412-0c63-407b-8e15-aa477461af48",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c456c034-e777-49d9-9ebd-a26b063fb242",
        "planning_id": "b774030a-503f-45a4-95d8-7a4af311956a",
        "order_id": "6a95620b-1642-414c-832d-5438b95f3f03"
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
      "id": "7705727a-3c27-48ac-a361-f0f8b8743661",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "753bddd0-54a3-4bb4-bd0a-a4c092af9eaa",
        "planning_id": "b774030a-503f-45a4-95d8-7a4af311956a",
        "order_id": "6a95620b-1642-414c-832d-5438b95f3f03"
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
      "id": "c2bf4991-c4ee-4a01-9358-e4bbb38df6e4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:49+00:00",
        "updated_at": "2023-02-21T10:57:49+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ba17f907-7440-4b18-b00e-af550b79f326",
        "planning_id": "b774030a-503f-45a4-95d8-7a4af311956a",
        "order_id": "6a95620b-1642-414c-832d-5438b95f3f03"
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
          "order_id": "30d249b9-e855-44f1-a0df-9ea6386a2534",
          "items": [
            {
              "type": "bundles",
              "id": "07afe978-88b4-4c97-9dd4-dd92c249d8de",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "13cd4cd1-e3cd-4774-a29c-3aa9d935357b",
                  "id": "87440be9-7993-46f5-b838-c0eb00d2b375"
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
    "id": "c22296c8-b6f5-5c2a-993b-4f1d19e3904d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "30d249b9-e855-44f1-a0df-9ea6386a2534"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "30d249b9-e855-44f1-a0df-9ea6386a2534"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7720030c-3c13-436c-8c81-c4de2fee99e3"
          },
          {
            "type": "lines",
            "id": "8f44e93f-c1d2-478f-9e7d-c1cda15ac125"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "03d5b410-cec8-4c17-9b1d-c22bdbd5d850"
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
      "id": "30d249b9-e855-44f1-a0df-9ea6386a2534",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T10:57:52+00:00",
        "updated_at": "2023-02-21T10:57:53+00:00",
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
        "starts_at": "2023-02-19T10:45:00+00:00",
        "stops_at": "2023-02-23T10:45:00+00:00",
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
        "start_location_id": "18755ec3-bb68-4c62-8f8c-53c4561980d7",
        "stop_location_id": "18755ec3-bb68-4c62-8f8c-53c4561980d7"
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
      "id": "7720030c-3c13-436c-8c81-c4de2fee99e3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:57:53+00:00",
        "updated_at": "2023-02-21T10:57:53+00:00",
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
        "item_id": "07afe978-88b4-4c97-9dd4-dd92c249d8de",
        "tax_category_id": null,
        "planning_id": "03d5b410-cec8-4c17-9b1d-c22bdbd5d850",
        "parent_line_id": null,
        "owner_id": "30d249b9-e855-44f1-a0df-9ea6386a2534",
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
      "id": "8f44e93f-c1d2-478f-9e7d-c1cda15ac125",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:57:53+00:00",
        "updated_at": "2023-02-21T10:57:53+00:00",
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
        "item_id": "87440be9-7993-46f5-b838-c0eb00d2b375",
        "tax_category_id": null,
        "planning_id": "59382b9e-e348-4041-9f15-bcf5a6a6ec75",
        "parent_line_id": "7720030c-3c13-436c-8c81-c4de2fee99e3",
        "owner_id": "30d249b9-e855-44f1-a0df-9ea6386a2534",
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
      "id": "03d5b410-cec8-4c17-9b1d-c22bdbd5d850",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:57:53+00:00",
        "updated_at": "2023-02-21T10:57:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T10:45:00+00:00",
        "stops_at": "2023-02-23T10:45:00+00:00",
        "reserved_from": "2023-02-19T10:45:00+00:00",
        "reserved_till": "2023-02-23T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "07afe978-88b4-4c97-9dd4-dd92c249d8de",
        "order_id": "30d249b9-e855-44f1-a0df-9ea6386a2534",
        "start_location_id": "18755ec3-bb68-4c62-8f8c-53c4561980d7",
        "stop_location_id": "18755ec3-bb68-4c62-8f8c-53c4561980d7",
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





