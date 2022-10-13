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
          "order_id": "7f2c31ec-38e3-4505-aa38-b8bc369dab27",
          "items": [
            {
              "type": "products",
              "id": "c324c84d-c49d-4202-a6b3-3fa46ed95c2a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6e0d63af-10e5-4932-86fd-39fdd32ea11d",
              "stock_item_ids": [
                "0c9b7910-cad9-4418-b5fa-aa248cc1bc10",
                "f2d88cc9-8d36-4d96-b6dd-2b3c04ac3c43"
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
            "item_id": "c324c84d-c49d-4202-a6b3-3fa46ed95c2a",
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
          "order_id": "177aedd6-6f73-457b-9a96-62391165eef6",
          "items": [
            {
              "type": "products",
              "id": "0942075c-61ab-49f0-8d0b-dcfa2081bbeb",
              "stock_item_ids": [
                "b5578713-3f57-47e6-a743-c832ffcdc8af",
                "96f560d8-5776-4878-ba17-442c128ae562",
                "3c42f58a-645f-4c14-afac-7e2560784173"
              ]
            },
            {
              "type": "products",
              "id": "b6e178af-60be-4241-852e-588aebb417b8",
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
    "id": "38b2b98e-24a4-5cc3-a9c8-11d3afbc44c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "177aedd6-6f73-457b-9a96-62391165eef6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "177aedd6-6f73-457b-9a96-62391165eef6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6a4f3881-2889-4216-9bca-ea1a08c85813"
          },
          {
            "type": "lines",
            "id": "e98f2cd7-b6b8-43de-a833-04231e425e90"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5c109cf1-f73a-4081-a041-83b955ba1584"
          },
          {
            "type": "plannings",
            "id": "b512d1fe-5761-4a04-b625-949df346823d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "41f28879-ebe8-44fe-a8c5-e87c4162e013"
          },
          {
            "type": "stock_item_plannings",
            "id": "412a5e6a-0cc7-44b5-8430-2f8460eda777"
          },
          {
            "type": "stock_item_plannings",
            "id": "25b0f9f6-1267-4cbf-9a59-2967a5c95b40"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "177aedd6-6f73-457b-9a96-62391165eef6",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T15:44:08+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
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
        "customer_id": "eff6af03-08b0-4449-a209-2b5acd43815d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa",
        "stop_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa"
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
      "id": "6a4f3881-2889-4216-9bca-ea1a08c85813",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
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
        "item_id": "0942075c-61ab-49f0-8d0b-dcfa2081bbeb",
        "tax_category_id": "8880c2f2-77f5-45c6-93c4-e2d0950e8019",
        "planning_id": "5c109cf1-f73a-4081-a041-83b955ba1584",
        "parent_line_id": null,
        "owner_id": "177aedd6-6f73-457b-9a96-62391165eef6",
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
      "id": "e98f2cd7-b6b8-43de-a833-04231e425e90",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
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
        "item_id": "b6e178af-60be-4241-852e-588aebb417b8",
        "tax_category_id": "8880c2f2-77f5-45c6-93c4-e2d0950e8019",
        "planning_id": "b512d1fe-5761-4a04-b625-949df346823d",
        "parent_line_id": null,
        "owner_id": "177aedd6-6f73-457b-9a96-62391165eef6",
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
      "id": "5c109cf1-f73a-4081-a041-83b955ba1584",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
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
        "item_id": "0942075c-61ab-49f0-8d0b-dcfa2081bbeb",
        "order_id": "177aedd6-6f73-457b-9a96-62391165eef6",
        "start_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa",
        "stop_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa",
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
      "id": "b512d1fe-5761-4a04-b625-949df346823d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
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
        "item_id": "b6e178af-60be-4241-852e-588aebb417b8",
        "order_id": "177aedd6-6f73-457b-9a96-62391165eef6",
        "start_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa",
        "stop_location_id": "9b797e75-d3e0-4cc0-a665-db3af6789ffa",
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
      "id": "41f28879-ebe8-44fe-a8c5-e87c4162e013",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b5578713-3f57-47e6-a743-c832ffcdc8af",
        "planning_id": "5c109cf1-f73a-4081-a041-83b955ba1584",
        "order_id": "177aedd6-6f73-457b-9a96-62391165eef6"
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
      "id": "412a5e6a-0cc7-44b5-8430-2f8460eda777",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "96f560d8-5776-4878-ba17-442c128ae562",
        "planning_id": "5c109cf1-f73a-4081-a041-83b955ba1584",
        "order_id": "177aedd6-6f73-457b-9a96-62391165eef6"
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
      "id": "25b0f9f6-1267-4cbf-9a59-2967a5c95b40",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:10+00:00",
        "updated_at": "2022-10-13T15:44:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3c42f58a-645f-4c14-afac-7e2560784173",
        "planning_id": "5c109cf1-f73a-4081-a041-83b955ba1584",
        "order_id": "177aedd6-6f73-457b-9a96-62391165eef6"
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
          "order_id": "440f0bf3-76da-4800-88d8-420766495c8f",
          "items": [
            {
              "type": "bundles",
              "id": "36b77c53-be63-49fd-94ef-870b620ae76e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "bc3d19c6-6b2a-4858-973e-98702f01bd5c",
                  "id": "7d531765-ba81-4aeb-81c2-34ef2d7d5343"
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
    "id": "e1b11c06-0489-523a-802a-4c6330349f69",
    "type": "order_bookings",
    "attributes": {
      "order_id": "440f0bf3-76da-4800-88d8-420766495c8f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "440f0bf3-76da-4800-88d8-420766495c8f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d5a94e9c-2c0f-4e14-9fd3-965e8961ec2a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "30105d72-5f83-4237-8f2e-937599ceb364"
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
      "id": "440f0bf3-76da-4800-88d8-420766495c8f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T15:44:12+00:00",
        "updated_at": "2022-10-13T15:44:13+00:00",
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
        "starts_at": "2022-10-11T15:30:00+00:00",
        "stops_at": "2022-10-15T15:30:00+00:00",
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
        "start_location_id": "a21c52d1-3a10-495d-832e-958d2e27d65d",
        "stop_location_id": "a21c52d1-3a10-495d-832e-958d2e27d65d"
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
      "id": "d5a94e9c-2c0f-4e14-9fd3-965e8961ec2a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T15:44:13+00:00",
        "updated_at": "2022-10-13T15:44:13+00:00",
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
        "item_id": "36b77c53-be63-49fd-94ef-870b620ae76e",
        "tax_category_id": null,
        "planning_id": "30105d72-5f83-4237-8f2e-937599ceb364",
        "parent_line_id": null,
        "owner_id": "440f0bf3-76da-4800-88d8-420766495c8f",
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
      "id": "30105d72-5f83-4237-8f2e-937599ceb364",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T15:44:13+00:00",
        "updated_at": "2022-10-13T15:44:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-11T15:30:00+00:00",
        "stops_at": "2022-10-15T15:30:00+00:00",
        "reserved_from": "2022-10-11T15:30:00+00:00",
        "reserved_till": "2022-10-15T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "36b77c53-be63-49fd-94ef-870b620ae76e",
        "order_id": "440f0bf3-76da-4800-88d8-420766495c8f",
        "start_location_id": "a21c52d1-3a10-495d-832e-958d2e27d65d",
        "stop_location_id": "a21c52d1-3a10-495d-832e-958d2e27d65d",
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





