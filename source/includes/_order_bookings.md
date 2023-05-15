# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
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
          "order_id": "2c9a1c85-37d0-4015-9acd-590d390354f2",
          "items": [
            {
              "type": "products",
              "id": "f987d69a-b305-488f-b59a-76df609ba7f2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "64c96683-2143-4c7d-a66e-744be6fd189f",
              "stock_item_ids": [
                "883ca34c-8313-4a65-a2cb-754e8220c506",
                "5e59bc1c-f368-46e2-8b26-080a0cc3770f"
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
          "stock_item_id 883ca34c-8313-4a65-a2cb-754e8220c506 has already been booked on this order"
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
          "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
          "items": [
            {
              "type": "products",
              "id": "8d60e424-b0ee-41a7-9215-1dd87d291b59",
              "stock_item_ids": [
                "6aa7e698-0517-468f-b5dc-618ad4b44d6a",
                "eb9f8a83-b91e-48b6-80e1-19270af9359e",
                "8eee1cb0-bed2-4ec6-b6fa-f6b1c0d08ef6"
              ]
            },
            {
              "type": "products",
              "id": "a941b7a9-d711-4393-9893-997a28172bdb",
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
    "id": "941f6308-3731-5204-952e-f695278209cd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1dae871e-1507-4f59-b6ee-251f86d83087"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b7aba256-fa59-484e-b5f8-6db96520ccde"
          },
          {
            "type": "lines",
            "id": "5e6035fc-0032-4e39-bc88-ee7396b442eb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7"
          },
          {
            "type": "plannings",
            "id": "b9e47d4e-dcbf-46dc-97d0-bd651360fb30"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0b24822a-c63f-4a40-b424-ce33c947b2bd"
          },
          {
            "type": "stock_item_plannings",
            "id": "a424c1bc-0718-4006-a875-b3418394c6ac"
          },
          {
            "type": "stock_item_plannings",
            "id": "d6e75964-700c-436f-9fb3-af6593b1952e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1dae871e-1507-4f59-b6ee-251f86d83087",
      "type": "orders",
      "attributes": {
        "created_at": "2023-05-15T13:49:35+00:00",
        "updated_at": "2023-05-15T13:49:37+00:00",
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
        "deposit_value": 10.0,
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
        "customer_id": "0aa60250-4677-45a4-967a-94913d1ca219",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d",
        "stop_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d"
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
      "id": "b7aba256-fa59-484e-b5f8-6db96520ccde",
      "type": "lines",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:37+00:00",
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
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "item_id": "8d60e424-b0ee-41a7-9215-1dd87d291b59",
        "tax_category_id": "1838b6c8-2705-4f09-95a9-5c14adea8a51",
        "planning_id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7",
        "parent_line_id": null,
        "owner_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "5e6035fc-0032-4e39-bc88-ee7396b442eb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:37+00:00",
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
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "item_id": "a941b7a9-d711-4393-9893-997a28172bdb",
        "tax_category_id": "1838b6c8-2705-4f09-95a9-5c14adea8a51",
        "planning_id": "b9e47d4e-dcbf-46dc-97d0-bd651360fb30",
        "parent_line_id": null,
        "owner_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:36+00:00",
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
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "item_id": "8d60e424-b0ee-41a7-9215-1dd87d291b59",
        "start_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d",
        "stop_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "b9e47d4e-dcbf-46dc-97d0-bd651360fb30",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:36+00:00",
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
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087",
        "item_id": "a941b7a9-d711-4393-9893-997a28172bdb",
        "start_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d",
        "stop_location_id": "377cff9b-1ce2-458a-a8fb-abc220ee175d",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "0b24822a-c63f-4a40-b424-ce33c947b2bd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6aa7e698-0517-468f-b5dc-618ad4b44d6a",
        "planning_id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7",
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087"
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
      "id": "a424c1bc-0718-4006-a875-b3418394c6ac",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eb9f8a83-b91e-48b6-80e1-19270af9359e",
        "planning_id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7",
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087"
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
      "id": "d6e75964-700c-436f-9fb3-af6593b1952e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:36+00:00",
        "updated_at": "2023-05-15T13:49:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8eee1cb0-bed2-4ec6-b6fa-f6b1c0d08ef6",
        "planning_id": "6786bde0-d310-49e8-98ba-7cbe80fe73a7",
        "order_id": "1dae871e-1507-4f59-b6ee-251f86d83087"
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
          "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
          "items": [
            {
              "type": "bundles",
              "id": "cb634ff7-c1df-417f-b530-47ad2262169e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2d716607-3559-46de-b8a0-2b9f202f4272",
                  "id": "2e0c68d0-dd80-49e7-aad0-d93c66fba9b2"
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
    "id": "e0f2088c-601f-5051-aa0e-94f2b40de120",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6a74690a-1522-4bed-bac2-faa6f99931f6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ae8ecc5f-4463-4b5e-82fc-a52bd5e80dfc"
          },
          {
            "type": "lines",
            "id": "1ce7aab3-abbf-4f53-9e06-ab6153953a82"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bbf5147a-6a15-4ff1-9c64-9f0176e194f0"
          },
          {
            "type": "plannings",
            "id": "624a1bfa-46bf-4e45-926e-e08b7a5abd9d"
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
      "id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-05-15T13:49:39+00:00",
        "updated_at": "2023-05-15T13:49:40+00:00",
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
        "starts_at": "2023-05-13T13:45:00+00:00",
        "stops_at": "2023-05-17T13:45:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
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
        "start_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d",
        "stop_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d"
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
      "id": "ae8ecc5f-4463-4b5e-82fc-a52bd5e80dfc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-05-15T13:49:40+00:00",
        "updated_at": "2023-05-15T13:49:40+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000012 - red",
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
        "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "item_id": "2e0c68d0-dd80-49e7-aad0-d93c66fba9b2",
        "tax_category_id": null,
        "planning_id": "624a1bfa-46bf-4e45-926e-e08b7a5abd9d",
        "parent_line_id": "1ce7aab3-abbf-4f53-9e06-ab6153953a82",
        "owner_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "1ce7aab3-abbf-4f53-9e06-ab6153953a82",
      "type": "lines",
      "attributes": {
        "created_at": "2023-05-15T13:49:40+00:00",
        "updated_at": "2023-05-15T13:49:40+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
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
        "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "item_id": "cb634ff7-c1df-417f-b530-47ad2262169e",
        "tax_category_id": null,
        "planning_id": "bbf5147a-6a15-4ff1-9c64-9f0176e194f0",
        "parent_line_id": null,
        "owner_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "bbf5147a-6a15-4ff1-9c64-9f0176e194f0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:40+00:00",
        "updated_at": "2023-05-15T13:49:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-05-13T13:45:00+00:00",
        "stops_at": "2023-05-17T13:45:00+00:00",
        "reserved_from": "2023-05-13T13:45:00+00:00",
        "reserved_till": "2023-05-17T13:45:00+00:00",
        "reserved": false,
        "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "item_id": "cb634ff7-c1df-417f-b530-47ad2262169e",
        "start_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d",
        "stop_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "624a1bfa-46bf-4e45-926e-e08b7a5abd9d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-05-15T13:49:40+00:00",
        "updated_at": "2023-05-15T13:49:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-05-13T13:45:00+00:00",
        "stops_at": "2023-05-17T13:45:00+00:00",
        "reserved_from": "2023-05-13T13:45:00+00:00",
        "reserved_till": "2023-05-17T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "6a74690a-1522-4bed-bac2-faa6f99931f6",
        "item_id": "2e0c68d0-dd80-49e7-aad0-d93c66fba9b2",
        "start_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d",
        "stop_location_id": "65be7a97-557a-4bc4-bcba-4cf8199cc32d",
        "parent_planning_id": "bbf5147a-6a15-4ff1-9c64-9f0176e194f0",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





