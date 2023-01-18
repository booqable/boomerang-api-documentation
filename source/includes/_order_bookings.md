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
          "order_id": "e24d13a6-d39b-4e83-8897-b8c4a01e8f17",
          "items": [
            {
              "type": "products",
              "id": "7e3da747-b0ff-461c-9019-c0c4e47596d1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "69d34dff-7140-42fb-a09f-9af5e950694a",
              "stock_item_ids": [
                "a12b1263-7d26-4c57-9dc1-f7b5bd5bf3a0",
                "f4f04683-b479-4c7d-a57d-7e1de05a8ecb"
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
            "item_id": "7e3da747-b0ff-461c-9019-c0c4e47596d1",
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
          "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
          "items": [
            {
              "type": "products",
              "id": "cc595159-7767-4c0f-b264-06e37b4323b8",
              "stock_item_ids": [
                "66302979-dad9-4786-8525-f74689630c94",
                "8ab872dc-d9ac-4fd9-bd38-1bb0e91deed5",
                "c23ec490-a8f1-405f-b5ed-edf1df945aab"
              ]
            },
            {
              "type": "products",
              "id": "be571fe2-e64c-482f-a4a7-83647cd4c83e",
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
    "id": "9f87121a-28dd-50a7-8260-cf41bce678d2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e02e9c99-265a-4eff-94c2-98c542ef5159"
          },
          {
            "type": "lines",
            "id": "3f31cb44-afa0-4c8e-9280-96065914cb55"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26"
          },
          {
            "type": "plannings",
            "id": "a0c51af9-0e80-4d48-8de8-1efaa2b0fdb3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b9c9b661-4c24-43d6-9ff5-7627fa58a7d0"
          },
          {
            "type": "stock_item_plannings",
            "id": "a65590b1-8f9b-4eef-bd30-11db2a7c5aac"
          },
          {
            "type": "stock_item_plannings",
            "id": "d514f865-4d29-4d7f-a4a3-b8718757ce00"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-18T13:36:23+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
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
        "customer_id": "44ab2a41-e2ea-4cb0-9af9-9935e61facf1",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c",
        "stop_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c"
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
      "id": "e02e9c99-265a-4eff-94c2-98c542ef5159",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-18T13:36:25+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
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
        "item_id": "cc595159-7767-4c0f-b264-06e37b4323b8",
        "tax_category_id": "0c8af20b-d667-4425-810e-359309f3ae55",
        "planning_id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26",
        "parent_line_id": null,
        "owner_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
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
      "id": "3f31cb44-afa0-4c8e-9280-96065914cb55",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-18T13:36:25+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
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
        "item_id": "be571fe2-e64c-482f-a4a7-83647cd4c83e",
        "tax_category_id": "0c8af20b-d667-4425-810e-359309f3ae55",
        "planning_id": "a0c51af9-0e80-4d48-8de8-1efaa2b0fdb3",
        "parent_line_id": null,
        "owner_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
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
      "id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:24+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
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
        "item_id": "cc595159-7767-4c0f-b264-06e37b4323b8",
        "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
        "start_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c",
        "stop_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c",
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
      "id": "a0c51af9-0e80-4d48-8de8-1efaa2b0fdb3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:24+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
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
        "item_id": "be571fe2-e64c-482f-a4a7-83647cd4c83e",
        "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85",
        "start_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c",
        "stop_location_id": "20df2fd7-3bc9-479d-980f-df97038fab9c",
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
      "id": "b9c9b661-4c24-43d6-9ff5-7627fa58a7d0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:24+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66302979-dad9-4786-8525-f74689630c94",
        "planning_id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26",
        "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85"
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
      "id": "a65590b1-8f9b-4eef-bd30-11db2a7c5aac",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:24+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8ab872dc-d9ac-4fd9-bd38-1bb0e91deed5",
        "planning_id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26",
        "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85"
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
      "id": "d514f865-4d29-4d7f-a4a3-b8718757ce00",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:24+00:00",
        "updated_at": "2023-01-18T13:36:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c23ec490-a8f1-405f-b5ed-edf1df945aab",
        "planning_id": "9e872f76-ef6a-4cd4-a1ed-fab9f3961a26",
        "order_id": "76df69c1-0b5e-4ab7-bf9a-eeb0f9c39a85"
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
          "order_id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f",
          "items": [
            {
              "type": "bundles",
              "id": "266b6dc6-7183-453d-84b9-9cb4d8fa4147",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a8b733d2-b21e-49ce-b3a4-afa941ed5171",
                  "id": "c5e9ca0c-c926-4531-b054-99dfb29bd451"
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
    "id": "79c59262-2e5f-5da3-a08a-9fee9b7515bb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ac5c36f3-9997-4a1f-8afd-54271232f8bb"
          },
          {
            "type": "lines",
            "id": "767dea20-e3ad-4989-88f2-1f28976e467e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7bf4575e-c830-40db-8cff-5246ca40ae0f"
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
      "id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-18T13:36:27+00:00",
        "updated_at": "2023-01-18T13:36:28+00:00",
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
        "starts_at": "2023-01-16T13:30:00+00:00",
        "stops_at": "2023-01-20T13:30:00+00:00",
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
        "start_location_id": "34d9b159-92fc-4fcc-93d5-957fe7ea12b5",
        "stop_location_id": "34d9b159-92fc-4fcc-93d5-957fe7ea12b5"
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
      "id": "ac5c36f3-9997-4a1f-8afd-54271232f8bb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-18T13:36:27+00:00",
        "updated_at": "2023-01-18T13:36:27+00:00",
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
        "item_id": "266b6dc6-7183-453d-84b9-9cb4d8fa4147",
        "tax_category_id": null,
        "planning_id": "7bf4575e-c830-40db-8cff-5246ca40ae0f",
        "parent_line_id": null,
        "owner_id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f",
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
      "id": "767dea20-e3ad-4989-88f2-1f28976e467e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-18T13:36:27+00:00",
        "updated_at": "2023-01-18T13:36:27+00:00",
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
        "item_id": "c5e9ca0c-c926-4531-b054-99dfb29bd451",
        "tax_category_id": null,
        "planning_id": "cc59b898-0d92-434f-b378-543853d435d3",
        "parent_line_id": "ac5c36f3-9997-4a1f-8afd-54271232f8bb",
        "owner_id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f",
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
      "id": "7bf4575e-c830-40db-8cff-5246ca40ae0f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-18T13:36:27+00:00",
        "updated_at": "2023-01-18T13:36:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-16T13:30:00+00:00",
        "stops_at": "2023-01-20T13:30:00+00:00",
        "reserved_from": "2023-01-16T13:30:00+00:00",
        "reserved_till": "2023-01-20T13:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "266b6dc6-7183-453d-84b9-9cb4d8fa4147",
        "order_id": "9fe85df0-27ee-43a4-afb0-f6da9080c00f",
        "start_location_id": "34d9b159-92fc-4fcc-93d5-957fe7ea12b5",
        "stop_location_id": "34d9b159-92fc-4fcc-93d5-957fe7ea12b5",
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





