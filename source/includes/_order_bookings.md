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
          "order_id": "89313f95-bf94-450d-aec5-0ddebfed25a2",
          "items": [
            {
              "type": "products",
              "id": "bae73836-2de9-40c8-bb99-cfa5a1b4bf7d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "43c8bb42-42c4-444f-a72b-9292be8f904b",
              "stock_item_ids": [
                "674f906e-799f-4a1e-9c5f-064bc7d36db8",
                "a0e75f87-40b5-4708-9a86-d89bca3cc2e0"
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
            "item_id": "bae73836-2de9-40c8-bb99-cfa5a1b4bf7d",
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
          "order_id": "f383a552-e252-4f89-bee4-280890f25f81",
          "items": [
            {
              "type": "products",
              "id": "af972e72-7a48-4665-9cae-ed5bb026c848",
              "stock_item_ids": [
                "9a96f2c6-6c5a-40c6-8c4d-3079ab179337",
                "f67bdf1b-b1b0-4c1e-9439-c06ccc6d15f2",
                "c6211a99-05c1-46c9-bed9-03c2521ea647"
              ]
            },
            {
              "type": "products",
              "id": "75e04920-e829-4820-9e52-65d725c294c9",
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
    "id": "c6aa6f38-8bfd-53e4-a290-4970d32ff249",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f383a552-e252-4f89-bee4-280890f25f81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f383a552-e252-4f89-bee4-280890f25f81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cc2b4d59-5290-43a2-a9ef-64149b6b7c47"
          },
          {
            "type": "lines",
            "id": "1ae7abaf-0563-4c1d-8db6-fed0f82b6657"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c5835e0c-93de-4458-8e73-cd03fafdf77e"
          },
          {
            "type": "plannings",
            "id": "94c42632-da4e-4342-96f5-f5b815c3e7ab"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "95b819f3-081b-43e9-ae82-bc535bb5fa11"
          },
          {
            "type": "stock_item_plannings",
            "id": "7086b8c9-2bbe-4176-abc0-2c3abe85946d"
          },
          {
            "type": "stock_item_plannings",
            "id": "01726dfe-8240-453f-94cd-5bece97b3c26"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f383a552-e252-4f89-bee4-280890f25f81",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:00:50+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
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
        "customer_id": "f53e9c78-d2de-4093-b0ee-88b1f7aa0368",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e",
        "stop_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e"
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
      "id": "cc2b4d59-5290-43a2-a9ef-64149b6b7c47",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
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
        "item_id": "af972e72-7a48-4665-9cae-ed5bb026c848",
        "tax_category_id": "01172fe5-705e-4cbd-82e0-b89f27ef2723",
        "planning_id": "c5835e0c-93de-4458-8e73-cd03fafdf77e",
        "parent_line_id": null,
        "owner_id": "f383a552-e252-4f89-bee4-280890f25f81",
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
      "id": "1ae7abaf-0563-4c1d-8db6-fed0f82b6657",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
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
        "item_id": "75e04920-e829-4820-9e52-65d725c294c9",
        "tax_category_id": "01172fe5-705e-4cbd-82e0-b89f27ef2723",
        "planning_id": "94c42632-da4e-4342-96f5-f5b815c3e7ab",
        "parent_line_id": null,
        "owner_id": "f383a552-e252-4f89-bee4-280890f25f81",
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
      "id": "c5835e0c-93de-4458-8e73-cd03fafdf77e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
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
        "item_id": "af972e72-7a48-4665-9cae-ed5bb026c848",
        "order_id": "f383a552-e252-4f89-bee4-280890f25f81",
        "start_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e",
        "stop_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e",
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
      "id": "94c42632-da4e-4342-96f5-f5b815c3e7ab",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
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
        "item_id": "75e04920-e829-4820-9e52-65d725c294c9",
        "order_id": "f383a552-e252-4f89-bee4-280890f25f81",
        "start_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e",
        "stop_location_id": "f10fc9c7-01c7-4627-9b29-67a26f826a1e",
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
      "id": "95b819f3-081b-43e9-ae82-bc535bb5fa11",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9a96f2c6-6c5a-40c6-8c4d-3079ab179337",
        "planning_id": "c5835e0c-93de-4458-8e73-cd03fafdf77e",
        "order_id": "f383a552-e252-4f89-bee4-280890f25f81"
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
      "id": "7086b8c9-2bbe-4176-abc0-2c3abe85946d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f67bdf1b-b1b0-4c1e-9439-c06ccc6d15f2",
        "planning_id": "c5835e0c-93de-4458-8e73-cd03fafdf77e",
        "order_id": "f383a552-e252-4f89-bee4-280890f25f81"
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
      "id": "01726dfe-8240-453f-94cd-5bece97b3c26",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:51+00:00",
        "updated_at": "2023-02-08T15:00:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c6211a99-05c1-46c9-bed9-03c2521ea647",
        "planning_id": "c5835e0c-93de-4458-8e73-cd03fafdf77e",
        "order_id": "f383a552-e252-4f89-bee4-280890f25f81"
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
          "order_id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff",
          "items": [
            {
              "type": "bundles",
              "id": "98c8450d-6ba3-4630-a599-561db7e7a739",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1d65e8a4-9a09-4425-9265-e98cb7436e10",
                  "id": "7da7fdf9-ea20-43c8-b95d-b80bfae1431b"
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
    "id": "ffcc0acb-8383-5584-8830-757b87b3c4f4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f53753cc-098e-4912-99aa-99c9f663b48e"
          },
          {
            "type": "lines",
            "id": "860cb688-c1ca-4b54-b64e-e794a76a4f7f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "feaa8548-8e4a-48cc-bc39-63ebb6f1e0a3"
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
      "id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T15:00:53+00:00",
        "updated_at": "2023-02-08T15:00:54+00:00",
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
        "starts_at": "2023-02-06T15:00:00+00:00",
        "stops_at": "2023-02-10T15:00:00+00:00",
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
        "start_location_id": "fdef7bbe-f906-4b17-8df7-96f3c425dc70",
        "stop_location_id": "fdef7bbe-f906-4b17-8df7-96f3c425dc70"
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
      "id": "f53753cc-098e-4912-99aa-99c9f663b48e",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:54+00:00",
        "updated_at": "2023-02-08T15:00:54+00:00",
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
        "item_id": "7da7fdf9-ea20-43c8-b95d-b80bfae1431b",
        "tax_category_id": null,
        "planning_id": "56fe0661-2734-4239-ba9f-eb4e088485e5",
        "parent_line_id": "860cb688-c1ca-4b54-b64e-e794a76a4f7f",
        "owner_id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff",
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
      "id": "860cb688-c1ca-4b54-b64e-e794a76a4f7f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T15:00:54+00:00",
        "updated_at": "2023-02-08T15:00:54+00:00",
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
        "item_id": "98c8450d-6ba3-4630-a599-561db7e7a739",
        "tax_category_id": null,
        "planning_id": "feaa8548-8e4a-48cc-bc39-63ebb6f1e0a3",
        "parent_line_id": null,
        "owner_id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff",
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
      "id": "feaa8548-8e4a-48cc-bc39-63ebb6f1e0a3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T15:00:54+00:00",
        "updated_at": "2023-02-08T15:00:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T15:00:00+00:00",
        "stops_at": "2023-02-10T15:00:00+00:00",
        "reserved_from": "2023-02-06T15:00:00+00:00",
        "reserved_till": "2023-02-10T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "98c8450d-6ba3-4630-a599-561db7e7a739",
        "order_id": "9aa62fd0-08c7-4bc4-92fb-559eb6881eff",
        "start_location_id": "fdef7bbe-f906-4b17-8df7-96f3c425dc70",
        "stop_location_id": "fdef7bbe-f906-4b17-8df7-96f3c425dc70",
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





