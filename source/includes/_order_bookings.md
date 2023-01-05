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
          "order_id": "874f1435-bc26-416d-85be-5c764a882a16",
          "items": [
            {
              "type": "products",
              "id": "c2d1933a-e1aa-4ac1-b920-5e2c8a4a0c6f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1eb06b6a-c86b-4167-bf35-c9d603974ab4",
              "stock_item_ids": [
                "b8a3b453-8a9c-4a06-9670-bf00e186f708",
                "e0b8b2b7-defb-4c98-9667-1c81e775e5a3"
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
            "item_id": "c2d1933a-e1aa-4ac1-b920-5e2c8a4a0c6f",
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
          "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
          "items": [
            {
              "type": "products",
              "id": "ba3abae3-2d5d-4ff8-b123-0318fe2ab2d6",
              "stock_item_ids": [
                "d52a1cc6-dfa2-431c-b173-6dafb842492c",
                "e6628424-5ffd-48a0-86af-97bb1594f298",
                "8fc26fc9-f608-4d8c-81cd-c4fc76453cc3"
              ]
            },
            {
              "type": "products",
              "id": "9d1a7184-8013-4505-ba72-824573f9b0b7",
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
    "id": "4943daaf-1b38-5271-9ffc-97ce7ed27dbd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "062d83bb-387d-409d-85bb-5250737026e5"
          },
          {
            "type": "lines",
            "id": "3d5a64a2-46aa-4a21-9feb-58c171419315"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f66ff400-766d-4c50-8942-c91e5e7cec9f"
          },
          {
            "type": "plannings",
            "id": "5f9099a3-5f31-4b92-b7fb-2cda849936b4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "afae2814-b00c-415f-81a7-1a5f100dcab8"
          },
          {
            "type": "stock_item_plannings",
            "id": "7097a4a4-4fef-42da-bc44-bd2373231a73"
          },
          {
            "type": "stock_item_plannings",
            "id": "800002da-bb7f-4162-ad3c-69e10c36b805"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T11:27:54+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
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
        "customer_id": "3a8c512f-0d18-4936-ba8b-e8f901e33886",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c",
        "stop_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c"
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
      "id": "062d83bb-387d-409d-85bb-5250737026e5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
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
        "item_id": "ba3abae3-2d5d-4ff8-b123-0318fe2ab2d6",
        "tax_category_id": "5735d2cf-57da-46c1-8a19-2cf1db4e2312",
        "planning_id": "f66ff400-766d-4c50-8942-c91e5e7cec9f",
        "parent_line_id": null,
        "owner_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
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
      "id": "3d5a64a2-46aa-4a21-9feb-58c171419315",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
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
        "item_id": "9d1a7184-8013-4505-ba72-824573f9b0b7",
        "tax_category_id": "5735d2cf-57da-46c1-8a19-2cf1db4e2312",
        "planning_id": "5f9099a3-5f31-4b92-b7fb-2cda849936b4",
        "parent_line_id": null,
        "owner_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
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
      "id": "f66ff400-766d-4c50-8942-c91e5e7cec9f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
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
        "item_id": "ba3abae3-2d5d-4ff8-b123-0318fe2ab2d6",
        "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
        "start_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c",
        "stop_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c",
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
      "id": "5f9099a3-5f31-4b92-b7fb-2cda849936b4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
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
        "item_id": "9d1a7184-8013-4505-ba72-824573f9b0b7",
        "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b",
        "start_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c",
        "stop_location_id": "243c750f-ed30-4e5a-8ba8-66d4f528221c",
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
      "id": "afae2814-b00c-415f-81a7-1a5f100dcab8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d52a1cc6-dfa2-431c-b173-6dafb842492c",
        "planning_id": "f66ff400-766d-4c50-8942-c91e5e7cec9f",
        "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b"
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
      "id": "7097a4a4-4fef-42da-bc44-bd2373231a73",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e6628424-5ffd-48a0-86af-97bb1594f298",
        "planning_id": "f66ff400-766d-4c50-8942-c91e5e7cec9f",
        "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b"
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
      "id": "800002da-bb7f-4162-ad3c-69e10c36b805",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:55+00:00",
        "updated_at": "2023-01-05T11:27:55+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8fc26fc9-f608-4d8c-81cd-c4fc76453cc3",
        "planning_id": "f66ff400-766d-4c50-8942-c91e5e7cec9f",
        "order_id": "2bf6ca4e-87b4-4d7e-a1f3-ade68ed6e22b"
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
          "order_id": "f3ed672c-a5e9-4521-b405-415a8507bbc7",
          "items": [
            {
              "type": "bundles",
              "id": "f97e879d-154a-4948-9d81-121c3ba66dd0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "449a861a-0f3a-4cb3-8aaa-5a55bf002574",
                  "id": "68623d76-0cc3-4c75-a2dd-bc474afcadfb"
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
    "id": "519af805-ef71-5b97-b4a9-24ec25f217ce",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f3ed672c-a5e9-4521-b405-415a8507bbc7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f3ed672c-a5e9-4521-b405-415a8507bbc7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a52a8d3f-e5b8-44b8-8f64-6f674b7cedf2"
          },
          {
            "type": "lines",
            "id": "e8cc2d50-90b7-427e-84ff-c5db2b992ebd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "03703e1f-08fb-4642-bf2a-4d57fe9f0536"
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
      "id": "f3ed672c-a5e9-4521-b405-415a8507bbc7",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T11:27:57+00:00",
        "updated_at": "2023-01-05T11:27:58+00:00",
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
        "starts_at": "2023-01-03T11:15:00+00:00",
        "stops_at": "2023-01-07T11:15:00+00:00",
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
        "start_location_id": "5535af53-d016-475f-83d9-ff30c5efe4f8",
        "stop_location_id": "5535af53-d016-475f-83d9-ff30c5efe4f8"
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
      "id": "a52a8d3f-e5b8-44b8-8f64-6f674b7cedf2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:27:58+00:00",
        "updated_at": "2023-01-05T11:27:58+00:00",
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
        "item_id": "f97e879d-154a-4948-9d81-121c3ba66dd0",
        "tax_category_id": null,
        "planning_id": "03703e1f-08fb-4642-bf2a-4d57fe9f0536",
        "parent_line_id": null,
        "owner_id": "f3ed672c-a5e9-4521-b405-415a8507bbc7",
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
      "id": "e8cc2d50-90b7-427e-84ff-c5db2b992ebd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T11:27:58+00:00",
        "updated_at": "2023-01-05T11:27:58+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 9 - red",
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
        "item_id": "68623d76-0cc3-4c75-a2dd-bc474afcadfb",
        "tax_category_id": null,
        "planning_id": "6ca2eed0-83ad-46cb-ae8a-da610d08bc71",
        "parent_line_id": "a52a8d3f-e5b8-44b8-8f64-6f674b7cedf2",
        "owner_id": "f3ed672c-a5e9-4521-b405-415a8507bbc7",
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
      "id": "03703e1f-08fb-4642-bf2a-4d57fe9f0536",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T11:27:58+00:00",
        "updated_at": "2023-01-05T11:27:58+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T11:15:00+00:00",
        "stops_at": "2023-01-07T11:15:00+00:00",
        "reserved_from": "2023-01-03T11:15:00+00:00",
        "reserved_till": "2023-01-07T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f97e879d-154a-4948-9d81-121c3ba66dd0",
        "order_id": "f3ed672c-a5e9-4521-b405-415a8507bbc7",
        "start_location_id": "5535af53-d016-475f-83d9-ff30c5efe4f8",
        "stop_location_id": "5535af53-d016-475f-83d9-ff30c5efe4f8",
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





