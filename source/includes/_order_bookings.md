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
          "order_id": "cb3c9ef6-583e-4412-be9c-3b35e53f48fb",
          "items": [
            {
              "type": "products",
              "id": "445cd6f4-d238-4052-905a-cf5cdcf283d6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "694e4ab4-484f-4d96-a36e-beb944817855",
              "stock_item_ids": [
                "7c2d0f35-be5a-41e3-bb0c-28476373a123",
                "9cd6fe2e-1363-4ea3-bae6-3da4a04692bf"
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
            "item_id": "445cd6f4-d238-4052-905a-cf5cdcf283d6",
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
          "order_id": "62484734-f90a-4cc6-8347-47c42fa17240",
          "items": [
            {
              "type": "products",
              "id": "0e6c4c5c-318a-4714-9971-ca67e70c25c9",
              "stock_item_ids": [
                "b0bb7f88-03f8-4658-959e-42b0b49702b2",
                "c333e770-d5b9-4672-b9c0-8a0ead934ded",
                "3e396f32-4c49-42f5-87d6-f269a1ca8eb2"
              ]
            },
            {
              "type": "products",
              "id": "0844a8a9-d6b8-40a8-ac94-71dba5faf106",
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
    "id": "14cf1a58-f625-517f-8475-935146781a1b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "62484734-f90a-4cc6-8347-47c42fa17240"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "62484734-f90a-4cc6-8347-47c42fa17240"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d8dcf4fa-79f3-4f70-82a3-84315d752503"
          },
          {
            "type": "lines",
            "id": "541dc0a2-15ee-4944-af0a-94cee6cd5c4c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "24326589-1ff2-4480-bc0a-84c295ad700b"
          },
          {
            "type": "plannings",
            "id": "f923427a-1511-4e54-a0af-42c7bef58850"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3c11d044-7589-4126-80df-2899e3bf2d10"
          },
          {
            "type": "stock_item_plannings",
            "id": "7b301bcb-4603-4cea-95f2-1ddc9209faed"
          },
          {
            "type": "stock_item_plannings",
            "id": "bbc67920-6b0a-4207-9ce8-5e647f803342"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "62484734-f90a-4cc6-8347-47c42fa17240",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-23T19:02:31+00:00",
        "updated_at": "2022-06-23T19:02:34+00:00",
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
        "customer_id": "81dfa6b7-f2bb-42c7-bcbf-d7620670f281",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467",
        "stop_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467"
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
      "id": "d8dcf4fa-79f3-4f70-82a3-84315d752503",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T19:02:32+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
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
        "item_id": "0844a8a9-d6b8-40a8-ac94-71dba5faf106",
        "tax_category_id": "451ee9ca-b0bd-45e1-8ccd-4afd4b61db25",
        "planning_id": "24326589-1ff2-4480-bc0a-84c295ad700b",
        "parent_line_id": null,
        "owner_id": "62484734-f90a-4cc6-8347-47c42fa17240",
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
      "id": "541dc0a2-15ee-4944-af0a-94cee6cd5c4c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T19:02:33+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
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
        "item_id": "0e6c4c5c-318a-4714-9971-ca67e70c25c9",
        "tax_category_id": "451ee9ca-b0bd-45e1-8ccd-4afd4b61db25",
        "planning_id": "f923427a-1511-4e54-a0af-42c7bef58850",
        "parent_line_id": null,
        "owner_id": "62484734-f90a-4cc6-8347-47c42fa17240",
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
      "id": "24326589-1ff2-4480-bc0a-84c295ad700b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:32+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
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
        "item_id": "0844a8a9-d6b8-40a8-ac94-71dba5faf106",
        "order_id": "62484734-f90a-4cc6-8347-47c42fa17240",
        "start_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467",
        "stop_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467",
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
      "id": "f923427a-1511-4e54-a0af-42c7bef58850",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:33+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
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
        "item_id": "0e6c4c5c-318a-4714-9971-ca67e70c25c9",
        "order_id": "62484734-f90a-4cc6-8347-47c42fa17240",
        "start_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467",
        "stop_location_id": "2e498a52-8509-486d-93b1-69b94cd9b467",
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
      "id": "3c11d044-7589-4126-80df-2899e3bf2d10",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:33+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b0bb7f88-03f8-4658-959e-42b0b49702b2",
        "planning_id": "f923427a-1511-4e54-a0af-42c7bef58850",
        "order_id": "62484734-f90a-4cc6-8347-47c42fa17240"
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
      "id": "7b301bcb-4603-4cea-95f2-1ddc9209faed",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:33+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c333e770-d5b9-4672-b9c0-8a0ead934ded",
        "planning_id": "f923427a-1511-4e54-a0af-42c7bef58850",
        "order_id": "62484734-f90a-4cc6-8347-47c42fa17240"
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
      "id": "bbc67920-6b0a-4207-9ce8-5e647f803342",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:33+00:00",
        "updated_at": "2022-06-23T19:02:33+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3e396f32-4c49-42f5-87d6-f269a1ca8eb2",
        "planning_id": "f923427a-1511-4e54-a0af-42c7bef58850",
        "order_id": "62484734-f90a-4cc6-8347-47c42fa17240"
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
          "order_id": "1ad9eb01-96d9-4eb9-87a1-378d20102274",
          "items": [
            {
              "type": "bundles",
              "id": "60ac4cb9-657e-4f56-b7ed-1c2b3198742e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a8400342-9e84-4512-9417-7a4cafc08c83",
                  "id": "f112632d-883f-4e19-b226-9d324e106207"
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
    "id": "2e7521ab-e5bc-538d-815f-e54559bdcfa2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1ad9eb01-96d9-4eb9-87a1-378d20102274"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1ad9eb01-96d9-4eb9-87a1-378d20102274"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dd69ab57-d6de-4b66-9b5a-64fd3e846407"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "64e5f01e-68bf-46e3-9abc-24a0be3e8809"
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
      "id": "1ad9eb01-96d9-4eb9-87a1-378d20102274",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-23T19:02:36+00:00",
        "updated_at": "2022-06-23T19:02:37+00:00",
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
        "starts_at": "2022-06-21T19:00:00+00:00",
        "stops_at": "2022-06-25T19:00:00+00:00",
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
        "start_location_id": "41ea1b1e-5b9f-495d-957b-f2bdd91db3f1",
        "stop_location_id": "41ea1b1e-5b9f-495d-957b-f2bdd91db3f1"
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
      "id": "dd69ab57-d6de-4b66-9b5a-64fd3e846407",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-23T19:02:36+00:00",
        "updated_at": "2022-06-23T19:02:36+00:00",
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
        "item_id": "60ac4cb9-657e-4f56-b7ed-1c2b3198742e",
        "tax_category_id": null,
        "planning_id": "64e5f01e-68bf-46e3-9abc-24a0be3e8809",
        "parent_line_id": null,
        "owner_id": "1ad9eb01-96d9-4eb9-87a1-378d20102274",
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
      "id": "64e5f01e-68bf-46e3-9abc-24a0be3e8809",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-23T19:02:36+00:00",
        "updated_at": "2022-06-23T19:02:36+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-21T19:00:00+00:00",
        "stops_at": "2022-06-25T19:00:00+00:00",
        "reserved_from": "2022-06-21T19:00:00+00:00",
        "reserved_till": "2022-06-25T19:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "60ac4cb9-657e-4f56-b7ed-1c2b3198742e",
        "order_id": "1ad9eb01-96d9-4eb9-87a1-378d20102274",
        "start_location_id": "41ea1b1e-5b9f-495d-957b-f2bdd91db3f1",
        "stop_location_id": "41ea1b1e-5b9f-495d-957b-f2bdd91db3f1",
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





