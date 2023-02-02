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
          "order_id": "1d10a413-1712-4abd-909d-275b85cfdea7",
          "items": [
            {
              "type": "products",
              "id": "beeb3f59-c12f-4701-aeb1-0c579ae5b4d2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f44fc709-30bc-4af7-ae61-00d0478871cd",
              "stock_item_ids": [
                "b62e6c9f-c26e-4877-bf12-97d06ead6215",
                "5b341382-adb9-49e2-a35d-684136b54470"
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
            "item_id": "beeb3f59-c12f-4701-aeb1-0c579ae5b4d2",
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
          "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
          "items": [
            {
              "type": "products",
              "id": "b733da23-2bf0-4bd6-a5af-6d5e265f4348",
              "stock_item_ids": [
                "51a9ac8d-7f6b-4f05-9be9-f6c06445005a",
                "11d39be1-7375-4847-ae87-49851a7f4359",
                "e57570d8-d373-4576-8f1e-c681e41905aa"
              ]
            },
            {
              "type": "products",
              "id": "b441f4eb-aada-48b5-8520-58bb3aea5ac4",
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
    "id": "18cae9e2-4978-5950-a36d-9dd2891c1571",
    "type": "order_bookings",
    "attributes": {
      "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "100348bd-5566-4a69-9f06-2a4b5aa1a218"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3ecb0806-f88e-436e-990f-545f1a5d89b9"
          },
          {
            "type": "lines",
            "id": "31ad3782-f2a8-454b-984a-9b4c5f976c96"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a"
          },
          {
            "type": "plannings",
            "id": "f63822c2-f6f8-4953-acc6-61df639db91f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6bdaed37-86d8-439c-82d9-7a5d86747359"
          },
          {
            "type": "stock_item_plannings",
            "id": "8ae4c10d-1b96-4088-b4ec-83de305371e1"
          },
          {
            "type": "stock_item_plannings",
            "id": "38d71266-9159-48ed-8bd0-0a4ecb87128d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:30:19+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
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
        "customer_id": "b0f1a9d5-9925-469e-b261-3d543a95744b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380",
        "stop_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380"
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
      "id": "3ecb0806-f88e-436e-990f-545f1a5d89b9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
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
        "item_id": "b733da23-2bf0-4bd6-a5af-6d5e265f4348",
        "tax_category_id": "97dd1b2e-0aba-4eb2-9e8d-412ae45e3b33",
        "planning_id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a",
        "parent_line_id": null,
        "owner_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
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
      "id": "31ad3782-f2a8-454b-984a-9b4c5f976c96",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
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
        "item_id": "b441f4eb-aada-48b5-8520-58bb3aea5ac4",
        "tax_category_id": "97dd1b2e-0aba-4eb2-9e8d-412ae45e3b33",
        "planning_id": "f63822c2-f6f8-4953-acc6-61df639db91f",
        "parent_line_id": null,
        "owner_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
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
      "id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
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
        "item_id": "b733da23-2bf0-4bd6-a5af-6d5e265f4348",
        "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
        "start_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380",
        "stop_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380",
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
      "id": "f63822c2-f6f8-4953-acc6-61df639db91f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
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
        "item_id": "b441f4eb-aada-48b5-8520-58bb3aea5ac4",
        "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218",
        "start_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380",
        "stop_location_id": "a195a4f6-fea9-471c-916d-8a903fabf380",
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
      "id": "6bdaed37-86d8-439c-82d9-7a5d86747359",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "51a9ac8d-7f6b-4f05-9be9-f6c06445005a",
        "planning_id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a",
        "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218"
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
      "id": "8ae4c10d-1b96-4088-b4ec-83de305371e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "11d39be1-7375-4847-ae87-49851a7f4359",
        "planning_id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a",
        "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218"
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
      "id": "38d71266-9159-48ed-8bd0-0a4ecb87128d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:20+00:00",
        "updated_at": "2023-02-02T16:30:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e57570d8-d373-4576-8f1e-c681e41905aa",
        "planning_id": "cc7b416d-74d1-493a-8c5a-34fb4e7b8b7a",
        "order_id": "100348bd-5566-4a69-9f06-2a4b5aa1a218"
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
          "order_id": "f682d697-556f-470d-b723-7c90edb6f183",
          "items": [
            {
              "type": "bundles",
              "id": "10e021c9-4622-4dc7-8ccf-b10b3d95512a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e5958692-8760-47d9-a723-91ac04faffe8",
                  "id": "a23f59a8-9a41-48e8-97a0-5db4d67b91a6"
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
    "id": "09f05c6e-a5ad-5e79-ad24-a2a2fc468c4f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f682d697-556f-470d-b723-7c90edb6f183"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f682d697-556f-470d-b723-7c90edb6f183"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "206102af-20bf-4918-bac8-7f9cf286f627"
          },
          {
            "type": "lines",
            "id": "bc1c4ec4-c21a-4ae9-9a88-bc1b96a84a24"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b7d11d9f-0326-4aad-aadd-a9dc688fbe9c"
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
      "id": "f682d697-556f-470d-b723-7c90edb6f183",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:30:24+00:00",
        "updated_at": "2023-02-02T16:30:25+00:00",
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
        "starts_at": "2023-01-31T16:30:00+00:00",
        "stops_at": "2023-02-04T16:30:00+00:00",
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
        "start_location_id": "4645f8c3-2dad-41cd-8509-d086915840b3",
        "stop_location_id": "4645f8c3-2dad-41cd-8509-d086915840b3"
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
      "id": "206102af-20bf-4918-bac8-7f9cf286f627",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:30:24+00:00",
        "updated_at": "2023-02-02T16:30:24+00:00",
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
        "item_id": "a23f59a8-9a41-48e8-97a0-5db4d67b91a6",
        "tax_category_id": null,
        "planning_id": "9c7c4a28-5d59-4af3-80ed-e5b313c14bd7",
        "parent_line_id": "bc1c4ec4-c21a-4ae9-9a88-bc1b96a84a24",
        "owner_id": "f682d697-556f-470d-b723-7c90edb6f183",
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
      "id": "bc1c4ec4-c21a-4ae9-9a88-bc1b96a84a24",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:30:24+00:00",
        "updated_at": "2023-02-02T16:30:24+00:00",
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
        "item_id": "10e021c9-4622-4dc7-8ccf-b10b3d95512a",
        "tax_category_id": null,
        "planning_id": "b7d11d9f-0326-4aad-aadd-a9dc688fbe9c",
        "parent_line_id": null,
        "owner_id": "f682d697-556f-470d-b723-7c90edb6f183",
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
      "id": "b7d11d9f-0326-4aad-aadd-a9dc688fbe9c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:30:24+00:00",
        "updated_at": "2023-02-02T16:30:24+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T16:30:00+00:00",
        "stops_at": "2023-02-04T16:30:00+00:00",
        "reserved_from": "2023-01-31T16:30:00+00:00",
        "reserved_till": "2023-02-04T16:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "10e021c9-4622-4dc7-8ccf-b10b3d95512a",
        "order_id": "f682d697-556f-470d-b723-7c90edb6f183",
        "start_location_id": "4645f8c3-2dad-41cd-8509-d086915840b3",
        "stop_location_id": "4645f8c3-2dad-41cd-8509-d086915840b3",
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





