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
          "order_id": "cbd15822-51c1-4f9b-8519-e0f250792d8b",
          "items": [
            {
              "type": "products",
              "id": "bfe0c4cb-43b2-4590-bbfa-b179daef3feb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fb801640-0b75-40b5-9697-9b33c86807c3",
              "stock_item_ids": [
                "9e71ad6f-5bb7-4482-8692-6dfd9838f2a3",
                "1783a0a7-a77b-4101-8fde-a6beffd16b5c"
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
            "item_id": "bfe0c4cb-43b2-4590-bbfa-b179daef3feb",
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
          "order_id": "73b7a21b-1800-4c90-b965-7887488cb510",
          "items": [
            {
              "type": "products",
              "id": "9d01c70f-9028-4582-9056-c4ab1f5805ee",
              "stock_item_ids": [
                "34a7ca3c-46a3-47ac-ae3b-70d0efbe63c4",
                "0c7c8955-9344-42ca-bf48-be8896e26e78",
                "fb343736-71ea-4f61-bc78-f399519848db"
              ]
            },
            {
              "type": "products",
              "id": "90de8a3f-e08e-456e-b38b-10f773ccc526",
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
    "id": "77d8376a-45db-54b6-8a8e-6d45bde670cf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "73b7a21b-1800-4c90-b965-7887488cb510"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "73b7a21b-1800-4c90-b965-7887488cb510"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cfb7818e-604f-4772-b25f-608f3da38ed2"
          },
          {
            "type": "lines",
            "id": "3f3effa2-49a5-4707-a0ee-28f2e208fef4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dfc622d9-1a34-45d2-810f-1648237a4940"
          },
          {
            "type": "plannings",
            "id": "a043df6f-4cad-42a5-ba98-3aa39953f8c8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8dbf31d9-a192-4f36-aee3-89b256cccb9c"
          },
          {
            "type": "stock_item_plannings",
            "id": "6e868189-1795-47ff-b941-024a66c4e3f8"
          },
          {
            "type": "stock_item_plannings",
            "id": "7bbc43f2-44ad-4c3b-8733-18509c7d5e43"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "73b7a21b-1800-4c90-b965-7887488cb510",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-09T08:13:59+00:00",
        "updated_at": "2022-12-09T08:14:01+00:00",
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
        "customer_id": "7f8ae696-fe3e-4af0-b99f-d2237a164f2e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d",
        "stop_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d"
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
      "id": "cfb7818e-604f-4772-b25f-608f3da38ed2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:00+00:00",
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
        "item_id": "9d01c70f-9028-4582-9056-c4ab1f5805ee",
        "tax_category_id": "f49ad463-93f1-49b3-863e-949b309b0e84",
        "planning_id": "dfc622d9-1a34-45d2-810f-1648237a4940",
        "parent_line_id": null,
        "owner_id": "73b7a21b-1800-4c90-b965-7887488cb510",
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
      "id": "3f3effa2-49a5-4707-a0ee-28f2e208fef4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:00+00:00",
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
        "item_id": "90de8a3f-e08e-456e-b38b-10f773ccc526",
        "tax_category_id": "f49ad463-93f1-49b3-863e-949b309b0e84",
        "planning_id": "a043df6f-4cad-42a5-ba98-3aa39953f8c8",
        "parent_line_id": null,
        "owner_id": "73b7a21b-1800-4c90-b965-7887488cb510",
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
      "id": "dfc622d9-1a34-45d2-810f-1648237a4940",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:01+00:00",
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
        "item_id": "9d01c70f-9028-4582-9056-c4ab1f5805ee",
        "order_id": "73b7a21b-1800-4c90-b965-7887488cb510",
        "start_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d",
        "stop_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d",
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
      "id": "a043df6f-4cad-42a5-ba98-3aa39953f8c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:01+00:00",
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
        "item_id": "90de8a3f-e08e-456e-b38b-10f773ccc526",
        "order_id": "73b7a21b-1800-4c90-b965-7887488cb510",
        "start_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d",
        "stop_location_id": "4a2f1ffc-62e8-4ace-9d97-1923310f199d",
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
      "id": "8dbf31d9-a192-4f36-aee3-89b256cccb9c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "34a7ca3c-46a3-47ac-ae3b-70d0efbe63c4",
        "planning_id": "dfc622d9-1a34-45d2-810f-1648237a4940",
        "order_id": "73b7a21b-1800-4c90-b965-7887488cb510"
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
      "id": "6e868189-1795-47ff-b941-024a66c4e3f8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0c7c8955-9344-42ca-bf48-be8896e26e78",
        "planning_id": "dfc622d9-1a34-45d2-810f-1648237a4940",
        "order_id": "73b7a21b-1800-4c90-b965-7887488cb510"
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
      "id": "7bbc43f2-44ad-4c3b-8733-18509c7d5e43",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:00+00:00",
        "updated_at": "2022-12-09T08:14:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fb343736-71ea-4f61-bc78-f399519848db",
        "planning_id": "dfc622d9-1a34-45d2-810f-1648237a4940",
        "order_id": "73b7a21b-1800-4c90-b965-7887488cb510"
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
          "order_id": "fc5a0491-f428-4637-a672-0cb3cf51efaa",
          "items": [
            {
              "type": "bundles",
              "id": "f3943075-3fea-4d8c-82db-6921eae5723f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "83fd32fe-cd24-46f5-ba96-4565f4490011",
                  "id": "b5996a92-d805-4880-b71f-7ae4e07533b7"
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
    "id": "e401349f-46ce-5bd4-b2fd-4cb6ce782c05",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fc5a0491-f428-4637-a672-0cb3cf51efaa"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fc5a0491-f428-4637-a672-0cb3cf51efaa"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "304f1d76-e958-4a5e-beea-e4255889ebf6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "71780038-fcb8-4082-bcfc-076747d1c033"
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
      "id": "fc5a0491-f428-4637-a672-0cb3cf51efaa",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-09T08:14:03+00:00",
        "updated_at": "2022-12-09T08:14:04+00:00",
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
        "starts_at": "2022-12-07T08:00:00+00:00",
        "stops_at": "2022-12-11T08:00:00+00:00",
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
        "start_location_id": "337d745b-f456-49ad-8743-0516d272aa1d",
        "stop_location_id": "337d745b-f456-49ad-8743-0516d272aa1d"
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
      "id": "304f1d76-e958-4a5e-beea-e4255889ebf6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-09T08:14:04+00:00",
        "updated_at": "2022-12-09T08:14:04+00:00",
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
        "item_id": "f3943075-3fea-4d8c-82db-6921eae5723f",
        "tax_category_id": null,
        "planning_id": "71780038-fcb8-4082-bcfc-076747d1c033",
        "parent_line_id": null,
        "owner_id": "fc5a0491-f428-4637-a672-0cb3cf51efaa",
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
      "id": "71780038-fcb8-4082-bcfc-076747d1c033",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-09T08:14:03+00:00",
        "updated_at": "2022-12-09T08:14:03+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-12-07T08:00:00+00:00",
        "stops_at": "2022-12-11T08:00:00+00:00",
        "reserved_from": "2022-12-07T08:00:00+00:00",
        "reserved_till": "2022-12-11T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f3943075-3fea-4d8c-82db-6921eae5723f",
        "order_id": "fc5a0491-f428-4637-a672-0cb3cf51efaa",
        "start_location_id": "337d745b-f456-49ad-8743-0516d272aa1d",
        "stop_location_id": "337d745b-f456-49ad-8743-0516d272aa1d",
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





