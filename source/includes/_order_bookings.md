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
          "order_id": "4ae7e8d8-f30a-4a32-a769-4ad317e96db5",
          "items": [
            {
              "type": "products",
              "id": "53c6c6a4-0c90-4608-9737-cb91de9f0a56",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "93b65094-1e70-4b46-befe-8acfeaeb70ac",
              "stock_item_ids": [
                "4b224dba-5399-4701-8314-47a8bd6e79a5",
                "ac690246-1199-44fd-8ac7-9230ac3cf4c2"
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
          "stock_item_id 4b224dba-5399-4701-8314-47a8bd6e79a5 has already been booked on this order"
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
          "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
          "items": [
            {
              "type": "products",
              "id": "ffc1fef1-d638-4a29-8ecd-6d52d61e5b45",
              "stock_item_ids": [
                "91ed03cd-7aae-47b8-88e0-bbc18d97d2a8",
                "3aa2b2f1-add0-422a-95b7-d26928845c31",
                "3e0c979f-f713-4f92-b498-1366ed0e0e87"
              ]
            },
            {
              "type": "products",
              "id": "cfaa5832-aa72-496e-a3b3-63ea02194b63",
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
    "id": "7867ecc1-efbd-50ee-ab60-d1bc8e8ac579",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0cb8d954-487f-41fb-8e0a-bbab84599224"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "14042745-944e-447e-80ce-50f90d293ffe"
          },
          {
            "type": "lines",
            "id": "dad2fcc4-a0f7-4964-9621-b2b17679749d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9e7c79bf-c1c2-436b-ba84-2882ba510304"
          },
          {
            "type": "plannings",
            "id": "4227a99a-a396-4bf4-badf-396cb3db7535"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f7009839-51c4-4db7-a061-1f58ad3a8e60"
          },
          {
            "type": "stock_item_plannings",
            "id": "34f5ee32-ed5a-45e6-a170-909ebca3bde4"
          },
          {
            "type": "stock_item_plannings",
            "id": "fef780e0-492a-45e7-954c-6e41de177cf3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T09:12:19+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
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
        "customer_id": "a7797f82-128e-4695-a24a-778ef2de3155",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999",
        "stop_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999"
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
      "id": "14042745-944e-447e-80ce-50f90d293ffe",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
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
        "item_id": "ffc1fef1-d638-4a29-8ecd-6d52d61e5b45",
        "tax_category_id": "3e2d9586-05a6-4026-8e7a-e28ad59195da",
        "planning_id": "9e7c79bf-c1c2-436b-ba84-2882ba510304",
        "parent_line_id": null,
        "owner_id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
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
      "id": "dad2fcc4-a0f7-4964-9621-b2b17679749d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
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
        "item_id": "cfaa5832-aa72-496e-a3b3-63ea02194b63",
        "tax_category_id": "3e2d9586-05a6-4026-8e7a-e28ad59195da",
        "planning_id": "4227a99a-a396-4bf4-badf-396cb3db7535",
        "parent_line_id": null,
        "owner_id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
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
      "id": "9e7c79bf-c1c2-436b-ba84-2882ba510304",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
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
        "item_id": "ffc1fef1-d638-4a29-8ecd-6d52d61e5b45",
        "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
        "start_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999",
        "stop_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999",
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
      "id": "4227a99a-a396-4bf4-badf-396cb3db7535",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
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
        "item_id": "cfaa5832-aa72-496e-a3b3-63ea02194b63",
        "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224",
        "start_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999",
        "stop_location_id": "0a792ca2-ab10-41d3-89ec-0ec3777c2999",
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
      "id": "f7009839-51c4-4db7-a061-1f58ad3a8e60",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "91ed03cd-7aae-47b8-88e0-bbc18d97d2a8",
        "planning_id": "9e7c79bf-c1c2-436b-ba84-2882ba510304",
        "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224"
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
      "id": "34f5ee32-ed5a-45e6-a170-909ebca3bde4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3aa2b2f1-add0-422a-95b7-d26928845c31",
        "planning_id": "9e7c79bf-c1c2-436b-ba84-2882ba510304",
        "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224"
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
      "id": "fef780e0-492a-45e7-954c-6e41de177cf3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:21+00:00",
        "updated_at": "2023-02-24T09:12:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3e0c979f-f713-4f92-b498-1366ed0e0e87",
        "planning_id": "9e7c79bf-c1c2-436b-ba84-2882ba510304",
        "order_id": "0cb8d954-487f-41fb-8e0a-bbab84599224"
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
          "order_id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e",
          "items": [
            {
              "type": "bundles",
              "id": "e920241d-02ec-434b-a9a4-89b0c14adf39",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "52cfe157-e04b-43d4-9a5e-b78a50e6fd3b",
                  "id": "00a31c61-1e5a-4e78-ba06-1fd7ce510a07"
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
    "id": "00ec817e-a437-5600-9c2c-b51968250a59",
    "type": "order_bookings",
    "attributes": {
      "order_id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0edc4c54-6979-4223-9a7e-d1efc0b749f4"
          },
          {
            "type": "lines",
            "id": "899623db-6f6e-4056-8056-ef10dbc3c62f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b7505ac5-9717-4ecb-9d83-e145256f00d0"
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
      "id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T09:12:23+00:00",
        "updated_at": "2023-02-24T09:12:24+00:00",
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
        "starts_at": "2023-02-22T09:00:00+00:00",
        "stops_at": "2023-02-26T09:00:00+00:00",
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
        "start_location_id": "056829e0-47a1-40ba-9afe-bc378db671cd",
        "stop_location_id": "056829e0-47a1-40ba-9afe-bc378db671cd"
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
      "id": "0edc4c54-6979-4223-9a7e-d1efc0b749f4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:12:24+00:00",
        "updated_at": "2023-02-24T09:12:24+00:00",
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
        "item_id": "00a31c61-1e5a-4e78-ba06-1fd7ce510a07",
        "tax_category_id": null,
        "planning_id": "aa3a57fb-28a4-4c80-8769-311bb7e73f8f",
        "parent_line_id": "899623db-6f6e-4056-8056-ef10dbc3c62f",
        "owner_id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e",
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
      "id": "899623db-6f6e-4056-8056-ef10dbc3c62f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T09:12:24+00:00",
        "updated_at": "2023-02-24T09:12:24+00:00",
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
        "item_id": "e920241d-02ec-434b-a9a4-89b0c14adf39",
        "tax_category_id": null,
        "planning_id": "b7505ac5-9717-4ecb-9d83-e145256f00d0",
        "parent_line_id": null,
        "owner_id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e",
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
      "id": "b7505ac5-9717-4ecb-9d83-e145256f00d0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T09:12:23+00:00",
        "updated_at": "2023-02-24T09:12:23+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T09:00:00+00:00",
        "stops_at": "2023-02-26T09:00:00+00:00",
        "reserved_from": "2023-02-22T09:00:00+00:00",
        "reserved_till": "2023-02-26T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e920241d-02ec-434b-a9a4-89b0c14adf39",
        "order_id": "54ebf601-97ee-4d04-8449-3c9fc0dcd94e",
        "start_location_id": "056829e0-47a1-40ba-9afe-bc378db671cd",
        "stop_location_id": "056829e0-47a1-40ba-9afe-bc378db671cd",
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





