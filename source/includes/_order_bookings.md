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
          "order_id": "6492ba4e-6515-472c-b519-fe0e2e565cfe",
          "items": [
            {
              "type": "products",
              "id": "b1cd18e2-e998-48a6-a065-3c991564de4e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "54d64c3b-5441-4c66-b771-bfa690ae2787",
              "stock_item_ids": [
                "6032d135-9523-477e-b43f-defa48ef0bde",
                "511d785d-3fe6-4d9f-8fdf-1d3280cc6719"
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
            "item_id": "b1cd18e2-e998-48a6-a065-3c991564de4e",
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
          "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
          "items": [
            {
              "type": "products",
              "id": "09d9361b-a8b1-4439-b478-90987a834bea",
              "stock_item_ids": [
                "2fe81b64-5130-455e-8466-8aca54238dda",
                "fab1106c-7f6d-4c45-beaf-ce7ac4c8fae0",
                "9b356c9e-66e7-4ab8-b931-e95de5a88e01"
              ]
            },
            {
              "type": "products",
              "id": "5c4db4fb-8a04-4fbe-bc5d-d43ab625b53d",
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
    "id": "beafce4f-87d9-53a6-b3bd-9923c135e964",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "61434222-687e-421e-8545-2e53f85fc5b8"
          },
          {
            "type": "lines",
            "id": "3fa4980a-eb62-4f4c-80ab-2312e57b6a2c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7e630302-79ef-4e8b-a50b-1379f78bf49e"
          },
          {
            "type": "plannings",
            "id": "b30a882d-ed6b-4ee2-95d3-1f9b32c53cfe"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "7d3943f7-ccd7-4252-a0bb-98e910082f03"
          },
          {
            "type": "stock_item_plannings",
            "id": "0552b067-e958-44d4-8fd8-aed71210819a"
          },
          {
            "type": "stock_item_plannings",
            "id": "c26cdd72-de37-48f7-9cff-74d6fffd4a84"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T17:44:06+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
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
        "customer_id": "f266d2d0-1c97-4b3a-96cc-536214a99dfb",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762",
        "stop_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762"
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
      "id": "61434222-687e-421e-8545-2e53f85fc5b8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
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
        "item_id": "09d9361b-a8b1-4439-b478-90987a834bea",
        "tax_category_id": "3570e4de-3e3b-4401-bcf7-820eb6a4e01d",
        "planning_id": "7e630302-79ef-4e8b-a50b-1379f78bf49e",
        "parent_line_id": null,
        "owner_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
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
      "id": "3fa4980a-eb62-4f4c-80ab-2312e57b6a2c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
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
        "item_id": "5c4db4fb-8a04-4fbe-bc5d-d43ab625b53d",
        "tax_category_id": "3570e4de-3e3b-4401-bcf7-820eb6a4e01d",
        "planning_id": "b30a882d-ed6b-4ee2-95d3-1f9b32c53cfe",
        "parent_line_id": null,
        "owner_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
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
      "id": "7e630302-79ef-4e8b-a50b-1379f78bf49e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
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
        "item_id": "09d9361b-a8b1-4439-b478-90987a834bea",
        "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
        "start_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762",
        "stop_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762",
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
      "id": "b30a882d-ed6b-4ee2-95d3-1f9b32c53cfe",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
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
        "item_id": "5c4db4fb-8a04-4fbe-bc5d-d43ab625b53d",
        "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a",
        "start_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762",
        "stop_location_id": "14266bc5-8b77-4b73-a27d-53007e95e762",
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
      "id": "7d3943f7-ccd7-4252-a0bb-98e910082f03",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2fe81b64-5130-455e-8466-8aca54238dda",
        "planning_id": "7e630302-79ef-4e8b-a50b-1379f78bf49e",
        "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a"
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
      "id": "0552b067-e958-44d4-8fd8-aed71210819a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fab1106c-7f6d-4c45-beaf-ce7ac4c8fae0",
        "planning_id": "7e630302-79ef-4e8b-a50b-1379f78bf49e",
        "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a"
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
      "id": "c26cdd72-de37-48f7-9cff-74d6fffd4a84",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:08+00:00",
        "updated_at": "2022-11-22T17:44:08+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9b356c9e-66e7-4ab8-b931-e95de5a88e01",
        "planning_id": "7e630302-79ef-4e8b-a50b-1379f78bf49e",
        "order_id": "f55dc2ef-a53a-4a90-b9b2-5ddf3d3c066a"
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
          "order_id": "01862964-71f3-4211-9301-b1b834d809c4",
          "items": [
            {
              "type": "bundles",
              "id": "25edd178-4149-405f-a987-236221f42697",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2c0bbfcc-2cf6-49ef-90ec-a2d3358b7368",
                  "id": "e499ec32-7072-48ed-ad2d-9826d2b57c22"
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
    "id": "009a2f26-81e7-51a6-8be5-bf948f638e54",
    "type": "order_bookings",
    "attributes": {
      "order_id": "01862964-71f3-4211-9301-b1b834d809c4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "01862964-71f3-4211-9301-b1b834d809c4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "51186d39-be06-4e4c-8ad3-2ab0cb5de93b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5e1078cd-8600-4870-9b14-d98a46764194"
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
      "id": "01862964-71f3-4211-9301-b1b834d809c4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T17:44:10+00:00",
        "updated_at": "2022-11-22T17:44:11+00:00",
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
        "starts_at": "2022-11-20T17:30:00+00:00",
        "stops_at": "2022-11-24T17:30:00+00:00",
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
        "start_location_id": "016fc20c-da88-46ac-9749-2b2e316e14f9",
        "stop_location_id": "016fc20c-da88-46ac-9749-2b2e316e14f9"
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
      "id": "51186d39-be06-4e4c-8ad3-2ab0cb5de93b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T17:44:11+00:00",
        "updated_at": "2022-11-22T17:44:11+00:00",
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
        "item_id": "25edd178-4149-405f-a987-236221f42697",
        "tax_category_id": null,
        "planning_id": "5e1078cd-8600-4870-9b14-d98a46764194",
        "parent_line_id": null,
        "owner_id": "01862964-71f3-4211-9301-b1b834d809c4",
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
      "id": "5e1078cd-8600-4870-9b14-d98a46764194",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T17:44:10+00:00",
        "updated_at": "2022-11-22T17:44:10+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T17:30:00+00:00",
        "stops_at": "2022-11-24T17:30:00+00:00",
        "reserved_from": "2022-11-20T17:30:00+00:00",
        "reserved_till": "2022-11-24T17:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "25edd178-4149-405f-a987-236221f42697",
        "order_id": "01862964-71f3-4211-9301-b1b834d809c4",
        "start_location_id": "016fc20c-da88-46ac-9749-2b2e316e14f9",
        "stop_location_id": "016fc20c-da88-46ac-9749-2b2e316e14f9",
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





