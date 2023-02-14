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
          "order_id": "f0b6bd7b-c376-454b-ab86-b369118a1983",
          "items": [
            {
              "type": "products",
              "id": "ecd13f55-6a9b-41a7-a28a-2c508d824ef8",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a3e42664-f765-43f4-80bc-1e0a1c97a371",
              "stock_item_ids": [
                "8421959a-cf07-46f0-8a31-df2b417b806a",
                "972e1989-bdeb-42f4-8632-9379d0ee468f"
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
            "item_id": "ecd13f55-6a9b-41a7-a28a-2c508d824ef8",
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
          "order_id": "e137b109-bb54-4df2-90db-6536a5161096",
          "items": [
            {
              "type": "products",
              "id": "f54ec458-3092-4a95-acbd-1bb68f88bf93",
              "stock_item_ids": [
                "13545206-5d54-4f9d-b8a8-d096a2ac5b0d",
                "7996112d-e427-4ead-ab52-a0b2575e5de4",
                "6e5cacab-04a1-4e9d-8e6d-8b1c69b9780b"
              ]
            },
            {
              "type": "products",
              "id": "9dc71f47-a043-4ab2-8ada-cd123cdb9cc1",
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
    "id": "a7646b5b-e6de-586b-a053-3ca40c1942dd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e137b109-bb54-4df2-90db-6536a5161096"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e137b109-bb54-4df2-90db-6536a5161096"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6ba91ea9-1480-4bfb-b1e9-780ed02fcc19"
          },
          {
            "type": "lines",
            "id": "c7571f61-ba5a-4c2d-806e-06b34e431894"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294"
          },
          {
            "type": "plannings",
            "id": "bce62164-1f46-4ef8-85c2-31dacf9d0704"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "db07a4a0-dc86-46aa-b1c3-f614e70d92e2"
          },
          {
            "type": "stock_item_plannings",
            "id": "f54027fb-fc2c-48e6-9aea-29cd3a1755aa"
          },
          {
            "type": "stock_item_plannings",
            "id": "396f3f9b-15c3-4762-bb6c-68d703b3e787"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e137b109-bb54-4df2-90db-6536a5161096",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:07:33+00:00",
        "updated_at": "2023-02-14T11:07:35+00:00",
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
        "customer_id": "a4b0558e-c205-4539-b538-67bb3267226d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863",
        "stop_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863"
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
      "id": "6ba91ea9-1480-4bfb-b1e9-780ed02fcc19",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:35+00:00",
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
        "item_id": "f54ec458-3092-4a95-acbd-1bb68f88bf93",
        "tax_category_id": "80cd3797-67ee-4c0a-8201-ebd3e4e655bb",
        "planning_id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294",
        "parent_line_id": null,
        "owner_id": "e137b109-bb54-4df2-90db-6536a5161096",
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
      "id": "c7571f61-ba5a-4c2d-806e-06b34e431894",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:35+00:00",
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
        "item_id": "9dc71f47-a043-4ab2-8ada-cd123cdb9cc1",
        "tax_category_id": "80cd3797-67ee-4c0a-8201-ebd3e4e655bb",
        "planning_id": "bce62164-1f46-4ef8-85c2-31dacf9d0704",
        "parent_line_id": null,
        "owner_id": "e137b109-bb54-4df2-90db-6536a5161096",
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
      "id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:35+00:00",
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
        "item_id": "f54ec458-3092-4a95-acbd-1bb68f88bf93",
        "order_id": "e137b109-bb54-4df2-90db-6536a5161096",
        "start_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863",
        "stop_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863",
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
      "id": "bce62164-1f46-4ef8-85c2-31dacf9d0704",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:35+00:00",
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
        "item_id": "9dc71f47-a043-4ab2-8ada-cd123cdb9cc1",
        "order_id": "e137b109-bb54-4df2-90db-6536a5161096",
        "start_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863",
        "stop_location_id": "af70ea99-885b-4502-a283-c3ab42bb0863",
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
      "id": "db07a4a0-dc86-46aa-b1c3-f614e70d92e2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "13545206-5d54-4f9d-b8a8-d096a2ac5b0d",
        "planning_id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294",
        "order_id": "e137b109-bb54-4df2-90db-6536a5161096"
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
      "id": "f54027fb-fc2c-48e6-9aea-29cd3a1755aa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7996112d-e427-4ead-ab52-a0b2575e5de4",
        "planning_id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294",
        "order_id": "e137b109-bb54-4df2-90db-6536a5161096"
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
      "id": "396f3f9b-15c3-4762-bb6c-68d703b3e787",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:34+00:00",
        "updated_at": "2023-02-14T11:07:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6e5cacab-04a1-4e9d-8e6d-8b1c69b9780b",
        "planning_id": "c0fdfaca-b62d-4ae5-b2f7-dbc0d4340294",
        "order_id": "e137b109-bb54-4df2-90db-6536a5161096"
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
          "order_id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1",
          "items": [
            {
              "type": "bundles",
              "id": "6809efb2-0a65-43e2-83e0-870b9446a4ef",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1bf039e3-262c-4170-822a-2c334f3fc4b3",
                  "id": "efe28cb4-3724-4350-b9e2-26f58e6d08a4"
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
    "id": "73993d2b-7245-573a-8d8f-0424695ee365",
    "type": "order_bookings",
    "attributes": {
      "order_id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2422976f-b0ce-494d-a94d-19cd0b14fc39"
          },
          {
            "type": "lines",
            "id": "baab5944-6827-4609-bccd-07a440a19cee"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "51090f48-3866-4e48-979e-0c04b7b418c5"
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
      "id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:07:37+00:00",
        "updated_at": "2023-02-14T11:07:38+00:00",
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
        "starts_at": "2023-02-12T11:00:00+00:00",
        "stops_at": "2023-02-16T11:00:00+00:00",
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
        "start_location_id": "c621d04b-88da-4ee9-923b-6c838d80410d",
        "stop_location_id": "c621d04b-88da-4ee9-923b-6c838d80410d"
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
      "id": "2422976f-b0ce-494d-a94d-19cd0b14fc39",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:07:37+00:00",
        "updated_at": "2023-02-14T11:07:37+00:00",
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
        "item_id": "6809efb2-0a65-43e2-83e0-870b9446a4ef",
        "tax_category_id": null,
        "planning_id": "51090f48-3866-4e48-979e-0c04b7b418c5",
        "parent_line_id": null,
        "owner_id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1",
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
      "id": "baab5944-6827-4609-bccd-07a440a19cee",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:07:37+00:00",
        "updated_at": "2023-02-14T11:07:37+00:00",
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
        "item_id": "efe28cb4-3724-4350-b9e2-26f58e6d08a4",
        "tax_category_id": null,
        "planning_id": "846dd61f-3c5b-46af-bd31-d9fc1b4c0421",
        "parent_line_id": "2422976f-b0ce-494d-a94d-19cd0b14fc39",
        "owner_id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1",
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
      "id": "51090f48-3866-4e48-979e-0c04b7b418c5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:07:37+00:00",
        "updated_at": "2023-02-14T11:07:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-12T11:00:00+00:00",
        "stops_at": "2023-02-16T11:00:00+00:00",
        "reserved_from": "2023-02-12T11:00:00+00:00",
        "reserved_till": "2023-02-16T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6809efb2-0a65-43e2-83e0-870b9446a4ef",
        "order_id": "45a15f0d-01d9-43fd-a22d-33fec6869ab1",
        "start_location_id": "c621d04b-88da-4ee9-923b-6c838d80410d",
        "stop_location_id": "c621d04b-88da-4ee9-923b-6c838d80410d",
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





