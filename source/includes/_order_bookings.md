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
          "order_id": "fa294274-23d3-4a07-9eae-b62f7f9bcb9f",
          "items": [
            {
              "type": "products",
              "id": "491ec119-f726-4852-8e95-06ae0c33087a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1ae09ae8-6db8-47c4-93ec-e5d2d051f422",
              "stock_item_ids": [
                "76817572-2e56-4b4a-b573-ee6cfe873428",
                "17873c42-1cbd-4b46-887a-fea78e7e95c5"
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
            "item_id": "491ec119-f726-4852-8e95-06ae0c33087a",
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
          "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
          "items": [
            {
              "type": "products",
              "id": "0bf21dcb-44c1-4084-9d32-092d2c2f73cb",
              "stock_item_ids": [
                "78224d55-0434-4fbc-afdb-736a1d6ff6fa",
                "3d22fa5a-9c50-4c3b-b5b3-57331513d46e",
                "87961158-0422-477a-8423-7ff2d647b36c"
              ]
            },
            {
              "type": "products",
              "id": "aff1c331-fe1c-4f01-86c3-94721fd27b3f",
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
    "id": "924da43c-9d33-57ee-9da2-48cb519da44d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a0d6df69-0462-4558-894e-f0c4cb188d46"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "661c23ea-db1a-4703-acb1-3edd65429585"
          },
          {
            "type": "lines",
            "id": "d039dba8-61ad-4066-850d-e9de0ecddc2a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b"
          },
          {
            "type": "plannings",
            "id": "b8db54dc-86d7-4dbe-8749-314da779c405"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "bd3642b2-8abb-405e-9b78-d9ea506f161d"
          },
          {
            "type": "stock_item_plannings",
            "id": "666e1116-6ed5-4d54-8143-1ddcaa74dc01"
          },
          {
            "type": "stock_item_plannings",
            "id": "5311da11-77ec-4a5d-8ee8-ea0bd54e990b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T18:50:17+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
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
        "customer_id": "fed9b578-4a47-4a1e-8055-d6cca69b8461",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47",
        "stop_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47"
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
      "id": "661c23ea-db1a-4703-acb1-3edd65429585",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T18:50:20+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
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
        "item_id": "0bf21dcb-44c1-4084-9d32-092d2c2f73cb",
        "tax_category_id": "c8ca865c-65cf-459e-9d90-22efadb6dce8",
        "planning_id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b",
        "parent_line_id": null,
        "owner_id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
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
      "id": "d039dba8-61ad-4066-850d-e9de0ecddc2a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T18:50:20+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
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
        "item_id": "aff1c331-fe1c-4f01-86c3-94721fd27b3f",
        "tax_category_id": "c8ca865c-65cf-459e-9d90-22efadb6dce8",
        "planning_id": "b8db54dc-86d7-4dbe-8749-314da779c405",
        "parent_line_id": null,
        "owner_id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
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
      "id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:19+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
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
        "item_id": "0bf21dcb-44c1-4084-9d32-092d2c2f73cb",
        "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
        "start_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47",
        "stop_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47",
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
      "id": "b8db54dc-86d7-4dbe-8749-314da779c405",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:19+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
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
        "item_id": "aff1c331-fe1c-4f01-86c3-94721fd27b3f",
        "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46",
        "start_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47",
        "stop_location_id": "53c9ea9e-d37d-41a5-b0b7-086e5c793a47",
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
      "id": "bd3642b2-8abb-405e-9b78-d9ea506f161d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:20+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "78224d55-0434-4fbc-afdb-736a1d6ff6fa",
        "planning_id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b",
        "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46"
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
      "id": "666e1116-6ed5-4d54-8143-1ddcaa74dc01",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:20+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3d22fa5a-9c50-4c3b-b5b3-57331513d46e",
        "planning_id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b",
        "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46"
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
      "id": "5311da11-77ec-4a5d-8ee8-ea0bd54e990b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:20+00:00",
        "updated_at": "2022-10-25T18:50:20+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "87961158-0422-477a-8423-7ff2d647b36c",
        "planning_id": "bec8e55c-eae5-404c-bbb4-6a3059fa2d3b",
        "order_id": "a0d6df69-0462-4558-894e-f0c4cb188d46"
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
          "order_id": "141b5964-93ea-495d-be17-dd80ee238a08",
          "items": [
            {
              "type": "bundles",
              "id": "d56e43ae-d1e4-4a8a-b4cc-4e8a7029143e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "299c32a4-a922-47e1-a302-1904b820ef69",
                  "id": "cefbc65d-e951-4c82-b3f1-a144db36fc84"
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
    "id": "94a068bb-bec2-5ec9-ba0c-530c8eff04ef",
    "type": "order_bookings",
    "attributes": {
      "order_id": "141b5964-93ea-495d-be17-dd80ee238a08"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "141b5964-93ea-495d-be17-dd80ee238a08"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1087cdb3-80b1-4006-81c1-5ecd583cf6b5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "84512701-33e2-49bf-8d0f-d320f242fd0a"
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
      "id": "141b5964-93ea-495d-be17-dd80ee238a08",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T18:50:23+00:00",
        "updated_at": "2022-10-25T18:50:24+00:00",
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
        "starts_at": "2022-10-23T18:45:00+00:00",
        "stops_at": "2022-10-27T18:45:00+00:00",
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
        "start_location_id": "0e19cf8e-1c8e-4d6f-86aa-007868af83d6",
        "stop_location_id": "0e19cf8e-1c8e-4d6f-86aa-007868af83d6"
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
      "id": "1087cdb3-80b1-4006-81c1-5ecd583cf6b5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T18:50:24+00:00",
        "updated_at": "2022-10-25T18:50:24+00:00",
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
        "item_id": "d56e43ae-d1e4-4a8a-b4cc-4e8a7029143e",
        "tax_category_id": null,
        "planning_id": "84512701-33e2-49bf-8d0f-d320f242fd0a",
        "parent_line_id": null,
        "owner_id": "141b5964-93ea-495d-be17-dd80ee238a08",
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
      "id": "84512701-33e2-49bf-8d0f-d320f242fd0a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T18:50:24+00:00",
        "updated_at": "2022-10-25T18:50:24+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T18:45:00+00:00",
        "stops_at": "2022-10-27T18:45:00+00:00",
        "reserved_from": "2022-10-23T18:45:00+00:00",
        "reserved_till": "2022-10-27T18:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d56e43ae-d1e4-4a8a-b4cc-4e8a7029143e",
        "order_id": "141b5964-93ea-495d-be17-dd80ee238a08",
        "start_location_id": "0e19cf8e-1c8e-4d6f-86aa-007868af83d6",
        "stop_location_id": "0e19cf8e-1c8e-4d6f-86aa-007868af83d6",
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





