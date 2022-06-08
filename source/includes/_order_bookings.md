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
          "order_id": "f51d1d7d-28db-4bc3-b814-2653c1f3c859",
          "items": [
            {
              "type": "products",
              "id": "ca4d99e3-c57f-484f-be1d-78560eefa7b9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "758b467f-8874-41e3-9d3f-24183cf4480c",
              "stock_item_ids": [
                "6380928b-197c-413f-8908-e4690819d337",
                "5c03fd62-67b1-41c9-b24e-ea50053cc32a"
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
            "item_id": "ca4d99e3-c57f-484f-be1d-78560eefa7b9",
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
          "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
          "items": [
            {
              "type": "products",
              "id": "518e86e7-8aa3-4042-9022-1ae75ec8bd89",
              "stock_item_ids": [
                "65ab9e3e-bb95-4e08-8411-9dfa8784e062",
                "0ecd5c21-0f10-4403-b15c-a1e9bd3fbc47",
                "da1fbcdb-9e1b-4470-9e2b-c42b46e72e6b"
              ]
            },
            {
              "type": "products",
              "id": "165f40d3-6394-437e-be33-90724bb26c83",
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
    "id": "879b6b56-83ef-51e5-b5be-0ebf0572348a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "28263d2d-2c84-4026-866f-2b1e399b7a73"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "99162f45-1463-459f-ad3f-1656e6357e6e"
          },
          {
            "type": "lines",
            "id": "71ffc9a1-628b-47cf-8baf-2db8ce40d756"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1ae316e5-4330-4781-adc8-06f4c2a60180"
          },
          {
            "type": "plannings",
            "id": "6b49da9c-944b-487a-b33f-a79cd363090a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3f195d18-0933-4ec0-950d-9c2ce650e412"
          },
          {
            "type": "stock_item_plannings",
            "id": "15d0d233-a7cd-43e6-855a-8da3f141e1b4"
          },
          {
            "type": "stock_item_plannings",
            "id": "016284a1-bf88-437d-afa8-7ceeeeb17579"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-08T14:25:59+00:00",
        "updated_at": "2022-06-08T14:26:02+00:00",
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
        "customer_id": "6e308708-f494-4af3-b388-530341779f4b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6842385d-d198-47d2-b289-8940036caba5",
        "stop_location_id": "6842385d-d198-47d2-b289-8940036caba5"
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
      "id": "99162f45-1463-459f-ad3f-1656e6357e6e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T14:26:00+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
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
        "item_id": "165f40d3-6394-437e-be33-90724bb26c83",
        "tax_category_id": "fbc22e9c-7b34-4a0c-b56e-0ae6f3975225",
        "planning_id": "1ae316e5-4330-4781-adc8-06f4c2a60180",
        "parent_line_id": null,
        "owner_id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
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
      "id": "71ffc9a1-628b-47cf-8baf-2db8ce40d756",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T14:26:01+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
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
        "item_id": "518e86e7-8aa3-4042-9022-1ae75ec8bd89",
        "tax_category_id": "fbc22e9c-7b34-4a0c-b56e-0ae6f3975225",
        "planning_id": "6b49da9c-944b-487a-b33f-a79cd363090a",
        "parent_line_id": null,
        "owner_id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
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
      "id": "1ae316e5-4330-4781-adc8-06f4c2a60180",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:00+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
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
        "item_id": "165f40d3-6394-437e-be33-90724bb26c83",
        "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
        "start_location_id": "6842385d-d198-47d2-b289-8940036caba5",
        "stop_location_id": "6842385d-d198-47d2-b289-8940036caba5",
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
      "id": "6b49da9c-944b-487a-b33f-a79cd363090a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:01+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
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
        "item_id": "518e86e7-8aa3-4042-9022-1ae75ec8bd89",
        "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73",
        "start_location_id": "6842385d-d198-47d2-b289-8940036caba5",
        "stop_location_id": "6842385d-d198-47d2-b289-8940036caba5",
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
      "id": "3f195d18-0933-4ec0-950d-9c2ce650e412",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:01+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "65ab9e3e-bb95-4e08-8411-9dfa8784e062",
        "planning_id": "6b49da9c-944b-487a-b33f-a79cd363090a",
        "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73"
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
      "id": "15d0d233-a7cd-43e6-855a-8da3f141e1b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:01+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0ecd5c21-0f10-4403-b15c-a1e9bd3fbc47",
        "planning_id": "6b49da9c-944b-487a-b33f-a79cd363090a",
        "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73"
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
      "id": "016284a1-bf88-437d-afa8-7ceeeeb17579",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:01+00:00",
        "updated_at": "2022-06-08T14:26:01+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "da1fbcdb-9e1b-4470-9e2b-c42b46e72e6b",
        "planning_id": "6b49da9c-944b-487a-b33f-a79cd363090a",
        "order_id": "28263d2d-2c84-4026-866f-2b1e399b7a73"
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
          "order_id": "ee99763d-077a-477b-921f-1fe8a5c0b493",
          "items": [
            {
              "type": "bundles",
              "id": "71ab19a6-68f7-437a-8edb-bf9c36557546",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "ff33d4d3-3163-4480-a18e-3f3900d7b624",
                  "id": "c0115671-13fe-4f24-ae76-6d14550d06e5"
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
    "id": "5165b60f-cd87-52da-b50c-054c76c54ae8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ee99763d-077a-477b-921f-1fe8a5c0b493"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ee99763d-077a-477b-921f-1fe8a5c0b493"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "74c4086b-3a62-45e4-9806-1a0b8611c673"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "848baeb6-d876-4492-a573-0a8c25834362"
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
      "id": "ee99763d-077a-477b-921f-1fe8a5c0b493",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-08T14:26:05+00:00",
        "updated_at": "2022-06-08T14:26:07+00:00",
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
        "starts_at": "2022-06-06T14:15:00+00:00",
        "stops_at": "2022-06-10T14:15:00+00:00",
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
        "start_location_id": "d8d8bebe-a45d-4a3a-a85f-0905b6ae0966",
        "stop_location_id": "d8d8bebe-a45d-4a3a-a85f-0905b6ae0966"
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
      "id": "74c4086b-3a62-45e4-9806-1a0b8611c673",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T14:26:07+00:00",
        "updated_at": "2022-06-08T14:26:07+00:00",
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
        "item_id": "71ab19a6-68f7-437a-8edb-bf9c36557546",
        "tax_category_id": null,
        "planning_id": "848baeb6-d876-4492-a573-0a8c25834362",
        "parent_line_id": null,
        "owner_id": "ee99763d-077a-477b-921f-1fe8a5c0b493",
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
      "id": "848baeb6-d876-4492-a573-0a8c25834362",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T14:26:06+00:00",
        "updated_at": "2022-06-08T14:26:06+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-06T14:15:00+00:00",
        "stops_at": "2022-06-10T14:15:00+00:00",
        "reserved_from": "2022-06-06T14:15:00+00:00",
        "reserved_till": "2022-06-10T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "71ab19a6-68f7-437a-8edb-bf9c36557546",
        "order_id": "ee99763d-077a-477b-921f-1fe8a5c0b493",
        "start_location_id": "d8d8bebe-a45d-4a3a-a85f-0905b6ae0966",
        "stop_location_id": "d8d8bebe-a45d-4a3a-a85f-0905b6ae0966",
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





