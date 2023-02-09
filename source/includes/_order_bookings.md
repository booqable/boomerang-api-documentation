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
          "order_id": "e29296ec-d0fe-4649-8589-94da594fe446",
          "items": [
            {
              "type": "products",
              "id": "67c0515c-26c0-455c-bc00-9da25e2b4f51",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d557891e-d34a-4f9a-97df-fe189d9a4e95",
              "stock_item_ids": [
                "110c14cf-eeae-4c27-a058-7b77db236ed6",
                "abf793c2-7a0a-4d03-bcfb-90bdadaaf61b"
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
            "item_id": "67c0515c-26c0-455c-bc00-9da25e2b4f51",
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
          "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
          "items": [
            {
              "type": "products",
              "id": "94c3afb9-3ef5-450a-8747-6042c966cb81",
              "stock_item_ids": [
                "29158380-7d0d-4c71-9132-84b1f9187d9e",
                "e2099898-9618-439e-8e18-c6e56bf8f4a5",
                "d49be678-f0d7-4836-affe-af5c78031158"
              ]
            },
            {
              "type": "products",
              "id": "2585dfa5-3054-4141-a640-5dc1c89534cc",
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
    "id": "07e6de6e-504e-5dc7-a010-7f6da424893b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3c7432c6-a59a-4872-9eaa-9a9ef3e57ad4"
          },
          {
            "type": "lines",
            "id": "0de3c0e1-8144-46ee-b1b1-5777838f43eb"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8"
          },
          {
            "type": "plannings",
            "id": "2f9be896-6cae-43f7-9819-4f7eb97ad58b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "cfb6a1b4-22dd-4e49-adf5-10bba65575b0"
          },
          {
            "type": "stock_item_plannings",
            "id": "c3ba9e70-629c-44a8-8ef6-0ccd3493d98f"
          },
          {
            "type": "stock_item_plannings",
            "id": "25b579a5-14e9-475d-91c5-78af2d79b839"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T10:11:40+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
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
        "customer_id": "37597f81-24ac-4501-a545-3fd724582d23",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1b912125-dd54-41c0-bb77-324826531996",
        "stop_location_id": "1b912125-dd54-41c0-bb77-324826531996"
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
      "id": "3c7432c6-a59a-4872-9eaa-9a9ef3e57ad4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
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
        "item_id": "94c3afb9-3ef5-450a-8747-6042c966cb81",
        "tax_category_id": "59baba7a-b92b-4248-9550-80e592c8ebae",
        "planning_id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8",
        "parent_line_id": null,
        "owner_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
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
      "id": "0de3c0e1-8144-46ee-b1b1-5777838f43eb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
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
        "item_id": "2585dfa5-3054-4141-a640-5dc1c89534cc",
        "tax_category_id": "59baba7a-b92b-4248-9550-80e592c8ebae",
        "planning_id": "2f9be896-6cae-43f7-9819-4f7eb97ad58b",
        "parent_line_id": null,
        "owner_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
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
      "id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
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
        "item_id": "94c3afb9-3ef5-450a-8747-6042c966cb81",
        "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
        "start_location_id": "1b912125-dd54-41c0-bb77-324826531996",
        "stop_location_id": "1b912125-dd54-41c0-bb77-324826531996",
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
      "id": "2f9be896-6cae-43f7-9819-4f7eb97ad58b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
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
        "item_id": "2585dfa5-3054-4141-a640-5dc1c89534cc",
        "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b",
        "start_location_id": "1b912125-dd54-41c0-bb77-324826531996",
        "stop_location_id": "1b912125-dd54-41c0-bb77-324826531996",
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
      "id": "cfb6a1b4-22dd-4e49-adf5-10bba65575b0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "29158380-7d0d-4c71-9132-84b1f9187d9e",
        "planning_id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8",
        "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b"
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
      "id": "c3ba9e70-629c-44a8-8ef6-0ccd3493d98f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e2099898-9618-439e-8e18-c6e56bf8f4a5",
        "planning_id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8",
        "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b"
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
      "id": "25b579a5-14e9-475d-91c5-78af2d79b839",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:41+00:00",
        "updated_at": "2023-02-09T10:11:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d49be678-f0d7-4836-affe-af5c78031158",
        "planning_id": "6ea9177d-24ec-46dd-91e3-ed5d5ef688c8",
        "order_id": "842ed7d9-7e84-4083-bf64-da6b18d5cc3b"
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
          "order_id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534",
          "items": [
            {
              "type": "bundles",
              "id": "0269d6b6-b321-467e-9ffd-82dc009fe59b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ad6d453b-9d67-4687-b964-9a9faf421a5c",
                  "id": "5b24a6aa-cfa5-409b-b788-39044fe7f0a3"
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
    "id": "3588e336-f993-5593-a950-ac9c2691678b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9f0d5beb-34f5-4bf2-b0ca-22e6b767bb95"
          },
          {
            "type": "lines",
            "id": "13458b95-3147-4e1a-81c6-ed1aef4ba79b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5adf7022-a1c2-42a7-9c77-22119a12ed37"
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
      "id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T10:11:43+00:00",
        "updated_at": "2023-02-09T10:11:44+00:00",
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
        "starts_at": "2023-02-07T10:00:00+00:00",
        "stops_at": "2023-02-11T10:00:00+00:00",
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
        "start_location_id": "e3548ac3-1de9-43f2-afea-72d91cd3df3f",
        "stop_location_id": "e3548ac3-1de9-43f2-afea-72d91cd3df3f"
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
      "id": "9f0d5beb-34f5-4bf2-b0ca-22e6b767bb95",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:11:44+00:00",
        "updated_at": "2023-02-09T10:11:44+00:00",
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
        "item_id": "5b24a6aa-cfa5-409b-b788-39044fe7f0a3",
        "tax_category_id": null,
        "planning_id": "0bad0487-2727-4a4c-b504-405fd95189f1",
        "parent_line_id": "13458b95-3147-4e1a-81c6-ed1aef4ba79b",
        "owner_id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534",
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
      "id": "13458b95-3147-4e1a-81c6-ed1aef4ba79b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T10:11:44+00:00",
        "updated_at": "2023-02-09T10:11:44+00:00",
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
        "item_id": "0269d6b6-b321-467e-9ffd-82dc009fe59b",
        "tax_category_id": null,
        "planning_id": "5adf7022-a1c2-42a7-9c77-22119a12ed37",
        "parent_line_id": null,
        "owner_id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534",
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
      "id": "5adf7022-a1c2-42a7-9c77-22119a12ed37",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T10:11:43+00:00",
        "updated_at": "2023-02-09T10:11:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T10:00:00+00:00",
        "stops_at": "2023-02-11T10:00:00+00:00",
        "reserved_from": "2023-02-07T10:00:00+00:00",
        "reserved_till": "2023-02-11T10:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0269d6b6-b321-467e-9ffd-82dc009fe59b",
        "order_id": "a4fe0ea8-c18b-4298-a0f0-aa0a551aa534",
        "start_location_id": "e3548ac3-1de9-43f2-afea-72d91cd3df3f",
        "stop_location_id": "e3548ac3-1de9-43f2-afea-72d91cd3df3f",
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





