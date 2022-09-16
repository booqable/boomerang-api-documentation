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
          "order_id": "975652d8-ed50-48d6-8c31-f5353271c9fb",
          "items": [
            {
              "type": "products",
              "id": "c0458aff-d1fb-4c76-83cf-ab711a468bfd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3032c6d7-f650-4033-8e64-533e2ab46104",
              "stock_item_ids": [
                "c826ed51-42bd-4242-86b2-b5201bd7e4f3",
                "627bdf8d-7f1e-4ee1-a897-5e2d094b459b"
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
            "item_id": "c0458aff-d1fb-4c76-83cf-ab711a468bfd",
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
          "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
          "items": [
            {
              "type": "products",
              "id": "7b63de60-2e65-4cee-8fb9-04735a110202",
              "stock_item_ids": [
                "7cdd99ba-7564-4382-bdf9-8ca7a26a8969",
                "30852672-982a-4ea3-806d-cf2553fb18fb",
                "1255df98-f3b8-4b68-84d7-9f650c53343b"
              ]
            },
            {
              "type": "products",
              "id": "ffd06231-7fd0-4b20-989e-963a0ab48a4f",
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
    "id": "492c7160-edb4-5d99-aa35-7266126cbff2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d3a1151a-0f07-4dbe-8d15-851b86d7909a"
          },
          {
            "type": "lines",
            "id": "efaeb814-69e9-445e-9f99-344b5556029f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f9dc3792-a119-46a2-a74c-990423a5db91"
          },
          {
            "type": "plannings",
            "id": "84c4a49c-4ad8-4a09-89f8-ddeaf259847f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ca6a2582-ca33-44a1-8e3e-f54c081a8daa"
          },
          {
            "type": "stock_item_plannings",
            "id": "5d6bd11e-341e-4284-bd8a-78a35c246aaa"
          },
          {
            "type": "stock_item_plannings",
            "id": "f48a3fa9-e05f-415c-9b65-7de403e63e46"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T11:50:23+00:00",
        "updated_at": "2022-09-16T11:50:26+00:00",
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
        "customer_id": "8ff08635-e624-4270-ae50-59bbbd92fbc2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc",
        "stop_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc"
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
      "id": "d3a1151a-0f07-4dbe-8d15-851b86d7909a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:26+00:00",
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
        "item_id": "7b63de60-2e65-4cee-8fb9-04735a110202",
        "tax_category_id": "260f61df-193f-4f01-9244-bbb00edd9b6c",
        "planning_id": "f9dc3792-a119-46a2-a74c-990423a5db91",
        "parent_line_id": null,
        "owner_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
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
      "id": "efaeb814-69e9-445e-9f99-344b5556029f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:26+00:00",
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
        "item_id": "ffd06231-7fd0-4b20-989e-963a0ab48a4f",
        "tax_category_id": "260f61df-193f-4f01-9244-bbb00edd9b6c",
        "planning_id": "84c4a49c-4ad8-4a09-89f8-ddeaf259847f",
        "parent_line_id": null,
        "owner_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
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
      "id": "f9dc3792-a119-46a2-a74c-990423a5db91",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:26+00:00",
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
        "item_id": "7b63de60-2e65-4cee-8fb9-04735a110202",
        "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
        "start_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc",
        "stop_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc",
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
      "id": "84c4a49c-4ad8-4a09-89f8-ddeaf259847f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:26+00:00",
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
        "item_id": "ffd06231-7fd0-4b20-989e-963a0ab48a4f",
        "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7",
        "start_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc",
        "stop_location_id": "ba44d562-8acc-4254-8aba-55acce1deccc",
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
      "id": "ca6a2582-ca33-44a1-8e3e-f54c081a8daa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7cdd99ba-7564-4382-bdf9-8ca7a26a8969",
        "planning_id": "f9dc3792-a119-46a2-a74c-990423a5db91",
        "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7"
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
      "id": "5d6bd11e-341e-4284-bd8a-78a35c246aaa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "30852672-982a-4ea3-806d-cf2553fb18fb",
        "planning_id": "f9dc3792-a119-46a2-a74c-990423a5db91",
        "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7"
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
      "id": "f48a3fa9-e05f-415c-9b65-7de403e63e46",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:25+00:00",
        "updated_at": "2022-09-16T11:50:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1255df98-f3b8-4b68-84d7-9f650c53343b",
        "planning_id": "f9dc3792-a119-46a2-a74c-990423a5db91",
        "order_id": "6f80d1cb-2a56-4d25-a5ea-16cbed5b61b7"
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
          "order_id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd",
          "items": [
            {
              "type": "bundles",
              "id": "8d115e6d-1884-4356-90f4-7f5f4c277648",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9b5f76ef-a0d0-4d61-97d2-a9f4e547dab6",
                  "id": "c76d4bf0-22d0-4c4f-9883-47e32a0ec2fb"
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
    "id": "4c9edbd3-278c-58c3-ad6c-f3a373da847b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c6c591e7-1b44-42ae-ba02-6818fddf0f55"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a46e9793-7a92-48b2-9618-9332bd299f2a"
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
      "id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd",
      "type": "orders",
      "attributes": {
        "created_at": "2022-09-16T11:50:29+00:00",
        "updated_at": "2022-09-16T11:50:30+00:00",
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
        "starts_at": "2022-09-14T11:45:00+00:00",
        "stops_at": "2022-09-18T11:45:00+00:00",
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
        "start_location_id": "062823c0-2317-4cc6-9773-5f9e7537ab03",
        "stop_location_id": "062823c0-2317-4cc6-9773-5f9e7537ab03"
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
      "id": "c6c591e7-1b44-42ae-ba02-6818fddf0f55",
      "type": "lines",
      "attributes": {
        "created_at": "2022-09-16T11:50:30+00:00",
        "updated_at": "2022-09-16T11:50:30+00:00",
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
        "item_id": "8d115e6d-1884-4356-90f4-7f5f4c277648",
        "tax_category_id": null,
        "planning_id": "a46e9793-7a92-48b2-9618-9332bd299f2a",
        "parent_line_id": null,
        "owner_id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd",
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
      "id": "a46e9793-7a92-48b2-9618-9332bd299f2a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-09-16T11:50:30+00:00",
        "updated_at": "2022-09-16T11:50:30+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-09-14T11:45:00+00:00",
        "stops_at": "2022-09-18T11:45:00+00:00",
        "reserved_from": "2022-09-14T11:45:00+00:00",
        "reserved_till": "2022-09-18T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8d115e6d-1884-4356-90f4-7f5f4c277648",
        "order_id": "a5d92ffe-eaae-4ad0-a562-8c123075e1bd",
        "start_location_id": "062823c0-2317-4cc6-9773-5f9e7537ab03",
        "stop_location_id": "062823c0-2317-4cc6-9773-5f9e7537ab03",
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





