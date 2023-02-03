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
          "order_id": "3741e53f-087a-4eda-b26c-7c88a067d48b",
          "items": [
            {
              "type": "products",
              "id": "c74c299b-26de-4b77-980d-1546cf7ddb16",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2ef8f70b-575b-4e4b-b386-1688474856f6",
              "stock_item_ids": [
                "bd0a9267-391a-45d4-938f-575eb78d349b",
                "e392abce-c708-4dc0-854c-d308fd54e8e0"
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
            "item_id": "c74c299b-26de-4b77-980d-1546cf7ddb16",
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
          "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
          "items": [
            {
              "type": "products",
              "id": "cd4ef926-628c-4ea9-9299-00b279ab5aeb",
              "stock_item_ids": [
                "214ee3ee-a854-48f8-ba75-c43a4da73ae3",
                "431e6144-09d9-4c8f-ab1f-df72a24e0990",
                "abe6a473-91ce-43d7-b315-b566d79ae76c"
              ]
            },
            {
              "type": "products",
              "id": "2786e043-da7b-44fa-8a93-06ace65283bc",
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
    "id": "d3fd1d61-6dee-5b10-aa72-30e0a0b3dcc0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "93e2e460-0f31-4e02-9af4-1ad6dc10bc6b"
          },
          {
            "type": "lines",
            "id": "cec3cf27-2368-4995-96dd-d3767a21b389"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b"
          },
          {
            "type": "plannings",
            "id": "8aca74fb-b44c-4ac8-ba52-e570f717e6e9"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1bb44dcd-c829-4fa5-b666-a65bd9315bfd"
          },
          {
            "type": "stock_item_plannings",
            "id": "388a640d-6a43-484e-8773-c213f6788842"
          },
          {
            "type": "stock_item_plannings",
            "id": "1d9c9c2a-b149-45a3-a2f8-592ac4f07773"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T08:15:38+00:00",
        "updated_at": "2023-02-03T08:15:40+00:00",
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
        "customer_id": "3a938b2d-a327-4a61-8ef7-f4f4802378e0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "55ac6894-fa79-4846-92a9-4484423f229e",
        "stop_location_id": "55ac6894-fa79-4846-92a9-4484423f229e"
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
      "id": "93e2e460-0f31-4e02-9af4-1ad6dc10bc6b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:39+00:00",
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
        "item_id": "cd4ef926-628c-4ea9-9299-00b279ab5aeb",
        "tax_category_id": "1f4afa2b-057e-401a-b118-f9f576cb6d74",
        "planning_id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b",
        "parent_line_id": null,
        "owner_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
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
      "id": "cec3cf27-2368-4995-96dd-d3767a21b389",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:39+00:00",
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
        "item_id": "2786e043-da7b-44fa-8a93-06ace65283bc",
        "tax_category_id": "1f4afa2b-057e-401a-b118-f9f576cb6d74",
        "planning_id": "8aca74fb-b44c-4ac8-ba52-e570f717e6e9",
        "parent_line_id": null,
        "owner_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
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
      "id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:40+00:00",
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
        "item_id": "cd4ef926-628c-4ea9-9299-00b279ab5aeb",
        "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
        "start_location_id": "55ac6894-fa79-4846-92a9-4484423f229e",
        "stop_location_id": "55ac6894-fa79-4846-92a9-4484423f229e",
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
      "id": "8aca74fb-b44c-4ac8-ba52-e570f717e6e9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:40+00:00",
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
        "item_id": "2786e043-da7b-44fa-8a93-06ace65283bc",
        "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4",
        "start_location_id": "55ac6894-fa79-4846-92a9-4484423f229e",
        "stop_location_id": "55ac6894-fa79-4846-92a9-4484423f229e",
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
      "id": "1bb44dcd-c829-4fa5-b666-a65bd9315bfd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "214ee3ee-a854-48f8-ba75-c43a4da73ae3",
        "planning_id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b",
        "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4"
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
      "id": "388a640d-6a43-484e-8773-c213f6788842",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "431e6144-09d9-4c8f-ab1f-df72a24e0990",
        "planning_id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b",
        "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4"
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
      "id": "1d9c9c2a-b149-45a3-a2f8-592ac4f07773",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:39+00:00",
        "updated_at": "2023-02-03T08:15:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "abe6a473-91ce-43d7-b315-b566d79ae76c",
        "planning_id": "b0d64856-9f7a-447d-a699-5e8340fdbc0b",
        "order_id": "e289ce8c-fc48-42f9-8e63-3a7b958a27c4"
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
          "order_id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f",
          "items": [
            {
              "type": "bundles",
              "id": "1715707d-e608-4075-80fd-fd7ad2bf3c02",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b7bd6c5b-1b52-4205-bdb3-4ef5aad0146e",
                  "id": "84282e80-9bf4-4479-8fff-b87b99eecf4e"
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
    "id": "2d2d9bee-7acb-5246-b444-d0c397ce53c9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bfa65e02-d92f-47dc-9ceb-93e094725b9b"
          },
          {
            "type": "lines",
            "id": "23f09df0-087d-454d-ba5a-8f396d173614"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fa5d6b0a-8c13-4d72-b174-f5451939b48c"
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
      "id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T08:15:42+00:00",
        "updated_at": "2023-02-03T08:15:42+00:00",
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
        "starts_at": "2023-02-01T08:15:00+00:00",
        "stops_at": "2023-02-05T08:15:00+00:00",
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
        "start_location_id": "8834494e-b67e-404f-91d9-29c03297d950",
        "stop_location_id": "8834494e-b67e-404f-91d9-29c03297d950"
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
      "id": "bfa65e02-d92f-47dc-9ceb-93e094725b9b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:15:42+00:00",
        "updated_at": "2023-02-03T08:15:42+00:00",
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
        "item_id": "84282e80-9bf4-4479-8fff-b87b99eecf4e",
        "tax_category_id": null,
        "planning_id": "4ea7221a-1084-4173-af11-87935070837a",
        "parent_line_id": "23f09df0-087d-454d-ba5a-8f396d173614",
        "owner_id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f",
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
      "id": "23f09df0-087d-454d-ba5a-8f396d173614",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:15:42+00:00",
        "updated_at": "2023-02-03T08:15:42+00:00",
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
        "item_id": "1715707d-e608-4075-80fd-fd7ad2bf3c02",
        "tax_category_id": null,
        "planning_id": "fa5d6b0a-8c13-4d72-b174-f5451939b48c",
        "parent_line_id": null,
        "owner_id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f",
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
      "id": "fa5d6b0a-8c13-4d72-b174-f5451939b48c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:15:42+00:00",
        "updated_at": "2023-02-03T08:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T08:15:00+00:00",
        "stops_at": "2023-02-05T08:15:00+00:00",
        "reserved_from": "2023-02-01T08:15:00+00:00",
        "reserved_till": "2023-02-05T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1715707d-e608-4075-80fd-fd7ad2bf3c02",
        "order_id": "fc428186-d0f0-4e8c-aaf8-5f6f41e1e94f",
        "start_location_id": "8834494e-b67e-404f-91d9-29c03297d950",
        "stop_location_id": "8834494e-b67e-404f-91d9-29c03297d950",
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





