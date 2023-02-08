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
          "order_id": "bd5f24c8-bdeb-449a-a5a4-5b6f7cdac090",
          "items": [
            {
              "type": "products",
              "id": "e78e9a1c-9d40-4c7d-a446-95c33740cff6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b39be490-8e99-49a9-89e5-560ef4405ae2",
              "stock_item_ids": [
                "697522f8-6383-48c3-8032-38b4c3a9550f",
                "790666f9-60d9-456d-8976-619298017d6f"
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
            "item_id": "e78e9a1c-9d40-4c7d-a446-95c33740cff6",
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
          "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
          "items": [
            {
              "type": "products",
              "id": "3febc313-2fbb-4449-8074-18459ec16762",
              "stock_item_ids": [
                "45ea483a-eccd-4706-9a55-9aa567b5a5db",
                "e75959ff-c187-4a0d-8ccb-62feb44d57ea",
                "92deb8f1-01f0-40d8-9b59-f21a3beee31f"
              ]
            },
            {
              "type": "products",
              "id": "fb4bb3bd-cfac-43ab-86a7-c1dfe8835ef7",
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
    "id": "e8a40570-2db8-53dc-8d38-b52afc984fdc",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1838dcc2-4267-4dad-bd14-4e1751533cdc"
          },
          {
            "type": "lines",
            "id": "e1ba2c29-f352-457a-b0b7-36d1d96e464d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3ed91461-f410-4048-986b-502c1ba2cd24"
          },
          {
            "type": "plannings",
            "id": "f9b7e0fa-13dd-45c6-8f4f-08af2c86ae1d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a3d36718-acb3-4091-8c9a-f815f7f39039"
          },
          {
            "type": "stock_item_plannings",
            "id": "8d0de3dd-3ec9-4fc8-ae55-e6bd303850de"
          },
          {
            "type": "stock_item_plannings",
            "id": "38deff9f-0442-420d-8156-b7d61048e62a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:44:11+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
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
        "customer_id": "379c9f3f-4cb9-4638-a7aa-a74090760aab",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b",
        "stop_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b"
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
      "id": "1838dcc2-4267-4dad-bd14-4e1751533cdc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
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
        "item_id": "3febc313-2fbb-4449-8074-18459ec16762",
        "tax_category_id": "2ff34bad-c2d3-44ae-ab1d-26cdfd62d68b",
        "planning_id": "3ed91461-f410-4048-986b-502c1ba2cd24",
        "parent_line_id": null,
        "owner_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
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
      "id": "e1ba2c29-f352-457a-b0b7-36d1d96e464d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
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
        "item_id": "fb4bb3bd-cfac-43ab-86a7-c1dfe8835ef7",
        "tax_category_id": "2ff34bad-c2d3-44ae-ab1d-26cdfd62d68b",
        "planning_id": "f9b7e0fa-13dd-45c6-8f4f-08af2c86ae1d",
        "parent_line_id": null,
        "owner_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
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
      "id": "3ed91461-f410-4048-986b-502c1ba2cd24",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
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
        "item_id": "3febc313-2fbb-4449-8074-18459ec16762",
        "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
        "start_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b",
        "stop_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b",
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
      "id": "f9b7e0fa-13dd-45c6-8f4f-08af2c86ae1d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
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
        "item_id": "fb4bb3bd-cfac-43ab-86a7-c1dfe8835ef7",
        "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41",
        "start_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b",
        "stop_location_id": "4e1130c4-45f3-414b-b8c5-21db64ba2b5b",
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
      "id": "a3d36718-acb3-4091-8c9a-f815f7f39039",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "45ea483a-eccd-4706-9a55-9aa567b5a5db",
        "planning_id": "3ed91461-f410-4048-986b-502c1ba2cd24",
        "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41"
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
      "id": "8d0de3dd-3ec9-4fc8-ae55-e6bd303850de",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e75959ff-c187-4a0d-8ccb-62feb44d57ea",
        "planning_id": "3ed91461-f410-4048-986b-502c1ba2cd24",
        "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41"
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
      "id": "38deff9f-0442-420d-8156-b7d61048e62a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:12+00:00",
        "updated_at": "2023-02-08T15:44:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "92deb8f1-01f0-40d8-9b59-f21a3beee31f",
        "planning_id": "3ed91461-f410-4048-986b-502c1ba2cd24",
        "order_id": "5c7b4554-ae69-44ee-a18a-b0bdd8fc2f41"
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
          "order_id": "a42bb825-65fc-4fde-b355-3c2c46db07c2",
          "items": [
            {
              "type": "bundles",
              "id": "aa8e750a-45c5-463b-ba78-ddf0cb496b4b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b706725e-b7c5-4fb6-b7df-2006edd93d41",
                  "id": "ce11fc28-64c1-48fb-9076-055a5f1b0f95"
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
    "id": "d68e272c-355f-5631-896a-c91d79c4a2f5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a42bb825-65fc-4fde-b355-3c2c46db07c2"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a42bb825-65fc-4fde-b355-3c2c46db07c2"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "628fd52a-5f36-4060-ae1e-8d4db66b7479"
          },
          {
            "type": "lines",
            "id": "1829789b-7daa-4b40-8668-ab468b21444e"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a035a6b6-e340-47d2-91d7-b875a7edab07"
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
      "id": "a42bb825-65fc-4fde-b355-3c2c46db07c2",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:44:14+00:00",
        "updated_at": "2023-02-08T15:44:15+00:00",
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
        "starts_at": "2023-02-06T15:30:00+00:00",
        "stops_at": "2023-02-10T15:30:00+00:00",
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
        "start_location_id": "167a6b5d-8b5c-4cbe-82bf-4129a48c7239",
        "stop_location_id": "167a6b5d-8b5c-4cbe-82bf-4129a48c7239"
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
      "id": "628fd52a-5f36-4060-ae1e-8d4db66b7479",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:44:15+00:00",
        "updated_at": "2023-02-08T15:44:15+00:00",
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
        "item_id": "ce11fc28-64c1-48fb-9076-055a5f1b0f95",
        "tax_category_id": null,
        "planning_id": "49f45048-ed08-4734-9ba4-c36a3ad642e0",
        "parent_line_id": "1829789b-7daa-4b40-8668-ab468b21444e",
        "owner_id": "a42bb825-65fc-4fde-b355-3c2c46db07c2",
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
      "id": "1829789b-7daa-4b40-8668-ab468b21444e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:44:15+00:00",
        "updated_at": "2023-02-08T15:44:15+00:00",
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
        "item_id": "aa8e750a-45c5-463b-ba78-ddf0cb496b4b",
        "tax_category_id": null,
        "planning_id": "a035a6b6-e340-47d2-91d7-b875a7edab07",
        "parent_line_id": null,
        "owner_id": "a42bb825-65fc-4fde-b355-3c2c46db07c2",
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
      "id": "a035a6b6-e340-47d2-91d7-b875a7edab07",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:44:15+00:00",
        "updated_at": "2023-02-08T15:44:15+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T15:30:00+00:00",
        "stops_at": "2023-02-10T15:30:00+00:00",
        "reserved_from": "2023-02-06T15:30:00+00:00",
        "reserved_till": "2023-02-10T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "aa8e750a-45c5-463b-ba78-ddf0cb496b4b",
        "order_id": "a42bb825-65fc-4fde-b355-3c2c46db07c2",
        "start_location_id": "167a6b5d-8b5c-4cbe-82bf-4129a48c7239",
        "stop_location_id": "167a6b5d-8b5c-4cbe-82bf-4129a48c7239",
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





