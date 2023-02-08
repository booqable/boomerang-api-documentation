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
          "order_id": "98ac44a8-d1ca-4b60-89f2-bd3885f097f1",
          "items": [
            {
              "type": "products",
              "id": "e09bd510-fb0b-4914-b375-153e9ac1441f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ab478efd-6050-4f94-af87-204636bb2bd2",
              "stock_item_ids": [
                "a1b47de0-e431-4314-b96f-f9bdefbe1af9",
                "5135c5c7-de8e-4d7a-adf9-b86a609667e6"
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
            "item_id": "e09bd510-fb0b-4914-b375-153e9ac1441f",
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
          "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
          "items": [
            {
              "type": "products",
              "id": "2b232a33-4830-460e-8632-7c01fbdd8f43",
              "stock_item_ids": [
                "e2f22b49-4b0b-4f41-bf1a-6eace8db55ec",
                "1f7348ad-a51d-41dd-afff-5fd2b91822ec",
                "314da92a-1df4-4e3a-b9f1-35dcadf2a485"
              ]
            },
            {
              "type": "products",
              "id": "38414efb-98c6-448e-9445-56f2468c9bef",
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
    "id": "39df671d-fdd8-5a06-a61d-ecb66d67a145",
    "type": "order_bookings",
    "attributes": {
      "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9bfd0737-4d28-48a7-9692-d152ace2c58f"
          },
          {
            "type": "lines",
            "id": "96c2a676-f01e-414e-ba15-855633c4130c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "14e510eb-8031-493f-9867-9b3f03417a10"
          },
          {
            "type": "plannings",
            "id": "30e5abd4-57d8-41b8-af0a-a709a44a4945"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d584b886-3978-4b7a-8bb4-da83afe8fe56"
          },
          {
            "type": "stock_item_plannings",
            "id": "43903870-818a-4015-b196-1fac18134714"
          },
          {
            "type": "stock_item_plannings",
            "id": "eb08ee21-0f22-43dc-94d7-eaf87049acff"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T08:36:05+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
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
        "customer_id": "0ee4bc60-57b8-4edd-8abb-d37d147cbd67",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832",
        "stop_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832"
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
      "id": "9bfd0737-4d28-48a7-9692-d152ace2c58f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
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
        "item_id": "2b232a33-4830-460e-8632-7c01fbdd8f43",
        "tax_category_id": "f118ebc7-68ca-48b2-acf3-c2707854c564",
        "planning_id": "14e510eb-8031-493f-9867-9b3f03417a10",
        "parent_line_id": null,
        "owner_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
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
      "id": "96c2a676-f01e-414e-ba15-855633c4130c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
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
        "item_id": "38414efb-98c6-448e-9445-56f2468c9bef",
        "tax_category_id": "f118ebc7-68ca-48b2-acf3-c2707854c564",
        "planning_id": "30e5abd4-57d8-41b8-af0a-a709a44a4945",
        "parent_line_id": null,
        "owner_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
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
      "id": "14e510eb-8031-493f-9867-9b3f03417a10",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
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
        "item_id": "2b232a33-4830-460e-8632-7c01fbdd8f43",
        "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
        "start_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832",
        "stop_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832",
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
      "id": "30e5abd4-57d8-41b8-af0a-a709a44a4945",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
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
        "item_id": "38414efb-98c6-448e-9445-56f2468c9bef",
        "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc",
        "start_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832",
        "stop_location_id": "1846a51d-e47d-4ebc-b01c-1de2afa8a832",
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
      "id": "d584b886-3978-4b7a-8bb4-da83afe8fe56",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e2f22b49-4b0b-4f41-bf1a-6eace8db55ec",
        "planning_id": "14e510eb-8031-493f-9867-9b3f03417a10",
        "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc"
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
      "id": "43903870-818a-4015-b196-1fac18134714",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1f7348ad-a51d-41dd-afff-5fd2b91822ec",
        "planning_id": "14e510eb-8031-493f-9867-9b3f03417a10",
        "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc"
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
      "id": "eb08ee21-0f22-43dc-94d7-eaf87049acff",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:07+00:00",
        "updated_at": "2023-02-08T08:36:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "314da92a-1df4-4e3a-b9f1-35dcadf2a485",
        "planning_id": "14e510eb-8031-493f-9867-9b3f03417a10",
        "order_id": "45ce0caf-e673-4a98-8a9c-58e4bbc875bc"
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
          "order_id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1",
          "items": [
            {
              "type": "bundles",
              "id": "76048e12-b931-4cd5-b13d-0dce5df51eab",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d532bd2e-03a2-441f-8cb7-0008bdfc014f",
                  "id": "56fa7abd-5195-4b96-800d-1a420c08bf7b"
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
    "id": "40a14e37-64db-56a9-a6ef-ffcf0653a13a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cc1633f6-4a6f-4b66-b8a2-62cd2f87c962"
          },
          {
            "type": "lines",
            "id": "0cef8380-66d7-43f5-ba27-72a84b237496"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "66ce728e-a27b-4ea8-aae6-ad69e887cef5"
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
      "id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T08:36:09+00:00",
        "updated_at": "2023-02-08T08:36:10+00:00",
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
        "starts_at": "2023-02-06T08:30:00+00:00",
        "stops_at": "2023-02-10T08:30:00+00:00",
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
        "start_location_id": "f0565e89-cc9c-47ca-80d3-bce125b6e3eb",
        "stop_location_id": "f0565e89-cc9c-47ca-80d3-bce125b6e3eb"
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
      "id": "cc1633f6-4a6f-4b66-b8a2-62cd2f87c962",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:10+00:00",
        "updated_at": "2023-02-08T08:36:10+00:00",
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
        "item_id": "56fa7abd-5195-4b96-800d-1a420c08bf7b",
        "tax_category_id": null,
        "planning_id": "0e05ba91-3f3e-4909-b5d3-423f256a1e92",
        "parent_line_id": "0cef8380-66d7-43f5-ba27-72a84b237496",
        "owner_id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1",
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
      "id": "0cef8380-66d7-43f5-ba27-72a84b237496",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:10+00:00",
        "updated_at": "2023-02-08T08:36:10+00:00",
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
        "item_id": "76048e12-b931-4cd5-b13d-0dce5df51eab",
        "tax_category_id": null,
        "planning_id": "66ce728e-a27b-4ea8-aae6-ad69e887cef5",
        "parent_line_id": null,
        "owner_id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1",
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
      "id": "66ce728e-a27b-4ea8-aae6-ad69e887cef5",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:10+00:00",
        "updated_at": "2023-02-08T08:36:10+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T08:30:00+00:00",
        "stops_at": "2023-02-10T08:30:00+00:00",
        "reserved_from": "2023-02-06T08:30:00+00:00",
        "reserved_till": "2023-02-10T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "76048e12-b931-4cd5-b13d-0dce5df51eab",
        "order_id": "7e991bf2-9e0d-4964-99a9-00be4a4f6df1",
        "start_location_id": "f0565e89-cc9c-47ca-80d3-bce125b6e3eb",
        "stop_location_id": "f0565e89-cc9c-47ca-80d3-bce125b6e3eb",
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





