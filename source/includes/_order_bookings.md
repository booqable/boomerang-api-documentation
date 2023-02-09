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
          "order_id": "e427d2b0-eaf1-448d-a206-d2b4ade40e74",
          "items": [
            {
              "type": "products",
              "id": "49ca9150-a96b-42be-807b-2dc302585b26",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1cc0bb6c-3fbe-43ea-9c3b-8d884cae7253",
              "stock_item_ids": [
                "c78a43ec-e25e-4ba1-aa82-f9f71e952a70",
                "288aec86-e769-44d0-b733-366c73e1059b"
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
            "item_id": "49ca9150-a96b-42be-807b-2dc302585b26",
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
          "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
          "items": [
            {
              "type": "products",
              "id": "65e05ff3-20c6-4342-83ee-88975d1453ef",
              "stock_item_ids": [
                "bec380c4-7e39-4ced-8ad6-d29825a42b26",
                "dfac1bb4-07e1-4c96-a3bf-c6337060c24f",
                "ce49d1a2-852c-4381-a643-ab575987fcb5"
              ]
            },
            {
              "type": "products",
              "id": "a05c33ed-e58f-4ada-8430-dc293359e866",
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
    "id": "c4d0c960-bbb4-507e-9bc7-c9d283dec9a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "deccc4b6-e656-4bde-b4db-409b6ca8727a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "28f3d8e2-04ec-47a1-bfc3-6edd5e44efe5"
          },
          {
            "type": "lines",
            "id": "57260c35-1bc9-432c-b492-cc5a9c4f2f60"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "20adbe84-ae49-484e-9988-834e9da6fad9"
          },
          {
            "type": "plannings",
            "id": "0be3482a-5081-4782-836a-26c742fb10f2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6729d84b-321e-4a74-b12a-c49fea91f731"
          },
          {
            "type": "stock_item_plannings",
            "id": "95c09588-f6bb-4db0-8998-27dcac2c2b2f"
          },
          {
            "type": "stock_item_plannings",
            "id": "589307a2-ffea-460f-b3e1-63008c21d715"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T10:19:47+00:00",
        "updated_at": "2023-02-09T10:19:49+00:00",
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
        "customer_id": "594edd4f-ec65-4cf7-9e52-ee1c7cf78659",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "15128293-460c-4683-8987-e9f28dd5eebf",
        "stop_location_id": "15128293-460c-4683-8987-e9f28dd5eebf"
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
      "id": "28f3d8e2-04ec-47a1-bfc3-6edd5e44efe5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:48+00:00",
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
        "item_id": "65e05ff3-20c6-4342-83ee-88975d1453ef",
        "tax_category_id": "240c604d-7a32-4d5f-8f69-b86b8cc1281f",
        "planning_id": "20adbe84-ae49-484e-9988-834e9da6fad9",
        "parent_line_id": null,
        "owner_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
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
      "id": "57260c35-1bc9-432c-b492-cc5a9c4f2f60",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:48+00:00",
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
        "item_id": "a05c33ed-e58f-4ada-8430-dc293359e866",
        "tax_category_id": "240c604d-7a32-4d5f-8f69-b86b8cc1281f",
        "planning_id": "0be3482a-5081-4782-836a-26c742fb10f2",
        "parent_line_id": null,
        "owner_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
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
      "id": "20adbe84-ae49-484e-9988-834e9da6fad9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:49+00:00",
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
        "item_id": "65e05ff3-20c6-4342-83ee-88975d1453ef",
        "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
        "start_location_id": "15128293-460c-4683-8987-e9f28dd5eebf",
        "stop_location_id": "15128293-460c-4683-8987-e9f28dd5eebf",
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
      "id": "0be3482a-5081-4782-836a-26c742fb10f2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:49+00:00",
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
        "item_id": "a05c33ed-e58f-4ada-8430-dc293359e866",
        "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a",
        "start_location_id": "15128293-460c-4683-8987-e9f28dd5eebf",
        "stop_location_id": "15128293-460c-4683-8987-e9f28dd5eebf",
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
      "id": "6729d84b-321e-4a74-b12a-c49fea91f731",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bec380c4-7e39-4ced-8ad6-d29825a42b26",
        "planning_id": "20adbe84-ae49-484e-9988-834e9da6fad9",
        "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a"
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
      "id": "95c09588-f6bb-4db0-8998-27dcac2c2b2f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dfac1bb4-07e1-4c96-a3bf-c6337060c24f",
        "planning_id": "20adbe84-ae49-484e-9988-834e9da6fad9",
        "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a"
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
      "id": "589307a2-ffea-460f-b3e1-63008c21d715",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:48+00:00",
        "updated_at": "2023-02-09T10:19:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ce49d1a2-852c-4381-a643-ab575987fcb5",
        "planning_id": "20adbe84-ae49-484e-9988-834e9da6fad9",
        "order_id": "deccc4b6-e656-4bde-b4db-409b6ca8727a"
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
          "order_id": "13df6bde-00ff-4c94-9481-bff5b7450bd3",
          "items": [
            {
              "type": "bundles",
              "id": "2a98b672-2624-4df9-9859-e84d1f690a7c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "05bcb80c-2cec-403b-bb99-846bcb10fc4c",
                  "id": "a1914fdd-79a6-4067-8913-b93ce6e0b0bc"
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
    "id": "8a4e7120-d4f7-5257-91a6-b7fd356e2397",
    "type": "order_bookings",
    "attributes": {
      "order_id": "13df6bde-00ff-4c94-9481-bff5b7450bd3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "13df6bde-00ff-4c94-9481-bff5b7450bd3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9f6dcfb5-5307-49b6-8442-62f089378cc1"
          },
          {
            "type": "lines",
            "id": "9442dd61-ce22-4bbd-908b-75b860c17ef2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a4ba38aa-262b-41e4-a975-0ed2039131c6"
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
      "id": "13df6bde-00ff-4c94-9481-bff5b7450bd3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T10:19:51+00:00",
        "updated_at": "2023-02-09T10:19:52+00:00",
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
        "starts_at": "2023-02-07T10:15:00+00:00",
        "stops_at": "2023-02-11T10:15:00+00:00",
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
        "start_location_id": "c19b32cc-c1ba-4df8-90d0-63058fa982a6",
        "stop_location_id": "c19b32cc-c1ba-4df8-90d0-63058fa982a6"
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
      "id": "9f6dcfb5-5307-49b6-8442-62f089378cc1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:19:51+00:00",
        "updated_at": "2023-02-09T10:19:51+00:00",
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
        "item_id": "a1914fdd-79a6-4067-8913-b93ce6e0b0bc",
        "tax_category_id": null,
        "planning_id": "a2653422-d7a9-4a57-8810-e42660c90fed",
        "parent_line_id": "9442dd61-ce22-4bbd-908b-75b860c17ef2",
        "owner_id": "13df6bde-00ff-4c94-9481-bff5b7450bd3",
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
      "id": "9442dd61-ce22-4bbd-908b-75b860c17ef2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:19:51+00:00",
        "updated_at": "2023-02-09T10:19:51+00:00",
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
        "item_id": "2a98b672-2624-4df9-9859-e84d1f690a7c",
        "tax_category_id": null,
        "planning_id": "a4ba38aa-262b-41e4-a975-0ed2039131c6",
        "parent_line_id": null,
        "owner_id": "13df6bde-00ff-4c94-9481-bff5b7450bd3",
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
      "id": "a4ba38aa-262b-41e4-a975-0ed2039131c6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:19:51+00:00",
        "updated_at": "2023-02-09T10:19:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T10:15:00+00:00",
        "stops_at": "2023-02-11T10:15:00+00:00",
        "reserved_from": "2023-02-07T10:15:00+00:00",
        "reserved_till": "2023-02-11T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2a98b672-2624-4df9-9859-e84d1f690a7c",
        "order_id": "13df6bde-00ff-4c94-9481-bff5b7450bd3",
        "start_location_id": "c19b32cc-c1ba-4df8-90d0-63058fa982a6",
        "stop_location_id": "c19b32cc-c1ba-4df8-90d0-63058fa982a6",
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





