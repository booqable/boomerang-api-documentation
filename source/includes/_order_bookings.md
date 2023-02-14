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
          "order_id": "84e58f9d-dfbd-4af4-8648-8fa5ec9e54bb",
          "items": [
            {
              "type": "products",
              "id": "0ba8e81f-11f9-4172-ac30-492153c92b46",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "36454e5c-5584-42a1-bb6c-8e541509f09e",
              "stock_item_ids": [
                "c20328b1-cf54-4e94-910e-adfbba3f4dbf",
                "5441e710-8545-4324-a26e-38df56b0a62c"
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
          "stock_item_id c20328b1-cf54-4e94-910e-adfbba3f4dbf has already been booked on this order"
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
          "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24",
          "items": [
            {
              "type": "products",
              "id": "5ee7f9aa-f12e-4882-ae23-9cf7a716b8ac",
              "stock_item_ids": [
                "180a7c46-08fd-409b-b503-41ee09257db8",
                "e0f2c35a-7fbd-411a-a925-85eb7149bee4",
                "1b5bebc2-fb28-4695-88f4-5cdfa17e8f76"
              ]
            },
            {
              "type": "products",
              "id": "392fb3a2-d70a-4c49-a337-5c43a2de16c6",
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
    "id": "5c480650-00a3-5486-863c-ced93513c55e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "62f99b26-f1b3-481c-8846-bcd220010e24"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "567466f6-4a73-4eda-9f09-1d19ac9e7227"
          },
          {
            "type": "lines",
            "id": "af731c23-efd0-423b-bfa6-6a6ca89b9e53"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "60c55c66-b2db-420b-9083-181f1715bd15"
          },
          {
            "type": "plannings",
            "id": "1c3fdea3-e12e-495e-902e-60c21322f3ae"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a63c7d09-e310-449b-926a-3762e195401d"
          },
          {
            "type": "stock_item_plannings",
            "id": "0846f375-6ce2-4a37-89ec-82c954d32447"
          },
          {
            "type": "stock_item_plannings",
            "id": "0f62fc33-6b2c-441a-a489-cb5f4d8e9f71"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "62f99b26-f1b3-481c-8846-bcd220010e24",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T15:28:23+00:00",
        "updated_at": "2023-02-14T15:28:26+00:00",
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
        "customer_id": "bcb831cc-e02a-41c5-b128-0cb06fdddb60",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555",
        "stop_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555"
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
      "id": "567466f6-4a73-4eda-9f09-1d19ac9e7227",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:26+00:00",
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
        "item_id": "5ee7f9aa-f12e-4882-ae23-9cf7a716b8ac",
        "tax_category_id": "cfe8e6d4-0a72-48cc-9d8e-80798b54403d",
        "planning_id": "60c55c66-b2db-420b-9083-181f1715bd15",
        "parent_line_id": null,
        "owner_id": "62f99b26-f1b3-481c-8846-bcd220010e24",
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
      "id": "af731c23-efd0-423b-bfa6-6a6ca89b9e53",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:26+00:00",
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
        "item_id": "392fb3a2-d70a-4c49-a337-5c43a2de16c6",
        "tax_category_id": "cfe8e6d4-0a72-48cc-9d8e-80798b54403d",
        "planning_id": "1c3fdea3-e12e-495e-902e-60c21322f3ae",
        "parent_line_id": null,
        "owner_id": "62f99b26-f1b3-481c-8846-bcd220010e24",
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
      "id": "60c55c66-b2db-420b-9083-181f1715bd15",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:26+00:00",
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
        "item_id": "5ee7f9aa-f12e-4882-ae23-9cf7a716b8ac",
        "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24",
        "start_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555",
        "stop_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555",
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
      "id": "1c3fdea3-e12e-495e-902e-60c21322f3ae",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:26+00:00",
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
        "item_id": "392fb3a2-d70a-4c49-a337-5c43a2de16c6",
        "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24",
        "start_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555",
        "stop_location_id": "93eef773-6d23-43cb-9d9a-a0b59762b555",
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
      "id": "a63c7d09-e310-449b-926a-3762e195401d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "180a7c46-08fd-409b-b503-41ee09257db8",
        "planning_id": "60c55c66-b2db-420b-9083-181f1715bd15",
        "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24"
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
      "id": "0846f375-6ce2-4a37-89ec-82c954d32447",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e0f2c35a-7fbd-411a-a925-85eb7149bee4",
        "planning_id": "60c55c66-b2db-420b-9083-181f1715bd15",
        "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24"
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
      "id": "0f62fc33-6b2c-441a-a489-cb5f4d8e9f71",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:25+00:00",
        "updated_at": "2023-02-14T15:28:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1b5bebc2-fb28-4695-88f4-5cdfa17e8f76",
        "planning_id": "60c55c66-b2db-420b-9083-181f1715bd15",
        "order_id": "62f99b26-f1b3-481c-8846-bcd220010e24"
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
          "order_id": "916b2627-9cfe-4031-9614-1af0406b6f69",
          "items": [
            {
              "type": "bundles",
              "id": "550924f1-b031-4780-b0e2-cee17d22ddac",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "929ad448-5bb4-4331-bc7f-153ced9fa557",
                  "id": "8dcf552b-673c-426e-97c0-01f63c7273e5"
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
    "id": "03e8e6b8-335a-5d90-ab6a-fbf585fe4b04",
    "type": "order_bookings",
    "attributes": {
      "order_id": "916b2627-9cfe-4031-9614-1af0406b6f69"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "916b2627-9cfe-4031-9614-1af0406b6f69"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6495543d-a23c-44ad-9f42-d9b607fb1676"
          },
          {
            "type": "lines",
            "id": "f60ad20d-aeb3-48b4-a35d-8907bdc8c57e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "59f77a3c-ca23-46db-8cd9-d9e6fea9ca3b"
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
      "id": "916b2627-9cfe-4031-9614-1af0406b6f69",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T15:28:29+00:00",
        "updated_at": "2023-02-14T15:28:30+00:00",
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
        "starts_at": "2023-02-12T15:15:00+00:00",
        "stops_at": "2023-02-16T15:15:00+00:00",
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
        "start_location_id": "1c6826fd-e425-4750-b3a0-54bf71ff0a87",
        "stop_location_id": "1c6826fd-e425-4750-b3a0-54bf71ff0a87"
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
      "id": "6495543d-a23c-44ad-9f42-d9b607fb1676",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T15:28:29+00:00",
        "updated_at": "2023-02-14T15:28:29+00:00",
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
        "item_id": "550924f1-b031-4780-b0e2-cee17d22ddac",
        "tax_category_id": null,
        "planning_id": "59f77a3c-ca23-46db-8cd9-d9e6fea9ca3b",
        "parent_line_id": null,
        "owner_id": "916b2627-9cfe-4031-9614-1af0406b6f69",
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
      "id": "f60ad20d-aeb3-48b4-a35d-8907bdc8c57e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T15:28:29+00:00",
        "updated_at": "2023-02-14T15:28:29+00:00",
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
        "item_id": "8dcf552b-673c-426e-97c0-01f63c7273e5",
        "tax_category_id": null,
        "planning_id": "8304acbd-7f83-4259-90a3-a879bed3fd9e",
        "parent_line_id": "6495543d-a23c-44ad-9f42-d9b607fb1676",
        "owner_id": "916b2627-9cfe-4031-9614-1af0406b6f69",
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
      "id": "59f77a3c-ca23-46db-8cd9-d9e6fea9ca3b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T15:28:29+00:00",
        "updated_at": "2023-02-14T15:28:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-12T15:15:00+00:00",
        "stops_at": "2023-02-16T15:15:00+00:00",
        "reserved_from": "2023-02-12T15:15:00+00:00",
        "reserved_till": "2023-02-16T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "550924f1-b031-4780-b0e2-cee17d22ddac",
        "order_id": "916b2627-9cfe-4031-9614-1af0406b6f69",
        "start_location_id": "1c6826fd-e425-4750-b3a0-54bf71ff0a87",
        "stop_location_id": "1c6826fd-e425-4750-b3a0-54bf71ff0a87",
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





