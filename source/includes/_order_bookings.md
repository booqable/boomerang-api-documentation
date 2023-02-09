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
          "order_id": "77730fb3-7ad1-4283-867a-0b0d9fdf8494",
          "items": [
            {
              "type": "products",
              "id": "a3e8f890-7835-471b-8786-156189e4fd0d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "63ec87e1-036d-49bc-adc9-8cb6e9afcb10",
              "stock_item_ids": [
                "06678d20-32e1-44ac-91ab-4df73e31314a",
                "9559a10f-e2e1-47fa-8552-e959d9f22c4e"
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
            "item_id": "a3e8f890-7835-471b-8786-156189e4fd0d",
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
          "order_id": "1a05f742-644b-4689-a190-3aa6261e6038",
          "items": [
            {
              "type": "products",
              "id": "cc75d1c5-8af0-466a-886c-482b911532d3",
              "stock_item_ids": [
                "77468c7c-a5c6-4ea6-948d-4a833bb6b27d",
                "6f3e425d-f7aa-4e0b-a9d0-8d81c4533051",
                "a5fe2f69-69b9-431d-8112-62b58d94ffb0"
              ]
            },
            {
              "type": "products",
              "id": "4dc03b19-4b53-4d44-9717-bd59287b02c1",
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
    "id": "b8f1c6f5-fc2c-5281-9cde-55f27ea14f13",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1a05f742-644b-4689-a190-3aa6261e6038"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1a05f742-644b-4689-a190-3aa6261e6038"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cae99200-216d-4ca0-bfae-553c39d5c462"
          },
          {
            "type": "lines",
            "id": "a04feeff-b2aa-4a8e-98b3-a12930a195e6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c49da249-4180-47cb-b599-eb794f760a93"
          },
          {
            "type": "plannings",
            "id": "bffaa703-6789-4ff6-8d84-d5d7f2562b8d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c439af11-091e-4716-acb5-1c89b66b5e07"
          },
          {
            "type": "stock_item_plannings",
            "id": "555a0b25-a52e-4421-b6d1-5e278975cdd5"
          },
          {
            "type": "stock_item_plannings",
            "id": "ab78a9dc-ec98-4718-9901-0bc58b20ddfa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1a05f742-644b-4689-a190-3aa6261e6038",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T12:17:59+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
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
        "customer_id": "94c8be75-5900-4411-ae52-fd0efa16493d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d",
        "stop_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d"
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
      "id": "cae99200-216d-4ca0-bfae-553c39d5c462",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
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
        "item_id": "cc75d1c5-8af0-466a-886c-482b911532d3",
        "tax_category_id": "14be5182-c529-4066-9d59-eeb08a380be9",
        "planning_id": "c49da249-4180-47cb-b599-eb794f760a93",
        "parent_line_id": null,
        "owner_id": "1a05f742-644b-4689-a190-3aa6261e6038",
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
      "id": "a04feeff-b2aa-4a8e-98b3-a12930a195e6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
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
        "item_id": "4dc03b19-4b53-4d44-9717-bd59287b02c1",
        "tax_category_id": "14be5182-c529-4066-9d59-eeb08a380be9",
        "planning_id": "bffaa703-6789-4ff6-8d84-d5d7f2562b8d",
        "parent_line_id": null,
        "owner_id": "1a05f742-644b-4689-a190-3aa6261e6038",
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
      "id": "c49da249-4180-47cb-b599-eb794f760a93",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
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
        "item_id": "cc75d1c5-8af0-466a-886c-482b911532d3",
        "order_id": "1a05f742-644b-4689-a190-3aa6261e6038",
        "start_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d",
        "stop_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d",
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
      "id": "bffaa703-6789-4ff6-8d84-d5d7f2562b8d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
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
        "item_id": "4dc03b19-4b53-4d44-9717-bd59287b02c1",
        "order_id": "1a05f742-644b-4689-a190-3aa6261e6038",
        "start_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d",
        "stop_location_id": "5f1bf2ab-b8e1-4fc1-b046-dade8d2bef7d",
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
      "id": "c439af11-091e-4716-acb5-1c89b66b5e07",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "77468c7c-a5c6-4ea6-948d-4a833bb6b27d",
        "planning_id": "c49da249-4180-47cb-b599-eb794f760a93",
        "order_id": "1a05f742-644b-4689-a190-3aa6261e6038"
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
      "id": "555a0b25-a52e-4421-b6d1-5e278975cdd5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6f3e425d-f7aa-4e0b-a9d0-8d81c4533051",
        "planning_id": "c49da249-4180-47cb-b599-eb794f760a93",
        "order_id": "1a05f742-644b-4689-a190-3aa6261e6038"
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
      "id": "ab78a9dc-ec98-4718-9901-0bc58b20ddfa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:01+00:00",
        "updated_at": "2023-02-09T12:18:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a5fe2f69-69b9-431d-8112-62b58d94ffb0",
        "planning_id": "c49da249-4180-47cb-b599-eb794f760a93",
        "order_id": "1a05f742-644b-4689-a190-3aa6261e6038"
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
          "order_id": "86ee278d-010f-4aca-b857-e267a536b297",
          "items": [
            {
              "type": "bundles",
              "id": "32b665af-f2c8-4ee5-b55a-8775c7cfe036",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5164ecbf-5035-4aad-8a8d-58e8b02d9ad0",
                  "id": "d186ebd8-61ea-4ab0-92fb-bd7e7530bfd5"
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
    "id": "b44fe436-bd15-57b8-bf94-b0cc750b0ab1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "86ee278d-010f-4aca-b857-e267a536b297"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "86ee278d-010f-4aca-b857-e267a536b297"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2b8c7105-bcb1-4431-b020-918956018a3e"
          },
          {
            "type": "lines",
            "id": "43c3107c-a5d9-4bc3-98f1-2975b4f05634"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2bcbe4ad-fbdf-4ba3-aaee-2ed1f67317d0"
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
      "id": "86ee278d-010f-4aca-b857-e267a536b297",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T12:18:03+00:00",
        "updated_at": "2023-02-09T12:18:04+00:00",
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
        "starts_at": "2023-02-07T12:15:00+00:00",
        "stops_at": "2023-02-11T12:15:00+00:00",
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
        "start_location_id": "b30780a5-ee8c-4596-bdf1-659a91432e14",
        "stop_location_id": "b30780a5-ee8c-4596-bdf1-659a91432e14"
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
      "id": "2b8c7105-bcb1-4431-b020-918956018a3e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:18:04+00:00",
        "updated_at": "2023-02-09T12:18:04+00:00",
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
        "item_id": "32b665af-f2c8-4ee5-b55a-8775c7cfe036",
        "tax_category_id": null,
        "planning_id": "2bcbe4ad-fbdf-4ba3-aaee-2ed1f67317d0",
        "parent_line_id": null,
        "owner_id": "86ee278d-010f-4aca-b857-e267a536b297",
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
      "id": "43c3107c-a5d9-4bc3-98f1-2975b4f05634",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T12:18:04+00:00",
        "updated_at": "2023-02-09T12:18:04+00:00",
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
        "item_id": "d186ebd8-61ea-4ab0-92fb-bd7e7530bfd5",
        "tax_category_id": null,
        "planning_id": "3aab7873-4b0e-489c-8f8a-ddf88102b5b7",
        "parent_line_id": "2b8c7105-bcb1-4431-b020-918956018a3e",
        "owner_id": "86ee278d-010f-4aca-b857-e267a536b297",
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
      "id": "2bcbe4ad-fbdf-4ba3-aaee-2ed1f67317d0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T12:18:04+00:00",
        "updated_at": "2023-02-09T12:18:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T12:15:00+00:00",
        "stops_at": "2023-02-11T12:15:00+00:00",
        "reserved_from": "2023-02-07T12:15:00+00:00",
        "reserved_till": "2023-02-11T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "32b665af-f2c8-4ee5-b55a-8775c7cfe036",
        "order_id": "86ee278d-010f-4aca-b857-e267a536b297",
        "start_location_id": "b30780a5-ee8c-4596-bdf1-659a91432e14",
        "stop_location_id": "b30780a5-ee8c-4596-bdf1-659a91432e14",
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





