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
          "order_id": "5e4dd669-5a50-4586-b4ff-7249677a5460",
          "items": [
            {
              "type": "products",
              "id": "ed604b92-abdb-40cc-9e99-96e700aeb798",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9d8479b8-dbf3-4dd5-9a70-f01576b298e4",
              "stock_item_ids": [
                "33f401df-590b-4d56-9286-f16d25fd00e0",
                "e56a4fa1-b34b-4899-8769-e11f03e9ce44"
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
          "stock_item_id 33f401df-590b-4d56-9286-f16d25fd00e0 has already been booked on this order"
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
          "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766",
          "items": [
            {
              "type": "products",
              "id": "d6c53c08-f846-45ef-9b87-f28ee550b690",
              "stock_item_ids": [
                "5e85bd26-46af-4690-be57-8d83e8c23128",
                "7ee6146b-8bbc-47d6-83e6-e1cc71d05588",
                "dd71a7e0-23cf-4f9d-8f3e-e38866f4e0d7"
              ]
            },
            {
              "type": "products",
              "id": "daf7a04c-51b4-4ab3-ad68-d0a0e6702675",
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
    "id": "7493cfad-d8ec-52a6-9e83-c16470d94237",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c13ae534-e654-4ad5-95aa-391edac0f766"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5f764f43-5096-4c7e-8508-78646bb768d8"
          },
          {
            "type": "lines",
            "id": "b76fc829-533e-456b-9b72-1331e2af2047"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cddde237-722e-4e43-b645-fdec5f71d688"
          },
          {
            "type": "plannings",
            "id": "60502fa1-220b-44ec-bc43-2e08721b0bef"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1c1f0a4b-3a5a-4dee-a939-e71d3db073dd"
          },
          {
            "type": "stock_item_plannings",
            "id": "80599dd6-6dcb-41d8-8f1e-3a275105d1fb"
          },
          {
            "type": "stock_item_plannings",
            "id": "a1c4b2ba-c743-4d68-bf8a-11131a9c2fd3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c13ae534-e654-4ad5-95aa-391edac0f766",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T09:35:11+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
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
        "customer_id": "a6b8ebff-dc10-4cb8-8115-a58088124698",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45",
        "stop_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45"
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
      "id": "5f764f43-5096-4c7e-8508-78646bb768d8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
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
        "item_id": "d6c53c08-f846-45ef-9b87-f28ee550b690",
        "tax_category_id": "cc01bc6e-d140-4e6d-886a-0a8a60e4aef2",
        "planning_id": "cddde237-722e-4e43-b645-fdec5f71d688",
        "parent_line_id": null,
        "owner_id": "c13ae534-e654-4ad5-95aa-391edac0f766",
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
      "id": "b76fc829-533e-456b-9b72-1331e2af2047",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
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
        "item_id": "daf7a04c-51b4-4ab3-ad68-d0a0e6702675",
        "tax_category_id": "cc01bc6e-d140-4e6d-886a-0a8a60e4aef2",
        "planning_id": "60502fa1-220b-44ec-bc43-2e08721b0bef",
        "parent_line_id": null,
        "owner_id": "c13ae534-e654-4ad5-95aa-391edac0f766",
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
      "id": "cddde237-722e-4e43-b645-fdec5f71d688",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
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
        "item_id": "d6c53c08-f846-45ef-9b87-f28ee550b690",
        "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766",
        "start_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45",
        "stop_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45",
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
      "id": "60502fa1-220b-44ec-bc43-2e08721b0bef",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
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
        "item_id": "daf7a04c-51b4-4ab3-ad68-d0a0e6702675",
        "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766",
        "start_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45",
        "stop_location_id": "372cd34c-e1af-406b-b39c-2b865f402c45",
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
      "id": "1c1f0a4b-3a5a-4dee-a939-e71d3db073dd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5e85bd26-46af-4690-be57-8d83e8c23128",
        "planning_id": "cddde237-722e-4e43-b645-fdec5f71d688",
        "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766"
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
      "id": "80599dd6-6dcb-41d8-8f1e-3a275105d1fb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7ee6146b-8bbc-47d6-83e6-e1cc71d05588",
        "planning_id": "cddde237-722e-4e43-b645-fdec5f71d688",
        "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766"
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
      "id": "a1c4b2ba-c743-4d68-bf8a-11131a9c2fd3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:12+00:00",
        "updated_at": "2023-03-09T09:35:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dd71a7e0-23cf-4f9d-8f3e-e38866f4e0d7",
        "planning_id": "cddde237-722e-4e43-b645-fdec5f71d688",
        "order_id": "c13ae534-e654-4ad5-95aa-391edac0f766"
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
          "order_id": "b710e6f9-ca4e-4c42-9446-d607577b623d",
          "items": [
            {
              "type": "bundles",
              "id": "f5e5a6c6-7768-4720-b90f-20c63f5b29b8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3249bd57-1d09-4e25-b9f4-7cea6126137c",
                  "id": "f1aa8c10-6e7c-4425-b58e-acb8f90a9aaf"
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
    "id": "2c4e41ea-b5cd-563f-8d95-db0593635996",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b710e6f9-ca4e-4c42-9446-d607577b623d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b710e6f9-ca4e-4c42-9446-d607577b623d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e9e2aa95-f3ca-4863-9a3c-58b029b428ea"
          },
          {
            "type": "lines",
            "id": "ca933388-76da-4e4d-a46d-a852785e4ed5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "56bc1d3b-b2aa-4a05-9705-51b194a6a17e"
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
      "id": "b710e6f9-ca4e-4c42-9446-d607577b623d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T09:35:15+00:00",
        "updated_at": "2023-03-09T09:35:16+00:00",
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
        "starts_at": "2023-03-07T09:30:00+00:00",
        "stops_at": "2023-03-11T09:30:00+00:00",
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
        "start_location_id": "ffb1dd7d-4874-4059-b365-57ca16929cc7",
        "stop_location_id": "ffb1dd7d-4874-4059-b365-57ca16929cc7"
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
      "id": "e9e2aa95-f3ca-4863-9a3c-58b029b428ea",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T09:35:16+00:00",
        "updated_at": "2023-03-09T09:35:16+00:00",
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
        "item_id": "f1aa8c10-6e7c-4425-b58e-acb8f90a9aaf",
        "tax_category_id": null,
        "planning_id": "25333d03-bd7c-4a7f-b3f8-f63951e4af5b",
        "parent_line_id": "ca933388-76da-4e4d-a46d-a852785e4ed5",
        "owner_id": "b710e6f9-ca4e-4c42-9446-d607577b623d",
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
      "id": "ca933388-76da-4e4d-a46d-a852785e4ed5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T09:35:16+00:00",
        "updated_at": "2023-03-09T09:35:16+00:00",
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
        "item_id": "f5e5a6c6-7768-4720-b90f-20c63f5b29b8",
        "tax_category_id": null,
        "planning_id": "56bc1d3b-b2aa-4a05-9705-51b194a6a17e",
        "parent_line_id": null,
        "owner_id": "b710e6f9-ca4e-4c42-9446-d607577b623d",
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
      "id": "56bc1d3b-b2aa-4a05-9705-51b194a6a17e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T09:35:16+00:00",
        "updated_at": "2023-03-09T09:35:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-07T09:30:00+00:00",
        "stops_at": "2023-03-11T09:30:00+00:00",
        "reserved_from": "2023-03-07T09:30:00+00:00",
        "reserved_till": "2023-03-11T09:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f5e5a6c6-7768-4720-b90f-20c63f5b29b8",
        "order_id": "b710e6f9-ca4e-4c42-9446-d607577b623d",
        "start_location_id": "ffb1dd7d-4874-4059-b365-57ca16929cc7",
        "stop_location_id": "ffb1dd7d-4874-4059-b365-57ca16929cc7",
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





