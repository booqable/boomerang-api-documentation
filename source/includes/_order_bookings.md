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
          "order_id": "49d474ac-c9b9-406e-9d1e-4becc759e475",
          "items": [
            {
              "type": "products",
              "id": "8ac7eafa-0758-44dd-a236-0d3ffe06b91c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d51badbc-5d37-4df6-9e48-9a1db01c1e05",
              "stock_item_ids": [
                "c9317184-4e54-480f-89a9-bbc6a6ae5ad9",
                "f49fe826-cdb9-439f-8d37-8447cc1a2c5a"
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
            "item_id": "8ac7eafa-0758-44dd-a236-0d3ffe06b91c",
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
          "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
          "items": [
            {
              "type": "products",
              "id": "2396d40d-3b54-46f7-9c43-26481ca2fb63",
              "stock_item_ids": [
                "91013c87-8eb8-40a5-a187-0ff54d87bca0",
                "fdc8e50e-f93c-49a2-ba8f-bd8f6bdcdfcc",
                "340b534b-36f8-44bf-aff9-3dbe7a1fefb3"
              ]
            },
            {
              "type": "products",
              "id": "dc5472f3-c1d2-4b3e-b2b5-346746d6e96e",
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
    "id": "cf130c52-e074-574f-a0dd-d643f5db6943",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e14e4d8a-3f20-4521-a469-645e8d96b76b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d0df9580-c853-4918-be73-5f331f1c447c"
          },
          {
            "type": "lines",
            "id": "14b74a6f-75dc-46bb-8cf3-ff902dfb4bab"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1"
          },
          {
            "type": "plannings",
            "id": "f26cdf48-9108-4354-b0da-02a555b9348a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3d6c9a6e-69e7-4ad9-856b-ec96949c8711"
          },
          {
            "type": "stock_item_plannings",
            "id": "42d25e2a-dc31-4f72-b83b-8d50b9a2b846"
          },
          {
            "type": "stock_item_plannings",
            "id": "264ab044-ac65-4d9e-8a97-6a5076313414"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T11:08:03+00:00",
        "updated_at": "2023-02-09T11:08:05+00:00",
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
        "customer_id": "70dfeb79-bf6c-42ea-b475-76f15f0c8a23",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14",
        "stop_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14"
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
      "id": "d0df9580-c853-4918-be73-5f331f1c447c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:04+00:00",
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
        "item_id": "2396d40d-3b54-46f7-9c43-26481ca2fb63",
        "tax_category_id": "2d3868e8-dd08-4d54-adbe-93d2f24e84b7",
        "planning_id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1",
        "parent_line_id": null,
        "owner_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
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
      "id": "14b74a6f-75dc-46bb-8cf3-ff902dfb4bab",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:04+00:00",
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
        "item_id": "dc5472f3-c1d2-4b3e-b2b5-346746d6e96e",
        "tax_category_id": "2d3868e8-dd08-4d54-adbe-93d2f24e84b7",
        "planning_id": "f26cdf48-9108-4354-b0da-02a555b9348a",
        "parent_line_id": null,
        "owner_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
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
      "id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:05+00:00",
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
        "item_id": "2396d40d-3b54-46f7-9c43-26481ca2fb63",
        "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
        "start_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14",
        "stop_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14",
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
      "id": "f26cdf48-9108-4354-b0da-02a555b9348a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:05+00:00",
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
        "item_id": "dc5472f3-c1d2-4b3e-b2b5-346746d6e96e",
        "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b",
        "start_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14",
        "stop_location_id": "f73231b8-d789-4b5f-82af-c76dc0b86a14",
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
      "id": "3d6c9a6e-69e7-4ad9-856b-ec96949c8711",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "91013c87-8eb8-40a5-a187-0ff54d87bca0",
        "planning_id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1",
        "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b"
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
      "id": "42d25e2a-dc31-4f72-b83b-8d50b9a2b846",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fdc8e50e-f93c-49a2-ba8f-bd8f6bdcdfcc",
        "planning_id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1",
        "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b"
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
      "id": "264ab044-ac65-4d9e-8a97-6a5076313414",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:04+00:00",
        "updated_at": "2023-02-09T11:08:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "340b534b-36f8-44bf-aff9-3dbe7a1fefb3",
        "planning_id": "2d2e020d-4ef9-459e-ac77-5e151b88dba1",
        "order_id": "e14e4d8a-3f20-4521-a469-645e8d96b76b"
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
          "order_id": "1fdb76bf-dd02-4923-9cc2-926948468fc3",
          "items": [
            {
              "type": "bundles",
              "id": "b4dc211f-afa1-48e0-9924-6e5e5e65b20f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "05c52a2e-ee4e-49a6-b2c8-a70dc0071b4f",
                  "id": "2dda7a0c-e460-4bdd-9460-75db6e61f4f7"
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
    "id": "d2ba94fc-257e-5e9e-861a-65571924ecf0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1fdb76bf-dd02-4923-9cc2-926948468fc3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1fdb76bf-dd02-4923-9cc2-926948468fc3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8201392b-75fa-4a6f-a141-49befb953257"
          },
          {
            "type": "lines",
            "id": "a03da81e-1e53-4a42-90fc-69ec566e31f2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "80723d64-af18-4565-a54b-337bfe40a381"
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
      "id": "1fdb76bf-dd02-4923-9cc2-926948468fc3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-09T11:08:07+00:00",
        "updated_at": "2023-02-09T11:08:08+00:00",
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
        "starts_at": "2023-02-07T11:00:00+00:00",
        "stops_at": "2023-02-11T11:00:00+00:00",
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
        "start_location_id": "95a1d848-c72e-439f-9b6e-0e7ffbf8fab9",
        "stop_location_id": "95a1d848-c72e-439f-9b6e-0e7ffbf8fab9"
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
      "id": "8201392b-75fa-4a6f-a141-49befb953257",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:08:07+00:00",
        "updated_at": "2023-02-09T11:08:07+00:00",
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
        "item_id": "b4dc211f-afa1-48e0-9924-6e5e5e65b20f",
        "tax_category_id": null,
        "planning_id": "80723d64-af18-4565-a54b-337bfe40a381",
        "parent_line_id": null,
        "owner_id": "1fdb76bf-dd02-4923-9cc2-926948468fc3",
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
      "id": "a03da81e-1e53-4a42-90fc-69ec566e31f2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-09T11:08:07+00:00",
        "updated_at": "2023-02-09T11:08:07+00:00",
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
        "item_id": "2dda7a0c-e460-4bdd-9460-75db6e61f4f7",
        "tax_category_id": null,
        "planning_id": "991a21a5-f48b-4f77-8b4b-992ae1f4084e",
        "parent_line_id": "8201392b-75fa-4a6f-a141-49befb953257",
        "owner_id": "1fdb76bf-dd02-4923-9cc2-926948468fc3",
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
      "id": "80723d64-af18-4565-a54b-337bfe40a381",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-09T11:08:07+00:00",
        "updated_at": "2023-02-09T11:08:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-07T11:00:00+00:00",
        "stops_at": "2023-02-11T11:00:00+00:00",
        "reserved_from": "2023-02-07T11:00:00+00:00",
        "reserved_till": "2023-02-11T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b4dc211f-afa1-48e0-9924-6e5e5e65b20f",
        "order_id": "1fdb76bf-dd02-4923-9cc2-926948468fc3",
        "start_location_id": "95a1d848-c72e-439f-9b6e-0e7ffbf8fab9",
        "stop_location_id": "95a1d848-c72e-439f-9b6e-0e7ffbf8fab9",
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





