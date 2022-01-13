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
          "order_id": "15f34e44-29c0-4cb0-99c9-395f31c4e89b",
          "items": [
            {
              "type": "products",
              "id": "78fbae48-1ea5-4654-9ec5-a65fed3d17d4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "85d95b58-f500-409d-b960-b8104473b5dc",
              "stock_item_ids": [
                "ab2e2b03-8210-437a-9163-63e8f2ff5aee",
                "11545fe6-37fd-483b-8f17-c86db31dd045"
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
            "item_id": "78fbae48-1ea5-4654-9ec5-a65fed3d17d4",
            "stock_count": 7,
            "reserved": 0,
            "needed": 10,
            "shortage": 3
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
          "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
          "items": [
            {
              "type": "products",
              "id": "b991b56e-b0ac-48f8-85d7-0ce2c3d17cae",
              "stock_item_ids": [
                "da8ca991-9161-4039-b0f1-c29e033cb9a8",
                "d2755205-4e87-49db-a5ce-c851dc35f754",
                "7552c134-56fc-425c-88fe-d0f00baafffc"
              ]
            },
            {
              "type": "products",
              "id": "5c3ce3dd-a2ff-4c38-8f75-8531009619f9",
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
    "id": "7d08c6f7-3d1e-5a67-b737-919669ac53d2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0e5bd153-34f5-4fe0-b817-9f0a97241873"
          },
          {
            "type": "lines",
            "id": "80c3f0ad-c206-4176-a71b-a75ad6872a3e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2ee0dd58-c907-4555-b41d-e28b5ac9c413"
          },
          {
            "type": "plannings",
            "id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ffecedbf-17b6-4b69-ae84-9cbc0261f963"
          },
          {
            "type": "stock_item_plannings",
            "id": "7eb30ccd-a2dc-46b6-ba8c-d0064d27df81"
          },
          {
            "type": "stock_item_plannings",
            "id": "c9a7583a-1dd7-47d6-97c8-7a872526c389"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-13T11:42:34+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
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
        "customer_id": "ec7315a4-0141-4c52-9311-34fb83fa6742",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67",
        "stop_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67"
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
      "id": "0e5bd153-34f5-4fe0-b817-9f0a97241873",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T11:42:34+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
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
        "item_id": "5c3ce3dd-a2ff-4c38-8f75-8531009619f9",
        "tax_category_id": "f1f41a88-ef00-42c7-86f1-1ef62074a323",
        "planning_id": "2ee0dd58-c907-4555-b41d-e28b5ac9c413",
        "parent_line_id": null,
        "owner_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
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
      "id": "80c3f0ad-c206-4176-a71b-a75ad6872a3e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T11:42:35+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
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
        "item_id": "b991b56e-b0ac-48f8-85d7-0ce2c3d17cae",
        "tax_category_id": "f1f41a88-ef00-42c7-86f1-1ef62074a323",
        "planning_id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62",
        "parent_line_id": null,
        "owner_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
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
      "id": "2ee0dd58-c907-4555-b41d-e28b5ac9c413",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:34+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
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
        "item_id": "5c3ce3dd-a2ff-4c38-8f75-8531009619f9",
        "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
        "start_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67",
        "stop_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67",
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
      "id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:35+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
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
        "item_id": "b991b56e-b0ac-48f8-85d7-0ce2c3d17cae",
        "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9",
        "start_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67",
        "stop_location_id": "755fbbd2-dfe0-4340-8c42-b062cd8ebc67",
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
      "id": "ffecedbf-17b6-4b69-ae84-9cbc0261f963",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:35+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "da8ca991-9161-4039-b0f1-c29e033cb9a8",
        "planning_id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62",
        "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9"
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
      "id": "7eb30ccd-a2dc-46b6-ba8c-d0064d27df81",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:35+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d2755205-4e87-49db-a5ce-c851dc35f754",
        "planning_id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62",
        "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9"
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
      "id": "c9a7583a-1dd7-47d6-97c8-7a872526c389",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:35+00:00",
        "updated_at": "2022-01-13T11:42:35+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7552c134-56fc-425c-88fe-d0f00baafffc",
        "planning_id": "9b9d6eb4-e6d5-4797-b784-eaec9a2fce62",
        "order_id": "bbeccf1f-b042-4783-84b4-8a9555b9e1a9"
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
          "order_id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4",
          "items": [
            {
              "type": "bundles",
              "id": "19474871-03ea-48bb-bd12-cb6463827558",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8a8895f0-8ea7-4b58-ae59-c427c1e803d2",
                  "id": "a49649ce-076e-4b74-b1e9-6251363d1080"
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
    "id": "65176096-135a-5f3d-8f4c-c3ddf50aacc0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "51c09739-3d03-4e96-9cd3-9d625b975cb3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ed906a46-3803-4883-87d7-d80ced26830d"
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
      "id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-13T11:42:37+00:00",
        "updated_at": "2022-01-13T11:42:38+00:00",
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
        "starts_at": "2022-01-11T11:30:00+00:00",
        "stops_at": "2022-01-15T11:30:00+00:00",
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
        "start_location_id": "e5f01680-d2d1-4da8-aac4-dab69c421889",
        "stop_location_id": "e5f01680-d2d1-4da8-aac4-dab69c421889"
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
      "id": "51c09739-3d03-4e96-9cd3-9d625b975cb3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-13T11:42:38+00:00",
        "updated_at": "2022-01-13T11:42:38+00:00",
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
        "item_id": "19474871-03ea-48bb-bd12-cb6463827558",
        "tax_category_id": null,
        "planning_id": "ed906a46-3803-4883-87d7-d80ced26830d",
        "parent_line_id": null,
        "owner_id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4",
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
      "id": "ed906a46-3803-4883-87d7-d80ced26830d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-13T11:42:38+00:00",
        "updated_at": "2022-01-13T11:42:38+00:00",
        "quantity": 1,
        "starts_at": "2022-01-11T11:30:00+00:00",
        "stops_at": "2022-01-15T11:30:00+00:00",
        "reserved_from": "2022-01-11T11:30:00+00:00",
        "reserved_till": "2022-01-15T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "19474871-03ea-48bb-bd12-cb6463827558",
        "order_id": "70cce225-2ba2-4f54-85b3-b23572e2b6c4",
        "start_location_id": "e5f01680-d2d1-4da8-aac4-dab69c421889",
        "stop_location_id": "e5f01680-d2d1-4da8-aac4-dab69c421889",
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





