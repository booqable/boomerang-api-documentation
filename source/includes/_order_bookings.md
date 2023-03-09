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
          "order_id": "34b55e1a-20bc-4317-b1b6-0426bd58f7aa",
          "items": [
            {
              "type": "products",
              "id": "c5d32564-903f-400b-8a11-b31cb656d582",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6f7d4e10-050b-4f58-8681-54b6529d3313",
              "stock_item_ids": [
                "66924f0f-1ade-451a-a61a-3aa7db7e0305",
                "a85e5f1a-12ec-48d7-8ee6-491fea6460d7"
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
          "stock_item_id 66924f0f-1ade-451a-a61a-3aa7db7e0305 has already been booked on this order"
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
          "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237",
          "items": [
            {
              "type": "products",
              "id": "449f7e6e-d659-4247-b02a-88e9251d48fb",
              "stock_item_ids": [
                "50ab9845-26d5-4692-a0cd-a266a4cc852b",
                "2fe21c18-726f-42c5-a3a7-791bcf6065ce",
                "eee05a2e-eff5-4a96-9f40-9048ae5f2621"
              ]
            },
            {
              "type": "products",
              "id": "aff68a29-5e37-43b9-8964-dcae4b0a5286",
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
    "id": "966a60a2-e103-54bd-ac4a-f28c663cad8a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "17a292cd-21f6-41b9-836a-6beae2c63237"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "93042bcd-71e2-4fff-9239-bcdf1d3020e0"
          },
          {
            "type": "lines",
            "id": "8ce70bec-8e40-4551-a6e5-10db10b95fb0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5"
          },
          {
            "type": "plannings",
            "id": "30a634d3-6a19-405d-be88-07953088592d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a2da8e19-832e-4837-8a2e-f408d88aa3bc"
          },
          {
            "type": "stock_item_plannings",
            "id": "54f58332-93ce-4c94-8457-fb529e4156e1"
          },
          {
            "type": "stock_item_plannings",
            "id": "0b5a79a8-2d1a-443f-a504-478ceca9e1c1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "17a292cd-21f6-41b9-836a-6beae2c63237",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T13:50:28+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
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
        "customer_id": "1883837b-cfa9-4605-a51c-b4656e59c173",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed",
        "stop_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed"
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
      "id": "93042bcd-71e2-4fff-9239-bcdf1d3020e0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
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
        "item_id": "449f7e6e-d659-4247-b02a-88e9251d48fb",
        "tax_category_id": "8225165d-3928-4483-b17e-ee79c883fcec",
        "planning_id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5",
        "parent_line_id": null,
        "owner_id": "17a292cd-21f6-41b9-836a-6beae2c63237",
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
      "id": "8ce70bec-8e40-4551-a6e5-10db10b95fb0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
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
        "item_id": "aff68a29-5e37-43b9-8964-dcae4b0a5286",
        "tax_category_id": "8225165d-3928-4483-b17e-ee79c883fcec",
        "planning_id": "30a634d3-6a19-405d-be88-07953088592d",
        "parent_line_id": null,
        "owner_id": "17a292cd-21f6-41b9-836a-6beae2c63237",
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
      "id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
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
        "item_id": "449f7e6e-d659-4247-b02a-88e9251d48fb",
        "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237",
        "start_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed",
        "stop_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed",
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
      "id": "30a634d3-6a19-405d-be88-07953088592d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
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
        "item_id": "aff68a29-5e37-43b9-8964-dcae4b0a5286",
        "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237",
        "start_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed",
        "stop_location_id": "5964ef45-f488-4a53-97e2-f17fa6109fed",
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
      "id": "a2da8e19-832e-4837-8a2e-f408d88aa3bc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "50ab9845-26d5-4692-a0cd-a266a4cc852b",
        "planning_id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5",
        "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237"
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
      "id": "54f58332-93ce-4c94-8457-fb529e4156e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2fe21c18-726f-42c5-a3a7-791bcf6065ce",
        "planning_id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5",
        "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237"
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
      "id": "0b5a79a8-2d1a-443f-a504-478ceca9e1c1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:30+00:00",
        "updated_at": "2023-03-09T13:50:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eee05a2e-eff5-4a96-9f40-9048ae5f2621",
        "planning_id": "d7d9ca47-82fd-4c56-a7b1-18a5170275a5",
        "order_id": "17a292cd-21f6-41b9-836a-6beae2c63237"
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
          "order_id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080",
          "items": [
            {
              "type": "bundles",
              "id": "5cead87f-fbf9-4a45-9f71-1991ea9bde89",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5b82ff04-960c-4d94-a459-5dfbac21f79f",
                  "id": "8f3a3dfc-09fb-48af-b3e5-2bb3ef3bd601"
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
    "id": "cc8bc4a7-aee2-535e-b7c6-916879626500",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "75d8e764-1b89-4a13-bee2-9ed84ffc2898"
          },
          {
            "type": "lines",
            "id": "a421235f-15e6-4ce7-bae1-87ec0bf49a24"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b1a96649-8163-4466-843a-2c2df4ebac3c"
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
      "id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T13:50:33+00:00",
        "updated_at": "2023-03-09T13:50:34+00:00",
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
        "starts_at": "2023-03-07T13:45:00+00:00",
        "stops_at": "2023-03-11T13:45:00+00:00",
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
        "start_location_id": "e7386bc6-8733-44b8-af6f-cfeb9ec5cca5",
        "stop_location_id": "e7386bc6-8733-44b8-af6f-cfeb9ec5cca5"
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
      "id": "75d8e764-1b89-4a13-bee2-9ed84ffc2898",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T13:50:33+00:00",
        "updated_at": "2023-03-09T13:50:33+00:00",
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
        "item_id": "8f3a3dfc-09fb-48af-b3e5-2bb3ef3bd601",
        "tax_category_id": null,
        "planning_id": "976b9669-4651-41d0-81eb-9eaced0d21a2",
        "parent_line_id": "a421235f-15e6-4ce7-bae1-87ec0bf49a24",
        "owner_id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080",
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
      "id": "a421235f-15e6-4ce7-bae1-87ec0bf49a24",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T13:50:33+00:00",
        "updated_at": "2023-03-09T13:50:33+00:00",
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
        "item_id": "5cead87f-fbf9-4a45-9f71-1991ea9bde89",
        "tax_category_id": null,
        "planning_id": "b1a96649-8163-4466-843a-2c2df4ebac3c",
        "parent_line_id": null,
        "owner_id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080",
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
      "id": "b1a96649-8163-4466-843a-2c2df4ebac3c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T13:50:33+00:00",
        "updated_at": "2023-03-09T13:50:33+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-07T13:45:00+00:00",
        "stops_at": "2023-03-11T13:45:00+00:00",
        "reserved_from": "2023-03-07T13:45:00+00:00",
        "reserved_till": "2023-03-11T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5cead87f-fbf9-4a45-9f71-1991ea9bde89",
        "order_id": "6a5ddd10-a99b-4bc2-8aa8-158b2bdef080",
        "start_location_id": "e7386bc6-8733-44b8-af6f-cfeb9ec5cca5",
        "stop_location_id": "e7386bc6-8733-44b8-af6f-cfeb9ec5cca5",
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





