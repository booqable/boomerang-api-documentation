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
          "order_id": "6a159709-9e9e-4b67-aeb6-763b5a19f98b",
          "items": [
            {
              "type": "products",
              "id": "ae92f043-420a-4bd7-b286-485621aaa160",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e2c74ffe-86c1-4b02-bde6-6e4a9a009904",
              "stock_item_ids": [
                "bdab677d-89be-4601-97db-dacebd91fab8",
                "bbcf8c25-3ae5-4693-ae29-88feb638bda8"
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
          "stock_item_id bdab677d-89be-4601-97db-dacebd91fab8 has already been booked on this order"
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
          "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495",
          "items": [
            {
              "type": "products",
              "id": "917720f1-1551-4f2d-b7af-628a1076a816",
              "stock_item_ids": [
                "73a1d90f-5d8e-4507-a812-808ebb98e2c8",
                "d92bc79d-8b07-4a25-b029-2940912ba081",
                "8e3a814b-fcc2-49a5-b367-d3603693deff"
              ]
            },
            {
              "type": "products",
              "id": "c2181bb4-ba04-4522-b26b-df39abb07651",
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
    "id": "43621808-36e9-54c4-a4eb-e7d1a752c6c9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c30e252e-c69d-4097-921b-3aedeb17a495"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c84d8876-96f3-4a1c-9c24-d871e21a8e85"
          },
          {
            "type": "lines",
            "id": "caaaa4af-2362-4923-9f4a-43ee63964268"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4"
          },
          {
            "type": "plannings",
            "id": "c7538619-797b-4ae6-8d9c-3049197c595d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b9b9cf7c-450e-4155-a5d3-b7af0f7b59e8"
          },
          {
            "type": "stock_item_plannings",
            "id": "dc84dc0b-f1fd-43a2-a150-f75fdd275f22"
          },
          {
            "type": "stock_item_plannings",
            "id": "a74768f0-a6f3-4b08-bfcc-98f1e49afc45"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c30e252e-c69d-4097-921b-3aedeb17a495",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T12:11:51+00:00",
        "updated_at": "2023-03-07T12:11:53+00:00",
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
        "customer_id": "0d46b009-b8ba-43e2-ba4c-c8d2a3509417",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe",
        "stop_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe"
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
      "id": "c84d8876-96f3-4a1c-9c24-d871e21a8e85",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:53+00:00",
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
        "item_id": "917720f1-1551-4f2d-b7af-628a1076a816",
        "tax_category_id": "3667cacf-10f4-41e5-b63a-27a9ab3cd775",
        "planning_id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4",
        "parent_line_id": null,
        "owner_id": "c30e252e-c69d-4097-921b-3aedeb17a495",
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
      "id": "caaaa4af-2362-4923-9f4a-43ee63964268",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:53+00:00",
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
        "item_id": "c2181bb4-ba04-4522-b26b-df39abb07651",
        "tax_category_id": "3667cacf-10f4-41e5-b63a-27a9ab3cd775",
        "planning_id": "c7538619-797b-4ae6-8d9c-3049197c595d",
        "parent_line_id": null,
        "owner_id": "c30e252e-c69d-4097-921b-3aedeb17a495",
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
      "id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:52+00:00",
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
        "item_id": "917720f1-1551-4f2d-b7af-628a1076a816",
        "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495",
        "start_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe",
        "stop_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe",
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
      "id": "c7538619-797b-4ae6-8d9c-3049197c595d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:52+00:00",
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
        "item_id": "c2181bb4-ba04-4522-b26b-df39abb07651",
        "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495",
        "start_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe",
        "stop_location_id": "5ac541be-fa2a-4674-987b-442d3ab0acfe",
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
      "id": "b9b9cf7c-450e-4155-a5d3-b7af0f7b59e8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "73a1d90f-5d8e-4507-a812-808ebb98e2c8",
        "planning_id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4",
        "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495"
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
      "id": "dc84dc0b-f1fd-43a2-a150-f75fdd275f22",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d92bc79d-8b07-4a25-b029-2940912ba081",
        "planning_id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4",
        "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495"
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
      "id": "a74768f0-a6f3-4b08-bfcc-98f1e49afc45",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:52+00:00",
        "updated_at": "2023-03-07T12:11:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e3a814b-fcc2-49a5-b367-d3603693deff",
        "planning_id": "8eecd69a-fb88-4828-ae49-6e9d7aab17e4",
        "order_id": "c30e252e-c69d-4097-921b-3aedeb17a495"
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
          "order_id": "29fe3d6f-950b-4699-891b-1d115bdb4a83",
          "items": [
            {
              "type": "bundles",
              "id": "15a36a81-7b54-422e-9694-7701af90494c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6f279697-b319-47a8-9faa-06b0bc9343ed",
                  "id": "71a3594e-1d59-4980-84b3-e72791a0bf7e"
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
    "id": "c4de1a58-a472-5bdb-baef-826603a9abd8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "29fe3d6f-950b-4699-891b-1d115bdb4a83"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "29fe3d6f-950b-4699-891b-1d115bdb4a83"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4ee442e1-ffb7-47af-9823-e2a3ace0940c"
          },
          {
            "type": "lines",
            "id": "a7a24cef-df46-4e83-98ed-938df59f6238"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ad05b43e-7867-4ae4-9503-bb05c87c4e79"
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
      "id": "29fe3d6f-950b-4699-891b-1d115bdb4a83",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T12:11:55+00:00",
        "updated_at": "2023-03-07T12:11:55+00:00",
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
        "starts_at": "2023-03-05T12:00:00+00:00",
        "stops_at": "2023-03-09T12:00:00+00:00",
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
        "start_location_id": "2d26a0d1-b9b1-44bf-9073-7fd6a39f18d8",
        "stop_location_id": "2d26a0d1-b9b1-44bf-9073-7fd6a39f18d8"
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
      "id": "4ee442e1-ffb7-47af-9823-e2a3ace0940c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T12:11:55+00:00",
        "updated_at": "2023-03-07T12:11:55+00:00",
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
        "item_id": "15a36a81-7b54-422e-9694-7701af90494c",
        "tax_category_id": null,
        "planning_id": "ad05b43e-7867-4ae4-9503-bb05c87c4e79",
        "parent_line_id": null,
        "owner_id": "29fe3d6f-950b-4699-891b-1d115bdb4a83",
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
      "id": "a7a24cef-df46-4e83-98ed-938df59f6238",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T12:11:55+00:00",
        "updated_at": "2023-03-07T12:11:55+00:00",
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
        "item_id": "71a3594e-1d59-4980-84b3-e72791a0bf7e",
        "tax_category_id": null,
        "planning_id": "e0cbfe89-bdaf-4b58-a670-2451609f174a",
        "parent_line_id": "4ee442e1-ffb7-47af-9823-e2a3ace0940c",
        "owner_id": "29fe3d6f-950b-4699-891b-1d115bdb4a83",
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
      "id": "ad05b43e-7867-4ae4-9503-bb05c87c4e79",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T12:11:55+00:00",
        "updated_at": "2023-03-07T12:11:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-05T12:00:00+00:00",
        "stops_at": "2023-03-09T12:00:00+00:00",
        "reserved_from": "2023-03-05T12:00:00+00:00",
        "reserved_till": "2023-03-09T12:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "15a36a81-7b54-422e-9694-7701af90494c",
        "order_id": "29fe3d6f-950b-4699-891b-1d115bdb4a83",
        "start_location_id": "2d26a0d1-b9b1-44bf-9073-7fd6a39f18d8",
        "stop_location_id": "2d26a0d1-b9b1-44bf-9073-7fd6a39f18d8",
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





