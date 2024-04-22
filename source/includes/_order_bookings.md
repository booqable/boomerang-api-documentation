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



> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
          "items": [
            {
              "type": "products",
              "id": "173b0fc5-bcae-4a6c-b4ff-9807713c67aa",
              "stock_item_ids": [
                "0cd9a8ea-aa8d-411b-b9b4-314ef9f44972",
                "3471acb0-9f8b-4217-b195-91daf2843646",
                "0b151b09-746c-423d-91fe-dd2c5bd2191c"
              ]
            },
            {
              "type": "products",
              "id": "87c30e3d-37ea-4a8f-927d-7280af892c25",
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
    "id": "49c62e36-d670-57f2-834f-59575218579e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d398c081-a7e0-48de-8340-3c18236e67b3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5fb48881-05d2-40e9-be36-02c8018ede9d"
          },
          {
            "type": "lines",
            "id": "46013cb7-a402-491e-a182-e9963fbf3bb0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ba30984d-cb9e-4937-ad55-2a1139746724"
          },
          {
            "type": "plannings",
            "id": "782999b5-ea1f-48bd-8912-97e03fc7d0ed"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a276944c-bff6-4a44-93e1-48da872ab38d"
          },
          {
            "type": "stock_item_plannings",
            "id": "2633284f-e516-425b-a763-6257763925e9"
          },
          {
            "type": "stock_item_plannings",
            "id": "6dff6ef5-e241-4a94-b238-f16b1a851035"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d398c081-a7e0-48de-8340-3c18236e67b3",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-22T09:27:35+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
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
        "customer_id": "aedd5999-3fc4-4b13-81a8-400590dadee0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2",
        "stop_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2"
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
      "id": "5fb48881-05d2-40e9-be36-02c8018ede9d",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
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
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
        "item_id": "173b0fc5-bcae-4a6c-b4ff-9807713c67aa",
        "tax_category_id": "3a7c295e-4a42-40f4-bdf3-c24402d07b66",
        "planning_id": "ba30984d-cb9e-4937-ad55-2a1139746724",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
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
      "id": "46013cb7-a402-491e-a182-e9963fbf3bb0",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
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
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
        "item_id": "87c30e3d-37ea-4a8f-927d-7280af892c25",
        "tax_category_id": "3a7c295e-4a42-40f4-bdf3-c24402d07b66",
        "planning_id": "782999b5-ea1f-48bd-8912-97e03fc7d0ed",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
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
      "id": "ba30984d-cb9e-4937-ad55-2a1139746724",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
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
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
        "item_id": "173b0fc5-bcae-4a6c-b4ff-9807713c67aa",
        "start_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2",
        "stop_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2",
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
      "id": "782999b5-ea1f-48bd-8912-97e03fc7d0ed",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
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
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3",
        "item_id": "87c30e3d-37ea-4a8f-927d-7280af892c25",
        "start_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2",
        "stop_location_id": "9e635289-8cfa-454b-8827-42bf42f84ff2",
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
      "id": "a276944c-bff6-4a44-93e1-48da872ab38d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0cd9a8ea-aa8d-411b-b9b4-314ef9f44972",
        "planning_id": "ba30984d-cb9e-4937-ad55-2a1139746724",
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3"
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
      "id": "2633284f-e516-425b-a763-6257763925e9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3471acb0-9f8b-4217-b195-91daf2843646",
        "planning_id": "ba30984d-cb9e-4937-ad55-2a1139746724",
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3"
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
      "id": "6dff6ef5-e241-4a94-b238-f16b1a851035",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:37+00:00",
        "updated_at": "2024-04-22T09:27:37+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0b151b09-746c-423d-91fe-dd2c5bd2191c",
        "planning_id": "ba30984d-cb9e-4937-ad55-2a1139746724",
        "order_id": "d398c081-a7e0-48de-8340-3c18236e67b3"
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
          "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
          "items": [
            {
              "type": "bundles",
              "id": "50f032ec-2f57-4dca-9607-6adc6fbeb91c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "423a435f-907e-4f89-9d98-a76b5dd3166f",
                  "id": "66e5f604-15f5-4c12-9595-515c6876012e"
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
    "id": "8d67bde5-1eed-5fe6-a1be-16d4fa13899c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "40d03483-0bb1-4b1d-9a0c-a6876314b060"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2d37e70a-0238-4e92-bdfa-c4c01ada3971"
          },
          {
            "type": "lines",
            "id": "c23946c0-66d2-4d68-ae9e-04081754b93b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4768f523-fa1e-4cfe-ab8f-37c55bed3843"
          },
          {
            "type": "plannings",
            "id": "52bb9832-b233-4d47-9104-38b8f816c514"
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
      "id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
      "type": "orders",
      "attributes": {
        "created_at": "2024-04-22T09:27:40+00:00",
        "updated_at": "2024-04-22T09:27:40+00:00",
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
        "starts_at": "2024-04-20T09:15:00+00:00",
        "stops_at": "2024-04-24T09:15:00+00:00",
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
        "start_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42",
        "stop_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42"
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
      "id": "2d37e70a-0238-4e92-bdfa-c4c01ada3971",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-22T09:27:41+00:00",
        "updated_at": "2024-04-22T09:27:41+00:00",
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
        "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
        "item_id": "50f032ec-2f57-4dca-9607-6adc6fbeb91c",
        "tax_category_id": null,
        "planning_id": "4768f523-fa1e-4cfe-ab8f-37c55bed3843",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
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
      "id": "c23946c0-66d2-4d68-ae9e-04081754b93b",
      "type": "lines",
      "attributes": {
        "created_at": "2024-04-22T09:27:41+00:00",
        "updated_at": "2024-04-22T09:27:41+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000073 - red",
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
        "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
        "item_id": "66e5f604-15f5-4c12-9595-515c6876012e",
        "tax_category_id": null,
        "planning_id": "52bb9832-b233-4d47-9104-38b8f816c514",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "2d37e70a-0238-4e92-bdfa-c4c01ada3971",
        "owner_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
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
      "id": "4768f523-fa1e-4cfe-ab8f-37c55bed3843",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:40+00:00",
        "updated_at": "2024-04-22T09:27:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-20T09:15:00+00:00",
        "stops_at": "2024-04-24T09:15:00+00:00",
        "reserved_from": "2024-04-20T09:15:00+00:00",
        "reserved_till": "2024-04-24T09:15:00+00:00",
        "reserved": false,
        "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
        "item_id": "50f032ec-2f57-4dca-9607-6adc6fbeb91c",
        "start_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42",
        "stop_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42",
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
      "id": "52bb9832-b233-4d47-9104-38b8f816c514",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-04-22T09:27:40+00:00",
        "updated_at": "2024-04-22T09:27:40+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-04-20T09:15:00+00:00",
        "stops_at": "2024-04-24T09:15:00+00:00",
        "reserved_from": "2024-04-20T09:15:00+00:00",
        "reserved_till": "2024-04-24T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "40d03483-0bb1-4b1d-9a0c-a6876314b060",
        "item_id": "66e5f604-15f5-4c12-9595-515c6876012e",
        "start_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42",
        "stop_location_id": "09a3bc2a-a947-43b9-8eb4-129511976e42",
        "parent_planning_id": "4768f523-fa1e-4cfe-ab8f-37c55bed3843",
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "afba2778-57fb-49e5-92df-d9824a898ece",
          "items": [
            {
              "type": "products",
              "id": "5e1efed2-cae8-4f03-a958-57362325b7ca",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "eef56050-a98e-453f-bf2f-46d12c178603",
              "stock_item_ids": [
                "9f8587c9-1153-4c5b-ae98-f0ef9563fdd3",
                "e85670ac-23ae-46d2-91ab-c363bf4418f6"
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
          "stock_item_id 9f8587c9-1153-4c5b-ae98-f0ef9563fdd3 has already been booked on this order"
        ]
      }
    }
  ]
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





