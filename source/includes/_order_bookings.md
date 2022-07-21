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
          "order_id": "38a7c077-ba1e-4dcc-b390-7ca06398a848",
          "items": [
            {
              "type": "products",
              "id": "206c643a-9b41-4794-b4be-97fce69611b5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "cb6e609e-1e30-4a61-bc53-c7a79b2261ff",
              "stock_item_ids": [
                "5d1656fa-1389-4253-998f-c0d2782c036c",
                "580f827d-ec78-4334-aaca-a5490fe076c7"
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
            "item_id": "206c643a-9b41-4794-b4be-97fce69611b5",
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
          "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
          "items": [
            {
              "type": "products",
              "id": "0028e397-2f16-469b-bb11-be928a86454e",
              "stock_item_ids": [
                "eb4dcefd-eb7c-40c7-92ad-4f1d8debcda2",
                "f420e321-c946-45b1-a650-6a203ff0d80c",
                "d1b9d48f-091e-4115-aae0-a0ef48988540"
              ]
            },
            {
              "type": "products",
              "id": "21ac8239-b766-4f00-a937-322469edce91",
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
    "id": "7b2323ab-d684-5366-981b-57ec560a8be0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "de8802c0-0477-4f58-9a03-bf7d9e0a089e"
          },
          {
            "type": "lines",
            "id": "1f75ad3d-3880-4140-a9b3-0ade64d5e6ea"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a1d49c24-7e61-49ff-a6fc-1b1ddc84afcf"
          },
          {
            "type": "plannings",
            "id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3b9d3678-56be-4a97-8cfe-7222bf9d0b5f"
          },
          {
            "type": "stock_item_plannings",
            "id": "54833aea-d821-4335-bd20-09f4cc6130e1"
          },
          {
            "type": "stock_item_plannings",
            "id": "37dea5d5-14e8-40af-a031-a6bbde179d92"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-21T10:58:22+00:00",
        "updated_at": "2022-07-21T10:58:26+00:00",
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
        "customer_id": "7545a7ad-7197-449e-93b9-27bc2b780ed0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68",
        "stop_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68"
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
      "id": "de8802c0-0477-4f58-9a03-bf7d9e0a089e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-21T10:58:24+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
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
        "item_id": "21ac8239-b766-4f00-a937-322469edce91",
        "tax_category_id": "e953ce05-df8f-4890-80b5-eae2aab496ed",
        "planning_id": "a1d49c24-7e61-49ff-a6fc-1b1ddc84afcf",
        "parent_line_id": null,
        "owner_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
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
      "id": "1f75ad3d-3880-4140-a9b3-0ade64d5e6ea",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-21T10:58:25+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
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
        "item_id": "0028e397-2f16-469b-bb11-be928a86454e",
        "tax_category_id": "e953ce05-df8f-4890-80b5-eae2aab496ed",
        "planning_id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1",
        "parent_line_id": null,
        "owner_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
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
      "id": "a1d49c24-7e61-49ff-a6fc-1b1ddc84afcf",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:23+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
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
        "item_id": "21ac8239-b766-4f00-a937-322469edce91",
        "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
        "start_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68",
        "stop_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68",
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
      "id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:25+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
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
        "item_id": "0028e397-2f16-469b-bb11-be928a86454e",
        "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d",
        "start_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68",
        "stop_location_id": "8232e2f7-b406-439b-bd9e-f989ce977a68",
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
      "id": "3b9d3678-56be-4a97-8cfe-7222bf9d0b5f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:25+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eb4dcefd-eb7c-40c7-92ad-4f1d8debcda2",
        "planning_id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1",
        "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d"
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
      "id": "54833aea-d821-4335-bd20-09f4cc6130e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:25+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f420e321-c946-45b1-a650-6a203ff0d80c",
        "planning_id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1",
        "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d"
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
      "id": "37dea5d5-14e8-40af-a031-a6bbde179d92",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:25+00:00",
        "updated_at": "2022-07-21T10:58:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d1b9d48f-091e-4115-aae0-a0ef48988540",
        "planning_id": "1b7d4f18-9f97-4dda-a626-3ffff3c651d1",
        "order_id": "cf71fc3f-e9f4-4fb9-9afd-cd516500de6d"
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
          "order_id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be",
          "items": [
            {
              "type": "bundles",
              "id": "5d0a89c6-d87b-4ef0-a006-9d776667f659",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e4bb5308-922e-4c14-9458-f024d6d25946",
                  "id": "cb29d20e-04d8-4b68-9e35-7da3bd302f63"
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
    "id": "0922b4e8-5bfe-5ea7-821c-1a527255f9fb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "56af2006-167f-40e5-8ab1-35ce9312ff06"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "992dd711-9d71-4905-90bc-3dbc83c7b917"
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
      "id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-21T10:58:28+00:00",
        "updated_at": "2022-07-21T10:58:30+00:00",
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
        "starts_at": "2022-07-19T10:45:00+00:00",
        "stops_at": "2022-07-23T10:45:00+00:00",
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
        "start_location_id": "b88b363c-b985-497b-b64c-4f0485c72ced",
        "stop_location_id": "b88b363c-b985-497b-b64c-4f0485c72ced"
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
      "id": "56af2006-167f-40e5-8ab1-35ce9312ff06",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-21T10:58:29+00:00",
        "updated_at": "2022-07-21T10:58:29+00:00",
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
        "item_id": "5d0a89c6-d87b-4ef0-a006-9d776667f659",
        "tax_category_id": null,
        "planning_id": "992dd711-9d71-4905-90bc-3dbc83c7b917",
        "parent_line_id": null,
        "owner_id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be",
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
      "id": "992dd711-9d71-4905-90bc-3dbc83c7b917",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-21T10:58:29+00:00",
        "updated_at": "2022-07-21T10:58:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-19T10:45:00+00:00",
        "stops_at": "2022-07-23T10:45:00+00:00",
        "reserved_from": "2022-07-19T10:45:00+00:00",
        "reserved_till": "2022-07-23T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5d0a89c6-d87b-4ef0-a006-9d776667f659",
        "order_id": "5f3c5606-c1c9-4cbb-a485-55a32823b7be",
        "start_location_id": "b88b363c-b985-497b-b64c-4f0485c72ced",
        "stop_location_id": "b88b363c-b985-497b-b64c-4f0485c72ced",
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





