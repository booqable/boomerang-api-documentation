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
          "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
          "items": [
            {
              "type": "products",
              "id": "b1e45003-3bc4-4fe5-b257-468d4b506d98",
              "stock_item_ids": [
                "1bfba264-ec19-44ea-815c-7663d0b5ced1",
                "e1f4ba12-e087-44ff-9b9d-299343209f63",
                "53008d0a-754d-427c-8064-2b0883b0b2a7"
              ]
            },
            {
              "type": "products",
              "id": "b510acb8-fa4e-4bab-86f7-2a7b610e5021",
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
    "id": "330549e8-3cbf-5a82-a2d3-9ef237302b97",
    "type": "order_bookings",
    "attributes": {
      "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "32fa30de-b819-452c-82b2-085a9ac997b3"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8d378261-d0ea-4a93-9af8-71ca52b64374"
          },
          {
            "type": "lines",
            "id": "0f789611-c834-4f17-9521-ea2d5c84f349"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0"
          },
          {
            "type": "plannings",
            "id": "6a323bf3-70bd-4d18-880d-9d636a0b5bd0"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "f55b8eee-7b57-4e73-b8ae-150612bb69f5"
          },
          {
            "type": "stock_item_plannings",
            "id": "75302caa-f700-49b6-80d3-91514a0d6e3d"
          },
          {
            "type": "stock_item_plannings",
            "id": "38070a92-82c6-43fd-b686-b41cfc4c0d09"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "32fa30de-b819-452c-82b2-085a9ac997b3",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-07T13:57:00+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
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
        "customer_id": "ea6ce81f-809d-4595-a184-624301633c03",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902",
        "stop_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902"
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
      "id": "8d378261-d0ea-4a93-9af8-71ca52b64374",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
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
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
        "item_id": "b1e45003-3bc4-4fe5-b257-468d4b506d98",
        "tax_category_id": "51f68329-3695-4b63-b66d-a40eb042c980",
        "planning_id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0",
        "parent_line_id": null,
        "owner_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
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
      "id": "0f789611-c834-4f17-9521-ea2d5c84f349",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
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
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
        "item_id": "b510acb8-fa4e-4bab-86f7-2a7b610e5021",
        "tax_category_id": "51f68329-3695-4b63-b66d-a40eb042c980",
        "planning_id": "6a323bf3-70bd-4d18-880d-9d636a0b5bd0",
        "parent_line_id": null,
        "owner_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
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
      "id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
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
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
        "item_id": "b1e45003-3bc4-4fe5-b257-468d4b506d98",
        "start_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902",
        "stop_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902",
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
      "id": "6a323bf3-70bd-4d18-880d-9d636a0b5bd0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
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
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3",
        "item_id": "b510acb8-fa4e-4bab-86f7-2a7b610e5021",
        "start_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902",
        "stop_location_id": "e1d096aa-9110-45a6-8e3c-d83d0c30f902",
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
      "id": "f55b8eee-7b57-4e73-b8ae-150612bb69f5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1bfba264-ec19-44ea-815c-7663d0b5ced1",
        "planning_id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0",
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3"
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
      "id": "75302caa-f700-49b6-80d3-91514a0d6e3d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e1f4ba12-e087-44ff-9b9d-299343209f63",
        "planning_id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0",
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3"
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
      "id": "38070a92-82c6-43fd-b686-b41cfc4c0d09",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:02+00:00",
        "updated_at": "2023-12-07T13:57:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "53008d0a-754d-427c-8064-2b0883b0b2a7",
        "planning_id": "2b6fa24d-3b13-4361-a5aa-6801a9c5b1a0",
        "order_id": "32fa30de-b819-452c-82b2-085a9ac997b3"
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
          "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
          "items": [
            {
              "type": "bundles",
              "id": "ba069909-a5c6-44e3-9926-ed01429f2c42",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "c3bed443-34cb-4285-ab35-02c84c1e2ac5",
                  "id": "fefb944c-f4c6-4f79-8817-beb74624c03c"
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
    "id": "a9160c69-5618-567f-92bd-1d35107f67d3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5a030a48-412a-4bc4-87a6-01f888dd506c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3b463d3a-16d6-49f6-82d8-8e5490fe4ca4"
          },
          {
            "type": "lines",
            "id": "fd268cc4-d121-4cac-8bf3-1de7283449d4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d254fed3-e500-4181-bf25-dd34a9eb0cc2"
          },
          {
            "type": "plannings",
            "id": "7a55d027-f1ac-4501-8022-068654752a8b"
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
      "id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-07T13:57:05+00:00",
        "updated_at": "2023-12-07T13:57:05+00:00",
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
        "starts_at": "2023-12-05T13:45:00+00:00",
        "stops_at": "2023-12-09T13:45:00+00:00",
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
        "start_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7",
        "stop_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7"
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
      "id": "3b463d3a-16d6-49f6-82d8-8e5490fe4ca4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T13:57:06+00:00",
        "updated_at": "2023-12-07T13:57:06+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000037 - red",
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
        "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
        "item_id": "fefb944c-f4c6-4f79-8817-beb74624c03c",
        "tax_category_id": null,
        "planning_id": "7a55d027-f1ac-4501-8022-068654752a8b",
        "parent_line_id": "fd268cc4-d121-4cac-8bf3-1de7283449d4",
        "owner_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
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
      "id": "fd268cc4-d121-4cac-8bf3-1de7283449d4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T13:57:06+00:00",
        "updated_at": "2023-12-07T13:57:06+00:00",
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
        "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
        "item_id": "ba069909-a5c6-44e3-9926-ed01429f2c42",
        "tax_category_id": null,
        "planning_id": "d254fed3-e500-4181-bf25-dd34a9eb0cc2",
        "parent_line_id": null,
        "owner_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
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
      "id": "d254fed3-e500-4181-bf25-dd34a9eb0cc2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:05+00:00",
        "updated_at": "2023-12-07T13:57:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-05T13:45:00+00:00",
        "stops_at": "2023-12-09T13:45:00+00:00",
        "reserved_from": "2023-12-05T13:45:00+00:00",
        "reserved_till": "2023-12-09T13:45:00+00:00",
        "reserved": false,
        "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
        "item_id": "ba069909-a5c6-44e3-9926-ed01429f2c42",
        "start_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7",
        "stop_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7",
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
      "id": "7a55d027-f1ac-4501-8022-068654752a8b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T13:57:05+00:00",
        "updated_at": "2023-12-07T13:57:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-05T13:45:00+00:00",
        "stops_at": "2023-12-09T13:45:00+00:00",
        "reserved_from": "2023-12-05T13:45:00+00:00",
        "reserved_till": "2023-12-09T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "5a030a48-412a-4bc4-87a6-01f888dd506c",
        "item_id": "fefb944c-f4c6-4f79-8817-beb74624c03c",
        "start_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7",
        "stop_location_id": "4521ecf1-0f8f-4a7d-901e-bd6b571053f7",
        "parent_planning_id": "d254fed3-e500-4181-bf25-dd34a9eb0cc2",
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
          "order_id": "114a8982-32ba-4568-946a-66a6a5a5b932",
          "items": [
            {
              "type": "products",
              "id": "511ca7fc-9b66-47d9-8ec8-9c5bc5e91829",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1cc7f45d-62fc-4147-b5de-8ccb47947531",
              "stock_item_ids": [
                "5967fefb-8539-4b9e-b9ac-9a43c5de4ce8",
                "79200176-6f0f-4718-acbb-297463691b48"
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
          "stock_item_id 5967fefb-8539-4b9e-b9ac-9a43c5de4ce8 has already been booked on this order"
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





