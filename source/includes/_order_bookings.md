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



> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
          "items": [
            {
              "type": "products",
              "id": "e11e549b-ac52-4ee0-b510-90adc777bb44",
              "stock_item_ids": [
                "1c6a0b9e-348e-41d8-9ba9-8a9982d52035",
                "da8a4c03-666f-4bd5-837a-7aef9c077122",
                "ce036dab-da7b-4d75-be25-bf38bb38248e"
              ]
            },
            {
              "type": "products",
              "id": "2ae0c77a-74df-4849-bd50-e22ebaf2d698",
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
    "id": "2b221685-3b63-5d1c-a66b-bb1801f417a0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "85fd8499-7c02-4e34-813b-e74db2b35ae8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a53084a3-0db7-48e6-b0c6-9fce6ec208d3"
          },
          {
            "type": "lines",
            "id": "f9df88b6-c8b2-442c-aba3-7f03c154605a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "01f01a84-3c90-4253-87be-d0afc238b8cf"
          },
          {
            "type": "plannings",
            "id": "ccbbaa98-5c3d-4e57-90bd-3e1fc21522d6"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1ef63bc3-25c2-4ab4-b9a2-e0a467f9c46a"
          },
          {
            "type": "stock_item_plannings",
            "id": "262f7d3c-259d-4672-8ad6-ab3a620cd6ad"
          },
          {
            "type": "stock_item_plannings",
            "id": "64cca1dc-c1fd-4e67-b17c-77acda6861d3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-26T09:18:51+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
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
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "7bbf0a4a-0498-4d0c-8a0d-c871c896dd1d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095",
        "stop_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095"
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
      "id": "a53084a3-0db7-48e6-b0c6-9fce6ec208d3",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
        "item_id": "e11e549b-ac52-4ee0-b510-90adc777bb44",
        "tax_category_id": "9bd3faeb-340f-4e0e-ba12-04e06eeed535",
        "planning_id": "01f01a84-3c90-4253-87be-d0afc238b8cf",
        "parent_line_id": null,
        "owner_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
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
      "id": "f9df88b6-c8b2-442c-aba3-7f03c154605a",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
        "item_id": "2ae0c77a-74df-4849-bd50-e22ebaf2d698",
        "tax_category_id": "9bd3faeb-340f-4e0e-ba12-04e06eeed535",
        "planning_id": "ccbbaa98-5c3d-4e57-90bd-3e1fc21522d6",
        "parent_line_id": null,
        "owner_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
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
      "id": "01f01a84-3c90-4253-87be-d0afc238b8cf",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
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
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
        "item_id": "e11e549b-ac52-4ee0-b510-90adc777bb44",
        "start_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095",
        "stop_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095",
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
      "id": "ccbbaa98-5c3d-4e57-90bd-3e1fc21522d6",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
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
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8",
        "item_id": "2ae0c77a-74df-4849-bd50-e22ebaf2d698",
        "start_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095",
        "stop_location_id": "66c32111-0e1e-4a17-85a7-de00f752e095",
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
      "id": "1ef63bc3-25c2-4ab4-b9a2-e0a467f9c46a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1c6a0b9e-348e-41d8-9ba9-8a9982d52035",
        "planning_id": "01f01a84-3c90-4253-87be-d0afc238b8cf",
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8"
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
      "id": "262f7d3c-259d-4672-8ad6-ab3a620cd6ad",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "da8a4c03-666f-4bd5-837a-7aef9c077122",
        "planning_id": "01f01a84-3c90-4253-87be-d0afc238b8cf",
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8"
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
      "id": "64cca1dc-c1fd-4e67-b17c-77acda6861d3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:53+00:00",
        "updated_at": "2024-02-26T09:18:53+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ce036dab-da7b-4d75-be25-bf38bb38248e",
        "planning_id": "01f01a84-3c90-4253-87be-d0afc238b8cf",
        "order_id": "85fd8499-7c02-4e34-813b-e74db2b35ae8"
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "4061c5ee-522d-4eed-92a7-a290b7986198",
          "items": [
            {
              "type": "products",
              "id": "f82ce80b-5938-4922-bf6a-9da7e9584a4b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f4631d01-debd-4e45-9791-a9ae6a9a062a",
              "stock_item_ids": [
                "c10b411d-f6dd-4702-a3cb-de9a0569a456",
                "59a80b48-1944-45b6-9e8c-1ce5faf2713b"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id c10b411d-f6dd-4702-a3cb-de9a0569a456 has already been booked on this order"
        ]
      }
    }
  ]
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
          "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
          "items": [
            {
              "type": "bundles",
              "id": "5dce7a8c-2798-4f01-aed7-b4a6237be8df",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2698ea94-501e-4651-b118-7788b29c2c99",
                  "id": "b6e5d7e0-d1d7-44f5-8294-ba2db355fbca"
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
    "id": "e6d6930f-1b53-5dbe-a2d2-4ffecae42181",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "86fba6fa-9254-455e-9303-47467f5ab266"
          },
          {
            "type": "lines",
            "id": "5c522f93-9198-4706-a3a8-1733c7ea340e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "68714e7e-8385-4beb-bdd3-2a2a8cbe5c81"
          },
          {
            "type": "plannings",
            "id": "e388040f-bc28-4bce-b124-201b4f867d18"
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
      "id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
      "type": "orders",
      "attributes": {
        "created_at": "2024-02-26T09:18:59+00:00",
        "updated_at": "2024-02-26T09:18:59+00:00",
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
        "starts_at": "2024-02-24T09:15:00+00:00",
        "stops_at": "2024-02-28T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5",
        "stop_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5"
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
      "id": "86fba6fa-9254-455e-9303-47467f5ab266",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-26T09:18:59+00:00",
        "updated_at": "2024-02-26T09:18:59+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
        "item_id": "5dce7a8c-2798-4f01-aed7-b4a6237be8df",
        "tax_category_id": null,
        "planning_id": "68714e7e-8385-4beb-bdd3-2a2a8cbe5c81",
        "parent_line_id": null,
        "owner_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
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
      "id": "5c522f93-9198-4706-a3a8-1733c7ea340e",
      "type": "lines",
      "attributes": {
        "created_at": "2024-02-26T09:18:59+00:00",
        "updated_at": "2024-02-26T09:18:59+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000058 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
        "item_id": "b6e5d7e0-d1d7-44f5-8294-ba2db355fbca",
        "tax_category_id": null,
        "planning_id": "e388040f-bc28-4bce-b124-201b4f867d18",
        "parent_line_id": "86fba6fa-9254-455e-9303-47467f5ab266",
        "owner_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
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
      "id": "68714e7e-8385-4beb-bdd3-2a2a8cbe5c81",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:59+00:00",
        "updated_at": "2024-02-26T09:18:59+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-24T09:15:00+00:00",
        "stops_at": "2024-02-28T09:15:00+00:00",
        "reserved_from": "2024-02-24T09:15:00+00:00",
        "reserved_till": "2024-02-28T09:15:00+00:00",
        "reserved": false,
        "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
        "item_id": "5dce7a8c-2798-4f01-aed7-b4a6237be8df",
        "start_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5",
        "stop_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5",
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
      "id": "e388040f-bc28-4bce-b124-201b4f867d18",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-02-26T09:18:59+00:00",
        "updated_at": "2024-02-26T09:18:59+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-02-24T09:15:00+00:00",
        "stops_at": "2024-02-28T09:15:00+00:00",
        "reserved_from": "2024-02-24T09:15:00+00:00",
        "reserved_till": "2024-02-28T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "7328860c-7ab1-4f7a-b964-b855ebac7e0e",
        "item_id": "b6e5d7e0-d1d7-44f5-8294-ba2db355fbca",
        "start_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5",
        "stop_location_id": "4af7cc04-43fb-4dc8-8b4e-4bd5771c50d5",
        "parent_planning_id": "68714e7e-8385-4beb-bdd3-2a2a8cbe5c81",
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





