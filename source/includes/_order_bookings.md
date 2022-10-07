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
          "order_id": "f1a02924-877e-4527-b194-77efbe75808b",
          "items": [
            {
              "type": "products",
              "id": "c400e408-b633-4ace-b60f-ea4861a90e27",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0224703c-13f9-4d4d-9407-115585dd596c",
              "stock_item_ids": [
                "6b495f65-64cd-4ebf-9b1f-ef873e46f88c",
                "03c4d300-662c-4aee-9576-8e583a536e4e"
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
            "item_id": "c400e408-b633-4ace-b60f-ea4861a90e27",
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
          "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
          "items": [
            {
              "type": "products",
              "id": "eb92f323-1c9b-4901-acb9-d6c9443a93ea",
              "stock_item_ids": [
                "04c3a81d-7b91-46dd-a4ad-3fb128e9ab45",
                "1652591b-3e02-4fd3-9b32-7266448d313d",
                "c826bb85-d352-4bcd-85eb-d0710304c3cb"
              ]
            },
            {
              "type": "products",
              "id": "ef111d9e-36bd-4088-b374-ede3abffc665",
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
    "id": "678d0358-0682-5da6-85a2-49ffe2e3e437",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "58dc5ef9-2fd6-4ea1-92e3-dea5659d1785"
          },
          {
            "type": "lines",
            "id": "842f72e7-2886-462d-8bd3-64c646ad0edd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3ac2345b-532d-46ae-82b3-cd917439c88a"
          },
          {
            "type": "plannings",
            "id": "1a808eb0-48e0-4edd-a41a-1b9e59999b24"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a4f7b2cc-8d51-400d-a1a1-08ba1ea83615"
          },
          {
            "type": "stock_item_plannings",
            "id": "fbc123b7-c769-4452-864a-58ac6bba3bc9"
          },
          {
            "type": "stock_item_plannings",
            "id": "4972491d-e6b2-44af-9f85-cab32170c358"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-07T12:09:18+00:00",
        "updated_at": "2022-10-07T12:09:20+00:00",
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
        "customer_id": "da1676fd-1412-4759-b45c-f8d64a8f1614",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6",
        "stop_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6"
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
      "id": "58dc5ef9-2fd6-4ea1-92e3-dea5659d1785",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
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
        "item_id": "eb92f323-1c9b-4901-acb9-d6c9443a93ea",
        "tax_category_id": "6ed4bed8-e13a-447b-a53f-9b8763d47120",
        "planning_id": "3ac2345b-532d-46ae-82b3-cd917439c88a",
        "parent_line_id": null,
        "owner_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
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
      "id": "842f72e7-2886-462d-8bd3-64c646ad0edd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
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
        "item_id": "ef111d9e-36bd-4088-b374-ede3abffc665",
        "tax_category_id": "6ed4bed8-e13a-447b-a53f-9b8763d47120",
        "planning_id": "1a808eb0-48e0-4edd-a41a-1b9e59999b24",
        "parent_line_id": null,
        "owner_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
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
      "id": "3ac2345b-532d-46ae-82b3-cd917439c88a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
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
        "item_id": "eb92f323-1c9b-4901-acb9-d6c9443a93ea",
        "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
        "start_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6",
        "stop_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6",
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
      "id": "1a808eb0-48e0-4edd-a41a-1b9e59999b24",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:20+00:00",
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
        "item_id": "ef111d9e-36bd-4088-b374-ede3abffc665",
        "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09",
        "start_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6",
        "stop_location_id": "387acdf4-8416-4fe2-9c3f-3552dd9488d6",
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
      "id": "a4f7b2cc-8d51-400d-a1a1-08ba1ea83615",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "04c3a81d-7b91-46dd-a4ad-3fb128e9ab45",
        "planning_id": "3ac2345b-532d-46ae-82b3-cd917439c88a",
        "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09"
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
      "id": "fbc123b7-c769-4452-864a-58ac6bba3bc9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1652591b-3e02-4fd3-9b32-7266448d313d",
        "planning_id": "3ac2345b-532d-46ae-82b3-cd917439c88a",
        "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09"
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
      "id": "4972491d-e6b2-44af-9f85-cab32170c358",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:19+00:00",
        "updated_at": "2022-10-07T12:09:19+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c826bb85-d352-4bcd-85eb-d0710304c3cb",
        "planning_id": "3ac2345b-532d-46ae-82b3-cd917439c88a",
        "order_id": "d997d3c1-707a-4f37-aa0c-4ac119d3fe09"
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
          "order_id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1",
          "items": [
            {
              "type": "bundles",
              "id": "f403a2dd-f5a2-4eae-9795-6fc3ce5241af",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "116d73fb-769a-4a91-8189-0dd8dbce9c53",
                  "id": "2db63135-6818-49f1-9d6e-893e902c8349"
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
    "id": "984acddc-41d1-57dd-9d87-d8f2c56f5208",
    "type": "order_bookings",
    "attributes": {
      "order_id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "52407f42-9536-40ca-b3b9-a59d1471dfa1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c6b350be-7882-4c85-8222-e025a4499c16"
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
      "id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-07T12:09:22+00:00",
        "updated_at": "2022-10-07T12:09:22+00:00",
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
        "starts_at": "2022-10-05T12:00:00+00:00",
        "stops_at": "2022-10-09T12:00:00+00:00",
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
        "start_location_id": "f8db97d5-5ee9-4926-9df9-63d9c300e29a",
        "stop_location_id": "f8db97d5-5ee9-4926-9df9-63d9c300e29a"
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
      "id": "52407f42-9536-40ca-b3b9-a59d1471dfa1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T12:09:22+00:00",
        "updated_at": "2022-10-07T12:09:22+00:00",
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
        "item_id": "f403a2dd-f5a2-4eae-9795-6fc3ce5241af",
        "tax_category_id": null,
        "planning_id": "c6b350be-7882-4c85-8222-e025a4499c16",
        "parent_line_id": null,
        "owner_id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1",
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
      "id": "c6b350be-7882-4c85-8222-e025a4499c16",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T12:09:22+00:00",
        "updated_at": "2022-10-07T12:09:22+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-05T12:00:00+00:00",
        "stops_at": "2022-10-09T12:00:00+00:00",
        "reserved_from": "2022-10-05T12:00:00+00:00",
        "reserved_till": "2022-10-09T12:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f403a2dd-f5a2-4eae-9795-6fc3ce5241af",
        "order_id": "01ce3679-bc22-4066-bbc4-0d95f8c9d5a1",
        "start_location_id": "f8db97d5-5ee9-4926-9df9-63d9c300e29a",
        "stop_location_id": "f8db97d5-5ee9-4926-9df9-63d9c300e29a",
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





