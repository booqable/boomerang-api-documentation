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
          "order_id": "e50ec426-46c0-4bf0-9a0b-70fd27fe57c2",
          "items": [
            {
              "type": "products",
              "id": "3c7a67aa-0969-4924-a5bb-f1978b284506",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2d8a3ef9-abeb-4cb7-b9b0-526754d7c221",
              "stock_item_ids": [
                "476423d3-f6ca-4c47-8f98-c4b59896d542",
                "8b6a91b0-f8aa-4203-aeb1-59e2a9eace33"
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
            "item_id": "3c7a67aa-0969-4924-a5bb-f1978b284506",
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
          "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
          "items": [
            {
              "type": "products",
              "id": "aa3b17a4-5e70-4abc-98e9-01b487a479a3",
              "stock_item_ids": [
                "f11b33f0-8b2b-4ced-aedc-b400d018e02d",
                "888da355-df55-4a01-bb1b-93e349d136a1",
                "08311343-0910-4216-975a-1f555eb89927"
              ]
            },
            {
              "type": "products",
              "id": "b11aeadb-2de5-4d73-aa17-eb30dfb4a757",
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
    "id": "cc3b7a2f-4156-553d-9ce3-334210421e55",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ba64a05f-3756-48cb-8191-03b195b1ca58"
          },
          {
            "type": "lines",
            "id": "4b984e53-ce8d-4722-bf4f-2c4255cc4e1b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6ec7b38f-92cf-46e3-af82-0c34edcadaed"
          },
          {
            "type": "plannings",
            "id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8997722c-8e7d-4c90-b24c-132322070004"
          },
          {
            "type": "stock_item_plannings",
            "id": "85af78cd-b294-47a5-9923-013008916369"
          },
          {
            "type": "stock_item_plannings",
            "id": "5a877174-db5c-45cd-b795-cf84b7214fc7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T10:05:33+00:00",
        "updated_at": "2022-04-07T10:05:35+00:00",
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
        "customer_id": "4707a083-1373-486c-bf78-ac4b63e1f784",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf",
        "stop_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf"
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
      "id": "ba64a05f-3756-48cb-8191-03b195b1ca58",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:05:33+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
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
        "item_id": "b11aeadb-2de5-4d73-aa17-eb30dfb4a757",
        "tax_category_id": "d04e2683-9de1-4f8f-828d-d2efb07c257c",
        "planning_id": "6ec7b38f-92cf-46e3-af82-0c34edcadaed",
        "parent_line_id": null,
        "owner_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
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
      "id": "4b984e53-ce8d-4722-bf4f-2c4255cc4e1b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:05:34+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
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
        "item_id": "aa3b17a4-5e70-4abc-98e9-01b487a479a3",
        "tax_category_id": "d04e2683-9de1-4f8f-828d-d2efb07c257c",
        "planning_id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca",
        "parent_line_id": null,
        "owner_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
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
      "id": "6ec7b38f-92cf-46e3-af82-0c34edcadaed",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:33+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
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
        "item_id": "b11aeadb-2de5-4d73-aa17-eb30dfb4a757",
        "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
        "start_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf",
        "stop_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf",
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
      "id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:34+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
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
        "item_id": "aa3b17a4-5e70-4abc-98e9-01b487a479a3",
        "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14",
        "start_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf",
        "stop_location_id": "744abd6f-8c40-4463-94bd-ee71b0f73edf",
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
      "id": "8997722c-8e7d-4c90-b24c-132322070004",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:34+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f11b33f0-8b2b-4ced-aedc-b400d018e02d",
        "planning_id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca",
        "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14"
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
      "id": "85af78cd-b294-47a5-9923-013008916369",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:34+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "888da355-df55-4a01-bb1b-93e349d136a1",
        "planning_id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca",
        "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14"
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
      "id": "5a877174-db5c-45cd-b795-cf84b7214fc7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:34+00:00",
        "updated_at": "2022-04-07T10:05:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "08311343-0910-4216-975a-1f555eb89927",
        "planning_id": "ea3d7ee9-7910-46d7-8a01-5921c6a08bca",
        "order_id": "5a7f1a0a-87b7-4da7-aaa4-e412cc112d14"
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
          "order_id": "04946da7-695d-4b49-bda7-c3ba72ca072a",
          "items": [
            {
              "type": "bundles",
              "id": "1fe7c22e-373d-428c-a763-9454533886b2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3f18d8a9-0518-4e52-a094-109da70c4012",
                  "id": "e35eaff1-04ec-44e6-8d87-5713be0a0e54"
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
    "id": "f9576c4c-7e3b-5b8f-9797-c7ab9afe0bc2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "04946da7-695d-4b49-bda7-c3ba72ca072a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "04946da7-695d-4b49-bda7-c3ba72ca072a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fbcb7adf-fb23-4bf8-a778-a2ddc0dc053e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ba90c60c-10a3-41a8-9b59-dd89b1a58419"
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
      "id": "04946da7-695d-4b49-bda7-c3ba72ca072a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-07T10:05:37+00:00",
        "updated_at": "2022-04-07T10:05:38+00:00",
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
        "starts_at": "2022-04-05T10:00:00+00:00",
        "stops_at": "2022-04-09T10:00:00+00:00",
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
        "start_location_id": "f5e5a8fb-573d-49c7-9da8-58acdf3267d3",
        "stop_location_id": "f5e5a8fb-573d-49c7-9da8-58acdf3267d3"
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
      "id": "fbcb7adf-fb23-4bf8-a778-a2ddc0dc053e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-07T10:05:37+00:00",
        "updated_at": "2022-04-07T10:05:37+00:00",
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
        "item_id": "1fe7c22e-373d-428c-a763-9454533886b2",
        "tax_category_id": null,
        "planning_id": "ba90c60c-10a3-41a8-9b59-dd89b1a58419",
        "parent_line_id": null,
        "owner_id": "04946da7-695d-4b49-bda7-c3ba72ca072a",
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
      "id": "ba90c60c-10a3-41a8-9b59-dd89b1a58419",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-07T10:05:37+00:00",
        "updated_at": "2022-04-07T10:05:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-05T10:00:00+00:00",
        "stops_at": "2022-04-09T10:00:00+00:00",
        "reserved_from": "2022-04-05T10:00:00+00:00",
        "reserved_till": "2022-04-09T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1fe7c22e-373d-428c-a763-9454533886b2",
        "order_id": "04946da7-695d-4b49-bda7-c3ba72ca072a",
        "start_location_id": "f5e5a8fb-573d-49c7-9da8-58acdf3267d3",
        "stop_location_id": "f5e5a8fb-573d-49c7-9da8-58acdf3267d3",
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





