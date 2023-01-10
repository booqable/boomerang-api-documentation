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
          "order_id": "c17142c7-b744-4066-b10d-8bfe4379ceda",
          "items": [
            {
              "type": "products",
              "id": "d8b7c7ad-0b44-42f7-8341-332de1e08ed7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7b477beb-34ac-4c0e-b98d-9165ba4d8c0d",
              "stock_item_ids": [
                "bcb02f3c-a7e5-4cc7-8461-98595f15b7b8",
                "b7bf7c7c-6679-45e7-8fcb-4a24e1fa4db5"
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
            "item_id": "d8b7c7ad-0b44-42f7-8341-332de1e08ed7",
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
          "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
          "items": [
            {
              "type": "products",
              "id": "f7ae6a0c-c50b-4a4a-9a4e-c827aaa37404",
              "stock_item_ids": [
                "7f590653-7b4e-41aa-baf8-2d04f6094261",
                "a82aef5d-f682-4de3-8472-5e57b1a31cd2",
                "19ec60a6-6a5b-4733-801c-426d05d940d8"
              ]
            },
            {
              "type": "products",
              "id": "f27fde3a-7cce-4dad-a6f1-2f151ffe87a1",
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
    "id": "8537f1cd-6a0d-5fb4-a28f-080b9d75c57a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0a2bc5b2-35aa-4d9f-af4a-1ddb9ad9dc41"
          },
          {
            "type": "lines",
            "id": "37ac5edd-966e-4c90-94da-75f0a1cbf8d3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9"
          },
          {
            "type": "plannings",
            "id": "09ec44ea-9074-4fc4-9069-d553c98e6da2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "02bf7bf7-0ea6-4aea-80d5-3bd3c96a0e62"
          },
          {
            "type": "stock_item_plannings",
            "id": "a6307063-e851-495f-94b1-cbf5a7e1f6b4"
          },
          {
            "type": "stock_item_plannings",
            "id": "b465d654-ae14-4809-96a0-c170fa696a48"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-10T14:07:21+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
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
        "customer_id": "44de7487-4fe5-404c-9f15-cf841972a8ad",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0",
        "stop_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0"
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
      "id": "0a2bc5b2-35aa-4d9f-af4a-1ddb9ad9dc41",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
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
        "item_id": "f7ae6a0c-c50b-4a4a-9a4e-c827aaa37404",
        "tax_category_id": "c71507a9-1fd1-4689-9903-de02744b21d8",
        "planning_id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9",
        "parent_line_id": null,
        "owner_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
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
      "id": "37ac5edd-966e-4c90-94da-75f0a1cbf8d3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
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
        "item_id": "f27fde3a-7cce-4dad-a6f1-2f151ffe87a1",
        "tax_category_id": "c71507a9-1fd1-4689-9903-de02744b21d8",
        "planning_id": "09ec44ea-9074-4fc4-9069-d553c98e6da2",
        "parent_line_id": null,
        "owner_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
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
      "id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
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
        "item_id": "f7ae6a0c-c50b-4a4a-9a4e-c827aaa37404",
        "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
        "start_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0",
        "stop_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0",
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
      "id": "09ec44ea-9074-4fc4-9069-d553c98e6da2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
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
        "item_id": "f27fde3a-7cce-4dad-a6f1-2f151ffe87a1",
        "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780",
        "start_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0",
        "stop_location_id": "aac12d19-5584-46cc-85a1-6ab34ec375f0",
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
      "id": "02bf7bf7-0ea6-4aea-80d5-3bd3c96a0e62",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7f590653-7b4e-41aa-baf8-2d04f6094261",
        "planning_id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9",
        "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780"
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
      "id": "a6307063-e851-495f-94b1-cbf5a7e1f6b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a82aef5d-f682-4de3-8472-5e57b1a31cd2",
        "planning_id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9",
        "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780"
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
      "id": "b465d654-ae14-4809-96a0-c170fa696a48",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:23+00:00",
        "updated_at": "2023-01-10T14:07:23+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "19ec60a6-6a5b-4733-801c-426d05d940d8",
        "planning_id": "3eb49bbf-c714-41aa-b8f2-269f58c00dc9",
        "order_id": "11f4eb7f-96ae-485e-8c21-4ab38bb7d780"
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
          "order_id": "d646c725-59c4-4b4e-a174-4876963aaa9b",
          "items": [
            {
              "type": "bundles",
              "id": "7ddf3d1f-4e4b-4dcc-a70a-409da62db563",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5e55d4c0-7337-4ab2-b77c-06178cd13946",
                  "id": "4c9a9fb7-f049-414f-b81e-b5433b0408ec"
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
    "id": "96214ef0-14aa-5a87-8e1e-f6707d931bec",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d646c725-59c4-4b4e-a174-4876963aaa9b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d646c725-59c4-4b4e-a174-4876963aaa9b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e10fd2e-a7b0-4503-b4fe-bc11fb7089eb"
          },
          {
            "type": "lines",
            "id": "27176af9-4d93-4380-8f58-84a1e425ab9b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a7d9f89c-0331-4838-b2c6-6f33c2ae8f86"
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
      "id": "d646c725-59c4-4b4e-a174-4876963aaa9b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-10T14:07:25+00:00",
        "updated_at": "2023-01-10T14:07:26+00:00",
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
        "starts_at": "2023-01-08T14:00:00+00:00",
        "stops_at": "2023-01-12T14:00:00+00:00",
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
        "start_location_id": "432fe64b-b0bf-4daa-9110-3d43acfef247",
        "stop_location_id": "432fe64b-b0bf-4daa-9110-3d43acfef247"
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
      "id": "5e10fd2e-a7b0-4503-b4fe-bc11fb7089eb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-10T14:07:26+00:00",
        "updated_at": "2023-01-10T14:07:26+00:00",
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
        "item_id": "7ddf3d1f-4e4b-4dcc-a70a-409da62db563",
        "tax_category_id": null,
        "planning_id": "a7d9f89c-0331-4838-b2c6-6f33c2ae8f86",
        "parent_line_id": null,
        "owner_id": "d646c725-59c4-4b4e-a174-4876963aaa9b",
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
      "id": "27176af9-4d93-4380-8f58-84a1e425ab9b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-10T14:07:26+00:00",
        "updated_at": "2023-01-10T14:07:26+00:00",
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
        "item_id": "4c9a9fb7-f049-414f-b81e-b5433b0408ec",
        "tax_category_id": null,
        "planning_id": "f3d904bf-2167-4486-97fe-84f6a39c37f5",
        "parent_line_id": "5e10fd2e-a7b0-4503-b4fe-bc11fb7089eb",
        "owner_id": "d646c725-59c4-4b4e-a174-4876963aaa9b",
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
      "id": "a7d9f89c-0331-4838-b2c6-6f33c2ae8f86",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-10T14:07:26+00:00",
        "updated_at": "2023-01-10T14:07:26+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-08T14:00:00+00:00",
        "stops_at": "2023-01-12T14:00:00+00:00",
        "reserved_from": "2023-01-08T14:00:00+00:00",
        "reserved_till": "2023-01-12T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7ddf3d1f-4e4b-4dcc-a70a-409da62db563",
        "order_id": "d646c725-59c4-4b4e-a174-4876963aaa9b",
        "start_location_id": "432fe64b-b0bf-4daa-9110-3d43acfef247",
        "stop_location_id": "432fe64b-b0bf-4daa-9110-3d43acfef247",
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





