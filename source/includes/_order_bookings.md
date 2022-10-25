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
          "order_id": "f5549caa-c967-421e-941d-0235445b0697",
          "items": [
            {
              "type": "products",
              "id": "4065229a-8d06-4703-ad41-f9d6c2050ed9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fd2bca3e-aba2-4b29-a78f-bc57d0751af6",
              "stock_item_ids": [
                "3afe3cfb-d0da-4ef4-8744-ab1b7864e5d7",
                "a9fe773e-08b4-42fb-9b2a-985e6ed7663a"
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
            "item_id": "4065229a-8d06-4703-ad41-f9d6c2050ed9",
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
          "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
          "items": [
            {
              "type": "products",
              "id": "2035f1ed-6e0e-4b44-8704-576a739044f5",
              "stock_item_ids": [
                "08ec5a4a-5ce4-4819-a995-3913d6305960",
                "b486dc51-09cd-4df6-a8e9-ee05fab5b96f",
                "a642fc83-ce06-41ca-adda-5e7c564d4623"
              ]
            },
            {
              "type": "products",
              "id": "25057033-4107-404d-984d-21a7b9fde41d",
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
    "id": "09aec619-3fdb-5569-be02-42ea5f2e0769",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6bc51b39-f6bd-40ff-8cd0-d5fe738eb2ae"
          },
          {
            "type": "lines",
            "id": "c7d67b84-c333-470e-b297-4b5c4cf9ddab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cb82e402-c53e-46f9-9c2e-e20979c637ee"
          },
          {
            "type": "plannings",
            "id": "4669efcb-9403-4432-ad2c-98581354a213"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4783bc3d-47cd-44af-86bd-6a06d5fa878b"
          },
          {
            "type": "stock_item_plannings",
            "id": "fc7f4efb-5a44-4b97-baa4-99fe36970dad"
          },
          {
            "type": "stock_item_plannings",
            "id": "acadc5d1-7ee2-430a-b836-6507e9a608fe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T19:11:01+00:00",
        "updated_at": "2022-10-25T19:11:03+00:00",
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
        "customer_id": "62685051-2953-40e1-bca3-85d064fab89c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "59383f41-6e99-42a9-84d4-478552922da6",
        "stop_location_id": "59383f41-6e99-42a9-84d4-478552922da6"
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
      "id": "6bc51b39-f6bd-40ff-8cd0-d5fe738eb2ae",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:03+00:00",
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
        "item_id": "2035f1ed-6e0e-4b44-8704-576a739044f5",
        "tax_category_id": "f3184a6d-7164-4cfd-8aef-13652984ecda",
        "planning_id": "cb82e402-c53e-46f9-9c2e-e20979c637ee",
        "parent_line_id": null,
        "owner_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
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
      "id": "c7d67b84-c333-470e-b297-4b5c4cf9ddab",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:03+00:00",
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
        "item_id": "25057033-4107-404d-984d-21a7b9fde41d",
        "tax_category_id": "f3184a6d-7164-4cfd-8aef-13652984ecda",
        "planning_id": "4669efcb-9403-4432-ad2c-98581354a213",
        "parent_line_id": null,
        "owner_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
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
      "id": "cb82e402-c53e-46f9-9c2e-e20979c637ee",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:03+00:00",
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
        "item_id": "2035f1ed-6e0e-4b44-8704-576a739044f5",
        "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
        "start_location_id": "59383f41-6e99-42a9-84d4-478552922da6",
        "stop_location_id": "59383f41-6e99-42a9-84d4-478552922da6",
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
      "id": "4669efcb-9403-4432-ad2c-98581354a213",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:03+00:00",
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
        "item_id": "25057033-4107-404d-984d-21a7b9fde41d",
        "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7",
        "start_location_id": "59383f41-6e99-42a9-84d4-478552922da6",
        "stop_location_id": "59383f41-6e99-42a9-84d4-478552922da6",
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
      "id": "4783bc3d-47cd-44af-86bd-6a06d5fa878b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "08ec5a4a-5ce4-4819-a995-3913d6305960",
        "planning_id": "cb82e402-c53e-46f9-9c2e-e20979c637ee",
        "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7"
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
      "id": "fc7f4efb-5a44-4b97-baa4-99fe36970dad",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b486dc51-09cd-4df6-a8e9-ee05fab5b96f",
        "planning_id": "cb82e402-c53e-46f9-9c2e-e20979c637ee",
        "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7"
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
      "id": "acadc5d1-7ee2-430a-b836-6507e9a608fe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:02+00:00",
        "updated_at": "2022-10-25T19:11:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a642fc83-ce06-41ca-adda-5e7c564d4623",
        "planning_id": "cb82e402-c53e-46f9-9c2e-e20979c637ee",
        "order_id": "fa263142-7bd9-45a9-bab1-1b1ff789c8b7"
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
          "order_id": "2f0af217-07fb-4fd8-acec-f441b745ad57",
          "items": [
            {
              "type": "bundles",
              "id": "6f6893d1-d0a0-4c16-b338-579a91daaadc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3b14fc71-c185-43a0-858d-e893f7718f7c",
                  "id": "b6485033-5bc8-44c0-bc45-e2423e0418c8"
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
    "id": "eb48c7a3-af0a-5fce-93cc-1daaccab3c87",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2f0af217-07fb-4fd8-acec-f441b745ad57"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2f0af217-07fb-4fd8-acec-f441b745ad57"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e9364f35-21c9-4852-a3f5-a8e43bd645e1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4641ec65-2716-4e52-9e9c-5fa369fa35f0"
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
      "id": "2f0af217-07fb-4fd8-acec-f441b745ad57",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T19:11:05+00:00",
        "updated_at": "2022-10-25T19:11:06+00:00",
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
        "starts_at": "2022-10-23T19:00:00+00:00",
        "stops_at": "2022-10-27T19:00:00+00:00",
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
        "start_location_id": "2a693ebe-01db-41d7-a158-37712ae2e08f",
        "stop_location_id": "2a693ebe-01db-41d7-a158-37712ae2e08f"
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
      "id": "e9364f35-21c9-4852-a3f5-a8e43bd645e1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T19:11:06+00:00",
        "updated_at": "2022-10-25T19:11:06+00:00",
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
        "item_id": "6f6893d1-d0a0-4c16-b338-579a91daaadc",
        "tax_category_id": null,
        "planning_id": "4641ec65-2716-4e52-9e9c-5fa369fa35f0",
        "parent_line_id": null,
        "owner_id": "2f0af217-07fb-4fd8-acec-f441b745ad57",
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
      "id": "4641ec65-2716-4e52-9e9c-5fa369fa35f0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T19:11:06+00:00",
        "updated_at": "2022-10-25T19:11:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T19:00:00+00:00",
        "stops_at": "2022-10-27T19:00:00+00:00",
        "reserved_from": "2022-10-23T19:00:00+00:00",
        "reserved_till": "2022-10-27T19:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6f6893d1-d0a0-4c16-b338-579a91daaadc",
        "order_id": "2f0af217-07fb-4fd8-acec-f441b745ad57",
        "start_location_id": "2a693ebe-01db-41d7-a158-37712ae2e08f",
        "stop_location_id": "2a693ebe-01db-41d7-a158-37712ae2e08f",
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





