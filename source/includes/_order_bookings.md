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
          "order_id": "8daca410-0b81-4fb3-886e-55c8536b45e0",
          "items": [
            {
              "type": "products",
              "id": "930243fd-08b7-4694-8333-2fd8ec24fda3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "52cf515d-e212-437f-b47b-34609b184f32",
              "stock_item_ids": [
                "7bb7f692-6ec1-4340-a70c-96d8937b93b3",
                "e64a6cff-2a19-40be-b8f2-e04e7126d3eb"
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
            "item_id": "930243fd-08b7-4694-8333-2fd8ec24fda3",
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
          "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
          "items": [
            {
              "type": "products",
              "id": "a22c8f00-0480-4595-8661-8b64d3e77b7b",
              "stock_item_ids": [
                "7fe5e4ab-f373-4763-9f88-ba24920da132",
                "2fc54541-a8fc-4de4-aa48-13e23b507fa6",
                "16147534-0aee-438c-bb7f-fd99c19b9294"
              ]
            },
            {
              "type": "products",
              "id": "a08d6242-cf64-423e-aa48-fa5a840db4f9",
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
    "id": "e5007152-77ba-5403-a0b2-a0564f6b9ed0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f79b545f-463e-4b85-95a0-584df27dc255"
          },
          {
            "type": "lines",
            "id": "341a4d30-b7ef-4240-9601-035db62f4de8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "81e75c7a-8331-4793-bcec-9afc8c6c756b"
          },
          {
            "type": "plannings",
            "id": "8fba870d-249a-48df-9f2b-f3d0347f3fb3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "84b77bd0-46ee-4a97-a12d-7c8578f03f56"
          },
          {
            "type": "stock_item_plannings",
            "id": "5cee0b38-e0d9-446b-aeb4-511a3a48f619"
          },
          {
            "type": "stock_item_plannings",
            "id": "17700b27-52f6-46b1-ac7e-0d23aa0fc0d5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:59:36+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
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
        "customer_id": "3dbd190a-e53e-4e0b-86ec-685145347d61",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a",
        "stop_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a"
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
      "id": "f79b545f-463e-4b85-95a0-584df27dc255",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
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
        "item_id": "a22c8f00-0480-4595-8661-8b64d3e77b7b",
        "tax_category_id": "c5978049-c562-4580-8fec-f35e9064a579",
        "planning_id": "81e75c7a-8331-4793-bcec-9afc8c6c756b",
        "parent_line_id": null,
        "owner_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
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
      "id": "341a4d30-b7ef-4240-9601-035db62f4de8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
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
        "item_id": "a08d6242-cf64-423e-aa48-fa5a840db4f9",
        "tax_category_id": "c5978049-c562-4580-8fec-f35e9064a579",
        "planning_id": "8fba870d-249a-48df-9f2b-f3d0347f3fb3",
        "parent_line_id": null,
        "owner_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
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
      "id": "81e75c7a-8331-4793-bcec-9afc8c6c756b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
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
        "item_id": "a22c8f00-0480-4595-8661-8b64d3e77b7b",
        "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
        "start_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a",
        "stop_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a",
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
      "id": "8fba870d-249a-48df-9f2b-f3d0347f3fb3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
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
        "item_id": "a08d6242-cf64-423e-aa48-fa5a840db4f9",
        "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209",
        "start_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a",
        "stop_location_id": "fa984df0-6909-4aa2-ae66-89c9fcee5c9a",
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
      "id": "84b77bd0-46ee-4a97-a12d-7c8578f03f56",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7fe5e4ab-f373-4763-9f88-ba24920da132",
        "planning_id": "81e75c7a-8331-4793-bcec-9afc8c6c756b",
        "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209"
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
      "id": "5cee0b38-e0d9-446b-aeb4-511a3a48f619",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2fc54541-a8fc-4de4-aa48-13e23b507fa6",
        "planning_id": "81e75c7a-8331-4793-bcec-9afc8c6c756b",
        "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209"
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
      "id": "17700b27-52f6-46b1-ac7e-0d23aa0fc0d5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:37+00:00",
        "updated_at": "2023-02-02T16:59:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "16147534-0aee-438c-bb7f-fd99c19b9294",
        "planning_id": "81e75c7a-8331-4793-bcec-9afc8c6c756b",
        "order_id": "e9cfa21a-f8b0-4ce4-aef4-164f440a6209"
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
          "order_id": "6815f515-2227-4de3-ad6b-392013d4ba7f",
          "items": [
            {
              "type": "bundles",
              "id": "00613cc9-e215-485b-9c12-e6b160b489f0",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "51cc06bd-3498-4c4f-8e0f-f7da1c6283fc",
                  "id": "5f462d41-07cc-44bd-a192-c619d4c4341d"
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
    "id": "6af7852c-d1dd-5b5e-a0e2-7967b8f569df",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6815f515-2227-4de3-ad6b-392013d4ba7f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6815f515-2227-4de3-ad6b-392013d4ba7f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ce619d12-f078-458b-92b4-b5ab18f470fa"
          },
          {
            "type": "lines",
            "id": "740f98a2-325f-44e9-80d1-80855cad543b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a3ba65ac-84ad-4346-a2a0-ffd55f2c8d81"
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
      "id": "6815f515-2227-4de3-ad6b-392013d4ba7f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T16:59:39+00:00",
        "updated_at": "2023-02-02T16:59:40+00:00",
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
        "starts_at": "2023-01-31T16:45:00+00:00",
        "stops_at": "2023-02-04T16:45:00+00:00",
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
        "start_location_id": "64e48024-ee5f-4d41-9e1e-afb0dd74b72c",
        "stop_location_id": "64e48024-ee5f-4d41-9e1e-afb0dd74b72c"
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
      "id": "ce619d12-f078-458b-92b4-b5ab18f470fa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:59:40+00:00",
        "updated_at": "2023-02-02T16:59:40+00:00",
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
        "item_id": "5f462d41-07cc-44bd-a192-c619d4c4341d",
        "tax_category_id": null,
        "planning_id": "6d098aae-1323-4c0b-bc42-2dc71d2d026b",
        "parent_line_id": "740f98a2-325f-44e9-80d1-80855cad543b",
        "owner_id": "6815f515-2227-4de3-ad6b-392013d4ba7f",
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
      "id": "740f98a2-325f-44e9-80d1-80855cad543b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T16:59:40+00:00",
        "updated_at": "2023-02-02T16:59:40+00:00",
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
        "item_id": "00613cc9-e215-485b-9c12-e6b160b489f0",
        "tax_category_id": null,
        "planning_id": "a3ba65ac-84ad-4346-a2a0-ffd55f2c8d81",
        "parent_line_id": null,
        "owner_id": "6815f515-2227-4de3-ad6b-392013d4ba7f",
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
      "id": "a3ba65ac-84ad-4346-a2a0-ffd55f2c8d81",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T16:59:40+00:00",
        "updated_at": "2023-02-02T16:59:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T16:45:00+00:00",
        "stops_at": "2023-02-04T16:45:00+00:00",
        "reserved_from": "2023-01-31T16:45:00+00:00",
        "reserved_till": "2023-02-04T16:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "00613cc9-e215-485b-9c12-e6b160b489f0",
        "order_id": "6815f515-2227-4de3-ad6b-392013d4ba7f",
        "start_location_id": "64e48024-ee5f-4d41-9e1e-afb0dd74b72c",
        "stop_location_id": "64e48024-ee5f-4d41-9e1e-afb0dd74b72c",
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





