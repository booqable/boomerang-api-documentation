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
          "order_id": "37591153-da34-4fe4-a9cd-47731330b712",
          "items": [
            {
              "type": "products",
              "id": "914b9224-ab66-4f90-ba60-3e6400f0e12e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a9c2b40a-8b87-4ad3-b606-698b8870522e",
              "stock_item_ids": [
                "1aeedae3-8b02-45ec-9397-f480d3712c3a",
                "e3c46440-1b1a-460b-8739-6401a4577ca3"
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
            "item_id": "914b9224-ab66-4f90-ba60-3e6400f0e12e",
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
          "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
          "items": [
            {
              "type": "products",
              "id": "6c06829c-193f-4d83-bf13-1293d76965ce",
              "stock_item_ids": [
                "8b9d8be3-9a95-4724-af6c-1a3a414b1bd9",
                "f658a684-9981-4b20-b631-f5cf88f90e83",
                "5e4694de-ff09-49f3-8394-68f77bedfc04"
              ]
            },
            {
              "type": "products",
              "id": "e5d40707-6450-4c30-a8ab-3853a2d16776",
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
    "id": "1058134e-a536-51c3-b601-e6b9e34c8465",
    "type": "order_bookings",
    "attributes": {
      "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f5f16fbc-a8a3-49af-bf75-f33a15477e66"
          },
          {
            "type": "lines",
            "id": "7681a382-7510-42bb-8051-af894011f2a4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2b26ba94-9141-4e39-96b0-5fbb0a56de54"
          },
          {
            "type": "plannings",
            "id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b9210867-b4f6-4788-a912-b88a7007aef2"
          },
          {
            "type": "stock_item_plannings",
            "id": "556d5450-046a-4e36-a404-b69fdb3327c8"
          },
          {
            "type": "stock_item_plannings",
            "id": "d10df561-b7e3-4550-91b6-9b32a5ba58df"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-19T14:23:40+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
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
        "customer_id": "95cab9a1-8a4a-4973-9083-0062f11e0803",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a",
        "stop_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a"
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
      "id": "f5f16fbc-a8a3-49af-bf75-f33a15477e66",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T14:23:41+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
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
        "item_id": "e5d40707-6450-4c30-a8ab-3853a2d16776",
        "tax_category_id": "10f70d10-7b7a-4909-b3fd-529d27846a56",
        "planning_id": "2b26ba94-9141-4e39-96b0-5fbb0a56de54",
        "parent_line_id": null,
        "owner_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
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
      "id": "7681a382-7510-42bb-8051-af894011f2a4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T14:23:42+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
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
        "item_id": "6c06829c-193f-4d83-bf13-1293d76965ce",
        "tax_category_id": "10f70d10-7b7a-4909-b3fd-529d27846a56",
        "planning_id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe",
        "parent_line_id": null,
        "owner_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
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
      "id": "2b26ba94-9141-4e39-96b0-5fbb0a56de54",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:41+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
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
        "item_id": "e5d40707-6450-4c30-a8ab-3853a2d16776",
        "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
        "start_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a",
        "stop_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a",
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
      "id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:42+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
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
        "item_id": "6c06829c-193f-4d83-bf13-1293d76965ce",
        "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a",
        "start_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a",
        "stop_location_id": "39a4bd28-f0c8-416a-8ed3-2bbb5a45e52a",
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
      "id": "b9210867-b4f6-4788-a912-b88a7007aef2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:42+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b9d8be3-9a95-4724-af6c-1a3a414b1bd9",
        "planning_id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe",
        "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a"
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
      "id": "556d5450-046a-4e36-a404-b69fdb3327c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:42+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f658a684-9981-4b20-b631-f5cf88f90e83",
        "planning_id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe",
        "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a"
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
      "id": "d10df561-b7e3-4550-91b6-9b32a5ba58df",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:42+00:00",
        "updated_at": "2022-05-19T14:23:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5e4694de-ff09-49f3-8394-68f77bedfc04",
        "planning_id": "817cad6e-d2c5-4b57-83c6-b3bc1a7917fe",
        "order_id": "edfdae7f-7687-4374-9214-0ad2ebe15f9a"
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
          "order_id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37",
          "items": [
            {
              "type": "bundles",
              "id": "c96fd5d8-3239-4d58-84c3-9dd2afe0c822",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "621105d0-b270-44f8-970d-e102cc02c406",
                  "id": "3a54e913-3b0e-4986-9130-7d570c424d31"
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
    "id": "5dc3db75-802b-58e2-8e84-3767f592afe0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7cb00a4b-f986-4b9f-a349-d1a3f3cd420c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7536a51d-b8ca-49c2-abee-fd7872bcecf7"
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
      "id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-19T14:23:44+00:00",
        "updated_at": "2022-05-19T14:23:45+00:00",
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
        "starts_at": "2022-05-17T14:15:00+00:00",
        "stops_at": "2022-05-21T14:15:00+00:00",
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
        "start_location_id": "97d8a237-5c2b-40d3-998b-94c5df773975",
        "stop_location_id": "97d8a237-5c2b-40d3-998b-94c5df773975"
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
      "id": "7cb00a4b-f986-4b9f-a349-d1a3f3cd420c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T14:23:44+00:00",
        "updated_at": "2022-05-19T14:23:44+00:00",
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
        "item_id": "c96fd5d8-3239-4d58-84c3-9dd2afe0c822",
        "tax_category_id": null,
        "planning_id": "7536a51d-b8ca-49c2-abee-fd7872bcecf7",
        "parent_line_id": null,
        "owner_id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37",
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
      "id": "7536a51d-b8ca-49c2-abee-fd7872bcecf7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T14:23:44+00:00",
        "updated_at": "2022-05-19T14:23:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-17T14:15:00+00:00",
        "stops_at": "2022-05-21T14:15:00+00:00",
        "reserved_from": "2022-05-17T14:15:00+00:00",
        "reserved_till": "2022-05-21T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c96fd5d8-3239-4d58-84c3-9dd2afe0c822",
        "order_id": "1cbfab6e-9c1a-401b-80e7-4759d9414a37",
        "start_location_id": "97d8a237-5c2b-40d3-998b-94c5df773975",
        "stop_location_id": "97d8a237-5c2b-40d3-998b-94c5df773975",
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





