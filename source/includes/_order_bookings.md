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
- **Lines** Individual elements on order, which in the case of order bookings contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Endpoints
`POST /api/boomerang/order_bookings`

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
          "order_id": "7bdae4d4-5935-4c62-80bb-fcac442d618a",
          "items": [
            {
              "type": "products",
              "id": "24425f10-b30e-459e-9163-4e3baa2259a5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b214427d-fb7c-4cc0-a71c-bd662fc05bf6",
              "stock_item_ids": [
                "c40284c9-5be1-4247-8c31-309f9f9b1d28",
                "329f294e-fbaa-4e37-85c2-ea3d68d3aac1"
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
            "item_id": "24425f10-b30e-459e-9163-4e3baa2259a5",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "b214427d-fb7c-4cc0-a71c-bd662fc05bf6",
            "unavailable": [
              "c40284c9-5be1-4247-8c31-309f9f9b1d28"
            ],
            "available": [
              "329f294e-fbaa-4e37-85c2-ea3d68d3aac1"
            ]
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
          "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
          "items": [
            {
              "type": "products",
              "id": "6ca08e7c-036d-408c-b3aa-d134cd4a1917",
              "stock_item_ids": [
                "9878e19e-f4db-4c0d-807e-b29720ff7d32",
                "5604bff5-05d5-4bdd-8e2f-484372545179",
                "37733b47-0800-48a2-9c55-68551724c2c9"
              ]
            },
            {
              "type": "products",
              "id": "99003961-d7b8-41c2-bf3b-b7a2df54b382",
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
    "id": "49b84984-8ba7-54a6-817f-a99501ddd667",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "410e25e3-ff84-40b3-a9ba-7bdd45afb94e"
          },
          {
            "type": "lines",
            "id": "c94b5253-215a-4d15-9fdd-2e86c193af8e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dfadf4f3-8d0c-4306-920a-3eec4029f3ef"
          },
          {
            "type": "plannings",
            "id": "62d2bab7-30c5-49de-9451-042b4012c4a3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "84baa106-b2a0-498a-adb5-4ac7774b184a"
          },
          {
            "type": "stock_item_plannings",
            "id": "08101f91-eeb3-45a5-9c24-8e882b04e8a0"
          },
          {
            "type": "stock_item_plannings",
            "id": "b07c0021-3384-4015-80ff-5c46c73e53c6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-25T13:41:44+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
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
        "customer_id": "72d5dc00-42ec-4c7c-990c-5869f88d0bb8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350",
        "stop_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350"
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
      "id": "410e25e3-ff84-40b3-a9ba-7bdd45afb94e",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-25T13:41:45+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
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
        "item_id": "99003961-d7b8-41c2-bf3b-b7a2df54b382",
        "tax_category_id": "e6463fe1-7372-42b8-9c55-3317dbc1d0fc",
        "parent_line_id": null,
        "owner_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
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
      "id": "c94b5253-215a-4d15-9fdd-2e86c193af8e",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-25T13:41:46+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
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
        "item_id": "6ca08e7c-036d-408c-b3aa-d134cd4a1917",
        "tax_category_id": "e6463fe1-7372-42b8-9c55-3317dbc1d0fc",
        "parent_line_id": null,
        "owner_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
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
      "id": "dfadf4f3-8d0c-4306-920a-3eec4029f3ef",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:46+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
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
        "item_id": "6ca08e7c-036d-408c-b3aa-d134cd4a1917",
        "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
        "start_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350",
        "stop_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350",
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
      "id": "62d2bab7-30c5-49de-9451-042b4012c4a3",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:45+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
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
        "item_id": "99003961-d7b8-41c2-bf3b-b7a2df54b382",
        "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f",
        "start_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350",
        "stop_location_id": "4df0a582-9ac1-4088-b495-9b0e1c7c5350",
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
      "id": "84baa106-b2a0-498a-adb5-4ac7774b184a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:46+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9878e19e-f4db-4c0d-807e-b29720ff7d32",
        "planning_id": "dfadf4f3-8d0c-4306-920a-3eec4029f3ef",
        "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f"
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
      "id": "08101f91-eeb3-45a5-9c24-8e882b04e8a0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:46+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5604bff5-05d5-4bdd-8e2f-484372545179",
        "planning_id": "dfadf4f3-8d0c-4306-920a-3eec4029f3ef",
        "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f"
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
      "id": "b07c0021-3384-4015-80ff-5c46c73e53c6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:46+00:00",
        "updated_at": "2021-11-25T13:41:46+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "37733b47-0800-48a2-9c55-68551724c2c9",
        "planning_id": "dfadf4f3-8d0c-4306-920a-3eec4029f3ef",
        "order_id": "4cf3722e-77e5-4d38-8049-cb37cdc4bc0f"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6ca08e7c-036d-408c-b3aa-d134cd4a1917&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9878e19e-f4db-4c0d-807e-b29720ff7d32&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5604bff5-05d5-4bdd-8e2f-484372545179&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=37733b47-0800-48a2-9c55-68551724c2c9&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=99003961-d7b8-41c2-bf3b-b7a2df54b382&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4cf3722e-77e5-4d38-8049-cb37cdc4bc0f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "b1b877f7-16d2-436a-9893-e43a6563bcf3",
          "items": [
            {
              "type": "bundles",
              "id": "79f9ca96-cae4-4cdc-a3c7-e51cbdadf055",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2d609930-ce56-4f59-89e6-c47f04d18f51",
                  "id": "0c98ae08-a8d8-4c80-98c4-033b58b9a1ad"
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
    "id": "ed6a4f79-7c94-5fe4-83e9-f7875a404c31",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b1b877f7-16d2-436a-9893-e43a6563bcf3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b1b877f7-16d2-436a-9893-e43a6563bcf3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4338eb84-5591-4a8c-b567-02681dc2e46d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "607c0303-a1ea-45f1-8b9e-b3a59c493037"
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
      "id": "b1b877f7-16d2-436a-9893-e43a6563bcf3",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-25T13:41:48+00:00",
        "updated_at": "2021-11-25T13:41:49+00:00",
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
        "starts_at": "2021-11-23T13:30:00+00:00",
        "stops_at": "2021-11-27T13:30:00+00:00",
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
        "start_location_id": "817ac8ce-9ffa-4be8-a78b-67867d13dc63",
        "stop_location_id": "817ac8ce-9ffa-4be8-a78b-67867d13dc63"
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
      "id": "4338eb84-5591-4a8c-b567-02681dc2e46d",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-25T13:41:49+00:00",
        "updated_at": "2021-11-25T13:41:49+00:00",
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
        "item_id": "79f9ca96-cae4-4cdc-a3c7-e51cbdadf055",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "b1b877f7-16d2-436a-9893-e43a6563bcf3",
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
      "id": "607c0303-a1ea-45f1-8b9e-b3a59c493037",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-25T13:41:49+00:00",
        "updated_at": "2021-11-25T13:41:49+00:00",
        "quantity": 1,
        "starts_at": "2021-11-23T13:30:00+00:00",
        "stops_at": "2021-11-27T13:30:00+00:00",
        "reserved_from": "2021-11-23T13:30:00+00:00",
        "reserved_till": "2021-11-27T13:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "79f9ca96-cae4-4cdc-a3c7-e51cbdadf055",
        "order_id": "b1b877f7-16d2-436a-9893-e43a6563bcf3",
        "start_location_id": "817ac8ce-9ffa-4be8-a78b-67867d13dc63",
        "stop_location_id": "817ac8ce-9ffa-4be8-a78b-67867d13dc63",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&data%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&data%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&data%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&data%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=79f9ca96-cae4-4cdc-a3c7-e51cbdadf055&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=2d609930-ce56-4f59-89e6-c47f04d18f51&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=0c98ae08-a8d8-4c80-98c4-033b58b9a1ad&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=b1b877f7-16d2-436a-9893-e43a6563bcf3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





