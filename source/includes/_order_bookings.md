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
          "order_id": "47fa95f4-7cd5-42a9-9ca5-c1598d27a4b2",
          "items": [
            {
              "type": "products",
              "id": "7bcfdedd-5ed0-4270-a930-716e41b421bf",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f2db3e6d-4555-4f46-a76f-8c3c289c8583",
              "stock_item_ids": [
                "fccedc88-fa64-4d70-8a89-31d57f744a0b",
                "6a4f79b4-67a5-48b3-b238-8df3d9894343"
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
            "item_id": "7bcfdedd-5ed0-4270-a930-716e41b421bf",
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
          "order_id": "94132326-0e82-4287-9e62-3d267e623a71",
          "items": [
            {
              "type": "products",
              "id": "abdc0003-9f8c-4d6a-844e-4e00818feb28",
              "stock_item_ids": [
                "de94948c-0c90-4b8b-9433-affe1677854e",
                "b53fc1c5-f993-4f8f-9640-620a0314f9e8",
                "4a5619bd-d425-4086-957b-7fab11b075d7"
              ]
            },
            {
              "type": "products",
              "id": "ca02be43-9742-473b-b3d8-566b21364fcd",
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
    "id": "9c46149b-309b-5690-9f23-4028c62ff08f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "94132326-0e82-4287-9e62-3d267e623a71"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "94132326-0e82-4287-9e62-3d267e623a71"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "59b349a7-71ae-43f1-8118-aa891f5e5774"
          },
          {
            "type": "lines",
            "id": "1f035523-600b-461a-9778-5513390b8d50"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6eefc6bf-e2b3-4b29-aae9-be873b035bbd"
          },
          {
            "type": "plannings",
            "id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f5608abb-4687-4bcc-8e90-b15141d9a242"
          },
          {
            "type": "stock_item_plannings",
            "id": "be40756f-a8a0-486c-83ed-3da0d7d08341"
          },
          {
            "type": "stock_item_plannings",
            "id": "fc02e184-31cb-4810-831b-6113dda780a5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "94132326-0e82-4287-9e62-3d267e623a71",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T14:28:02+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
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
        "customer_id": "fcd17301-459e-4a23-8256-1e116590900f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775",
        "stop_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775"
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
      "id": "59b349a7-71ae-43f1-8118-aa891f5e5774",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T14:28:03+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
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
        "item_id": "ca02be43-9742-473b-b3d8-566b21364fcd",
        "tax_category_id": "0c24c72d-7006-4c92-b943-5e5860d6ce24",
        "planning_id": "6eefc6bf-e2b3-4b29-aae9-be873b035bbd",
        "parent_line_id": null,
        "owner_id": "94132326-0e82-4287-9e62-3d267e623a71",
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
      "id": "1f035523-600b-461a-9778-5513390b8d50",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T14:28:04+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
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
        "item_id": "abdc0003-9f8c-4d6a-844e-4e00818feb28",
        "tax_category_id": "0c24c72d-7006-4c92-b943-5e5860d6ce24",
        "planning_id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5",
        "parent_line_id": null,
        "owner_id": "94132326-0e82-4287-9e62-3d267e623a71",
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
      "id": "6eefc6bf-e2b3-4b29-aae9-be873b035bbd",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:03+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
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
        "item_id": "ca02be43-9742-473b-b3d8-566b21364fcd",
        "order_id": "94132326-0e82-4287-9e62-3d267e623a71",
        "start_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775",
        "stop_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775",
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
      "id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:04+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
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
        "item_id": "abdc0003-9f8c-4d6a-844e-4e00818feb28",
        "order_id": "94132326-0e82-4287-9e62-3d267e623a71",
        "start_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775",
        "stop_location_id": "c8006c31-6302-4cb8-b6e0-a29496aa9775",
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
      "id": "f5608abb-4687-4bcc-8e90-b15141d9a242",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:04+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "de94948c-0c90-4b8b-9433-affe1677854e",
        "planning_id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5",
        "order_id": "94132326-0e82-4287-9e62-3d267e623a71"
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
      "id": "be40756f-a8a0-486c-83ed-3da0d7d08341",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:04+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b53fc1c5-f993-4f8f-9640-620a0314f9e8",
        "planning_id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5",
        "order_id": "94132326-0e82-4287-9e62-3d267e623a71"
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
      "id": "fc02e184-31cb-4810-831b-6113dda780a5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:04+00:00",
        "updated_at": "2022-07-14T14:28:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4a5619bd-d425-4086-957b-7fab11b075d7",
        "planning_id": "848a606c-47d6-46bf-9fe2-95c0dcd9eda5",
        "order_id": "94132326-0e82-4287-9e62-3d267e623a71"
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
          "order_id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9",
          "items": [
            {
              "type": "bundles",
              "id": "5cf5d2d8-f76f-422c-a9ca-8826decb1637",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "cf4398a4-fc38-4814-a63a-d2848ffd4b60",
                  "id": "0d58c92a-5101-4a5b-9db7-3c7705339a38"
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
    "id": "51c83bbc-e0db-517e-9389-5a900d61c96a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "32b9f5d9-5f82-4462-b491-9dfa032c1c4d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "720cd0d8-8e2a-4480-967d-ce9f1f7ad1a6"
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
      "id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T14:28:06+00:00",
        "updated_at": "2022-07-14T14:28:07+00:00",
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
        "starts_at": "2022-07-12T14:15:00+00:00",
        "stops_at": "2022-07-16T14:15:00+00:00",
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
        "start_location_id": "76268bed-36cf-4cd5-b6ef-12f542e01cd1",
        "stop_location_id": "76268bed-36cf-4cd5-b6ef-12f542e01cd1"
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
      "id": "32b9f5d9-5f82-4462-b491-9dfa032c1c4d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T14:28:07+00:00",
        "updated_at": "2022-07-14T14:28:07+00:00",
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
        "item_id": "5cf5d2d8-f76f-422c-a9ca-8826decb1637",
        "tax_category_id": null,
        "planning_id": "720cd0d8-8e2a-4480-967d-ce9f1f7ad1a6",
        "parent_line_id": null,
        "owner_id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9",
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
      "id": "720cd0d8-8e2a-4480-967d-ce9f1f7ad1a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T14:28:07+00:00",
        "updated_at": "2022-07-14T14:28:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T14:15:00+00:00",
        "stops_at": "2022-07-16T14:15:00+00:00",
        "reserved_from": "2022-07-12T14:15:00+00:00",
        "reserved_till": "2022-07-16T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5cf5d2d8-f76f-422c-a9ca-8826decb1637",
        "order_id": "3fa4c069-21da-4d5a-a9ae-fd8ba74dd7a9",
        "start_location_id": "76268bed-36cf-4cd5-b6ef-12f542e01cd1",
        "stop_location_id": "76268bed-36cf-4cd5-b6ef-12f542e01cd1",
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





