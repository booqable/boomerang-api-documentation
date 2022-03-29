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
          "order_id": "b4ab4e8c-c837-4357-8070-6a6f7a7050b5",
          "items": [
            {
              "type": "products",
              "id": "1aed6610-8332-4432-91d3-90dbc88567d3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "63e069c1-0490-40f8-9d70-2c0a5f76b53b",
              "stock_item_ids": [
                "854bc9d5-3ed9-489e-9b8c-a748ee68f496",
                "af804fea-e866-4bc8-a80b-ad07944982fb"
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
            "item_id": "1aed6610-8332-4432-91d3-90dbc88567d3",
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
          "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
          "items": [
            {
              "type": "products",
              "id": "573995dd-2876-45f4-8816-2c5890bc79ce",
              "stock_item_ids": [
                "cce1e6e8-0ca4-40b8-bbb8-740f01eef030",
                "958dcce4-346f-4fcf-875f-757024094b73",
                "fc436fb7-94b5-428a-8585-45523c247c82"
              ]
            },
            {
              "type": "products",
              "id": "da3098f9-46aa-4516-8a51-f5ccc6853850",
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
    "id": "c6b85163-6c1a-5770-bf02-927180836123",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4fde3183-0f15-4f8a-88ce-3d80016dff16"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e2c114fc-e8e8-4ce7-b350-5f1b7fdd37e3"
          },
          {
            "type": "lines",
            "id": "582b3521-8ed5-460a-86d6-5b436bd9bf62"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3fbc7604-6965-46da-9d39-ecdfda18b430"
          },
          {
            "type": "plannings",
            "id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "06ec85ca-ea2a-4330-8134-efec811b0dd7"
          },
          {
            "type": "stock_item_plannings",
            "id": "aa727519-1592-435f-9c3d-ee485884d296"
          },
          {
            "type": "stock_item_plannings",
            "id": "910bd0bf-34bb-44ce-9d58-dab8e52205d3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-29T09:20:52+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
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
        "customer_id": "2720f515-3091-43c2-ad0f-54f0c8868513",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15",
        "stop_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15"
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
      "id": "e2c114fc-e8e8-4ce7-b350-5f1b7fdd37e3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-29T09:20:53+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
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
        "item_id": "da3098f9-46aa-4516-8a51-f5ccc6853850",
        "tax_category_id": "b331978f-7223-469e-b2e7-a9e274e8dc79",
        "planning_id": "3fbc7604-6965-46da-9d39-ecdfda18b430",
        "parent_line_id": null,
        "owner_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
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
      "id": "582b3521-8ed5-460a-86d6-5b436bd9bf62",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-29T09:20:54+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
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
        "item_id": "573995dd-2876-45f4-8816-2c5890bc79ce",
        "tax_category_id": "b331978f-7223-469e-b2e7-a9e274e8dc79",
        "planning_id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5",
        "parent_line_id": null,
        "owner_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
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
      "id": "3fbc7604-6965-46da-9d39-ecdfda18b430",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:53+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
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
        "item_id": "da3098f9-46aa-4516-8a51-f5ccc6853850",
        "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
        "start_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15",
        "stop_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15",
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
      "id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:54+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
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
        "item_id": "573995dd-2876-45f4-8816-2c5890bc79ce",
        "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16",
        "start_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15",
        "stop_location_id": "a6a60b78-c28a-47e5-8bda-18999f171b15",
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
      "id": "06ec85ca-ea2a-4330-8134-efec811b0dd7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:54+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cce1e6e8-0ca4-40b8-bbb8-740f01eef030",
        "planning_id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5",
        "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16"
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
      "id": "aa727519-1592-435f-9c3d-ee485884d296",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:54+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "958dcce4-346f-4fcf-875f-757024094b73",
        "planning_id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5",
        "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16"
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
      "id": "910bd0bf-34bb-44ce-9d58-dab8e52205d3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:54+00:00",
        "updated_at": "2022-03-29T09:20:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fc436fb7-94b5-428a-8585-45523c247c82",
        "planning_id": "2d1035e4-78d6-4424-bf56-fdc0bcee69c5",
        "order_id": "4fde3183-0f15-4f8a-88ce-3d80016dff16"
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
          "order_id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2",
          "items": [
            {
              "type": "bundles",
              "id": "27172c49-f817-4368-a97d-70f55ae186d7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "24cdd035-0f76-4177-898d-f1f8b56c7b8a",
                  "id": "c2ee35fe-e5cc-4d54-9e05-3184d4a4f3a3"
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
    "id": "fa9e9c1b-ce97-5bb9-a7f4-634191780fd8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ad0d583a-36c9-47ea-b18d-48434125e51e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f2b78cc0-be25-44b5-ae42-1e73b147cca2"
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
      "id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-29T09:20:56+00:00",
        "updated_at": "2022-03-29T09:20:57+00:00",
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
        "starts_at": "2022-03-27T09:15:00+00:00",
        "stops_at": "2022-03-31T09:15:00+00:00",
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
        "start_location_id": "659b298a-e677-4852-9e3a-11eb3ac1beb7",
        "stop_location_id": "659b298a-e677-4852-9e3a-11eb3ac1beb7"
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
      "id": "ad0d583a-36c9-47ea-b18d-48434125e51e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-29T09:20:57+00:00",
        "updated_at": "2022-03-29T09:20:57+00:00",
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
        "item_id": "27172c49-f817-4368-a97d-70f55ae186d7",
        "tax_category_id": null,
        "planning_id": "f2b78cc0-be25-44b5-ae42-1e73b147cca2",
        "parent_line_id": null,
        "owner_id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2",
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
      "id": "f2b78cc0-be25-44b5-ae42-1e73b147cca2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-29T09:20:57+00:00",
        "updated_at": "2022-03-29T09:20:57+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-27T09:15:00+00:00",
        "stops_at": "2022-03-31T09:15:00+00:00",
        "reserved_from": "2022-03-27T09:15:00+00:00",
        "reserved_till": "2022-03-31T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "27172c49-f817-4368-a97d-70f55ae186d7",
        "order_id": "ec21e438-4ff9-486f-ba35-a87ea540c8f2",
        "start_location_id": "659b298a-e677-4852-9e3a-11eb3ac1beb7",
        "stop_location_id": "659b298a-e677-4852-9e3a-11eb3ac1beb7",
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





