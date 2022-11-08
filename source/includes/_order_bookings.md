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
          "order_id": "7eea9b76-f714-4824-ba50-2d5fe9106967",
          "items": [
            {
              "type": "products",
              "id": "ecfc8ff0-dcef-419c-b20b-080564a63077",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0069967a-3e10-49c7-9690-dd657aef4db2",
              "stock_item_ids": [
                "b3c37b34-f8b8-4e3e-af5c-70f27e85ad47",
                "8c45794b-41bc-4d6e-ac00-9cfc04ab664f"
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
            "item_id": "ecfc8ff0-dcef-419c-b20b-080564a63077",
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
          "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
          "items": [
            {
              "type": "products",
              "id": "33ae57bc-50c2-4782-96fa-68b31f02e29c",
              "stock_item_ids": [
                "f0039f0b-4c55-4177-be8c-63adcae644cd",
                "4b5ed007-58bf-45eb-8a34-96cda695931b",
                "827b4b8f-fe77-4a88-899b-77f5e427e998"
              ]
            },
            {
              "type": "products",
              "id": "c4c2e823-5a3a-4744-935c-f0df02d1fa97",
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
    "id": "87d8f3f7-a937-5feb-9457-1037552a4a86",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "505e2a87-07f2-47d5-be47-aa68fbbb2d7f"
          },
          {
            "type": "lines",
            "id": "f4fdde6c-5079-4628-8d9b-5a82446c3eb3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "11637d8c-7542-4d37-a187-996c2458025d"
          },
          {
            "type": "plannings",
            "id": "2f4bc08a-301b-4e9f-a7b1-9acabeea1d7e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fb9cb28b-717f-4217-a382-ebef7ab73a9c"
          },
          {
            "type": "stock_item_plannings",
            "id": "340f4631-7fce-4663-b041-4a0598520cdd"
          },
          {
            "type": "stock_item_plannings",
            "id": "2b426d0f-041b-4087-bc61-e6bbce756918"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-08T13:53:39+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
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
        "customer_id": "c859cf82-5b33-4269-8414-9bb306ee8fbb",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1",
        "stop_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1"
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
      "id": "505e2a87-07f2-47d5-be47-aa68fbbb2d7f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-08T13:53:42+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
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
        "item_id": "33ae57bc-50c2-4782-96fa-68b31f02e29c",
        "tax_category_id": "24228f81-267a-41ca-9108-5e03f5e8f9bd",
        "planning_id": "11637d8c-7542-4d37-a187-996c2458025d",
        "parent_line_id": null,
        "owner_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
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
      "id": "f4fdde6c-5079-4628-8d9b-5a82446c3eb3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-08T13:53:42+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
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
        "item_id": "c4c2e823-5a3a-4744-935c-f0df02d1fa97",
        "tax_category_id": "24228f81-267a-41ca-9108-5e03f5e8f9bd",
        "planning_id": "2f4bc08a-301b-4e9f-a7b1-9acabeea1d7e",
        "parent_line_id": null,
        "owner_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
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
      "id": "11637d8c-7542-4d37-a187-996c2458025d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:41+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
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
        "item_id": "33ae57bc-50c2-4782-96fa-68b31f02e29c",
        "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
        "start_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1",
        "stop_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1",
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
      "id": "2f4bc08a-301b-4e9f-a7b1-9acabeea1d7e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:41+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
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
        "item_id": "c4c2e823-5a3a-4744-935c-f0df02d1fa97",
        "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5",
        "start_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1",
        "stop_location_id": "8ae5e18a-08c1-4161-b5fc-57a59c0e81b1",
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
      "id": "fb9cb28b-717f-4217-a382-ebef7ab73a9c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:41+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f0039f0b-4c55-4177-be8c-63adcae644cd",
        "planning_id": "11637d8c-7542-4d37-a187-996c2458025d",
        "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5"
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
      "id": "340f4631-7fce-4663-b041-4a0598520cdd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:41+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4b5ed007-58bf-45eb-8a34-96cda695931b",
        "planning_id": "11637d8c-7542-4d37-a187-996c2458025d",
        "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5"
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
      "id": "2b426d0f-041b-4087-bc61-e6bbce756918",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:41+00:00",
        "updated_at": "2022-11-08T13:53:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "827b4b8f-fe77-4a88-899b-77f5e427e998",
        "planning_id": "11637d8c-7542-4d37-a187-996c2458025d",
        "order_id": "e1dc0597-dc5b-4e8e-873a-ebcf958f1ea5"
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
          "order_id": "6c33dabd-d0f3-47ed-9975-edaa748d0506",
          "items": [
            {
              "type": "bundles",
              "id": "3eb15a3f-818a-4ead-9d10-115dcb86b5a5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4b2aee94-8ad5-494f-ad07-8dde9ea17e2c",
                  "id": "87aa4424-2978-4d86-bde8-df726259bbba"
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
    "id": "bdeba444-c81a-5dd5-8ffe-3b66d06b45df",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6c33dabd-d0f3-47ed-9975-edaa748d0506"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6c33dabd-d0f3-47ed-9975-edaa748d0506"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d1f19555-e7f3-4261-87e4-aedcdd3e5957"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "71542646-d3dc-48cc-b885-be4c21a1254a"
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
      "id": "6c33dabd-d0f3-47ed-9975-edaa748d0506",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-08T13:53:44+00:00",
        "updated_at": "2022-11-08T13:53:46+00:00",
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
        "starts_at": "2022-11-06T13:45:00+00:00",
        "stops_at": "2022-11-10T13:45:00+00:00",
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
        "start_location_id": "518865f5-963e-46f4-b050-5ab88d1da8ef",
        "stop_location_id": "518865f5-963e-46f4-b050-5ab88d1da8ef"
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
      "id": "d1f19555-e7f3-4261-87e4-aedcdd3e5957",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-08T13:53:45+00:00",
        "updated_at": "2022-11-08T13:53:45+00:00",
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
        "item_id": "3eb15a3f-818a-4ead-9d10-115dcb86b5a5",
        "tax_category_id": null,
        "planning_id": "71542646-d3dc-48cc-b885-be4c21a1254a",
        "parent_line_id": null,
        "owner_id": "6c33dabd-d0f3-47ed-9975-edaa748d0506",
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
      "id": "71542646-d3dc-48cc-b885-be4c21a1254a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-08T13:53:45+00:00",
        "updated_at": "2022-11-08T13:53:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-06T13:45:00+00:00",
        "stops_at": "2022-11-10T13:45:00+00:00",
        "reserved_from": "2022-11-06T13:45:00+00:00",
        "reserved_till": "2022-11-10T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3eb15a3f-818a-4ead-9d10-115dcb86b5a5",
        "order_id": "6c33dabd-d0f3-47ed-9975-edaa748d0506",
        "start_location_id": "518865f5-963e-46f4-b050-5ab88d1da8ef",
        "stop_location_id": "518865f5-963e-46f4-b050-5ab88d1da8ef",
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





