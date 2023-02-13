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
          "order_id": "272da580-d211-475a-934d-da5064df729a",
          "items": [
            {
              "type": "products",
              "id": "be601f63-2731-4a86-b22d-09fd921032eb",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0675e964-f92e-4218-96fd-35a537f691e2",
              "stock_item_ids": [
                "7eff508c-1734-4a19-bf5e-fde23da2709a",
                "c8051d45-3d87-4606-9bb9-d3c0c4cb1c1e"
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
            "item_id": "be601f63-2731-4a86-b22d-09fd921032eb",
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
          "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
          "items": [
            {
              "type": "products",
              "id": "c621e19e-d7b8-4a1a-8fc6-3e7d194f512e",
              "stock_item_ids": [
                "74eaad22-d9b0-4156-ab10-be37123802e2",
                "64f73820-0809-46f7-b127-308395f1ab1e",
                "c80dc27e-2429-4f00-9354-f9833c1c17ee"
              ]
            },
            {
              "type": "products",
              "id": "9b1f612f-fe51-4e6c-850c-5d5c28d707f5",
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
    "id": "10130e1c-968f-5e85-b35f-61df39cf9f7d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8f27afbc-a837-4b50-b099-11b73d2cf727"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "eda88e88-6953-459f-b30e-343702ac3600"
          },
          {
            "type": "lines",
            "id": "e56d9be0-e0c5-4320-990e-78301bed8a98"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0edfbaa9-0b85-401a-a682-1b59a9532874"
          },
          {
            "type": "plannings",
            "id": "4fbfd1a0-e9ca-4042-b997-c6efd94c4eb0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c534a63b-2e07-48d9-8688-7fd9795d7817"
          },
          {
            "type": "stock_item_plannings",
            "id": "e4ce5af8-8959-4f0c-a965-da4e0ab9e6d7"
          },
          {
            "type": "stock_item_plannings",
            "id": "08db5484-232f-43cd-bb79-0dfb0be1f0c7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:54:01+00:00",
        "updated_at": "2023-02-13T12:54:03+00:00",
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
        "customer_id": "a7bf5a1a-ab09-40c8-b145-cacf272bd227",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790",
        "stop_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790"
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
      "id": "eda88e88-6953-459f-b30e-343702ac3600",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:02+00:00",
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
        "item_id": "c621e19e-d7b8-4a1a-8fc6-3e7d194f512e",
        "tax_category_id": "6bb62f7b-2f92-4488-8a7c-550b177fb52a",
        "planning_id": "0edfbaa9-0b85-401a-a682-1b59a9532874",
        "parent_line_id": null,
        "owner_id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
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
      "id": "e56d9be0-e0c5-4320-990e-78301bed8a98",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:02+00:00",
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
        "item_id": "9b1f612f-fe51-4e6c-850c-5d5c28d707f5",
        "tax_category_id": "6bb62f7b-2f92-4488-8a7c-550b177fb52a",
        "planning_id": "4fbfd1a0-e9ca-4042-b997-c6efd94c4eb0",
        "parent_line_id": null,
        "owner_id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
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
      "id": "0edfbaa9-0b85-401a-a682-1b59a9532874",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:03+00:00",
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
        "item_id": "c621e19e-d7b8-4a1a-8fc6-3e7d194f512e",
        "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
        "start_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790",
        "stop_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790",
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
      "id": "4fbfd1a0-e9ca-4042-b997-c6efd94c4eb0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:03+00:00",
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
        "item_id": "9b1f612f-fe51-4e6c-850c-5d5c28d707f5",
        "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727",
        "start_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790",
        "stop_location_id": "8fe57b74-c8ea-4a0c-9bcc-8c364bab7790",
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
      "id": "c534a63b-2e07-48d9-8688-7fd9795d7817",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "74eaad22-d9b0-4156-ab10-be37123802e2",
        "planning_id": "0edfbaa9-0b85-401a-a682-1b59a9532874",
        "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727"
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
      "id": "e4ce5af8-8959-4f0c-a965-da4e0ab9e6d7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "64f73820-0809-46f7-b127-308395f1ab1e",
        "planning_id": "0edfbaa9-0b85-401a-a682-1b59a9532874",
        "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727"
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
      "id": "08db5484-232f-43cd-bb79-0dfb0be1f0c7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:02+00:00",
        "updated_at": "2023-02-13T12:54:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c80dc27e-2429-4f00-9354-f9833c1c17ee",
        "planning_id": "0edfbaa9-0b85-401a-a682-1b59a9532874",
        "order_id": "8f27afbc-a837-4b50-b099-11b73d2cf727"
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
          "order_id": "b7889a11-061f-4b61-81ef-12aac956a15d",
          "items": [
            {
              "type": "bundles",
              "id": "ca844453-0660-4152-b0f9-ce7c090b2e78",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a4ff2724-f788-46aa-b12b-b1878067cde3",
                  "id": "c3971c07-a2e0-4e22-ab5d-a11dac36e7e0"
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
    "id": "b745f98c-ace6-504a-95c4-b821ceeede55",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b7889a11-061f-4b61-81ef-12aac956a15d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b7889a11-061f-4b61-81ef-12aac956a15d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b1600ae1-0c33-41cb-8221-975df5d282e6"
          },
          {
            "type": "lines",
            "id": "c63393ae-6453-4ccc-b260-4a1143207877"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b02b820d-e7c9-4059-a949-4934db7aaf2c"
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
      "id": "b7889a11-061f-4b61-81ef-12aac956a15d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T12:54:05+00:00",
        "updated_at": "2023-02-13T12:54:06+00:00",
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
        "start_location_id": "ed5a1a97-5d77-4d2f-8908-7f5a497f5030",
        "stop_location_id": "ed5a1a97-5d77-4d2f-8908-7f5a497f5030"
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
      "id": "b1600ae1-0c33-41cb-8221-975df5d282e6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:54:06+00:00",
        "updated_at": "2023-02-13T12:54:06+00:00",
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
        "item_id": "c3971c07-a2e0-4e22-ab5d-a11dac36e7e0",
        "tax_category_id": null,
        "planning_id": "14210b68-3422-4da8-b688-b78b0e9bd52c",
        "parent_line_id": "c63393ae-6453-4ccc-b260-4a1143207877",
        "owner_id": "b7889a11-061f-4b61-81ef-12aac956a15d",
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
      "id": "c63393ae-6453-4ccc-b260-4a1143207877",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T12:54:06+00:00",
        "updated_at": "2023-02-13T12:54:06+00:00",
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
        "item_id": "ca844453-0660-4152-b0f9-ce7c090b2e78",
        "tax_category_id": null,
        "planning_id": "b02b820d-e7c9-4059-a949-4934db7aaf2c",
        "parent_line_id": null,
        "owner_id": "b7889a11-061f-4b61-81ef-12aac956a15d",
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
      "id": "b02b820d-e7c9-4059-a949-4934db7aaf2c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T12:54:06+00:00",
        "updated_at": "2023-02-13T12:54:06+00:00",
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
        "item_id": "ca844453-0660-4152-b0f9-ce7c090b2e78",
        "order_id": "b7889a11-061f-4b61-81ef-12aac956a15d",
        "start_location_id": "ed5a1a97-5d77-4d2f-8908-7f5a497f5030",
        "stop_location_id": "ed5a1a97-5d77-4d2f-8908-7f5a497f5030",
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





