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
          "order_id": "40767539-2263-4d92-9472-6dad68af60b7",
          "items": [
            {
              "type": "products",
              "id": "9bbaa336-d764-4106-983e-710f25933cde",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "aab6c90e-a39c-4dfe-9b66-4c4d3875edd7",
              "stock_item_ids": [
                "2f5f6272-1f55-459f-bd61-337c977c5d06",
                "7f6ce02e-384b-40c9-9028-a3987ad6f59a"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 2f5f6272-1f55-459f-bd61-337c977c5d06 has already been booked on this order"
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
          "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
          "items": [
            {
              "type": "products",
              "id": "02309dba-cc4b-48d1-a0ec-7061ccf80f60",
              "stock_item_ids": [
                "52797372-ebae-46ea-8ca7-c97f5322f149",
                "284f81ef-9f67-4584-814b-50c2dad950fb",
                "6a7bc3e3-58c1-4453-9e3f-07b6b51e1cf4"
              ]
            },
            {
              "type": "products",
              "id": "4ed04e8d-c218-4fe2-9a66-ebb92eef88c0",
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
    "id": "a5496332-7ca2-51c8-82c7-f9132fd2ba1d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "85474674-63a1-4abd-bd48-64b4c103f23b"
          },
          {
            "type": "lines",
            "id": "7bd4dbe9-f937-4634-98b4-df204ed829db"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a747988b-316a-4d50-bea5-2ce082859740"
          },
          {
            "type": "plannings",
            "id": "c64564dd-5cbc-49f4-9895-039b9a4936d4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7d3aaf39-ecd8-41ab-ba4e-d32581ffeb37"
          },
          {
            "type": "stock_item_plannings",
            "id": "39d8716c-f02e-49ce-9268-fc6209f2f2fd"
          },
          {
            "type": "stock_item_plannings",
            "id": "76f04a18-72e0-4a32-be93-8c077f08183d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T08:59:10+00:00",
        "updated_at": "2023-03-09T08:59:12+00:00",
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
        "customer_id": "bdd7cdcd-0804-4b2d-8c61-b4f62d09397e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7",
        "stop_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7"
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
      "id": "85474674-63a1-4abd-bd48-64b4c103f23b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:12+00:00",
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
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "02309dba-cc4b-48d1-a0ec-7061ccf80f60",
        "tax_category_id": "265252e4-0d4f-4fb6-baa4-afddab5d02ad",
        "planning_id": "a747988b-316a-4d50-bea5-2ce082859740",
        "parent_line_id": null,
        "owner_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
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
      "id": "7bd4dbe9-f937-4634-98b4-df204ed829db",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:12+00:00",
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
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "4ed04e8d-c218-4fe2-9a66-ebb92eef88c0",
        "tax_category_id": "265252e4-0d4f-4fb6-baa4-afddab5d02ad",
        "planning_id": "c64564dd-5cbc-49f4-9895-039b9a4936d4",
        "parent_line_id": null,
        "owner_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
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
      "id": "a747988b-316a-4d50-bea5-2ce082859740",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:11+00:00",
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
        "item_id": "02309dba-cc4b-48d1-a0ec-7061ccf80f60",
        "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
        "start_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7",
        "stop_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7",
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
      "id": "c64564dd-5cbc-49f4-9895-039b9a4936d4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:11+00:00",
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
        "item_id": "4ed04e8d-c218-4fe2-9a66-ebb92eef88c0",
        "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2",
        "start_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7",
        "stop_location_id": "682bc047-9fcd-44f9-91f8-4d1b98d6b2a7",
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
      "id": "7d3aaf39-ecd8-41ab-ba4e-d32581ffeb37",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "52797372-ebae-46ea-8ca7-c97f5322f149",
        "planning_id": "a747988b-316a-4d50-bea5-2ce082859740",
        "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2"
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
      "id": "39d8716c-f02e-49ce-9268-fc6209f2f2fd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "284f81ef-9f67-4584-814b-50c2dad950fb",
        "planning_id": "a747988b-316a-4d50-bea5-2ce082859740",
        "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2"
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
      "id": "76f04a18-72e0-4a32-be93-8c077f08183d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:11+00:00",
        "updated_at": "2023-03-09T08:59:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6a7bc3e3-58c1-4453-9e3f-07b6b51e1cf4",
        "planning_id": "a747988b-316a-4d50-bea5-2ce082859740",
        "order_id": "7ff7a0fe-9154-4b50-afb2-c05552855ae2"
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
          "order_id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c",
          "items": [
            {
              "type": "bundles",
              "id": "f712337d-c442-463c-8667-763fb680e35b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "89e0087e-669a-491b-9ae5-4e7fe5f97ae6",
                  "id": "ec0bcd8c-3b12-48c7-a398-1456e42b9b56"
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
    "id": "c4287683-5887-5683-a3b8-4b332f553c1a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3090ca2e-702c-4338-b07a-3c7e9bc87e54"
          },
          {
            "type": "lines",
            "id": "511b3208-14a6-4114-a33b-9d0cec7e4d89"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6821d531-9ee6-496e-a4d8-d308964332a1"
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
      "id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T08:59:16+00:00",
        "updated_at": "2023-03-09T08:59:17+00:00",
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
        "starts_at": "2023-03-07T08:45:00+00:00",
        "stops_at": "2023-03-11T08:45:00+00:00",
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
        "start_location_id": "8a6271e3-8fe8-4583-96a7-5411f84de8ac",
        "stop_location_id": "8a6271e3-8fe8-4583-96a7-5411f84de8ac"
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
      "id": "3090ca2e-702c-4338-b07a-3c7e9bc87e54",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:17+00:00",
        "updated_at": "2023-03-09T08:59:17+00:00",
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
        "item_id": "ec0bcd8c-3b12-48c7-a398-1456e42b9b56",
        "tax_category_id": null,
        "planning_id": "513e938f-a06e-4437-ba07-6fc7173cfac7",
        "parent_line_id": "511b3208-14a6-4114-a33b-9d0cec7e4d89",
        "owner_id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c",
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
      "id": "511b3208-14a6-4114-a33b-9d0cec7e4d89",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:17+00:00",
        "updated_at": "2023-03-09T08:59:17+00:00",
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
        "item_id": "f712337d-c442-463c-8667-763fb680e35b",
        "tax_category_id": null,
        "planning_id": "6821d531-9ee6-496e-a4d8-d308964332a1",
        "parent_line_id": null,
        "owner_id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c",
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
      "id": "6821d531-9ee6-496e-a4d8-d308964332a1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:16+00:00",
        "updated_at": "2023-03-09T08:59:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-07T08:45:00+00:00",
        "stops_at": "2023-03-11T08:45:00+00:00",
        "reserved_from": "2023-03-07T08:45:00+00:00",
        "reserved_till": "2023-03-11T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f712337d-c442-463c-8667-763fb680e35b",
        "order_id": "6bf68f03-172b-4ab9-a5d8-83d8e5d7119c",
        "start_location_id": "8a6271e3-8fe8-4583-96a7-5411f84de8ac",
        "stop_location_id": "8a6271e3-8fe8-4583-96a7-5411f84de8ac",
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





