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
          "order_id": "6a90261d-6fec-465a-a211-d967952e3ef8",
          "items": [
            {
              "type": "products",
              "id": "fdfe1a85-06e5-447a-8438-4835ad602643",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f9d86e2e-9182-45d1-bf95-49f5cc842183",
              "stock_item_ids": [
                "ec3bb24b-8819-4259-8072-9f7eefa68275",
                "45d680e7-6408-46d3-b22c-6113f70480c2"
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
          "stock_item_id ec3bb24b-8819-4259-8072-9f7eefa68275 has already been booked on this order"
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
          "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
          "items": [
            {
              "type": "products",
              "id": "ee25d605-e2a6-45fd-bc12-8f3c2bb4c320",
              "stock_item_ids": [
                "4547d5fc-b584-4b12-b18f-6e273a777dfc",
                "0a2509f6-9fd2-493c-82d3-41fd2b83011a",
                "e3509533-b84b-4fd5-ba47-00dccf09b1a6"
              ]
            },
            {
              "type": "products",
              "id": "bc5971af-b684-4fa2-a5ac-b724ea6f201f",
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
    "id": "f4f628ff-34a5-5b19-a18a-55bc43be4897",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f067e950-202e-42ed-bf19-2f30d3425e2c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "03e46edd-767d-41e8-bffe-4492914c522e"
          },
          {
            "type": "lines",
            "id": "ddf6e851-ab5a-409a-b30c-a249bfbec2e2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0a5c2c11-e766-421f-8662-66af314de851"
          },
          {
            "type": "plannings",
            "id": "4c228f8d-6daf-491d-b9af-e7f5283643a1"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4f4a17f1-5728-48e3-8585-c997fcbf9bc4"
          },
          {
            "type": "stock_item_plannings",
            "id": "0b2f4078-f0c5-47aa-9925-e664d8c34f67"
          },
          {
            "type": "stock_item_plannings",
            "id": "5a274c33-e50c-4c2d-9a4d-0f44cc697d1b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T08:56:12+00:00",
        "updated_at": "2023-02-23T08:56:14+00:00",
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
        "customer_id": "c2b4900c-120c-43ba-a95d-3987748b5459",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6",
        "stop_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6"
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
      "id": "03e46edd-767d-41e8-bffe-4492914c522e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:14+00:00",
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
        "item_id": "ee25d605-e2a6-45fd-bc12-8f3c2bb4c320",
        "tax_category_id": "5d8b2a3b-0579-4eec-973b-c8c8c948eb38",
        "planning_id": "0a5c2c11-e766-421f-8662-66af314de851",
        "parent_line_id": null,
        "owner_id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
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
      "id": "ddf6e851-ab5a-409a-b30c-a249bfbec2e2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:14+00:00",
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
        "item_id": "bc5971af-b684-4fa2-a5ac-b724ea6f201f",
        "tax_category_id": "5d8b2a3b-0579-4eec-973b-c8c8c948eb38",
        "planning_id": "4c228f8d-6daf-491d-b9af-e7f5283643a1",
        "parent_line_id": null,
        "owner_id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
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
      "id": "0a5c2c11-e766-421f-8662-66af314de851",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:13+00:00",
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
        "item_id": "ee25d605-e2a6-45fd-bc12-8f3c2bb4c320",
        "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
        "start_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6",
        "stop_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6",
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
      "id": "4c228f8d-6daf-491d-b9af-e7f5283643a1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:13+00:00",
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
        "item_id": "bc5971af-b684-4fa2-a5ac-b724ea6f201f",
        "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c",
        "start_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6",
        "stop_location_id": "4cbd1c32-8da2-48f7-8a1a-e6330d8301e6",
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
      "id": "4f4a17f1-5728-48e3-8585-c997fcbf9bc4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4547d5fc-b584-4b12-b18f-6e273a777dfc",
        "planning_id": "0a5c2c11-e766-421f-8662-66af314de851",
        "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c"
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
      "id": "0b2f4078-f0c5-47aa-9925-e664d8c34f67",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0a2509f6-9fd2-493c-82d3-41fd2b83011a",
        "planning_id": "0a5c2c11-e766-421f-8662-66af314de851",
        "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c"
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
      "id": "5a274c33-e50c-4c2d-9a4d-0f44cc697d1b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:13+00:00",
        "updated_at": "2023-02-23T08:56:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e3509533-b84b-4fd5-ba47-00dccf09b1a6",
        "planning_id": "0a5c2c11-e766-421f-8662-66af314de851",
        "order_id": "f067e950-202e-42ed-bf19-2f30d3425e2c"
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
          "order_id": "84f5be66-324b-4daf-b10d-b6ce55221ae3",
          "items": [
            {
              "type": "bundles",
              "id": "67fa7455-7dca-4355-ba10-6c47a3ace2fd",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "61f2ddaa-7870-44bf-8db0-91f0a4672d01",
                  "id": "c42db4d1-385f-47f1-abe9-b7bba178382e"
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
    "id": "0a11e188-4c39-57e2-b112-c306ee5256d5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "84f5be66-324b-4daf-b10d-b6ce55221ae3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "84f5be66-324b-4daf-b10d-b6ce55221ae3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8fb6eb4b-5c30-4295-9ab3-b4c9b9847d0e"
          },
          {
            "type": "lines",
            "id": "798468ff-54f5-4cc4-862a-f25d672f53b0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a69fce78-fb6e-4608-9346-3f85c6d97dda"
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
      "id": "84f5be66-324b-4daf-b10d-b6ce55221ae3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T08:56:16+00:00",
        "updated_at": "2023-02-23T08:56:16+00:00",
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
        "starts_at": "2023-02-21T08:45:00+00:00",
        "stops_at": "2023-02-25T08:45:00+00:00",
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
        "start_location_id": "69ce1e74-61ce-414e-811d-532185d2c6e8",
        "stop_location_id": "69ce1e74-61ce-414e-811d-532185d2c6e8"
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
      "id": "8fb6eb4b-5c30-4295-9ab3-b4c9b9847d0e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:56:16+00:00",
        "updated_at": "2023-02-23T08:56:16+00:00",
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
        "item_id": "c42db4d1-385f-47f1-abe9-b7bba178382e",
        "tax_category_id": null,
        "planning_id": "29dfee03-80a4-4e31-94c1-36c3c9938b30",
        "parent_line_id": "798468ff-54f5-4cc4-862a-f25d672f53b0",
        "owner_id": "84f5be66-324b-4daf-b10d-b6ce55221ae3",
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
      "id": "798468ff-54f5-4cc4-862a-f25d672f53b0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T08:56:16+00:00",
        "updated_at": "2023-02-23T08:56:16+00:00",
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
        "item_id": "67fa7455-7dca-4355-ba10-6c47a3ace2fd",
        "tax_category_id": null,
        "planning_id": "a69fce78-fb6e-4608-9346-3f85c6d97dda",
        "parent_line_id": null,
        "owner_id": "84f5be66-324b-4daf-b10d-b6ce55221ae3",
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
      "id": "a69fce78-fb6e-4608-9346-3f85c6d97dda",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T08:56:16+00:00",
        "updated_at": "2023-02-23T08:56:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-21T08:45:00+00:00",
        "stops_at": "2023-02-25T08:45:00+00:00",
        "reserved_from": "2023-02-21T08:45:00+00:00",
        "reserved_till": "2023-02-25T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "67fa7455-7dca-4355-ba10-6c47a3ace2fd",
        "order_id": "84f5be66-324b-4daf-b10d-b6ce55221ae3",
        "start_location_id": "69ce1e74-61ce-414e-811d-532185d2c6e8",
        "stop_location_id": "69ce1e74-61ce-414e-811d-532185d2c6e8",
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





