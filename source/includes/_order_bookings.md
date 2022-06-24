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
          "order_id": "2f0ce48b-6411-49da-97d8-1fc4661a8eb3",
          "items": [
            {
              "type": "products",
              "id": "a955b058-8e70-4fc5-ba56-a0176875d3c4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ac1c182b-abfd-446c-a8e8-a0d4e335e15a",
              "stock_item_ids": [
                "7dc01923-7e49-4584-bf69-01decb34982a",
                "feeddbd6-417c-41e5-b640-1253b8214c46"
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
            "item_id": "a955b058-8e70-4fc5-ba56-a0176875d3c4",
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
          "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
          "items": [
            {
              "type": "products",
              "id": "1939e516-385c-4821-8d17-942ba9d6f987",
              "stock_item_ids": [
                "c2bff062-4165-4fd2-a1de-8c2b7a376a32",
                "09c8f8eb-32ea-49a4-a796-343eea59ab40",
                "be3a3bca-fe70-443a-8fd4-2aa93c74c512"
              ]
            },
            {
              "type": "products",
              "id": "c87aca88-50a1-4ac0-a733-1eb81121aa0a",
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
    "id": "6c9368f7-2ad6-560a-89f0-43ad030e3ec4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "56cdaeb4-e0d1-49e2-b536-220a7bc4985b"
          },
          {
            "type": "lines",
            "id": "f2a0e06d-5ee0-4e71-9677-1064af09b7a1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5020e764-190b-4b32-ba46-b2a8a2e17806"
          },
          {
            "type": "plannings",
            "id": "35fe27aa-d74e-499f-a379-e04999ec5bad"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fadfe6bf-6592-4cb6-b5dd-7287fe26ad74"
          },
          {
            "type": "stock_item_plannings",
            "id": "f209c6d9-f163-4de5-add4-05ecff3e3f3e"
          },
          {
            "type": "stock_item_plannings",
            "id": "5751e641-ffe0-4eb9-b3b7-a67d23a265be"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-24T14:46:33+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
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
        "customer_id": "a75c669e-4fa1-4f32-a181-78ca2802a732",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f",
        "stop_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f"
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
      "id": "56cdaeb4-e0d1-49e2-b536-220a7bc4985b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-24T14:46:34+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
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
        "item_id": "c87aca88-50a1-4ac0-a733-1eb81121aa0a",
        "tax_category_id": "0ba96e92-035f-4fdd-9cb1-596a9b635e3b",
        "planning_id": "5020e764-190b-4b32-ba46-b2a8a2e17806",
        "parent_line_id": null,
        "owner_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
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
      "id": "f2a0e06d-5ee0-4e71-9677-1064af09b7a1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-24T14:46:35+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
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
        "item_id": "1939e516-385c-4821-8d17-942ba9d6f987",
        "tax_category_id": "0ba96e92-035f-4fdd-9cb1-596a9b635e3b",
        "planning_id": "35fe27aa-d74e-499f-a379-e04999ec5bad",
        "parent_line_id": null,
        "owner_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
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
      "id": "5020e764-190b-4b32-ba46-b2a8a2e17806",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:34+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
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
        "item_id": "c87aca88-50a1-4ac0-a733-1eb81121aa0a",
        "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
        "start_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f",
        "stop_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f",
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
      "id": "35fe27aa-d74e-499f-a379-e04999ec5bad",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:35+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
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
        "item_id": "1939e516-385c-4821-8d17-942ba9d6f987",
        "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d",
        "start_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f",
        "stop_location_id": "7efbfca9-a6e9-47fb-90fe-f7b698728d9f",
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
      "id": "fadfe6bf-6592-4cb6-b5dd-7287fe26ad74",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:35+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c2bff062-4165-4fd2-a1de-8c2b7a376a32",
        "planning_id": "35fe27aa-d74e-499f-a379-e04999ec5bad",
        "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d"
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
      "id": "f209c6d9-f163-4de5-add4-05ecff3e3f3e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:35+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "09c8f8eb-32ea-49a4-a796-343eea59ab40",
        "planning_id": "35fe27aa-d74e-499f-a379-e04999ec5bad",
        "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d"
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
      "id": "5751e641-ffe0-4eb9-b3b7-a67d23a265be",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:35+00:00",
        "updated_at": "2022-06-24T14:46:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "be3a3bca-fe70-443a-8fd4-2aa93c74c512",
        "planning_id": "35fe27aa-d74e-499f-a379-e04999ec5bad",
        "order_id": "9bac4fba-a5e0-4aa8-8f12-2461b2d57b0d"
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
          "order_id": "399ded1e-92c7-44d7-9dc0-37be31e0b908",
          "items": [
            {
              "type": "bundles",
              "id": "bd224a61-4cff-47cf-bcaf-15aac54f6f75",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "72ca374a-7ee5-4873-8379-9e96b8b35056",
                  "id": "6294e1b2-411d-4e12-84ce-da6a9dc88033"
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
    "id": "1b71db19-b150-5c79-9d74-655a5adca45f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "399ded1e-92c7-44d7-9dc0-37be31e0b908"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "399ded1e-92c7-44d7-9dc0-37be31e0b908"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1cd1d886-358a-4837-8588-5da4baa3ac9b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "113292e9-e612-400c-937c-dd4945155eac"
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
      "id": "399ded1e-92c7-44d7-9dc0-37be31e0b908",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-24T14:46:37+00:00",
        "updated_at": "2022-06-24T14:46:38+00:00",
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
        "starts_at": "2022-06-22T14:45:00+00:00",
        "stops_at": "2022-06-26T14:45:00+00:00",
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
        "start_location_id": "63b12887-b943-4214-b0c7-28f2c56ed101",
        "stop_location_id": "63b12887-b943-4214-b0c7-28f2c56ed101"
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
      "id": "1cd1d886-358a-4837-8588-5da4baa3ac9b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-24T14:46:38+00:00",
        "updated_at": "2022-06-24T14:46:38+00:00",
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
        "item_id": "bd224a61-4cff-47cf-bcaf-15aac54f6f75",
        "tax_category_id": null,
        "planning_id": "113292e9-e612-400c-937c-dd4945155eac",
        "parent_line_id": null,
        "owner_id": "399ded1e-92c7-44d7-9dc0-37be31e0b908",
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
      "id": "113292e9-e612-400c-937c-dd4945155eac",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-24T14:46:38+00:00",
        "updated_at": "2022-06-24T14:46:38+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-22T14:45:00+00:00",
        "stops_at": "2022-06-26T14:45:00+00:00",
        "reserved_from": "2022-06-22T14:45:00+00:00",
        "reserved_till": "2022-06-26T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "bd224a61-4cff-47cf-bcaf-15aac54f6f75",
        "order_id": "399ded1e-92c7-44d7-9dc0-37be31e0b908",
        "start_location_id": "63b12887-b943-4214-b0c7-28f2c56ed101",
        "stop_location_id": "63b12887-b943-4214-b0c7-28f2c56ed101",
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





