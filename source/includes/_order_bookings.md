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
          "order_id": "4ec4525b-0337-4262-9eef-d595d58938cc",
          "items": [
            {
              "type": "products",
              "id": "bd8d6ade-964a-4bda-82d7-a96d65cdd19c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "761d1411-7910-43dc-8bc1-1c93d7599730",
              "stock_item_ids": [
                "5239b7a2-8358-4dd4-be03-83f478b94ffc",
                "0d17238a-cbb4-4fdc-a0f0-0d04fe77a40c"
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
            "item_id": "bd8d6ade-964a-4bda-82d7-a96d65cdd19c",
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
          "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
          "items": [
            {
              "type": "products",
              "id": "6e89d3c4-bccb-42c5-b007-f42e645898d9",
              "stock_item_ids": [
                "5b2c4f45-5ef9-4502-a5b4-79d73b9caa73",
                "b6b7cfba-0c4a-4822-96e4-51301142428c",
                "75296ba2-659f-40a3-8cd3-95d2605e7d98"
              ]
            },
            {
              "type": "products",
              "id": "7125936a-9f86-4807-840a-37bc6905d38f",
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
    "id": "a4adda02-6d55-56e1-a830-0e7d388e7e5d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "960e6a1f-a509-49b7-b436-655429f62400"
          },
          {
            "type": "lines",
            "id": "1e764a0b-cc11-4e2b-b2f3-b8fdd43e59c1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6438b700-b78a-44c7-837f-4e4eec5fea16"
          },
          {
            "type": "plannings",
            "id": "67020b48-463c-4ac3-96e4-b0ca4aa2667c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f9e70a71-82fe-4b7c-989d-f0f82f09a105"
          },
          {
            "type": "stock_item_plannings",
            "id": "ad569417-4d42-473c-8605-c5e2e4575efa"
          },
          {
            "type": "stock_item_plannings",
            "id": "b1d91dc6-5b10-4383-bfbd-8bf4de6a7eda"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:05:48+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
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
        "customer_id": "95c9c0cd-14b2-4707-8132-ce60fc445b56",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6",
        "stop_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6"
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
      "id": "960e6a1f-a509-49b7-b436-655429f62400",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:50+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
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
        "item_id": "6e89d3c4-bccb-42c5-b007-f42e645898d9",
        "tax_category_id": "ad24f8cb-6111-4e0e-b395-d94572c25df4",
        "planning_id": "6438b700-b78a-44c7-837f-4e4eec5fea16",
        "parent_line_id": null,
        "owner_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
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
      "id": "1e764a0b-cc11-4e2b-b2f3-b8fdd43e59c1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:50+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
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
        "item_id": "7125936a-9f86-4807-840a-37bc6905d38f",
        "tax_category_id": "ad24f8cb-6111-4e0e-b395-d94572c25df4",
        "planning_id": "67020b48-463c-4ac3-96e4-b0ca4aa2667c",
        "parent_line_id": null,
        "owner_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
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
      "id": "6438b700-b78a-44c7-837f-4e4eec5fea16",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:49+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
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
        "item_id": "6e89d3c4-bccb-42c5-b007-f42e645898d9",
        "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
        "start_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6",
        "stop_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6",
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
      "id": "67020b48-463c-4ac3-96e4-b0ca4aa2667c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:49+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
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
        "item_id": "7125936a-9f86-4807-840a-37bc6905d38f",
        "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e",
        "start_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6",
        "stop_location_id": "434154bf-a8e2-400c-94d6-7d528a36a1a6",
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
      "id": "f9e70a71-82fe-4b7c-989d-f0f82f09a105",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:49+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5b2c4f45-5ef9-4502-a5b4-79d73b9caa73",
        "planning_id": "6438b700-b78a-44c7-837f-4e4eec5fea16",
        "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e"
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
      "id": "ad569417-4d42-473c-8605-c5e2e4575efa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:49+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b6b7cfba-0c4a-4822-96e4-51301142428c",
        "planning_id": "6438b700-b78a-44c7-837f-4e4eec5fea16",
        "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e"
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
      "id": "b1d91dc6-5b10-4383-bfbd-8bf4de6a7eda",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:49+00:00",
        "updated_at": "2023-02-14T11:05:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "75296ba2-659f-40a3-8cd3-95d2605e7d98",
        "planning_id": "6438b700-b78a-44c7-837f-4e4eec5fea16",
        "order_id": "4f762e4a-cc91-4388-a3a1-b85e3df2976e"
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
          "order_id": "342db6a9-c893-4b04-9477-1910b207ebc6",
          "items": [
            {
              "type": "bundles",
              "id": "7883436e-6f55-4044-bc3f-aabd4264c6a7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2ba0b221-d784-4890-a2bf-ff7323952c59",
                  "id": "9269d4b4-a552-42c3-a209-0eb735661716"
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
    "id": "76b17e54-76bf-526d-8f17-f138c03b038e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "342db6a9-c893-4b04-9477-1910b207ebc6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "342db6a9-c893-4b04-9477-1910b207ebc6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3007bb74-33a2-4fc2-8677-b9586c7ead78"
          },
          {
            "type": "lines",
            "id": "a0aa4e48-216c-4324-8076-f9013af3e2da"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e0c892d1-5900-43a2-ad90-0bbe30837425"
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
      "id": "342db6a9-c893-4b04-9477-1910b207ebc6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T11:05:52+00:00",
        "updated_at": "2023-02-14T11:05:53+00:00",
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
        "start_location_id": "39f4c132-4981-448f-98e4-06996c1aed1d",
        "stop_location_id": "39f4c132-4981-448f-98e4-06996c1aed1d"
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
      "id": "3007bb74-33a2-4fc2-8677-b9586c7ead78",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:53+00:00",
        "updated_at": "2023-02-14T11:05:53+00:00",
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
        "item_id": "9269d4b4-a552-42c3-a209-0eb735661716",
        "tax_category_id": null,
        "planning_id": "2b98adef-a13e-4d96-8be6-89930a429569",
        "parent_line_id": "a0aa4e48-216c-4324-8076-f9013af3e2da",
        "owner_id": "342db6a9-c893-4b04-9477-1910b207ebc6",
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
      "id": "a0aa4e48-216c-4324-8076-f9013af3e2da",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T11:05:53+00:00",
        "updated_at": "2023-02-14T11:05:53+00:00",
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
        "item_id": "7883436e-6f55-4044-bc3f-aabd4264c6a7",
        "tax_category_id": null,
        "planning_id": "e0c892d1-5900-43a2-ad90-0bbe30837425",
        "parent_line_id": null,
        "owner_id": "342db6a9-c893-4b04-9477-1910b207ebc6",
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
      "id": "e0c892d1-5900-43a2-ad90-0bbe30837425",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T11:05:53+00:00",
        "updated_at": "2023-02-14T11:05:53+00:00",
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
        "item_id": "7883436e-6f55-4044-bc3f-aabd4264c6a7",
        "order_id": "342db6a9-c893-4b04-9477-1910b207ebc6",
        "start_location_id": "39f4c132-4981-448f-98e4-06996c1aed1d",
        "stop_location_id": "39f4c132-4981-448f-98e4-06996c1aed1d",
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





