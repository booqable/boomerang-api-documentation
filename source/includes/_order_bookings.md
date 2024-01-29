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
          "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
          "items": [
            {
              "type": "products",
              "id": "55770f6b-a165-42f1-9d16-e00f504b01bb",
              "stock_item_ids": [
                "eb545214-74ff-48c9-980d-3667073d5977",
                "93802839-b30f-4dcc-8779-0caea21641e4",
                "fbe49349-fe4b-4fa5-b60b-d90d560f914c"
              ]
            },
            {
              "type": "products",
              "id": "d54308c4-d3f0-4899-921e-92459d0c36f7",
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
    "id": "98384b9d-05b9-5590-9482-b99a8059d890",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e5c8d680-fe9f-4fb8-9965-239c37050187"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "baa72066-34c2-4540-9d6f-f15730699681"
          },
          {
            "type": "lines",
            "id": "a3ea97ea-4924-4804-9405-851c4dcbfd17"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad"
          },
          {
            "type": "plannings",
            "id": "56b1010e-4114-438f-a23e-a1f8d071f233"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "998f081d-ff37-4913-abba-6c68fb96d12e"
          },
          {
            "type": "stock_item_plannings",
            "id": "e8ae4001-d388-446c-abb5-ff680d8c5d19"
          },
          {
            "type": "stock_item_plannings",
            "id": "2baf4b8c-2821-4512-a7fd-24b53503c391"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-29T09:20:15+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
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
        "customer_id": "cd8324c9-cbcd-4ac5-a669-0777a0466587",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2",
        "stop_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2"
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
      "id": "baa72066-34c2-4540-9d6f-f15730699681",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
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
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
        "item_id": "55770f6b-a165-42f1-9d16-e00f504b01bb",
        "tax_category_id": "72fc935f-8ea2-45f3-b8d3-58dbb7a673ef",
        "planning_id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad",
        "parent_line_id": null,
        "owner_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
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
      "id": "a3ea97ea-4924-4804-9405-851c4dcbfd17",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
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
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
        "item_id": "d54308c4-d3f0-4899-921e-92459d0c36f7",
        "tax_category_id": "72fc935f-8ea2-45f3-b8d3-58dbb7a673ef",
        "planning_id": "56b1010e-4114-438f-a23e-a1f8d071f233",
        "parent_line_id": null,
        "owner_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
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
      "id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
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
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
        "item_id": "55770f6b-a165-42f1-9d16-e00f504b01bb",
        "start_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2",
        "stop_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2",
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
      "id": "56b1010e-4114-438f-a23e-a1f8d071f233",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
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
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187",
        "item_id": "d54308c4-d3f0-4899-921e-92459d0c36f7",
        "start_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2",
        "stop_location_id": "aeb1b6d6-1944-4aa4-b03c-2de58976a9b2",
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
      "id": "998f081d-ff37-4913-abba-6c68fb96d12e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eb545214-74ff-48c9-980d-3667073d5977",
        "planning_id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad",
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187"
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
      "id": "e8ae4001-d388-446c-abb5-ff680d8c5d19",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "93802839-b30f-4dcc-8779-0caea21641e4",
        "planning_id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad",
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187"
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
      "id": "2baf4b8c-2821-4512-a7fd-24b53503c391",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:17+00:00",
        "updated_at": "2024-01-29T09:20:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fbe49349-fe4b-4fa5-b60b-d90d560f914c",
        "planning_id": "6d6e37e1-fbae-4e48-9089-72c26ac378ad",
        "order_id": "e5c8d680-fe9f-4fb8-9965-239c37050187"
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
          "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
          "items": [
            {
              "type": "bundles",
              "id": "d087d2ef-27d2-4710-8348-6599a77645fe",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "da477ad9-bd88-4b94-ad51-778868797f7e",
                  "id": "2a395373-36e0-4126-92f2-a79dbacec508"
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
    "id": "c1fc3463-1043-58c0-84a1-edf63bb1024e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "55cac51a-043c-461b-8446-46ed1ea8cbfb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "56336bd3-1201-4eac-af17-8e16fc33bfca"
          },
          {
            "type": "lines",
            "id": "380826df-697f-4c72-8a5b-e83f90eac9bb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e97d6453-6298-41d1-bbc3-ac9024051b94"
          },
          {
            "type": "plannings",
            "id": "622c998c-a0e2-4c0f-8f9f-bea7c13796d7"
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
      "id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-29T09:20:20+00:00",
        "updated_at": "2024-01-29T09:20:21+00:00",
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
        "starts_at": "2024-01-27T09:15:00+00:00",
        "stops_at": "2024-01-31T09:15:00+00:00",
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
        "start_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f",
        "stop_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f"
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
      "id": "56336bd3-1201-4eac-af17-8e16fc33bfca",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-29T09:20:21+00:00",
        "updated_at": "2024-01-29T09:20:21+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000065 - red",
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
        "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
        "item_id": "2a395373-36e0-4126-92f2-a79dbacec508",
        "tax_category_id": null,
        "planning_id": "622c998c-a0e2-4c0f-8f9f-bea7c13796d7",
        "parent_line_id": "380826df-697f-4c72-8a5b-e83f90eac9bb",
        "owner_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
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
      "id": "380826df-697f-4c72-8a5b-e83f90eac9bb",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-29T09:20:21+00:00",
        "updated_at": "2024-01-29T09:20:21+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 5",
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
        "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
        "item_id": "d087d2ef-27d2-4710-8348-6599a77645fe",
        "tax_category_id": null,
        "planning_id": "e97d6453-6298-41d1-bbc3-ac9024051b94",
        "parent_line_id": null,
        "owner_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
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
      "id": "e97d6453-6298-41d1-bbc3-ac9024051b94",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:20+00:00",
        "updated_at": "2024-01-29T09:20:20+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-27T09:15:00+00:00",
        "stops_at": "2024-01-31T09:15:00+00:00",
        "reserved_from": "2024-01-27T09:15:00+00:00",
        "reserved_till": "2024-01-31T09:15:00+00:00",
        "reserved": false,
        "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
        "item_id": "d087d2ef-27d2-4710-8348-6599a77645fe",
        "start_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f",
        "stop_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f",
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
      "id": "622c998c-a0e2-4c0f-8f9f-bea7c13796d7",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-29T09:20:20+00:00",
        "updated_at": "2024-01-29T09:20:20+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-01-27T09:15:00+00:00",
        "stops_at": "2024-01-31T09:15:00+00:00",
        "reserved_from": "2024-01-27T09:15:00+00:00",
        "reserved_till": "2024-01-31T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "55cac51a-043c-461b-8446-46ed1ea8cbfb",
        "item_id": "2a395373-36e0-4126-92f2-a79dbacec508",
        "start_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f",
        "stop_location_id": "5d8162ab-69d1-4c9a-a086-8fe63cb0838f",
        "parent_planning_id": "e97d6453-6298-41d1-bbc3-ac9024051b94",
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "06782594-71d9-4046-8406-8930b246501b",
          "items": [
            {
              "type": "products",
              "id": "e16187a2-dc3f-46a3-a431-49f19e027357",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "df50b61e-32ec-4a07-b095-966a9f7e36f5",
              "stock_item_ids": [
                "3d43a1d5-175a-4014-846a-5d80c0820ac4",
                "10ba0b3d-c11c-4357-befe-2e5437fe4ddc"
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
          "stock_item_id 3d43a1d5-175a-4014-846a-5d80c0820ac4 has already been booked on this order"
        ]
      }
    }
  ]
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





