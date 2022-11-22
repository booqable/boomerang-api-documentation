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
          "order_id": "f3b7d315-567e-4a78-8f84-dbccc9b73d48",
          "items": [
            {
              "type": "products",
              "id": "e2dd14e1-0f90-481e-ac99-4e5b0fe46fc7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "04d4e244-5915-4f63-bff0-7452165818ff",
              "stock_item_ids": [
                "c5745bc0-9786-4a1c-a1f5-56767e71eefb",
                "528897ef-f0fc-4852-a588-d2a88471e10e"
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
            "item_id": "e2dd14e1-0f90-481e-ac99-4e5b0fe46fc7",
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
          "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81",
          "items": [
            {
              "type": "products",
              "id": "3bf24afe-cb54-477c-a191-a0b089e379ab",
              "stock_item_ids": [
                "7bf57156-d4fe-4452-8254-f02bdbd50edf",
                "849ae699-8024-41fa-935e-010a71e1c749",
                "88a96ebc-36fb-43b1-85f2-1b88f38cfad8"
              ]
            },
            {
              "type": "products",
              "id": "37bfa3c2-f1d0-413f-9135-e8994485bd1a",
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
    "id": "c4059e73-82cc-56de-9a87-40c91e17236d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6a407ded-25f1-4251-8aad-7c194428fd81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "22024b09-1d3a-42e3-8195-6d7a15fdaaa8"
          },
          {
            "type": "lines",
            "id": "fe644a89-279c-4447-8865-5c94a16832ff"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd"
          },
          {
            "type": "plannings",
            "id": "3d23bc9a-efc7-4205-92a1-f6073bbcbb52"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "391f2010-8e92-4895-a1cd-ebe2d03b36c9"
          },
          {
            "type": "stock_item_plannings",
            "id": "1e027f91-c561-486d-a149-32eca9fa83bf"
          },
          {
            "type": "stock_item_plannings",
            "id": "a5518bf8-ca5d-4cb9-b78c-9d51dbeff8b9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6a407ded-25f1-4251-8aad-7c194428fd81",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T15:33:49+00:00",
        "updated_at": "2022-11-22T15:33:51+00:00",
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
        "customer_id": "de7298e9-b62c-49d1-933a-0c603a53ada5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a",
        "stop_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a"
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
      "id": "22024b09-1d3a-42e3-8195-6d7a15fdaaa8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:51+00:00",
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
        "item_id": "3bf24afe-cb54-477c-a191-a0b089e379ab",
        "tax_category_id": "106a9a2b-58c0-4563-ba10-545028aa5c96",
        "planning_id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd",
        "parent_line_id": null,
        "owner_id": "6a407ded-25f1-4251-8aad-7c194428fd81",
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
      "id": "fe644a89-279c-4447-8865-5c94a16832ff",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:51+00:00",
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
        "item_id": "37bfa3c2-f1d0-413f-9135-e8994485bd1a",
        "tax_category_id": "106a9a2b-58c0-4563-ba10-545028aa5c96",
        "planning_id": "3d23bc9a-efc7-4205-92a1-f6073bbcbb52",
        "parent_line_id": null,
        "owner_id": "6a407ded-25f1-4251-8aad-7c194428fd81",
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
      "id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:51+00:00",
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
        "item_id": "3bf24afe-cb54-477c-a191-a0b089e379ab",
        "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81",
        "start_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a",
        "stop_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a",
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
      "id": "3d23bc9a-efc7-4205-92a1-f6073bbcbb52",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:51+00:00",
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
        "item_id": "37bfa3c2-f1d0-413f-9135-e8994485bd1a",
        "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81",
        "start_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a",
        "stop_location_id": "f26a65f6-617f-4139-a56a-46f0c267e00a",
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
      "id": "391f2010-8e92-4895-a1cd-ebe2d03b36c9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7bf57156-d4fe-4452-8254-f02bdbd50edf",
        "planning_id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd",
        "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81"
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
      "id": "1e027f91-c561-486d-a149-32eca9fa83bf",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "849ae699-8024-41fa-935e-010a71e1c749",
        "planning_id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd",
        "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81"
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
      "id": "a5518bf8-ca5d-4cb9-b78c-9d51dbeff8b9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:50+00:00",
        "updated_at": "2022-11-22T15:33:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "88a96ebc-36fb-43b1-85f2-1b88f38cfad8",
        "planning_id": "371afaa9-d975-4adf-bc8f-6075a5bcfedd",
        "order_id": "6a407ded-25f1-4251-8aad-7c194428fd81"
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
          "order_id": "650d68ff-ad83-4935-be96-92b45458da8f",
          "items": [
            {
              "type": "bundles",
              "id": "8f0fd123-3f92-45aa-98cb-1ddb738dcda3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "04611927-9a8c-48ac-bcf1-fb520ec4f804",
                  "id": "ae47a4ba-3555-4c4f-b96f-1086f7433838"
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
    "id": "4668f1a3-e266-58bc-9126-fa70336250ca",
    "type": "order_bookings",
    "attributes": {
      "order_id": "650d68ff-ad83-4935-be96-92b45458da8f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "650d68ff-ad83-4935-be96-92b45458da8f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f360e06b-bfb2-4c5e-9aeb-1a9b06cc2ba2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "43cc1341-ebf2-419b-be72-872d92162fc3"
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
      "id": "650d68ff-ad83-4935-be96-92b45458da8f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T15:33:53+00:00",
        "updated_at": "2022-11-22T15:33:54+00:00",
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
        "starts_at": "2022-11-20T15:30:00+00:00",
        "stops_at": "2022-11-24T15:30:00+00:00",
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
        "start_location_id": "f323381f-497e-4bb7-9177-232e3a473069",
        "stop_location_id": "f323381f-497e-4bb7-9177-232e3a473069"
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
      "id": "f360e06b-bfb2-4c5e-9aeb-1a9b06cc2ba2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T15:33:54+00:00",
        "updated_at": "2022-11-22T15:33:54+00:00",
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
        "item_id": "8f0fd123-3f92-45aa-98cb-1ddb738dcda3",
        "tax_category_id": null,
        "planning_id": "43cc1341-ebf2-419b-be72-872d92162fc3",
        "parent_line_id": null,
        "owner_id": "650d68ff-ad83-4935-be96-92b45458da8f",
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
      "id": "43cc1341-ebf2-419b-be72-872d92162fc3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T15:33:54+00:00",
        "updated_at": "2022-11-22T15:33:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T15:30:00+00:00",
        "stops_at": "2022-11-24T15:30:00+00:00",
        "reserved_from": "2022-11-20T15:30:00+00:00",
        "reserved_till": "2022-11-24T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8f0fd123-3f92-45aa-98cb-1ddb738dcda3",
        "order_id": "650d68ff-ad83-4935-be96-92b45458da8f",
        "start_location_id": "f323381f-497e-4bb7-9177-232e3a473069",
        "stop_location_id": "f323381f-497e-4bb7-9177-232e3a473069",
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





