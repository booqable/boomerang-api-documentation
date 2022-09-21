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
          "order_id": "4272ef1f-8c65-460d-a3d6-758b144b45ce",
          "items": [
            {
              "type": "products",
              "id": "2f48ced0-a1e0-4116-9640-c10fbeb82c9c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "203cef2d-27fc-404f-85fc-76c9fcd65cda",
              "stock_item_ids": [
                "bd0bc706-9c52-46bf-bfa2-d38787f5b408",
                "fa49f45a-fa80-4a2b-8297-8136726bd044"
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
            "item_id": "2f48ced0-a1e0-4116-9640-c10fbeb82c9c",
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
          "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
          "items": [
            {
              "type": "products",
              "id": "67c83c4e-a4be-45fd-9d07-59a94562b0b5",
              "stock_item_ids": [
                "7e17486f-4b03-4d5c-9a64-4d333f9116e1",
                "57ad64c9-a3aa-494d-be10-1d2972ec6e41",
                "04411278-f83b-4e73-8f3b-32de3b1ffaca"
              ]
            },
            {
              "type": "products",
              "id": "8f904473-dc78-4bdc-ae96-775e61412a27",
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
    "id": "e2a8021c-e5f2-56d2-9436-ab168ff83ce0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e90abeb5-c0fb-4dc5-8644-ba6491da897d"
          },
          {
            "type": "lines",
            "id": "d8f99f1c-c643-4c1d-ba13-1a09eab70754"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b13f47a2-b037-4edb-b042-79e152fc22af"
          },
          {
            "type": "plannings",
            "id": "26ef507c-f41f-4b8c-acd2-988484270568"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0b17ead1-4395-46a1-b2fb-bcca9c4490ce"
          },
          {
            "type": "stock_item_plannings",
            "id": "41c8cd75-8ae6-4162-b020-feac852566c4"
          },
          {
            "type": "stock_item_plannings",
            "id": "23e827cb-1e96-4ae9-98f9-b5d9a5e0e5cd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-21T09:07:33+00:00",
        "updated_at": "2022-09-21T09:07:37+00:00",
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
        "customer_id": "e2677f96-49af-4215-b526-dd9c0f169672",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208",
        "stop_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208"
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
      "id": "e90abeb5-c0fb-4dc5-8644-ba6491da897d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:36+00:00",
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
        "item_id": "67c83c4e-a4be-45fd-9d07-59a94562b0b5",
        "tax_category_id": "4267a6e7-17d3-4b16-b53e-92711f014898",
        "planning_id": "b13f47a2-b037-4edb-b042-79e152fc22af",
        "parent_line_id": null,
        "owner_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
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
      "id": "d8f99f1c-c643-4c1d-ba13-1a09eab70754",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:36+00:00",
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
        "item_id": "8f904473-dc78-4bdc-ae96-775e61412a27",
        "tax_category_id": "4267a6e7-17d3-4b16-b53e-92711f014898",
        "planning_id": "26ef507c-f41f-4b8c-acd2-988484270568",
        "parent_line_id": null,
        "owner_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
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
      "id": "b13f47a2-b037-4edb-b042-79e152fc22af",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:37+00:00",
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
        "item_id": "67c83c4e-a4be-45fd-9d07-59a94562b0b5",
        "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
        "start_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208",
        "stop_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208",
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
      "id": "26ef507c-f41f-4b8c-acd2-988484270568",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:37+00:00",
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
        "item_id": "8f904473-dc78-4bdc-ae96-775e61412a27",
        "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6",
        "start_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208",
        "stop_location_id": "a9e9f893-01af-467a-9298-2d8d4dfe9208",
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
      "id": "0b17ead1-4395-46a1-b2fb-bcca9c4490ce",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7e17486f-4b03-4d5c-9a64-4d333f9116e1",
        "planning_id": "b13f47a2-b037-4edb-b042-79e152fc22af",
        "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6"
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
      "id": "41c8cd75-8ae6-4162-b020-feac852566c4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "57ad64c9-a3aa-494d-be10-1d2972ec6e41",
        "planning_id": "b13f47a2-b037-4edb-b042-79e152fc22af",
        "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6"
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
      "id": "23e827cb-1e96-4ae9-98f9-b5d9a5e0e5cd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:36+00:00",
        "updated_at": "2022-09-21T09:07:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "04411278-f83b-4e73-8f3b-32de3b1ffaca",
        "planning_id": "b13f47a2-b037-4edb-b042-79e152fc22af",
        "order_id": "eef4233f-5ae1-40cd-a274-490ba9de0ab6"
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
          "order_id": "2cda1215-8b32-4451-9195-64226bb3d36c",
          "items": [
            {
              "type": "bundles",
              "id": "22bd90f4-aa53-47b9-99f7-67b12b39cd71",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8d9b9ffa-583a-405e-b6df-7c80af648cb8",
                  "id": "e6202157-97aa-49d7-9034-bf359e2587db"
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
    "id": "f24d8c99-7db2-56cf-a15a-f9322901f997",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2cda1215-8b32-4451-9195-64226bb3d36c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2cda1215-8b32-4451-9195-64226bb3d36c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d3229e3f-313f-4feb-8ef7-0e787d7d5568"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1f0e5bc0-13f8-4041-a628-5dbe866cb096"
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
      "id": "2cda1215-8b32-4451-9195-64226bb3d36c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-21T09:07:41+00:00",
        "updated_at": "2022-09-21T09:07:42+00:00",
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
        "starts_at": "2022-09-19T09:00:00+00:00",
        "stops_at": "2022-09-23T09:00:00+00:00",
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
        "start_location_id": "0cd7cce0-d789-4e9f-8939-3254679bb67c",
        "stop_location_id": "0cd7cce0-d789-4e9f-8939-3254679bb67c"
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
      "id": "d3229e3f-313f-4feb-8ef7-0e787d7d5568",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-21T09:07:42+00:00",
        "updated_at": "2022-09-21T09:07:42+00:00",
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
        "item_id": "22bd90f4-aa53-47b9-99f7-67b12b39cd71",
        "tax_category_id": null,
        "planning_id": "1f0e5bc0-13f8-4041-a628-5dbe866cb096",
        "parent_line_id": null,
        "owner_id": "2cda1215-8b32-4451-9195-64226bb3d36c",
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
      "id": "1f0e5bc0-13f8-4041-a628-5dbe866cb096",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-21T09:07:42+00:00",
        "updated_at": "2022-09-21T09:07:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-19T09:00:00+00:00",
        "stops_at": "2022-09-23T09:00:00+00:00",
        "reserved_from": "2022-09-19T09:00:00+00:00",
        "reserved_till": "2022-09-23T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "22bd90f4-aa53-47b9-99f7-67b12b39cd71",
        "order_id": "2cda1215-8b32-4451-9195-64226bb3d36c",
        "start_location_id": "0cd7cce0-d789-4e9f-8939-3254679bb67c",
        "stop_location_id": "0cd7cce0-d789-4e9f-8939-3254679bb67c",
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





