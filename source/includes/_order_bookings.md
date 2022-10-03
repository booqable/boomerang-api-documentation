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
          "order_id": "1224062e-5987-49d6-9aa0-c6d4884aaa9b",
          "items": [
            {
              "type": "products",
              "id": "0834dc84-ae06-4366-8bad-0be10e18ea9d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "238e26ab-2af9-4504-ad2f-aa1a3be880bd",
              "stock_item_ids": [
                "af3c0a73-9d2b-42da-9e61-b9f84d86393b",
                "de156547-a148-4ed1-a047-898271682e4f"
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
            "item_id": "0834dc84-ae06-4366-8bad-0be10e18ea9d",
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
          "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7",
          "items": [
            {
              "type": "products",
              "id": "96ac83d0-fac4-4f65-b8ff-628d395127a1",
              "stock_item_ids": [
                "8732b096-fd2e-4eca-9651-8abd7f9334ca",
                "48fdc1fb-60df-4ad9-9427-c04ad992285e",
                "66f1baa3-0fbd-4c43-bc25-a64fbb26f77c"
              ]
            },
            {
              "type": "products",
              "id": "dce5a9fb-a9e2-4b5f-8d36-21656c385c83",
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
    "id": "4e5c5feb-206e-5c12-86a0-20a8869f8651",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aeccec57-4293-491f-b74c-6a953d5572c7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "86c59c09-001d-4a6c-9298-e2ff1c8ddb4d"
          },
          {
            "type": "lines",
            "id": "e72fd81c-96b1-4b79-9c0f-e37a66d02bb6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1e711b54-120a-4946-9757-331dfdf1a66c"
          },
          {
            "type": "plannings",
            "id": "83998a51-40a1-46b8-b670-ed8313ff4342"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1ac20e69-b9db-47ed-95ef-8a51f270ea0c"
          },
          {
            "type": "stock_item_plannings",
            "id": "42582662-226d-446c-9719-1eff0c9eb6f7"
          },
          {
            "type": "stock_item_plannings",
            "id": "64714f56-8def-40ea-9353-431280b2c4c3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "aeccec57-4293-491f-b74c-6a953d5572c7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-30T11:59:09+00:00",
        "updated_at": "2022-09-30T11:59:13+00:00",
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
        "customer_id": "aa57aa89-34cd-4110-bbfd-710c43df1140",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04",
        "stop_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04"
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
      "id": "86c59c09-001d-4a6c-9298-e2ff1c8ddb4d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:12+00:00",
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
        "item_id": "96ac83d0-fac4-4f65-b8ff-628d395127a1",
        "tax_category_id": "eb635c54-7c63-48ac-9fee-2f01a85ca5c1",
        "planning_id": "1e711b54-120a-4946-9757-331dfdf1a66c",
        "parent_line_id": null,
        "owner_id": "aeccec57-4293-491f-b74c-6a953d5572c7",
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
      "id": "e72fd81c-96b1-4b79-9c0f-e37a66d02bb6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:12+00:00",
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
        "item_id": "dce5a9fb-a9e2-4b5f-8d36-21656c385c83",
        "tax_category_id": "eb635c54-7c63-48ac-9fee-2f01a85ca5c1",
        "planning_id": "83998a51-40a1-46b8-b670-ed8313ff4342",
        "parent_line_id": null,
        "owner_id": "aeccec57-4293-491f-b74c-6a953d5572c7",
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
      "id": "1e711b54-120a-4946-9757-331dfdf1a66c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:13+00:00",
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
        "item_id": "96ac83d0-fac4-4f65-b8ff-628d395127a1",
        "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7",
        "start_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04",
        "stop_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04",
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
      "id": "83998a51-40a1-46b8-b670-ed8313ff4342",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:13+00:00",
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
        "item_id": "dce5a9fb-a9e2-4b5f-8d36-21656c385c83",
        "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7",
        "start_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04",
        "stop_location_id": "08b97a01-075c-4ac3-b2a3-b066eeb4ea04",
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
      "id": "1ac20e69-b9db-47ed-95ef-8a51f270ea0c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8732b096-fd2e-4eca-9651-8abd7f9334ca",
        "planning_id": "1e711b54-120a-4946-9757-331dfdf1a66c",
        "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7"
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
      "id": "42582662-226d-446c-9719-1eff0c9eb6f7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "48fdc1fb-60df-4ad9-9427-c04ad992285e",
        "planning_id": "1e711b54-120a-4946-9757-331dfdf1a66c",
        "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7"
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
      "id": "64714f56-8def-40ea-9353-431280b2c4c3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:12+00:00",
        "updated_at": "2022-09-30T11:59:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66f1baa3-0fbd-4c43-bc25-a64fbb26f77c",
        "planning_id": "1e711b54-120a-4946-9757-331dfdf1a66c",
        "order_id": "aeccec57-4293-491f-b74c-6a953d5572c7"
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
          "order_id": "a2cd34f9-c72d-4351-b988-d99118a43d7b",
          "items": [
            {
              "type": "bundles",
              "id": "929cc012-e039-44ae-8c47-a4fef8aeef69",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ed84fcf5-1643-4dcb-ba26-42af1ac3d5e8",
                  "id": "80b7a9fa-3ebb-4366-9dd1-48e2913bb278"
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
    "id": "956988be-2641-5342-928c-b9445221f60c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a2cd34f9-c72d-4351-b988-d99118a43d7b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a2cd34f9-c72d-4351-b988-d99118a43d7b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "13caf1b6-cd9a-4fea-bfd8-224898c23b50"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "708d9005-2f64-43ba-a5cc-5572fb3ee768"
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
      "id": "a2cd34f9-c72d-4351-b988-d99118a43d7b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-30T11:59:15+00:00",
        "updated_at": "2022-09-30T11:59:16+00:00",
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
        "starts_at": "2022-09-28T11:45:00+00:00",
        "stops_at": "2022-10-02T11:45:00+00:00",
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
        "start_location_id": "bf16cdc1-1870-4c7f-943c-495a5984d7fc",
        "stop_location_id": "bf16cdc1-1870-4c7f-943c-495a5984d7fc"
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
      "id": "13caf1b6-cd9a-4fea-bfd8-224898c23b50",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-30T11:59:16+00:00",
        "updated_at": "2022-09-30T11:59:16+00:00",
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
        "item_id": "929cc012-e039-44ae-8c47-a4fef8aeef69",
        "tax_category_id": null,
        "planning_id": "708d9005-2f64-43ba-a5cc-5572fb3ee768",
        "parent_line_id": null,
        "owner_id": "a2cd34f9-c72d-4351-b988-d99118a43d7b",
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
      "id": "708d9005-2f64-43ba-a5cc-5572fb3ee768",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-30T11:59:16+00:00",
        "updated_at": "2022-09-30T11:59:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-28T11:45:00+00:00",
        "stops_at": "2022-10-02T11:45:00+00:00",
        "reserved_from": "2022-09-28T11:45:00+00:00",
        "reserved_till": "2022-10-02T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "929cc012-e039-44ae-8c47-a4fef8aeef69",
        "order_id": "a2cd34f9-c72d-4351-b988-d99118a43d7b",
        "start_location_id": "bf16cdc1-1870-4c7f-943c-495a5984d7fc",
        "stop_location_id": "bf16cdc1-1870-4c7f-943c-495a5984d7fc",
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





