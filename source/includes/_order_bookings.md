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
          "order_id": "eb41ff66-23c5-4874-aa36-ae95bcb9f9e4",
          "items": [
            {
              "type": "products",
              "id": "e695d2d6-69a1-4c0b-bb6f-1f39dc7d7c99",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0798baf1-2edd-4a0c-a363-b6c78fd4fe74",
              "stock_item_ids": [
                "1f4bd777-92cf-407f-a889-8ae90cf1974a",
                "d01831ee-588e-4bd9-91d9-6e53ca28d5fd"
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
            "item_id": "e695d2d6-69a1-4c0b-bb6f-1f39dc7d7c99",
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
          "order_id": "67d96c55-62ea-4147-8960-699b39336f9c",
          "items": [
            {
              "type": "products",
              "id": "4c2fd222-222f-463c-8448-9150ba8bc96c",
              "stock_item_ids": [
                "f8f28bae-b36c-4305-8b4a-fdd45c3a3f84",
                "8e8f9a6c-18cc-4130-a18a-48834553fe29",
                "883eab0f-c630-4890-9790-be3d2b1a654d"
              ]
            },
            {
              "type": "products",
              "id": "4a2d3d2e-b4f9-488e-86da-d5becaf76dd8",
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
    "id": "1d743ff1-3920-599f-8a2b-46d0a9f438ee",
    "type": "order_bookings",
    "attributes": {
      "order_id": "67d96c55-62ea-4147-8960-699b39336f9c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "67d96c55-62ea-4147-8960-699b39336f9c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "451941fc-98e2-4e83-9e98-f8c2be0283e7"
          },
          {
            "type": "lines",
            "id": "515e2602-c855-41f2-8d14-43504f180594"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3f15997e-4162-4cfb-867f-fb229e0600ee"
          },
          {
            "type": "plannings",
            "id": "20ba23d1-0e94-48e6-bc7e-255653001020"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ac141eab-d70b-418e-a3fd-6acc9f18fd69"
          },
          {
            "type": "stock_item_plannings",
            "id": "aec2eda3-a7b1-4fe4-98e0-3ee69421621f"
          },
          {
            "type": "stock_item_plannings",
            "id": "32aa216f-8794-4b62-b694-01d40e6cae87"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "67d96c55-62ea-4147-8960-699b39336f9c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-17T11:34:22+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
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
        "customer_id": "bc12a1da-58f2-4a36-8314-81fa67282787",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539",
        "stop_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539"
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
      "id": "451941fc-98e2-4e83-9e98-f8c2be0283e7",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-17T11:34:24+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
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
        "item_id": "4c2fd222-222f-463c-8448-9150ba8bc96c",
        "tax_category_id": "bdd70370-f0de-4a43-a7de-7c9f7755a75f",
        "planning_id": "3f15997e-4162-4cfb-867f-fb229e0600ee",
        "parent_line_id": null,
        "owner_id": "67d96c55-62ea-4147-8960-699b39336f9c",
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
      "id": "515e2602-c855-41f2-8d14-43504f180594",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-17T11:34:24+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
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
        "item_id": "4a2d3d2e-b4f9-488e-86da-d5becaf76dd8",
        "tax_category_id": "bdd70370-f0de-4a43-a7de-7c9f7755a75f",
        "planning_id": "20ba23d1-0e94-48e6-bc7e-255653001020",
        "parent_line_id": null,
        "owner_id": "67d96c55-62ea-4147-8960-699b39336f9c",
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
      "id": "3f15997e-4162-4cfb-867f-fb229e0600ee",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:23+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
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
        "item_id": "4c2fd222-222f-463c-8448-9150ba8bc96c",
        "order_id": "67d96c55-62ea-4147-8960-699b39336f9c",
        "start_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539",
        "stop_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539",
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
      "id": "20ba23d1-0e94-48e6-bc7e-255653001020",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:23+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
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
        "item_id": "4a2d3d2e-b4f9-488e-86da-d5becaf76dd8",
        "order_id": "67d96c55-62ea-4147-8960-699b39336f9c",
        "start_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539",
        "stop_location_id": "6892e48a-40cf-48d8-86f7-e86a490c3539",
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
      "id": "ac141eab-d70b-418e-a3fd-6acc9f18fd69",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:23+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f8f28bae-b36c-4305-8b4a-fdd45c3a3f84",
        "planning_id": "3f15997e-4162-4cfb-867f-fb229e0600ee",
        "order_id": "67d96c55-62ea-4147-8960-699b39336f9c"
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
      "id": "aec2eda3-a7b1-4fe4-98e0-3ee69421621f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:23+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e8f9a6c-18cc-4130-a18a-48834553fe29",
        "planning_id": "3f15997e-4162-4cfb-867f-fb229e0600ee",
        "order_id": "67d96c55-62ea-4147-8960-699b39336f9c"
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
      "id": "32aa216f-8794-4b62-b694-01d40e6cae87",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:23+00:00",
        "updated_at": "2022-11-17T11:34:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "883eab0f-c630-4890-9790-be3d2b1a654d",
        "planning_id": "3f15997e-4162-4cfb-867f-fb229e0600ee",
        "order_id": "67d96c55-62ea-4147-8960-699b39336f9c"
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
          "order_id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e",
          "items": [
            {
              "type": "bundles",
              "id": "58627bc8-5e70-4cfe-a8de-36bc175d98f0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5db6779b-74d6-4b62-bf46-ac0434c1ac48",
                  "id": "97144a20-acc5-47c1-b3c1-a455f0147f4c"
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
    "id": "642788ba-0538-5730-91e5-9234d9412de0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "60e03727-01fa-49d5-b460-905a27a60b7b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7d73203b-f12e-484e-8146-1851a4836032"
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
      "id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-17T11:34:27+00:00",
        "updated_at": "2022-11-17T11:34:28+00:00",
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
        "starts_at": "2022-11-15T11:30:00+00:00",
        "stops_at": "2022-11-19T11:30:00+00:00",
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
        "start_location_id": "553ec4ad-47fd-4a6e-8462-e408d2a43629",
        "stop_location_id": "553ec4ad-47fd-4a6e-8462-e408d2a43629"
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
      "id": "60e03727-01fa-49d5-b460-905a27a60b7b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-17T11:34:27+00:00",
        "updated_at": "2022-11-17T11:34:28+00:00",
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
        "item_id": "58627bc8-5e70-4cfe-a8de-36bc175d98f0",
        "tax_category_id": null,
        "planning_id": "7d73203b-f12e-484e-8146-1851a4836032",
        "parent_line_id": null,
        "owner_id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e",
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
      "id": "7d73203b-f12e-484e-8146-1851a4836032",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-17T11:34:27+00:00",
        "updated_at": "2022-11-17T11:34:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-15T11:30:00+00:00",
        "stops_at": "2022-11-19T11:30:00+00:00",
        "reserved_from": "2022-11-15T11:30:00+00:00",
        "reserved_till": "2022-11-19T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "58627bc8-5e70-4cfe-a8de-36bc175d98f0",
        "order_id": "0b29f6a7-6989-4cf0-95ed-3cd269b1411e",
        "start_location_id": "553ec4ad-47fd-4a6e-8462-e408d2a43629",
        "stop_location_id": "553ec4ad-47fd-4a6e-8462-e408d2a43629",
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





