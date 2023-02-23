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
          "order_id": "e6799d33-ac9f-4360-9f13-95741085833a",
          "items": [
            {
              "type": "products",
              "id": "4c5faeaa-7d1a-422a-b97b-4ba54216813d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2c1fd25b-804b-4e47-b74b-fd16531af092",
              "stock_item_ids": [
                "e49d7df1-e557-4915-bdbf-42178610279f",
                "7abc6679-6458-4bbe-838b-633988dbd89c"
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
          "stock_item_id e49d7df1-e557-4915-bdbf-42178610279f has already been booked on this order"
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
          "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
          "items": [
            {
              "type": "products",
              "id": "68259cc5-0711-4c04-9ae6-ddbedc7e2420",
              "stock_item_ids": [
                "e0140edb-3f73-402b-a742-89c1127cdcd1",
                "67c3b7ae-52b2-4663-bd92-83351ca75605",
                "6da15dcf-6030-4e50-bd7b-dd90426036cf"
              ]
            },
            {
              "type": "products",
              "id": "ba09cde6-dfbc-481c-a220-826b61221647",
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
    "id": "4a7c5b5e-d53c-5368-bfa1-57e09f375696",
    "type": "order_bookings",
    "attributes": {
      "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "44dcc777-a85c-41ed-968f-4b70dc60920e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3b99ff8b-a15a-4e5a-bde1-32850b8e6732"
          },
          {
            "type": "lines",
            "id": "2f29f863-faf2-4d4d-85ab-7cca45f4682b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58"
          },
          {
            "type": "plannings",
            "id": "64f4455a-603d-4dbd-b8cd-3528a6c93885"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e5bf7a59-9f8e-4526-acc2-9f5869bc76d5"
          },
          {
            "type": "stock_item_plannings",
            "id": "122aac61-8a57-4893-a512-a2f64ae8cee1"
          },
          {
            "type": "stock_item_plannings",
            "id": "1546f732-608b-4f96-a594-f51ca1dd22bb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T13:37:57+00:00",
        "updated_at": "2023-02-23T13:37:59+00:00",
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
        "customer_id": "1418080a-a52f-4b6f-8662-3d1f5c71ee27",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4",
        "stop_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4"
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
      "id": "3b99ff8b-a15a-4e5a-bde1-32850b8e6732",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:59+00:00",
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
        "item_id": "68259cc5-0711-4c04-9ae6-ddbedc7e2420",
        "tax_category_id": "6adba5f8-910a-4368-a4b7-dd3d389bd9ea",
        "planning_id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58",
        "parent_line_id": null,
        "owner_id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
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
      "id": "2f29f863-faf2-4d4d-85ab-7cca45f4682b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:59+00:00",
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
        "item_id": "ba09cde6-dfbc-481c-a220-826b61221647",
        "tax_category_id": "6adba5f8-910a-4368-a4b7-dd3d389bd9ea",
        "planning_id": "64f4455a-603d-4dbd-b8cd-3528a6c93885",
        "parent_line_id": null,
        "owner_id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
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
      "id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:58+00:00",
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
        "item_id": "68259cc5-0711-4c04-9ae6-ddbedc7e2420",
        "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
        "start_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4",
        "stop_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4",
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
      "id": "64f4455a-603d-4dbd-b8cd-3528a6c93885",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:58+00:00",
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
        "item_id": "ba09cde6-dfbc-481c-a220-826b61221647",
        "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e",
        "start_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4",
        "stop_location_id": "3a85d048-dabf-4429-beef-0b080afc23c4",
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
      "id": "e5bf7a59-9f8e-4526-acc2-9f5869bc76d5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e0140edb-3f73-402b-a742-89c1127cdcd1",
        "planning_id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58",
        "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e"
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
      "id": "122aac61-8a57-4893-a512-a2f64ae8cee1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "67c3b7ae-52b2-4663-bd92-83351ca75605",
        "planning_id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58",
        "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e"
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
      "id": "1546f732-608b-4f96-a594-f51ca1dd22bb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T13:37:58+00:00",
        "updated_at": "2023-02-23T13:37:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6da15dcf-6030-4e50-bd7b-dd90426036cf",
        "planning_id": "e60b0bbb-246f-4ebd-bfeb-1e3b4b3f6f58",
        "order_id": "44dcc777-a85c-41ed-968f-4b70dc60920e"
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
          "order_id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c",
          "items": [
            {
              "type": "bundles",
              "id": "2ae681a7-0bf6-4334-8fca-d154463fb939",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b4417791-cf56-4792-b3e4-64933fa25ccf",
                  "id": "e511cc50-eae1-411a-8496-081c39900e2d"
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
    "id": "7ad6583a-ca2e-59d3-ad82-d2c194cfbbc9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ecbb0f7b-85dd-42ec-bb43-c5e0abe8ebca"
          },
          {
            "type": "lines",
            "id": "2ecf64eb-2bd7-40b0-b963-1ce5133399e3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "399d4ba7-9a1d-4855-bd9e-ad6fd2b3dfb4"
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
      "id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T13:38:01+00:00",
        "updated_at": "2023-02-23T13:38:01+00:00",
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
        "starts_at": "2023-02-21T13:30:00+00:00",
        "stops_at": "2023-02-25T13:30:00+00:00",
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
        "start_location_id": "5b987db0-3af7-4fab-b9fc-a5eafbd2ac7b",
        "stop_location_id": "5b987db0-3af7-4fab-b9fc-a5eafbd2ac7b"
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
      "id": "ecbb0f7b-85dd-42ec-bb43-c5e0abe8ebca",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:38:01+00:00",
        "updated_at": "2023-02-23T13:38:01+00:00",
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
        "item_id": "2ae681a7-0bf6-4334-8fca-d154463fb939",
        "tax_category_id": null,
        "planning_id": "399d4ba7-9a1d-4855-bd9e-ad6fd2b3dfb4",
        "parent_line_id": null,
        "owner_id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c",
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
      "id": "2ecf64eb-2bd7-40b0-b963-1ce5133399e3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T13:38:01+00:00",
        "updated_at": "2023-02-23T13:38:01+00:00",
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
        "item_id": "e511cc50-eae1-411a-8496-081c39900e2d",
        "tax_category_id": null,
        "planning_id": "3f7f8c5b-17d2-430f-95d1-b7201adae74f",
        "parent_line_id": "ecbb0f7b-85dd-42ec-bb43-c5e0abe8ebca",
        "owner_id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c",
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
      "id": "399d4ba7-9a1d-4855-bd9e-ad6fd2b3dfb4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T13:38:01+00:00",
        "updated_at": "2023-02-23T13:38:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-21T13:30:00+00:00",
        "stops_at": "2023-02-25T13:30:00+00:00",
        "reserved_from": "2023-02-21T13:30:00+00:00",
        "reserved_till": "2023-02-25T13:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2ae681a7-0bf6-4334-8fca-d154463fb939",
        "order_id": "af7c7951-b4fe-4242-94e0-86ba0f6bb36c",
        "start_location_id": "5b987db0-3af7-4fab-b9fc-a5eafbd2ac7b",
        "stop_location_id": "5b987db0-3af7-4fab-b9fc-a5eafbd2ac7b",
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





