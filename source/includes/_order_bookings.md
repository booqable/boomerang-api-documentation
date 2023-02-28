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
          "order_id": "03744961-83a6-47a6-b1e6-df08a8799106",
          "items": [
            {
              "type": "products",
              "id": "a3c4e0d3-b091-4b5c-98e5-22d7ee438640",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b51b2957-207f-4e08-af84-68c807ade1de",
              "stock_item_ids": [
                "97c73b4a-54c1-4791-9a7c-c1af7730bd32",
                "194b8b01-72b6-472a-9612-ad24351288f9"
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
          "stock_item_id 97c73b4a-54c1-4791-9a7c-c1af7730bd32 has already been booked on this order"
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
          "order_id": "add80edc-227c-4000-a7be-8f0e696f754d",
          "items": [
            {
              "type": "products",
              "id": "b38f4b70-33c7-4c96-a46e-e96b17efe3cc",
              "stock_item_ids": [
                "9f471f23-6a41-4903-9e11-8d8b609399a2",
                "00c78f68-4890-47f8-b94b-9f2d950b6c4e",
                "e58c8064-b649-46df-a9b0-ea5a7b906a49"
              ]
            },
            {
              "type": "products",
              "id": "9071aa9b-e5ee-4852-a7a2-91cdb39ac511",
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
    "id": "13b3a08d-b70c-5f6a-b1ac-aeddbfbb477d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "add80edc-227c-4000-a7be-8f0e696f754d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "add80edc-227c-4000-a7be-8f0e696f754d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4ba38c42-e618-4eee-902e-17ffc98faab0"
          },
          {
            "type": "lines",
            "id": "1970e185-2303-4fd6-a10d-e0b43e32c2be"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1239c97c-7a6f-4eac-9744-b6d3b627e658"
          },
          {
            "type": "plannings",
            "id": "e8b3c7ab-0981-4e06-94fc-db034247e505"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "01feebc4-22d9-44cd-8da9-1625cbf7fb57"
          },
          {
            "type": "stock_item_plannings",
            "id": "dbf5774a-2456-477f-92a7-f22c1b47a195"
          },
          {
            "type": "stock_item_plannings",
            "id": "5dbdf5b3-8b7d-4e3b-b9a6-6a3f08c083e3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "add80edc-227c-4000-a7be-8f0e696f754d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T08:12:23+00:00",
        "updated_at": "2023-02-28T08:12:25+00:00",
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
        "customer_id": "6c4f5c54-4d56-41ae-b8a7-f254ee5e8bbf",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707",
        "stop_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707"
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
      "id": "4ba38c42-e618-4eee-902e-17ffc98faab0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
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
        "item_id": "b38f4b70-33c7-4c96-a46e-e96b17efe3cc",
        "tax_category_id": "0f9d1ec1-c830-47ec-88db-ceac6a9d1afa",
        "planning_id": "1239c97c-7a6f-4eac-9744-b6d3b627e658",
        "parent_line_id": null,
        "owner_id": "add80edc-227c-4000-a7be-8f0e696f754d",
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
      "id": "1970e185-2303-4fd6-a10d-e0b43e32c2be",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
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
        "item_id": "9071aa9b-e5ee-4852-a7a2-91cdb39ac511",
        "tax_category_id": "0f9d1ec1-c830-47ec-88db-ceac6a9d1afa",
        "planning_id": "e8b3c7ab-0981-4e06-94fc-db034247e505",
        "parent_line_id": null,
        "owner_id": "add80edc-227c-4000-a7be-8f0e696f754d",
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
      "id": "1239c97c-7a6f-4eac-9744-b6d3b627e658",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
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
        "item_id": "b38f4b70-33c7-4c96-a46e-e96b17efe3cc",
        "order_id": "add80edc-227c-4000-a7be-8f0e696f754d",
        "start_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707",
        "stop_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707",
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
      "id": "e8b3c7ab-0981-4e06-94fc-db034247e505",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
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
        "item_id": "9071aa9b-e5ee-4852-a7a2-91cdb39ac511",
        "order_id": "add80edc-227c-4000-a7be-8f0e696f754d",
        "start_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707",
        "stop_location_id": "2ca3dc3e-0381-4229-a8a3-fa56383cb707",
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
      "id": "01feebc4-22d9-44cd-8da9-1625cbf7fb57",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9f471f23-6a41-4903-9e11-8d8b609399a2",
        "planning_id": "1239c97c-7a6f-4eac-9744-b6d3b627e658",
        "order_id": "add80edc-227c-4000-a7be-8f0e696f754d"
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
      "id": "dbf5774a-2456-477f-92a7-f22c1b47a195",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "00c78f68-4890-47f8-b94b-9f2d950b6c4e",
        "planning_id": "1239c97c-7a6f-4eac-9744-b6d3b627e658",
        "order_id": "add80edc-227c-4000-a7be-8f0e696f754d"
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
      "id": "5dbdf5b3-8b7d-4e3b-b9a6-6a3f08c083e3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:24+00:00",
        "updated_at": "2023-02-28T08:12:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e58c8064-b649-46df-a9b0-ea5a7b906a49",
        "planning_id": "1239c97c-7a6f-4eac-9744-b6d3b627e658",
        "order_id": "add80edc-227c-4000-a7be-8f0e696f754d"
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
          "order_id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff",
          "items": [
            {
              "type": "bundles",
              "id": "df663da7-a7d1-413e-9d01-f3b44836b4d9",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6bc855c2-edd1-4b74-8a0e-3aac51db48db",
                  "id": "764dfd93-e1fc-4f39-8972-58dcdc339414"
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
    "id": "f1a50345-2e0f-5b11-be94-be680f51bcc9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b300a6bd-01a0-49a8-ac25-89bfb1a216e0"
          },
          {
            "type": "lines",
            "id": "27dcc8d7-eb94-4a11-8333-a62b06fda1e7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "99efe80a-6f7c-4a65-8139-afa0deb7e688"
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
      "id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T08:12:27+00:00",
        "updated_at": "2023-02-28T08:12:27+00:00",
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
        "starts_at": "2023-02-26T08:00:00+00:00",
        "stops_at": "2023-03-02T08:00:00+00:00",
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
        "start_location_id": "43772b9d-e0ff-4c25-a012-f3ca68aee5d5",
        "stop_location_id": "43772b9d-e0ff-4c25-a012-f3ca68aee5d5"
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
      "id": "b300a6bd-01a0-49a8-ac25-89bfb1a216e0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:12:27+00:00",
        "updated_at": "2023-02-28T08:12:27+00:00",
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
        "item_id": "df663da7-a7d1-413e-9d01-f3b44836b4d9",
        "tax_category_id": null,
        "planning_id": "99efe80a-6f7c-4a65-8139-afa0deb7e688",
        "parent_line_id": null,
        "owner_id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff",
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
      "id": "27dcc8d7-eb94-4a11-8333-a62b06fda1e7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T08:12:27+00:00",
        "updated_at": "2023-02-28T08:12:27+00:00",
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
        "item_id": "764dfd93-e1fc-4f39-8972-58dcdc339414",
        "tax_category_id": null,
        "planning_id": "e465b8bf-efac-4898-aa34-0c0e5741cb5c",
        "parent_line_id": "b300a6bd-01a0-49a8-ac25-89bfb1a216e0",
        "owner_id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff",
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
      "id": "99efe80a-6f7c-4a65-8139-afa0deb7e688",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T08:12:27+00:00",
        "updated_at": "2023-02-28T08:12:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-26T08:00:00+00:00",
        "stops_at": "2023-03-02T08:00:00+00:00",
        "reserved_from": "2023-02-26T08:00:00+00:00",
        "reserved_till": "2023-03-02T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "df663da7-a7d1-413e-9d01-f3b44836b4d9",
        "order_id": "d49fb2f4-0fd7-4dde-8b76-f37b107120ff",
        "start_location_id": "43772b9d-e0ff-4c25-a012-f3ca68aee5d5",
        "stop_location_id": "43772b9d-e0ff-4c25-a012-f3ca68aee5d5",
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





