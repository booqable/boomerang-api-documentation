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
          "order_id": "ec8b0c3a-0d8c-498c-93e0-c95a66d72573",
          "items": [
            {
              "type": "products",
              "id": "4ad9b85b-b1ef-4d28-a62e-914cd39a0981",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "57343bb4-51a3-4d72-b9fa-60e7c704a411",
              "stock_item_ids": [
                "27e5f420-6e28-4941-9b78-5fc74a99eef5",
                "fce95d64-ec82-438c-8969-b1a8820d92a4"
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
            "item_id": "4ad9b85b-b1ef-4d28-a62e-914cd39a0981",
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
          "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
          "items": [
            {
              "type": "products",
              "id": "e602e649-d645-4cfb-bdf6-c338ffb7a4ef",
              "stock_item_ids": [
                "9c614e84-3583-48ab-8c81-9d9a640240dc",
                "0420203b-50e1-48e7-a860-caaa88103c91",
                "f11f8503-e592-4983-ae76-8e211739d59c"
              ]
            },
            {
              "type": "products",
              "id": "c9ac7497-96d1-49dd-90c7-7c7ac2838248",
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
    "id": "95150d93-0af3-5e89-8be5-c044dd7c0d4b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f500fe85-0247-49cf-88e7-191fc480c2a8"
          },
          {
            "type": "lines",
            "id": "3b4241db-051c-4892-b442-acc42f70b535"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c5453e72-77c8-4445-b148-a15bbf6132d0"
          },
          {
            "type": "plannings",
            "id": "c9a08566-c1ee-4de6-9172-e8256771335d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ee4983fd-925b-4ef0-82ad-aaa983773c01"
          },
          {
            "type": "stock_item_plannings",
            "id": "4aaab164-3a9a-47b6-8212-bd8a4219d413"
          },
          {
            "type": "stock_item_plannings",
            "id": "5976a0a7-84b9-4a9b-96ed-70617180aded"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T08:28:40+00:00",
        "updated_at": "2023-02-03T08:28:42+00:00",
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
        "customer_id": "28bcafbd-11a9-4a8b-bdc1-e854a18390c6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418",
        "stop_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418"
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
      "id": "f500fe85-0247-49cf-88e7-191fc480c2a8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:41+00:00",
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
        "item_id": "e602e649-d645-4cfb-bdf6-c338ffb7a4ef",
        "tax_category_id": "9be91e43-9132-4b1c-8b32-5a4a26abf0e4",
        "planning_id": "c5453e72-77c8-4445-b148-a15bbf6132d0",
        "parent_line_id": null,
        "owner_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
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
      "id": "3b4241db-051c-4892-b442-acc42f70b535",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:41+00:00",
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
        "item_id": "c9ac7497-96d1-49dd-90c7-7c7ac2838248",
        "tax_category_id": "9be91e43-9132-4b1c-8b32-5a4a26abf0e4",
        "planning_id": "c9a08566-c1ee-4de6-9172-e8256771335d",
        "parent_line_id": null,
        "owner_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
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
      "id": "c5453e72-77c8-4445-b148-a15bbf6132d0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:42+00:00",
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
        "item_id": "e602e649-d645-4cfb-bdf6-c338ffb7a4ef",
        "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
        "start_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418",
        "stop_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418",
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
      "id": "c9a08566-c1ee-4de6-9172-e8256771335d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:42+00:00",
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
        "item_id": "c9ac7497-96d1-49dd-90c7-7c7ac2838248",
        "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad",
        "start_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418",
        "stop_location_id": "ac644a1b-ebae-4d8f-87a8-e6cd64756418",
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
      "id": "ee4983fd-925b-4ef0-82ad-aaa983773c01",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9c614e84-3583-48ab-8c81-9d9a640240dc",
        "planning_id": "c5453e72-77c8-4445-b148-a15bbf6132d0",
        "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad"
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
      "id": "4aaab164-3a9a-47b6-8212-bd8a4219d413",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0420203b-50e1-48e7-a860-caaa88103c91",
        "planning_id": "c5453e72-77c8-4445-b148-a15bbf6132d0",
        "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad"
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
      "id": "5976a0a7-84b9-4a9b-96ed-70617180aded",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:41+00:00",
        "updated_at": "2023-02-03T08:28:41+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f11f8503-e592-4983-ae76-8e211739d59c",
        "planning_id": "c5453e72-77c8-4445-b148-a15bbf6132d0",
        "order_id": "c12e82b6-0147-4ccb-a3f4-87140326a1ad"
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
          "order_id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d",
          "items": [
            {
              "type": "bundles",
              "id": "8edbbbff-3df4-4179-bec7-b4694e1bf6f5",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "32a70da3-1003-4bc3-a1c3-c410a7c8c11c",
                  "id": "813734f2-d7a8-47c6-8a28-fa0df4bc07f4"
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
    "id": "e003f266-2e30-536b-960a-080cf2da6787",
    "type": "order_bookings",
    "attributes": {
      "order_id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7d75438f-caea-4297-a5dc-c87a27954996"
          },
          {
            "type": "lines",
            "id": "712e1b4b-5920-4882-ae01-a50324d57077"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ce1cab31-bba9-4713-9f59-8318e036420c"
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
      "id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T08:28:44+00:00",
        "updated_at": "2023-02-03T08:28:45+00:00",
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
        "starts_at": "2023-02-01T08:15:00+00:00",
        "stops_at": "2023-02-05T08:15:00+00:00",
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
        "start_location_id": "0fe95b27-96f5-46ac-9695-9829772b92bf",
        "stop_location_id": "0fe95b27-96f5-46ac-9695-9829772b92bf"
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
      "id": "7d75438f-caea-4297-a5dc-c87a27954996",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:28:45+00:00",
        "updated_at": "2023-02-03T08:28:45+00:00",
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
        "item_id": "8edbbbff-3df4-4179-bec7-b4694e1bf6f5",
        "tax_category_id": null,
        "planning_id": "ce1cab31-bba9-4713-9f59-8318e036420c",
        "parent_line_id": null,
        "owner_id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d",
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
      "id": "712e1b4b-5920-4882-ae01-a50324d57077",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T08:28:45+00:00",
        "updated_at": "2023-02-03T08:28:45+00:00",
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
        "item_id": "813734f2-d7a8-47c6-8a28-fa0df4bc07f4",
        "tax_category_id": null,
        "planning_id": "d11f0556-cac4-4f85-9d58-c222a56c5315",
        "parent_line_id": "7d75438f-caea-4297-a5dc-c87a27954996",
        "owner_id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d",
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
      "id": "ce1cab31-bba9-4713-9f59-8318e036420c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T08:28:45+00:00",
        "updated_at": "2023-02-03T08:28:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T08:15:00+00:00",
        "stops_at": "2023-02-05T08:15:00+00:00",
        "reserved_from": "2023-02-01T08:15:00+00:00",
        "reserved_till": "2023-02-05T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8edbbbff-3df4-4179-bec7-b4694e1bf6f5",
        "order_id": "88fd0867-e8e4-4e0a-8b64-50c5481e3b7d",
        "start_location_id": "0fe95b27-96f5-46ac-9695-9829772b92bf",
        "stop_location_id": "0fe95b27-96f5-46ac-9695-9829772b92bf",
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





