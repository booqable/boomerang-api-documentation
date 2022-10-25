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
          "order_id": "cc6f937f-3989-4203-b00c-a1e1124e2b55",
          "items": [
            {
              "type": "products",
              "id": "81df0429-9b21-4017-b022-1a93e2a57556",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2a5a065e-9542-4ecf-847c-0fcf33debe94",
              "stock_item_ids": [
                "13ad77df-d09a-448a-b128-dc7bff5a46cc",
                "617faa4d-d273-4e0b-8dce-7d6d1a431342"
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
            "item_id": "81df0429-9b21-4017-b022-1a93e2a57556",
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
          "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112",
          "items": [
            {
              "type": "products",
              "id": "aecd1b97-8ace-4cb2-a5ee-032eeb8577c7",
              "stock_item_ids": [
                "a627630f-12be-4a39-9278-d727acab515a",
                "4c629c68-bd65-4d01-bd1c-59cfab0f09ea",
                "ff66dd7c-b601-4e89-8b38-3b9e6655679c"
              ]
            },
            {
              "type": "products",
              "id": "f9ccb4b5-eae4-462e-bcc5-841adeab93e6",
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
    "id": "cf1680e6-75e8-5493-b7d9-d481d59a33b1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "06720dba-2ddc-4737-a82e-b1a19435a112"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1cce814a-8f68-405c-8cc8-414327add561"
          },
          {
            "type": "lines",
            "id": "35b4d2ff-a593-4369-923c-496422df7432"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8f129e47-ba3e-4424-8e01-ba5012504e35"
          },
          {
            "type": "plannings",
            "id": "843bd7b3-68f3-4c61-8bad-c8f0e3db878d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "edb27a60-a0f2-4f28-bc53-3aa700c780b1"
          },
          {
            "type": "stock_item_plannings",
            "id": "a8c35ae4-5f9a-45c5-ab03-45f273126009"
          },
          {
            "type": "stock_item_plannings",
            "id": "3537c201-d103-4fa6-befa-7eea41562ee5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "06720dba-2ddc-4737-a82e-b1a19435a112",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T14:59:53+00:00",
        "updated_at": "2022-10-25T14:59:55+00:00",
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
        "customer_id": "bbbd2d89-8295-4e28-a6e8-74386e600b07",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df",
        "stop_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df"
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
      "id": "1cce814a-8f68-405c-8cc8-414327add561",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:54+00:00",
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
        "item_id": "aecd1b97-8ace-4cb2-a5ee-032eeb8577c7",
        "tax_category_id": "431838d9-91aa-4abd-8037-e672092ded4a",
        "planning_id": "8f129e47-ba3e-4424-8e01-ba5012504e35",
        "parent_line_id": null,
        "owner_id": "06720dba-2ddc-4737-a82e-b1a19435a112",
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
      "id": "35b4d2ff-a593-4369-923c-496422df7432",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:54+00:00",
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
        "item_id": "f9ccb4b5-eae4-462e-bcc5-841adeab93e6",
        "tax_category_id": "431838d9-91aa-4abd-8037-e672092ded4a",
        "planning_id": "843bd7b3-68f3-4c61-8bad-c8f0e3db878d",
        "parent_line_id": null,
        "owner_id": "06720dba-2ddc-4737-a82e-b1a19435a112",
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
      "id": "8f129e47-ba3e-4424-8e01-ba5012504e35",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:55+00:00",
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
        "item_id": "aecd1b97-8ace-4cb2-a5ee-032eeb8577c7",
        "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112",
        "start_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df",
        "stop_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df",
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
      "id": "843bd7b3-68f3-4c61-8bad-c8f0e3db878d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:55+00:00",
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
        "item_id": "f9ccb4b5-eae4-462e-bcc5-841adeab93e6",
        "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112",
        "start_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df",
        "stop_location_id": "b0e4cae1-7ae7-4112-98b3-c55033c453df",
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
      "id": "edb27a60-a0f2-4f28-bc53-3aa700c780b1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a627630f-12be-4a39-9278-d727acab515a",
        "planning_id": "8f129e47-ba3e-4424-8e01-ba5012504e35",
        "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112"
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
      "id": "a8c35ae4-5f9a-45c5-ab03-45f273126009",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4c629c68-bd65-4d01-bd1c-59cfab0f09ea",
        "planning_id": "8f129e47-ba3e-4424-8e01-ba5012504e35",
        "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112"
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
      "id": "3537c201-d103-4fa6-befa-7eea41562ee5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:54+00:00",
        "updated_at": "2022-10-25T14:59:54+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ff66dd7c-b601-4e89-8b38-3b9e6655679c",
        "planning_id": "8f129e47-ba3e-4424-8e01-ba5012504e35",
        "order_id": "06720dba-2ddc-4737-a82e-b1a19435a112"
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
          "order_id": "6b89308e-b438-46e4-a5b8-22c32316eda9",
          "items": [
            {
              "type": "bundles",
              "id": "af71e513-6b94-47c6-a0b0-f6af82cc298b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "78f860e1-1ddb-4001-8b29-3ea60d9d6024",
                  "id": "379c6605-6d12-41eb-9d87-e6307b533839"
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
    "id": "9c641b0d-c1f5-5d1f-a9b7-621f7b77946f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6b89308e-b438-46e4-a5b8-22c32316eda9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6b89308e-b438-46e4-a5b8-22c32316eda9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "942919a5-7263-46a9-8243-51d1af49f821"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "512c3510-1680-48ec-a49d-b0d307eb2f88"
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
      "id": "6b89308e-b438-46e4-a5b8-22c32316eda9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T14:59:57+00:00",
        "updated_at": "2022-10-25T14:59:58+00:00",
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
        "starts_at": "2022-10-23T14:45:00+00:00",
        "stops_at": "2022-10-27T14:45:00+00:00",
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
        "start_location_id": "b3a7e7ec-3625-4833-930c-67d7b6092742",
        "stop_location_id": "b3a7e7ec-3625-4833-930c-67d7b6092742"
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
      "id": "942919a5-7263-46a9-8243-51d1af49f821",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T14:59:57+00:00",
        "updated_at": "2022-10-25T14:59:57+00:00",
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
        "item_id": "af71e513-6b94-47c6-a0b0-f6af82cc298b",
        "tax_category_id": null,
        "planning_id": "512c3510-1680-48ec-a49d-b0d307eb2f88",
        "parent_line_id": null,
        "owner_id": "6b89308e-b438-46e4-a5b8-22c32316eda9",
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
      "id": "512c3510-1680-48ec-a49d-b0d307eb2f88",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T14:59:57+00:00",
        "updated_at": "2022-10-25T14:59:57+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T14:45:00+00:00",
        "stops_at": "2022-10-27T14:45:00+00:00",
        "reserved_from": "2022-10-23T14:45:00+00:00",
        "reserved_till": "2022-10-27T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "af71e513-6b94-47c6-a0b0-f6af82cc298b",
        "order_id": "6b89308e-b438-46e4-a5b8-22c32316eda9",
        "start_location_id": "b3a7e7ec-3625-4833-930c-67d7b6092742",
        "stop_location_id": "b3a7e7ec-3625-4833-930c-67d7b6092742",
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





