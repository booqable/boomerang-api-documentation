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
          "order_id": "4bd346ef-33d2-4f4f-a3b9-a9fa4e265ae5",
          "items": [
            {
              "type": "products",
              "id": "a8236832-6450-49e4-b871-6e75b919439d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0ae77486-1d5b-488f-852f-a7f1b9b2ce9e",
              "stock_item_ids": [
                "73c72758-4362-454b-a2d9-580eea0bc96d",
                "755fc83d-9c2e-4442-bbb2-62bcecab033d"
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
            "item_id": "a8236832-6450-49e4-b871-6e75b919439d",
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
          "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
          "items": [
            {
              "type": "products",
              "id": "19d74b76-4ce4-465e-b3c1-1a60404dae06",
              "stock_item_ids": [
                "e9547b64-18fc-4027-921a-bc510a24f109",
                "a75e847f-48f0-446b-8bbe-0103a36ac5e4",
                "e4b5ab47-6308-422d-97d8-c7c4b817b9ff"
              ]
            },
            {
              "type": "products",
              "id": "be4085b5-ff98-4f8b-a4ea-c7d48e59f9b0",
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
    "id": "7ab8ffd6-8f51-57a3-8397-5b18fac799c4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b476e461-087e-4816-8758-3ffe2aeb8894"
          },
          {
            "type": "lines",
            "id": "a2b2749c-ecfb-4d62-bf8f-b6dd52dc1ee9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "13275779-c2ca-432a-9c06-918e26f12b36"
          },
          {
            "type": "plannings",
            "id": "2657b19c-d2d0-4809-a88c-a4149e20f400"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "413124df-fc9b-4772-87c7-4cfb8f5892a7"
          },
          {
            "type": "stock_item_plannings",
            "id": "0e0a23fb-538d-4c63-8863-817e79245770"
          },
          {
            "type": "stock_item_plannings",
            "id": "b80c09a0-a630-4765-b459-9428ed881f51"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-12T18:25:57+00:00",
        "updated_at": "2022-04-12T18:25:59+00:00",
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
        "customer_id": "5fa6093e-9cb8-407f-9e0f-5e6ba6b710d4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04",
        "stop_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04"
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
      "id": "b476e461-087e-4816-8758-3ffe2aeb8894",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:59+00:00",
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
        "item_id": "be4085b5-ff98-4f8b-a4ea-c7d48e59f9b0",
        "tax_category_id": "c0e3d257-26c2-4378-adfd-95591438f0a5",
        "planning_id": "13275779-c2ca-432a-9c06-918e26f12b36",
        "parent_line_id": null,
        "owner_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
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
      "id": "a2b2749c-ecfb-4d62-bf8f-b6dd52dc1ee9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:59+00:00",
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
        "item_id": "19d74b76-4ce4-465e-b3c1-1a60404dae06",
        "tax_category_id": "c0e3d257-26c2-4378-adfd-95591438f0a5",
        "planning_id": "2657b19c-d2d0-4809-a88c-a4149e20f400",
        "parent_line_id": null,
        "owner_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
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
      "id": "13275779-c2ca-432a-9c06-918e26f12b36",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:59+00:00",
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
        "item_id": "be4085b5-ff98-4f8b-a4ea-c7d48e59f9b0",
        "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
        "start_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04",
        "stop_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04",
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
      "id": "2657b19c-d2d0-4809-a88c-a4149e20f400",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:59+00:00",
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
        "item_id": "19d74b76-4ce4-465e-b3c1-1a60404dae06",
        "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35",
        "start_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04",
        "stop_location_id": "ce30700f-4ee3-4367-8541-890eecc63a04",
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
      "id": "413124df-fc9b-4772-87c7-4cfb8f5892a7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e9547b64-18fc-4027-921a-bc510a24f109",
        "planning_id": "2657b19c-d2d0-4809-a88c-a4149e20f400",
        "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35"
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
      "id": "0e0a23fb-538d-4c63-8863-817e79245770",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a75e847f-48f0-446b-8bbe-0103a36ac5e4",
        "planning_id": "2657b19c-d2d0-4809-a88c-a4149e20f400",
        "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35"
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
      "id": "b80c09a0-a630-4765-b459-9428ed881f51",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-12T18:25:58+00:00",
        "updated_at": "2022-04-12T18:25:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e4b5ab47-6308-422d-97d8-c7c4b817b9ff",
        "planning_id": "2657b19c-d2d0-4809-a88c-a4149e20f400",
        "order_id": "fb48b2cc-65ef-451e-90e3-04a81b22ce35"
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
          "order_id": "1f41dc84-aad2-443a-942e-cfce7d555177",
          "items": [
            {
              "type": "bundles",
              "id": "a45bf0dd-b9db-4bba-a81e-876bdd95e18a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "104fe1e4-3b0a-43b1-bb67-ef72516426a6",
                  "id": "71ef591b-e325-4f33-9479-5af63750d77c"
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
    "id": "68a84f56-1c2f-56a7-8712-02d322caa6d2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1f41dc84-aad2-443a-942e-cfce7d555177"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1f41dc84-aad2-443a-942e-cfce7d555177"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fa16db56-4ee3-41e8-9d01-b15606b1b2e5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b578a412-6fde-4e51-86df-e597938f37e3"
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
      "id": "1f41dc84-aad2-443a-942e-cfce7d555177",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-12T18:26:01+00:00",
        "updated_at": "2022-04-12T18:26:02+00:00",
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
        "starts_at": "2022-04-10T18:15:00+00:00",
        "stops_at": "2022-04-14T18:15:00+00:00",
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
        "start_location_id": "604076e3-385e-4518-a3ae-9a10daae1447",
        "stop_location_id": "604076e3-385e-4518-a3ae-9a10daae1447"
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
      "id": "fa16db56-4ee3-41e8-9d01-b15606b1b2e5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-12T18:26:01+00:00",
        "updated_at": "2022-04-12T18:26:01+00:00",
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
        "item_id": "a45bf0dd-b9db-4bba-a81e-876bdd95e18a",
        "tax_category_id": null,
        "planning_id": "b578a412-6fde-4e51-86df-e597938f37e3",
        "parent_line_id": null,
        "owner_id": "1f41dc84-aad2-443a-942e-cfce7d555177",
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
      "id": "b578a412-6fde-4e51-86df-e597938f37e3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-12T18:26:01+00:00",
        "updated_at": "2022-04-12T18:26:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-10T18:15:00+00:00",
        "stops_at": "2022-04-14T18:15:00+00:00",
        "reserved_from": "2022-04-10T18:15:00+00:00",
        "reserved_till": "2022-04-14T18:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a45bf0dd-b9db-4bba-a81e-876bdd95e18a",
        "order_id": "1f41dc84-aad2-443a-942e-cfce7d555177",
        "start_location_id": "604076e3-385e-4518-a3ae-9a10daae1447",
        "stop_location_id": "604076e3-385e-4518-a3ae-9a10daae1447",
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





