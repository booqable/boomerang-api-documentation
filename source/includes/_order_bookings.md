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
          "order_id": "b266d2ff-0ddc-4e69-83d9-7ee92e68325b",
          "items": [
            {
              "type": "products",
              "id": "d083ab12-c014-4bb2-9766-d58fc3ad2ceb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0347337d-8b45-4a9d-ad44-0330a1e1a507",
              "stock_item_ids": [
                "316c9458-d91b-44a8-b29b-1aad88f0beb2",
                "5d45b351-053f-4a8a-b9c4-cafcf31edf84"
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
            "item_id": "d083ab12-c014-4bb2-9766-d58fc3ad2ceb",
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
          "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
          "items": [
            {
              "type": "products",
              "id": "1f086ebc-a208-48a7-a479-9bdb18705cd9",
              "stock_item_ids": [
                "aa0e630e-7930-4f1d-a75b-be31cfef01d7",
                "12b2ff70-8599-4236-8fed-44f6089610d5",
                "6e249f39-c63b-4b99-836a-5b58a2e520be"
              ]
            },
            {
              "type": "products",
              "id": "b46f6806-1548-43d9-a984-ed9988edc346",
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
    "id": "ebb0c390-89b5-5428-b510-a11932c2e329",
    "type": "order_bookings",
    "attributes": {
      "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "485134dc-7259-4a54-87dd-20a0ec7232c7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "71623b79-4667-4851-a0bb-79e2fb83ac49"
          },
          {
            "type": "lines",
            "id": "b6f20dea-f81f-44d4-a7eb-6425b0c4b1b8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0b610fa2-0729-4b98-b026-1a582e9ed51f"
          },
          {
            "type": "plannings",
            "id": "b33d1f74-34a5-487b-a5d0-6b34c82dcbe1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9c268c5a-3864-42e3-93c6-d94903a6c8a9"
          },
          {
            "type": "stock_item_plannings",
            "id": "75c3ba49-b4d0-4975-9ccc-3be2d33dec76"
          },
          {
            "type": "stock_item_plannings",
            "id": "42654d3f-82f1-48d3-ae09-4862a074fde1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T14:30:30+00:00",
        "updated_at": "2022-10-13T14:30:33+00:00",
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
        "customer_id": "61e896f4-c823-4aab-8257-2e2ff76fa9b8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "786a7976-e62c-442a-addb-445f35204007",
        "stop_location_id": "786a7976-e62c-442a-addb-445f35204007"
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
      "id": "71623b79-4667-4851-a0bb-79e2fb83ac49",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:32+00:00",
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
        "item_id": "1f086ebc-a208-48a7-a479-9bdb18705cd9",
        "tax_category_id": "d8440d30-a0e4-47d2-bd23-92c026fc1384",
        "planning_id": "0b610fa2-0729-4b98-b026-1a582e9ed51f",
        "parent_line_id": null,
        "owner_id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
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
      "id": "b6f20dea-f81f-44d4-a7eb-6425b0c4b1b8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:32+00:00",
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
        "item_id": "b46f6806-1548-43d9-a984-ed9988edc346",
        "tax_category_id": "d8440d30-a0e4-47d2-bd23-92c026fc1384",
        "planning_id": "b33d1f74-34a5-487b-a5d0-6b34c82dcbe1",
        "parent_line_id": null,
        "owner_id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
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
      "id": "0b610fa2-0729-4b98-b026-1a582e9ed51f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:33+00:00",
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
        "item_id": "1f086ebc-a208-48a7-a479-9bdb18705cd9",
        "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
        "start_location_id": "786a7976-e62c-442a-addb-445f35204007",
        "stop_location_id": "786a7976-e62c-442a-addb-445f35204007",
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
      "id": "b33d1f74-34a5-487b-a5d0-6b34c82dcbe1",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:33+00:00",
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
        "item_id": "b46f6806-1548-43d9-a984-ed9988edc346",
        "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7",
        "start_location_id": "786a7976-e62c-442a-addb-445f35204007",
        "stop_location_id": "786a7976-e62c-442a-addb-445f35204007",
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
      "id": "9c268c5a-3864-42e3-93c6-d94903a6c8a9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "aa0e630e-7930-4f1d-a75b-be31cfef01d7",
        "planning_id": "0b610fa2-0729-4b98-b026-1a582e9ed51f",
        "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7"
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
      "id": "75c3ba49-b4d0-4975-9ccc-3be2d33dec76",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "12b2ff70-8599-4236-8fed-44f6089610d5",
        "planning_id": "0b610fa2-0729-4b98-b026-1a582e9ed51f",
        "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7"
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
      "id": "42654d3f-82f1-48d3-ae09-4862a074fde1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:32+00:00",
        "updated_at": "2022-10-13T14:30:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6e249f39-c63b-4b99-836a-5b58a2e520be",
        "planning_id": "0b610fa2-0729-4b98-b026-1a582e9ed51f",
        "order_id": "485134dc-7259-4a54-87dd-20a0ec7232c7"
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
          "order_id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939",
          "items": [
            {
              "type": "bundles",
              "id": "2e5b7492-8189-4663-a964-5673824e1ae1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a71b2200-daad-4ecf-ae1d-3b3116ef7827",
                  "id": "28e75d4d-1e6f-4e1f-b908-c8ef8ae6ddc6"
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
    "id": "2423f22b-22eb-5818-9c79-7924623bad38",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0acc3915-01bd-423b-8379-7c40e740aa60"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5fcbee43-6001-4a12-943f-3a48c0994625"
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
      "id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T14:30:36+00:00",
        "updated_at": "2022-10-13T14:30:37+00:00",
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
        "starts_at": "2022-10-11T14:30:00+00:00",
        "stops_at": "2022-10-15T14:30:00+00:00",
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
        "start_location_id": "9f916572-7a6e-474d-b0ed-1e5430fec792",
        "stop_location_id": "9f916572-7a6e-474d-b0ed-1e5430fec792"
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
      "id": "0acc3915-01bd-423b-8379-7c40e740aa60",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T14:30:37+00:00",
        "updated_at": "2022-10-13T14:30:37+00:00",
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
        "item_id": "2e5b7492-8189-4663-a964-5673824e1ae1",
        "tax_category_id": null,
        "planning_id": "5fcbee43-6001-4a12-943f-3a48c0994625",
        "parent_line_id": null,
        "owner_id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939",
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
      "id": "5fcbee43-6001-4a12-943f-3a48c0994625",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T14:30:37+00:00",
        "updated_at": "2022-10-13T14:30:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-11T14:30:00+00:00",
        "stops_at": "2022-10-15T14:30:00+00:00",
        "reserved_from": "2022-10-11T14:30:00+00:00",
        "reserved_till": "2022-10-15T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2e5b7492-8189-4663-a964-5673824e1ae1",
        "order_id": "4f4fd064-74ba-467a-9e7b-c8d6ef922939",
        "start_location_id": "9f916572-7a6e-474d-b0ed-1e5430fec792",
        "stop_location_id": "9f916572-7a6e-474d-b0ed-1e5430fec792",
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





