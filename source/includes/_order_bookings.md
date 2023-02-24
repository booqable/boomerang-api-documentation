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
          "order_id": "068e1541-e327-4aa3-8287-f665632628bc",
          "items": [
            {
              "type": "products",
              "id": "77524ca7-5e07-489e-a9b8-37083cc017c9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5083a94c-58aa-4bc3-a4ef-4fb13ab7ea59",
              "stock_item_ids": [
                "3d8e7fa4-58be-479c-bd81-1b2d53dace1b",
                "f7fe69af-b214-4a6e-9fde-1fa2e6f108e1"
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
          "stock_item_id 3d8e7fa4-58be-479c-bd81-1b2d53dace1b has already been booked on this order"
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
          "order_id": "36932165-f103-4302-8147-ac620975a568",
          "items": [
            {
              "type": "products",
              "id": "472dac5b-bcb8-48ba-8704-a503986d1b3e",
              "stock_item_ids": [
                "23d75c08-8030-4089-899e-2a85d4001443",
                "5c612544-cee6-4a74-bb65-28ad8e1f8d2d",
                "42c4eb54-0280-4fe8-987f-938866480562"
              ]
            },
            {
              "type": "products",
              "id": "788b2722-6bf3-4cbf-94d6-1c5f04c4c8cb",
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
    "id": "d5a98cd0-bb47-538c-84b8-7a8ecd123c49",
    "type": "order_bookings",
    "attributes": {
      "order_id": "36932165-f103-4302-8147-ac620975a568"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "36932165-f103-4302-8147-ac620975a568"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "915b9140-f003-4c17-b6a5-96cc8bbe88ad"
          },
          {
            "type": "lines",
            "id": "9fcf6460-8935-4fd2-90d6-ed76f4c4ce8f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91"
          },
          {
            "type": "plannings",
            "id": "9481b2bd-2e40-4ed7-acd0-01981bde965f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f34b6e6c-a12e-487d-8321-835c77013396"
          },
          {
            "type": "stock_item_plannings",
            "id": "eda066ba-d95e-4e3d-baca-02df89f85497"
          },
          {
            "type": "stock_item_plannings",
            "id": "a136eb78-b865-463b-8ffe-e54ad573f5fd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "36932165-f103-4302-8147-ac620975a568",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T09:48:41+00:00",
        "updated_at": "2023-02-24T09:48:44+00:00",
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
        "customer_id": "cffad8d1-924b-42b6-8ba1-0052a7193714",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45",
        "stop_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45"
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
      "id": "915b9140-f003-4c17-b6a5-96cc8bbe88ad",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:44+00:00",
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
        "item_id": "472dac5b-bcb8-48ba-8704-a503986d1b3e",
        "tax_category_id": "ba96c182-ad00-476e-bdbd-6b03bc47be94",
        "planning_id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91",
        "parent_line_id": null,
        "owner_id": "36932165-f103-4302-8147-ac620975a568",
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
      "id": "9fcf6460-8935-4fd2-90d6-ed76f4c4ce8f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:44+00:00",
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
        "item_id": "788b2722-6bf3-4cbf-94d6-1c5f04c4c8cb",
        "tax_category_id": "ba96c182-ad00-476e-bdbd-6b03bc47be94",
        "planning_id": "9481b2bd-2e40-4ed7-acd0-01981bde965f",
        "parent_line_id": null,
        "owner_id": "36932165-f103-4302-8147-ac620975a568",
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
      "id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:43+00:00",
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
        "item_id": "472dac5b-bcb8-48ba-8704-a503986d1b3e",
        "order_id": "36932165-f103-4302-8147-ac620975a568",
        "start_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45",
        "stop_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45",
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
      "id": "9481b2bd-2e40-4ed7-acd0-01981bde965f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:43+00:00",
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
        "item_id": "788b2722-6bf3-4cbf-94d6-1c5f04c4c8cb",
        "order_id": "36932165-f103-4302-8147-ac620975a568",
        "start_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45",
        "stop_location_id": "62795813-e586-46d7-bf1b-bd6dd543cf45",
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
      "id": "f34b6e6c-a12e-487d-8321-835c77013396",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "23d75c08-8030-4089-899e-2a85d4001443",
        "planning_id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91",
        "order_id": "36932165-f103-4302-8147-ac620975a568"
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
      "id": "eda066ba-d95e-4e3d-baca-02df89f85497",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5c612544-cee6-4a74-bb65-28ad8e1f8d2d",
        "planning_id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91",
        "order_id": "36932165-f103-4302-8147-ac620975a568"
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
      "id": "a136eb78-b865-463b-8ffe-e54ad573f5fd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:43+00:00",
        "updated_at": "2023-02-24T09:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "42c4eb54-0280-4fe8-987f-938866480562",
        "planning_id": "aca3501d-be01-4ce1-aea2-91a91ee2ff91",
        "order_id": "36932165-f103-4302-8147-ac620975a568"
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
          "order_id": "32c71d79-b1f8-46e3-8784-e5545b356c3d",
          "items": [
            {
              "type": "bundles",
              "id": "809a2f93-7d5f-489e-9f37-010c5a533224",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "994c11aa-0441-40f3-9125-a907330795f0",
                  "id": "affd0087-8f7b-4077-979e-cd01d0f0afdd"
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
    "id": "5d6f680e-b84f-5c0e-be93-4055e3e55f60",
    "type": "order_bookings",
    "attributes": {
      "order_id": "32c71d79-b1f8-46e3-8784-e5545b356c3d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "32c71d79-b1f8-46e3-8784-e5545b356c3d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6e1ddcda-b3d4-4f61-9059-9154d7482575"
          },
          {
            "type": "lines",
            "id": "88ed9ae7-fa7f-40de-b34b-94f89432cf78"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ac49b63a-fb78-4848-b052-edf5d3eb4e8f"
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
      "id": "32c71d79-b1f8-46e3-8784-e5545b356c3d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T09:48:46+00:00",
        "updated_at": "2023-02-24T09:48:47+00:00",
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
        "starts_at": "2023-02-22T09:45:00+00:00",
        "stops_at": "2023-02-26T09:45:00+00:00",
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
        "start_location_id": "e755c677-0fb7-4238-881f-748a9a1bcf2d",
        "stop_location_id": "e755c677-0fb7-4238-881f-748a9a1bcf2d"
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
      "id": "6e1ddcda-b3d4-4f61-9059-9154d7482575",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:48:47+00:00",
        "updated_at": "2023-02-24T09:48:47+00:00",
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
        "item_id": "affd0087-8f7b-4077-979e-cd01d0f0afdd",
        "tax_category_id": null,
        "planning_id": "1c63ba65-81f1-4056-853b-7973ee6dbad8",
        "parent_line_id": "88ed9ae7-fa7f-40de-b34b-94f89432cf78",
        "owner_id": "32c71d79-b1f8-46e3-8784-e5545b356c3d",
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
      "id": "88ed9ae7-fa7f-40de-b34b-94f89432cf78",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:48:47+00:00",
        "updated_at": "2023-02-24T09:48:47+00:00",
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
        "item_id": "809a2f93-7d5f-489e-9f37-010c5a533224",
        "tax_category_id": null,
        "planning_id": "ac49b63a-fb78-4848-b052-edf5d3eb4e8f",
        "parent_line_id": null,
        "owner_id": "32c71d79-b1f8-46e3-8784-e5545b356c3d",
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
      "id": "ac49b63a-fb78-4848-b052-edf5d3eb4e8f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:48:47+00:00",
        "updated_at": "2023-02-24T09:48:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T09:45:00+00:00",
        "stops_at": "2023-02-26T09:45:00+00:00",
        "reserved_from": "2023-02-22T09:45:00+00:00",
        "reserved_till": "2023-02-26T09:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "809a2f93-7d5f-489e-9f37-010c5a533224",
        "order_id": "32c71d79-b1f8-46e3-8784-e5545b356c3d",
        "start_location_id": "e755c677-0fb7-4238-881f-748a9a1bcf2d",
        "stop_location_id": "e755c677-0fb7-4238-881f-748a9a1bcf2d",
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





