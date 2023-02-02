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
          "order_id": "8061e91a-ef10-44b5-962c-151a19bf3e23",
          "items": [
            {
              "type": "products",
              "id": "95e2ce1f-daf8-4718-a5d7-6c0ffddbcb0d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "36beb74f-c399-4f0f-918d-9c17883da84b",
              "stock_item_ids": [
                "af2956cb-b1ed-4c13-a681-b71764ec323c",
                "9dffab16-773f-4109-8bb8-775cb5bd5d06"
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
            "item_id": "95e2ce1f-daf8-4718-a5d7-6c0ffddbcb0d",
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
          "order_id": "197facfa-41cb-4552-8ea5-3265f3636508",
          "items": [
            {
              "type": "products",
              "id": "94e2e5f1-f439-4d58-a353-3003613f5c30",
              "stock_item_ids": [
                "2ff8a49a-ddda-422c-a451-92f1ba410f89",
                "af00de8f-9adb-4597-b426-336c9a49d717",
                "a0f4fda6-d6ab-4e76-84c0-92250462a0e8"
              ]
            },
            {
              "type": "products",
              "id": "cbbbdd72-27dc-441e-bb71-997a5def7fa2",
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
    "id": "15a136aa-c514-52e3-a104-8b2c9b6528a7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "197facfa-41cb-4552-8ea5-3265f3636508"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "197facfa-41cb-4552-8ea5-3265f3636508"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d33d40ff-28c4-41a5-95dd-3534053b48fd"
          },
          {
            "type": "lines",
            "id": "a61a9016-710a-4215-9c09-1350c44f5998"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d"
          },
          {
            "type": "plannings",
            "id": "33aa3133-9b59-430d-afca-663986b464a7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "57e67f8b-0f5f-49bb-a514-5dcf18796186"
          },
          {
            "type": "stock_item_plannings",
            "id": "05577ec4-1184-424a-8011-b7b654e08476"
          },
          {
            "type": "stock_item_plannings",
            "id": "aaf1526c-c743-45c0-8dbd-5fa40e9c8014"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "197facfa-41cb-4552-8ea5-3265f3636508",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T07:56:58+00:00",
        "updated_at": "2023-02-02T07:57:00+00:00",
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
        "customer_id": "638a6db3-8c64-47ae-82bd-9707f140b8e3",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363",
        "stop_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363"
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
      "id": "d33d40ff-28c4-41a5-95dd-3534053b48fd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:56:59+00:00",
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
        "item_id": "94e2e5f1-f439-4d58-a353-3003613f5c30",
        "tax_category_id": "3e553538-5a8f-4f56-b693-5525346fdce8",
        "planning_id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d",
        "parent_line_id": null,
        "owner_id": "197facfa-41cb-4552-8ea5-3265f3636508",
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
      "id": "a61a9016-710a-4215-9c09-1350c44f5998",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:56:59+00:00",
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
        "item_id": "cbbbdd72-27dc-441e-bb71-997a5def7fa2",
        "tax_category_id": "3e553538-5a8f-4f56-b693-5525346fdce8",
        "planning_id": "33aa3133-9b59-430d-afca-663986b464a7",
        "parent_line_id": null,
        "owner_id": "197facfa-41cb-4552-8ea5-3265f3636508",
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
      "id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:57:00+00:00",
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
        "item_id": "94e2e5f1-f439-4d58-a353-3003613f5c30",
        "order_id": "197facfa-41cb-4552-8ea5-3265f3636508",
        "start_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363",
        "stop_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363",
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
      "id": "33aa3133-9b59-430d-afca-663986b464a7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:57:00+00:00",
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
        "item_id": "cbbbdd72-27dc-441e-bb71-997a5def7fa2",
        "order_id": "197facfa-41cb-4552-8ea5-3265f3636508",
        "start_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363",
        "stop_location_id": "24a4150d-67a8-4562-ae5f-d76dbf4b8363",
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
      "id": "57e67f8b-0f5f-49bb-a514-5dcf18796186",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:56:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2ff8a49a-ddda-422c-a451-92f1ba410f89",
        "planning_id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d",
        "order_id": "197facfa-41cb-4552-8ea5-3265f3636508"
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
      "id": "05577ec4-1184-424a-8011-b7b654e08476",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:56:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af00de8f-9adb-4597-b426-336c9a49d717",
        "planning_id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d",
        "order_id": "197facfa-41cb-4552-8ea5-3265f3636508"
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
      "id": "aaf1526c-c743-45c0-8dbd-5fa40e9c8014",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T07:56:59+00:00",
        "updated_at": "2023-02-02T07:56:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a0f4fda6-d6ab-4e76-84c0-92250462a0e8",
        "planning_id": "88499a60-fc08-4eb0-a89f-9ab3145e2d9d",
        "order_id": "197facfa-41cb-4552-8ea5-3265f3636508"
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
          "order_id": "1e1e6543-a376-447d-af6f-48609a770802",
          "items": [
            {
              "type": "bundles",
              "id": "4a13060a-2351-4d3f-a20f-a7248fc236cb",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c974621d-935d-4deb-8688-38c4eb0d54d6",
                  "id": "4c08792a-4c2e-4060-8a7b-b55679dc3469"
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
    "id": "2fc27031-ff73-5b08-8db1-8983cb24efc4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1e1e6543-a376-447d-af6f-48609a770802"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1e1e6543-a376-447d-af6f-48609a770802"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2d9450f8-d54f-47b8-9b4e-65a907a5463b"
          },
          {
            "type": "lines",
            "id": "3879edfb-8c2f-4378-b236-4a5649bcd0ae"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b1759672-6135-499b-85b6-bfedec983341"
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
      "id": "1e1e6543-a376-447d-af6f-48609a770802",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T07:57:01+00:00",
        "updated_at": "2023-02-02T07:57:02+00:00",
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
        "starts_at": "2023-01-31T07:45:00+00:00",
        "stops_at": "2023-02-04T07:45:00+00:00",
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
        "start_location_id": "9f5f850f-96f7-4269-a0d3-273c050e26cf",
        "stop_location_id": "9f5f850f-96f7-4269-a0d3-273c050e26cf"
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
      "id": "2d9450f8-d54f-47b8-9b4e-65a907a5463b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T07:57:02+00:00",
        "updated_at": "2023-02-02T07:57:02+00:00",
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
        "item_id": "4c08792a-4c2e-4060-8a7b-b55679dc3469",
        "tax_category_id": null,
        "planning_id": "5c9b3674-ffa6-4dd2-9df0-0fc92e617d5a",
        "parent_line_id": "3879edfb-8c2f-4378-b236-4a5649bcd0ae",
        "owner_id": "1e1e6543-a376-447d-af6f-48609a770802",
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
      "id": "3879edfb-8c2f-4378-b236-4a5649bcd0ae",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T07:57:02+00:00",
        "updated_at": "2023-02-02T07:57:02+00:00",
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
        "item_id": "4a13060a-2351-4d3f-a20f-a7248fc236cb",
        "tax_category_id": null,
        "planning_id": "b1759672-6135-499b-85b6-bfedec983341",
        "parent_line_id": null,
        "owner_id": "1e1e6543-a376-447d-af6f-48609a770802",
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
      "id": "b1759672-6135-499b-85b6-bfedec983341",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T07:57:02+00:00",
        "updated_at": "2023-02-02T07:57:02+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T07:45:00+00:00",
        "stops_at": "2023-02-04T07:45:00+00:00",
        "reserved_from": "2023-01-31T07:45:00+00:00",
        "reserved_till": "2023-02-04T07:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4a13060a-2351-4d3f-a20f-a7248fc236cb",
        "order_id": "1e1e6543-a376-447d-af6f-48609a770802",
        "start_location_id": "9f5f850f-96f7-4269-a0d3-273c050e26cf",
        "stop_location_id": "9f5f850f-96f7-4269-a0d3-273c050e26cf",
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





