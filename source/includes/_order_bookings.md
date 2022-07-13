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
          "order_id": "e16d57ab-4638-4652-82c2-f50235f65178",
          "items": [
            {
              "type": "products",
              "id": "4be46016-195b-49f8-a4ac-0d76f6ceadd1",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "67564966-d3ca-46a9-86c5-ed706c893330",
              "stock_item_ids": [
                "ed45f8ba-7146-46a8-b13c-537637d69a43",
                "ef766809-f9f1-4870-9cad-610bef647525"
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
            "item_id": "4be46016-195b-49f8-a4ac-0d76f6ceadd1",
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
          "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
          "items": [
            {
              "type": "products",
              "id": "f17c3796-47e7-41bf-a7ac-d056d8f4def0",
              "stock_item_ids": [
                "0368a96a-7a91-40fe-af16-ae7518ba48ef",
                "0efe1f06-b189-450d-992f-21d924808b40",
                "fa870b40-2821-42b8-b1b3-a5112270b261"
              ]
            },
            {
              "type": "products",
              "id": "5f7f88c3-479e-4c8f-a9e2-e8a1d4a25768",
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
    "id": "d608fb6e-af92-516d-9160-72c970ab17d7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9ba05200-02f8-4582-bf0e-27676deeeb39"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4b477a63-9da2-4ef1-833d-95fc297ace28"
          },
          {
            "type": "lines",
            "id": "1354a13d-be55-4cfa-b95f-63bce50a7d83"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e4947502-c1eb-4de4-b7c3-3ce613f78673"
          },
          {
            "type": "plannings",
            "id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b47e9efb-aa0b-4d31-bf64-8a613d7c28c5"
          },
          {
            "type": "stock_item_plannings",
            "id": "ecf975f1-7223-4504-a763-29366386d9fb"
          },
          {
            "type": "stock_item_plannings",
            "id": "5a854f50-ffdd-48c3-8705-66a70a3d7ce2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-13T11:51:12+00:00",
        "updated_at": "2022-07-13T11:51:14+00:00",
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
        "customer_id": "d780448f-2059-4bec-b981-dd91782e276d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7",
        "stop_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7"
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
      "id": "4b477a63-9da2-4ef1-833d-95fc297ace28",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T11:51:12+00:00",
        "updated_at": "2022-07-13T11:51:14+00:00",
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
        "item_id": "5f7f88c3-479e-4c8f-a9e2-e8a1d4a25768",
        "tax_category_id": "6658ed1f-6252-49e4-8e39-67cac1624180",
        "planning_id": "e4947502-c1eb-4de4-b7c3-3ce613f78673",
        "parent_line_id": null,
        "owner_id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
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
      "id": "1354a13d-be55-4cfa-b95f-63bce50a7d83",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T11:51:13+00:00",
        "updated_at": "2022-07-13T11:51:14+00:00",
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
        "item_id": "f17c3796-47e7-41bf-a7ac-d056d8f4def0",
        "tax_category_id": "6658ed1f-6252-49e4-8e39-67cac1624180",
        "planning_id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d",
        "parent_line_id": null,
        "owner_id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
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
      "id": "e4947502-c1eb-4de4-b7c3-3ce613f78673",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:12+00:00",
        "updated_at": "2022-07-13T11:51:14+00:00",
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
        "item_id": "5f7f88c3-479e-4c8f-a9e2-e8a1d4a25768",
        "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
        "start_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7",
        "stop_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7",
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
      "id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:13+00:00",
        "updated_at": "2022-07-13T11:51:14+00:00",
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
        "item_id": "f17c3796-47e7-41bf-a7ac-d056d8f4def0",
        "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39",
        "start_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7",
        "stop_location_id": "556ba268-b6b5-404f-9754-04785f7b05e7",
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
      "id": "b47e9efb-aa0b-4d31-bf64-8a613d7c28c5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:13+00:00",
        "updated_at": "2022-07-13T11:51:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0368a96a-7a91-40fe-af16-ae7518ba48ef",
        "planning_id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d",
        "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39"
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
      "id": "ecf975f1-7223-4504-a763-29366386d9fb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:13+00:00",
        "updated_at": "2022-07-13T11:51:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0efe1f06-b189-450d-992f-21d924808b40",
        "planning_id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d",
        "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39"
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
      "id": "5a854f50-ffdd-48c3-8705-66a70a3d7ce2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:13+00:00",
        "updated_at": "2022-07-13T11:51:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fa870b40-2821-42b8-b1b3-a5112270b261",
        "planning_id": "87507fa3-b9f9-44f3-98e9-f7c7ec14e76d",
        "order_id": "9ba05200-02f8-4582-bf0e-27676deeeb39"
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
          "order_id": "df160786-9744-443d-bb17-998b9d742465",
          "items": [
            {
              "type": "bundles",
              "id": "e5957e1d-ec3b-4263-85fb-449f9c9caade",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8093d554-ca43-426f-8377-c8eede8c73c2",
                  "id": "1eded418-7116-4966-9f7d-1ba2e63bd4ee"
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
    "id": "1ad2d430-e375-5699-8241-e6f54ec9d141",
    "type": "order_bookings",
    "attributes": {
      "order_id": "df160786-9744-443d-bb17-998b9d742465"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "df160786-9744-443d-bb17-998b9d742465"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1559828b-b880-4c2a-95ca-74cb515657ef"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "33b03071-3887-427f-bc40-1a9e4b3287b7"
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
      "id": "df160786-9744-443d-bb17-998b9d742465",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-13T11:51:16+00:00",
        "updated_at": "2022-07-13T11:51:17+00:00",
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
        "starts_at": "2022-07-11T11:45:00+00:00",
        "stops_at": "2022-07-15T11:45:00+00:00",
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
        "start_location_id": "3ca197cd-f69a-4eeb-be8c-86252a487827",
        "stop_location_id": "3ca197cd-f69a-4eeb-be8c-86252a487827"
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
      "id": "1559828b-b880-4c2a-95ca-74cb515657ef",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-13T11:51:17+00:00",
        "updated_at": "2022-07-13T11:51:17+00:00",
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
        "item_id": "e5957e1d-ec3b-4263-85fb-449f9c9caade",
        "tax_category_id": null,
        "planning_id": "33b03071-3887-427f-bc40-1a9e4b3287b7",
        "parent_line_id": null,
        "owner_id": "df160786-9744-443d-bb17-998b9d742465",
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
      "id": "33b03071-3887-427f-bc40-1a9e4b3287b7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-13T11:51:17+00:00",
        "updated_at": "2022-07-13T11:51:17+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-11T11:45:00+00:00",
        "stops_at": "2022-07-15T11:45:00+00:00",
        "reserved_from": "2022-07-11T11:45:00+00:00",
        "reserved_till": "2022-07-15T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e5957e1d-ec3b-4263-85fb-449f9c9caade",
        "order_id": "df160786-9744-443d-bb17-998b9d742465",
        "start_location_id": "3ca197cd-f69a-4eeb-be8c-86252a487827",
        "stop_location_id": "3ca197cd-f69a-4eeb-be8c-86252a487827",
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





