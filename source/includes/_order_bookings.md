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
          "order_id": "e1004488-1a21-4be4-8820-c82ccc97efb5",
          "items": [
            {
              "type": "products",
              "id": "bf1a1b87-4c50-4d97-a310-d0492984747f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "446ee8de-4a5c-4cb4-9ae2-a46449a8103d",
              "stock_item_ids": [
                "9c905585-54ad-40b7-aada-6ee329129dcc",
                "2294bd9c-a713-4a74-b8fa-84b989e49112"
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
            "item_id": "bf1a1b87-4c50-4d97-a310-d0492984747f",
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
          "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
          "items": [
            {
              "type": "products",
              "id": "33325606-b09b-4943-85c0-fd4e520a8d18",
              "stock_item_ids": [
                "ae0b25d2-55e0-4391-864e-0b0949a35e9f",
                "f742f0d8-53f3-4059-a805-fb1cb6e6a9ad",
                "62a81c57-828e-4c50-813b-6661680d1b4f"
              ]
            },
            {
              "type": "products",
              "id": "fb6107ef-6347-4a7f-8f12-b19c0011c315",
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
    "id": "34b1f370-ea74-5a36-85fe-5a055a215cd1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6a3dbbe6-f464-486c-8abe-b7278b11f985"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d3f64197-7324-44e4-afc2-5605b5097254"
          },
          {
            "type": "lines",
            "id": "96cff544-fd43-45a9-82d3-913c38c85d17"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "330232f3-719c-4e04-b384-d7ab8878854b"
          },
          {
            "type": "plannings",
            "id": "d23199ff-6928-4273-9406-05b5bcf7725c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9230d30c-e635-4951-bdba-bed0ec789b88"
          },
          {
            "type": "stock_item_plannings",
            "id": "e4648a1c-deab-495e-8e3a-993fc87d6d6e"
          },
          {
            "type": "stock_item_plannings",
            "id": "10d39f82-1e7b-49cb-a223-cd13eb702c92"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-04T15:39:12+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
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
        "customer_id": "9e6ce09a-a196-4c4a-a6ab-32b3dd0ec994",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2",
        "stop_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2"
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
      "id": "d3f64197-7324-44e4-afc2-5605b5097254",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:39:14+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
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
        "item_id": "33325606-b09b-4943-85c0-fd4e520a8d18",
        "tax_category_id": "86db4321-01a7-4266-a5b0-1bfe4383b0d4",
        "planning_id": "330232f3-719c-4e04-b384-d7ab8878854b",
        "parent_line_id": null,
        "owner_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
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
      "id": "96cff544-fd43-45a9-82d3-913c38c85d17",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:39:14+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
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
        "item_id": "fb6107ef-6347-4a7f-8f12-b19c0011c315",
        "tax_category_id": "86db4321-01a7-4266-a5b0-1bfe4383b0d4",
        "planning_id": "d23199ff-6928-4273-9406-05b5bcf7725c",
        "parent_line_id": null,
        "owner_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
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
      "id": "330232f3-719c-4e04-b384-d7ab8878854b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:13+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
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
        "item_id": "33325606-b09b-4943-85c0-fd4e520a8d18",
        "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
        "start_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2",
        "stop_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2",
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
      "id": "d23199ff-6928-4273-9406-05b5bcf7725c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:13+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
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
        "item_id": "fb6107ef-6347-4a7f-8f12-b19c0011c315",
        "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985",
        "start_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2",
        "stop_location_id": "fbc6e3a6-5077-453c-8e09-16b5729150d2",
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
      "id": "9230d30c-e635-4951-bdba-bed0ec789b88",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:13+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ae0b25d2-55e0-4391-864e-0b0949a35e9f",
        "planning_id": "330232f3-719c-4e04-b384-d7ab8878854b",
        "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985"
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
      "id": "e4648a1c-deab-495e-8e3a-993fc87d6d6e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:13+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f742f0d8-53f3-4059-a805-fb1cb6e6a9ad",
        "planning_id": "330232f3-719c-4e04-b384-d7ab8878854b",
        "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985"
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
      "id": "10d39f82-1e7b-49cb-a223-cd13eb702c92",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:13+00:00",
        "updated_at": "2022-11-04T15:39:14+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "62a81c57-828e-4c50-813b-6661680d1b4f",
        "planning_id": "330232f3-719c-4e04-b384-d7ab8878854b",
        "order_id": "6a3dbbe6-f464-486c-8abe-b7278b11f985"
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
          "order_id": "b6b49063-06a9-4662-b18c-921f8afc1ef5",
          "items": [
            {
              "type": "bundles",
              "id": "8ad0a72e-cbf8-4675-88e7-fa02d9a68bd5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d8c4170b-4048-4baa-abc7-914cb2606759",
                  "id": "0b2a4f68-c47d-4fa7-a7ff-7485d2df9ab9"
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
    "id": "89a1ae98-f736-5b82-950e-5f51cee64652",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b6b49063-06a9-4662-b18c-921f8afc1ef5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b6b49063-06a9-4662-b18c-921f8afc1ef5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "19d4ad83-3c24-4a60-b749-d1171d385596"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5c3221a0-e6bd-4f25-9934-ce734f349eae"
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
      "id": "b6b49063-06a9-4662-b18c-921f8afc1ef5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-04T15:39:16+00:00",
        "updated_at": "2022-11-04T15:39:17+00:00",
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
        "starts_at": "2022-11-02T15:30:00+00:00",
        "stops_at": "2022-11-06T15:30:00+00:00",
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
        "start_location_id": "bd4f2fc0-2bd5-4ae3-aebe-06dcd1a196c2",
        "stop_location_id": "bd4f2fc0-2bd5-4ae3-aebe-06dcd1a196c2"
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
      "id": "19d4ad83-3c24-4a60-b749-d1171d385596",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-04T15:39:16+00:00",
        "updated_at": "2022-11-04T15:39:16+00:00",
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
        "item_id": "8ad0a72e-cbf8-4675-88e7-fa02d9a68bd5",
        "tax_category_id": null,
        "planning_id": "5c3221a0-e6bd-4f25-9934-ce734f349eae",
        "parent_line_id": null,
        "owner_id": "b6b49063-06a9-4662-b18c-921f8afc1ef5",
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
      "id": "5c3221a0-e6bd-4f25-9934-ce734f349eae",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-04T15:39:16+00:00",
        "updated_at": "2022-11-04T15:39:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-02T15:30:00+00:00",
        "stops_at": "2022-11-06T15:30:00+00:00",
        "reserved_from": "2022-11-02T15:30:00+00:00",
        "reserved_till": "2022-11-06T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8ad0a72e-cbf8-4675-88e7-fa02d9a68bd5",
        "order_id": "b6b49063-06a9-4662-b18c-921f8afc1ef5",
        "start_location_id": "bd4f2fc0-2bd5-4ae3-aebe-06dcd1a196c2",
        "stop_location_id": "bd4f2fc0-2bd5-4ae3-aebe-06dcd1a196c2",
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





