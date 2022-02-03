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
          "order_id": "b2ad5cc8-deb8-4db7-b57e-7ab57bf5db82",
          "items": [
            {
              "type": "products",
              "id": "98aa3200-83c8-48e8-8586-5dd00817557f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6774ac14-aa62-4aab-98f4-88c044b2e13e",
              "stock_item_ids": [
                "b7fed2bb-343d-4a9f-b60a-cae0ce25f9f9",
                "1210d8a0-be58-464b-93d8-6649d76a0391"
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
            "item_id": "98aa3200-83c8-48e8-8586-5dd00817557f",
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
          "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
          "items": [
            {
              "type": "products",
              "id": "1e0c9008-8503-4daf-85aa-1a8f994303c4",
              "stock_item_ids": [
                "26c7195d-352a-4113-9205-52e5ff7ca37d",
                "940f06e0-6967-46ce-ad89-6d887e117959",
                "0fab6485-33e8-4f3c-af9a-47215710fb24"
              ]
            },
            {
              "type": "products",
              "id": "6f3ab36d-ee00-4612-b1c8-7458d02654cb",
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
    "id": "5dd5bc34-0dcd-5a97-bcab-a730ea26bb98",
    "type": "order_bookings",
    "attributes": {
      "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a6e82005-8989-40de-9adf-7a794c2306af"
          },
          {
            "type": "lines",
            "id": "30395df2-0335-4b55-a14d-42728d984e3c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "be5cbcee-60e9-4615-82af-dffa21726c09"
          },
          {
            "type": "plannings",
            "id": "d55fc9af-2774-4f40-b227-c20c074e15d5"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ed0f086a-18f5-49cb-9e4d-4811e4463962"
          },
          {
            "type": "stock_item_plannings",
            "id": "014955de-48ad-4220-b651-82bf1e44ac51"
          },
          {
            "type": "stock_item_plannings",
            "id": "07bbdbd0-8a82-48dc-8091-24824de8a698"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-03T09:19:32+00:00",
        "updated_at": "2022-02-03T09:19:35+00:00",
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
        "customer_id": "70f4e4dd-1ea4-4bf7-896a-3507aead6b5f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba",
        "stop_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba"
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
      "id": "a6e82005-8989-40de-9adf-7a794c2306af",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-03T09:19:33+00:00",
        "updated_at": "2022-02-03T09:19:34+00:00",
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
        "item_id": "6f3ab36d-ee00-4612-b1c8-7458d02654cb",
        "tax_category_id": "87918d1a-e141-44d2-80bc-b8b2e1d59f3c",
        "planning_id": "be5cbcee-60e9-4615-82af-dffa21726c09",
        "parent_line_id": null,
        "owner_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
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
      "id": "30395df2-0335-4b55-a14d-42728d984e3c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-03T09:19:34+00:00",
        "updated_at": "2022-02-03T09:19:34+00:00",
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
        "item_id": "1e0c9008-8503-4daf-85aa-1a8f994303c4",
        "tax_category_id": "87918d1a-e141-44d2-80bc-b8b2e1d59f3c",
        "planning_id": "d55fc9af-2774-4f40-b227-c20c074e15d5",
        "parent_line_id": null,
        "owner_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
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
      "id": "be5cbcee-60e9-4615-82af-dffa21726c09",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:33+00:00",
        "updated_at": "2022-02-03T09:19:35+00:00",
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
        "item_id": "6f3ab36d-ee00-4612-b1c8-7458d02654cb",
        "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
        "start_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba",
        "stop_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba",
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
      "id": "d55fc9af-2774-4f40-b227-c20c074e15d5",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:34+00:00",
        "updated_at": "2022-02-03T09:19:35+00:00",
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
        "item_id": "1e0c9008-8503-4daf-85aa-1a8f994303c4",
        "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b",
        "start_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba",
        "stop_location_id": "308e8f8c-7416-4a13-bb47-db8c1ba1a1ba",
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
      "id": "ed0f086a-18f5-49cb-9e4d-4811e4463962",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:34+00:00",
        "updated_at": "2022-02-03T09:19:34+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "26c7195d-352a-4113-9205-52e5ff7ca37d",
        "planning_id": "d55fc9af-2774-4f40-b227-c20c074e15d5",
        "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b"
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
      "id": "014955de-48ad-4220-b651-82bf1e44ac51",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:34+00:00",
        "updated_at": "2022-02-03T09:19:34+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "940f06e0-6967-46ce-ad89-6d887e117959",
        "planning_id": "d55fc9af-2774-4f40-b227-c20c074e15d5",
        "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b"
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
      "id": "07bbdbd0-8a82-48dc-8091-24824de8a698",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:34+00:00",
        "updated_at": "2022-02-03T09:19:34+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0fab6485-33e8-4f3c-af9a-47215710fb24",
        "planning_id": "d55fc9af-2774-4f40-b227-c20c074e15d5",
        "order_id": "99b19ff3-365b-4c94-bdd1-73b2b83ebd0b"
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
          "order_id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684",
          "items": [
            {
              "type": "bundles",
              "id": "d3eb0a44-8fba-474b-9067-8c817445a7b8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e8d1d574-bc23-44ff-a1c2-fa366a12cf3c",
                  "id": "7ae26824-5b3b-4845-ab45-02c02692862b"
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
    "id": "91acb632-855b-5497-9d8d-53102611ade1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e559afd5-c67c-47e3-9855-7b85016d6403"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c31c0240-bda7-429f-a5bd-8ee73a97c069"
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
      "id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-03T09:19:37+00:00",
        "updated_at": "2022-02-03T09:19:38+00:00",
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
        "starts_at": "2022-02-01T09:15:00+00:00",
        "stops_at": "2022-02-05T09:15:00+00:00",
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
        "start_location_id": "af7b1f63-310f-45b5-9e5a-28c09dcd9d53",
        "stop_location_id": "af7b1f63-310f-45b5-9e5a-28c09dcd9d53"
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
      "id": "e559afd5-c67c-47e3-9855-7b85016d6403",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-03T09:19:38+00:00",
        "updated_at": "2022-02-03T09:19:38+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "d3eb0a44-8fba-474b-9067-8c817445a7b8",
        "tax_category_id": null,
        "planning_id": "c31c0240-bda7-429f-a5bd-8ee73a97c069",
        "parent_line_id": null,
        "owner_id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684",
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
      "id": "c31c0240-bda7-429f-a5bd-8ee73a97c069",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-03T09:19:38+00:00",
        "updated_at": "2022-02-03T09:19:38+00:00",
        "quantity": 1,
        "starts_at": "2022-02-01T09:15:00+00:00",
        "stops_at": "2022-02-05T09:15:00+00:00",
        "reserved_from": "2022-02-01T09:15:00+00:00",
        "reserved_till": "2022-02-05T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d3eb0a44-8fba-474b-9067-8c817445a7b8",
        "order_id": "fcd3cafc-0f1b-420f-a54e-fc051c3ee684",
        "start_location_id": "af7b1f63-310f-45b5-9e5a-28c09dcd9d53",
        "stop_location_id": "af7b1f63-310f-45b5-9e5a-28c09dcd9d53",
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





