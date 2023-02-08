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
          "order_id": "4d100462-7dd9-4e7a-9a24-0e59e30bc0f2",
          "items": [
            {
              "type": "products",
              "id": "c129644a-551f-4bda-a839-112014eb3d58",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "091dbc33-0d6c-4c4b-aed8-b657934d2aad",
              "stock_item_ids": [
                "34059335-8073-40bf-acc7-535860508736",
                "781509e7-9a5f-4a7d-880f-5f0032eb4279"
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
            "item_id": "c129644a-551f-4bda-a839-112014eb3d58",
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
          "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
          "items": [
            {
              "type": "products",
              "id": "c9a2b3bd-7d3c-4d1c-b12f-0192c4915213",
              "stock_item_ids": [
                "accf497f-af71-4b63-8c5f-5a642db5c615",
                "82609287-096d-425e-94a0-80faf89d95c6",
                "1946d243-c198-4987-bc03-02d73eabeb31"
              ]
            },
            {
              "type": "products",
              "id": "5488ff0c-f08b-4569-b7cc-79be136c11ac",
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
    "id": "e3533aed-7e68-52b7-8ea2-9a1398fe1f02",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7c8d3078-6f8c-428f-a474-dd48d68a7df1"
          },
          {
            "type": "lines",
            "id": "cf312076-3158-4e5a-9d05-641c95b2404b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fa044148-18d5-444c-ad89-694c86707da7"
          },
          {
            "type": "plannings",
            "id": "0f5626be-9ddd-4e7a-94d5-f5a95df2ace0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7b7346b1-f592-4803-83a3-22c8bc0beed4"
          },
          {
            "type": "stock_item_plannings",
            "id": "eee63745-6af1-432b-99d6-2d940f1d7e62"
          },
          {
            "type": "stock_item_plannings",
            "id": "4977bb78-c63d-4b8b-82be-c254ef86afb8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T09:19:50+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
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
        "customer_id": "32994540-b664-498e-82e1-c294897c0185",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460",
        "stop_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460"
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
      "id": "7c8d3078-6f8c-428f-a474-dd48d68a7df1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
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
        "item_id": "c9a2b3bd-7d3c-4d1c-b12f-0192c4915213",
        "tax_category_id": "091f99af-f510-4f60-a00e-74e8bc0c23cd",
        "planning_id": "fa044148-18d5-444c-ad89-694c86707da7",
        "parent_line_id": null,
        "owner_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
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
      "id": "cf312076-3158-4e5a-9d05-641c95b2404b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
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
        "item_id": "5488ff0c-f08b-4569-b7cc-79be136c11ac",
        "tax_category_id": "091f99af-f510-4f60-a00e-74e8bc0c23cd",
        "planning_id": "0f5626be-9ddd-4e7a-94d5-f5a95df2ace0",
        "parent_line_id": null,
        "owner_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
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
      "id": "fa044148-18d5-444c-ad89-694c86707da7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
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
        "item_id": "c9a2b3bd-7d3c-4d1c-b12f-0192c4915213",
        "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
        "start_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460",
        "stop_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460",
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
      "id": "0f5626be-9ddd-4e7a-94d5-f5a95df2ace0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
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
        "item_id": "5488ff0c-f08b-4569-b7cc-79be136c11ac",
        "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f",
        "start_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460",
        "stop_location_id": "aa072f1a-a252-4ac4-b287-0b24a894a460",
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
      "id": "7b7346b1-f592-4803-83a3-22c8bc0beed4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "accf497f-af71-4b63-8c5f-5a642db5c615",
        "planning_id": "fa044148-18d5-444c-ad89-694c86707da7",
        "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f"
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
      "id": "eee63745-6af1-432b-99d6-2d940f1d7e62",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "82609287-096d-425e-94a0-80faf89d95c6",
        "planning_id": "fa044148-18d5-444c-ad89-694c86707da7",
        "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f"
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
      "id": "4977bb78-c63d-4b8b-82be-c254ef86afb8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:51+00:00",
        "updated_at": "2023-02-08T09:19:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1946d243-c198-4987-bc03-02d73eabeb31",
        "planning_id": "fa044148-18d5-444c-ad89-694c86707da7",
        "order_id": "e84c3d3b-fbcd-44e8-bcd9-b90db10d7f9f"
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
          "order_id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593",
          "items": [
            {
              "type": "bundles",
              "id": "210a3420-1666-4952-8b42-4f85bc5d02a8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "22d2bd7c-5a56-4055-aa52-45dd8473c687",
                  "id": "4ea87d9a-615a-438d-b8f7-28146db808e8"
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
    "id": "a46a9394-8588-5c08-8fa1-e23c029049cd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8319dea9-5068-488c-92d2-9c9d0b99ae27"
          },
          {
            "type": "lines",
            "id": "ea9c4e06-e619-403a-8156-a801abe77f47"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f336c6e5-0c63-4d17-b3fb-6606a4648113"
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
      "id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T09:19:54+00:00",
        "updated_at": "2023-02-08T09:19:54+00:00",
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
        "starts_at": "2023-02-06T09:15:00+00:00",
        "stops_at": "2023-02-10T09:15:00+00:00",
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
        "start_location_id": "78ce9474-0dc9-4125-b278-f1d88c039dc8",
        "stop_location_id": "78ce9474-0dc9-4125-b278-f1d88c039dc8"
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
      "id": "8319dea9-5068-488c-92d2-9c9d0b99ae27",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:19:54+00:00",
        "updated_at": "2023-02-08T09:19:54+00:00",
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
        "item_id": "4ea87d9a-615a-438d-b8f7-28146db808e8",
        "tax_category_id": null,
        "planning_id": "0ad16edd-5b88-428e-b7aa-3af519a2b93b",
        "parent_line_id": "ea9c4e06-e619-403a-8156-a801abe77f47",
        "owner_id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593",
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
      "id": "ea9c4e06-e619-403a-8156-a801abe77f47",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:19:54+00:00",
        "updated_at": "2023-02-08T09:19:54+00:00",
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
        "item_id": "210a3420-1666-4952-8b42-4f85bc5d02a8",
        "tax_category_id": null,
        "planning_id": "f336c6e5-0c63-4d17-b3fb-6606a4648113",
        "parent_line_id": null,
        "owner_id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593",
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
      "id": "f336c6e5-0c63-4d17-b3fb-6606a4648113",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:19:54+00:00",
        "updated_at": "2023-02-08T09:19:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T09:15:00+00:00",
        "stops_at": "2023-02-10T09:15:00+00:00",
        "reserved_from": "2023-02-06T09:15:00+00:00",
        "reserved_till": "2023-02-10T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "210a3420-1666-4952-8b42-4f85bc5d02a8",
        "order_id": "21b9ddc7-061a-4fea-b267-ba3bd2d62593",
        "start_location_id": "78ce9474-0dc9-4125-b278-f1d88c039dc8",
        "stop_location_id": "78ce9474-0dc9-4125-b278-f1d88c039dc8",
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





