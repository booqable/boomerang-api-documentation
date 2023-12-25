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



> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
          "items": [
            {
              "type": "bundles",
              "id": "0da0155a-00cf-40b8-9edd-d54fec0cb321",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "58453ef0-e91a-4a43-b8fc-782b19e479e3",
                  "id": "9b1ddfc7-cb15-4abf-b91a-8ff55e7635ed"
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
    "id": "c00d5fd5-cbcb-5f25-8735-8d951feaebaf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "12b587e4-c2d9-4a11-a507-887d16b77041"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "76b6bb7e-4af2-426b-9704-dcb2b7c0a192"
          },
          {
            "type": "lines",
            "id": "26c05a5e-1d8e-4e82-9b30-be3a5b245448"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "71826173-9536-4cea-9302-d8704699bfcc"
          },
          {
            "type": "plannings",
            "id": "9b7cc304-495c-4421-8dbb-f173d9dc475f"
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
      "id": "12b587e4-c2d9-4a11-a507-887d16b77041",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-25T09:14:48+00:00",
        "updated_at": "2023-12-25T09:14:49+00:00",
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
        "starts_at": "2023-12-23T09:00:00+00:00",
        "stops_at": "2023-12-27T09:00:00+00:00",
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
        "start_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0",
        "stop_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0"
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
      "id": "76b6bb7e-4af2-426b-9704-dcb2b7c0a192",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-25T09:14:49+00:00",
        "updated_at": "2023-12-25T09:14:49+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000018 - red",
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
        "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
        "item_id": "9b1ddfc7-cb15-4abf-b91a-8ff55e7635ed",
        "tax_category_id": null,
        "planning_id": "9b7cc304-495c-4421-8dbb-f173d9dc475f",
        "parent_line_id": "26c05a5e-1d8e-4e82-9b30-be3a5b245448",
        "owner_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
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
      "id": "26c05a5e-1d8e-4e82-9b30-be3a5b245448",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-25T09:14:49+00:00",
        "updated_at": "2023-12-25T09:14:49+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 4",
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
        "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
        "item_id": "0da0155a-00cf-40b8-9edd-d54fec0cb321",
        "tax_category_id": null,
        "planning_id": "71826173-9536-4cea-9302-d8704699bfcc",
        "parent_line_id": null,
        "owner_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
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
      "id": "71826173-9536-4cea-9302-d8704699bfcc",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:49+00:00",
        "updated_at": "2023-12-25T09:14:49+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-23T09:00:00+00:00",
        "stops_at": "2023-12-27T09:00:00+00:00",
        "reserved_from": "2023-12-23T09:00:00+00:00",
        "reserved_till": "2023-12-27T09:00:00+00:00",
        "reserved": false,
        "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
        "item_id": "0da0155a-00cf-40b8-9edd-d54fec0cb321",
        "start_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0",
        "stop_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0",
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
      "id": "9b7cc304-495c-4421-8dbb-f173d9dc475f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:49+00:00",
        "updated_at": "2023-12-25T09:14:49+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-23T09:00:00+00:00",
        "stops_at": "2023-12-27T09:00:00+00:00",
        "reserved_from": "2023-12-23T09:00:00+00:00",
        "reserved_till": "2023-12-27T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "12b587e4-c2d9-4a11-a507-887d16b77041",
        "item_id": "9b1ddfc7-cb15-4abf-b91a-8ff55e7635ed",
        "start_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0",
        "stop_location_id": "5dd1d415-840e-469d-b9b3-1a4afe6658b0",
        "parent_planning_id": "71826173-9536-4cea-9302-d8704699bfcc",
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


> How to add products to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
          "items": [
            {
              "type": "products",
              "id": "f0c9a81c-3686-4f34-8707-b72a4ce6dc2d",
              "stock_item_ids": [
                "ef09fc9d-5771-4ea3-a43b-c52aa69b7af6",
                "5c588f61-5b35-4c69-8fd3-2d65373d72cc",
                "3a9a51a1-b635-4fb3-bf12-b6acf47de73a"
              ]
            },
            {
              "type": "products",
              "id": "b65ff643-3306-4274-8deb-54d8deaf2ab5",
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
    "id": "7a9724ad-6f3b-5c2c-83ba-d06dd6463187",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e4f6d241-21ef-4515-8d91-20e9b53f6045"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "46b8390f-f8c6-4af7-b3bb-01420779f580"
          },
          {
            "type": "lines",
            "id": "8a318879-a1d3-46b8-830b-168bc2bc4241"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "b27158dc-e322-4ab2-a87a-8a158781d3f9"
          },
          {
            "type": "plannings",
            "id": "674132ba-411d-434a-b783-1380b8bed160"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "82e1e7e2-30e9-4778-a234-6e086761ba0b"
          },
          {
            "type": "stock_item_plannings",
            "id": "9f26cc81-c9fe-43f8-bc2d-301f5043c132"
          },
          {
            "type": "stock_item_plannings",
            "id": "257dcb1d-2b0b-4e41-bf74-e71982c3d9ca"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-25T09:14:50+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
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
        "customer_id": "5d428168-0b2e-4cdf-ac76-47a6370a8716",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567",
        "stop_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567"
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
      "id": "46b8390f-f8c6-4af7-b3bb-01420779f580",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
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
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
        "item_id": "f0c9a81c-3686-4f34-8707-b72a4ce6dc2d",
        "tax_category_id": "2206a3f8-bd0d-40f9-85ac-c560358aa8c7",
        "planning_id": "b27158dc-e322-4ab2-a87a-8a158781d3f9",
        "parent_line_id": null,
        "owner_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
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
      "id": "8a318879-a1d3-46b8-830b-168bc2bc4241",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
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
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
        "item_id": "b65ff643-3306-4274-8deb-54d8deaf2ab5",
        "tax_category_id": "2206a3f8-bd0d-40f9-85ac-c560358aa8c7",
        "planning_id": "674132ba-411d-434a-b783-1380b8bed160",
        "parent_line_id": null,
        "owner_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
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
      "id": "b27158dc-e322-4ab2-a87a-8a158781d3f9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
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
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
        "item_id": "f0c9a81c-3686-4f34-8707-b72a4ce6dc2d",
        "start_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567",
        "stop_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567",
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
      "id": "674132ba-411d-434a-b783-1380b8bed160",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
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
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045",
        "item_id": "b65ff643-3306-4274-8deb-54d8deaf2ab5",
        "start_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567",
        "stop_location_id": "2c0a3f41-d43c-48d6-9198-5510a4e43567",
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
      "id": "82e1e7e2-30e9-4778-a234-6e086761ba0b",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ef09fc9d-5771-4ea3-a43b-c52aa69b7af6",
        "planning_id": "b27158dc-e322-4ab2-a87a-8a158781d3f9",
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045"
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
      "id": "9f26cc81-c9fe-43f8-bc2d-301f5043c132",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5c588f61-5b35-4c69-8fd3-2d65373d72cc",
        "planning_id": "b27158dc-e322-4ab2-a87a-8a158781d3f9",
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045"
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
      "id": "257dcb1d-2b0b-4e41-bf74-e71982c3d9ca",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-25T09:14:52+00:00",
        "updated_at": "2023-12-25T09:14:52+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3a9a51a1-b635-4fb3-bf12-b6acf47de73a",
        "planning_id": "b27158dc-e322-4ab2-a87a-8a158781d3f9",
        "order_id": "e4f6d241-21ef-4515-8d91-20e9b53f6045"
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "2742c979-4f21-4bfd-afad-6319e881bf00",
          "items": [
            {
              "type": "products",
              "id": "2de90357-2fe8-41be-9533-fb469f3fc9c0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "196f7726-ae4e-4436-baa3-156881a52508",
              "stock_item_ids": [
                "068428e0-72f9-4f86-b670-3386707b257f",
                "7aca5b9f-8e39-484d-8067-a829d593e6e9"
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
          "stock_item_id 068428e0-72f9-4f86-b670-3386707b257f has already been booked on this order"
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





