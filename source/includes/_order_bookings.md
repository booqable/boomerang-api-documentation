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
          "order_id": "b6736bb3-6903-4225-9fb0-c79c55ea8002",
          "items": [
            {
              "type": "products",
              "id": "ce4042d4-3f1e-47b5-ba6b-2e888f756140",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4015a17a-e1a4-405c-9baf-61ee4b93b7c0",
              "stock_item_ids": [
                "7bffe979-43b2-42eb-b67f-b6097621d944",
                "99470414-7804-4b14-b469-11d1beb56062"
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
            "item_id": "ce4042d4-3f1e-47b5-ba6b-2e888f756140",
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
          "order_id": "17c10403-018b-407c-827d-2a1042c230bb",
          "items": [
            {
              "type": "products",
              "id": "e6573c09-d3d8-47ff-89d0-0f034db8fcc8",
              "stock_item_ids": [
                "2e7aa5c1-d564-414d-826d-ffa60f4ddfab",
                "9727a78d-ad24-4157-94df-df940a1e81fd",
                "eec71157-375e-4bdf-a06c-5907bdcb55f5"
              ]
            },
            {
              "type": "products",
              "id": "22646693-a980-4359-9ae0-763e7a59a9be",
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
    "id": "680219a8-213b-5499-997d-0727c68aa69d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "17c10403-018b-407c-827d-2a1042c230bb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "17c10403-018b-407c-827d-2a1042c230bb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4b2f0a40-8e7b-4593-bc1e-226665fc6267"
          },
          {
            "type": "lines",
            "id": "af7359c2-d9a7-4896-b652-60eab7efc6a4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "05a3852a-5251-4852-9087-724ff2624a6d"
          },
          {
            "type": "plannings",
            "id": "28c6150d-fa12-46ba-a141-a394fc8668be"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ac06d215-683d-4622-b8d9-24cf7d8568d3"
          },
          {
            "type": "stock_item_plannings",
            "id": "1129694e-f213-4159-a25c-ae689e2e8d78"
          },
          {
            "type": "stock_item_plannings",
            "id": "70cb58be-8562-4336-bc42-e7615636fb15"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "17c10403-018b-407c-827d-2a1042c230bb",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-09T10:03:06+00:00",
        "updated_at": "2022-03-09T10:03:09+00:00",
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
        "customer_id": "09d513d5-35b1-4857-981f-14ba50d9cf31",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd",
        "stop_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd"
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
      "id": "4b2f0a40-8e7b-4593-bc1e-226665fc6267",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-09T10:03:07+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
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
        "item_id": "22646693-a980-4359-9ae0-763e7a59a9be",
        "tax_category_id": "e450edbf-00e8-4d6c-8da9-3f5de9a635e9",
        "planning_id": "05a3852a-5251-4852-9087-724ff2624a6d",
        "parent_line_id": null,
        "owner_id": "17c10403-018b-407c-827d-2a1042c230bb",
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
      "id": "af7359c2-d9a7-4896-b652-60eab7efc6a4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-09T10:03:08+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
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
        "item_id": "e6573c09-d3d8-47ff-89d0-0f034db8fcc8",
        "tax_category_id": "e450edbf-00e8-4d6c-8da9-3f5de9a635e9",
        "planning_id": "28c6150d-fa12-46ba-a141-a394fc8668be",
        "parent_line_id": null,
        "owner_id": "17c10403-018b-407c-827d-2a1042c230bb",
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
      "id": "05a3852a-5251-4852-9087-724ff2624a6d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:07+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
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
        "item_id": "22646693-a980-4359-9ae0-763e7a59a9be",
        "order_id": "17c10403-018b-407c-827d-2a1042c230bb",
        "start_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd",
        "stop_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd",
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
      "id": "28c6150d-fa12-46ba-a141-a394fc8668be",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:08+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
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
        "item_id": "e6573c09-d3d8-47ff-89d0-0f034db8fcc8",
        "order_id": "17c10403-018b-407c-827d-2a1042c230bb",
        "start_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd",
        "stop_location_id": "fc258d6e-d050-4085-8b0c-186ad22b61dd",
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
      "id": "ac06d215-683d-4622-b8d9-24cf7d8568d3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:08+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e7aa5c1-d564-414d-826d-ffa60f4ddfab",
        "planning_id": "28c6150d-fa12-46ba-a141-a394fc8668be",
        "order_id": "17c10403-018b-407c-827d-2a1042c230bb"
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
      "id": "1129694e-f213-4159-a25c-ae689e2e8d78",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:08+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9727a78d-ad24-4157-94df-df940a1e81fd",
        "planning_id": "28c6150d-fa12-46ba-a141-a394fc8668be",
        "order_id": "17c10403-018b-407c-827d-2a1042c230bb"
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
      "id": "70cb58be-8562-4336-bc42-e7615636fb15",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:08+00:00",
        "updated_at": "2022-03-09T10:03:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eec71157-375e-4bdf-a06c-5907bdcb55f5",
        "planning_id": "28c6150d-fa12-46ba-a141-a394fc8668be",
        "order_id": "17c10403-018b-407c-827d-2a1042c230bb"
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
          "order_id": "fc980c01-0dcc-4a2f-868d-98a7097085bc",
          "items": [
            {
              "type": "bundles",
              "id": "342d1ee9-f8b2-4b2f-9b4b-1ab5cf42e6e4",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "507eec10-b613-4688-b248-4936babcb8e2",
                  "id": "4b3bf2df-8ffc-4112-b5e6-89665aefc0e1"
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
    "id": "2ffd1e2b-7ba0-570d-a75f-11690d6fbec4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fc980c01-0dcc-4a2f-868d-98a7097085bc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fc980c01-0dcc-4a2f-868d-98a7097085bc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ee53d844-4a40-4773-855d-2f5b647a2bda"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "dc0d4162-dc9a-4866-9642-e987bce20541"
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
      "id": "fc980c01-0dcc-4a2f-868d-98a7097085bc",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-09T10:03:11+00:00",
        "updated_at": "2022-03-09T10:03:12+00:00",
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
        "starts_at": "2022-03-07T10:00:00+00:00",
        "stops_at": "2022-03-11T10:00:00+00:00",
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
        "start_location_id": "46133427-d3a3-4651-bb5e-edecd1f95ace",
        "stop_location_id": "46133427-d3a3-4651-bb5e-edecd1f95ace"
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
      "id": "ee53d844-4a40-4773-855d-2f5b647a2bda",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-09T10:03:12+00:00",
        "updated_at": "2022-03-09T10:03:12+00:00",
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
        "item_id": "342d1ee9-f8b2-4b2f-9b4b-1ab5cf42e6e4",
        "tax_category_id": null,
        "planning_id": "dc0d4162-dc9a-4866-9642-e987bce20541",
        "parent_line_id": null,
        "owner_id": "fc980c01-0dcc-4a2f-868d-98a7097085bc",
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
      "id": "dc0d4162-dc9a-4866-9642-e987bce20541",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-09T10:03:12+00:00",
        "updated_at": "2022-03-09T10:03:12+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-07T10:00:00+00:00",
        "stops_at": "2022-03-11T10:00:00+00:00",
        "reserved_from": "2022-03-07T10:00:00+00:00",
        "reserved_till": "2022-03-11T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "342d1ee9-f8b2-4b2f-9b4b-1ab5cf42e6e4",
        "order_id": "fc980c01-0dcc-4a2f-868d-98a7097085bc",
        "start_location_id": "46133427-d3a3-4651-bb5e-edecd1f95ace",
        "stop_location_id": "46133427-d3a3-4651-bb5e-edecd1f95ace",
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





