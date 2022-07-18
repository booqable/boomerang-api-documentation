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
          "order_id": "f3dc2dbd-08ea-4a0b-a8b0-2d8ed9de06b9",
          "items": [
            {
              "type": "products",
              "id": "3dbe1bc5-7d66-496b-9b97-c78856c96f81",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "975463b3-b5f1-4d74-a092-f0534d8522ea",
              "stock_item_ids": [
                "69abfcc9-8ba6-486c-b9d3-65383cc4069c",
                "d41903af-05da-4929-88d6-572a6a38c708"
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
            "item_id": "3dbe1bc5-7d66-496b-9b97-c78856c96f81",
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
          "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
          "items": [
            {
              "type": "products",
              "id": "5a47d987-eb16-423d-931f-a99c02b7949b",
              "stock_item_ids": [
                "9ed9b233-f392-4657-b619-437da45ff86d",
                "8b79db14-389b-460f-b00d-ba9b20a377ea",
                "8b16c8af-7895-4832-84b4-9a86e0685b3d"
              ]
            },
            {
              "type": "products",
              "id": "cf25181b-cc41-42cb-b84f-e97bfa8949c9",
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
    "id": "35aec029-7cb4-501a-b5db-de8ea9770fe4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7ed27108-c74c-4d56-9475-610e0ef3b031"
          },
          {
            "type": "lines",
            "id": "89cb2e75-cc29-4c6d-86a9-c14b7ad821d1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1642aa06-3002-42fb-95d9-838fe69b079d"
          },
          {
            "type": "plannings",
            "id": "ec727dda-2053-4e6c-8205-8ccb2c56134d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c55a2722-24cb-46c3-b86e-37688b54debd"
          },
          {
            "type": "stock_item_plannings",
            "id": "0fcff561-8511-40ed-8f7a-d64a0e9df44c"
          },
          {
            "type": "stock_item_plannings",
            "id": "5016d5a8-1f7c-4861-a12c-9f1cc7d40d80"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-18T07:36:03+00:00",
        "updated_at": "2022-07-18T07:36:05+00:00",
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
        "customer_id": "e01cca07-c7de-4e7c-9c57-b5bf1bba7135",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239",
        "stop_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239"
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
      "id": "7ed27108-c74c-4d56-9475-610e0ef3b031",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-18T07:36:03+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
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
        "item_id": "cf25181b-cc41-42cb-b84f-e97bfa8949c9",
        "tax_category_id": "cfe491d1-3c05-4a28-bbcd-93d6d9cd289d",
        "planning_id": "1642aa06-3002-42fb-95d9-838fe69b079d",
        "parent_line_id": null,
        "owner_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
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
      "id": "89cb2e75-cc29-4c6d-86a9-c14b7ad821d1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-18T07:36:04+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
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
        "item_id": "5a47d987-eb16-423d-931f-a99c02b7949b",
        "tax_category_id": "cfe491d1-3c05-4a28-bbcd-93d6d9cd289d",
        "planning_id": "ec727dda-2053-4e6c-8205-8ccb2c56134d",
        "parent_line_id": null,
        "owner_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
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
      "id": "1642aa06-3002-42fb-95d9-838fe69b079d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:03+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
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
        "item_id": "cf25181b-cc41-42cb-b84f-e97bfa8949c9",
        "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
        "start_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239",
        "stop_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239",
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
      "id": "ec727dda-2053-4e6c-8205-8ccb2c56134d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:04+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
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
        "item_id": "5a47d987-eb16-423d-931f-a99c02b7949b",
        "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a",
        "start_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239",
        "stop_location_id": "4114cf13-14f5-40c4-b2d4-3403260be239",
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
      "id": "c55a2722-24cb-46c3-b86e-37688b54debd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:04+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ed9b233-f392-4657-b619-437da45ff86d",
        "planning_id": "ec727dda-2053-4e6c-8205-8ccb2c56134d",
        "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a"
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
      "id": "0fcff561-8511-40ed-8f7a-d64a0e9df44c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:04+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b79db14-389b-460f-b00d-ba9b20a377ea",
        "planning_id": "ec727dda-2053-4e6c-8205-8ccb2c56134d",
        "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a"
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
      "id": "5016d5a8-1f7c-4861-a12c-9f1cc7d40d80",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:04+00:00",
        "updated_at": "2022-07-18T07:36:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b16c8af-7895-4832-84b4-9a86e0685b3d",
        "planning_id": "ec727dda-2053-4e6c-8205-8ccb2c56134d",
        "order_id": "c6a894ec-fb73-45ec-95c7-d59c76f1e03a"
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
          "order_id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0",
          "items": [
            {
              "type": "bundles",
              "id": "d3d7eb0c-fde2-4d4f-b42f-f54653677580",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4c509426-6042-4b4a-9bed-024c991891e8",
                  "id": "c2b8886e-ce60-4cc9-9905-b40d50362ce1"
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
    "id": "002cab27-a9d7-5d15-9c9c-c05f1c651e01",
    "type": "order_bookings",
    "attributes": {
      "order_id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7eda88a8-18f0-408a-be64-ec258853bfb0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3d0b69ae-cc94-4f06-80ba-470cc7012921"
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
      "id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-18T07:36:06+00:00",
        "updated_at": "2022-07-18T07:36:07+00:00",
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
        "starts_at": "2022-07-16T07:30:00+00:00",
        "stops_at": "2022-07-20T07:30:00+00:00",
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
        "start_location_id": "e962343f-6a97-4f78-9975-6aff0138fd86",
        "stop_location_id": "e962343f-6a97-4f78-9975-6aff0138fd86"
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
      "id": "7eda88a8-18f0-408a-be64-ec258853bfb0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-18T07:36:07+00:00",
        "updated_at": "2022-07-18T07:36:07+00:00",
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
        "item_id": "d3d7eb0c-fde2-4d4f-b42f-f54653677580",
        "tax_category_id": null,
        "planning_id": "3d0b69ae-cc94-4f06-80ba-470cc7012921",
        "parent_line_id": null,
        "owner_id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0",
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
      "id": "3d0b69ae-cc94-4f06-80ba-470cc7012921",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-18T07:36:07+00:00",
        "updated_at": "2022-07-18T07:36:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-16T07:30:00+00:00",
        "stops_at": "2022-07-20T07:30:00+00:00",
        "reserved_from": "2022-07-16T07:30:00+00:00",
        "reserved_till": "2022-07-20T07:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d3d7eb0c-fde2-4d4f-b42f-f54653677580",
        "order_id": "796c4254-bf57-44e1-bf80-a1b5a021a5c0",
        "start_location_id": "e962343f-6a97-4f78-9975-6aff0138fd86",
        "stop_location_id": "e962343f-6a97-4f78-9975-6aff0138fd86",
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





