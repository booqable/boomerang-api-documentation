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
          "order_id": "7173573d-1bd8-4bba-9774-5ed064f7b5a7",
          "items": [
            {
              "type": "products",
              "id": "1d400929-3ac3-4c76-ace1-4b863f5d0cac",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5f2cad52-77c2-4497-a165-1612d5932658",
              "stock_item_ids": [
                "602c371f-657f-4478-87db-5ac448b4b2c5",
                "d46c73db-625c-455f-aa48-a009c33896f7"
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
            "item_id": "1d400929-3ac3-4c76-ace1-4b863f5d0cac",
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
          "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
          "items": [
            {
              "type": "products",
              "id": "5c4e7c31-083b-4ade-b48d-26b279944c1a",
              "stock_item_ids": [
                "422c087b-8e45-4fd5-9f57-4a1c23d8d07b",
                "c912c9e8-8f31-4200-9328-1c9fe4a1c17d",
                "916ef34f-fa7a-4c77-baa8-a5c006dbace1"
              ]
            },
            {
              "type": "products",
              "id": "222bae88-f2bb-49ea-894c-913f2c53d18a",
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
    "id": "0e4c19bb-cf61-569a-8102-a910f19801bb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "83451b3c-f449-43b1-9ebd-9ad349db0f06"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "86413cbf-bb9b-4c8c-8134-8ea6f0ef0fd3"
          },
          {
            "type": "lines",
            "id": "5c8fa286-0c40-4e3a-bf5b-a47c0aad96bc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "66b9e338-ce92-45a4-b947-60f82c7a7216"
          },
          {
            "type": "plannings",
            "id": "f5c4e22b-308e-45b8-af54-e251cecb878e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "5cff2c9f-6270-4734-bb73-2eda883b2005"
          },
          {
            "type": "stock_item_plannings",
            "id": "601a0357-dbe1-4551-a117-9e9b07c3e7aa"
          },
          {
            "type": "stock_item_plannings",
            "id": "366d58fe-346d-4dae-a1fe-52b52aeeaecc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-04T15:24:38+00:00",
        "updated_at": "2022-11-04T15:24:40+00:00",
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
        "customer_id": "8ddbd2b7-dfa1-4658-8b45-75a4408fdfba",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "20802790-3443-4e84-905f-d01538c98977",
        "stop_location_id": "20802790-3443-4e84-905f-d01538c98977"
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
      "id": "86413cbf-bb9b-4c8c-8134-8ea6f0ef0fd3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:40+00:00",
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
        "item_id": "5c4e7c31-083b-4ade-b48d-26b279944c1a",
        "tax_category_id": "820a9825-265a-4f18-ad22-5496016d1190",
        "planning_id": "66b9e338-ce92-45a4-b947-60f82c7a7216",
        "parent_line_id": null,
        "owner_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
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
      "id": "5c8fa286-0c40-4e3a-bf5b-a47c0aad96bc",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:40+00:00",
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
        "item_id": "222bae88-f2bb-49ea-894c-913f2c53d18a",
        "tax_category_id": "820a9825-265a-4f18-ad22-5496016d1190",
        "planning_id": "f5c4e22b-308e-45b8-af54-e251cecb878e",
        "parent_line_id": null,
        "owner_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
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
      "id": "66b9e338-ce92-45a4-b947-60f82c7a7216",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:40+00:00",
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
        "item_id": "5c4e7c31-083b-4ade-b48d-26b279944c1a",
        "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
        "start_location_id": "20802790-3443-4e84-905f-d01538c98977",
        "stop_location_id": "20802790-3443-4e84-905f-d01538c98977",
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
      "id": "f5c4e22b-308e-45b8-af54-e251cecb878e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:40+00:00",
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
        "item_id": "222bae88-f2bb-49ea-894c-913f2c53d18a",
        "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06",
        "start_location_id": "20802790-3443-4e84-905f-d01538c98977",
        "stop_location_id": "20802790-3443-4e84-905f-d01538c98977",
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
      "id": "5cff2c9f-6270-4734-bb73-2eda883b2005",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "422c087b-8e45-4fd5-9f57-4a1c23d8d07b",
        "planning_id": "66b9e338-ce92-45a4-b947-60f82c7a7216",
        "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06"
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
      "id": "601a0357-dbe1-4551-a117-9e9b07c3e7aa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c912c9e8-8f31-4200-9328-1c9fe4a1c17d",
        "planning_id": "66b9e338-ce92-45a4-b947-60f82c7a7216",
        "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06"
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
      "id": "366d58fe-346d-4dae-a1fe-52b52aeeaecc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:39+00:00",
        "updated_at": "2022-11-04T15:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "916ef34f-fa7a-4c77-baa8-a5c006dbace1",
        "planning_id": "66b9e338-ce92-45a4-b947-60f82c7a7216",
        "order_id": "83451b3c-f449-43b1-9ebd-9ad349db0f06"
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
          "order_id": "cf11130a-c1ef-4d68-80b4-28245c7502c6",
          "items": [
            {
              "type": "bundles",
              "id": "29c828fd-6e3e-4575-a04c-87b6374a867e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "36d1629c-6757-4d22-990f-6b81b4f16d55",
                  "id": "06189672-0cbc-4818-8636-a45ffb62d820"
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
    "id": "39169a4d-e6c4-5bb8-add1-879769062cb4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cf11130a-c1ef-4d68-80b4-28245c7502c6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cf11130a-c1ef-4d68-80b4-28245c7502c6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e3f7359a-1bc5-4698-a282-d5b61a9d9419"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fcfacd6a-7d04-4b4c-9695-ca839a562999"
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
      "id": "cf11130a-c1ef-4d68-80b4-28245c7502c6",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-04T15:24:42+00:00",
        "updated_at": "2022-11-04T15:24:42+00:00",
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
        "starts_at": "2022-11-02T15:15:00+00:00",
        "stops_at": "2022-11-06T15:15:00+00:00",
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
        "start_location_id": "9e3e90f0-440c-4860-b35c-886974bda4d3",
        "stop_location_id": "9e3e90f0-440c-4860-b35c-886974bda4d3"
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
      "id": "e3f7359a-1bc5-4698-a282-d5b61a9d9419",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:24:42+00:00",
        "updated_at": "2022-11-04T15:24:42+00:00",
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
        "item_id": "29c828fd-6e3e-4575-a04c-87b6374a867e",
        "tax_category_id": null,
        "planning_id": "fcfacd6a-7d04-4b4c-9695-ca839a562999",
        "parent_line_id": null,
        "owner_id": "cf11130a-c1ef-4d68-80b4-28245c7502c6",
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
      "id": "fcfacd6a-7d04-4b4c-9695-ca839a562999",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:24:42+00:00",
        "updated_at": "2022-11-04T15:24:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-02T15:15:00+00:00",
        "stops_at": "2022-11-06T15:15:00+00:00",
        "reserved_from": "2022-11-02T15:15:00+00:00",
        "reserved_till": "2022-11-06T15:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "29c828fd-6e3e-4575-a04c-87b6374a867e",
        "order_id": "cf11130a-c1ef-4d68-80b4-28245c7502c6",
        "start_location_id": "9e3e90f0-440c-4860-b35c-886974bda4d3",
        "stop_location_id": "9e3e90f0-440c-4860-b35c-886974bda4d3",
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





