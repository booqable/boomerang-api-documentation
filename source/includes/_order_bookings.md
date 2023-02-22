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
          "order_id": "76d2b361-ea54-491f-be14-0ba4a0f3706c",
          "items": [
            {
              "type": "products",
              "id": "531597fc-c55f-488c-8f7b-b835c986a009",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1f956f5c-6d15-45f3-8403-668b97f39032",
              "stock_item_ids": [
                "e143c3c7-e46f-4e5a-ae48-5c29ff4256a0",
                "2875b6a6-434b-4fd7-be0c-0d1b5f9e4649"
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
          "stock_item_id e143c3c7-e46f-4e5a-ae48-5c29ff4256a0 has already been booked on this order"
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
          "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312",
          "items": [
            {
              "type": "products",
              "id": "95efe3c8-01d0-450a-a623-82b243eec7a7",
              "stock_item_ids": [
                "e103525e-27e7-4dd1-b592-2eaf0189d9b1",
                "8bc2b5f9-dc80-40aa-81f3-f7bfa0ae758e",
                "ce589e59-b1e4-4bfb-aff4-9e350e089efc"
              ]
            },
            {
              "type": "products",
              "id": "80dacb1c-2588-400a-8fc4-79a08214d422",
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
    "id": "d3df7eae-8119-54ec-be43-0d04def9ceaf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3a965774-281d-414d-8e3f-41e9adcdd312"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "93eaa656-058e-4ef6-a203-323ee94ce996"
          },
          {
            "type": "lines",
            "id": "a031458c-33e9-4e3e-ba61-a89ae179c79b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "61023556-5422-4c65-b71a-6f7d80782bea"
          },
          {
            "type": "plannings",
            "id": "684732f4-8d60-4c95-8ae0-15901681bf80"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "98ef1f8e-c099-446c-b728-d8bcd8c49ad1"
          },
          {
            "type": "stock_item_plannings",
            "id": "fc8f39df-5119-4797-85fc-c387b5069490"
          },
          {
            "type": "stock_item_plannings",
            "id": "e282f88f-39e1-4983-9ac8-1edc41442548"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3a965774-281d-414d-8e3f-41e9adcdd312",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T11:53:30+00:00",
        "updated_at": "2023-02-22T11:53:32+00:00",
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
        "customer_id": "f470b89c-4362-4101-aad3-b35a9227c086",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f",
        "stop_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f"
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
      "id": "93eaa656-058e-4ef6-a203-323ee94ce996",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:32+00:00",
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
        "item_id": "95efe3c8-01d0-450a-a623-82b243eec7a7",
        "tax_category_id": "3b9229e3-a2e2-43a0-a7dd-a000f4e0a92c",
        "planning_id": "61023556-5422-4c65-b71a-6f7d80782bea",
        "parent_line_id": null,
        "owner_id": "3a965774-281d-414d-8e3f-41e9adcdd312",
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
      "id": "a031458c-33e9-4e3e-ba61-a89ae179c79b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:32+00:00",
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
        "item_id": "80dacb1c-2588-400a-8fc4-79a08214d422",
        "tax_category_id": "3b9229e3-a2e2-43a0-a7dd-a000f4e0a92c",
        "planning_id": "684732f4-8d60-4c95-8ae0-15901681bf80",
        "parent_line_id": null,
        "owner_id": "3a965774-281d-414d-8e3f-41e9adcdd312",
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
      "id": "61023556-5422-4c65-b71a-6f7d80782bea",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:31+00:00",
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
        "item_id": "95efe3c8-01d0-450a-a623-82b243eec7a7",
        "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312",
        "start_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f",
        "stop_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f",
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
      "id": "684732f4-8d60-4c95-8ae0-15901681bf80",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:31+00:00",
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
        "item_id": "80dacb1c-2588-400a-8fc4-79a08214d422",
        "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312",
        "start_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f",
        "stop_location_id": "f7057bc3-20a4-41e5-b719-d80dc7c5e02f",
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
      "id": "98ef1f8e-c099-446c-b728-d8bcd8c49ad1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e103525e-27e7-4dd1-b592-2eaf0189d9b1",
        "planning_id": "61023556-5422-4c65-b71a-6f7d80782bea",
        "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312"
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
      "id": "fc8f39df-5119-4797-85fc-c387b5069490",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8bc2b5f9-dc80-40aa-81f3-f7bfa0ae758e",
        "planning_id": "61023556-5422-4c65-b71a-6f7d80782bea",
        "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312"
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
      "id": "e282f88f-39e1-4983-9ac8-1edc41442548",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:31+00:00",
        "updated_at": "2023-02-22T11:53:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ce589e59-b1e4-4bfb-aff4-9e350e089efc",
        "planning_id": "61023556-5422-4c65-b71a-6f7d80782bea",
        "order_id": "3a965774-281d-414d-8e3f-41e9adcdd312"
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
          "order_id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7",
          "items": [
            {
              "type": "bundles",
              "id": "ace20916-3de1-4a51-8662-6a13b7d19551",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7059c68a-5488-4717-b224-c56e24536eb3",
                  "id": "c4479f17-2920-4227-8965-d5837d4d88b6"
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
    "id": "9bd31ffe-c1a2-5510-9286-2fe29c3d50b8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "43f31535-23e1-4977-8fb8-a7655d2e8938"
          },
          {
            "type": "lines",
            "id": "373773b8-bf07-4015-b7d9-82b72dd1b0dc"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b7cf1ff2-8a2f-408f-b7b5-700002986994"
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
      "id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-22T11:53:37+00:00",
        "updated_at": "2023-02-22T11:53:37+00:00",
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
        "starts_at": "2023-02-20T11:45:00+00:00",
        "stops_at": "2023-02-24T11:45:00+00:00",
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
        "start_location_id": "776a364c-7a99-4295-adce-afa082a82521",
        "stop_location_id": "776a364c-7a99-4295-adce-afa082a82521"
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
      "id": "43f31535-23e1-4977-8fb8-a7655d2e8938",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T11:53:37+00:00",
        "updated_at": "2023-02-22T11:53:37+00:00",
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
        "item_id": "c4479f17-2920-4227-8965-d5837d4d88b6",
        "tax_category_id": null,
        "planning_id": "2ccc3f73-c931-48a8-b118-42b5797b07bf",
        "parent_line_id": "373773b8-bf07-4015-b7d9-82b72dd1b0dc",
        "owner_id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7",
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
      "id": "373773b8-bf07-4015-b7d9-82b72dd1b0dc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-22T11:53:37+00:00",
        "updated_at": "2023-02-22T11:53:37+00:00",
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
        "item_id": "ace20916-3de1-4a51-8662-6a13b7d19551",
        "tax_category_id": null,
        "planning_id": "b7cf1ff2-8a2f-408f-b7b5-700002986994",
        "parent_line_id": null,
        "owner_id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7",
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
      "id": "b7cf1ff2-8a2f-408f-b7b5-700002986994",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-22T11:53:37+00:00",
        "updated_at": "2023-02-22T11:53:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-20T11:45:00+00:00",
        "stops_at": "2023-02-24T11:45:00+00:00",
        "reserved_from": "2023-02-20T11:45:00+00:00",
        "reserved_till": "2023-02-24T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ace20916-3de1-4a51-8662-6a13b7d19551",
        "order_id": "9c5ba55f-a237-4c9e-adfe-706de130e1f7",
        "start_location_id": "776a364c-7a99-4295-adce-afa082a82521",
        "stop_location_id": "776a364c-7a99-4295-adce-afa082a82521",
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





