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
          "order_id": "9a23b392-467f-484f-80fd-138015d009d0",
          "items": [
            {
              "type": "products",
              "id": "993d2392-4063-4dbd-8044-5714c1dc303b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e75491e7-db57-4573-9352-9eb563069a87",
              "stock_item_ids": [
                "bdf5491c-dc1b-46ab-b527-9b7951637177",
                "66785f58-d332-4963-86af-1e8f4a6723ba"
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
            "item_id": "993d2392-4063-4dbd-8044-5714c1dc303b",
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
          "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
          "items": [
            {
              "type": "products",
              "id": "da25f7f5-67b6-40c9-9322-2df864d721e9",
              "stock_item_ids": [
                "ad25a4ac-ef59-4745-a58c-9c999d79fb35",
                "92804a13-55c1-486b-80c4-b33225d7dfa7",
                "d86bf7ad-17ab-473a-8e63-6b97cb1d0d02"
              ]
            },
            {
              "type": "products",
              "id": "f28ef77a-f99a-49ec-bf5e-735668a607ec",
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
    "id": "107267d2-be34-5a17-9178-f3538179a8cf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "067446b3-2286-4ed3-b40c-6d0406f6a489"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "779afe6e-43e2-45a8-861e-d5b81d05eb1f"
          },
          {
            "type": "lines",
            "id": "8b1918e1-f464-42b1-93cc-78bf558d37dd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1af4552e-1a10-4932-adf8-3c71e13f0165"
          },
          {
            "type": "plannings",
            "id": "f120c59a-0a75-4f2e-9458-009f98728bd9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b4d73ed3-234c-4a32-ab6e-417ec82823c9"
          },
          {
            "type": "stock_item_plannings",
            "id": "cb492b35-8e24-492f-9b0f-a06ebf1c0d1c"
          },
          {
            "type": "stock_item_plannings",
            "id": "f9465075-8e01-4fec-b78f-8172a41c539c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-04T10:47:04+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
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
        "customer_id": "cf4e4347-3d8f-437b-9eaa-e442b62690fc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b",
        "stop_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b"
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
      "id": "779afe6e-43e2-45a8-861e-d5b81d05eb1f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:47:05+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
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
        "item_id": "f28ef77a-f99a-49ec-bf5e-735668a607ec",
        "tax_category_id": "308173b5-d987-4814-855c-00eb975f1da0",
        "planning_id": "1af4552e-1a10-4932-adf8-3c71e13f0165",
        "parent_line_id": null,
        "owner_id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
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
      "id": "8b1918e1-f464-42b1-93cc-78bf558d37dd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:47:06+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
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
        "item_id": "da25f7f5-67b6-40c9-9322-2df864d721e9",
        "tax_category_id": "308173b5-d987-4814-855c-00eb975f1da0",
        "planning_id": "f120c59a-0a75-4f2e-9458-009f98728bd9",
        "parent_line_id": null,
        "owner_id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
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
      "id": "1af4552e-1a10-4932-adf8-3c71e13f0165",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:05+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
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
        "item_id": "f28ef77a-f99a-49ec-bf5e-735668a607ec",
        "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
        "start_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b",
        "stop_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b",
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
      "id": "f120c59a-0a75-4f2e-9458-009f98728bd9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:06+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
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
        "item_id": "da25f7f5-67b6-40c9-9322-2df864d721e9",
        "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489",
        "start_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b",
        "stop_location_id": "0b8a612e-98f1-48e8-a68e-e1f0aa2b7f5b",
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
      "id": "b4d73ed3-234c-4a32-ab6e-417ec82823c9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:06+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ad25a4ac-ef59-4745-a58c-9c999d79fb35",
        "planning_id": "f120c59a-0a75-4f2e-9458-009f98728bd9",
        "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489"
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
      "id": "cb492b35-8e24-492f-9b0f-a06ebf1c0d1c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:06+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "92804a13-55c1-486b-80c4-b33225d7dfa7",
        "planning_id": "f120c59a-0a75-4f2e-9458-009f98728bd9",
        "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489"
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
      "id": "f9465075-8e01-4fec-b78f-8172a41c539c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:06+00:00",
        "updated_at": "2022-03-04T10:47:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d86bf7ad-17ab-473a-8e63-6b97cb1d0d02",
        "planning_id": "f120c59a-0a75-4f2e-9458-009f98728bd9",
        "order_id": "067446b3-2286-4ed3-b40c-6d0406f6a489"
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
          "order_id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8",
          "items": [
            {
              "type": "bundles",
              "id": "4389b331-7572-4969-a9d0-18df0af615b0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1fa87efd-7aa0-4e65-95ad-8d4f9ebb48a2",
                  "id": "9140d73a-77de-4403-bf57-5349cfa24eb8"
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
    "id": "28c1d222-01d1-5f95-b7b2-a1c9b4b12270",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bf7fadf8-8486-4886-b5eb-d2c8b94868a5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5f351bb5-96a4-4320-80c1-d493897b0c73"
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
      "id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-04T10:47:09+00:00",
        "updated_at": "2022-03-04T10:47:10+00:00",
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
        "starts_at": "2022-03-02T10:45:00+00:00",
        "stops_at": "2022-03-06T10:45:00+00:00",
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
        "start_location_id": "a2e94ab7-85b5-4265-a085-2db32cc002d3",
        "stop_location_id": "a2e94ab7-85b5-4265-a085-2db32cc002d3"
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
      "id": "bf7fadf8-8486-4886-b5eb-d2c8b94868a5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-04T10:47:09+00:00",
        "updated_at": "2022-03-04T10:47:09+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "4389b331-7572-4969-a9d0-18df0af615b0",
        "tax_category_id": null,
        "planning_id": "5f351bb5-96a4-4320-80c1-d493897b0c73",
        "parent_line_id": null,
        "owner_id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8",
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
      "id": "5f351bb5-96a4-4320-80c1-d493897b0c73",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-04T10:47:09+00:00",
        "updated_at": "2022-03-04T10:47:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-02T10:45:00+00:00",
        "stops_at": "2022-03-06T10:45:00+00:00",
        "reserved_from": "2022-03-02T10:45:00+00:00",
        "reserved_till": "2022-03-06T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4389b331-7572-4969-a9d0-18df0af615b0",
        "order_id": "c9d4e79c-4743-4c6a-82cc-4c75abfdd5a8",
        "start_location_id": "a2e94ab7-85b5-4265-a085-2db32cc002d3",
        "stop_location_id": "a2e94ab7-85b5-4265-a085-2db32cc002d3",
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





