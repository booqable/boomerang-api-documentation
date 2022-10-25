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
          "order_id": "a5cf3ac4-c15a-464b-86c5-4c73f991f7b7",
          "items": [
            {
              "type": "products",
              "id": "b496f62d-fe71-4425-bcea-bef696f9dab3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b409c099-6081-4af8-b48d-b4382a2fcaf5",
              "stock_item_ids": [
                "157823fb-2a03-4dad-b542-44bf09820654",
                "719ebf26-5d70-4ba6-b407-1a8e1247b4c2"
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
            "item_id": "b496f62d-fe71-4425-bcea-bef696f9dab3",
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
          "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
          "items": [
            {
              "type": "products",
              "id": "1f5e6604-a89b-43fe-9883-e8442de40004",
              "stock_item_ids": [
                "8d437414-88c9-4691-99f4-385d36d4638f",
                "b99c8a7c-9383-4f05-9193-a689855622de",
                "1055c610-70a7-4f83-a016-2ba50b168e4c"
              ]
            },
            {
              "type": "products",
              "id": "7edcac8d-69e3-4587-8d1d-a78fa1a751dc",
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
    "id": "5bdfdf37-20c5-597a-8f20-5ebad56d36b7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c3f3bce9-3098-492e-a85b-3d8334db1509"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5875e1b8-e0df-4289-a914-4664eb031289"
          },
          {
            "type": "lines",
            "id": "09e8c5de-d3e5-4dec-a13f-091dadfe3e7a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407"
          },
          {
            "type": "plannings",
            "id": "a1745ed3-682f-40e2-80e7-04366b5d9765"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "97ee13c2-f1d4-46aa-a821-506cdbf1896a"
          },
          {
            "type": "stock_item_plannings",
            "id": "410cc0ab-a938-4027-8e0c-60d415f1819f"
          },
          {
            "type": "stock_item_plannings",
            "id": "e652417a-1311-42cf-99de-d9d759a6c171"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T15:53:38+00:00",
        "updated_at": "2022-10-25T15:53:40+00:00",
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
        "customer_id": "d9eef0b9-e128-4783-9c79-b4582983a7fb",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0",
        "stop_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0"
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
      "id": "5875e1b8-e0df-4289-a914-4664eb031289",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
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
        "item_id": "1f5e6604-a89b-43fe-9883-e8442de40004",
        "tax_category_id": "a4e613d4-6ae7-4416-a8a4-f2d2348a5076",
        "planning_id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407",
        "parent_line_id": null,
        "owner_id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
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
      "id": "09e8c5de-d3e5-4dec-a13f-091dadfe3e7a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
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
        "item_id": "7edcac8d-69e3-4587-8d1d-a78fa1a751dc",
        "tax_category_id": "a4e613d4-6ae7-4416-a8a4-f2d2348a5076",
        "planning_id": "a1745ed3-682f-40e2-80e7-04366b5d9765",
        "parent_line_id": null,
        "owner_id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
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
      "id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
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
        "item_id": "1f5e6604-a89b-43fe-9883-e8442de40004",
        "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
        "start_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0",
        "stop_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0",
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
      "id": "a1745ed3-682f-40e2-80e7-04366b5d9765",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
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
        "item_id": "7edcac8d-69e3-4587-8d1d-a78fa1a751dc",
        "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509",
        "start_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0",
        "stop_location_id": "6598960f-03fa-41cf-b9fe-846a076544b0",
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
      "id": "97ee13c2-f1d4-46aa-a821-506cdbf1896a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8d437414-88c9-4691-99f4-385d36d4638f",
        "planning_id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407",
        "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509"
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
      "id": "410cc0ab-a938-4027-8e0c-60d415f1819f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b99c8a7c-9383-4f05-9193-a689855622de",
        "planning_id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407",
        "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509"
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
      "id": "e652417a-1311-42cf-99de-d9d759a6c171",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:39+00:00",
        "updated_at": "2022-10-25T15:53:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1055c610-70a7-4f83-a016-2ba50b168e4c",
        "planning_id": "c718f7e7-5b5f-41fb-9185-31e9df1ed407",
        "order_id": "c3f3bce9-3098-492e-a85b-3d8334db1509"
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
          "order_id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd",
          "items": [
            {
              "type": "bundles",
              "id": "56f9dcb2-8e39-45ee-b7dd-ede606d10a65",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fa71e06a-d712-4524-8144-65728ba27c34",
                  "id": "01356077-23a5-4181-aa89-850fd8faf248"
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
    "id": "a45bdd88-7f8f-55eb-8ead-a40d00362d25",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "634ec720-899e-4913-9c73-2af7e13f911c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f98d79c1-f11f-41f4-840e-1d6f889bdc97"
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
      "id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T15:53:41+00:00",
        "updated_at": "2022-10-25T15:53:42+00:00",
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
        "starts_at": "2022-10-23T15:45:00+00:00",
        "stops_at": "2022-10-27T15:45:00+00:00",
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
        "start_location_id": "6ba8def4-12eb-4305-a520-db962768e018",
        "stop_location_id": "6ba8def4-12eb-4305-a520-db962768e018"
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
      "id": "634ec720-899e-4913-9c73-2af7e13f911c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T15:53:42+00:00",
        "updated_at": "2022-10-25T15:53:42+00:00",
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
        "item_id": "56f9dcb2-8e39-45ee-b7dd-ede606d10a65",
        "tax_category_id": null,
        "planning_id": "f98d79c1-f11f-41f4-840e-1d6f889bdc97",
        "parent_line_id": null,
        "owner_id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd",
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
      "id": "f98d79c1-f11f-41f4-840e-1d6f889bdc97",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T15:53:42+00:00",
        "updated_at": "2022-10-25T15:53:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T15:45:00+00:00",
        "stops_at": "2022-10-27T15:45:00+00:00",
        "reserved_from": "2022-10-23T15:45:00+00:00",
        "reserved_till": "2022-10-27T15:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "56f9dcb2-8e39-45ee-b7dd-ede606d10a65",
        "order_id": "6ba304c7-9cbe-46d9-b207-bd90fe2ab5bd",
        "start_location_id": "6ba8def4-12eb-4305-a520-db962768e018",
        "stop_location_id": "6ba8def4-12eb-4305-a520-db962768e018",
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





