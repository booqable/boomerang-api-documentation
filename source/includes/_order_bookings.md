# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
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
          "order_id": "13cbba90-f316-4a62-b9d6-08e0c961fdfb",
          "items": [
            {
              "type": "products",
              "id": "be666c69-b7bd-40b4-8060-44072120e359",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "3d87f95d-4403-4ada-9f42-6dee2104f04e",
              "stock_item_ids": [
                "93ad9bd4-b839-421f-998d-d0575a5e1fdf",
                "d93eb01f-f314-44f3-9a8f-c132e6175824"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 93ad9bd4-b839-421f-998d-d0575a5e1fdf has already been booked on this order"
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
          "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
          "items": [
            {
              "type": "products",
              "id": "093bb87e-1e7d-47fa-8510-a7a05cf3e809",
              "stock_item_ids": [
                "ae997b53-ebf2-42ef-9860-6baed94695ea",
                "6d2a9bb8-5a53-4be9-aa0d-1a40131faac1",
                "eb4013c3-a9ea-4934-bd45-cf27050ef591"
              ]
            },
            {
              "type": "products",
              "id": "cc8f0cf6-7816-4301-8a55-335d25b7a2a0",
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
    "id": "4328d1f9-874b-5432-a0aa-f30982cb0f81",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d251e1c0-9205-46c8-8835-0c53b2feed35"
          },
          {
            "type": "lines",
            "id": "c03551af-1253-4910-a865-25ed457048a7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70"
          },
          {
            "type": "plannings",
            "id": "5496e44e-512f-4169-a101-fe3184ca78c8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4814d049-09ca-48c4-b39e-94a63d813bd5"
          },
          {
            "type": "stock_item_plannings",
            "id": "0ad62208-401f-4b81-b19d-386c66353409"
          },
          {
            "type": "stock_item_plannings",
            "id": "a9bbb204-08b5-42e8-a773-9b3b7e7aef48"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
      "type": "orders",
      "attributes": {
        "created_at": "2024-03-11T09:19:48+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
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
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "295d1b77-8098-4357-860b-ebe71782c633",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a",
        "stop_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a"
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
        "transfers": {
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
      "id": "d251e1c0-9205-46c8-8835-0c53b2feed35",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "display_price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "item_id": "093bb87e-1e7d-47fa-8510-a7a05cf3e809",
        "tax_category_id": "0a5ac674-a85e-4d47-ac1c-e31d23db1cc8",
        "planning_id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "c03551af-1253-4910-a865-25ed457048a7",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "display_price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "item_id": "cc8f0cf6-7816-4301-8a55-335d25b7a2a0",
        "tax_category_id": "0a5ac674-a85e-4d47-ac1c-e31d23db1cc8",
        "planning_id": "5496e44e-512f-4169-a101-fe3184ca78c8",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
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
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "item_id": "093bb87e-1e7d-47fa-8510-a7a05cf3e809",
        "start_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a",
        "stop_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "5496e44e-512f-4169-a101-fe3184ca78c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
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
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26",
        "item_id": "cc8f0cf6-7816-4301-8a55-335d25b7a2a0",
        "start_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a",
        "stop_location_id": "fcef8561-7a67-462c-b033-8eef8270dd4a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "4814d049-09ca-48c4-b39e-94a63d813bd5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ae997b53-ebf2-42ef-9860-6baed94695ea",
        "planning_id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70",
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26"
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
      "id": "0ad62208-401f-4b81-b19d-386c66353409",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6d2a9bb8-5a53-4be9-aa0d-1a40131faac1",
        "planning_id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70",
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26"
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
      "id": "a9bbb204-08b5-42e8-a773-9b3b7e7aef48",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:50+00:00",
        "updated_at": "2024-03-11T09:19:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eb4013c3-a9ea-4934-bd45-cf27050ef591",
        "planning_id": "fb6ce3c2-97bb-4f1a-82eb-4c5fddebbc70",
        "order_id": "ff8b776d-87c2-4d54-baed-d2a8c9affa26"
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
          "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
          "items": [
            {
              "type": "bundles",
              "id": "e8d915b7-8675-4b5b-b1ec-b0df6fcd1c57",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d33a08ff-20cd-4d3a-bac7-5aa3c8e18cf9",
                  "id": "fabff518-c4f1-43a4-8829-255d0ccc957c"
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
    "id": "2241d4d3-f0b1-52ba-8a96-2d406ede9f6b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ca7e5b39-a082-4850-9da7-90bf8660b608"
          },
          {
            "type": "lines",
            "id": "1c864fbb-0db5-4cde-b03f-323e73d9843d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9bcbcb0b-c4b9-4e8e-945f-1c662b7915f5"
          },
          {
            "type": "plannings",
            "id": "d70af57c-87d3-4ee6-8521-5f3f5ff1f105"
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
      "id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
      "type": "orders",
      "attributes": {
        "created_at": "2024-03-11T09:19:54+00:00",
        "updated_at": "2024-03-11T09:19:54+00:00",
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
        "starts_at": "2024-03-09T09:15:00+00:00",
        "stops_at": "2024-03-13T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115",
        "stop_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115"
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
        "transfers": {
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
      "id": "ca7e5b39-a082-4850-9da7-90bf8660b608",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-11T09:19:54+00:00",
        "updated_at": "2024-03-11T09:19:54+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 8",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "item_id": "e8d915b7-8675-4b5b-b1ec-b0df6fcd1c57",
        "tax_category_id": null,
        "planning_id": "9bcbcb0b-c4b9-4e8e-945f-1c662b7915f5",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "1c864fbb-0db5-4cde-b03f-323e73d9843d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-03-11T09:19:54+00:00",
        "updated_at": "2024-03-11T09:19:54+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000076 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "item_id": "fabff518-c4f1-43a4-8829-255d0ccc957c",
        "tax_category_id": null,
        "planning_id": "d70af57c-87d3-4ee6-8521-5f3f5ff1f105",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "ca7e5b39-a082-4850-9da7-90bf8660b608",
        "owner_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "9bcbcb0b-c4b9-4e8e-945f-1c662b7915f5",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:54+00:00",
        "updated_at": "2024-03-11T09:19:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-03-09T09:15:00+00:00",
        "stops_at": "2024-03-13T09:15:00+00:00",
        "reserved_from": "2024-03-09T09:15:00+00:00",
        "reserved_till": "2024-03-13T09:15:00+00:00",
        "reserved": false,
        "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "item_id": "e8d915b7-8675-4b5b-b1ec-b0df6fcd1c57",
        "start_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115",
        "stop_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "d70af57c-87d3-4ee6-8521-5f3f5ff1f105",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-03-11T09:19:54+00:00",
        "updated_at": "2024-03-11T09:19:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-03-09T09:15:00+00:00",
        "stops_at": "2024-03-13T09:15:00+00:00",
        "reserved_from": "2024-03-09T09:15:00+00:00",
        "reserved_till": "2024-03-13T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "e520eb0f-085b-4e3c-accf-3fdfd452fd66",
        "item_id": "fabff518-c4f1-43a4-8829-255d0ccc957c",
        "start_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115",
        "stop_location_id": "6bc4b53f-9b98-4050-a53d-f2ebed0c4115",
        "parent_planning_id": "9bcbcb0b-c4b9-4e8e-945f-1c662b7915f5",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





