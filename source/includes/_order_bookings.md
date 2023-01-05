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
          "order_id": "c34b40e1-8f8c-4a80-8237-7d01cf459221",
          "items": [
            {
              "type": "products",
              "id": "571ece1a-b8ca-4062-942e-27b22615e8c6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c922118f-49f9-4dbf-80d0-6aea6974aa78",
              "stock_item_ids": [
                "fd744e94-a9c1-4bc8-830f-e0fbeb5f650d",
                "51dbb6d9-df95-4d2d-8d56-49896f6c85a1"
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
            "item_id": "571ece1a-b8ca-4062-942e-27b22615e8c6",
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
          "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
          "items": [
            {
              "type": "products",
              "id": "f4dc96f9-f5ef-410b-a57e-f73eeab341ce",
              "stock_item_ids": [
                "49a689e5-22ff-4514-8571-31ef2e2e951b",
                "13276ee8-8b5f-451f-bd83-4e4288331e1b",
                "60ed947c-e5c1-4bef-acdf-dd2538db30c8"
              ]
            },
            {
              "type": "products",
              "id": "79263c2a-f83f-4e18-b83c-6b602ef6918a",
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
    "id": "2918a6cb-cd8c-586b-811d-1a6aea351d69",
    "type": "order_bookings",
    "attributes": {
      "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "85e2b154-a52c-4056-b95c-c6a1550c0c68"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "58be1db0-b9cd-4154-9e16-f172f23418f5"
          },
          {
            "type": "lines",
            "id": "55dce853-c62f-4ee0-9c8c-a58ac3d9b9f2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c8fe9c26-97a3-4133-a558-98bf3cf70929"
          },
          {
            "type": "plannings",
            "id": "e09a0305-7cb4-4424-8fb4-60b970128a81"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0a81d56c-1277-411e-9c95-57eea3b53ead"
          },
          {
            "type": "stock_item_plannings",
            "id": "0a30f577-0a72-4f4f-b690-017871f695c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "9b78d895-dfff-4a6d-b976-342ac243c50a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:03:54+00:00",
        "updated_at": "2023-01-05T13:03:57+00:00",
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
        "customer_id": "a7bae2dc-c318-48a0-98a5-67305cad7ae8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad",
        "stop_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad"
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
      "id": "58be1db0-b9cd-4154-9e16-f172f23418f5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:57+00:00",
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
        "item_id": "f4dc96f9-f5ef-410b-a57e-f73eeab341ce",
        "tax_category_id": "f3065bea-f283-49a1-b6c5-6e51e8a3e03a",
        "planning_id": "c8fe9c26-97a3-4133-a558-98bf3cf70929",
        "parent_line_id": null,
        "owner_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
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
      "id": "55dce853-c62f-4ee0-9c8c-a58ac3d9b9f2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:57+00:00",
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
        "item_id": "79263c2a-f83f-4e18-b83c-6b602ef6918a",
        "tax_category_id": "f3065bea-f283-49a1-b6c5-6e51e8a3e03a",
        "planning_id": "e09a0305-7cb4-4424-8fb4-60b970128a81",
        "parent_line_id": null,
        "owner_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
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
      "id": "c8fe9c26-97a3-4133-a558-98bf3cf70929",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:57+00:00",
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
        "item_id": "f4dc96f9-f5ef-410b-a57e-f73eeab341ce",
        "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
        "start_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad",
        "stop_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad",
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
      "id": "e09a0305-7cb4-4424-8fb4-60b970128a81",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:57+00:00",
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
        "item_id": "79263c2a-f83f-4e18-b83c-6b602ef6918a",
        "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68",
        "start_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad",
        "stop_location_id": "f8978532-4987-4f31-b94d-f481b6d91aad",
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
      "id": "0a81d56c-1277-411e-9c95-57eea3b53ead",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "49a689e5-22ff-4514-8571-31ef2e2e951b",
        "planning_id": "c8fe9c26-97a3-4133-a558-98bf3cf70929",
        "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68"
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
      "id": "0a30f577-0a72-4f4f-b690-017871f695c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "13276ee8-8b5f-451f-bd83-4e4288331e1b",
        "planning_id": "c8fe9c26-97a3-4133-a558-98bf3cf70929",
        "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68"
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
      "id": "9b78d895-dfff-4a6d-b976-342ac243c50a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:03:56+00:00",
        "updated_at": "2023-01-05T13:03:56+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "60ed947c-e5c1-4bef-acdf-dd2538db30c8",
        "planning_id": "c8fe9c26-97a3-4133-a558-98bf3cf70929",
        "order_id": "85e2b154-a52c-4056-b95c-c6a1550c0c68"
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
          "order_id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93",
          "items": [
            {
              "type": "bundles",
              "id": "ce5db57e-f7f6-40f1-a0d3-bb1872132a3d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "22996f05-8980-4db7-90d6-9afc74c1527a",
                  "id": "01001ae1-f8ce-4d35-8a1c-925c5e380b45"
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
    "id": "41642793-cccb-5ac5-8589-5136a90dd1ef",
    "type": "order_bookings",
    "attributes": {
      "order_id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "12642229-11ab-4924-bb3d-383eeaaef7b5"
          },
          {
            "type": "lines",
            "id": "eec807b6-3946-4733-b827-65b5ecac5da2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8e1d02f1-034f-46b5-8b78-72624979f5af"
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
      "id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:04:03+00:00",
        "updated_at": "2023-01-05T13:04:04+00:00",
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
        "starts_at": "2023-01-03T13:00:00+00:00",
        "stops_at": "2023-01-07T13:00:00+00:00",
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
        "start_location_id": "55f4cf50-d886-4e44-adda-6b35db253ccf",
        "stop_location_id": "55f4cf50-d886-4e44-adda-6b35db253ccf"
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
      "id": "12642229-11ab-4924-bb3d-383eeaaef7b5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:04:04+00:00",
        "updated_at": "2023-01-05T13:04:04+00:00",
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
        "item_id": "01001ae1-f8ce-4d35-8a1c-925c5e380b45",
        "tax_category_id": null,
        "planning_id": "7ccf602d-a734-42ad-a1cd-25f31333b240",
        "parent_line_id": "eec807b6-3946-4733-b827-65b5ecac5da2",
        "owner_id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93",
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
      "id": "eec807b6-3946-4733-b827-65b5ecac5da2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:04:04+00:00",
        "updated_at": "2023-01-05T13:04:04+00:00",
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
        "item_id": "ce5db57e-f7f6-40f1-a0d3-bb1872132a3d",
        "tax_category_id": null,
        "planning_id": "8e1d02f1-034f-46b5-8b78-72624979f5af",
        "parent_line_id": null,
        "owner_id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93",
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
      "id": "8e1d02f1-034f-46b5-8b78-72624979f5af",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:04:04+00:00",
        "updated_at": "2023-01-05T13:04:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T13:00:00+00:00",
        "stops_at": "2023-01-07T13:00:00+00:00",
        "reserved_from": "2023-01-03T13:00:00+00:00",
        "reserved_till": "2023-01-07T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ce5db57e-f7f6-40f1-a0d3-bb1872132a3d",
        "order_id": "260e7e83-6eb3-4f3d-a0fb-1fad12ef3d93",
        "start_location_id": "55f4cf50-d886-4e44-adda-6b35db253ccf",
        "stop_location_id": "55f4cf50-d886-4e44-adda-6b35db253ccf",
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





