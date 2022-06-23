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
          "order_id": "f428be52-0e81-4ab3-a215-a6131cd92e53",
          "items": [
            {
              "type": "products",
              "id": "f1dbcc23-a583-4b66-ad3d-8f64b04d523d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "782f206a-8178-4377-922d-f9d0c05000e9",
              "stock_item_ids": [
                "c425ab0b-ef46-4d8f-b6ce-5640842a52ad",
                "60c066c8-50b4-4545-ace3-8813a21b0cc1"
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
            "item_id": "f1dbcc23-a583-4b66-ad3d-8f64b04d523d",
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
          "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
          "items": [
            {
              "type": "products",
              "id": "657e9cf2-23fa-42c1-95b4-ab33b221f614",
              "stock_item_ids": [
                "5ff20a82-0099-4ec9-91cb-c29df677dfea",
                "2878b29f-d98b-4e23-96ab-fed8446994eb",
                "67965621-21b6-44a0-96ec-6680e4d02d1d"
              ]
            },
            {
              "type": "products",
              "id": "02df5f36-ea19-4ca0-adff-ba11a7dfa410",
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
    "id": "13684899-7023-5624-987e-ad1f5cec6945",
    "type": "order_bookings",
    "attributes": {
      "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "778d063d-c9f0-4499-b4e2-7e2ec44f8028"
          },
          {
            "type": "lines",
            "id": "edc2f4eb-ecb0-465d-8b1c-85e2e7b1e1da"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4f3aed5f-dab9-406a-951e-fa569b71522a"
          },
          {
            "type": "plannings",
            "id": "6d2eb393-c1bd-4630-8809-d669868ada20"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "342b41e2-2136-4b8c-9269-3f69839d5575"
          },
          {
            "type": "stock_item_plannings",
            "id": "1c3ffd8f-e5f4-4808-81cc-1709a4b55e01"
          },
          {
            "type": "stock_item_plannings",
            "id": "16d41f06-f846-4e67-906d-b222d161e30e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-23T12:52:26+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
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
        "customer_id": "9c86ebb6-553a-4720-90a4-060e72c95955",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0",
        "stop_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0"
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
      "id": "778d063d-c9f0-4499-b4e2-7e2ec44f8028",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T12:52:27+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
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
        "item_id": "02df5f36-ea19-4ca0-adff-ba11a7dfa410",
        "tax_category_id": "38a93d0e-da79-412e-b328-578a0581da08",
        "planning_id": "4f3aed5f-dab9-406a-951e-fa569b71522a",
        "parent_line_id": null,
        "owner_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
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
      "id": "edc2f4eb-ecb0-465d-8b1c-85e2e7b1e1da",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T12:52:28+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
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
        "item_id": "657e9cf2-23fa-42c1-95b4-ab33b221f614",
        "tax_category_id": "38a93d0e-da79-412e-b328-578a0581da08",
        "planning_id": "6d2eb393-c1bd-4630-8809-d669868ada20",
        "parent_line_id": null,
        "owner_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
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
      "id": "4f3aed5f-dab9-406a-951e-fa569b71522a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:27+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
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
        "item_id": "02df5f36-ea19-4ca0-adff-ba11a7dfa410",
        "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
        "start_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0",
        "stop_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0",
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
      "id": "6d2eb393-c1bd-4630-8809-d669868ada20",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:28+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
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
        "item_id": "657e9cf2-23fa-42c1-95b4-ab33b221f614",
        "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2",
        "start_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0",
        "stop_location_id": "82af69e6-e27e-46c0-8e4f-e2ae711969d0",
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
      "id": "342b41e2-2136-4b8c-9269-3f69839d5575",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:28+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5ff20a82-0099-4ec9-91cb-c29df677dfea",
        "planning_id": "6d2eb393-c1bd-4630-8809-d669868ada20",
        "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2"
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
      "id": "1c3ffd8f-e5f4-4808-81cc-1709a4b55e01",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:28+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2878b29f-d98b-4e23-96ab-fed8446994eb",
        "planning_id": "6d2eb393-c1bd-4630-8809-d669868ada20",
        "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2"
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
      "id": "16d41f06-f846-4e67-906d-b222d161e30e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:28+00:00",
        "updated_at": "2022-06-23T12:52:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "67965621-21b6-44a0-96ec-6680e4d02d1d",
        "planning_id": "6d2eb393-c1bd-4630-8809-d669868ada20",
        "order_id": "743239ee-f682-4a57-8a3f-9dee5dcea9a2"
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
          "order_id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd",
          "items": [
            {
              "type": "bundles",
              "id": "feab0fd7-46cf-4b51-84a7-bab30f0d10be",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5b0e5933-f1ca-48fb-9beb-5d08ac1248f8",
                  "id": "d99e626d-4843-4d36-89a4-17ecf1850173"
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
    "id": "408776e2-edc2-5dbd-b04a-84040b841f16",
    "type": "order_bookings",
    "attributes": {
      "order_id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eed49afe-5f31-4264-93e8-4a39cd6007fb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "50be9e5d-be64-4f40-ad6d-fb51e53dcfff"
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
      "id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-23T12:52:30+00:00",
        "updated_at": "2022-06-23T12:52:31+00:00",
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
        "starts_at": "2022-06-21T12:45:00+00:00",
        "stops_at": "2022-06-25T12:45:00+00:00",
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
        "start_location_id": "65c63b22-305c-43ab-8573-74d0f5ff6207",
        "stop_location_id": "65c63b22-305c-43ab-8573-74d0f5ff6207"
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
      "id": "eed49afe-5f31-4264-93e8-4a39cd6007fb",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T12:52:30+00:00",
        "updated_at": "2022-06-23T12:52:30+00:00",
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
        "item_id": "feab0fd7-46cf-4b51-84a7-bab30f0d10be",
        "tax_category_id": null,
        "planning_id": "50be9e5d-be64-4f40-ad6d-fb51e53dcfff",
        "parent_line_id": null,
        "owner_id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd",
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
      "id": "50be9e5d-be64-4f40-ad6d-fb51e53dcfff",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T12:52:30+00:00",
        "updated_at": "2022-06-23T12:52:30+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-21T12:45:00+00:00",
        "stops_at": "2022-06-25T12:45:00+00:00",
        "reserved_from": "2022-06-21T12:45:00+00:00",
        "reserved_till": "2022-06-25T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "feab0fd7-46cf-4b51-84a7-bab30f0d10be",
        "order_id": "615c92ff-83f8-4bfb-b326-36b12d6c89fd",
        "start_location_id": "65c63b22-305c-43ab-8573-74d0f5ff6207",
        "stop_location_id": "65c63b22-305c-43ab-8573-74d0f5ff6207",
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





