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
          "order_id": "13334f31-0448-4209-a73b-1e39903149d1",
          "items": [
            {
              "type": "products",
              "id": "fb1b3776-0d6b-4ef4-9e4a-b7b3f976622d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2f5e800e-ec8a-4cc5-9ad4-bccaf355ddfb",
              "stock_item_ids": [
                "fd3e1223-7aa5-4e41-bc3b-ee9eb032f60b",
                "1e74566d-1d9f-4700-902b-0e457d50e2cd"
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
            "item_id": "fb1b3776-0d6b-4ef4-9e4a-b7b3f976622d",
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
          "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
          "items": [
            {
              "type": "products",
              "id": "884d6eb2-b7d9-4381-a4ef-0e072f41b45f",
              "stock_item_ids": [
                "bb48b4d4-96d2-40fb-be36-36ca8d91b268",
                "fb1f27e8-0946-4b13-8c8a-e70c3060a7cf",
                "7e70f685-e760-461e-a118-3a571bf933f4"
              ]
            },
            {
              "type": "products",
              "id": "1cad7392-d563-41d9-aeaa-0aae4cdc3c72",
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
    "id": "18c3f12c-a03f-5902-a15c-8d21d021f054",
    "type": "order_bookings",
    "attributes": {
      "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "69d10e3f-6e4d-4687-bfb7-4ea7f81d2f78"
          },
          {
            "type": "lines",
            "id": "23e0192c-48a0-407a-86c6-eb0fc16b1a30"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "531083db-75aa-45a8-b002-df4f422835f6"
          },
          {
            "type": "plannings",
            "id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b27e481e-7b3a-4faa-9f92-bd9cf02ca0a2"
          },
          {
            "type": "stock_item_plannings",
            "id": "9ea3e251-765a-4c97-95dd-fea82cbdc87b"
          },
          {
            "type": "stock_item_plannings",
            "id": "6bb89785-8f33-4501-a2bd-8cc6d451ec2e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-09T12:39:10+00:00",
        "updated_at": "2022-06-09T12:39:13+00:00",
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
        "customer_id": "356a9a90-82ab-48c9-ae90-de8590633302",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f",
        "stop_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f"
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
      "id": "69d10e3f-6e4d-4687-bfb7-4ea7f81d2f78",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-09T12:39:11+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
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
        "item_id": "1cad7392-d563-41d9-aeaa-0aae4cdc3c72",
        "tax_category_id": "9dec32ac-ff55-48fb-b19f-1fb2e65c9a45",
        "planning_id": "531083db-75aa-45a8-b002-df4f422835f6",
        "parent_line_id": null,
        "owner_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
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
      "id": "23e0192c-48a0-407a-86c6-eb0fc16b1a30",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-09T12:39:12+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
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
        "item_id": "884d6eb2-b7d9-4381-a4ef-0e072f41b45f",
        "tax_category_id": "9dec32ac-ff55-48fb-b19f-1fb2e65c9a45",
        "planning_id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01",
        "parent_line_id": null,
        "owner_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
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
      "id": "531083db-75aa-45a8-b002-df4f422835f6",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:11+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
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
        "item_id": "1cad7392-d563-41d9-aeaa-0aae4cdc3c72",
        "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
        "start_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f",
        "stop_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f",
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
      "id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:12+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
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
        "item_id": "884d6eb2-b7d9-4381-a4ef-0e072f41b45f",
        "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0",
        "start_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f",
        "stop_location_id": "3bbf7eaf-02bb-44a2-b614-8847644e242f",
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
      "id": "b27e481e-7b3a-4faa-9f92-bd9cf02ca0a2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:12+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bb48b4d4-96d2-40fb-be36-36ca8d91b268",
        "planning_id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01",
        "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0"
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
      "id": "9ea3e251-765a-4c97-95dd-fea82cbdc87b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:12+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fb1f27e8-0946-4b13-8c8a-e70c3060a7cf",
        "planning_id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01",
        "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0"
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
      "id": "6bb89785-8f33-4501-a2bd-8cc6d451ec2e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:12+00:00",
        "updated_at": "2022-06-09T12:39:12+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7e70f685-e760-461e-a118-3a571bf933f4",
        "planning_id": "44b18eda-1bb9-425e-a0e7-4837a9f3ca01",
        "order_id": "226004dd-ba9f-4eea-9a8c-e923074ecfb0"
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
          "order_id": "06c7374d-826c-4363-9c0e-98fa47a824c6",
          "items": [
            {
              "type": "bundles",
              "id": "2cd1b65b-a7e0-48de-b265-456da428c1db",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c31586b2-f8e0-404d-a290-8ae95a0db5c8",
                  "id": "058a6bfa-dae9-46cd-9b66-eebf8d8c963b"
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
    "id": "18da08b5-d5ec-5363-b37a-9b96105b1d2b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "06c7374d-826c-4363-9c0e-98fa47a824c6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "06c7374d-826c-4363-9c0e-98fa47a824c6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a5333600-61e6-48ee-9e08-0985408db897"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c2a7dae5-c92b-45c3-a8ea-2e3128340ed9"
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
      "id": "06c7374d-826c-4363-9c0e-98fa47a824c6",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-09T12:39:15+00:00",
        "updated_at": "2022-06-09T12:39:16+00:00",
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
        "starts_at": "2022-06-07T12:30:00+00:00",
        "stops_at": "2022-06-11T12:30:00+00:00",
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
        "start_location_id": "f6220b3c-4225-43f6-8f1d-52dd4d1199f0",
        "stop_location_id": "f6220b3c-4225-43f6-8f1d-52dd4d1199f0"
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
      "id": "a5333600-61e6-48ee-9e08-0985408db897",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-09T12:39:16+00:00",
        "updated_at": "2022-06-09T12:39:16+00:00",
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
        "item_id": "2cd1b65b-a7e0-48de-b265-456da428c1db",
        "tax_category_id": null,
        "planning_id": "c2a7dae5-c92b-45c3-a8ea-2e3128340ed9",
        "parent_line_id": null,
        "owner_id": "06c7374d-826c-4363-9c0e-98fa47a824c6",
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
      "id": "c2a7dae5-c92b-45c3-a8ea-2e3128340ed9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-09T12:39:16+00:00",
        "updated_at": "2022-06-09T12:39:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-07T12:30:00+00:00",
        "stops_at": "2022-06-11T12:30:00+00:00",
        "reserved_from": "2022-06-07T12:30:00+00:00",
        "reserved_till": "2022-06-11T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2cd1b65b-a7e0-48de-b265-456da428c1db",
        "order_id": "06c7374d-826c-4363-9c0e-98fa47a824c6",
        "start_location_id": "f6220b3c-4225-43f6-8f1d-52dd4d1199f0",
        "stop_location_id": "f6220b3c-4225-43f6-8f1d-52dd4d1199f0",
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





