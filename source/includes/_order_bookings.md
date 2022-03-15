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
          "order_id": "b3c54465-e843-496d-9ddb-3371607253d8",
          "items": [
            {
              "type": "products",
              "id": "67fd702c-4f41-469a-9f44-d80c3b5286f9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "62bdb053-cc19-42f2-b0b2-8c1cda550ce0",
              "stock_item_ids": [
                "09cb51c1-77b5-4887-bb4f-252c3d6f1a00",
                "c23757b3-96dc-4e1e-8349-e12de5a07104"
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
            "item_id": "67fd702c-4f41-469a-9f44-d80c3b5286f9",
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
          "order_id": "a7e970f1-898b-4972-ad33-111538343354",
          "items": [
            {
              "type": "products",
              "id": "bb088ebd-188d-472a-8e1f-51bfb8cec103",
              "stock_item_ids": [
                "197f093e-e365-419c-9d17-23320c9e40e7",
                "7a98d4b5-0e93-4ca8-a5d4-d5e54da4bd18",
                "d275255c-e469-4cda-b75c-8702a3ccc17b"
              ]
            },
            {
              "type": "products",
              "id": "9d676417-9b02-434e-8758-c397c22ddd56",
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
    "id": "ba22e1f5-0a4b-5f5d-9251-f018e17231c0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a7e970f1-898b-4972-ad33-111538343354"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a7e970f1-898b-4972-ad33-111538343354"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e4d2f78d-7dcd-454f-9b42-abab2e594548"
          },
          {
            "type": "lines",
            "id": "1a288cb0-22a3-483a-93af-e8d7273e09bc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9d8e20a8-7cfe-4fee-af14-fa50a4ff1042"
          },
          {
            "type": "plannings",
            "id": "3e985b6a-315f-4e7a-beed-7c431c72510f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e56a5ad2-5027-480a-82fa-ddb0374b18a7"
          },
          {
            "type": "stock_item_plannings",
            "id": "27b12814-b8e5-4c30-b761-9a345b42a345"
          },
          {
            "type": "stock_item_plannings",
            "id": "c22f0eec-c15d-4885-8ed0-ec058f59cdb2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a7e970f1-898b-4972-ad33-111538343354",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-15T16:24:37+00:00",
        "updated_at": "2022-03-15T16:24:40+00:00",
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
        "customer_id": "53f2df55-f841-481c-8965-d1c91b55f5d8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c",
        "stop_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c"
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
      "id": "e4d2f78d-7dcd-454f-9b42-abab2e594548",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T16:24:38+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
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
        "item_id": "9d676417-9b02-434e-8758-c397c22ddd56",
        "tax_category_id": "9b982aff-53c1-4d1d-9669-d578df6ee168",
        "planning_id": "9d8e20a8-7cfe-4fee-af14-fa50a4ff1042",
        "parent_line_id": null,
        "owner_id": "a7e970f1-898b-4972-ad33-111538343354",
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
      "id": "1a288cb0-22a3-483a-93af-e8d7273e09bc",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T16:24:39+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
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
        "item_id": "bb088ebd-188d-472a-8e1f-51bfb8cec103",
        "tax_category_id": "9b982aff-53c1-4d1d-9669-d578df6ee168",
        "planning_id": "3e985b6a-315f-4e7a-beed-7c431c72510f",
        "parent_line_id": null,
        "owner_id": "a7e970f1-898b-4972-ad33-111538343354",
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
      "id": "9d8e20a8-7cfe-4fee-af14-fa50a4ff1042",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:37+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
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
        "item_id": "9d676417-9b02-434e-8758-c397c22ddd56",
        "order_id": "a7e970f1-898b-4972-ad33-111538343354",
        "start_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c",
        "stop_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c",
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
      "id": "3e985b6a-315f-4e7a-beed-7c431c72510f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:39+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
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
        "item_id": "bb088ebd-188d-472a-8e1f-51bfb8cec103",
        "order_id": "a7e970f1-898b-4972-ad33-111538343354",
        "start_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c",
        "stop_location_id": "56b1ab79-610a-473a-ac92-c0adb6f95d5c",
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
      "id": "e56a5ad2-5027-480a-82fa-ddb0374b18a7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:39+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "197f093e-e365-419c-9d17-23320c9e40e7",
        "planning_id": "3e985b6a-315f-4e7a-beed-7c431c72510f",
        "order_id": "a7e970f1-898b-4972-ad33-111538343354"
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
      "id": "27b12814-b8e5-4c30-b761-9a345b42a345",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:39+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7a98d4b5-0e93-4ca8-a5d4-d5e54da4bd18",
        "planning_id": "3e985b6a-315f-4e7a-beed-7c431c72510f",
        "order_id": "a7e970f1-898b-4972-ad33-111538343354"
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
      "id": "c22f0eec-c15d-4885-8ed0-ec058f59cdb2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:39+00:00",
        "updated_at": "2022-03-15T16:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d275255c-e469-4cda-b75c-8702a3ccc17b",
        "planning_id": "3e985b6a-315f-4e7a-beed-7c431c72510f",
        "order_id": "a7e970f1-898b-4972-ad33-111538343354"
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
          "order_id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb",
          "items": [
            {
              "type": "bundles",
              "id": "ae4db0d7-207f-4333-867f-07279e9eecec",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "20dbf9ab-0c71-419d-9901-8951bb580b00",
                  "id": "b4b36f23-6fff-4009-8de9-43b926c8189f"
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
    "id": "bba1aa49-6dcc-5281-835f-7ccd51455025",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f76e2a8b-fbc6-42c4-9549-64bab3b10190"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cde41c1e-47b7-466e-af84-de0b9c757090"
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
      "id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-15T16:24:43+00:00",
        "updated_at": "2022-03-15T16:24:44+00:00",
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
        "starts_at": "2022-03-13T16:15:00+00:00",
        "stops_at": "2022-03-17T16:15:00+00:00",
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
        "start_location_id": "806f67ab-3f5f-435b-9a73-534193aef4f2",
        "stop_location_id": "806f67ab-3f5f-435b-9a73-534193aef4f2"
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
      "id": "f76e2a8b-fbc6-42c4-9549-64bab3b10190",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T16:24:44+00:00",
        "updated_at": "2022-03-15T16:24:44+00:00",
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
        "item_id": "ae4db0d7-207f-4333-867f-07279e9eecec",
        "tax_category_id": null,
        "planning_id": "cde41c1e-47b7-466e-af84-de0b9c757090",
        "parent_line_id": null,
        "owner_id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb",
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
      "id": "cde41c1e-47b7-466e-af84-de0b9c757090",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T16:24:44+00:00",
        "updated_at": "2022-03-15T16:24:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-13T16:15:00+00:00",
        "stops_at": "2022-03-17T16:15:00+00:00",
        "reserved_from": "2022-03-13T16:15:00+00:00",
        "reserved_till": "2022-03-17T16:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ae4db0d7-207f-4333-867f-07279e9eecec",
        "order_id": "e55ac63e-b2ce-4d56-b393-17c9ec0653fb",
        "start_location_id": "806f67ab-3f5f-435b-9a73-534193aef4f2",
        "stop_location_id": "806f67ab-3f5f-435b-9a73-534193aef4f2",
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





