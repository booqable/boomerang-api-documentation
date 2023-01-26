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
          "order_id": "a298b203-4a63-48e9-86aa-2e5b442955b1",
          "items": [
            {
              "type": "products",
              "id": "6d623fa8-7a0b-43b4-b7bb-11746c855001",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "16f74f0e-bd98-4baf-b3ae-caba1c047e6a",
              "stock_item_ids": [
                "1e4e2f4f-0309-48f2-8cc4-3118719142eb",
                "894fa720-112f-4c36-b49b-01df3213f228"
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
            "item_id": "6d623fa8-7a0b-43b4-b7bb-11746c855001",
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
          "order_id": "917ac4d4-5083-4751-a663-00f3550511a6",
          "items": [
            {
              "type": "products",
              "id": "0a15d8ae-598e-4600-ade2-4c33ce69a606",
              "stock_item_ids": [
                "0f7dccc5-753f-4e2d-8984-25b4b7c688d8",
                "41952923-215b-4e82-bce8-42a30fdceada",
                "3b8c8efd-f566-4132-a476-c3d01461fd13"
              ]
            },
            {
              "type": "products",
              "id": "5b671e2b-f022-4749-bcdd-56457c5facf7",
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
    "id": "3439d55f-79a2-5d36-96f2-0eb774aff4fc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "917ac4d4-5083-4751-a663-00f3550511a6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "917ac4d4-5083-4751-a663-00f3550511a6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1a74a162-3549-4aef-b970-a379d7f9f5cd"
          },
          {
            "type": "lines",
            "id": "cc3bcb45-cedf-4cac-a649-e30f54513ccd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d4ed1011-eef0-4b27-89e8-34ea10457917"
          },
          {
            "type": "plannings",
            "id": "0928e1f3-88ca-4777-a0de-85c77dcd949e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "74297df6-a61f-4169-93c1-b3fc0eb447b8"
          },
          {
            "type": "stock_item_plannings",
            "id": "82702022-69e6-4f36-afb9-2c9a75a257cb"
          },
          {
            "type": "stock_item_plannings",
            "id": "fa6cc5b3-d756-42d4-85a0-e56063d1b9e5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "917ac4d4-5083-4751-a663-00f3550511a6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T10:21:17+00:00",
        "updated_at": "2023-01-26T10:21:19+00:00",
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
        "customer_id": "f512312c-1ba6-4256-9836-3126648a8095",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e",
        "stop_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e"
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
      "id": "1a74a162-3549-4aef-b970-a379d7f9f5cd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:19+00:00",
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
        "item_id": "0a15d8ae-598e-4600-ade2-4c33ce69a606",
        "tax_category_id": "2f7d46c7-94cb-489a-a13e-1cd9be7a863e",
        "planning_id": "d4ed1011-eef0-4b27-89e8-34ea10457917",
        "parent_line_id": null,
        "owner_id": "917ac4d4-5083-4751-a663-00f3550511a6",
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
      "id": "cc3bcb45-cedf-4cac-a649-e30f54513ccd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:19+00:00",
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
        "item_id": "5b671e2b-f022-4749-bcdd-56457c5facf7",
        "tax_category_id": "2f7d46c7-94cb-489a-a13e-1cd9be7a863e",
        "planning_id": "0928e1f3-88ca-4777-a0de-85c77dcd949e",
        "parent_line_id": null,
        "owner_id": "917ac4d4-5083-4751-a663-00f3550511a6",
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
      "id": "d4ed1011-eef0-4b27-89e8-34ea10457917",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:19+00:00",
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
        "item_id": "0a15d8ae-598e-4600-ade2-4c33ce69a606",
        "order_id": "917ac4d4-5083-4751-a663-00f3550511a6",
        "start_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e",
        "stop_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e",
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
      "id": "0928e1f3-88ca-4777-a0de-85c77dcd949e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:19+00:00",
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
        "item_id": "5b671e2b-f022-4749-bcdd-56457c5facf7",
        "order_id": "917ac4d4-5083-4751-a663-00f3550511a6",
        "start_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e",
        "stop_location_id": "8d6bef6e-c3ba-4a55-be60-10a5c8edc39e",
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
      "id": "74297df6-a61f-4169-93c1-b3fc0eb447b8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0f7dccc5-753f-4e2d-8984-25b4b7c688d8",
        "planning_id": "d4ed1011-eef0-4b27-89e8-34ea10457917",
        "order_id": "917ac4d4-5083-4751-a663-00f3550511a6"
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
      "id": "82702022-69e6-4f36-afb9-2c9a75a257cb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "41952923-215b-4e82-bce8-42a30fdceada",
        "planning_id": "d4ed1011-eef0-4b27-89e8-34ea10457917",
        "order_id": "917ac4d4-5083-4751-a663-00f3550511a6"
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
      "id": "fa6cc5b3-d756-42d4-85a0-e56063d1b9e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:18+00:00",
        "updated_at": "2023-01-26T10:21:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b8c8efd-f566-4132-a476-c3d01461fd13",
        "planning_id": "d4ed1011-eef0-4b27-89e8-34ea10457917",
        "order_id": "917ac4d4-5083-4751-a663-00f3550511a6"
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
          "order_id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89",
          "items": [
            {
              "type": "bundles",
              "id": "db6b74e5-dd38-4033-af94-519e576621b4",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "617e3494-5d32-4460-b005-c9447c9c15f7",
                  "id": "0f6bdefc-6888-4f4a-85e4-c2cedf34257f"
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
    "id": "e5b7e638-2c85-5928-a088-3b5cb34b666e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4a9c555e-e953-4605-8fee-28b8030fdab3"
          },
          {
            "type": "lines",
            "id": "426690bf-2dee-4e86-be2d-b112cb53506b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "52daa75c-b5a1-4d8e-8baf-ced8493e0b68"
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
      "id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-26T10:21:22+00:00",
        "updated_at": "2023-01-26T10:21:22+00:00",
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
        "starts_at": "2023-01-24T10:15:00+00:00",
        "stops_at": "2023-01-28T10:15:00+00:00",
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
        "start_location_id": "ae8bfc9e-8908-4d54-a98d-c93311cb7b6f",
        "stop_location_id": "ae8bfc9e-8908-4d54-a98d-c93311cb7b6f"
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
      "id": "4a9c555e-e953-4605-8fee-28b8030fdab3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T10:21:22+00:00",
        "updated_at": "2023-01-26T10:21:22+00:00",
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
        "item_id": "db6b74e5-dd38-4033-af94-519e576621b4",
        "tax_category_id": null,
        "planning_id": "52daa75c-b5a1-4d8e-8baf-ced8493e0b68",
        "parent_line_id": null,
        "owner_id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89",
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
      "id": "426690bf-2dee-4e86-be2d-b112cb53506b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-26T10:21:22+00:00",
        "updated_at": "2023-01-26T10:21:22+00:00",
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
        "item_id": "0f6bdefc-6888-4f4a-85e4-c2cedf34257f",
        "tax_category_id": null,
        "planning_id": "83a4917f-69d3-4962-9663-19dd1c3204c8",
        "parent_line_id": "4a9c555e-e953-4605-8fee-28b8030fdab3",
        "owner_id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89",
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
      "id": "52daa75c-b5a1-4d8e-8baf-ced8493e0b68",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-26T10:21:22+00:00",
        "updated_at": "2023-01-26T10:21:22+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-24T10:15:00+00:00",
        "stops_at": "2023-01-28T10:15:00+00:00",
        "reserved_from": "2023-01-24T10:15:00+00:00",
        "reserved_till": "2023-01-28T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "db6b74e5-dd38-4033-af94-519e576621b4",
        "order_id": "f2e9e19a-96c6-4b89-b3f8-38d9c3b27e89",
        "start_location_id": "ae8bfc9e-8908-4d54-a98d-c93311cb7b6f",
        "stop_location_id": "ae8bfc9e-8908-4d54-a98d-c93311cb7b6f",
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





