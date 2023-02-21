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
          "order_id": "fc184b74-085d-4e95-b0d6-267b9b6a4302",
          "items": [
            {
              "type": "products",
              "id": "41b356f7-7d6c-4eda-80a5-d02747449891",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2f2f0bcd-ab2c-4d8b-a05c-487b921281ff",
              "stock_item_ids": [
                "1b4a6a7b-ea4c-4384-9f25-84d5c6dd1b1a",
                "4967e36b-8ee6-4b1c-9178-5eeca5081134"
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
          "stock_item_id 1b4a6a7b-ea4c-4384-9f25-84d5c6dd1b1a has already been booked on this order"
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
          "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
          "items": [
            {
              "type": "products",
              "id": "29a74ab1-e6de-400c-8c70-664d38a5fb1d",
              "stock_item_ids": [
                "67fce8e3-55aa-4c7d-8a82-a7478d348783",
                "d7bf1bc1-3a21-413e-a66a-6e336b4ea9c7",
                "2a91287c-436a-4c12-b9ce-f50721e8b3ae"
              ]
            },
            {
              "type": "products",
              "id": "aff3951f-83bb-4e5b-93c9-c84f87e4145d",
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
    "id": "542620d2-34a6-5e05-8aac-40b68f6f92f1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "df2d899d-a9cc-4d02-8057-7debd1a95f59"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "192a4cf6-9470-4f7f-89b5-9e0a068eac6b"
          },
          {
            "type": "lines",
            "id": "e9df7f0e-58fa-40f5-8e3c-781e920c5600"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b804e248-e2db-4699-b05a-b7d655d2cfde"
          },
          {
            "type": "plannings",
            "id": "36873d5e-a331-4cd0-995b-434cf2cd54d2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f7ea8e95-145f-4728-b6fd-b05366e25869"
          },
          {
            "type": "stock_item_plannings",
            "id": "e12b03f2-dd3c-4c08-851c-4ad1c91ff58f"
          },
          {
            "type": "stock_item_plannings",
            "id": "673c0931-6b43-4338-9817-7e75e3e96d10"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T10:49:46+00:00",
        "updated_at": "2023-02-21T10:49:48+00:00",
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
        "customer_id": "af0e122d-c608-4b67-bd30-32a33c25dbec",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0",
        "stop_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0"
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
      "id": "192a4cf6-9470-4f7f-89b5-9e0a068eac6b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
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
        "item_id": "29a74ab1-e6de-400c-8c70-664d38a5fb1d",
        "tax_category_id": "9fef7128-5af6-4cb5-8694-9556d55d2a0f",
        "planning_id": "b804e248-e2db-4699-b05a-b7d655d2cfde",
        "parent_line_id": null,
        "owner_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
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
      "id": "e9df7f0e-58fa-40f5-8e3c-781e920c5600",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
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
        "item_id": "aff3951f-83bb-4e5b-93c9-c84f87e4145d",
        "tax_category_id": "9fef7128-5af6-4cb5-8694-9556d55d2a0f",
        "planning_id": "36873d5e-a331-4cd0-995b-434cf2cd54d2",
        "parent_line_id": null,
        "owner_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
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
      "id": "b804e248-e2db-4699-b05a-b7d655d2cfde",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
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
        "item_id": "29a74ab1-e6de-400c-8c70-664d38a5fb1d",
        "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
        "start_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0",
        "stop_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0",
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
      "id": "36873d5e-a331-4cd0-995b-434cf2cd54d2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
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
        "item_id": "aff3951f-83bb-4e5b-93c9-c84f87e4145d",
        "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59",
        "start_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0",
        "stop_location_id": "24e18956-9f6d-4dfd-b10c-c3944154d0c0",
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
      "id": "f7ea8e95-145f-4728-b6fd-b05366e25869",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "67fce8e3-55aa-4c7d-8a82-a7478d348783",
        "planning_id": "b804e248-e2db-4699-b05a-b7d655d2cfde",
        "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59"
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
      "id": "e12b03f2-dd3c-4c08-851c-4ad1c91ff58f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d7bf1bc1-3a21-413e-a66a-6e336b4ea9c7",
        "planning_id": "b804e248-e2db-4699-b05a-b7d655d2cfde",
        "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59"
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
      "id": "673c0931-6b43-4338-9817-7e75e3e96d10",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:47+00:00",
        "updated_at": "2023-02-21T10:49:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2a91287c-436a-4c12-b9ce-f50721e8b3ae",
        "planning_id": "b804e248-e2db-4699-b05a-b7d655d2cfde",
        "order_id": "df2d899d-a9cc-4d02-8057-7debd1a95f59"
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
          "order_id": "adcd18d2-7586-475e-af04-12970ce29909",
          "items": [
            {
              "type": "bundles",
              "id": "075a52b3-3d54-463c-a1fd-ca6aa0ac556c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "009b2e16-d68e-4331-b5e6-4dc346fbf018",
                  "id": "19b02614-9df7-4c28-8150-48215db00e9b"
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
    "id": "6266b706-256e-53b1-8e6f-fe3a457243f4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "adcd18d2-7586-475e-af04-12970ce29909"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "adcd18d2-7586-475e-af04-12970ce29909"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2dbe6b5a-4a5c-4146-8b51-e2cb31fdb153"
          },
          {
            "type": "lines",
            "id": "737bbbcb-1a2b-4432-99aa-9e3310b01159"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e1779c7f-c13f-4cec-9869-cd73fa7459db"
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
      "id": "adcd18d2-7586-475e-af04-12970ce29909",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T10:49:49+00:00",
        "updated_at": "2023-02-21T10:49:50+00:00",
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
        "starts_at": "2023-02-19T10:45:00+00:00",
        "stops_at": "2023-02-23T10:45:00+00:00",
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
        "start_location_id": "9b197200-3d92-4771-8099-8776b9f06db9",
        "stop_location_id": "9b197200-3d92-4771-8099-8776b9f06db9"
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
      "id": "2dbe6b5a-4a5c-4146-8b51-e2cb31fdb153",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:49:50+00:00",
        "updated_at": "2023-02-21T10:49:50+00:00",
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
        "item_id": "19b02614-9df7-4c28-8150-48215db00e9b",
        "tax_category_id": null,
        "planning_id": "d7671efc-e3fc-4d10-9fba-3dd626a3e085",
        "parent_line_id": "737bbbcb-1a2b-4432-99aa-9e3310b01159",
        "owner_id": "adcd18d2-7586-475e-af04-12970ce29909",
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
      "id": "737bbbcb-1a2b-4432-99aa-9e3310b01159",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T10:49:50+00:00",
        "updated_at": "2023-02-21T10:49:50+00:00",
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
        "item_id": "075a52b3-3d54-463c-a1fd-ca6aa0ac556c",
        "tax_category_id": null,
        "planning_id": "e1779c7f-c13f-4cec-9869-cd73fa7459db",
        "parent_line_id": null,
        "owner_id": "adcd18d2-7586-475e-af04-12970ce29909",
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
      "id": "e1779c7f-c13f-4cec-9869-cd73fa7459db",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T10:49:50+00:00",
        "updated_at": "2023-02-21T10:49:50+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T10:45:00+00:00",
        "stops_at": "2023-02-23T10:45:00+00:00",
        "reserved_from": "2023-02-19T10:45:00+00:00",
        "reserved_till": "2023-02-23T10:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "075a52b3-3d54-463c-a1fd-ca6aa0ac556c",
        "order_id": "adcd18d2-7586-475e-af04-12970ce29909",
        "start_location_id": "9b197200-3d92-4771-8099-8776b9f06db9",
        "stop_location_id": "9b197200-3d92-4771-8099-8776b9f06db9",
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





