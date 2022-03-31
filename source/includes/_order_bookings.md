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
          "order_id": "2a00542f-5a89-408b-8404-837b3b917336",
          "items": [
            {
              "type": "products",
              "id": "6a011e74-f75f-43e0-95be-83d619602688",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "eac5ac3e-8774-4251-9156-2d7e80bfaef0",
              "stock_item_ids": [
                "57fe7f48-1cbb-4b1d-8910-85f51b6d64c3",
                "f89a0716-e538-45c5-bce8-c76ee18f8586"
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
            "item_id": "6a011e74-f75f-43e0-95be-83d619602688",
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
          "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
          "items": [
            {
              "type": "products",
              "id": "e329e2e7-7481-4b48-9354-233e4ed37ce1",
              "stock_item_ids": [
                "d44a77b0-af62-422f-a318-10e4a118509b",
                "de986dda-b564-4ec4-bf56-3717e6d3e228",
                "cc5c5337-7a10-44d3-ae84-3d4c0435fb84"
              ]
            },
            {
              "type": "products",
              "id": "b9ad7f50-fbbe-4978-8dc5-b9ac1d226efe",
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
    "id": "20b0b87d-5ba4-533a-b783-abe519765460",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e9265ab4-8e93-4507-88f8-1ce1b22560af"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "daab7f37-ab9f-4c94-af5f-82586c4edbdc"
          },
          {
            "type": "lines",
            "id": "b1274c37-9c9c-4085-bc18-b94ef238e236"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6b9218bc-4411-40a8-9175-d9cda3c60bac"
          },
          {
            "type": "plannings",
            "id": "91c32218-fd65-404c-aa00-2aebd2914e53"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3162915d-4ff1-4bfa-b5f2-f1ca8acd07c9"
          },
          {
            "type": "stock_item_plannings",
            "id": "e218df0f-d8c3-49aa-9090-787bf89fc4b2"
          },
          {
            "type": "stock_item_plannings",
            "id": "e9b30579-6aa3-4ac9-942b-e4f83a0524b1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-31T14:16:04+00:00",
        "updated_at": "2022-03-31T14:16:07+00:00",
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
        "customer_id": "6d5e3d14-a64b-4887-8586-efe7f8651275",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d",
        "stop_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d"
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
      "id": "daab7f37-ab9f-4c94-af5f-82586c4edbdc",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-31T14:16:05+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
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
        "item_id": "b9ad7f50-fbbe-4978-8dc5-b9ac1d226efe",
        "tax_category_id": "76346bd2-bbb3-4aaf-a6d9-0fc375cbc124",
        "planning_id": "6b9218bc-4411-40a8-9175-d9cda3c60bac",
        "parent_line_id": null,
        "owner_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
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
      "id": "b1274c37-9c9c-4085-bc18-b94ef238e236",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-31T14:16:06+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
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
        "item_id": "e329e2e7-7481-4b48-9354-233e4ed37ce1",
        "tax_category_id": "76346bd2-bbb3-4aaf-a6d9-0fc375cbc124",
        "planning_id": "91c32218-fd65-404c-aa00-2aebd2914e53",
        "parent_line_id": null,
        "owner_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
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
      "id": "6b9218bc-4411-40a8-9175-d9cda3c60bac",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:05+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
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
        "item_id": "b9ad7f50-fbbe-4978-8dc5-b9ac1d226efe",
        "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
        "start_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d",
        "stop_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d",
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
      "id": "91c32218-fd65-404c-aa00-2aebd2914e53",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:06+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
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
        "item_id": "e329e2e7-7481-4b48-9354-233e4ed37ce1",
        "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af",
        "start_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d",
        "stop_location_id": "daa8929c-68c2-4855-b0f4-85f6baa0444d",
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
      "id": "3162915d-4ff1-4bfa-b5f2-f1ca8acd07c9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:06+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d44a77b0-af62-422f-a318-10e4a118509b",
        "planning_id": "91c32218-fd65-404c-aa00-2aebd2914e53",
        "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af"
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
      "id": "e218df0f-d8c3-49aa-9090-787bf89fc4b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:06+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "de986dda-b564-4ec4-bf56-3717e6d3e228",
        "planning_id": "91c32218-fd65-404c-aa00-2aebd2914e53",
        "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af"
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
      "id": "e9b30579-6aa3-4ac9-942b-e4f83a0524b1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:06+00:00",
        "updated_at": "2022-03-31T14:16:06+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cc5c5337-7a10-44d3-ae84-3d4c0435fb84",
        "planning_id": "91c32218-fd65-404c-aa00-2aebd2914e53",
        "order_id": "e9265ab4-8e93-4507-88f8-1ce1b22560af"
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
          "order_id": "a6acb2d5-8770-433b-903c-7452bbad39fc",
          "items": [
            {
              "type": "bundles",
              "id": "829fa022-25dc-40ac-8d65-d6f3574a42a2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0c192603-b807-452a-80fc-b9ab99b40a35",
                  "id": "7b2f020c-a544-4b9f-9b4b-cbedd58746aa"
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
    "id": "f96d6595-1325-556e-af5b-5616e30d6c2a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a6acb2d5-8770-433b-903c-7452bbad39fc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a6acb2d5-8770-433b-903c-7452bbad39fc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c4ef337d-fc4b-42ba-b8ff-1f3824f0250e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cdaea93f-03f2-44bc-acbe-7eee39210934"
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
      "id": "a6acb2d5-8770-433b-903c-7452bbad39fc",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-31T14:16:10+00:00",
        "updated_at": "2022-03-31T14:16:11+00:00",
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
        "starts_at": "2022-03-29T14:15:00+00:00",
        "stops_at": "2022-04-02T14:15:00+00:00",
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
        "start_location_id": "b4fcb389-ccc6-4253-a3d0-848fb1034c67",
        "stop_location_id": "b4fcb389-ccc6-4253-a3d0-848fb1034c67"
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
      "id": "c4ef337d-fc4b-42ba-b8ff-1f3824f0250e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-31T14:16:11+00:00",
        "updated_at": "2022-03-31T14:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "829fa022-25dc-40ac-8d65-d6f3574a42a2",
        "tax_category_id": null,
        "planning_id": "cdaea93f-03f2-44bc-acbe-7eee39210934",
        "parent_line_id": null,
        "owner_id": "a6acb2d5-8770-433b-903c-7452bbad39fc",
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
      "id": "cdaea93f-03f2-44bc-acbe-7eee39210934",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-31T14:16:11+00:00",
        "updated_at": "2022-03-31T14:16:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-29T14:15:00+00:00",
        "stops_at": "2022-04-02T14:15:00+00:00",
        "reserved_from": "2022-03-29T14:15:00+00:00",
        "reserved_till": "2022-04-02T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "829fa022-25dc-40ac-8d65-d6f3574a42a2",
        "order_id": "a6acb2d5-8770-433b-903c-7452bbad39fc",
        "start_location_id": "b4fcb389-ccc6-4253-a3d0-848fb1034c67",
        "stop_location_id": "b4fcb389-ccc6-4253-a3d0-848fb1034c67",
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





