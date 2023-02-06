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
          "order_id": "05badf25-83ed-4c9c-a737-540e82a6d8f8",
          "items": [
            {
              "type": "products",
              "id": "762ee9f5-863d-4016-befa-be38aede3ea2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "98d69185-1ff1-4bc1-bda8-ce89fd57cbe9",
              "stock_item_ids": [
                "5adad9bb-44b0-468e-85a1-5ec41b419856",
                "3b9161b4-dca8-4a0d-9531-b75c3c2551b7"
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
            "item_id": "762ee9f5-863d-4016-befa-be38aede3ea2",
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
          "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
          "items": [
            {
              "type": "products",
              "id": "52d554d4-61e5-42e0-b716-89534aa81524",
              "stock_item_ids": [
                "61370365-2c06-4557-a635-95a65bfe8105",
                "f34682a0-f4c2-4d28-af27-ee6da5c01445",
                "7a380308-1c06-4073-a38b-d018d2faabcf"
              ]
            },
            {
              "type": "products",
              "id": "3d3218c1-e810-4218-bea8-3ba588cee784",
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
    "id": "8b023f51-cd64-53a8-b44d-46dc280f56b2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6cb77976-80f7-4081-ae9c-e2be1c804413"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ede1fbae-819a-4379-9ac2-89335b7f496d"
          },
          {
            "type": "lines",
            "id": "50415e85-af97-4da1-9ecc-039ea80a04bd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0"
          },
          {
            "type": "plannings",
            "id": "560952d8-fce8-4128-97b8-c25b97395e66"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "644b995d-dcd1-44d3-bfc1-8f5840bce6b1"
          },
          {
            "type": "stock_item_plannings",
            "id": "bc225a81-d645-46c3-abb2-5993236df6e9"
          },
          {
            "type": "stock_item_plannings",
            "id": "97d4b3f7-5527-4ccb-b37e-b6a389a61465"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T18:58:38+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
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
        "customer_id": "188e6753-d167-470e-ac8b-6f78e5c3d2e6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078",
        "stop_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078"
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
      "id": "ede1fbae-819a-4379-9ac2-89335b7f496d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
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
        "item_id": "52d554d4-61e5-42e0-b716-89534aa81524",
        "tax_category_id": "be651d13-c326-4d27-abed-068016561d33",
        "planning_id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0",
        "parent_line_id": null,
        "owner_id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
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
      "id": "50415e85-af97-4da1-9ecc-039ea80a04bd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
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
        "item_id": "3d3218c1-e810-4218-bea8-3ba588cee784",
        "tax_category_id": "be651d13-c326-4d27-abed-068016561d33",
        "planning_id": "560952d8-fce8-4128-97b8-c25b97395e66",
        "parent_line_id": null,
        "owner_id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
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
      "id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
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
        "item_id": "52d554d4-61e5-42e0-b716-89534aa81524",
        "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
        "start_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078",
        "stop_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078",
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
      "id": "560952d8-fce8-4128-97b8-c25b97395e66",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
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
        "item_id": "3d3218c1-e810-4218-bea8-3ba588cee784",
        "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413",
        "start_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078",
        "stop_location_id": "c8b4f4ab-9445-4c14-8d02-aa2d979ff078",
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
      "id": "644b995d-dcd1-44d3-bfc1-8f5840bce6b1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "61370365-2c06-4557-a635-95a65bfe8105",
        "planning_id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0",
        "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413"
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
      "id": "bc225a81-d645-46c3-abb2-5993236df6e9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f34682a0-f4c2-4d28-af27-ee6da5c01445",
        "planning_id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0",
        "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413"
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
      "id": "97d4b3f7-5527-4ccb-b37e-b6a389a61465",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:39+00:00",
        "updated_at": "2023-02-06T18:58:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7a380308-1c06-4073-a38b-d018d2faabcf",
        "planning_id": "8b3c720b-d483-4140-8f6f-213c3aac1ca0",
        "order_id": "6cb77976-80f7-4081-ae9c-e2be1c804413"
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
          "order_id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc",
          "items": [
            {
              "type": "bundles",
              "id": "94acd432-0799-4973-b1b9-0d01cf662020",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ce0ac887-5935-4e39-ad48-5bb0b5ee4a9c",
                  "id": "0a36fd0b-9e00-439f-824c-197cffd34e23"
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
    "id": "8b77dedd-62f3-5450-ab50-d4e305d92c50",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6dafba2b-6ee1-4f8b-a75b-9b51772eb10e"
          },
          {
            "type": "lines",
            "id": "641668da-321f-4825-8b03-e20b708624c7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4bdd1c80-10a0-4c33-8704-cd1509c4dc3c"
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
      "id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T18:58:41+00:00",
        "updated_at": "2023-02-06T18:58:42+00:00",
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
        "starts_at": "2023-02-04T18:45:00+00:00",
        "stops_at": "2023-02-08T18:45:00+00:00",
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
        "start_location_id": "6c6cc0de-a270-43b5-a19e-82d1af176ed7",
        "stop_location_id": "6c6cc0de-a270-43b5-a19e-82d1af176ed7"
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
      "id": "6dafba2b-6ee1-4f8b-a75b-9b51772eb10e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T18:58:42+00:00",
        "updated_at": "2023-02-06T18:58:42+00:00",
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
        "item_id": "94acd432-0799-4973-b1b9-0d01cf662020",
        "tax_category_id": null,
        "planning_id": "4bdd1c80-10a0-4c33-8704-cd1509c4dc3c",
        "parent_line_id": null,
        "owner_id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc",
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
      "id": "641668da-321f-4825-8b03-e20b708624c7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T18:58:42+00:00",
        "updated_at": "2023-02-06T18:58:42+00:00",
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
        "item_id": "0a36fd0b-9e00-439f-824c-197cffd34e23",
        "tax_category_id": null,
        "planning_id": "a4a48b52-f24c-4418-9dd4-8436afd57ef0",
        "parent_line_id": "6dafba2b-6ee1-4f8b-a75b-9b51772eb10e",
        "owner_id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc",
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
      "id": "4bdd1c80-10a0-4c33-8704-cd1509c4dc3c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T18:58:42+00:00",
        "updated_at": "2023-02-06T18:58:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-04T18:45:00+00:00",
        "stops_at": "2023-02-08T18:45:00+00:00",
        "reserved_from": "2023-02-04T18:45:00+00:00",
        "reserved_till": "2023-02-08T18:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "94acd432-0799-4973-b1b9-0d01cf662020",
        "order_id": "a3dcda2d-9ffc-4087-a5cc-3e6a3f060acc",
        "start_location_id": "6c6cc0de-a270-43b5-a19e-82d1af176ed7",
        "stop_location_id": "6c6cc0de-a270-43b5-a19e-82d1af176ed7",
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





