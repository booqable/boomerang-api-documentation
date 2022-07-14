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
          "order_id": "e71ca834-2f97-4c27-a111-da5180c5e081",
          "items": [
            {
              "type": "products",
              "id": "aa4e184f-2a49-4008-99a8-8fa558865f5d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "382562db-af58-4899-8e89-e1d179e15f0f",
              "stock_item_ids": [
                "c733cf85-6b26-422e-ab7f-2a5cb3abef52",
                "9dc8b7b3-e490-4d83-96fd-31e68b365cac"
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
            "item_id": "aa4e184f-2a49-4008-99a8-8fa558865f5d",
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
          "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
          "items": [
            {
              "type": "products",
              "id": "a0ae5b92-9d09-43bc-8766-00cb7c8d11ce",
              "stock_item_ids": [
                "3d7ec4aa-2f57-4ae4-8e4a-bf698dea5b34",
                "311996e2-b56e-42ae-8bb2-9f7de9773c12",
                "0288822c-81a8-4ed1-bbee-77d825dc01cf"
              ]
            },
            {
              "type": "products",
              "id": "1e482656-7f40-4d57-b88a-5d5e8078b9d2",
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
    "id": "2d138df0-d4c3-5878-934b-46c660652130",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6c2630c0-6f85-4768-9644-d908f6943a2f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "601aff00-db3f-449b-b084-94797fb7512d"
          },
          {
            "type": "lines",
            "id": "90f38874-e41b-4252-a032-fb717f2496f0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e5adbe01-19cb-42f7-8d1e-ff10ba038b3c"
          },
          {
            "type": "plannings",
            "id": "9f9614b2-9759-457a-846f-4e41f2f56a87"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ce0fb972-c3f1-43a9-9c00-b54e8bca2dbe"
          },
          {
            "type": "stock_item_plannings",
            "id": "4c3845cc-07ec-43fb-a86c-e8a5f6b55590"
          },
          {
            "type": "stock_item_plannings",
            "id": "684f4f43-7421-4927-9b40-962afc0f6b98"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T12:40:49+00:00",
        "updated_at": "2022-07-14T12:40:51+00:00",
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
        "customer_id": "07d7ce8b-997f-420a-bfe9-90c34b410da8",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd",
        "stop_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd"
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
      "id": "601aff00-db3f-449b-b084-94797fb7512d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T12:40:49+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
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
        "item_id": "1e482656-7f40-4d57-b88a-5d5e8078b9d2",
        "tax_category_id": "5f0fb6b5-288a-4d93-8133-2a5c13ec9177",
        "planning_id": "e5adbe01-19cb-42f7-8d1e-ff10ba038b3c",
        "parent_line_id": null,
        "owner_id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
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
      "id": "90f38874-e41b-4252-a032-fb717f2496f0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T12:40:50+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
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
        "item_id": "a0ae5b92-9d09-43bc-8766-00cb7c8d11ce",
        "tax_category_id": "5f0fb6b5-288a-4d93-8133-2a5c13ec9177",
        "planning_id": "9f9614b2-9759-457a-846f-4e41f2f56a87",
        "parent_line_id": null,
        "owner_id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
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
      "id": "e5adbe01-19cb-42f7-8d1e-ff10ba038b3c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:49+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
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
        "item_id": "1e482656-7f40-4d57-b88a-5d5e8078b9d2",
        "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
        "start_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd",
        "stop_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd",
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
      "id": "9f9614b2-9759-457a-846f-4e41f2f56a87",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:50+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
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
        "item_id": "a0ae5b92-9d09-43bc-8766-00cb7c8d11ce",
        "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f",
        "start_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd",
        "stop_location_id": "1b3f5ae0-afcd-47ff-a630-c8c9ea8dc3cd",
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
      "id": "ce0fb972-c3f1-43a9-9c00-b54e8bca2dbe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:50+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3d7ec4aa-2f57-4ae4-8e4a-bf698dea5b34",
        "planning_id": "9f9614b2-9759-457a-846f-4e41f2f56a87",
        "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f"
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
      "id": "4c3845cc-07ec-43fb-a86c-e8a5f6b55590",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:50+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "311996e2-b56e-42ae-8bb2-9f7de9773c12",
        "planning_id": "9f9614b2-9759-457a-846f-4e41f2f56a87",
        "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f"
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
      "id": "684f4f43-7421-4927-9b40-962afc0f6b98",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:50+00:00",
        "updated_at": "2022-07-14T12:40:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0288822c-81a8-4ed1-bbee-77d825dc01cf",
        "planning_id": "9f9614b2-9759-457a-846f-4e41f2f56a87",
        "order_id": "6c2630c0-6f85-4768-9644-d908f6943a2f"
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
          "order_id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8",
          "items": [
            {
              "type": "bundles",
              "id": "ca882d50-07ad-463c-952e-502d6cf59280",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4cb8b8a4-00c7-4069-8af3-d7e6964f0bfe",
                  "id": "8898356e-50df-4843-b074-08f1b67d0a05"
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
    "id": "c12d649c-b2f8-54c5-a3c9-715af9139cd3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5e0ba9a3-5f29-4843-a29a-9cbdcd037a8a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "61ffa122-8d45-49e1-95ff-5a12a73774bc"
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
      "id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T12:40:52+00:00",
        "updated_at": "2022-07-14T12:40:53+00:00",
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
        "starts_at": "2022-07-12T12:30:00+00:00",
        "stops_at": "2022-07-16T12:30:00+00:00",
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
        "start_location_id": "af24bd67-21ee-474a-93e5-ad843926eb13",
        "stop_location_id": "af24bd67-21ee-474a-93e5-ad843926eb13"
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
      "id": "5e0ba9a3-5f29-4843-a29a-9cbdcd037a8a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T12:40:53+00:00",
        "updated_at": "2022-07-14T12:40:53+00:00",
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
        "item_id": "ca882d50-07ad-463c-952e-502d6cf59280",
        "tax_category_id": null,
        "planning_id": "61ffa122-8d45-49e1-95ff-5a12a73774bc",
        "parent_line_id": null,
        "owner_id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8",
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
      "id": "61ffa122-8d45-49e1-95ff-5a12a73774bc",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T12:40:53+00:00",
        "updated_at": "2022-07-14T12:40:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T12:30:00+00:00",
        "stops_at": "2022-07-16T12:30:00+00:00",
        "reserved_from": "2022-07-12T12:30:00+00:00",
        "reserved_till": "2022-07-16T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ca882d50-07ad-463c-952e-502d6cf59280",
        "order_id": "43d21f8e-53ed-43b3-b7a8-1d1bb7736dd8",
        "start_location_id": "af24bd67-21ee-474a-93e5-ad843926eb13",
        "stop_location_id": "af24bd67-21ee-474a-93e5-ad843926eb13",
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





