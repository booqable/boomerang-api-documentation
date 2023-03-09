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
          "order_id": "57f210a7-f1d0-43e8-b928-438d17eccb26",
          "items": [
            {
              "type": "products",
              "id": "f2316b10-bded-4a61-b43b-2dba598139db",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7b78093a-07d9-481a-ab37-b2de8172573c",
              "stock_item_ids": [
                "e7b5181a-8ec0-4ced-a150-63c12350dc0b",
                "ec2a1a05-92c0-49c8-b8fb-06b764bcd659"
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
          "stock_item_id e7b5181a-8ec0-4ced-a150-63c12350dc0b has already been booked on this order"
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
          "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
          "items": [
            {
              "type": "products",
              "id": "01731b5b-3c75-4cd1-8541-2f332a69f28e",
              "stock_item_ids": [
                "22b18597-f180-4ace-9f5d-641cbb09acff",
                "9f8e45a8-84fc-496d-becf-155928a1d3ce",
                "686194df-28bf-470d-b670-f25c292578d1"
              ]
            },
            {
              "type": "products",
              "id": "9dec7543-cdc6-4404-bc78-d5d3018fe9f8",
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
    "id": "4e2ccd6e-3fb0-51e0-8679-7c801d915071",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eddc787a-fba1-4bbf-b3a4-f5b7db8301b3"
          },
          {
            "type": "lines",
            "id": "9f823abb-00c6-45a3-8a3d-e0f060d4516a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb"
          },
          {
            "type": "plannings",
            "id": "6099fe82-44d1-4d8a-a72e-8ce885fe5215"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "aafde8c8-c841-44df-854b-576f0024285a"
          },
          {
            "type": "stock_item_plannings",
            "id": "fffea7aa-219e-46ba-ae19-454e17a8f7b2"
          },
          {
            "type": "stock_item_plannings",
            "id": "09e07479-9af2-454d-a2bb-03c464231787"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T08:59:03+00:00",
        "updated_at": "2023-03-09T08:59:06+00:00",
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
        "customer_id": "6639586e-64f3-4f77-ac3e-0c745e99004f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561",
        "stop_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561"
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
      "id": "eddc787a-fba1-4bbf-b3a4-f5b7db8301b3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
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
        "item_id": "01731b5b-3c75-4cd1-8541-2f332a69f28e",
        "tax_category_id": "bd13bd2d-4837-4778-9c00-693e41cb7cc8",
        "planning_id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb",
        "parent_line_id": null,
        "owner_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
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
      "id": "9f823abb-00c6-45a3-8a3d-e0f060d4516a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
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
        "item_id": "9dec7543-cdc6-4404-bc78-d5d3018fe9f8",
        "tax_category_id": "bd13bd2d-4837-4778-9c00-693e41cb7cc8",
        "planning_id": "6099fe82-44d1-4d8a-a72e-8ce885fe5215",
        "parent_line_id": null,
        "owner_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
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
      "id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
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
        "item_id": "01731b5b-3c75-4cd1-8541-2f332a69f28e",
        "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
        "start_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561",
        "stop_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561",
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
      "id": "6099fe82-44d1-4d8a-a72e-8ce885fe5215",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
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
        "item_id": "9dec7543-cdc6-4404-bc78-d5d3018fe9f8",
        "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e",
        "start_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561",
        "stop_location_id": "13594e17-05b2-4a06-a4b6-60d102ce4561",
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
      "id": "aafde8c8-c841-44df-854b-576f0024285a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "22b18597-f180-4ace-9f5d-641cbb09acff",
        "planning_id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb",
        "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e"
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
      "id": "fffea7aa-219e-46ba-ae19-454e17a8f7b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9f8e45a8-84fc-496d-becf-155928a1d3ce",
        "planning_id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb",
        "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e"
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
      "id": "09e07479-9af2-454d-a2bb-03c464231787",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:05+00:00",
        "updated_at": "2023-03-09T08:59:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "686194df-28bf-470d-b670-f25c292578d1",
        "planning_id": "e31cb501-5abe-42e5-ac1d-2f3b7cd6adbb",
        "order_id": "fffe0a90-ab04-4630-9d19-6f1d030c1c0e"
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
          "order_id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79",
          "items": [
            {
              "type": "bundles",
              "id": "a8d56b0f-7971-403b-ade6-15f510ede701",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e7a53423-5bf3-4f97-89a2-638e82af980d",
                  "id": "8683d17d-b10c-4e75-a6d7-05806dc8674f"
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
    "id": "a338efaf-9049-530f-9e1a-ea0b9b27b521",
    "type": "order_bookings",
    "attributes": {
      "order_id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "274564b4-5cf3-4bb2-aa40-b5d077e4dc75"
          },
          {
            "type": "lines",
            "id": "a7e7d17c-6b55-4f84-a4e5-cd483fd06d9a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ee472599-f278-4f45-b532-d346ae4098c1"
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
      "id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T08:59:08+00:00",
        "updated_at": "2023-03-09T08:59:09+00:00",
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
        "starts_at": "2023-03-07T08:45:00+00:00",
        "stops_at": "2023-03-11T08:45:00+00:00",
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
        "start_location_id": "deea4978-1b71-494d-99b1-8683b652e960",
        "stop_location_id": "deea4978-1b71-494d-99b1-8683b652e960"
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
      "id": "274564b4-5cf3-4bb2-aa40-b5d077e4dc75",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:09+00:00",
        "updated_at": "2023-03-09T08:59:09+00:00",
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
        "item_id": "a8d56b0f-7971-403b-ade6-15f510ede701",
        "tax_category_id": null,
        "planning_id": "ee472599-f278-4f45-b532-d346ae4098c1",
        "parent_line_id": null,
        "owner_id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79",
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
      "id": "a7e7d17c-6b55-4f84-a4e5-cd483fd06d9a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T08:59:09+00:00",
        "updated_at": "2023-03-09T08:59:09+00:00",
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
        "item_id": "8683d17d-b10c-4e75-a6d7-05806dc8674f",
        "tax_category_id": null,
        "planning_id": "f19edee4-da60-4820-b246-49b0f483c55d",
        "parent_line_id": "274564b4-5cf3-4bb2-aa40-b5d077e4dc75",
        "owner_id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79",
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
      "id": "ee472599-f278-4f45-b532-d346ae4098c1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T08:59:09+00:00",
        "updated_at": "2023-03-09T08:59:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-07T08:45:00+00:00",
        "stops_at": "2023-03-11T08:45:00+00:00",
        "reserved_from": "2023-03-07T08:45:00+00:00",
        "reserved_till": "2023-03-11T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a8d56b0f-7971-403b-ade6-15f510ede701",
        "order_id": "12a6efa8-f937-42a8-83aa-d1fc45ab4e79",
        "start_location_id": "deea4978-1b71-494d-99b1-8683b652e960",
        "stop_location_id": "deea4978-1b71-494d-99b1-8683b652e960",
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





