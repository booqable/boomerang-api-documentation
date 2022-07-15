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
          "order_id": "31ae0add-95bd-4579-b966-fcb7f6982f52",
          "items": [
            {
              "type": "products",
              "id": "20b99928-a7f1-4e96-ad6f-f26d17af2927",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "13aec5ed-1781-458c-be5b-bc4b4e124b06",
              "stock_item_ids": [
                "e851bf5a-d5cb-4595-9c6c-a5e89d1a02c5",
                "f625542e-d5c5-494c-8018-744b331838f2"
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
            "item_id": "20b99928-a7f1-4e96-ad6f-f26d17af2927",
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
          "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
          "items": [
            {
              "type": "products",
              "id": "2fa172da-23e6-4ef3-bb0d-e60bc65f2911",
              "stock_item_ids": [
                "7454a787-85dc-4e4b-92a4-822a173f91e9",
                "ef4a87d4-e1f8-460c-ba01-5b33e62420a2",
                "2889b005-e43d-41e1-bc1c-b343baee8827"
              ]
            },
            {
              "type": "products",
              "id": "100d1847-f7db-4448-b390-ec19028cc93c",
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
    "id": "3c166108-9e5a-5bb1-a13e-ce7757da9571",
    "type": "order_bookings",
    "attributes": {
      "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f84bd422-3619-4980-b71e-c2248ca219ec"
          },
          {
            "type": "lines",
            "id": "7804e0d8-e3df-4aee-9746-5a926c9f0fd9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0936898b-29da-4361-9de8-265119131fae"
          },
          {
            "type": "plannings",
            "id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "14fe0023-5894-42bf-a7c0-ad585e1cd524"
          },
          {
            "type": "stock_item_plannings",
            "id": "29b90a26-9764-4bbf-8dfc-768f9963c81c"
          },
          {
            "type": "stock_item_plannings",
            "id": "9c1df18b-fb77-4995-8b00-3f001ab45d46"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-15T09:55:19+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
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
        "customer_id": "34f1328a-413f-44cf-acb5-6f06a1b8a5a6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0276e395-a143-4322-91d6-400a020603ad",
        "stop_location_id": "0276e395-a143-4322-91d6-400a020603ad"
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
      "id": "f84bd422-3619-4980-b71e-c2248ca219ec",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:55:20+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
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
        "item_id": "100d1847-f7db-4448-b390-ec19028cc93c",
        "tax_category_id": "da3d9c87-b771-4a8c-a431-3bf074a60991",
        "planning_id": "0936898b-29da-4361-9de8-265119131fae",
        "parent_line_id": null,
        "owner_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
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
      "id": "7804e0d8-e3df-4aee-9746-5a926c9f0fd9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:55:21+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
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
        "item_id": "2fa172da-23e6-4ef3-bb0d-e60bc65f2911",
        "tax_category_id": "da3d9c87-b771-4a8c-a431-3bf074a60991",
        "planning_id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3",
        "parent_line_id": null,
        "owner_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
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
      "id": "0936898b-29da-4361-9de8-265119131fae",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:20+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
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
        "item_id": "100d1847-f7db-4448-b390-ec19028cc93c",
        "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
        "start_location_id": "0276e395-a143-4322-91d6-400a020603ad",
        "stop_location_id": "0276e395-a143-4322-91d6-400a020603ad",
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
      "id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:21+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
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
        "item_id": "2fa172da-23e6-4ef3-bb0d-e60bc65f2911",
        "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3",
        "start_location_id": "0276e395-a143-4322-91d6-400a020603ad",
        "stop_location_id": "0276e395-a143-4322-91d6-400a020603ad",
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
      "id": "14fe0023-5894-42bf-a7c0-ad585e1cd524",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:21+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7454a787-85dc-4e4b-92a4-822a173f91e9",
        "planning_id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3",
        "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3"
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
      "id": "29b90a26-9764-4bbf-8dfc-768f9963c81c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:21+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ef4a87d4-e1f8-460c-ba01-5b33e62420a2",
        "planning_id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3",
        "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3"
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
      "id": "9c1df18b-fb77-4995-8b00-3f001ab45d46",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:21+00:00",
        "updated_at": "2022-07-15T09:55:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2889b005-e43d-41e1-bc1c-b343baee8827",
        "planning_id": "0e6fe359-4b15-4e97-ba2a-fbd193b35aa3",
        "order_id": "45aa8ed4-780c-42c2-ba1c-2422536be6a3"
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
          "order_id": "9879d8fb-0866-4d41-911e-3a4ba656457c",
          "items": [
            {
              "type": "bundles",
              "id": "5cc347e9-520f-4159-ae92-c90f283d2a15",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1602dfde-1195-42e3-9f3e-e0c30af44674",
                  "id": "ab1c8044-eee7-45e9-9c8a-826c7ab4ca51"
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
    "id": "29ebc22c-a745-5b58-bbfa-cb3112215a61",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9879d8fb-0866-4d41-911e-3a4ba656457c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9879d8fb-0866-4d41-911e-3a4ba656457c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3a58bfb4-a0a6-4a23-a7c7-bb90dd7a55c2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e7b3aab8-5388-4007-904b-cf260dc9224e"
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
      "id": "9879d8fb-0866-4d41-911e-3a4ba656457c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-15T09:55:23+00:00",
        "updated_at": "2022-07-15T09:55:24+00:00",
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
        "starts_at": "2022-07-13T09:45:00+00:00",
        "stops_at": "2022-07-17T09:45:00+00:00",
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
        "start_location_id": "3d4f3e4d-1bd1-425d-86ad-da880e947bf9",
        "stop_location_id": "3d4f3e4d-1bd1-425d-86ad-da880e947bf9"
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
      "id": "3a58bfb4-a0a6-4a23-a7c7-bb90dd7a55c2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-15T09:55:24+00:00",
        "updated_at": "2022-07-15T09:55:24+00:00",
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
        "item_id": "5cc347e9-520f-4159-ae92-c90f283d2a15",
        "tax_category_id": null,
        "planning_id": "e7b3aab8-5388-4007-904b-cf260dc9224e",
        "parent_line_id": null,
        "owner_id": "9879d8fb-0866-4d41-911e-3a4ba656457c",
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
      "id": "e7b3aab8-5388-4007-904b-cf260dc9224e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-15T09:55:24+00:00",
        "updated_at": "2022-07-15T09:55:24+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-13T09:45:00+00:00",
        "stops_at": "2022-07-17T09:45:00+00:00",
        "reserved_from": "2022-07-13T09:45:00+00:00",
        "reserved_till": "2022-07-17T09:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5cc347e9-520f-4159-ae92-c90f283d2a15",
        "order_id": "9879d8fb-0866-4d41-911e-3a4ba656457c",
        "start_location_id": "3d4f3e4d-1bd1-425d-86ad-da880e947bf9",
        "stop_location_id": "3d4f3e4d-1bd1-425d-86ad-da880e947bf9",
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





