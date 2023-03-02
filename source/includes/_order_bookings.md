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
          "order_id": "7c8f04c6-e879-40cf-a4d4-d7540a9b798f",
          "items": [
            {
              "type": "products",
              "id": "ea4dc3b5-e6cf-46c7-9f11-f1bc37b2129c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "aa9450e5-2287-44d2-a6fb-5be8463d18be",
              "stock_item_ids": [
                "0a7008aa-8622-4d0c-bfb3-578efb825ce2",
                "1f41216e-2055-4cc8-a254-87374f63aee9"
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
          "stock_item_id 0a7008aa-8622-4d0c-bfb3-578efb825ce2 has already been booked on this order"
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
          "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
          "items": [
            {
              "type": "products",
              "id": "d3edb8eb-f673-45dd-8a6d-d1d6ed3cc900",
              "stock_item_ids": [
                "09303391-ee87-4384-8d2a-423e67bbe5d4",
                "d32ece84-a56b-4686-b057-d73a9d6c0f0c",
                "8ade948b-ee3f-482d-830e-1995ec305bfa"
              ]
            },
            {
              "type": "products",
              "id": "7fae09a5-9cfb-4f25-b0d7-535e66c813a6",
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
    "id": "89a300a5-9a82-55f5-9327-7998e1e4f8f2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a6e0c932-8205-4f77-8f59-9982e208cdfc"
          },
          {
            "type": "lines",
            "id": "109fdd65-cd59-42a1-a50b-2029c6ce1c07"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c70db257-9caf-4073-ad9b-296b72447118"
          },
          {
            "type": "plannings",
            "id": "ad3b5ae8-e516-4990-89a3-b3cdc66a61f9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "36995fed-acd7-41db-b057-77d0090cfc73"
          },
          {
            "type": "stock_item_plannings",
            "id": "43a2016b-bdcf-47f3-b87d-a1474b6f0409"
          },
          {
            "type": "stock_item_plannings",
            "id": "9319726f-6a98-43d0-b6bd-d562dcc2e950"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T11:09:23+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
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
        "customer_id": "d4af8cea-574a-4e6f-9310-52bbd4c13d8d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225",
        "stop_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225"
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
      "id": "a6e0c932-8205-4f77-8f59-9982e208cdfc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
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
        "item_id": "d3edb8eb-f673-45dd-8a6d-d1d6ed3cc900",
        "tax_category_id": "baa69245-1e56-4fbb-807d-9ee47b5bee7d",
        "planning_id": "c70db257-9caf-4073-ad9b-296b72447118",
        "parent_line_id": null,
        "owner_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
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
      "id": "109fdd65-cd59-42a1-a50b-2029c6ce1c07",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
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
        "item_id": "7fae09a5-9cfb-4f25-b0d7-535e66c813a6",
        "tax_category_id": "baa69245-1e56-4fbb-807d-9ee47b5bee7d",
        "planning_id": "ad3b5ae8-e516-4990-89a3-b3cdc66a61f9",
        "parent_line_id": null,
        "owner_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
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
      "id": "c70db257-9caf-4073-ad9b-296b72447118",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
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
        "item_id": "d3edb8eb-f673-45dd-8a6d-d1d6ed3cc900",
        "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
        "start_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225",
        "stop_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225",
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
      "id": "ad3b5ae8-e516-4990-89a3-b3cdc66a61f9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
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
        "item_id": "7fae09a5-9cfb-4f25-b0d7-535e66c813a6",
        "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c",
        "start_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225",
        "stop_location_id": "f2059701-7fbc-4d1c-b280-d243eb674225",
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
      "id": "36995fed-acd7-41db-b057-77d0090cfc73",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "09303391-ee87-4384-8d2a-423e67bbe5d4",
        "planning_id": "c70db257-9caf-4073-ad9b-296b72447118",
        "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c"
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
      "id": "43a2016b-bdcf-47f3-b87d-a1474b6f0409",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d32ece84-a56b-4686-b057-d73a9d6c0f0c",
        "planning_id": "c70db257-9caf-4073-ad9b-296b72447118",
        "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c"
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
      "id": "9319726f-6a98-43d0-b6bd-d562dcc2e950",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:24+00:00",
        "updated_at": "2023-03-02T11:09:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8ade948b-ee3f-482d-830e-1995ec305bfa",
        "planning_id": "c70db257-9caf-4073-ad9b-296b72447118",
        "order_id": "7708bc48-fd97-4a40-b7e0-384a68cfc38c"
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
          "order_id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f",
          "items": [
            {
              "type": "bundles",
              "id": "0b0a3bc6-5b11-481a-a890-0b38f97897b3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5373fa97-40a3-4b11-a3b9-8fe1b2b3a9ea",
                  "id": "3729e9ef-6fda-4b0d-b458-5cc4f72a9399"
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
    "id": "e3d81de8-3965-5b72-96a0-3fa3ac53d716",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8e3fc818-287a-4f6d-8142-6a0cc473d622"
          },
          {
            "type": "lines",
            "id": "2d5d7887-6458-42fc-9ca0-70b2ff852fb3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7a725ba4-a36f-47e9-a59f-d504583f2750"
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
      "id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-02T11:09:26+00:00",
        "updated_at": "2023-03-02T11:09:27+00:00",
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
        "starts_at": "2023-02-28T11:00:00+00:00",
        "stops_at": "2023-03-04T11:00:00+00:00",
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
        "start_location_id": "a9b08c4c-26dc-4ce6-9b00-1eec5e540c18",
        "stop_location_id": "a9b08c4c-26dc-4ce6-9b00-1eec5e540c18"
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
      "id": "8e3fc818-287a-4f6d-8142-6a0cc473d622",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T11:09:26+00:00",
        "updated_at": "2023-03-02T11:09:26+00:00",
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
        "item_id": "0b0a3bc6-5b11-481a-a890-0b38f97897b3",
        "tax_category_id": null,
        "planning_id": "7a725ba4-a36f-47e9-a59f-d504583f2750",
        "parent_line_id": null,
        "owner_id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f",
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
      "id": "2d5d7887-6458-42fc-9ca0-70b2ff852fb3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-02T11:09:26+00:00",
        "updated_at": "2023-03-02T11:09:26+00:00",
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
        "item_id": "3729e9ef-6fda-4b0d-b458-5cc4f72a9399",
        "tax_category_id": null,
        "planning_id": "9f1ba14e-d0d6-4584-8d7c-7fa280f7495e",
        "parent_line_id": "8e3fc818-287a-4f6d-8142-6a0cc473d622",
        "owner_id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f",
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
      "id": "7a725ba4-a36f-47e9-a59f-d504583f2750",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-02T11:09:26+00:00",
        "updated_at": "2023-03-02T11:09:26+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-28T11:00:00+00:00",
        "stops_at": "2023-03-04T11:00:00+00:00",
        "reserved_from": "2023-02-28T11:00:00+00:00",
        "reserved_till": "2023-03-04T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0b0a3bc6-5b11-481a-a890-0b38f97897b3",
        "order_id": "b92007b2-eddd-4fe4-98ee-b49091cedd0f",
        "start_location_id": "a9b08c4c-26dc-4ce6-9b00-1eec5e540c18",
        "stop_location_id": "a9b08c4c-26dc-4ce6-9b00-1eec5e540c18",
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





