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
          "order_id": "0f3598f5-8cb1-4db8-9c39-b6c9eeea3796",
          "items": [
            {
              "type": "products",
              "id": "0afc32e2-a643-4ab6-aac9-7745b7017df2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c805939a-5b72-462e-b95b-7e909809102d",
              "stock_item_ids": [
                "2fa29390-6857-4b85-a3f3-a74364336367",
                "e3c02549-9190-41ed-a24e-6a78f557d2ec"
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
            "item_id": "0afc32e2-a643-4ab6-aac9-7745b7017df2",
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
          "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
          "items": [
            {
              "type": "products",
              "id": "2337c1a7-69fd-4808-95ba-7bc625b48263",
              "stock_item_ids": [
                "859de91e-52a1-414f-b41d-e6197a360420",
                "36c8d0e4-44b1-4962-a619-1da5abd6f808",
                "ff8048c2-db1a-47b1-9b30-bf79c2ed3e5e"
              ]
            },
            {
              "type": "products",
              "id": "966e98b0-e730-43eb-9632-800e4121a3ad",
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
    "id": "b9d00c6d-feda-54aa-9820-9e5d5ccb3fba",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "094d0b16-8954-4470-8865-7e9bad07e54c"
          },
          {
            "type": "lines",
            "id": "c71c5175-b17d-4e20-9938-45c817178f15"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "07175c37-b359-411f-9feb-70561f6029f9"
          },
          {
            "type": "plannings",
            "id": "27dd487f-e75b-4541-af27-fd708295c171"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6233248e-7920-41ce-ad46-a3da37fa2461"
          },
          {
            "type": "stock_item_plannings",
            "id": "eb6db9eb-e010-4b41-907f-916979d41b5e"
          },
          {
            "type": "stock_item_plannings",
            "id": "989cfebd-922b-4d86-9dcc-74e4024da8d2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T09:09:32+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
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
        "customer_id": "11b69041-570f-4add-ad46-3b963c33d576",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858",
        "stop_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858"
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
      "id": "094d0b16-8954-4470-8865-7e9bad07e54c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T09:09:33+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
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
        "item_id": "966e98b0-e730-43eb-9632-800e4121a3ad",
        "tax_category_id": "7419af31-86d6-44cc-8dff-b3dcca49e61b",
        "planning_id": "07175c37-b359-411f-9feb-70561f6029f9",
        "parent_line_id": null,
        "owner_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
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
      "id": "c71c5175-b17d-4e20-9938-45c817178f15",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T09:09:34+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
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
        "item_id": "2337c1a7-69fd-4808-95ba-7bc625b48263",
        "tax_category_id": "7419af31-86d6-44cc-8dff-b3dcca49e61b",
        "planning_id": "27dd487f-e75b-4541-af27-fd708295c171",
        "parent_line_id": null,
        "owner_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
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
      "id": "07175c37-b359-411f-9feb-70561f6029f9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:33+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
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
        "item_id": "966e98b0-e730-43eb-9632-800e4121a3ad",
        "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
        "start_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858",
        "stop_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858",
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
      "id": "27dd487f-e75b-4541-af27-fd708295c171",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:34+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
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
        "item_id": "2337c1a7-69fd-4808-95ba-7bc625b48263",
        "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25",
        "start_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858",
        "stop_location_id": "5669c55c-c5c7-4af3-9d50-6a9c970f0858",
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
      "id": "6233248e-7920-41ce-ad46-a3da37fa2461",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:34+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "859de91e-52a1-414f-b41d-e6197a360420",
        "planning_id": "27dd487f-e75b-4541-af27-fd708295c171",
        "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25"
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
      "id": "eb6db9eb-e010-4b41-907f-916979d41b5e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:34+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "36c8d0e4-44b1-4962-a619-1da5abd6f808",
        "planning_id": "27dd487f-e75b-4541-af27-fd708295c171",
        "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25"
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
      "id": "989cfebd-922b-4d86-9dcc-74e4024da8d2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:34+00:00",
        "updated_at": "2022-04-13T09:09:34+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ff8048c2-db1a-47b1-9b30-bf79c2ed3e5e",
        "planning_id": "27dd487f-e75b-4541-af27-fd708295c171",
        "order_id": "6050f7ef-ffea-40d8-9f7b-38aa55e96a25"
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
          "order_id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d",
          "items": [
            {
              "type": "bundles",
              "id": "1e5a1d07-0f74-41f4-a743-22a3224ddb8a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "14a0973d-1c8e-458d-9ce7-824db7f39244",
                  "id": "f71a56c8-7b6e-491c-9f5c-7341c45b029f"
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
    "id": "4e29f2c7-dc81-578d-87e1-6b1b580cac57",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f77c3e21-319c-4800-a733-5ad186cc3f2a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "75a949e2-6547-453b-a066-4e6c0c699719"
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
      "id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T09:09:36+00:00",
        "updated_at": "2022-04-13T09:09:37+00:00",
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
        "starts_at": "2022-04-11T09:00:00+00:00",
        "stops_at": "2022-04-15T09:00:00+00:00",
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
        "start_location_id": "c4c21650-4bd8-46a1-9426-ab0fcb677d5f",
        "stop_location_id": "c4c21650-4bd8-46a1-9426-ab0fcb677d5f"
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
      "id": "f77c3e21-319c-4800-a733-5ad186cc3f2a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T09:09:37+00:00",
        "updated_at": "2022-04-13T09:09:37+00:00",
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
        "item_id": "1e5a1d07-0f74-41f4-a743-22a3224ddb8a",
        "tax_category_id": null,
        "planning_id": "75a949e2-6547-453b-a066-4e6c0c699719",
        "parent_line_id": null,
        "owner_id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d",
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
      "id": "75a949e2-6547-453b-a066-4e6c0c699719",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T09:09:37+00:00",
        "updated_at": "2022-04-13T09:09:37+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-11T09:00:00+00:00",
        "stops_at": "2022-04-15T09:00:00+00:00",
        "reserved_from": "2022-04-11T09:00:00+00:00",
        "reserved_till": "2022-04-15T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1e5a1d07-0f74-41f4-a743-22a3224ddb8a",
        "order_id": "b8f4ed3e-89b4-4922-8993-6aedcbd44e9d",
        "start_location_id": "c4c21650-4bd8-46a1-9426-ab0fcb677d5f",
        "stop_location_id": "c4c21650-4bd8-46a1-9426-ab0fcb677d5f",
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





