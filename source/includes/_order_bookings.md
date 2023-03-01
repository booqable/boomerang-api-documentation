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
          "order_id": "f501fb3b-afd9-42d0-a9a4-6bf287eb4e62",
          "items": [
            {
              "type": "products",
              "id": "39b50884-f854-4f03-8da5-7134847eb4a7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5a6744db-6ac4-4ac4-ae02-be2212c9fda4",
              "stock_item_ids": [
                "7f627e4d-3b30-4440-84bc-003afdcbb8b8",
                "93eca80d-3c9b-49c0-9801-ad6b79b7df66"
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
          "stock_item_id 7f627e4d-3b30-4440-84bc-003afdcbb8b8 has already been booked on this order"
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
          "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
          "items": [
            {
              "type": "products",
              "id": "a1217f03-5f0e-475b-9a84-00e47fd6bdf6",
              "stock_item_ids": [
                "e599fa67-31c3-4c3d-a5e2-8df50ba74e4f",
                "c0fdcb3f-7121-4224-abca-f3980abbcea2",
                "b4a770cd-9eb7-414a-b937-76fb53647533"
              ]
            },
            {
              "type": "products",
              "id": "51c20b2e-a045-4064-b312-c21a6e6c6762",
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
    "id": "dc0485a1-7e7a-5bb1-b4e2-0d91bd2410aa",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cc02615a-100c-421d-a4cf-852ac05c510c"
          },
          {
            "type": "lines",
            "id": "add57a6b-6d17-49f9-848e-9fa733846195"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fa2458b4-7590-46b2-8553-225ccc2e18d8"
          },
          {
            "type": "plannings",
            "id": "e04180c5-b910-4375-8d76-1e3e451ebd3d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8cb0805a-9248-4fec-906f-5553e2ccf500"
          },
          {
            "type": "stock_item_plannings",
            "id": "d8e6eafc-c253-4216-968f-c7f0fcbeef0d"
          },
          {
            "type": "stock_item_plannings",
            "id": "c538a0a8-9542-4708-a17a-2bd3de1bc3c7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T10:01:51+00:00",
        "updated_at": "2023-03-01T10:01:53+00:00",
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
        "customer_id": "d824865a-6517-438f-9ee3-9c636ea944fe",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4",
        "stop_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4"
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
      "id": "cc02615a-100c-421d-a4cf-852ac05c510c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:53+00:00",
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
        "item_id": "a1217f03-5f0e-475b-9a84-00e47fd6bdf6",
        "tax_category_id": "2e30b96a-94f6-475f-b163-c1568aaf559a",
        "planning_id": "fa2458b4-7590-46b2-8553-225ccc2e18d8",
        "parent_line_id": null,
        "owner_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
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
      "id": "add57a6b-6d17-49f9-848e-9fa733846195",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:53+00:00",
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
        "item_id": "51c20b2e-a045-4064-b312-c21a6e6c6762",
        "tax_category_id": "2e30b96a-94f6-475f-b163-c1568aaf559a",
        "planning_id": "e04180c5-b910-4375-8d76-1e3e451ebd3d",
        "parent_line_id": null,
        "owner_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
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
      "id": "fa2458b4-7590-46b2-8553-225ccc2e18d8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:52+00:00",
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
        "item_id": "a1217f03-5f0e-475b-9a84-00e47fd6bdf6",
        "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
        "start_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4",
        "stop_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4",
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
      "id": "e04180c5-b910-4375-8d76-1e3e451ebd3d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:52+00:00",
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
        "item_id": "51c20b2e-a045-4064-b312-c21a6e6c6762",
        "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77",
        "start_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4",
        "stop_location_id": "54dfbe0e-3844-4140-b352-6c7daa8332a4",
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
      "id": "8cb0805a-9248-4fec-906f-5553e2ccf500",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e599fa67-31c3-4c3d-a5e2-8df50ba74e4f",
        "planning_id": "fa2458b4-7590-46b2-8553-225ccc2e18d8",
        "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77"
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
      "id": "d8e6eafc-c253-4216-968f-c7f0fcbeef0d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c0fdcb3f-7121-4224-abca-f3980abbcea2",
        "planning_id": "fa2458b4-7590-46b2-8553-225ccc2e18d8",
        "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77"
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
      "id": "c538a0a8-9542-4708-a17a-2bd3de1bc3c7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:52+00:00",
        "updated_at": "2023-03-01T10:01:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b4a770cd-9eb7-414a-b937-76fb53647533",
        "planning_id": "fa2458b4-7590-46b2-8553-225ccc2e18d8",
        "order_id": "6b16818a-ea6d-47e0-91ae-e8ced16aab77"
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
          "order_id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3",
          "items": [
            {
              "type": "bundles",
              "id": "509728ac-fa7b-4e37-8ddf-71311002787c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e35d200c-c767-4479-bb14-bbdcdc006a9f",
                  "id": "61afbc4b-e11d-439a-a372-dc64a580e53c"
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
    "id": "d1f48e81-6499-591f-a82e-946170a9f26a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3a669d6a-3b72-4800-a376-399915e8e525"
          },
          {
            "type": "lines",
            "id": "73d30073-335e-4eee-8ce4-4c73ffd04986"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c7c5d830-1959-433e-b58c-55972767ba8c"
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
      "id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T10:01:55+00:00",
        "updated_at": "2023-03-01T10:01:55+00:00",
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
        "starts_at": "2023-02-27T10:00:00+00:00",
        "stops_at": "2023-03-03T10:00:00+00:00",
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
        "start_location_id": "d355d64c-b273-41e4-9ae0-3ed144607c8c",
        "stop_location_id": "d355d64c-b273-41e4-9ae0-3ed144607c8c"
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
      "id": "3a669d6a-3b72-4800-a376-399915e8e525",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:01:55+00:00",
        "updated_at": "2023-03-01T10:01:55+00:00",
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
        "item_id": "61afbc4b-e11d-439a-a372-dc64a580e53c",
        "tax_category_id": null,
        "planning_id": "c2b04bf3-3e24-4fda-ab11-2d9cb2f19f29",
        "parent_line_id": "73d30073-335e-4eee-8ce4-4c73ffd04986",
        "owner_id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3",
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
      "id": "73d30073-335e-4eee-8ce4-4c73ffd04986",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:01:55+00:00",
        "updated_at": "2023-03-01T10:01:55+00:00",
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
        "item_id": "509728ac-fa7b-4e37-8ddf-71311002787c",
        "tax_category_id": null,
        "planning_id": "c7c5d830-1959-433e-b58c-55972767ba8c",
        "parent_line_id": null,
        "owner_id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3",
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
      "id": "c7c5d830-1959-433e-b58c-55972767ba8c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:01:55+00:00",
        "updated_at": "2023-03-01T10:01:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-27T10:00:00+00:00",
        "stops_at": "2023-03-03T10:00:00+00:00",
        "reserved_from": "2023-02-27T10:00:00+00:00",
        "reserved_till": "2023-03-03T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "509728ac-fa7b-4e37-8ddf-71311002787c",
        "order_id": "fb8e64d8-fdc6-4c26-af29-dcf64f6d30b3",
        "start_location_id": "d355d64c-b273-41e4-9ae0-3ed144607c8c",
        "stop_location_id": "d355d64c-b273-41e4-9ae0-3ed144607c8c",
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





