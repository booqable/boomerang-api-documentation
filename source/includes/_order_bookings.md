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
          "order_id": "d5168ed4-175e-4401-a300-51ff1ca73140",
          "items": [
            {
              "type": "products",
              "id": "23a1b808-fb46-4372-97a9-f8b565cdb855",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f4eefffb-957b-4fe0-a7f9-17946e87a170",
              "stock_item_ids": [
                "3e8e47c8-c1c5-4e5f-9331-b96e412c9cde",
                "bd19c8c7-9e81-4788-85f7-27a0c21861a6"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 3e8e47c8-c1c5-4e5f-9331-b96e412c9cde has already been booked on this order"
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
          "order_id": "7e651340-88dc-4848-9155-e606c063697f",
          "items": [
            {
              "type": "products",
              "id": "e2e2ee67-43ce-47f9-b6a4-ff479d24ea2f",
              "stock_item_ids": [
                "720c6590-eaf0-44af-b403-b7ef3932cdbe",
                "386bb44d-b4ed-4307-b89e-992a322657c2",
                "e0e1c723-798f-4fc6-a940-b040c5a77cec"
              ]
            },
            {
              "type": "products",
              "id": "014ab468-ccb1-4d50-a7c4-19f82823e309",
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
    "id": "1c934810-590f-5615-8b5b-ae2b109de510",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7e651340-88dc-4848-9155-e606c063697f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7e651340-88dc-4848-9155-e606c063697f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8d8d2fca-52bd-44a0-b08b-34bb0ff951e7"
          },
          {
            "type": "lines",
            "id": "e682f55b-ee01-4a6b-ba1f-d165d55e82c8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f87185c1-c859-431d-a41f-70d6b5ae74a2"
          },
          {
            "type": "plannings",
            "id": "06d5605d-2c2d-4740-997b-77ddb2737780"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "269a288b-e33a-43db-baa4-a42147762343"
          },
          {
            "type": "stock_item_plannings",
            "id": "1a935ea2-a703-4541-a866-d99fa6fc85fa"
          },
          {
            "type": "stock_item_plannings",
            "id": "c506e013-7501-441e-ab25-af2c815d8503"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7e651340-88dc-4848-9155-e606c063697f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T11:36:31+00:00",
        "updated_at": "2023-03-07T11:36:33+00:00",
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
        "customer_id": "43109c14-b068-4492-9159-92ad09a39f6d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582",
        "stop_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582"
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
      "id": "8d8d2fca-52bd-44a0-b08b-34bb0ff951e7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:33+00:00",
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
        "item_id": "e2e2ee67-43ce-47f9-b6a4-ff479d24ea2f",
        "tax_category_id": "8901cda9-28c7-4408-8595-315f615166d2",
        "planning_id": "f87185c1-c859-431d-a41f-70d6b5ae74a2",
        "parent_line_id": null,
        "owner_id": "7e651340-88dc-4848-9155-e606c063697f",
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
      "id": "e682f55b-ee01-4a6b-ba1f-d165d55e82c8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:33+00:00",
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
        "item_id": "014ab468-ccb1-4d50-a7c4-19f82823e309",
        "tax_category_id": "8901cda9-28c7-4408-8595-315f615166d2",
        "planning_id": "06d5605d-2c2d-4740-997b-77ddb2737780",
        "parent_line_id": null,
        "owner_id": "7e651340-88dc-4848-9155-e606c063697f",
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
      "id": "f87185c1-c859-431d-a41f-70d6b5ae74a2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:32+00:00",
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
        "item_id": "e2e2ee67-43ce-47f9-b6a4-ff479d24ea2f",
        "order_id": "7e651340-88dc-4848-9155-e606c063697f",
        "start_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582",
        "stop_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582",
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
      "id": "06d5605d-2c2d-4740-997b-77ddb2737780",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:32+00:00",
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
        "item_id": "014ab468-ccb1-4d50-a7c4-19f82823e309",
        "order_id": "7e651340-88dc-4848-9155-e606c063697f",
        "start_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582",
        "stop_location_id": "aa6cb3c5-83d0-4f55-90fc-3e29cd635582",
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
      "id": "269a288b-e33a-43db-baa4-a42147762343",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "720c6590-eaf0-44af-b403-b7ef3932cdbe",
        "planning_id": "f87185c1-c859-431d-a41f-70d6b5ae74a2",
        "order_id": "7e651340-88dc-4848-9155-e606c063697f"
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
      "id": "1a935ea2-a703-4541-a866-d99fa6fc85fa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "386bb44d-b4ed-4307-b89e-992a322657c2",
        "planning_id": "f87185c1-c859-431d-a41f-70d6b5ae74a2",
        "order_id": "7e651340-88dc-4848-9155-e606c063697f"
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
      "id": "c506e013-7501-441e-ab25-af2c815d8503",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:32+00:00",
        "updated_at": "2023-03-07T11:36:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e0e1c723-798f-4fc6-a940-b040c5a77cec",
        "planning_id": "f87185c1-c859-431d-a41f-70d6b5ae74a2",
        "order_id": "7e651340-88dc-4848-9155-e606c063697f"
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
          "order_id": "e2c8aa2c-abd4-4770-8779-cce487c982a0",
          "items": [
            {
              "type": "bundles",
              "id": "c8f9456d-628a-4583-ab15-c3950eb62035",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "b455213d-dea4-487e-9aba-5d6a4f99a894",
                  "id": "2424a3d3-72f4-41ff-9675-c8f0438e9538"
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
    "id": "cddf0a8b-32a7-52f6-b8ea-47bcb682a4a0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e2c8aa2c-abd4-4770-8779-cce487c982a0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e2c8aa2c-abd4-4770-8779-cce487c982a0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f5095768-ad5a-414f-8ca5-e2567f6f2d00"
          },
          {
            "type": "lines",
            "id": "5d204bfb-2f79-4bd9-b8e5-459d92dfff2f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "96d72dea-8027-4d0b-a8e3-aa1be25f0ae8"
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
      "id": "e2c8aa2c-abd4-4770-8779-cce487c982a0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T11:36:35+00:00",
        "updated_at": "2023-03-07T11:36:35+00:00",
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
        "starts_at": "2023-03-05T11:30:00+00:00",
        "stops_at": "2023-03-09T11:30:00+00:00",
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
        "start_location_id": "cfc1bf5c-5eab-4052-9675-ad1724e47bca",
        "stop_location_id": "cfc1bf5c-5eab-4052-9675-ad1724e47bca"
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
      "id": "f5095768-ad5a-414f-8ca5-e2567f6f2d00",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T11:36:35+00:00",
        "updated_at": "2023-03-07T11:36:35+00:00",
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
        "item_id": "2424a3d3-72f4-41ff-9675-c8f0438e9538",
        "tax_category_id": null,
        "planning_id": "2a1289ff-149e-408a-be53-71847a0e6d7b",
        "parent_line_id": "5d204bfb-2f79-4bd9-b8e5-459d92dfff2f",
        "owner_id": "e2c8aa2c-abd4-4770-8779-cce487c982a0",
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
      "id": "5d204bfb-2f79-4bd9-b8e5-459d92dfff2f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T11:36:35+00:00",
        "updated_at": "2023-03-07T11:36:35+00:00",
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
        "item_id": "c8f9456d-628a-4583-ab15-c3950eb62035",
        "tax_category_id": null,
        "planning_id": "96d72dea-8027-4d0b-a8e3-aa1be25f0ae8",
        "parent_line_id": null,
        "owner_id": "e2c8aa2c-abd4-4770-8779-cce487c982a0",
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
      "id": "96d72dea-8027-4d0b-a8e3-aa1be25f0ae8",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T11:36:35+00:00",
        "updated_at": "2023-03-07T11:36:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-05T11:30:00+00:00",
        "stops_at": "2023-03-09T11:30:00+00:00",
        "reserved_from": "2023-03-05T11:30:00+00:00",
        "reserved_till": "2023-03-09T11:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c8f9456d-628a-4583-ab15-c3950eb62035",
        "order_id": "e2c8aa2c-abd4-4770-8779-cce487c982a0",
        "start_location_id": "cfc1bf5c-5eab-4052-9675-ad1724e47bca",
        "stop_location_id": "cfc1bf5c-5eab-4052-9675-ad1724e47bca",
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





