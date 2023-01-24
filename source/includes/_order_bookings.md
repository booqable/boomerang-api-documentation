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
          "order_id": "dcbf5209-40ad-4cdf-9332-0ec7bf3f40a4",
          "items": [
            {
              "type": "products",
              "id": "c8590f17-5094-4edd-a43c-0a4c7ee3e3cc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c6f4ffe1-98d3-4e69-aba1-f87397fec281",
              "stock_item_ids": [
                "ec8e4848-c57f-4dac-a676-0e9463a1142e",
                "9db939eb-758a-4f77-aba4-5d958331af02"
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
            "item_id": "c8590f17-5094-4edd-a43c-0a4c7ee3e3cc",
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
          "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b",
          "items": [
            {
              "type": "products",
              "id": "e4bf4fa8-ee34-4ed2-b956-d6605d3489ad",
              "stock_item_ids": [
                "267f1622-5625-413d-9852-98c4182beffd",
                "309ffd4a-7ad6-4420-911b-7108ffe8e1e5",
                "c58cf6ee-b20e-4dc4-a55d-8732aa4bb302"
              ]
            },
            {
              "type": "products",
              "id": "3339d793-298a-4c38-a8dc-ce85cfed321e",
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
    "id": "6fdeed25-bc97-56f2-a3a1-5a525f94f7bd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "15be9f98-9ada-407c-b487-a5becade6a9b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9fcdbef6-d642-478c-b8cf-d40bc647a245"
          },
          {
            "type": "lines",
            "id": "024b8788-11e8-4b71-b14a-ed292a8f68c8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ec73656e-4e01-4fc6-b76b-e751b48b0940"
          },
          {
            "type": "plannings",
            "id": "4b4e758c-7ff3-465b-9c87-945903f2f530"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "94486bc5-113e-4bcf-960c-099208b64669"
          },
          {
            "type": "stock_item_plannings",
            "id": "62783731-03b5-4db0-85c4-3e1d9afbdb20"
          },
          {
            "type": "stock_item_plannings",
            "id": "9cc52faf-6470-4cdb-9db0-6f7a94a88195"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "15be9f98-9ada-407c-b487-a5becade6a9b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T16:32:40+00:00",
        "updated_at": "2023-01-24T16:32:42+00:00",
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
        "customer_id": "8245894b-57f4-4620-a511-1842ae18d570",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d",
        "stop_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d"
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
      "id": "9fcdbef6-d642-478c-b8cf-d40bc647a245",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
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
        "item_id": "e4bf4fa8-ee34-4ed2-b956-d6605d3489ad",
        "tax_category_id": "ca2e6d5a-1cb0-40ce-a9f0-bdb02e9a2fa1",
        "planning_id": "ec73656e-4e01-4fc6-b76b-e751b48b0940",
        "parent_line_id": null,
        "owner_id": "15be9f98-9ada-407c-b487-a5becade6a9b",
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
      "id": "024b8788-11e8-4b71-b14a-ed292a8f68c8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
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
        "item_id": "3339d793-298a-4c38-a8dc-ce85cfed321e",
        "tax_category_id": "ca2e6d5a-1cb0-40ce-a9f0-bdb02e9a2fa1",
        "planning_id": "4b4e758c-7ff3-465b-9c87-945903f2f530",
        "parent_line_id": null,
        "owner_id": "15be9f98-9ada-407c-b487-a5becade6a9b",
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
      "id": "ec73656e-4e01-4fc6-b76b-e751b48b0940",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
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
        "item_id": "e4bf4fa8-ee34-4ed2-b956-d6605d3489ad",
        "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b",
        "start_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d",
        "stop_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d",
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
      "id": "4b4e758c-7ff3-465b-9c87-945903f2f530",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
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
        "item_id": "3339d793-298a-4c38-a8dc-ce85cfed321e",
        "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b",
        "start_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d",
        "stop_location_id": "13fe3a4e-3921-40f0-a331-39c0b18c971d",
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
      "id": "94486bc5-113e-4bcf-960c-099208b64669",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "267f1622-5625-413d-9852-98c4182beffd",
        "planning_id": "ec73656e-4e01-4fc6-b76b-e751b48b0940",
        "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b"
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
      "id": "62783731-03b5-4db0-85c4-3e1d9afbdb20",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "309ffd4a-7ad6-4420-911b-7108ffe8e1e5",
        "planning_id": "ec73656e-4e01-4fc6-b76b-e751b48b0940",
        "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b"
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
      "id": "9cc52faf-6470-4cdb-9db0-6f7a94a88195",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:41+00:00",
        "updated_at": "2023-01-24T16:32:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c58cf6ee-b20e-4dc4-a55d-8732aa4bb302",
        "planning_id": "ec73656e-4e01-4fc6-b76b-e751b48b0940",
        "order_id": "15be9f98-9ada-407c-b487-a5becade6a9b"
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
          "order_id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6",
          "items": [
            {
              "type": "bundles",
              "id": "fda8f9fe-38e5-4771-b7d6-1651aca2286d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6797edf8-5ecc-47a0-b776-b0940f60e846",
                  "id": "0ac987d9-0bd7-48ba-8fd7-a0b877c233aa"
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
    "id": "8976cff3-832c-5291-9418-85370dd285b3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bd252e9c-f744-42dc-8ef0-3c244c11ae53"
          },
          {
            "type": "lines",
            "id": "d06405f1-294b-4c04-a2c2-f3016cf082b2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3a599add-7c18-4b98-aba0-b9d69b73d70f"
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
      "id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T16:32:43+00:00",
        "updated_at": "2023-01-24T16:32:44+00:00",
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
        "starts_at": "2023-01-22T16:30:00+00:00",
        "stops_at": "2023-01-26T16:30:00+00:00",
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
        "start_location_id": "addcf97e-9385-4891-9dfe-1ab49d012962",
        "stop_location_id": "addcf97e-9385-4891-9dfe-1ab49d012962"
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
      "id": "bd252e9c-f744-42dc-8ef0-3c244c11ae53",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T16:32:44+00:00",
        "updated_at": "2023-01-24T16:32:44+00:00",
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
        "item_id": "fda8f9fe-38e5-4771-b7d6-1651aca2286d",
        "tax_category_id": null,
        "planning_id": "3a599add-7c18-4b98-aba0-b9d69b73d70f",
        "parent_line_id": null,
        "owner_id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6",
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
      "id": "d06405f1-294b-4c04-a2c2-f3016cf082b2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T16:32:44+00:00",
        "updated_at": "2023-01-24T16:32:44+00:00",
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
        "item_id": "0ac987d9-0bd7-48ba-8fd7-a0b877c233aa",
        "tax_category_id": null,
        "planning_id": "8529fcd1-9f83-49d1-9f02-84e9209df757",
        "parent_line_id": "bd252e9c-f744-42dc-8ef0-3c244c11ae53",
        "owner_id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6",
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
      "id": "3a599add-7c18-4b98-aba0-b9d69b73d70f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T16:32:44+00:00",
        "updated_at": "2023-01-24T16:32:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-22T16:30:00+00:00",
        "stops_at": "2023-01-26T16:30:00+00:00",
        "reserved_from": "2023-01-22T16:30:00+00:00",
        "reserved_till": "2023-01-26T16:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "fda8f9fe-38e5-4771-b7d6-1651aca2286d",
        "order_id": "d037ac57-bb5e-4c54-bcb6-973f8f1a74c6",
        "start_location_id": "addcf97e-9385-4891-9dfe-1ab49d012962",
        "stop_location_id": "addcf97e-9385-4891-9dfe-1ab49d012962",
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





