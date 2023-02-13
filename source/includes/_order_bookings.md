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
          "order_id": "c31ff502-4bc7-47cc-8305-de92219e52f9",
          "items": [
            {
              "type": "products",
              "id": "029afc0c-3a96-4d13-a743-2b00484e048c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1fc7a9e8-c8a5-43f8-abc5-8b048fd6aa81",
              "stock_item_ids": [
                "4590863e-16ad-4178-9e53-a36a49080349",
                "e9d5777f-6f60-4f01-86bb-9df724f9645d"
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
            "item_id": "029afc0c-3a96-4d13-a743-2b00484e048c",
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
          "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
          "items": [
            {
              "type": "products",
              "id": "05bf8d2d-d1ca-46af-a2cf-96b4a4a413c3",
              "stock_item_ids": [
                "ccb2d93c-b8d4-44a2-8e04-9edcbdd06468",
                "1e64b1ea-7f9c-4281-90e0-130c003f86d2",
                "c784a203-9640-497c-8f5f-2fc9ec71b36e"
              ]
            },
            {
              "type": "products",
              "id": "4ce8d922-d703-4167-b9b2-e7f0feaaa593",
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
    "id": "0b88ea0a-8a08-5b3a-96e4-ee6a43fc63cd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "325630d6-781f-4b1b-bdf4-8f5769794e23"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "534ed52f-027c-4011-b970-3fe3e42470e1"
          },
          {
            "type": "lines",
            "id": "5eb42c9d-bf08-43f9-9955-c560d3b4973b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e16e1b98-0a2c-4ca8-a870-88f336f98306"
          },
          {
            "type": "plannings",
            "id": "66a048f8-1f86-4445-8685-76efab4b8f59"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "469dbeb8-666d-4335-b331-f5a7c1dc3947"
          },
          {
            "type": "stock_item_plannings",
            "id": "a6084a14-2e90-4ca5-9dca-d16654603b95"
          },
          {
            "type": "stock_item_plannings",
            "id": "9062a89b-469d-4cb6-86f8-4974fcb84c17"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:47:25+00:00",
        "updated_at": "2023-02-13T12:47:27+00:00",
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
        "customer_id": "d6a31a8f-9106-43c6-9df7-b89a51b0f622",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8",
        "stop_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8"
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
      "id": "534ed52f-027c-4011-b970-3fe3e42470e1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:26+00:00",
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
        "item_id": "05bf8d2d-d1ca-46af-a2cf-96b4a4a413c3",
        "tax_category_id": "502960e9-8aab-434c-9a88-c664a56c4962",
        "planning_id": "e16e1b98-0a2c-4ca8-a870-88f336f98306",
        "parent_line_id": null,
        "owner_id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
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
      "id": "5eb42c9d-bf08-43f9-9955-c560d3b4973b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:26+00:00",
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
        "item_id": "4ce8d922-d703-4167-b9b2-e7f0feaaa593",
        "tax_category_id": "502960e9-8aab-434c-9a88-c664a56c4962",
        "planning_id": "66a048f8-1f86-4445-8685-76efab4b8f59",
        "parent_line_id": null,
        "owner_id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
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
      "id": "e16e1b98-0a2c-4ca8-a870-88f336f98306",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:27+00:00",
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
        "item_id": "05bf8d2d-d1ca-46af-a2cf-96b4a4a413c3",
        "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
        "start_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8",
        "stop_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8",
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
      "id": "66a048f8-1f86-4445-8685-76efab4b8f59",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:27+00:00",
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
        "item_id": "4ce8d922-d703-4167-b9b2-e7f0feaaa593",
        "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23",
        "start_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8",
        "stop_location_id": "ebc430dc-1352-47c1-899d-7feeed6a5fc8",
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
      "id": "469dbeb8-666d-4335-b331-f5a7c1dc3947",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ccb2d93c-b8d4-44a2-8e04-9edcbdd06468",
        "planning_id": "e16e1b98-0a2c-4ca8-a870-88f336f98306",
        "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23"
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
      "id": "a6084a14-2e90-4ca5-9dca-d16654603b95",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1e64b1ea-7f9c-4281-90e0-130c003f86d2",
        "planning_id": "e16e1b98-0a2c-4ca8-a870-88f336f98306",
        "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23"
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
      "id": "9062a89b-469d-4cb6-86f8-4974fcb84c17",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:26+00:00",
        "updated_at": "2023-02-13T12:47:26+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c784a203-9640-497c-8f5f-2fc9ec71b36e",
        "planning_id": "e16e1b98-0a2c-4ca8-a870-88f336f98306",
        "order_id": "325630d6-781f-4b1b-bdf4-8f5769794e23"
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
          "order_id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f",
          "items": [
            {
              "type": "bundles",
              "id": "21bf89f1-c0db-47dc-b0bf-57a214f3f656",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d066b3b5-537f-40a2-bea4-45fdfba98ef9",
                  "id": "da42efe5-dba7-4654-b43f-4525340690e6"
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
    "id": "55113209-57c3-53b0-858c-df936194f2ef",
    "type": "order_bookings",
    "attributes": {
      "order_id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0e92dc1a-ea83-4110-8a72-eb243ed99ab4"
          },
          {
            "type": "lines",
            "id": "76367683-f3e2-4d51-836d-22e660fabcbd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4ca14293-55ae-4c97-a8ee-ec87b33fc596"
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
      "id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:47:28+00:00",
        "updated_at": "2023-02-13T12:47:29+00:00",
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
        "starts_at": "2023-02-11T12:45:00+00:00",
        "stops_at": "2023-02-15T12:45:00+00:00",
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
        "start_location_id": "373294fe-25fb-4134-b10b-9911c86026de",
        "stop_location_id": "373294fe-25fb-4134-b10b-9911c86026de"
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
      "id": "0e92dc1a-ea83-4110-8a72-eb243ed99ab4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:47:29+00:00",
        "updated_at": "2023-02-13T12:47:29+00:00",
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
        "item_id": "da42efe5-dba7-4654-b43f-4525340690e6",
        "tax_category_id": null,
        "planning_id": "29f55dde-20e2-409c-90d9-4a3c2e43b6e7",
        "parent_line_id": "76367683-f3e2-4d51-836d-22e660fabcbd",
        "owner_id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f",
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
      "id": "76367683-f3e2-4d51-836d-22e660fabcbd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:47:29+00:00",
        "updated_at": "2023-02-13T12:47:29+00:00",
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
        "item_id": "21bf89f1-c0db-47dc-b0bf-57a214f3f656",
        "tax_category_id": null,
        "planning_id": "4ca14293-55ae-4c97-a8ee-ec87b33fc596",
        "parent_line_id": null,
        "owner_id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f",
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
      "id": "4ca14293-55ae-4c97-a8ee-ec87b33fc596",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:47:29+00:00",
        "updated_at": "2023-02-13T12:47:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-11T12:45:00+00:00",
        "stops_at": "2023-02-15T12:45:00+00:00",
        "reserved_from": "2023-02-11T12:45:00+00:00",
        "reserved_till": "2023-02-15T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "21bf89f1-c0db-47dc-b0bf-57a214f3f656",
        "order_id": "46fce87b-bca4-4b96-b3ec-0b462264fd7f",
        "start_location_id": "373294fe-25fb-4134-b10b-9911c86026de",
        "stop_location_id": "373294fe-25fb-4134-b10b-9911c86026de",
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





