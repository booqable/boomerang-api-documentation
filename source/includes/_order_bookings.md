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
          "order_id": "211f4d58-8a09-4150-9f64-0e31690a07c3",
          "items": [
            {
              "type": "products",
              "id": "f5e319ac-114e-4463-924a-5b1c6b347796",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f556205d-7c65-43fb-b5c4-b4c1c505a0b5",
              "stock_item_ids": [
                "9f81d03c-334c-4e8a-b676-7ca23738c94a",
                "34037889-630d-47af-b368-ee8db79fb2b8"
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
            "item_id": "f5e319ac-114e-4463-924a-5b1c6b347796",
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
          "order_id": "5c369a71-9186-404b-857e-94577ac83639",
          "items": [
            {
              "type": "products",
              "id": "4c9dae08-d7d5-444b-8093-2367510c5fdb",
              "stock_item_ids": [
                "3ce2bfa3-2a24-4498-9a36-93b7e76ff3ff",
                "a1455854-6af7-4d43-aa10-ba0470234a40",
                "eedbbdff-d66c-4232-9d4b-2ee95efc020e"
              ]
            },
            {
              "type": "products",
              "id": "f1cf21f2-a0dd-40bf-ae89-68f4f6dc8928",
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
    "id": "dcaed0fc-504d-572b-964f-b1448b1cfcad",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5c369a71-9186-404b-857e-94577ac83639"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5c369a71-9186-404b-857e-94577ac83639"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7365231e-e53b-4eba-9a15-cb79ebbeaf2d"
          },
          {
            "type": "lines",
            "id": "ac3f06e1-66ae-463f-bd69-4075dc957875"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "54ad8e0b-f983-472d-8060-81383dc103b2"
          },
          {
            "type": "plannings",
            "id": "3ee41241-1b22-4004-b7e2-df890ba8e14d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "76bb4040-2bda-4746-add3-a9ce36dc77c1"
          },
          {
            "type": "stock_item_plannings",
            "id": "a4111521-31f3-411d-9b9c-ba4e8355fa5b"
          },
          {
            "type": "stock_item_plannings",
            "id": "ef5ea665-e0c5-4100-ba1f-22ea4ed91036"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5c369a71-9186-404b-857e-94577ac83639",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T08:40:49+00:00",
        "updated_at": "2023-02-06T08:40:51+00:00",
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
        "customer_id": "dc184a77-1d48-44f8-85d9-2bcc09b89d2b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73",
        "stop_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73"
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
      "id": "7365231e-e53b-4eba-9a15-cb79ebbeaf2d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:51+00:00",
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
        "item_id": "4c9dae08-d7d5-444b-8093-2367510c5fdb",
        "tax_category_id": "566a5ef7-ccb5-4f35-af76-8f9a73142c25",
        "planning_id": "54ad8e0b-f983-472d-8060-81383dc103b2",
        "parent_line_id": null,
        "owner_id": "5c369a71-9186-404b-857e-94577ac83639",
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
      "id": "ac3f06e1-66ae-463f-bd69-4075dc957875",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:51+00:00",
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
        "item_id": "f1cf21f2-a0dd-40bf-ae89-68f4f6dc8928",
        "tax_category_id": "566a5ef7-ccb5-4f35-af76-8f9a73142c25",
        "planning_id": "3ee41241-1b22-4004-b7e2-df890ba8e14d",
        "parent_line_id": null,
        "owner_id": "5c369a71-9186-404b-857e-94577ac83639",
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
      "id": "54ad8e0b-f983-472d-8060-81383dc103b2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:51+00:00",
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
        "item_id": "4c9dae08-d7d5-444b-8093-2367510c5fdb",
        "order_id": "5c369a71-9186-404b-857e-94577ac83639",
        "start_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73",
        "stop_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73",
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
      "id": "3ee41241-1b22-4004-b7e2-df890ba8e14d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:51+00:00",
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
        "item_id": "f1cf21f2-a0dd-40bf-ae89-68f4f6dc8928",
        "order_id": "5c369a71-9186-404b-857e-94577ac83639",
        "start_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73",
        "stop_location_id": "f2b71898-93e1-4db8-9974-ff7cc3255e73",
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
      "id": "76bb4040-2bda-4746-add3-a9ce36dc77c1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3ce2bfa3-2a24-4498-9a36-93b7e76ff3ff",
        "planning_id": "54ad8e0b-f983-472d-8060-81383dc103b2",
        "order_id": "5c369a71-9186-404b-857e-94577ac83639"
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
      "id": "a4111521-31f3-411d-9b9c-ba4e8355fa5b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a1455854-6af7-4d43-aa10-ba0470234a40",
        "planning_id": "54ad8e0b-f983-472d-8060-81383dc103b2",
        "order_id": "5c369a71-9186-404b-857e-94577ac83639"
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
      "id": "ef5ea665-e0c5-4100-ba1f-22ea4ed91036",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:50+00:00",
        "updated_at": "2023-02-06T08:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eedbbdff-d66c-4232-9d4b-2ee95efc020e",
        "planning_id": "54ad8e0b-f983-472d-8060-81383dc103b2",
        "order_id": "5c369a71-9186-404b-857e-94577ac83639"
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
          "order_id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55",
          "items": [
            {
              "type": "bundles",
              "id": "cca8d848-6b63-43a3-a081-edb6abfc0111",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "20b0b376-3631-428f-a564-bb59ac51eb37",
                  "id": "8a549b0d-5699-43c7-a36e-b704c9b01c9d"
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
    "id": "aa997d7b-6946-53c7-bb7d-ab1005df14f8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c839a1aa-f692-4800-8298-d25cb53e727d"
          },
          {
            "type": "lines",
            "id": "25180c67-37d1-4434-9a25-d0dabcd0f8f7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "211c1328-6de3-4a18-8288-6b775f7f38dc"
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
      "id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-06T08:40:53+00:00",
        "updated_at": "2023-02-06T08:40:53+00:00",
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
        "starts_at": "2023-02-04T08:30:00+00:00",
        "stops_at": "2023-02-08T08:30:00+00:00",
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
        "start_location_id": "3f256dd7-053e-4124-825e-fff6d74f18b8",
        "stop_location_id": "3f256dd7-053e-4124-825e-fff6d74f18b8"
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
      "id": "c839a1aa-f692-4800-8298-d25cb53e727d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T08:40:53+00:00",
        "updated_at": "2023-02-06T08:40:53+00:00",
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
        "item_id": "cca8d848-6b63-43a3-a081-edb6abfc0111",
        "tax_category_id": null,
        "planning_id": "211c1328-6de3-4a18-8288-6b775f7f38dc",
        "parent_line_id": null,
        "owner_id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55",
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
      "id": "25180c67-37d1-4434-9a25-d0dabcd0f8f7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-06T08:40:53+00:00",
        "updated_at": "2023-02-06T08:40:53+00:00",
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
        "item_id": "8a549b0d-5699-43c7-a36e-b704c9b01c9d",
        "tax_category_id": null,
        "planning_id": "bf231f94-9dd4-4b82-b9b2-b994c623975c",
        "parent_line_id": "c839a1aa-f692-4800-8298-d25cb53e727d",
        "owner_id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55",
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
      "id": "211c1328-6de3-4a18-8288-6b775f7f38dc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-06T08:40:53+00:00",
        "updated_at": "2023-02-06T08:40:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-04T08:30:00+00:00",
        "stops_at": "2023-02-08T08:30:00+00:00",
        "reserved_from": "2023-02-04T08:30:00+00:00",
        "reserved_till": "2023-02-08T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cca8d848-6b63-43a3-a081-edb6abfc0111",
        "order_id": "3f0b271a-1e97-4f9a-bc5d-7a4dc1194e55",
        "start_location_id": "3f256dd7-053e-4124-825e-fff6d74f18b8",
        "stop_location_id": "3f256dd7-053e-4124-825e-fff6d74f18b8",
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





