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
          "order_id": "7b7fa7cc-2ea0-41b6-a3d4-03982cc70b3d",
          "items": [
            {
              "type": "products",
              "id": "47f2439a-dc18-4b59-9527-38ad8e61ee27",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "615b4b61-896c-49ff-a76f-73cef085507e",
              "stock_item_ids": [
                "968fdbb5-6028-421d-aad0-e1c99ef90fe6",
                "123d9950-9fa6-4af2-bfbe-ad962c25aaa7"
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
            "item_id": "47f2439a-dc18-4b59-9527-38ad8e61ee27",
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
          "order_id": "8b4b66fa-8812-4034-b370-90d097075138",
          "items": [
            {
              "type": "products",
              "id": "b5e4db4d-82fd-430a-a8e4-dbf8b51195d6",
              "stock_item_ids": [
                "7583e9d7-8740-4a24-8ff2-17c7df7b7957",
                "3c6995ab-87f6-4ced-a53e-573e4aa90920",
                "e8857a87-cacd-4be4-b0f9-a277fe865bb0"
              ]
            },
            {
              "type": "products",
              "id": "e8c296ba-5862-4298-b0ae-54152c64c59d",
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
    "id": "243d0cea-6ba7-5ee3-8ea0-383f4c6daa9a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8b4b66fa-8812-4034-b370-90d097075138"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8b4b66fa-8812-4034-b370-90d097075138"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b43335fe-c121-4d1f-b131-37e9c1b1e936"
          },
          {
            "type": "lines",
            "id": "71d805b6-989e-49cc-b73a-36e6ed45f581"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "77036313-887a-4cc3-9bae-4d9aac3c9554"
          },
          {
            "type": "plannings",
            "id": "b41b4e0f-7aca-49ea-958f-f2304991b934"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6830de5f-2941-4a14-acf3-883990cefe03"
          },
          {
            "type": "stock_item_plannings",
            "id": "73f656c0-ff88-4a94-aec6-fc6fd157f024"
          },
          {
            "type": "stock_item_plannings",
            "id": "82499b4a-d30c-4e1b-849a-4a29ff71db3c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8b4b66fa-8812-4034-b370-90d097075138",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T16:28:18+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
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
        "customer_id": "e768c925-c367-4bf2-bf58-08b6fb43de70",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0",
        "stop_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0"
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
      "id": "b43335fe-c121-4d1f-b131-37e9c1b1e936",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
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
        "item_id": "b5e4db4d-82fd-430a-a8e4-dbf8b51195d6",
        "tax_category_id": "23a7066e-da03-4876-86c0-fb1387107e04",
        "planning_id": "77036313-887a-4cc3-9bae-4d9aac3c9554",
        "parent_line_id": null,
        "owner_id": "8b4b66fa-8812-4034-b370-90d097075138",
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
      "id": "71d805b6-989e-49cc-b73a-36e6ed45f581",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
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
        "item_id": "e8c296ba-5862-4298-b0ae-54152c64c59d",
        "tax_category_id": "23a7066e-da03-4876-86c0-fb1387107e04",
        "planning_id": "b41b4e0f-7aca-49ea-958f-f2304991b934",
        "parent_line_id": null,
        "owner_id": "8b4b66fa-8812-4034-b370-90d097075138",
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
      "id": "77036313-887a-4cc3-9bae-4d9aac3c9554",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
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
        "item_id": "b5e4db4d-82fd-430a-a8e4-dbf8b51195d6",
        "order_id": "8b4b66fa-8812-4034-b370-90d097075138",
        "start_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0",
        "stop_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0",
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
      "id": "b41b4e0f-7aca-49ea-958f-f2304991b934",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
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
        "item_id": "e8c296ba-5862-4298-b0ae-54152c64c59d",
        "order_id": "8b4b66fa-8812-4034-b370-90d097075138",
        "start_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0",
        "stop_location_id": "6de3f17c-c82d-4781-aea6-40006ec46eb0",
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
      "id": "6830de5f-2941-4a14-acf3-883990cefe03",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7583e9d7-8740-4a24-8ff2-17c7df7b7957",
        "planning_id": "77036313-887a-4cc3-9bae-4d9aac3c9554",
        "order_id": "8b4b66fa-8812-4034-b370-90d097075138"
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
      "id": "73f656c0-ff88-4a94-aec6-fc6fd157f024",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3c6995ab-87f6-4ced-a53e-573e4aa90920",
        "planning_id": "77036313-887a-4cc3-9bae-4d9aac3c9554",
        "order_id": "8b4b66fa-8812-4034-b370-90d097075138"
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
      "id": "82499b4a-d30c-4e1b-849a-4a29ff71db3c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:20+00:00",
        "updated_at": "2023-01-05T16:28:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e8857a87-cacd-4be4-b0f9-a277fe865bb0",
        "planning_id": "77036313-887a-4cc3-9bae-4d9aac3c9554",
        "order_id": "8b4b66fa-8812-4034-b370-90d097075138"
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
          "order_id": "cf359952-bdec-43bf-ab10-f3be94201ca7",
          "items": [
            {
              "type": "bundles",
              "id": "d613497d-adcf-49b6-9364-8f09965d1879",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "22fa0f91-b346-4648-8431-c833de36982a",
                  "id": "0b2e5741-6c6a-4d7f-9f00-77b3017f1c85"
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
    "id": "a1a0fdc9-da3a-546e-93cd-d300a13b87c0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cf359952-bdec-43bf-ab10-f3be94201ca7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cf359952-bdec-43bf-ab10-f3be94201ca7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dbd45789-ea5d-46c9-8055-62ec8dce2edc"
          },
          {
            "type": "lines",
            "id": "701a0fa7-94b4-49e9-816b-52b57c03fdd2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a848810f-9797-47fc-be27-7e49d26e57e8"
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
      "id": "cf359952-bdec-43bf-ab10-f3be94201ca7",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T16:28:22+00:00",
        "updated_at": "2023-01-05T16:28:23+00:00",
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
        "starts_at": "2023-01-03T16:15:00+00:00",
        "stops_at": "2023-01-07T16:15:00+00:00",
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
        "start_location_id": "abc5beec-77a6-4b40-9af7-56de79c4aa08",
        "stop_location_id": "abc5beec-77a6-4b40-9af7-56de79c4aa08"
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
      "id": "dbd45789-ea5d-46c9-8055-62ec8dce2edc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T16:28:23+00:00",
        "updated_at": "2023-01-05T16:28:23+00:00",
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
        "item_id": "0b2e5741-6c6a-4d7f-9f00-77b3017f1c85",
        "tax_category_id": null,
        "planning_id": "549d7643-bfc5-49ef-8324-77cb3a02c292",
        "parent_line_id": "701a0fa7-94b4-49e9-816b-52b57c03fdd2",
        "owner_id": "cf359952-bdec-43bf-ab10-f3be94201ca7",
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
      "id": "701a0fa7-94b4-49e9-816b-52b57c03fdd2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T16:28:23+00:00",
        "updated_at": "2023-01-05T16:28:23+00:00",
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
        "item_id": "d613497d-adcf-49b6-9364-8f09965d1879",
        "tax_category_id": null,
        "planning_id": "a848810f-9797-47fc-be27-7e49d26e57e8",
        "parent_line_id": null,
        "owner_id": "cf359952-bdec-43bf-ab10-f3be94201ca7",
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
      "id": "a848810f-9797-47fc-be27-7e49d26e57e8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T16:28:23+00:00",
        "updated_at": "2023-01-05T16:28:23+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T16:15:00+00:00",
        "stops_at": "2023-01-07T16:15:00+00:00",
        "reserved_from": "2023-01-03T16:15:00+00:00",
        "reserved_till": "2023-01-07T16:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d613497d-adcf-49b6-9364-8f09965d1879",
        "order_id": "cf359952-bdec-43bf-ab10-f3be94201ca7",
        "start_location_id": "abc5beec-77a6-4b40-9af7-56de79c4aa08",
        "stop_location_id": "abc5beec-77a6-4b40-9af7-56de79c4aa08",
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





