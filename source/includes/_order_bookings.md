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
          "order_id": "fc9e637f-dd0f-45b0-b89a-6e9cb1b23e76",
          "items": [
            {
              "type": "products",
              "id": "5e4dae74-1478-4c75-85a9-12f4aae709e8",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "eeeea609-1d30-4c32-8160-ad7edf9ce716",
              "stock_item_ids": [
                "1243e1a7-72d7-4448-9411-8a18b8e6158b",
                "b3eceff8-60d8-48f0-aefe-0185e3bff532"
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
            "item_id": "5e4dae74-1478-4c75-85a9-12f4aae709e8",
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
          "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
          "items": [
            {
              "type": "products",
              "id": "93dade92-b84e-440d-a73a-acca4a6b7ed9",
              "stock_item_ids": [
                "97ff7736-fd1f-42af-97b9-e24e93248cb8",
                "8a7e5fe4-9d71-4a1d-85b9-ef4cc1d5d6cb",
                "78299d93-2619-48f2-a571-fec4e8539cbf"
              ]
            },
            {
              "type": "products",
              "id": "8b7a0600-aaba-4db6-9d93-eb5a4b5a8dcf",
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
    "id": "1ae58018-951c-52d0-a195-6dc7f96aafc8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a027a77d-8c08-436e-8976-7cd9a21b8d94"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "481c25c0-5b25-4e00-80d0-b9ec0375c913"
          },
          {
            "type": "lines",
            "id": "e205d11b-af31-47aa-b24a-6567161e025b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6bef219b-9a32-4051-8a22-f95ca8f3b544"
          },
          {
            "type": "plannings",
            "id": "e13d7bb5-0619-47e4-8f6f-02cf7af868a0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dcea1448-c73c-4720-9d03-f304222b1b8d"
          },
          {
            "type": "stock_item_plannings",
            "id": "e864d9a5-2f01-4a05-9c71-9727f3d27278"
          },
          {
            "type": "stock_item_plannings",
            "id": "2e53b15a-b8c9-4122-aa4a-e1e5ecd73fed"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-19T08:47:38+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
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
        "customer_id": "44e97c78-5c5f-4adc-8353-6930a56d69cd",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a",
        "stop_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a"
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
      "id": "481c25c0-5b25-4e00-80d0-b9ec0375c913",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
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
        "item_id": "93dade92-b84e-440d-a73a-acca4a6b7ed9",
        "tax_category_id": "e0f9c96c-20e3-4648-9783-c393749936c9",
        "planning_id": "6bef219b-9a32-4051-8a22-f95ca8f3b544",
        "parent_line_id": null,
        "owner_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
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
      "id": "e205d11b-af31-47aa-b24a-6567161e025b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
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
        "item_id": "8b7a0600-aaba-4db6-9d93-eb5a4b5a8dcf",
        "tax_category_id": "e0f9c96c-20e3-4648-9783-c393749936c9",
        "planning_id": "e13d7bb5-0619-47e4-8f6f-02cf7af868a0",
        "parent_line_id": null,
        "owner_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
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
      "id": "6bef219b-9a32-4051-8a22-f95ca8f3b544",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
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
        "item_id": "93dade92-b84e-440d-a73a-acca4a6b7ed9",
        "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
        "start_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a",
        "stop_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a",
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
      "id": "e13d7bb5-0619-47e4-8f6f-02cf7af868a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
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
        "item_id": "8b7a0600-aaba-4db6-9d93-eb5a4b5a8dcf",
        "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94",
        "start_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a",
        "stop_location_id": "b00e5944-5ef6-4467-bd50-b2258f73181a",
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
      "id": "dcea1448-c73c-4720-9d03-f304222b1b8d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "97ff7736-fd1f-42af-97b9-e24e93248cb8",
        "planning_id": "6bef219b-9a32-4051-8a22-f95ca8f3b544",
        "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94"
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
      "id": "e864d9a5-2f01-4a05-9c71-9727f3d27278",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8a7e5fe4-9d71-4a1d-85b9-ef4cc1d5d6cb",
        "planning_id": "6bef219b-9a32-4051-8a22-f95ca8f3b544",
        "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94"
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
      "id": "2e53b15a-b8c9-4122-aa4a-e1e5ecd73fed",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:40+00:00",
        "updated_at": "2022-12-19T08:47:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "78299d93-2619-48f2-a571-fec4e8539cbf",
        "planning_id": "6bef219b-9a32-4051-8a22-f95ca8f3b544",
        "order_id": "a027a77d-8c08-436e-8976-7cd9a21b8d94"
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
          "order_id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570",
          "items": [
            {
              "type": "bundles",
              "id": "a1c78e5f-1f6a-425a-b661-b19bb5317803",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "cd5c2e85-a124-4b4c-ba2e-b8157f812778",
                  "id": "fbd67606-5a00-4460-b76c-17d5165262a2"
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
    "id": "eb251e72-361c-561e-8c2b-ecb43e9bdffd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6524f8ce-de95-4fbf-a2aa-3637eb0fc744"
          },
          {
            "type": "lines",
            "id": "38bb25bb-f5e1-4cfc-b709-e0b91c1027f2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "834f0390-8838-4fe1-be17-c0b01cbb8541"
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
      "id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-19T08:47:43+00:00",
        "updated_at": "2022-12-19T08:47:44+00:00",
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
        "starts_at": "2022-12-17T08:45:00+00:00",
        "stops_at": "2022-12-21T08:45:00+00:00",
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
        "start_location_id": "750c0959-5023-4a95-ae7d-cf735bec6e15",
        "stop_location_id": "750c0959-5023-4a95-ae7d-cf735bec6e15"
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
      "id": "6524f8ce-de95-4fbf-a2aa-3637eb0fc744",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-19T08:47:44+00:00",
        "updated_at": "2022-12-19T08:47:44+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 9 - red",
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
        "item_id": "fbd67606-5a00-4460-b76c-17d5165262a2",
        "tax_category_id": null,
        "planning_id": "82de2776-34a3-41fa-a49b-1a929585e07d",
        "parent_line_id": "38bb25bb-f5e1-4cfc-b709-e0b91c1027f2",
        "owner_id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570",
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
      "id": "38bb25bb-f5e1-4cfc-b709-e0b91c1027f2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-19T08:47:44+00:00",
        "updated_at": "2022-12-19T08:47:44+00:00",
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
        "item_id": "a1c78e5f-1f6a-425a-b661-b19bb5317803",
        "tax_category_id": null,
        "planning_id": "834f0390-8838-4fe1-be17-c0b01cbb8541",
        "parent_line_id": null,
        "owner_id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570",
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
      "id": "834f0390-8838-4fe1-be17-c0b01cbb8541",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-19T08:47:43+00:00",
        "updated_at": "2022-12-19T08:47:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-12-17T08:45:00+00:00",
        "stops_at": "2022-12-21T08:45:00+00:00",
        "reserved_from": "2022-12-17T08:45:00+00:00",
        "reserved_till": "2022-12-21T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a1c78e5f-1f6a-425a-b661-b19bb5317803",
        "order_id": "5fbeb911-b6e6-4a2a-8d39-d5cb59c06570",
        "start_location_id": "750c0959-5023-4a95-ae7d-cf735bec6e15",
        "stop_location_id": "750c0959-5023-4a95-ae7d-cf735bec6e15",
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





