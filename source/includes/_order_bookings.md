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
          "order_id": "18dc7a07-753d-41cf-a0a7-dcb253fa66da",
          "items": [
            {
              "type": "products",
              "id": "2cbf42c7-bc46-414d-ae7f-ad3335a72cd9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4b425bb2-c9a2-4541-851e-113ff03645fe",
              "stock_item_ids": [
                "29c6915d-544c-43e8-8283-905e5b47a26d",
                "3eac728b-d349-49d1-8b15-b278a3e9da2c"
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
            "item_id": "2cbf42c7-bc46-414d-ae7f-ad3335a72cd9",
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
          "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539",
          "items": [
            {
              "type": "products",
              "id": "432069b5-060b-4a94-8c2d-377d1114f6e2",
              "stock_item_ids": [
                "30705237-bf2c-4be4-86da-4f0c3e08f9b7",
                "33ca0c8c-e1ef-4faa-9251-017420633619",
                "18123fff-e6b9-4820-945e-4e8cfd8f1d99"
              ]
            },
            {
              "type": "products",
              "id": "70f072b9-527c-4c42-a9c0-022f8e402d8c",
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
    "id": "f7c36314-3dd2-5480-9091-9603581ffce0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5cc3b4f8-4346-4689-b872-580816dc7539"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cdb9a87a-03d4-417a-8dc9-abf50e7051c1"
          },
          {
            "type": "lines",
            "id": "8489d1af-9d88-4092-8f4b-ee18caf52eec"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e6e6c9fc-71b9-40b4-b8fc-5e5e2abaad9f"
          },
          {
            "type": "plannings",
            "id": "bca5a52b-57db-4892-8b5d-e4408293a5c3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "662a8d2b-8f8c-4f69-8661-3fdfbe837b0a"
          },
          {
            "type": "stock_item_plannings",
            "id": "42fdfd8d-75ed-48a2-ba6a-c7f458d26565"
          },
          {
            "type": "stock_item_plannings",
            "id": "abeb8bdc-898d-4e8f-b8ef-b717a916aedb"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5cc3b4f8-4346-4689-b872-580816dc7539",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-04T13:22:38+00:00",
        "updated_at": "2022-04-04T13:22:40+00:00",
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
        "customer_id": "9c389dfa-1216-44db-8ded-e3ebd41dbaea",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94",
        "stop_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94"
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
      "id": "cdb9a87a-03d4-417a-8dc9-abf50e7051c1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-04T13:22:38+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
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
        "item_id": "70f072b9-527c-4c42-a9c0-022f8e402d8c",
        "tax_category_id": "f48d2204-098d-47b8-b748-97397fe400bb",
        "planning_id": "e6e6c9fc-71b9-40b4-b8fc-5e5e2abaad9f",
        "parent_line_id": null,
        "owner_id": "5cc3b4f8-4346-4689-b872-580816dc7539",
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
      "id": "8489d1af-9d88-4092-8f4b-ee18caf52eec",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-04T13:22:39+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
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
        "item_id": "432069b5-060b-4a94-8c2d-377d1114f6e2",
        "tax_category_id": "f48d2204-098d-47b8-b748-97397fe400bb",
        "planning_id": "bca5a52b-57db-4892-8b5d-e4408293a5c3",
        "parent_line_id": null,
        "owner_id": "5cc3b4f8-4346-4689-b872-580816dc7539",
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
      "id": "e6e6c9fc-71b9-40b4-b8fc-5e5e2abaad9f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:38+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
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
        "item_id": "70f072b9-527c-4c42-a9c0-022f8e402d8c",
        "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539",
        "start_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94",
        "stop_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94",
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
      "id": "bca5a52b-57db-4892-8b5d-e4408293a5c3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:39+00:00",
        "updated_at": "2022-04-04T13:22:40+00:00",
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
        "item_id": "432069b5-060b-4a94-8c2d-377d1114f6e2",
        "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539",
        "start_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94",
        "stop_location_id": "fcc8e385-792d-4dc4-b1a8-b46f4eecde94",
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
      "id": "662a8d2b-8f8c-4f69-8661-3fdfbe837b0a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:39+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "30705237-bf2c-4be4-86da-4f0c3e08f9b7",
        "planning_id": "bca5a52b-57db-4892-8b5d-e4408293a5c3",
        "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539"
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
      "id": "42fdfd8d-75ed-48a2-ba6a-c7f458d26565",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:39+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "33ca0c8c-e1ef-4faa-9251-017420633619",
        "planning_id": "bca5a52b-57db-4892-8b5d-e4408293a5c3",
        "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539"
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
      "id": "abeb8bdc-898d-4e8f-b8ef-b717a916aedb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:39+00:00",
        "updated_at": "2022-04-04T13:22:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "18123fff-e6b9-4820-945e-4e8cfd8f1d99",
        "planning_id": "bca5a52b-57db-4892-8b5d-e4408293a5c3",
        "order_id": "5cc3b4f8-4346-4689-b872-580816dc7539"
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
          "order_id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1",
          "items": [
            {
              "type": "bundles",
              "id": "8fa92420-7c53-4278-b865-b721c10a4247",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "106129d9-cbee-4639-a5be-3a63b94d6993",
                  "id": "5b845e5d-d54f-4867-a5b4-f5a99e0a0de4"
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
    "id": "364d3f6d-a6cb-5d2f-9e5f-3f691e6bda03",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "bf92a858-e744-4406-84e4-1e4f524780a0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9eea78b3-54a9-4036-813f-4902bfb40dd4"
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
      "id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-04T13:22:41+00:00",
        "updated_at": "2022-04-04T13:22:42+00:00",
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
        "starts_at": "2022-04-02T13:15:00+00:00",
        "stops_at": "2022-04-06T13:15:00+00:00",
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
        "start_location_id": "54fc8ed2-e9b7-417c-bd88-0074301fe174",
        "stop_location_id": "54fc8ed2-e9b7-417c-bd88-0074301fe174"
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
      "id": "bf92a858-e744-4406-84e4-1e4f524780a0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-04T13:22:42+00:00",
        "updated_at": "2022-04-04T13:22:42+00:00",
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
        "item_id": "8fa92420-7c53-4278-b865-b721c10a4247",
        "tax_category_id": null,
        "planning_id": "9eea78b3-54a9-4036-813f-4902bfb40dd4",
        "parent_line_id": null,
        "owner_id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1",
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
      "id": "9eea78b3-54a9-4036-813f-4902bfb40dd4",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-04T13:22:42+00:00",
        "updated_at": "2022-04-04T13:22:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-02T13:15:00+00:00",
        "stops_at": "2022-04-06T13:15:00+00:00",
        "reserved_from": "2022-04-02T13:15:00+00:00",
        "reserved_till": "2022-04-06T13:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8fa92420-7c53-4278-b865-b721c10a4247",
        "order_id": "f6712839-b8b9-4bb9-aed7-e78d7bf174f1",
        "start_location_id": "54fc8ed2-e9b7-417c-bd88-0074301fe174",
        "stop_location_id": "54fc8ed2-e9b7-417c-bd88-0074301fe174",
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





