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
          "order_id": "eb99c78a-de4a-4496-a9b2-20643409b133",
          "items": [
            {
              "type": "products",
              "id": "ba176bd0-eeb8-40df-8db5-b0e42f3fa931",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ec1febb8-cd9d-45db-960a-b2caf962cab2",
              "stock_item_ids": [
                "878cea5c-ca21-46d1-b785-01abb27d51b6",
                "0f7c95e6-c77e-4caa-a8f7-dbbb7dcb5bd9"
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
            "item_id": "ba176bd0-eeb8-40df-8db5-b0e42f3fa931",
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
          "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779",
          "items": [
            {
              "type": "products",
              "id": "281ead28-fba7-4da2-be61-e48a5d8a2710",
              "stock_item_ids": [
                "a45c0278-5540-4972-bf52-b5e61aabc504",
                "317ff2d9-d126-4410-b293-4a8dae75b541",
                "07196e06-624f-4f99-b935-645a85b5bac1"
              ]
            },
            {
              "type": "products",
              "id": "5a0f67df-65b1-4754-8f57-a00795ba7e10",
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
    "id": "2d8feae0-90a3-5088-8b8e-ce96c9fe73ff",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cf5e6632-448e-4a08-b189-51cb38aea779"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4b42ef9c-5269-4e1c-8e00-253b015f19c4"
          },
          {
            "type": "lines",
            "id": "e5425247-c973-41ab-bed8-a08da7635fb8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0edf9189-2f4a-4310-a021-fc9410b21896"
          },
          {
            "type": "plannings",
            "id": "9e5f30a7-19ce-4754-af94-fe45b8de9776"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c0be6dbb-4f0f-4093-a6b1-c4ce120dd488"
          },
          {
            "type": "stock_item_plannings",
            "id": "77f5def8-f94e-49a7-b142-e5e9ee1e2d4e"
          },
          {
            "type": "stock_item_plannings",
            "id": "6e531ced-a282-4831-aee5-b97b50b36dd6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cf5e6632-448e-4a08-b189-51cb38aea779",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-27T06:43:46+00:00",
        "updated_at": "2022-09-27T06:43:48+00:00",
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
        "customer_id": "ac919018-58b3-4526-9eba-a4b73dce6221",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6",
        "stop_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6"
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
      "id": "4b42ef9c-5269-4e1c-8e00-253b015f19c4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:48+00:00",
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
        "item_id": "281ead28-fba7-4da2-be61-e48a5d8a2710",
        "tax_category_id": "e06b46d8-5077-498f-ad48-1b1a66c500c2",
        "planning_id": "0edf9189-2f4a-4310-a021-fc9410b21896",
        "parent_line_id": null,
        "owner_id": "cf5e6632-448e-4a08-b189-51cb38aea779",
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
      "id": "e5425247-c973-41ab-bed8-a08da7635fb8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:48+00:00",
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
        "item_id": "5a0f67df-65b1-4754-8f57-a00795ba7e10",
        "tax_category_id": "e06b46d8-5077-498f-ad48-1b1a66c500c2",
        "planning_id": "9e5f30a7-19ce-4754-af94-fe45b8de9776",
        "parent_line_id": null,
        "owner_id": "cf5e6632-448e-4a08-b189-51cb38aea779",
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
      "id": "0edf9189-2f4a-4310-a021-fc9410b21896",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:48+00:00",
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
        "item_id": "281ead28-fba7-4da2-be61-e48a5d8a2710",
        "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779",
        "start_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6",
        "stop_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6",
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
      "id": "9e5f30a7-19ce-4754-af94-fe45b8de9776",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:48+00:00",
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
        "item_id": "5a0f67df-65b1-4754-8f57-a00795ba7e10",
        "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779",
        "start_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6",
        "stop_location_id": "1016069e-ef93-4ebf-9e76-81b1083a4fb6",
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
      "id": "c0be6dbb-4f0f-4093-a6b1-c4ce120dd488",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a45c0278-5540-4972-bf52-b5e61aabc504",
        "planning_id": "0edf9189-2f4a-4310-a021-fc9410b21896",
        "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779"
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
      "id": "77f5def8-f94e-49a7-b142-e5e9ee1e2d4e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "317ff2d9-d126-4410-b293-4a8dae75b541",
        "planning_id": "0edf9189-2f4a-4310-a021-fc9410b21896",
        "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779"
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
      "id": "6e531ced-a282-4831-aee5-b97b50b36dd6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:47+00:00",
        "updated_at": "2022-09-27T06:43:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "07196e06-624f-4f99-b935-645a85b5bac1",
        "planning_id": "0edf9189-2f4a-4310-a021-fc9410b21896",
        "order_id": "cf5e6632-448e-4a08-b189-51cb38aea779"
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
          "order_id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998",
          "items": [
            {
              "type": "bundles",
              "id": "6d619fc3-2a64-469c-924a-12bcf5bd1e24",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5a71b00c-a1da-4721-9658-de7ef54b9291",
                  "id": "e63d98c0-a11e-42a7-bbb5-1611e4599e14"
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
    "id": "2e813554-50c8-5349-84bc-e2015473a8db",
    "type": "order_bookings",
    "attributes": {
      "order_id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "46603c9d-7df3-40bd-9305-8b0293261308"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2d314daa-91a0-4b34-bb78-6188e55d03bb"
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
      "id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-27T06:43:50+00:00",
        "updated_at": "2022-09-27T06:43:51+00:00",
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
        "starts_at": "2022-09-25T06:30:00+00:00",
        "stops_at": "2022-09-29T06:30:00+00:00",
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
        "start_location_id": "b66214eb-ac0d-4dee-9e1a-b6459d045d19",
        "stop_location_id": "b66214eb-ac0d-4dee-9e1a-b6459d045d19"
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
      "id": "46603c9d-7df3-40bd-9305-8b0293261308",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-27T06:43:51+00:00",
        "updated_at": "2022-09-27T06:43:51+00:00",
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
        "item_id": "6d619fc3-2a64-469c-924a-12bcf5bd1e24",
        "tax_category_id": null,
        "planning_id": "2d314daa-91a0-4b34-bb78-6188e55d03bb",
        "parent_line_id": null,
        "owner_id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998",
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
      "id": "2d314daa-91a0-4b34-bb78-6188e55d03bb",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-27T06:43:51+00:00",
        "updated_at": "2022-09-27T06:43:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-25T06:30:00+00:00",
        "stops_at": "2022-09-29T06:30:00+00:00",
        "reserved_from": "2022-09-25T06:30:00+00:00",
        "reserved_till": "2022-09-29T06:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6d619fc3-2a64-469c-924a-12bcf5bd1e24",
        "order_id": "59a0d942-5e86-4db7-8ef1-0dbf63e4f998",
        "start_location_id": "b66214eb-ac0d-4dee-9e1a-b6459d045d19",
        "stop_location_id": "b66214eb-ac0d-4dee-9e1a-b6459d045d19",
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





