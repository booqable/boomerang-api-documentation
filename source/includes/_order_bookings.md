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
          "order_id": "0c6734b9-b183-4ac0-b5ac-3224bb98c6dd",
          "items": [
            {
              "type": "products",
              "id": "1f44cef2-3833-4b06-832a-25e8f687de5b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "439adfa6-1993-41d0-af9a-0000a3f3ddac",
              "stock_item_ids": [
                "194ff09b-9e8f-49fa-bb4e-07db4abfe055",
                "0bf28de4-3508-4e70-9544-99d6cf60df11"
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
            "item_id": "1f44cef2-3833-4b06-832a-25e8f687de5b",
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
          "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53",
          "items": [
            {
              "type": "products",
              "id": "7c346d72-0f46-420f-81cd-8305d15d7f1d",
              "stock_item_ids": [
                "93cc19e5-fc26-4e8d-bde1-7561801879b5",
                "c085a3cb-b770-4e4f-a0f1-098ec9ae7c34",
                "000370d1-a5ce-4084-be97-134bb5f2b86d"
              ]
            },
            {
              "type": "products",
              "id": "5b67caa5-dd2c-450c-a81e-349d16bcaed1",
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
    "id": "f0e2ae15-0467-5536-8fa6-a4c6485881e7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4fa07515-8c16-4648-b421-c54153fb0a53"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0ac528f3-2b01-41a1-8b7e-4002b6474cfb"
          },
          {
            "type": "lines",
            "id": "9f31ff62-3672-43f1-bd79-a5715cf33386"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "10fdab89-d143-4f50-a4cb-99ae73b6ed1e"
          },
          {
            "type": "plannings",
            "id": "f39cbc26-98e4-4778-a714-84dccb702ee8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c48ea58d-65ba-4414-8d0b-1e3daf27bed9"
          },
          {
            "type": "stock_item_plannings",
            "id": "9c7d8066-ac62-4ae3-8593-a40e1a4db12c"
          },
          {
            "type": "stock_item_plannings",
            "id": "eeb0e64b-ddd1-40c5-a05f-a8bccff2a08c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4fa07515-8c16-4648-b421-c54153fb0a53",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T13:04:52+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
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
        "customer_id": "32c4e956-7004-48dd-b7b2-ad19d72e9847",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632",
        "stop_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632"
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
      "id": "0ac528f3-2b01-41a1-8b7e-4002b6474cfb",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T13:04:53+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
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
        "item_id": "5b67caa5-dd2c-450c-a81e-349d16bcaed1",
        "tax_category_id": "34076f8e-4124-46fb-9beb-19a06849d4ba",
        "planning_id": "10fdab89-d143-4f50-a4cb-99ae73b6ed1e",
        "parent_line_id": null,
        "owner_id": "4fa07515-8c16-4648-b421-c54153fb0a53",
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
      "id": "9f31ff62-3672-43f1-bd79-a5715cf33386",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T13:04:54+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
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
        "item_id": "7c346d72-0f46-420f-81cd-8305d15d7f1d",
        "tax_category_id": "34076f8e-4124-46fb-9beb-19a06849d4ba",
        "planning_id": "f39cbc26-98e4-4778-a714-84dccb702ee8",
        "parent_line_id": null,
        "owner_id": "4fa07515-8c16-4648-b421-c54153fb0a53",
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
      "id": "10fdab89-d143-4f50-a4cb-99ae73b6ed1e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:53+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
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
        "item_id": "5b67caa5-dd2c-450c-a81e-349d16bcaed1",
        "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53",
        "start_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632",
        "stop_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632",
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
      "id": "f39cbc26-98e4-4778-a714-84dccb702ee8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:54+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
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
        "item_id": "7c346d72-0f46-420f-81cd-8305d15d7f1d",
        "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53",
        "start_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632",
        "stop_location_id": "4762cfa9-0fb9-401e-a19b-971f4f973632",
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
      "id": "c48ea58d-65ba-4414-8d0b-1e3daf27bed9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:54+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "93cc19e5-fc26-4e8d-bde1-7561801879b5",
        "planning_id": "f39cbc26-98e4-4778-a714-84dccb702ee8",
        "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53"
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
      "id": "9c7d8066-ac62-4ae3-8593-a40e1a4db12c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:54+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c085a3cb-b770-4e4f-a0f1-098ec9ae7c34",
        "planning_id": "f39cbc26-98e4-4778-a714-84dccb702ee8",
        "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53"
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
      "id": "eeb0e64b-ddd1-40c5-a05f-a8bccff2a08c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:54+00:00",
        "updated_at": "2022-07-14T13:04:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "000370d1-a5ce-4084-be97-134bb5f2b86d",
        "planning_id": "f39cbc26-98e4-4778-a714-84dccb702ee8",
        "order_id": "4fa07515-8c16-4648-b421-c54153fb0a53"
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
          "order_id": "ed5777a9-ba82-4d3d-8462-58438963ccd3",
          "items": [
            {
              "type": "bundles",
              "id": "31387fb4-0edd-4167-9fc3-ab8ee2f3821d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1dbea89b-1d72-47ab-bf51-b277a51f03b6",
                  "id": "b01402d1-4708-4c5d-92ab-355ebeeaf065"
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
    "id": "5402ade6-0b44-5d0a-815c-9105c0496eee",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ed5777a9-ba82-4d3d-8462-58438963ccd3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ed5777a9-ba82-4d3d-8462-58438963ccd3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a06b418c-544b-4a0d-bab7-b5843ebe9fdd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f5faa1d5-cc33-4c17-b07c-589cbf4c3d4f"
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
      "id": "ed5777a9-ba82-4d3d-8462-58438963ccd3",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-14T13:04:56+00:00",
        "updated_at": "2022-07-14T13:04:57+00:00",
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
        "starts_at": "2022-07-12T13:00:00+00:00",
        "stops_at": "2022-07-16T13:00:00+00:00",
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
        "start_location_id": "e10938c6-1100-4d91-a34c-12b63d422a1a",
        "stop_location_id": "e10938c6-1100-4d91-a34c-12b63d422a1a"
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
      "id": "a06b418c-544b-4a0d-bab7-b5843ebe9fdd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-14T13:04:57+00:00",
        "updated_at": "2022-07-14T13:04:57+00:00",
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
        "item_id": "31387fb4-0edd-4167-9fc3-ab8ee2f3821d",
        "tax_category_id": null,
        "planning_id": "f5faa1d5-cc33-4c17-b07c-589cbf4c3d4f",
        "parent_line_id": null,
        "owner_id": "ed5777a9-ba82-4d3d-8462-58438963ccd3",
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
      "id": "f5faa1d5-cc33-4c17-b07c-589cbf4c3d4f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-14T13:04:57+00:00",
        "updated_at": "2022-07-14T13:04:57+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-12T13:00:00+00:00",
        "stops_at": "2022-07-16T13:00:00+00:00",
        "reserved_from": "2022-07-12T13:00:00+00:00",
        "reserved_till": "2022-07-16T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "31387fb4-0edd-4167-9fc3-ab8ee2f3821d",
        "order_id": "ed5777a9-ba82-4d3d-8462-58438963ccd3",
        "start_location_id": "e10938c6-1100-4d91-a34c-12b63d422a1a",
        "stop_location_id": "e10938c6-1100-4d91-a34c-12b63d422a1a",
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





