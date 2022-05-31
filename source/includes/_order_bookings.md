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
          "order_id": "e1a5ba81-10c7-4432-8106-4f0c0e76dd10",
          "items": [
            {
              "type": "products",
              "id": "32d1cbe0-1eae-435b-af3f-6fbcf64c1493",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c5e5215a-3974-4007-8bf3-dcc420325352",
              "stock_item_ids": [
                "fffba131-eaff-4c6f-b661-e73fc8e02ba8",
                "fa510ab9-d8de-4946-8455-b64b8a562095"
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
            "item_id": "32d1cbe0-1eae-435b-af3f-6fbcf64c1493",
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
          "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
          "items": [
            {
              "type": "products",
              "id": "0b5973f2-782b-440a-89c8-35ab38405161",
              "stock_item_ids": [
                "7c79f85d-f0b0-432e-aea3-19a1fa9ed212",
                "ba58e6b9-1f4c-41ae-956b-52a14e4dbc7d",
                "98626fba-ac71-40b9-9581-12809e4b3f92"
              ]
            },
            {
              "type": "products",
              "id": "58d367b0-78b7-4489-bd43-688a2bc8a013",
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
    "id": "89cf3386-b839-5f46-888a-44b2f16cfd13",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9d1098f1-0b21-4951-a5ab-4d36dd753811"
          },
          {
            "type": "lines",
            "id": "7492a56c-3edc-4674-b66d-919a4949c274"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "86cbb8f6-ac8b-4049-8e30-f9ad0b6a150c"
          },
          {
            "type": "plannings",
            "id": "6dcf422c-1259-492b-bf7a-9daf145c5f40"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f6ed40df-7e43-41d9-8582-92ec029e35c1"
          },
          {
            "type": "stock_item_plannings",
            "id": "2f5951f5-69de-4ef3-8ce6-e8d2e97f0286"
          },
          {
            "type": "stock_item_plannings",
            "id": "c9960c9b-d7de-4525-aac9-6f525f850e97"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-31T06:56:11+00:00",
        "updated_at": "2022-05-31T06:56:14+00:00",
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
        "customer_id": "cb5b0e28-ab8c-4d0b-91d4-c569fc262ac5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e",
        "stop_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e"
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
      "id": "9d1098f1-0b21-4951-a5ab-4d36dd753811",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T06:56:12+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
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
        "item_id": "58d367b0-78b7-4489-bd43-688a2bc8a013",
        "tax_category_id": "6a2db8bc-5888-4dd8-bfa9-b98854bbdb0c",
        "planning_id": "86cbb8f6-ac8b-4049-8e30-f9ad0b6a150c",
        "parent_line_id": null,
        "owner_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
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
      "id": "7492a56c-3edc-4674-b66d-919a4949c274",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T06:56:13+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
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
        "item_id": "0b5973f2-782b-440a-89c8-35ab38405161",
        "tax_category_id": "6a2db8bc-5888-4dd8-bfa9-b98854bbdb0c",
        "planning_id": "6dcf422c-1259-492b-bf7a-9daf145c5f40",
        "parent_line_id": null,
        "owner_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
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
      "id": "86cbb8f6-ac8b-4049-8e30-f9ad0b6a150c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:12+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
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
        "item_id": "58d367b0-78b7-4489-bd43-688a2bc8a013",
        "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
        "start_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e",
        "stop_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e",
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
      "id": "6dcf422c-1259-492b-bf7a-9daf145c5f40",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:13+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
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
        "item_id": "0b5973f2-782b-440a-89c8-35ab38405161",
        "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620",
        "start_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e",
        "stop_location_id": "c308bb03-f3cd-469d-9f06-ff9243c9866e",
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
      "id": "f6ed40df-7e43-41d9-8582-92ec029e35c1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:13+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7c79f85d-f0b0-432e-aea3-19a1fa9ed212",
        "planning_id": "6dcf422c-1259-492b-bf7a-9daf145c5f40",
        "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620"
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
      "id": "2f5951f5-69de-4ef3-8ce6-e8d2e97f0286",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:13+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ba58e6b9-1f4c-41ae-956b-52a14e4dbc7d",
        "planning_id": "6dcf422c-1259-492b-bf7a-9daf145c5f40",
        "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620"
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
      "id": "c9960c9b-d7de-4525-aac9-6f525f850e97",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:13+00:00",
        "updated_at": "2022-05-31T06:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "98626fba-ac71-40b9-9581-12809e4b3f92",
        "planning_id": "6dcf422c-1259-492b-bf7a-9daf145c5f40",
        "order_id": "7587c12e-7d1d-47ca-a9a9-81a6d4566620"
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
          "order_id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05",
          "items": [
            {
              "type": "bundles",
              "id": "f2669c5f-4c78-4361-8b68-e43118a9a729",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ceb0e79d-a455-42f4-b4f3-b34f74941642",
                  "id": "ef98d9cb-2c14-4f94-8fb9-41f7f21b2dad"
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
    "id": "012368d7-9db0-5ca2-9594-71d20f1f2b35",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b88aae3f-0fce-4b4f-b17a-1f01e1490ec2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8ae04b24-65e8-4f97-8393-3267ad25339d"
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
      "id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-31T06:56:16+00:00",
        "updated_at": "2022-05-31T06:56:17+00:00",
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
        "starts_at": "2022-05-29T06:45:00+00:00",
        "stops_at": "2022-06-02T06:45:00+00:00",
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
        "start_location_id": "2beea580-269d-4286-af2d-74f79cda666e",
        "stop_location_id": "2beea580-269d-4286-af2d-74f79cda666e"
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
      "id": "b88aae3f-0fce-4b4f-b17a-1f01e1490ec2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T06:56:17+00:00",
        "updated_at": "2022-05-31T06:56:17+00:00",
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
        "item_id": "f2669c5f-4c78-4361-8b68-e43118a9a729",
        "tax_category_id": null,
        "planning_id": "8ae04b24-65e8-4f97-8393-3267ad25339d",
        "parent_line_id": null,
        "owner_id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05",
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
      "id": "8ae04b24-65e8-4f97-8393-3267ad25339d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T06:56:17+00:00",
        "updated_at": "2022-05-31T06:56:17+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-29T06:45:00+00:00",
        "stops_at": "2022-06-02T06:45:00+00:00",
        "reserved_from": "2022-05-29T06:45:00+00:00",
        "reserved_till": "2022-06-02T06:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f2669c5f-4c78-4361-8b68-e43118a9a729",
        "order_id": "ecc85818-a346-49f9-bcbd-33fb0d6dac05",
        "start_location_id": "2beea580-269d-4286-af2d-74f79cda666e",
        "stop_location_id": "2beea580-269d-4286-af2d-74f79cda666e",
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





