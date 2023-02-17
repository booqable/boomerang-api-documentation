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
          "order_id": "ef71e208-6a3c-4a4b-90de-75d8c88919c3",
          "items": [
            {
              "type": "products",
              "id": "9c8c466a-aef4-4d0d-a435-defc470f72bc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2c39dd20-cce2-41c5-a313-4516f7e7106a",
              "stock_item_ids": [
                "bbca9a77-8f9f-4d09-829d-cfe00b9bb055",
                "9139b784-9182-4c9b-b702-9a5c35e486ca"
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
          "stock_item_id bbca9a77-8f9f-4d09-829d-cfe00b9bb055 has already been booked on this order"
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
          "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
          "items": [
            {
              "type": "products",
              "id": "1fd90d54-ce59-4759-a3a9-504d6701e525",
              "stock_item_ids": [
                "73970f71-fbd4-4fe8-b86f-424360f170d0",
                "830f2068-6e5e-478f-ac21-7e591c00aae6",
                "0ea337ed-9c00-47fc-930c-c9e3a37cadaa"
              ]
            },
            {
              "type": "products",
              "id": "91390cf3-ebb7-47ab-9d7a-2d2daa7e7f02",
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
    "id": "58fcac94-fb09-505c-a730-eefb2a431a72",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5253c03d-b024-4afe-adde-4ac6b3467dbe"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2423d536-0490-49e0-ad6a-8237fd6e0e18"
          },
          {
            "type": "lines",
            "id": "7b7d4e2e-953c-4ee3-bad2-ae390d28eef2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f1fd4455-c863-4423-840a-5633f909b369"
          },
          {
            "type": "plannings",
            "id": "7cd5da53-491f-405b-a549-b88a5576c066"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3ea2bc66-1b7e-4da6-837e-b9ceed1669ab"
          },
          {
            "type": "stock_item_plannings",
            "id": "d82c3309-9247-4630-b554-3117524cdefa"
          },
          {
            "type": "stock_item_plannings",
            "id": "cc3b8b13-e8fe-42d3-b8c1-2b02e91d6920"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-17T13:27:15+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
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
        "customer_id": "6953d554-0901-40ff-ab19-9ac537af62c4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0",
        "stop_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0"
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
      "id": "2423d536-0490-49e0-ad6a-8237fd6e0e18",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
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
        "item_id": "1fd90d54-ce59-4759-a3a9-504d6701e525",
        "tax_category_id": "48bee788-88f9-46ce-aab5-be5780028a7c",
        "planning_id": "f1fd4455-c863-4423-840a-5633f909b369",
        "parent_line_id": null,
        "owner_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
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
      "id": "7b7d4e2e-953c-4ee3-bad2-ae390d28eef2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
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
        "item_id": "91390cf3-ebb7-47ab-9d7a-2d2daa7e7f02",
        "tax_category_id": "48bee788-88f9-46ce-aab5-be5780028a7c",
        "planning_id": "7cd5da53-491f-405b-a549-b88a5576c066",
        "parent_line_id": null,
        "owner_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
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
      "id": "f1fd4455-c863-4423-840a-5633f909b369",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
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
        "item_id": "1fd90d54-ce59-4759-a3a9-504d6701e525",
        "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
        "start_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0",
        "stop_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0",
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
      "id": "7cd5da53-491f-405b-a549-b88a5576c066",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
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
        "item_id": "91390cf3-ebb7-47ab-9d7a-2d2daa7e7f02",
        "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe",
        "start_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0",
        "stop_location_id": "507fd56f-b0b7-4223-97e2-e66811c5f9a0",
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
      "id": "3ea2bc66-1b7e-4da6-837e-b9ceed1669ab",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "73970f71-fbd4-4fe8-b86f-424360f170d0",
        "planning_id": "f1fd4455-c863-4423-840a-5633f909b369",
        "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe"
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
      "id": "d82c3309-9247-4630-b554-3117524cdefa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "830f2068-6e5e-478f-ac21-7e591c00aae6",
        "planning_id": "f1fd4455-c863-4423-840a-5633f909b369",
        "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe"
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
      "id": "cc3b8b13-e8fe-42d3-b8c1-2b02e91d6920",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:17+00:00",
        "updated_at": "2023-02-17T13:27:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0ea337ed-9c00-47fc-930c-c9e3a37cadaa",
        "planning_id": "f1fd4455-c863-4423-840a-5633f909b369",
        "order_id": "5253c03d-b024-4afe-adde-4ac6b3467dbe"
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
          "order_id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde",
          "items": [
            {
              "type": "bundles",
              "id": "78285fc8-b23c-4aca-aee1-cf5ca73912bd",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "263af10d-d0a5-4ef8-b849-a3ba1ee12ce3",
                  "id": "756f2b61-7dfd-4b09-a0a1-6e9998e93eca"
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
    "id": "0e185ffc-3f29-542c-a634-0786e4c1d626",
    "type": "order_bookings",
    "attributes": {
      "order_id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a6fa138d-c1d2-4040-aa20-2c94a2a5afd4"
          },
          {
            "type": "lines",
            "id": "b6ffdd43-6a29-47f7-baa3-9cde097246ee"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a70f8862-2320-4480-8155-b8e3b50aa2b4"
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
      "id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-17T13:27:20+00:00",
        "updated_at": "2023-02-17T13:27:20+00:00",
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
        "starts_at": "2023-02-15T13:15:00+00:00",
        "stops_at": "2023-02-19T13:15:00+00:00",
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
        "start_location_id": "d780c289-1554-4a0d-a3f7-ee7556767e36",
        "stop_location_id": "d780c289-1554-4a0d-a3f7-ee7556767e36"
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
      "id": "a6fa138d-c1d2-4040-aa20-2c94a2a5afd4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T13:27:20+00:00",
        "updated_at": "2023-02-17T13:27:20+00:00",
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
        "item_id": "756f2b61-7dfd-4b09-a0a1-6e9998e93eca",
        "tax_category_id": null,
        "planning_id": "8e3145cd-6323-4238-b976-b36734c179be",
        "parent_line_id": "b6ffdd43-6a29-47f7-baa3-9cde097246ee",
        "owner_id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde",
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
      "id": "b6ffdd43-6a29-47f7-baa3-9cde097246ee",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T13:27:20+00:00",
        "updated_at": "2023-02-17T13:27:20+00:00",
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
        "item_id": "78285fc8-b23c-4aca-aee1-cf5ca73912bd",
        "tax_category_id": null,
        "planning_id": "a70f8862-2320-4480-8155-b8e3b50aa2b4",
        "parent_line_id": null,
        "owner_id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde",
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
      "id": "a70f8862-2320-4480-8155-b8e3b50aa2b4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T13:27:20+00:00",
        "updated_at": "2023-02-17T13:27:20+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-15T13:15:00+00:00",
        "stops_at": "2023-02-19T13:15:00+00:00",
        "reserved_from": "2023-02-15T13:15:00+00:00",
        "reserved_till": "2023-02-19T13:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "78285fc8-b23c-4aca-aee1-cf5ca73912bd",
        "order_id": "31097e4e-e3d4-445e-9ee0-36d785d3dcde",
        "start_location_id": "d780c289-1554-4a0d-a3f7-ee7556767e36",
        "stop_location_id": "d780c289-1554-4a0d-a3f7-ee7556767e36",
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





