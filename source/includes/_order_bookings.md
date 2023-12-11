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
          "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
          "items": [
            {
              "type": "bundles",
              "id": "5df141f7-9ab1-404f-a801-261b65767aca",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "167ac53a-2dc3-4eaf-94cb-3b41ec6dd170",
                  "id": "93545eeb-3765-4c63-9873-2b9fdbc32300"
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
    "id": "826f9a9e-3e8d-57d1-8373-de94e808e73d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "75e317c4-b666-4240-982b-14e6af8060bb"
          },
          {
            "type": "lines",
            "id": "cc3b0fa1-3ec7-4699-ba9b-98a4873d80df"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "539796c0-87a5-4a7b-a3c0-f813994fca52"
          },
          {
            "type": "plannings",
            "id": "44dc7d9c-936b-46b1-ad39-bd89fe16639d"
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
      "id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-11T15:32:34+00:00",
        "updated_at": "2023-12-11T15:32:35+00:00",
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
        "starts_at": "2023-12-09T15:30:00+00:00",
        "stops_at": "2023-12-13T15:30:00+00:00",
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
        "start_location_id": "83594ead-8257-4932-9aa2-33530d04e84c",
        "stop_location_id": "83594ead-8257-4932-9aa2-33530d04e84c"
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
      "id": "75e317c4-b666-4240-982b-14e6af8060bb",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-11T15:32:35+00:00",
        "updated_at": "2023-12-11T15:32:35+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000044 - red",
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
        "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
        "item_id": "93545eeb-3765-4c63-9873-2b9fdbc32300",
        "tax_category_id": null,
        "planning_id": "44dc7d9c-936b-46b1-ad39-bd89fe16639d",
        "parent_line_id": "cc3b0fa1-3ec7-4699-ba9b-98a4873d80df",
        "owner_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
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
      "id": "cc3b0fa1-3ec7-4699-ba9b-98a4873d80df",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-11T15:32:35+00:00",
        "updated_at": "2023-12-11T15:32:35+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
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
        "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
        "item_id": "5df141f7-9ab1-404f-a801-261b65767aca",
        "tax_category_id": null,
        "planning_id": "539796c0-87a5-4a7b-a3c0-f813994fca52",
        "parent_line_id": null,
        "owner_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
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
      "id": "539796c0-87a5-4a7b-a3c0-f813994fca52",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:35+00:00",
        "updated_at": "2023-12-11T15:32:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-09T15:30:00+00:00",
        "stops_at": "2023-12-13T15:30:00+00:00",
        "reserved_from": "2023-12-09T15:30:00+00:00",
        "reserved_till": "2023-12-13T15:30:00+00:00",
        "reserved": false,
        "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
        "item_id": "5df141f7-9ab1-404f-a801-261b65767aca",
        "start_location_id": "83594ead-8257-4932-9aa2-33530d04e84c",
        "stop_location_id": "83594ead-8257-4932-9aa2-33530d04e84c",
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
      "id": "44dc7d9c-936b-46b1-ad39-bd89fe16639d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:35+00:00",
        "updated_at": "2023-12-11T15:32:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-09T15:30:00+00:00",
        "stops_at": "2023-12-13T15:30:00+00:00",
        "reserved_from": "2023-12-09T15:30:00+00:00",
        "reserved_till": "2023-12-13T15:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "4a7296f5-b7a7-4690-aae1-9f3941c1dcef",
        "item_id": "93545eeb-3765-4c63-9873-2b9fdbc32300",
        "start_location_id": "83594ead-8257-4932-9aa2-33530d04e84c",
        "stop_location_id": "83594ead-8257-4932-9aa2-33530d04e84c",
        "parent_planning_id": "539796c0-87a5-4a7b-a3c0-f813994fca52",
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
          "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
          "items": [
            {
              "type": "products",
              "id": "197e2f7a-2fff-48e2-85ec-c1f705b547ba",
              "stock_item_ids": [
                "20134745-ed93-4e95-9d9d-0923e7c86ce8",
                "f170c4e5-0b42-4894-a5a8-cbac8cf7b3eb",
                "90d7354d-17dd-4200-bbe4-895deb205021"
              ]
            },
            {
              "type": "products",
              "id": "1727dadf-f123-40ce-94ac-c24a0c0ce2a5",
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
    "id": "23fc9b39-3f48-5282-9ef6-3a23eb8e9046",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dfe428cf-4fcb-4d83-8806-b4195b717299"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e6a234ef-682f-410b-a638-7749624d12b7"
          },
          {
            "type": "lines",
            "id": "b2d78fd1-895e-46c9-bafd-0eb2f497cf8f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1d1cb852-b10d-42f5-8888-b311020e8d15"
          },
          {
            "type": "plannings",
            "id": "f649ae34-fab3-4ac8-afa8-c7a8f076c210"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f43e51c0-c62f-4250-b77b-2be91e719ab2"
          },
          {
            "type": "stock_item_plannings",
            "id": "53b33372-9fa7-430b-a6f7-b84d15ff7971"
          },
          {
            "type": "stock_item_plannings",
            "id": "d1a48d50-d318-4634-a6fa-07934e32fc15"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-11T15:32:36+00:00",
        "updated_at": "2023-12-11T15:32:39+00:00",
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
        "customer_id": "f1c9fee8-b5f0-4f31-b20f-e190126ae4d6",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751",
        "stop_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751"
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
      "id": "e6a234ef-682f-410b-a638-7749624d12b7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:39+00:00",
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
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
        "item_id": "197e2f7a-2fff-48e2-85ec-c1f705b547ba",
        "tax_category_id": "e21b5131-4bf5-43f4-b9c2-d046891416b4",
        "planning_id": "1d1cb852-b10d-42f5-8888-b311020e8d15",
        "parent_line_id": null,
        "owner_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
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
      "id": "b2d78fd1-895e-46c9-bafd-0eb2f497cf8f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:39+00:00",
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
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
        "item_id": "1727dadf-f123-40ce-94ac-c24a0c0ce2a5",
        "tax_category_id": "e21b5131-4bf5-43f4-b9c2-d046891416b4",
        "planning_id": "f649ae34-fab3-4ac8-afa8-c7a8f076c210",
        "parent_line_id": null,
        "owner_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
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
      "id": "1d1cb852-b10d-42f5-8888-b311020e8d15",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:38+00:00",
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
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
        "item_id": "197e2f7a-2fff-48e2-85ec-c1f705b547ba",
        "start_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751",
        "stop_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751",
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
      "id": "f649ae34-fab3-4ac8-afa8-c7a8f076c210",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:38+00:00",
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
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299",
        "item_id": "1727dadf-f123-40ce-94ac-c24a0c0ce2a5",
        "start_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751",
        "stop_location_id": "159cfc06-fb9c-460f-94a2-b84a70e03751",
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
      "id": "f43e51c0-c62f-4250-b77b-2be91e719ab2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "20134745-ed93-4e95-9d9d-0923e7c86ce8",
        "planning_id": "1d1cb852-b10d-42f5-8888-b311020e8d15",
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299"
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
      "id": "53b33372-9fa7-430b-a6f7-b84d15ff7971",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f170c4e5-0b42-4894-a5a8-cbac8cf7b3eb",
        "planning_id": "1d1cb852-b10d-42f5-8888-b311020e8d15",
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299"
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
      "id": "d1a48d50-d318-4634-a6fa-07934e32fc15",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-11T15:32:38+00:00",
        "updated_at": "2023-12-11T15:32:38+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "90d7354d-17dd-4200-bbe4-895deb205021",
        "planning_id": "1d1cb852-b10d-42f5-8888-b311020e8d15",
        "order_id": "dfe428cf-4fcb-4d83-8806-b4195b717299"
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
          "order_id": "58818d5d-bf8d-4c9a-8b51-a6677b61c908",
          "items": [
            {
              "type": "products",
              "id": "c84fba37-3258-4cd6-ab24-963b020cc273",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9fb67c12-2d7f-4e25-8196-6eb2f551d9f1",
              "stock_item_ids": [
                "16a4405c-e080-4f7b-ae90-79993c2bb0d1",
                "fba149d0-1128-4dc7-bbb5-0cece6789e3c"
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
          "stock_item_id 16a4405c-e080-4f7b-ae90-79993c2bb0d1 has already been booked on this order"
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





