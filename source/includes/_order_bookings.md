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
          "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
          "items": [
            {
              "type": "products",
              "id": "ac6a5e75-296c-4e46-9617-c04eef87ec80",
              "stock_item_ids": [
                "8fbd56d0-56d0-4719-b517-35049db0653c",
                "3f57d4b2-0154-4c39-b04e-fef9df9ca0b2",
                "d23b8a42-911e-475e-9185-3c3f778e4f8d"
              ]
            },
            {
              "type": "products",
              "id": "fe4f2f4e-d406-46ee-ba21-0665f608d7d8",
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
    "id": "959f0121-3ecc-5745-9d02-f6199054fea3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e8f229dd-7731-48b9-9fa1-32eaee769673"
          },
          {
            "type": "lines",
            "id": "7423fcde-b3e6-460c-bffa-4d4287fe6df9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4e6cb1af-5b4a-493b-8638-75946447aa9f"
          },
          {
            "type": "plannings",
            "id": "4c1ec572-09ad-4e94-9a23-b60a42383762"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d5a8c146-abe9-4f71-b00c-d844c83ba03a"
          },
          {
            "type": "stock_item_plannings",
            "id": "429efef6-a874-4c1f-9ea0-984168d6fa39"
          },
          {
            "type": "stock_item_plannings",
            "id": "0b79709d-494a-42dd-a933-a474d26e4cba"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-01T09:17:45+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
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
        "customer_id": "bb474a59-2648-4983-beb2-88aa59d9dbb3",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd",
        "stop_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd"
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
      "id": "e8f229dd-7731-48b9-9fa1-32eaee769673",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
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
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
        "item_id": "ac6a5e75-296c-4e46-9617-c04eef87ec80",
        "tax_category_id": "f242a97e-85f0-47e5-949a-54d317a26743",
        "planning_id": "4e6cb1af-5b4a-493b-8638-75946447aa9f",
        "parent_line_id": null,
        "owner_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
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
      "id": "7423fcde-b3e6-460c-bffa-4d4287fe6df9",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
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
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
        "item_id": "fe4f2f4e-d406-46ee-ba21-0665f608d7d8",
        "tax_category_id": "f242a97e-85f0-47e5-949a-54d317a26743",
        "planning_id": "4c1ec572-09ad-4e94-9a23-b60a42383762",
        "parent_line_id": null,
        "owner_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
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
      "id": "4e6cb1af-5b4a-493b-8638-75946447aa9f",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
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
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
        "item_id": "ac6a5e75-296c-4e46-9617-c04eef87ec80",
        "start_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd",
        "stop_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd",
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
      "id": "4c1ec572-09ad-4e94-9a23-b60a42383762",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
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
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04",
        "item_id": "fe4f2f4e-d406-46ee-ba21-0665f608d7d8",
        "start_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd",
        "stop_location_id": "babc59ae-cb56-4b1e-9b6e-e234243ed1fd",
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
      "id": "d5a8c146-abe9-4f71-b00c-d844c83ba03a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8fbd56d0-56d0-4719-b517-35049db0653c",
        "planning_id": "4e6cb1af-5b4a-493b-8638-75946447aa9f",
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04"
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
      "id": "429efef6-a874-4c1f-9ea0-984168d6fa39",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3f57d4b2-0154-4c39-b04e-fef9df9ca0b2",
        "planning_id": "4e6cb1af-5b4a-493b-8638-75946447aa9f",
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04"
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
      "id": "0b79709d-494a-42dd-a933-a474d26e4cba",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:47+00:00",
        "updated_at": "2024-01-01T09:17:47+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d23b8a42-911e-475e-9185-3c3f778e4f8d",
        "planning_id": "4e6cb1af-5b4a-493b-8638-75946447aa9f",
        "order_id": "14f93cc6-c3c9-4900-9fb4-0bf58ab51e04"
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
          "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
          "items": [
            {
              "type": "bundles",
              "id": "ab1686e6-9f63-4ff0-9e75-785201002866",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "05950a93-2b8d-49f1-9667-626f3cb50ea3",
                  "id": "3f25201b-1c15-4b24-a123-f1deefe621d6"
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
    "id": "d14621d7-ffa2-59d2-a510-7ac85c9d2cf7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a326aeb2-4c67-483a-931e-c8fde0a2e7bf"
          },
          {
            "type": "lines",
            "id": "6896693b-3981-41a2-8bf4-af311c810b16"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "575e915a-f2d0-4ec5-baef-7a25cabbd787"
          },
          {
            "type": "plannings",
            "id": "0121184c-cfcc-46cc-8740-8bd693e6f57f"
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
      "id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
      "type": "orders",
      "attributes": {
        "created_at": "2024-01-01T09:17:52+00:00",
        "updated_at": "2024-01-01T09:17:53+00:00",
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
        "starts_at": "2023-12-30T09:15:00+00:00",
        "stops_at": "2024-01-03T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
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
        "start_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9",
        "stop_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9"
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
      "id": "a326aeb2-4c67-483a-931e-c8fde0a2e7bf",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-01T09:17:53+00:00",
        "updated_at": "2024-01-01T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000035 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
        "item_id": "3f25201b-1c15-4b24-a123-f1deefe621d6",
        "tax_category_id": null,
        "planning_id": "0121184c-cfcc-46cc-8740-8bd693e6f57f",
        "parent_line_id": "6896693b-3981-41a2-8bf4-af311c810b16",
        "owner_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
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
      "id": "6896693b-3981-41a2-8bf4-af311c810b16",
      "type": "lines",
      "attributes": {
        "created_at": "2024-01-01T09:17:53+00:00",
        "updated_at": "2024-01-01T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 5",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
        "item_id": "ab1686e6-9f63-4ff0-9e75-785201002866",
        "tax_category_id": null,
        "planning_id": "575e915a-f2d0-4ec5-baef-7a25cabbd787",
        "parent_line_id": null,
        "owner_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
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
      "id": "575e915a-f2d0-4ec5-baef-7a25cabbd787",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:53+00:00",
        "updated_at": "2024-01-01T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-30T09:15:00+00:00",
        "stops_at": "2024-01-03T09:15:00+00:00",
        "reserved_from": "2023-12-30T09:15:00+00:00",
        "reserved_till": "2024-01-03T09:15:00+00:00",
        "reserved": false,
        "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
        "item_id": "ab1686e6-9f63-4ff0-9e75-785201002866",
        "start_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9",
        "stop_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9",
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
      "id": "0121184c-cfcc-46cc-8740-8bd693e6f57f",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-01-01T09:17:53+00:00",
        "updated_at": "2024-01-01T09:17:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-30T09:15:00+00:00",
        "stops_at": "2024-01-03T09:15:00+00:00",
        "reserved_from": "2023-12-30T09:15:00+00:00",
        "reserved_till": "2024-01-03T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "168c0d42-237e-4a5f-aa5e-9fd50f1f8146",
        "item_id": "3f25201b-1c15-4b24-a123-f1deefe621d6",
        "start_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9",
        "stop_location_id": "19a8b99e-3194-4073-a6d2-304b9be913a9",
        "parent_planning_id": "575e915a-f2d0-4ec5-baef-7a25cabbd787",
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
          "order_id": "124dedac-8569-445f-8f27-856c08633d5c",
          "items": [
            {
              "type": "products",
              "id": "886b40fd-cdcf-42a9-b9cd-69951fbc8df9",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4784f97d-7231-4812-9a9a-8430fccc2668",
              "stock_item_ids": [
                "03039edd-bc48-4331-ac05-07cfa9b21ddd",
                "63ec1f73-0ef7-4842-b150-1cfa58e48fa3"
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
          "stock_item_id 03039edd-bc48-4331-ac05-07cfa9b21ddd has already been booked on this order"
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





