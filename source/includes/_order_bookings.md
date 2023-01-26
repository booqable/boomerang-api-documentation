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
          "order_id": "2f51e779-418f-43fe-a9e2-05b9ff004bcf",
          "items": [
            {
              "type": "products",
              "id": "4cb70626-64e7-4fab-ab56-6cb19bb39141",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "091164ea-a7dc-4fd5-a02f-ef7924f2e4e0",
              "stock_item_ids": [
                "37edf677-8f30-44f0-85cd-f1b96c9d92b0",
                "e401e91b-8526-4c01-9931-223d77a97b5b"
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
            "item_id": "4cb70626-64e7-4fab-ab56-6cb19bb39141",
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
          "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
          "items": [
            {
              "type": "products",
              "id": "7630b59f-820a-42be-92e4-fb136d75b3a1",
              "stock_item_ids": [
                "f56f23c1-fc67-4593-816c-caa8270e0c55",
                "80e67442-f49e-41ad-97a4-eb3ab8e5c785",
                "a80e3a25-ae8d-49f2-bb27-2018a7872f95"
              ]
            },
            {
              "type": "products",
              "id": "5b01866a-ed37-44b2-bcd2-8ca56a2bf575",
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
    "id": "ea16f92f-6ad7-53bd-bc42-d01ad1503b71",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "289b8060-d3d8-42fe-b062-fe55c109f4d9"
          },
          {
            "type": "lines",
            "id": "d73c1c0c-23fe-4844-8e90-2e358d12da84"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef"
          },
          {
            "type": "plannings",
            "id": "3f2b0264-30ed-4921-bf3b-70be8d3fb854"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e4d0244e-0915-4224-bdc2-d97fd3c7ffd4"
          },
          {
            "type": "stock_item_plannings",
            "id": "c0319232-45a9-4853-8cf6-ef466920a1f9"
          },
          {
            "type": "stock_item_plannings",
            "id": "bcbde91a-a484-47c5-8c52-e199eba215b2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T08:10:09+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
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
        "customer_id": "334684a0-eae1-4bfc-84e2-9bb9c85c02ae",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c",
        "stop_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c"
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
      "id": "289b8060-d3d8-42fe-b062-fe55c109f4d9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
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
        "item_id": "7630b59f-820a-42be-92e4-fb136d75b3a1",
        "tax_category_id": "10805dd4-ca54-4b3a-8dc2-7ad4fa85ddcd",
        "planning_id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef",
        "parent_line_id": null,
        "owner_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
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
      "id": "d73c1c0c-23fe-4844-8e90-2e358d12da84",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
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
              "price_in_cents": "7750.0",
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "5b01866a-ed37-44b2-bcd2-8ca56a2bf575",
        "tax_category_id": "10805dd4-ca54-4b3a-8dc2-7ad4fa85ddcd",
        "planning_id": "3f2b0264-30ed-4921-bf3b-70be8d3fb854",
        "parent_line_id": null,
        "owner_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
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
      "id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
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
        "item_id": "7630b59f-820a-42be-92e4-fb136d75b3a1",
        "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
        "start_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c",
        "stop_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c",
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
      "id": "3f2b0264-30ed-4921-bf3b-70be8d3fb854",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
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
        "item_id": "5b01866a-ed37-44b2-bcd2-8ca56a2bf575",
        "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26",
        "start_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c",
        "stop_location_id": "5a788276-10f5-4b44-8430-c70f2d7d837c",
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
      "id": "e4d0244e-0915-4224-bdc2-d97fd3c7ffd4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f56f23c1-fc67-4593-816c-caa8270e0c55",
        "planning_id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef",
        "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26"
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
      "id": "c0319232-45a9-4853-8cf6-ef466920a1f9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "80e67442-f49e-41ad-97a4-eb3ab8e5c785",
        "planning_id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef",
        "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26"
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
      "id": "bcbde91a-a484-47c5-8c52-e199eba215b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:11+00:00",
        "updated_at": "2023-01-26T08:10:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a80e3a25-ae8d-49f2-bb27-2018a7872f95",
        "planning_id": "cb7f9edf-6e4b-45ab-9f79-e2a355e63cef",
        "order_id": "b9cec4a6-6f67-49d7-9adb-cf999a9e1b26"
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
          "order_id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0",
          "items": [
            {
              "type": "bundles",
              "id": "21d30643-4c7e-4f37-88f7-c8c2469f483c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "deeff9f9-7a8f-45e6-b67a-44651faa77c9",
                  "id": "c67d179f-3672-4e42-8335-5d7c36381f4d"
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
    "id": "56cd458a-dff9-51f8-bf12-cc2697789037",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e330744a-5fe4-4477-ae86-235b5a761c5e"
          },
          {
            "type": "lines",
            "id": "73b7703b-d425-40e5-9d32-de7d45036770"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "efe56900-a9f6-4b2c-93c8-1096dc4245ba"
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
      "id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T08:10:13+00:00",
        "updated_at": "2023-01-26T08:10:14+00:00",
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
        "starts_at": "2023-01-24T08:00:00+00:00",
        "stops_at": "2023-01-28T08:00:00+00:00",
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
        "start_location_id": "8ec23ee1-fdc4-4b41-897c-69760b7e7d41",
        "stop_location_id": "8ec23ee1-fdc4-4b41-897c-69760b7e7d41"
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
      "id": "e330744a-5fe4-4477-ae86-235b5a761c5e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T08:10:14+00:00",
        "updated_at": "2023-01-26T08:10:14+00:00",
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
        "item_id": "c67d179f-3672-4e42-8335-5d7c36381f4d",
        "tax_category_id": null,
        "planning_id": "157f250b-5c0e-4ee4-bacd-ebe93f7fb541",
        "parent_line_id": "73b7703b-d425-40e5-9d32-de7d45036770",
        "owner_id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0",
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
      "id": "73b7703b-d425-40e5-9d32-de7d45036770",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T08:10:14+00:00",
        "updated_at": "2023-01-26T08:10:14+00:00",
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
        "item_id": "21d30643-4c7e-4f37-88f7-c8c2469f483c",
        "tax_category_id": null,
        "planning_id": "efe56900-a9f6-4b2c-93c8-1096dc4245ba",
        "parent_line_id": null,
        "owner_id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0",
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
      "id": "efe56900-a9f6-4b2c-93c8-1096dc4245ba",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T08:10:14+00:00",
        "updated_at": "2023-01-26T08:10:14+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-24T08:00:00+00:00",
        "stops_at": "2023-01-28T08:00:00+00:00",
        "reserved_from": "2023-01-24T08:00:00+00:00",
        "reserved_till": "2023-01-28T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "21d30643-4c7e-4f37-88f7-c8c2469f483c",
        "order_id": "2009742b-5993-4f8c-82c9-d9c9f502c6a0",
        "start_location_id": "8ec23ee1-fdc4-4b41-897c-69760b7e7d41",
        "stop_location_id": "8ec23ee1-fdc4-4b41-897c-69760b7e7d41",
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





