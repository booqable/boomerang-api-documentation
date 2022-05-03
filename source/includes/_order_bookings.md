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
          "order_id": "d985120d-25f9-49ed-8d9a-0e87fdb13e1f",
          "items": [
            {
              "type": "products",
              "id": "d16362f2-9a40-47ac-a071-4946c28ff590",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "faea7e21-3355-4a81-8e03-38f2383d27a0",
              "stock_item_ids": [
                "24630a9e-ade0-44c7-b6c9-815d918ae85a",
                "a4778225-50a5-4e11-9e59-67ee11493d05"
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
            "item_id": "d16362f2-9a40-47ac-a071-4946c28ff590",
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
          "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
          "items": [
            {
              "type": "products",
              "id": "2d7ef869-f7c1-4c4a-b8d6-3b57f2222040",
              "stock_item_ids": [
                "2ecc00b5-40d8-41cf-9e48-f8328df731c1",
                "d5e0a37e-751f-4dc1-9fde-e6bed351fb5c",
                "60adaa8f-660b-4b77-a3ca-47d23d37e980"
              ]
            },
            {
              "type": "products",
              "id": "1ee46cb7-a18f-496b-afc1-9accbe4eb968",
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
    "id": "625f7867-8c8d-523c-a97e-7ccdb623337d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "acbc90bb-9d97-4afa-aa11-1b292f8bee0e"
          },
          {
            "type": "lines",
            "id": "de336dc1-6f3c-4419-8210-155947f58654"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "32568091-47c2-41e2-b8d4-77e5ad6b20aa"
          },
          {
            "type": "plannings",
            "id": "18f0267c-5a1b-4f4f-8534-6132eec303d2"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "13caf90d-7157-410b-a22d-4887e5f480c1"
          },
          {
            "type": "stock_item_plannings",
            "id": "c0821445-a06b-467e-9d10-738a84f90302"
          },
          {
            "type": "stock_item_plannings",
            "id": "ea08685e-0c67-4310-9b39-880f36fb184b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-03T10:19:26+00:00",
        "updated_at": "2022-05-03T10:19:28+00:00",
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
        "customer_id": "338861e0-5b17-4239-9a2c-3d6a6aaf9732",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad",
        "stop_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad"
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
      "id": "acbc90bb-9d97-4afa-aa11-1b292f8bee0e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-03T10:19:26+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
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
        "item_id": "1ee46cb7-a18f-496b-afc1-9accbe4eb968",
        "tax_category_id": "b45096b3-92ae-4f39-8003-0a9b338efb44",
        "planning_id": "32568091-47c2-41e2-b8d4-77e5ad6b20aa",
        "parent_line_id": null,
        "owner_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
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
      "id": "de336dc1-6f3c-4419-8210-155947f58654",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-03T10:19:27+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
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
        "item_id": "2d7ef869-f7c1-4c4a-b8d6-3b57f2222040",
        "tax_category_id": "b45096b3-92ae-4f39-8003-0a9b338efb44",
        "planning_id": "18f0267c-5a1b-4f4f-8534-6132eec303d2",
        "parent_line_id": null,
        "owner_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
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
      "id": "32568091-47c2-41e2-b8d4-77e5ad6b20aa",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:26+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
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
        "item_id": "1ee46cb7-a18f-496b-afc1-9accbe4eb968",
        "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
        "start_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad",
        "stop_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad",
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
      "id": "18f0267c-5a1b-4f4f-8534-6132eec303d2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:27+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
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
        "item_id": "2d7ef869-f7c1-4c4a-b8d6-3b57f2222040",
        "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179",
        "start_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad",
        "stop_location_id": "b75d2cc4-4acf-4b64-a442-29d3affc67ad",
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
      "id": "13caf90d-7157-410b-a22d-4887e5f480c1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:27+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2ecc00b5-40d8-41cf-9e48-f8328df731c1",
        "planning_id": "18f0267c-5a1b-4f4f-8534-6132eec303d2",
        "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179"
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
      "id": "c0821445-a06b-467e-9d10-738a84f90302",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:27+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d5e0a37e-751f-4dc1-9fde-e6bed351fb5c",
        "planning_id": "18f0267c-5a1b-4f4f-8534-6132eec303d2",
        "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179"
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
      "id": "ea08685e-0c67-4310-9b39-880f36fb184b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:27+00:00",
        "updated_at": "2022-05-03T10:19:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "60adaa8f-660b-4b77-a3ca-47d23d37e980",
        "planning_id": "18f0267c-5a1b-4f4f-8534-6132eec303d2",
        "order_id": "423a33b4-bd36-4ffc-9fc2-4f0b15385179"
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
          "order_id": "dd091bdf-02ea-428e-b91f-30f263a322ce",
          "items": [
            {
              "type": "bundles",
              "id": "2326f145-89b8-431c-b015-aff4e6870783",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3c510353-c8da-4145-987c-30e33d652a11",
                  "id": "3982d5ab-203c-4eaf-ac53-e65448059000"
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
    "id": "68097293-93e2-5240-8374-327fa65866b6",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dd091bdf-02ea-428e-b91f-30f263a322ce"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dd091bdf-02ea-428e-b91f-30f263a322ce"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d6c81fe2-680f-4440-9abf-7901c2baf71c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "719aad1e-f954-4852-9d28-0f781a44f50e"
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
      "id": "dd091bdf-02ea-428e-b91f-30f263a322ce",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-03T10:19:30+00:00",
        "updated_at": "2022-05-03T10:19:30+00:00",
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
        "starts_at": "2022-05-01T10:15:00+00:00",
        "stops_at": "2022-05-05T10:15:00+00:00",
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
        "start_location_id": "9e2b1600-52ca-43ed-8f4d-a20657cc315b",
        "stop_location_id": "9e2b1600-52ca-43ed-8f4d-a20657cc315b"
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
      "id": "d6c81fe2-680f-4440-9abf-7901c2baf71c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-03T10:19:30+00:00",
        "updated_at": "2022-05-03T10:19:30+00:00",
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
        "item_id": "2326f145-89b8-431c-b015-aff4e6870783",
        "tax_category_id": null,
        "planning_id": "719aad1e-f954-4852-9d28-0f781a44f50e",
        "parent_line_id": null,
        "owner_id": "dd091bdf-02ea-428e-b91f-30f263a322ce",
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
      "id": "719aad1e-f954-4852-9d28-0f781a44f50e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-03T10:19:30+00:00",
        "updated_at": "2022-05-03T10:19:30+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-01T10:15:00+00:00",
        "stops_at": "2022-05-05T10:15:00+00:00",
        "reserved_from": "2022-05-01T10:15:00+00:00",
        "reserved_till": "2022-05-05T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "2326f145-89b8-431c-b015-aff4e6870783",
        "order_id": "dd091bdf-02ea-428e-b91f-30f263a322ce",
        "start_location_id": "9e2b1600-52ca-43ed-8f4d-a20657cc315b",
        "stop_location_id": "9e2b1600-52ca-43ed-8f4d-a20657cc315b",
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





