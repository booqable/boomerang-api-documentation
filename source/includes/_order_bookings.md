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
          "order_id": "33c07bcb-2d02-4019-ace4-02fcc559c4ee",
          "items": [
            {
              "type": "products",
              "id": "31fd4cb9-064b-4996-a249-077f3965155f",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "87c33b5a-74c7-4894-bd67-6111eab9c237",
              "stock_item_ids": [
                "3ca50360-ef13-4111-8b42-301e1813f7ac",
                "b124acfe-c107-4fbd-a5cd-026fc789efb3"
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
            "item_id": "31fd4cb9-064b-4996-a249-077f3965155f",
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
          "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36",
          "items": [
            {
              "type": "products",
              "id": "73da472f-e596-483f-91bb-cedee6944735",
              "stock_item_ids": [
                "88c87bd0-39dc-4bb4-a71b-2fe64e2d60c3",
                "7c946c77-9f9d-49ad-a6ed-fba98ee9e534",
                "9b977e1b-952b-4ea4-b2ff-0903f1736bea"
              ]
            },
            {
              "type": "products",
              "id": "4cf83aaa-8576-4678-81bc-99668301327f",
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
    "id": "6828ac28-f621-5ef3-bf9c-ce3c69bf98c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f24846ce-8cbb-4a44-952f-f557082dea36"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fa64bb86-ecb8-4a69-bcd1-33262bd89c0a"
          },
          {
            "type": "lines",
            "id": "48406ff5-bac6-47b9-bea9-6f353da5a643"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "949a72a6-081c-4b7b-9118-6238c05fc88b"
          },
          {
            "type": "plannings",
            "id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "120b5aa8-1b8b-4296-9958-a5e5a7a7ddfe"
          },
          {
            "type": "stock_item_plannings",
            "id": "b5baf7a9-0206-4358-acc3-78b61bfc0d25"
          },
          {
            "type": "stock_item_plannings",
            "id": "b5fb916d-1bd5-4532-82ca-744b9c2a0eb1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f24846ce-8cbb-4a44-952f-f557082dea36",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T06:35:13+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
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
        "customer_id": "5a2b6c1a-72c8-4eb6-aabe-3300ead04e93",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2",
        "stop_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2"
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
      "id": "fa64bb86-ecb8-4a69-bcd1-33262bd89c0a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T06:35:14+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
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
        "item_id": "4cf83aaa-8576-4678-81bc-99668301327f",
        "tax_category_id": "8aeb8b80-9d56-4ff0-85a1-a3b265e34f89",
        "planning_id": "949a72a6-081c-4b7b-9118-6238c05fc88b",
        "parent_line_id": null,
        "owner_id": "f24846ce-8cbb-4a44-952f-f557082dea36",
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
      "id": "48406ff5-bac6-47b9-bea9-6f353da5a643",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T06:35:15+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
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
        "item_id": "73da472f-e596-483f-91bb-cedee6944735",
        "tax_category_id": "8aeb8b80-9d56-4ff0-85a1-a3b265e34f89",
        "planning_id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505",
        "parent_line_id": null,
        "owner_id": "f24846ce-8cbb-4a44-952f-f557082dea36",
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
      "id": "949a72a6-081c-4b7b-9118-6238c05fc88b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:14+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
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
        "item_id": "4cf83aaa-8576-4678-81bc-99668301327f",
        "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36",
        "start_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2",
        "stop_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2",
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
      "id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:15+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
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
        "item_id": "73da472f-e596-483f-91bb-cedee6944735",
        "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36",
        "start_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2",
        "stop_location_id": "3bf9fcff-3a71-4a77-8575-0c792223dda2",
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
      "id": "120b5aa8-1b8b-4296-9958-a5e5a7a7ddfe",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:15+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "88c87bd0-39dc-4bb4-a71b-2fe64e2d60c3",
        "planning_id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505",
        "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36"
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
      "id": "b5baf7a9-0206-4358-acc3-78b61bfc0d25",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:15+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7c946c77-9f9d-49ad-a6ed-fba98ee9e534",
        "planning_id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505",
        "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36"
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
      "id": "b5fb916d-1bd5-4532-82ca-744b9c2a0eb1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:15+00:00",
        "updated_at": "2022-04-13T06:35:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9b977e1b-952b-4ea4-b2ff-0903f1736bea",
        "planning_id": "c902c0e5-58ec-4f8e-8236-bd6ec2416505",
        "order_id": "f24846ce-8cbb-4a44-952f-f557082dea36"
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
          "order_id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047",
          "items": [
            {
              "type": "bundles",
              "id": "eebe605c-e79a-4b12-a1c8-c9ff1a7d1b96",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1a9e24af-23cd-4667-97e3-f3d91245d6f3",
                  "id": "29d65c6a-fb9e-4e04-9eb4-8ead991326d4"
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
    "id": "eb9d6bd6-4e31-5876-814a-52a398d3b9c0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7880fc8c-6ce3-40a3-88af-5b1bfc613d7c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bc21d57f-71a7-4b87-b3c7-0c0ea743d86f"
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
      "id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047",
      "type": "orders",
      "attributes": {
        "created_at": "2022-04-13T06:35:17+00:00",
        "updated_at": "2022-04-13T06:35:18+00:00",
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
        "starts_at": "2022-04-11T06:30:00+00:00",
        "stops_at": "2022-04-15T06:30:00+00:00",
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
        "start_location_id": "a3c7182b-7ffa-461a-91b4-b89f76f4b6dc",
        "stop_location_id": "a3c7182b-7ffa-461a-91b4-b89f76f4b6dc"
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
      "id": "7880fc8c-6ce3-40a3-88af-5b1bfc613d7c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-04-13T06:35:18+00:00",
        "updated_at": "2022-04-13T06:35:18+00:00",
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
        "item_id": "eebe605c-e79a-4b12-a1c8-c9ff1a7d1b96",
        "tax_category_id": null,
        "planning_id": "bc21d57f-71a7-4b87-b3c7-0c0ea743d86f",
        "parent_line_id": null,
        "owner_id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047",
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
      "id": "bc21d57f-71a7-4b87-b3c7-0c0ea743d86f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-04-13T06:35:18+00:00",
        "updated_at": "2022-04-13T06:35:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-04-11T06:30:00+00:00",
        "stops_at": "2022-04-15T06:30:00+00:00",
        "reserved_from": "2022-04-11T06:30:00+00:00",
        "reserved_till": "2022-04-15T06:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "eebe605c-e79a-4b12-a1c8-c9ff1a7d1b96",
        "order_id": "cc0fbf79-6e7f-4e30-a128-408e38fc3047",
        "start_location_id": "a3c7182b-7ffa-461a-91b4-b89f76f4b6dc",
        "stop_location_id": "a3c7182b-7ffa-461a-91b4-b89f76f4b6dc",
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





