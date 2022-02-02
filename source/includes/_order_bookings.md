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
          "order_id": "882c6fb8-ebcb-4de6-b12c-c7f166ae5a4c",
          "items": [
            {
              "type": "products",
              "id": "776dc4cb-deec-4799-8662-4819775c9bd9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bb1bf3b1-2e1a-4b78-9ecb-8d3399557342",
              "stock_item_ids": [
                "aa31ca10-11cc-4991-89bd-a298c6dd8352",
                "03395787-9f7b-4723-a8f7-c61638dabbb4"
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
            "item_id": "776dc4cb-deec-4799-8662-4819775c9bd9",
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
          "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
          "items": [
            {
              "type": "products",
              "id": "0786410b-cefb-4c8a-a99f-a575b90bf419",
              "stock_item_ids": [
                "a048d645-551c-4c85-a8d3-efd91f162f8f",
                "669837b2-49bc-4321-a800-af0023d40062",
                "87462e1d-52e6-4232-8505-4cd327cae6ec"
              ]
            },
            {
              "type": "products",
              "id": "8d3d3ccc-103c-4c5f-b763-6be413573191",
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
    "id": "ae0f1455-b5bf-5252-b33a-aa2f064812c2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fe910efd-d1d9-4cae-a458-bc76b6149e79"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c0dac5f4-191d-441b-8adf-9038a41192ef"
          },
          {
            "type": "lines",
            "id": "4f117502-9daf-4cb9-a2a4-68367bc31317"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "02bd39b9-47eb-464f-aa0a-ed84dfc319d0"
          },
          {
            "type": "plannings",
            "id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "e04f335c-7e72-4549-9f87-e9edc00195b7"
          },
          {
            "type": "stock_item_plannings",
            "id": "294dd64d-7ee2-4abe-9c82-5a79eea7ea9d"
          },
          {
            "type": "stock_item_plannings",
            "id": "73b26635-16d0-46d7-b47a-f626dece47f3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-02T08:03:57+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
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
        "customer_id": "a90993a4-f1ad-4515-9cd1-5bb78b1ea028",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d",
        "stop_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d"
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
      "id": "c0dac5f4-191d-441b-8adf-9038a41192ef",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-02T08:03:58+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
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
        "item_id": "8d3d3ccc-103c-4c5f-b763-6be413573191",
        "tax_category_id": "9dd338f4-8031-492f-97f4-fb027c9d7cef",
        "planning_id": "02bd39b9-47eb-464f-aa0a-ed84dfc319d0",
        "parent_line_id": null,
        "owner_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
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
      "id": "4f117502-9daf-4cb9-a2a4-68367bc31317",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-02T08:03:59+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
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
        "item_id": "0786410b-cefb-4c8a-a99f-a575b90bf419",
        "tax_category_id": "9dd338f4-8031-492f-97f4-fb027c9d7cef",
        "planning_id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996",
        "parent_line_id": null,
        "owner_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
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
      "id": "02bd39b9-47eb-464f-aa0a-ed84dfc319d0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-02T08:03:58+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
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
        "item_id": "8d3d3ccc-103c-4c5f-b763-6be413573191",
        "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
        "start_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d",
        "stop_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d",
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
      "id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-02T08:03:59+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
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
        "item_id": "0786410b-cefb-4c8a-a99f-a575b90bf419",
        "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79",
        "start_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d",
        "stop_location_id": "90d1b797-4231-42bf-a179-0ef67a20c83d",
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
      "id": "e04f335c-7e72-4549-9f87-e9edc00195b7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-02T08:03:59+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a048d645-551c-4c85-a8d3-efd91f162f8f",
        "planning_id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996",
        "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79"
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
      "id": "294dd64d-7ee2-4abe-9c82-5a79eea7ea9d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-02T08:03:59+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "669837b2-49bc-4321-a800-af0023d40062",
        "planning_id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996",
        "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79"
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
      "id": "73b26635-16d0-46d7-b47a-f626dece47f3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-02T08:03:59+00:00",
        "updated_at": "2022-02-02T08:03:59+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "87462e1d-52e6-4232-8505-4cd327cae6ec",
        "planning_id": "03170fdb-eeeb-4c70-9cb8-f33d616d2996",
        "order_id": "fe910efd-d1d9-4cae-a458-bc76b6149e79"
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
          "order_id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43",
          "items": [
            {
              "type": "bundles",
              "id": "20496a1a-2fe6-40d5-9cbf-fc66aee32b6e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "de77ec1f-2814-4771-87a0-4886acabd5f9",
                  "id": "cd19e5df-148f-4bc3-a7a6-1d2f77bec95e"
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
    "id": "501a2469-30c9-58b2-88fa-4870bf9a627e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6ae72209-86dc-4a7a-86f6-8b878e46bbe8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5abe1d74-065f-49c1-ac8c-87ba059b85ec"
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
      "id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-02T08:04:02+00:00",
        "updated_at": "2022-02-02T08:04:03+00:00",
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
        "starts_at": "2022-01-31T08:00:00+00:00",
        "stops_at": "2022-02-04T08:00:00+00:00",
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
        "start_location_id": "101b3580-d3ea-4200-879f-e51df92fad2a",
        "stop_location_id": "101b3580-d3ea-4200-879f-e51df92fad2a"
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
      "id": "6ae72209-86dc-4a7a-86f6-8b878e46bbe8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-02T08:04:02+00:00",
        "updated_at": "2022-02-02T08:04:02+00:00",
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
        "item_id": "20496a1a-2fe6-40d5-9cbf-fc66aee32b6e",
        "tax_category_id": null,
        "planning_id": "5abe1d74-065f-49c1-ac8c-87ba059b85ec",
        "parent_line_id": null,
        "owner_id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43",
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
      "id": "5abe1d74-065f-49c1-ac8c-87ba059b85ec",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-02T08:04:02+00:00",
        "updated_at": "2022-02-02T08:04:02+00:00",
        "quantity": 1,
        "starts_at": "2022-01-31T08:00:00+00:00",
        "stops_at": "2022-02-04T08:00:00+00:00",
        "reserved_from": "2022-01-31T08:00:00+00:00",
        "reserved_till": "2022-02-04T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "20496a1a-2fe6-40d5-9cbf-fc66aee32b6e",
        "order_id": "5f74f099-bd8f-4ccb-84b7-f557483ecc43",
        "start_location_id": "101b3580-d3ea-4200-879f-e51df92fad2a",
        "stop_location_id": "101b3580-d3ea-4200-879f-e51df92fad2a",
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





