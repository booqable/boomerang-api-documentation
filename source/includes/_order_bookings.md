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
          "order_id": "7e5f87c8-af63-4b08-932c-ad0b94db190f",
          "items": [
            {
              "type": "products",
              "id": "9f380919-d408-417d-b864-4764dfd8efa4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fead9d71-6fef-4c90-a8f5-324795dc4333",
              "stock_item_ids": [
                "9228e93f-9a49-4ea0-82eb-1040d8c3f53f",
                "c73966bc-b3bb-446b-8988-30017af6bf00"
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
            "item_id": "9f380919-d408-417d-b864-4764dfd8efa4",
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
          "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99",
          "items": [
            {
              "type": "products",
              "id": "bfd0a037-757c-41c8-9e8c-785ee6fdd5fb",
              "stock_item_ids": [
                "a6a87d79-2afc-4a56-9de1-a0153c685b47",
                "47b9f6c9-b052-4f32-bd2d-f32ead416747",
                "199db125-bfe5-4e11-8ae1-10e94e7ee120"
              ]
            },
            {
              "type": "products",
              "id": "12503458-2a4e-4256-a7ab-68ec9229e658",
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
    "id": "cb70c973-e8e4-579b-a1ea-1ea107222e95",
    "type": "order_bookings",
    "attributes": {
      "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "935e8172-052b-4ef3-9347-57281cbb1d99"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "747b8b8f-7397-453c-863d-62450ea499e3"
          },
          {
            "type": "lines",
            "id": "4bd43a0d-e0ab-4a32-ba53-7c78f2572580"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5ea32e4c-76d4-4188-98fd-d360217dd31c"
          },
          {
            "type": "plannings",
            "id": "3a512879-1028-429a-891c-4118031fbc5a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "63c43ab9-3090-4672-a82e-27e3db6b8274"
          },
          {
            "type": "stock_item_plannings",
            "id": "126827cd-e870-4a86-b0be-b293b0f101f9"
          },
          {
            "type": "stock_item_plannings",
            "id": "9ed81ab4-da65-446a-a1b7-81b353325b88"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "935e8172-052b-4ef3-9347-57281cbb1d99",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T11:11:07+00:00",
        "updated_at": "2023-02-03T11:11:10+00:00",
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
        "customer_id": "ba18b8fb-89d5-451a-96ef-319c799db957",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130",
        "stop_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130"
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
      "id": "747b8b8f-7397-453c-863d-62450ea499e3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:10+00:00",
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
        "item_id": "bfd0a037-757c-41c8-9e8c-785ee6fdd5fb",
        "tax_category_id": "cfa6849f-5d9e-4cf0-9ab7-20ba93377aba",
        "planning_id": "5ea32e4c-76d4-4188-98fd-d360217dd31c",
        "parent_line_id": null,
        "owner_id": "935e8172-052b-4ef3-9347-57281cbb1d99",
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
      "id": "4bd43a0d-e0ab-4a32-ba53-7c78f2572580",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:10+00:00",
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
        "item_id": "12503458-2a4e-4256-a7ab-68ec9229e658",
        "tax_category_id": "cfa6849f-5d9e-4cf0-9ab7-20ba93377aba",
        "planning_id": "3a512879-1028-429a-891c-4118031fbc5a",
        "parent_line_id": null,
        "owner_id": "935e8172-052b-4ef3-9347-57281cbb1d99",
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
      "id": "5ea32e4c-76d4-4188-98fd-d360217dd31c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:10+00:00",
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
        "item_id": "bfd0a037-757c-41c8-9e8c-785ee6fdd5fb",
        "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99",
        "start_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130",
        "stop_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130",
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
      "id": "3a512879-1028-429a-891c-4118031fbc5a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:10+00:00",
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
        "item_id": "12503458-2a4e-4256-a7ab-68ec9229e658",
        "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99",
        "start_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130",
        "stop_location_id": "15656a7e-a71b-4e3d-976f-dbdd7fa6f130",
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
      "id": "63c43ab9-3090-4672-a82e-27e3db6b8274",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a6a87d79-2afc-4a56-9de1-a0153c685b47",
        "planning_id": "5ea32e4c-76d4-4188-98fd-d360217dd31c",
        "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99"
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
      "id": "126827cd-e870-4a86-b0be-b293b0f101f9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "47b9f6c9-b052-4f32-bd2d-f32ead416747",
        "planning_id": "5ea32e4c-76d4-4188-98fd-d360217dd31c",
        "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99"
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
      "id": "9ed81ab4-da65-446a-a1b7-81b353325b88",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:09+00:00",
        "updated_at": "2023-02-03T11:11:09+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "199db125-bfe5-4e11-8ae1-10e94e7ee120",
        "planning_id": "5ea32e4c-76d4-4188-98fd-d360217dd31c",
        "order_id": "935e8172-052b-4ef3-9347-57281cbb1d99"
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
          "order_id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e",
          "items": [
            {
              "type": "bundles",
              "id": "2f6574e4-cdfa-4741-9bd4-11fec2b98514",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "db0338e2-dc3b-4326-bfc8-9961a8450719",
                  "id": "03df8db8-c22e-4796-a819-81594aa3c117"
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
    "id": "010f8969-fd34-5c93-8d57-94114ab1b275",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5c94e178-63eb-4f75-9d8c-5a1c1c1e9a95"
          },
          {
            "type": "lines",
            "id": "734432cb-19a8-473e-9532-60f10b56902b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "370350f7-57c4-49da-88b6-cf314a23f184"
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
      "id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T11:11:14+00:00",
        "updated_at": "2023-02-03T11:11:15+00:00",
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
        "starts_at": "2023-02-01T11:00:00+00:00",
        "stops_at": "2023-02-05T11:00:00+00:00",
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
        "start_location_id": "ef42afda-77a5-45ba-8c9a-0a8526b91ccc",
        "stop_location_id": "ef42afda-77a5-45ba-8c9a-0a8526b91ccc"
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
      "id": "5c94e178-63eb-4f75-9d8c-5a1c1c1e9a95",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:14+00:00",
        "updated_at": "2023-02-03T11:11:14+00:00",
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
        "item_id": "2f6574e4-cdfa-4741-9bd4-11fec2b98514",
        "tax_category_id": null,
        "planning_id": "370350f7-57c4-49da-88b6-cf314a23f184",
        "parent_line_id": null,
        "owner_id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e",
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
      "id": "734432cb-19a8-473e-9532-60f10b56902b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:14+00:00",
        "updated_at": "2023-02-03T11:11:14+00:00",
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
        "item_id": "03df8db8-c22e-4796-a819-81594aa3c117",
        "tax_category_id": null,
        "planning_id": "f9f2f409-24c6-498c-a7a4-930182571c91",
        "parent_line_id": "5c94e178-63eb-4f75-9d8c-5a1c1c1e9a95",
        "owner_id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e",
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
      "id": "370350f7-57c4-49da-88b6-cf314a23f184",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:14+00:00",
        "updated_at": "2023-02-03T11:11:14+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T11:00:00+00:00",
        "stops_at": "2023-02-05T11:00:00+00:00",
        "reserved_from": "2023-02-01T11:00:00+00:00",
        "reserved_till": "2023-02-05T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2f6574e4-cdfa-4741-9bd4-11fec2b98514",
        "order_id": "b279725c-19e1-414e-9cb6-d4e6fff1c86e",
        "start_location_id": "ef42afda-77a5-45ba-8c9a-0a8526b91ccc",
        "stop_location_id": "ef42afda-77a5-45ba-8c9a-0a8526b91ccc",
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





