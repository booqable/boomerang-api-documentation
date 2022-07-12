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
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


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
          "order_id": "89e11ed4-f840-4001-bbaf-fff981049bdf",
          "items": [
            {
              "type": "products",
              "id": "8a5f0d60-52a6-4bb4-b979-42c2cbcafb41",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9d32658d-cfe4-40a1-bdb8-625ab38b2b69",
              "stock_item_ids": [
                "16070202-3fdd-47b7-9705-6fd09858dede",
                "31768487-fb15-40e1-8682-c74b62dba25d"
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
            "item_id": "8a5f0d60-52a6-4bb4-b979-42c2cbcafb41",
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
          "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
          "items": [
            {
              "type": "products",
              "id": "cc736a90-397a-4108-ad15-73ff1c2f566f",
              "stock_item_ids": [
                "7b6b2c5e-c8f8-4d4d-8408-d9d33a1eb256",
                "eddff6a8-b9d4-4f04-8d68-cb74f0835a6b",
                "89c3df56-d253-4558-bc53-b3b931694dd0"
              ]
            },
            {
              "type": "products",
              "id": "cf28c586-b466-4c2c-831c-05eb4a2b8977",
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
    "id": "69b41e80-e3fd-54d5-9509-fafe2237c6ca",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6e17c675-51df-4fb2-9a39-be34301031ee"
          },
          {
            "type": "lines",
            "id": "f0d761f5-093d-4e6f-a96d-ff29200cba34"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4caa3176-ad7a-466d-8686-8d3dac2fde52"
          },
          {
            "type": "plannings",
            "id": "17463313-73ad-4872-82b9-3f0c620742e2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c6f12170-b5c6-476c-8df7-ba148372eae3"
          },
          {
            "type": "stock_item_plannings",
            "id": "f42b2911-4938-42a8-ba61-5bb36ea2ad71"
          },
          {
            "type": "stock_item_plannings",
            "id": "bbb1cfcf-a4c1-40f6-90e4-fdd6a71dda64"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T08:48:41+00:00",
        "updated_at": "2022-07-12T08:48:44+00:00",
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
        "customer_id": "75290872-eaed-4c98-a133-dfa72f8b06d2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47",
        "stop_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47"
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
      "id": "6e17c675-51df-4fb2-9a39-be34301031ee",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T08:48:42+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 2,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 160500,
        "position": 1,
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
        "item_id": "cf28c586-b466-4c2c-831c-05eb4a2b8977",
        "tax_category_id": "98a226b4-6ec9-4838-8143-595bde596eb8",
        "planning_id": "4caa3176-ad7a-466d-8686-8d3dac2fde52",
        "parent_line_id": null,
        "owner_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
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
      "id": "f0d761f5-093d-4e6f-a96d-ff29200cba34",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T08:48:43+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
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
        "item_id": "cc736a90-397a-4108-ad15-73ff1c2f566f",
        "tax_category_id": "98a226b4-6ec9-4838-8143-595bde596eb8",
        "planning_id": "17463313-73ad-4872-82b9-3f0c620742e2",
        "parent_line_id": null,
        "owner_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
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
      "id": "4caa3176-ad7a-466d-8686-8d3dac2fde52",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:42+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cf28c586-b466-4c2c-831c-05eb4a2b8977",
        "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
        "start_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47",
        "stop_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47",
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
      "id": "17463313-73ad-4872-82b9-3f0c620742e2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:43+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
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
        "item_id": "cc736a90-397a-4108-ad15-73ff1c2f566f",
        "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65",
        "start_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47",
        "stop_location_id": "981f9830-4a0c-4dc5-8770-bebdffc1df47",
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
      "id": "c6f12170-b5c6-476c-8df7-ba148372eae3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:43+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7b6b2c5e-c8f8-4d4d-8408-d9d33a1eb256",
        "planning_id": "17463313-73ad-4872-82b9-3f0c620742e2",
        "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65"
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
      "id": "f42b2911-4938-42a8-ba61-5bb36ea2ad71",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:43+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eddff6a8-b9d4-4f04-8d68-cb74f0835a6b",
        "planning_id": "17463313-73ad-4872-82b9-3f0c620742e2",
        "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65"
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
      "id": "bbb1cfcf-a4c1-40f6-90e4-fdd6a71dda64",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:43+00:00",
        "updated_at": "2022-07-12T08:48:43+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "89c3df56-d253-4558-bc53-b3b931694dd0",
        "planning_id": "17463313-73ad-4872-82b9-3f0c620742e2",
        "order_id": "fdf09865-e6a5-46b7-8ad7-2d609f277b65"
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
          "order_id": "00dc7171-5399-4170-827e-acff64b5c43f",
          "items": [
            {
              "type": "bundles",
              "id": "295c7f00-1512-4b3f-8e9e-207bf35ccdb6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4fa4df03-8069-4bdc-b8c6-0c7bd1526fa7",
                  "id": "42d9c851-1a58-482c-9055-10a30646d817"
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
    "id": "296aec82-79c6-5c35-a387-7c17e789f59b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "00dc7171-5399-4170-827e-acff64b5c43f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "00dc7171-5399-4170-827e-acff64b5c43f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a95be2af-134f-4d7d-bf2a-7a8cdeacf8d5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d5a894a4-decb-42df-81e8-183c0542eda8"
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
      "id": "00dc7171-5399-4170-827e-acff64b5c43f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T08:48:46+00:00",
        "updated_at": "2022-07-12T08:48:47+00:00",
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
        "starts_at": "2022-07-10T08:45:00+00:00",
        "stops_at": "2022-07-14T08:45:00+00:00",
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
        "start_location_id": "0e275401-d37b-4274-af11-1c5ed1338b92",
        "stop_location_id": "0e275401-d37b-4274-af11-1c5ed1338b92"
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
      "id": "a95be2af-134f-4d7d-bf2a-7a8cdeacf8d5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T08:48:46+00:00",
        "updated_at": "2022-07-12T08:48:46+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "295c7f00-1512-4b3f-8e9e-207bf35ccdb6",
        "tax_category_id": null,
        "planning_id": "d5a894a4-decb-42df-81e8-183c0542eda8",
        "parent_line_id": null,
        "owner_id": "00dc7171-5399-4170-827e-acff64b5c43f",
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
      "id": "d5a894a4-decb-42df-81e8-183c0542eda8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T08:48:46+00:00",
        "updated_at": "2022-07-12T08:48:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-10T08:45:00+00:00",
        "stops_at": "2022-07-14T08:45:00+00:00",
        "reserved_from": "2022-07-10T08:45:00+00:00",
        "reserved_till": "2022-07-14T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "295c7f00-1512-4b3f-8e9e-207bf35ccdb6",
        "order_id": "00dc7171-5399-4170-827e-acff64b5c43f",
        "start_location_id": "0e275401-d37b-4274-af11-1c5ed1338b92",
        "stop_location_id": "0e275401-d37b-4274-af11-1c5ed1338b92",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>
`data[attributes][items][]` | **Array**<br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





