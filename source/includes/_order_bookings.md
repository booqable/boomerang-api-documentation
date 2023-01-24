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
          "order_id": "9cdf2fd1-c32c-4b13-8273-c63b16682637",
          "items": [
            {
              "type": "products",
              "id": "75656d5d-befe-4097-9e7f-8210ab677b5a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6931e36a-410e-4527-a052-4f35c2a1b54c",
              "stock_item_ids": [
                "cb39f86a-d2dd-4167-9be6-17f1d27d2450",
                "99ff396f-3df6-4216-9c2e-2297521c1787"
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
            "item_id": "75656d5d-befe-4097-9e7f-8210ab677b5a",
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
          "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
          "items": [
            {
              "type": "products",
              "id": "9fd14301-d952-4445-8880-8a60d9e6f0da",
              "stock_item_ids": [
                "6c4de48c-4447-4d49-8b88-efe9a7940a2d",
                "4df7b288-192b-491f-b6d9-5144286da485",
                "f43f5b2a-7a75-41d5-9636-f9e446debc3c"
              ]
            },
            {
              "type": "products",
              "id": "5e4e5508-c14a-44ff-b071-97eb00be7bc0",
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
    "id": "54b48bb8-6006-5c5c-8f01-41c3c167dee4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "deb67915-2d0c-42d1-903e-2fabe6b56903"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d5a74a97-4764-47d9-8c08-49cad0085727"
          },
          {
            "type": "lines",
            "id": "54a74cb6-8f82-43e1-857f-8ed4fb6a2a24"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd"
          },
          {
            "type": "plannings",
            "id": "a5c006ec-f8b4-425f-834c-c68232fe15e4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "156df00b-9f5d-439a-b7c3-3d73ad1df87a"
          },
          {
            "type": "stock_item_plannings",
            "id": "a2ebc65d-11f3-462c-b7d9-cbb5ca6641e5"
          },
          {
            "type": "stock_item_plannings",
            "id": "1cbe432d-53fd-460d-9fcb-63e79857f719"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T14:01:57+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
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
        "customer_id": "5109a6cb-4249-4781-b418-a7002c547daa",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389",
        "stop_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389"
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
      "id": "d5a74a97-4764-47d9-8c08-49cad0085727",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
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
        "item_id": "9fd14301-d952-4445-8880-8a60d9e6f0da",
        "tax_category_id": "f3ca8018-f782-463a-bc9d-e62beabb0dee",
        "planning_id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd",
        "parent_line_id": null,
        "owner_id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
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
      "id": "54a74cb6-8f82-43e1-857f-8ed4fb6a2a24",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
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
        "item_id": "5e4e5508-c14a-44ff-b071-97eb00be7bc0",
        "tax_category_id": "f3ca8018-f782-463a-bc9d-e62beabb0dee",
        "planning_id": "a5c006ec-f8b4-425f-834c-c68232fe15e4",
        "parent_line_id": null,
        "owner_id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
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
      "id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
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
        "item_id": "9fd14301-d952-4445-8880-8a60d9e6f0da",
        "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
        "start_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389",
        "stop_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389",
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
      "id": "a5c006ec-f8b4-425f-834c-c68232fe15e4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
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
        "item_id": "5e4e5508-c14a-44ff-b071-97eb00be7bc0",
        "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903",
        "start_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389",
        "stop_location_id": "2dc5473e-7e3a-41ed-bf88-3a0b3d97c389",
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
      "id": "156df00b-9f5d-439a-b7c3-3d73ad1df87a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6c4de48c-4447-4d49-8b88-efe9a7940a2d",
        "planning_id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd",
        "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903"
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
      "id": "a2ebc65d-11f3-462c-b7d9-cbb5ca6641e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4df7b288-192b-491f-b6d9-5144286da485",
        "planning_id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd",
        "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903"
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
      "id": "1cbe432d-53fd-460d-9fcb-63e79857f719",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T14:01:59+00:00",
        "updated_at": "2023-01-24T14:01:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f43f5b2a-7a75-41d5-9636-f9e446debc3c",
        "planning_id": "bba87fdc-76c3-437c-a1de-a19c61d4f8fd",
        "order_id": "deb67915-2d0c-42d1-903e-2fabe6b56903"
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
          "order_id": "4ef902f4-fb21-46d6-959d-f1e6e5568636",
          "items": [
            {
              "type": "bundles",
              "id": "0edc8e08-846b-4669-9895-8976285e8df9",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1e7248a2-923d-4a98-872f-b6cfd5957647",
                  "id": "04c2ccb7-96f1-42f4-a9af-eb18fc950e62"
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
    "id": "1b2dd017-9a95-5b9a-b0ca-5dcb6d77e4d8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4ef902f4-fb21-46d6-959d-f1e6e5568636"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4ef902f4-fb21-46d6-959d-f1e6e5568636"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "da6414be-5eb3-4f0e-ad9f-36f88bc4a1ca"
          },
          {
            "type": "lines",
            "id": "b05f27c0-30a2-44a5-a62e-c28967d18cbe"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "887769d7-3ffa-4ed3-b272-9eb6ada8e4ee"
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
      "id": "4ef902f4-fb21-46d6-959d-f1e6e5568636",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T14:02:01+00:00",
        "updated_at": "2023-01-24T14:02:02+00:00",
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
        "starts_at": "2023-01-22T14:00:00+00:00",
        "stops_at": "2023-01-26T14:00:00+00:00",
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
        "start_location_id": "a57be1da-c689-4df9-816e-c76eaea5b716",
        "stop_location_id": "a57be1da-c689-4df9-816e-c76eaea5b716"
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
      "id": "da6414be-5eb3-4f0e-ad9f-36f88bc4a1ca",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:02:02+00:00",
        "updated_at": "2023-01-24T14:02:02+00:00",
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
        "item_id": "0edc8e08-846b-4669-9895-8976285e8df9",
        "tax_category_id": null,
        "planning_id": "887769d7-3ffa-4ed3-b272-9eb6ada8e4ee",
        "parent_line_id": null,
        "owner_id": "4ef902f4-fb21-46d6-959d-f1e6e5568636",
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
      "id": "b05f27c0-30a2-44a5-a62e-c28967d18cbe",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T14:02:02+00:00",
        "updated_at": "2023-01-24T14:02:02+00:00",
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
        "item_id": "04c2ccb7-96f1-42f4-a9af-eb18fc950e62",
        "tax_category_id": null,
        "planning_id": "de3ca1f6-a872-4f94-9a96-1819935f1296",
        "parent_line_id": "da6414be-5eb3-4f0e-ad9f-36f88bc4a1ca",
        "owner_id": "4ef902f4-fb21-46d6-959d-f1e6e5568636",
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
      "id": "887769d7-3ffa-4ed3-b272-9eb6ada8e4ee",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T14:02:02+00:00",
        "updated_at": "2023-01-24T14:02:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-22T14:00:00+00:00",
        "stops_at": "2023-01-26T14:00:00+00:00",
        "reserved_from": "2023-01-22T14:00:00+00:00",
        "reserved_till": "2023-01-26T14:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0edc8e08-846b-4669-9895-8976285e8df9",
        "order_id": "4ef902f4-fb21-46d6-959d-f1e6e5568636",
        "start_location_id": "a57be1da-c689-4df9-816e-c76eaea5b716",
        "stop_location_id": "a57be1da-c689-4df9-816e-c76eaea5b716",
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





