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
          "order_id": "431ee56b-2da0-451d-ba53-9d5ee2cfc1d4",
          "items": [
            {
              "type": "products",
              "id": "ea2f95a1-38b1-42b4-8b88-94ccd20aa3fd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5caec786-84e5-4e16-9a6e-b28bfbcc0f65",
              "stock_item_ids": [
                "220beefa-7e02-430a-9daf-0eb43fc8c35a",
                "abe6dd6c-6c7a-4370-9a0d-b8ba3b15fd33"
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
            "item_id": "ea2f95a1-38b1-42b4-8b88-94ccd20aa3fd",
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
          "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b",
          "items": [
            {
              "type": "products",
              "id": "456195bf-df99-4aa0-8b09-a3dbd3fe5b84",
              "stock_item_ids": [
                "062c0374-35b9-4794-8572-1b9bf322671e",
                "f38b2360-bac0-4a7d-a97a-3f6f7526bf6a",
                "4958b2e7-4664-4b1a-be6f-bc65b978550b"
              ]
            },
            {
              "type": "products",
              "id": "57cb9e87-ae83-4567-9a42-52145a179515",
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
    "id": "eae61b0a-75f7-5cfd-8d2c-c40beb6b1a22",
    "type": "order_bookings",
    "attributes": {
      "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "641212cd-5aa4-4879-af98-fad1eba2507b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b7b49bfe-675c-442f-ab7a-1c0a1398f81e"
          },
          {
            "type": "lines",
            "id": "db0984f0-1ed1-4540-84f7-9df993f90ab0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a0898848-191c-4383-916b-699b56a8932d"
          },
          {
            "type": "plannings",
            "id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c75e01c9-3459-4a44-8d0b-14a26ec191e2"
          },
          {
            "type": "stock_item_plannings",
            "id": "b89ce0f4-7d7b-4f5a-8576-80f0fe6875f6"
          },
          {
            "type": "stock_item_plannings",
            "id": "798021dc-190e-4454-90d1-a0116aebec7e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "641212cd-5aa4-4879-af98-fad1eba2507b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T08:54:59+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
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
        "customer_id": "fe8d52d2-c301-4e41-a251-dc8e02f8b399",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea",
        "stop_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea"
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
      "id": "b7b49bfe-675c-442f-ab7a-1c0a1398f81e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
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
        "item_id": "57cb9e87-ae83-4567-9a42-52145a179515",
        "tax_category_id": "b7985db4-0eb8-4404-856b-de6144680f95",
        "planning_id": "a0898848-191c-4383-916b-699b56a8932d",
        "parent_line_id": null,
        "owner_id": "641212cd-5aa4-4879-af98-fad1eba2507b",
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
      "id": "db0984f0-1ed1-4540-84f7-9df993f90ab0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T08:55:01+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
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
        "item_id": "456195bf-df99-4aa0-8b09-a3dbd3fe5b84",
        "tax_category_id": "b7985db4-0eb8-4404-856b-de6144680f95",
        "planning_id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a",
        "parent_line_id": null,
        "owner_id": "641212cd-5aa4-4879-af98-fad1eba2507b",
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
      "id": "a0898848-191c-4383-916b-699b56a8932d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
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
        "item_id": "57cb9e87-ae83-4567-9a42-52145a179515",
        "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b",
        "start_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea",
        "stop_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea",
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
      "id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
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
        "item_id": "456195bf-df99-4aa0-8b09-a3dbd3fe5b84",
        "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b",
        "start_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea",
        "stop_location_id": "1fdfd2a9-8829-4b87-a840-6a4f6763e0ea",
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
      "id": "c75e01c9-3459-4a44-8d0b-14a26ec191e2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "062c0374-35b9-4794-8572-1b9bf322671e",
        "planning_id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a",
        "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b"
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
      "id": "b89ce0f4-7d7b-4f5a-8576-80f0fe6875f6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f38b2360-bac0-4a7d-a97a-3f6f7526bf6a",
        "planning_id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a",
        "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b"
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
      "id": "798021dc-190e-4454-90d1-a0116aebec7e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:00+00:00",
        "updated_at": "2022-07-08T08:55:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4958b2e7-4664-4b1a-be6f-bc65b978550b",
        "planning_id": "6d33f314-eaac-44c4-ba3c-44f392fe3c4a",
        "order_id": "641212cd-5aa4-4879-af98-fad1eba2507b"
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
          "order_id": "3c66dc8e-41e2-41f4-b256-73456906b07a",
          "items": [
            {
              "type": "bundles",
              "id": "3cf9b9a7-3f97-4305-a8fe-966b91b9024c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3d347117-49d7-41c0-9c17-7dee937c2f48",
                  "id": "099bf111-8a18-41ed-a15e-f29d6c9efa35"
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
    "id": "c0da88be-7004-5b07-be24-01703a727fa1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3c66dc8e-41e2-41f4-b256-73456906b07a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3c66dc8e-41e2-41f4-b256-73456906b07a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "acb3fea2-067f-4053-818d-4a36d58ca25e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f34bbbe5-30b3-4bf1-9cc2-8efe39b5a775"
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
      "id": "3c66dc8e-41e2-41f4-b256-73456906b07a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T08:55:03+00:00",
        "updated_at": "2022-07-08T08:55:05+00:00",
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
        "starts_at": "2022-07-06T08:45:00+00:00",
        "stops_at": "2022-07-10T08:45:00+00:00",
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
        "start_location_id": "7d718eed-1913-4af4-83f6-985005a29611",
        "stop_location_id": "7d718eed-1913-4af4-83f6-985005a29611"
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
      "id": "acb3fea2-067f-4053-818d-4a36d58ca25e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T08:55:04+00:00",
        "updated_at": "2022-07-08T08:55:04+00:00",
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
        "item_id": "3cf9b9a7-3f97-4305-a8fe-966b91b9024c",
        "tax_category_id": null,
        "planning_id": "f34bbbe5-30b3-4bf1-9cc2-8efe39b5a775",
        "parent_line_id": null,
        "owner_id": "3c66dc8e-41e2-41f4-b256-73456906b07a",
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
      "id": "f34bbbe5-30b3-4bf1-9cc2-8efe39b5a775",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T08:55:04+00:00",
        "updated_at": "2022-07-08T08:55:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-06T08:45:00+00:00",
        "stops_at": "2022-07-10T08:45:00+00:00",
        "reserved_from": "2022-07-06T08:45:00+00:00",
        "reserved_till": "2022-07-10T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3cf9b9a7-3f97-4305-a8fe-966b91b9024c",
        "order_id": "3c66dc8e-41e2-41f4-b256-73456906b07a",
        "start_location_id": "7d718eed-1913-4af4-83f6-985005a29611",
        "stop_location_id": "7d718eed-1913-4af4-83f6-985005a29611",
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





