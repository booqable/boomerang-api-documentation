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
          "order_id": "8fb7999d-c445-4897-b018-5779a023d3c7",
          "items": [
            {
              "type": "products",
              "id": "a19a35b0-3277-4b1c-8cb2-dee5b669dabc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ca0763a6-7dec-470d-81a9-2a13e704952d",
              "stock_item_ids": [
                "65b59a68-4124-4dd5-b95c-bc444b905377",
                "45a38721-b1d3-4c36-b80b-58c2532f23b4"
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
            "item_id": "a19a35b0-3277-4b1c-8cb2-dee5b669dabc",
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
          "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
          "items": [
            {
              "type": "products",
              "id": "193140c8-8334-4dd4-959e-f6bc5a91f66c",
              "stock_item_ids": [
                "ea20c3db-433c-43a7-8030-47fd1aad7663",
                "2cf99f7b-a730-4871-b90b-3a9397142c4b",
                "b56ed6ac-f1a9-49e9-9e0e-678fb462a7cf"
              ]
            },
            {
              "type": "products",
              "id": "cc2ae3f4-0287-4076-95dc-8b0c0591f55c",
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
    "id": "0c8ea062-5d0a-538c-a484-f89121705802",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "02519029-d8d3-4f75-b36a-4102ca547a0a"
          },
          {
            "type": "lines",
            "id": "bc39e844-3734-4d25-8bcd-93746843645b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c"
          },
          {
            "type": "plannings",
            "id": "bf06ef16-26e5-47f2-9f86-150645d7635c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "dab06343-4bb7-4a39-92d4-78ec777a021b"
          },
          {
            "type": "stock_item_plannings",
            "id": "7890d42f-10f1-4d57-9b04-c1de51e015b1"
          },
          {
            "type": "stock_item_plannings",
            "id": "61ef5433-f8a4-476e-95ce-be319b75e5d1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:15:11+00:00",
        "updated_at": "2023-02-13T12:15:13+00:00",
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
        "customer_id": "4fba62ae-eff0-4e98-b76b-8ad478227c25",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913",
        "stop_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913"
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
      "id": "02519029-d8d3-4f75-b36a-4102ca547a0a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
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
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "193140c8-8334-4dd4-959e-f6bc5a91f66c",
        "tax_category_id": "1a553ed0-e476-4c06-9b0d-25ce1fb3c1a6",
        "planning_id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c",
        "parent_line_id": null,
        "owner_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
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
      "id": "bc39e844-3734-4d25-8bcd-93746843645b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
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
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "cc2ae3f4-0287-4076-95dc-8b0c0591f55c",
        "tax_category_id": "1a553ed0-e476-4c06-9b0d-25ce1fb3c1a6",
        "planning_id": "bf06ef16-26e5-47f2-9f86-150645d7635c",
        "parent_line_id": null,
        "owner_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
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
      "id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
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
        "item_id": "193140c8-8334-4dd4-959e-f6bc5a91f66c",
        "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
        "start_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913",
        "stop_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913",
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
      "id": "bf06ef16-26e5-47f2-9f86-150645d7635c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
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
        "item_id": "cc2ae3f4-0287-4076-95dc-8b0c0591f55c",
        "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1",
        "start_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913",
        "stop_location_id": "9dcd073e-aa97-4cd4-9e63-1c452ef14913",
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
      "id": "dab06343-4bb7-4a39-92d4-78ec777a021b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ea20c3db-433c-43a7-8030-47fd1aad7663",
        "planning_id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c",
        "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1"
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
      "id": "7890d42f-10f1-4d57-9b04-c1de51e015b1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2cf99f7b-a730-4871-b90b-3a9397142c4b",
        "planning_id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c",
        "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1"
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
      "id": "61ef5433-f8a4-476e-95ce-be319b75e5d1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:12+00:00",
        "updated_at": "2023-02-13T12:15:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b56ed6ac-f1a9-49e9-9e0e-678fb462a7cf",
        "planning_id": "c19ea411-f9dc-47b8-b068-40b167ea8b6c",
        "order_id": "a94794cc-ebcc-4b6f-954a-0f204807c9e1"
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
          "order_id": "16b95878-3af1-4274-8999-d0b4c5934374",
          "items": [
            {
              "type": "bundles",
              "id": "d93a1a50-18e4-4c4d-bb8d-d9d388b0f7e1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "464e71ea-4d8d-40bd-878a-44e16351e0e3",
                  "id": "0be5a6e1-54ef-4e8b-a8a9-239a6175809b"
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
    "id": "45b05ae2-bbc5-5611-a130-9925bd60031a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "16b95878-3af1-4274-8999-d0b4c5934374"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "16b95878-3af1-4274-8999-d0b4c5934374"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a9fe4e1f-e77d-425d-ba2f-ae7295b9ed94"
          },
          {
            "type": "lines",
            "id": "9055d08f-de0b-4d62-9901-4cd8d0046225"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d006a487-8882-4e9f-8425-eeaa711334b7"
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
      "id": "16b95878-3af1-4274-8999-d0b4c5934374",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:15:15+00:00",
        "updated_at": "2023-02-13T12:15:15+00:00",
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
        "starts_at": "2023-02-11T12:15:00+00:00",
        "stops_at": "2023-02-15T12:15:00+00:00",
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
        "start_location_id": "02954c3f-8301-43c6-bd79-667d78389db3",
        "stop_location_id": "02954c3f-8301-43c6-bd79-667d78389db3"
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
      "id": "a9fe4e1f-e77d-425d-ba2f-ae7295b9ed94",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:15:15+00:00",
        "updated_at": "2023-02-13T12:15:15+00:00",
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
        "item_id": "0be5a6e1-54ef-4e8b-a8a9-239a6175809b",
        "tax_category_id": null,
        "planning_id": "82fbde11-4d1a-4beb-ba79-a4e330f6d3fc",
        "parent_line_id": "9055d08f-de0b-4d62-9901-4cd8d0046225",
        "owner_id": "16b95878-3af1-4274-8999-d0b4c5934374",
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
      "id": "9055d08f-de0b-4d62-9901-4cd8d0046225",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:15:15+00:00",
        "updated_at": "2023-02-13T12:15:15+00:00",
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
        "item_id": "d93a1a50-18e4-4c4d-bb8d-d9d388b0f7e1",
        "tax_category_id": null,
        "planning_id": "d006a487-8882-4e9f-8425-eeaa711334b7",
        "parent_line_id": null,
        "owner_id": "16b95878-3af1-4274-8999-d0b4c5934374",
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
      "id": "d006a487-8882-4e9f-8425-eeaa711334b7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:15:15+00:00",
        "updated_at": "2023-02-13T12:15:15+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-11T12:15:00+00:00",
        "stops_at": "2023-02-15T12:15:00+00:00",
        "reserved_from": "2023-02-11T12:15:00+00:00",
        "reserved_till": "2023-02-15T12:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d93a1a50-18e4-4c4d-bb8d-d9d388b0f7e1",
        "order_id": "16b95878-3af1-4274-8999-d0b4c5934374",
        "start_location_id": "02954c3f-8301-43c6-bd79-667d78389db3",
        "stop_location_id": "02954c3f-8301-43c6-bd79-667d78389db3",
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





