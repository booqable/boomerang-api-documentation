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
          "order_id": "c25930f4-21c9-4058-8814-dd51f2c21ba1",
          "items": [
            {
              "type": "products",
              "id": "6fac0178-7523-4cbe-8680-1a7d2fa3dcb7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c3fb7a01-7fba-472a-ae32-e66b0121d578",
              "stock_item_ids": [
                "a7a65e08-2fa0-45b5-a678-f4c2e0fe61bd",
                "48a6524e-ba9b-45dc-870e-d35e7752427b"
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
            "item_id": "6fac0178-7523-4cbe-8680-1a7d2fa3dcb7",
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
          "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
          "items": [
            {
              "type": "products",
              "id": "79fce384-6fc2-4490-8520-4ea560084482",
              "stock_item_ids": [
                "0719d175-5539-464a-89b5-ed63a3674c6c",
                "5ab68363-abfe-4360-9fa2-caa9146a8dcd",
                "d359ad44-8f12-44da-b020-d2a979b7900c"
              ]
            },
            {
              "type": "products",
              "id": "67a803d7-1dcb-4ca2-b702-d0481aacdb32",
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
    "id": "8d676f8a-e087-5ae9-8900-5747bf7daeb3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b22eb61c-9d1d-4382-a69c-b626d56706d5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "44893799-808a-4964-aa47-af7b52a86098"
          },
          {
            "type": "lines",
            "id": "6fe96afe-d2d1-487e-ab5f-25a2f54424aa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f"
          },
          {
            "type": "plannings",
            "id": "d1bbcc92-9468-4815-950b-11ae5c9d84d7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0a72a6c9-1e85-477a-9625-3c0bbbe81256"
          },
          {
            "type": "stock_item_plannings",
            "id": "bc70f9d4-5a25-4660-94c8-960a7647e3b7"
          },
          {
            "type": "stock_item_plannings",
            "id": "857dba28-b1b3-4b1f-b661-cd3ed0acec0c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T09:09:57+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
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
        "customer_id": "1cb6b997-46bf-41fa-bc31-69625b03dcbb",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff",
        "stop_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff"
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
      "id": "44893799-808a-4964-aa47-af7b52a86098",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
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
        "item_id": "79fce384-6fc2-4490-8520-4ea560084482",
        "tax_category_id": "b302e24e-fbb4-4244-b845-0c5f25dc39a1",
        "planning_id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f",
        "parent_line_id": null,
        "owner_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
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
      "id": "6fe96afe-d2d1-487e-ab5f-25a2f54424aa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
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
        "item_id": "67a803d7-1dcb-4ca2-b702-d0481aacdb32",
        "tax_category_id": "b302e24e-fbb4-4244-b845-0c5f25dc39a1",
        "planning_id": "d1bbcc92-9468-4815-950b-11ae5c9d84d7",
        "parent_line_id": null,
        "owner_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
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
      "id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
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
        "item_id": "79fce384-6fc2-4490-8520-4ea560084482",
        "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
        "start_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff",
        "stop_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff",
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
      "id": "d1bbcc92-9468-4815-950b-11ae5c9d84d7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
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
        "item_id": "67a803d7-1dcb-4ca2-b702-d0481aacdb32",
        "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5",
        "start_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff",
        "stop_location_id": "e31452f6-defd-4f60-8fc4-0b8e2bb7b7ff",
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
      "id": "0a72a6c9-1e85-477a-9625-3c0bbbe81256",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0719d175-5539-464a-89b5-ed63a3674c6c",
        "planning_id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f",
        "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5"
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
      "id": "bc70f9d4-5a25-4660-94c8-960a7647e3b7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5ab68363-abfe-4360-9fa2-caa9146a8dcd",
        "planning_id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f",
        "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5"
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
      "id": "857dba28-b1b3-4b1f-b661-cd3ed0acec0c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-13T09:09:59+00:00",
        "updated_at": "2023-02-13T09:09:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d359ad44-8f12-44da-b020-d2a979b7900c",
        "planning_id": "c3df53ce-69fb-4b60-bfc0-b2ea6607b56f",
        "order_id": "b22eb61c-9d1d-4382-a69c-b626d56706d5"
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
          "order_id": "1166bcfb-cb39-431f-82db-189248eb4e32",
          "items": [
            {
              "type": "bundles",
              "id": "b9655c60-dc34-4ed4-8441-0466fc3eb1e7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "16b89ca5-6b59-4b31-9a9b-485b616b0438",
                  "id": "8a425214-be85-43aa-a618-d752be0b6c04"
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
    "id": "fe625879-dae0-53ce-88b6-7b0d9d0b97aa",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1166bcfb-cb39-431f-82db-189248eb4e32"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1166bcfb-cb39-431f-82db-189248eb4e32"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b8d7636b-9418-403b-bbbb-d61648c820a7"
          },
          {
            "type": "lines",
            "id": "c18f51f5-8974-4ec2-a28e-36de68012480"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "74cc9401-dc37-41a9-9ff8-2b27bdd6a914"
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
      "id": "1166bcfb-cb39-431f-82db-189248eb4e32",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-13T09:10:02+00:00",
        "updated_at": "2023-02-13T09:10:03+00:00",
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
        "starts_at": "2023-02-11T09:00:00+00:00",
        "stops_at": "2023-02-15T09:00:00+00:00",
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
        "start_location_id": "20aa1bce-89ba-4131-bc41-d4a4cebdd880",
        "stop_location_id": "20aa1bce-89ba-4131-bc41-d4a4cebdd880"
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
      "id": "b8d7636b-9418-403b-bbbb-d61648c820a7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T09:10:03+00:00",
        "updated_at": "2023-02-13T09:10:03+00:00",
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
        "item_id": "8a425214-be85-43aa-a618-d752be0b6c04",
        "tax_category_id": null,
        "planning_id": "1c428901-70ac-4e4d-a5dd-859926b9ebd0",
        "parent_line_id": "c18f51f5-8974-4ec2-a28e-36de68012480",
        "owner_id": "1166bcfb-cb39-431f-82db-189248eb4e32",
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
      "id": "c18f51f5-8974-4ec2-a28e-36de68012480",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-13T09:10:03+00:00",
        "updated_at": "2023-02-13T09:10:03+00:00",
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
        "item_id": "b9655c60-dc34-4ed4-8441-0466fc3eb1e7",
        "tax_category_id": null,
        "planning_id": "74cc9401-dc37-41a9-9ff8-2b27bdd6a914",
        "parent_line_id": null,
        "owner_id": "1166bcfb-cb39-431f-82db-189248eb4e32",
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
      "id": "74cc9401-dc37-41a9-9ff8-2b27bdd6a914",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-13T09:10:03+00:00",
        "updated_at": "2023-02-13T09:10:03+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-11T09:00:00+00:00",
        "stops_at": "2023-02-15T09:00:00+00:00",
        "reserved_from": "2023-02-11T09:00:00+00:00",
        "reserved_till": "2023-02-15T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b9655c60-dc34-4ed4-8441-0466fc3eb1e7",
        "order_id": "1166bcfb-cb39-431f-82db-189248eb4e32",
        "start_location_id": "20aa1bce-89ba-4131-bc41-d4a4cebdd880",
        "stop_location_id": "20aa1bce-89ba-4131-bc41-d4a4cebdd880",
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





