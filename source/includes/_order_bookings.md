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
          "order_id": "267f9d74-40b0-4680-8266-3a9b31148430",
          "items": [
            {
              "type": "products",
              "id": "08d8e1dc-85a4-4069-87dd-ff00d51646c3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "adbd9ec2-3f22-4ae8-9da9-2918086f9649",
              "stock_item_ids": [
                "ae06de74-5b1b-49f9-a5f4-e506b00bb797",
                "0d179f5d-7717-4cf0-aba6-84318a3e201d"
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
            "item_id": "08d8e1dc-85a4-4069-87dd-ff00d51646c3",
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
          "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
          "items": [
            {
              "type": "products",
              "id": "03012183-4d03-4269-9b51-9c80144911ed",
              "stock_item_ids": [
                "f978ff45-7e0f-45f4-9e91-a58321eb94f5",
                "f47b7823-67ff-4890-a1c5-a4809e5ca208",
                "5d5cb659-02fc-49f7-8735-6818dde1c4ae"
              ]
            },
            {
              "type": "products",
              "id": "fc47aa3a-7164-4ebf-9616-2811257594d9",
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
    "id": "0f767cac-d9a2-5815-8af5-bf503a67335c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "843cf23d-b227-43f1-a1e2-5bdd26f811e9"
          },
          {
            "type": "lines",
            "id": "01add6b7-628f-49f5-962c-5ff42712e0ff"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b260494e-7c68-40e5-9d20-a8c8e99435e2"
          },
          {
            "type": "plannings",
            "id": "e4a67eed-4938-45f1-8793-b36b153b07a4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3f0bd6e7-b9e5-47c2-ae17-3694d4c3c9f3"
          },
          {
            "type": "stock_item_plannings",
            "id": "b85b3282-c31a-4fe4-9c05-352908a4d327"
          },
          {
            "type": "stock_item_plannings",
            "id": "2ca88e01-368a-4220-8ec1-aacbef529eb5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-17T10:03:41+00:00",
        "updated_at": "2022-03-17T10:03:43+00:00",
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
        "customer_id": "0a0ac31a-ed24-4f4e-986c-f60dbcd737c0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183",
        "stop_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183"
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
      "id": "843cf23d-b227-43f1-a1e2-5bdd26f811e9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:42+00:00",
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
        "item_id": "fc47aa3a-7164-4ebf-9616-2811257594d9",
        "tax_category_id": "b24e0de6-e413-4718-9f65-40fe45170600",
        "planning_id": "b260494e-7c68-40e5-9d20-a8c8e99435e2",
        "parent_line_id": null,
        "owner_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
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
      "id": "01add6b7-628f-49f5-962c-5ff42712e0ff",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:42+00:00",
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
        "item_id": "03012183-4d03-4269-9b51-9c80144911ed",
        "tax_category_id": "b24e0de6-e413-4718-9f65-40fe45170600",
        "planning_id": "e4a67eed-4938-45f1-8793-b36b153b07a4",
        "parent_line_id": null,
        "owner_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
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
      "id": "b260494e-7c68-40e5-9d20-a8c8e99435e2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:41+00:00",
        "updated_at": "2022-03-17T10:03:43+00:00",
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
        "item_id": "fc47aa3a-7164-4ebf-9616-2811257594d9",
        "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
        "start_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183",
        "stop_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183",
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
      "id": "e4a67eed-4938-45f1-8793-b36b153b07a4",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:43+00:00",
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
        "item_id": "03012183-4d03-4269-9b51-9c80144911ed",
        "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba",
        "start_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183",
        "stop_location_id": "7d5bc9a9-232c-4fac-af1e-c0657940a183",
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
      "id": "3f0bd6e7-b9e5-47c2-ae17-3694d4c3c9f3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f978ff45-7e0f-45f4-9e91-a58321eb94f5",
        "planning_id": "e4a67eed-4938-45f1-8793-b36b153b07a4",
        "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba"
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
      "id": "b85b3282-c31a-4fe4-9c05-352908a4d327",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f47b7823-67ff-4890-a1c5-a4809e5ca208",
        "planning_id": "e4a67eed-4938-45f1-8793-b36b153b07a4",
        "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba"
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
      "id": "2ca88e01-368a-4220-8ec1-aacbef529eb5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:42+00:00",
        "updated_at": "2022-03-17T10:03:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5d5cb659-02fc-49f7-8735-6818dde1c4ae",
        "planning_id": "e4a67eed-4938-45f1-8793-b36b153b07a4",
        "order_id": "fb0a2fa4-44e5-47c5-a51f-b2e48315a5ba"
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
          "order_id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627",
          "items": [
            {
              "type": "bundles",
              "id": "a05a4a95-aaa3-4cfd-b948-47d3161a16d0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "188ed4c0-9236-4049-b63b-3cdae276b128",
                  "id": "d79a54e8-a39b-4fe2-ad8e-18fde3e3563d"
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
    "id": "ae6643d8-2d01-550a-a3a9-9e331c4a1a32",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "36f25d89-24de-481a-97de-98b1e5ca5b70"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "00ac8db9-ee22-461b-b3f2-1ff4d2fa1d74"
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
      "id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-17T10:03:45+00:00",
        "updated_at": "2022-03-17T10:03:47+00:00",
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
        "starts_at": "2022-03-15T10:00:00+00:00",
        "stops_at": "2022-03-19T10:00:00+00:00",
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
        "start_location_id": "e8775592-c417-444c-a08e-6d9aaa8c507d",
        "stop_location_id": "e8775592-c417-444c-a08e-6d9aaa8c507d"
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
      "id": "36f25d89-24de-481a-97de-98b1e5ca5b70",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-17T10:03:46+00:00",
        "updated_at": "2022-03-17T10:03:46+00:00",
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
        "item_id": "a05a4a95-aaa3-4cfd-b948-47d3161a16d0",
        "tax_category_id": null,
        "planning_id": "00ac8db9-ee22-461b-b3f2-1ff4d2fa1d74",
        "parent_line_id": null,
        "owner_id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627",
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
      "id": "00ac8db9-ee22-461b-b3f2-1ff4d2fa1d74",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-17T10:03:46+00:00",
        "updated_at": "2022-03-17T10:03:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-15T10:00:00+00:00",
        "stops_at": "2022-03-19T10:00:00+00:00",
        "reserved_from": "2022-03-15T10:00:00+00:00",
        "reserved_till": "2022-03-19T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a05a4a95-aaa3-4cfd-b948-47d3161a16d0",
        "order_id": "e82a0947-2bee-47b2-8c2b-6bedbc10b627",
        "start_location_id": "e8775592-c417-444c-a08e-6d9aaa8c507d",
        "stop_location_id": "e8775592-c417-444c-a08e-6d9aaa8c507d",
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





