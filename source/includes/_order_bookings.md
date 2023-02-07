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
          "order_id": "29139d64-be56-49e5-8c64-b50915820bdf",
          "items": [
            {
              "type": "products",
              "id": "8530c966-90fe-4520-a25e-b25a42d2a435",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0b0fa426-e8e8-4af2-aadd-b98692a5f6a0",
              "stock_item_ids": [
                "e868f66e-220f-47d5-bb82-4bf58c64b7d3",
                "9bc26368-5aa9-4f3c-b251-4c26896ff249"
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
            "item_id": "8530c966-90fe-4520-a25e-b25a42d2a435",
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
          "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
          "items": [
            {
              "type": "products",
              "id": "fc439f4b-d660-4413-818a-6a3ac4ee7b8d",
              "stock_item_ids": [
                "f5db0c9b-b402-40e3-9511-b957b71e2127",
                "c1eae07e-510d-48b9-aef4-372a033a3552",
                "cc1a1ee8-a1ce-46c1-8a4c-bdf02bb374cf"
              ]
            },
            {
              "type": "products",
              "id": "0d246941-0fb5-4dea-aa34-c6fe12da3d85",
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
    "id": "9062b6b0-3ae8-5090-93e1-958e738c34ba",
    "type": "order_bookings",
    "attributes": {
      "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "133ecd98-5822-4a2c-a767-3477c6eadbb9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ffd694e8-3df2-433c-bd71-8aeb10ed26c0"
          },
          {
            "type": "lines",
            "id": "44edd862-d51c-47de-be6e-d0c932663343"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f123adc7-539a-4295-9f2b-9dda90f61034"
          },
          {
            "type": "plannings",
            "id": "b6335d5a-476b-47e7-b16d-9bab06c46309"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "58bd2007-a2f9-4853-a1bd-2ea993336aee"
          },
          {
            "type": "stock_item_plannings",
            "id": "2c651e3c-6a57-42d3-8aa6-adc13ae5b138"
          },
          {
            "type": "stock_item_plannings",
            "id": "991482a0-26c0-42ac-8a2a-d00d037fdf62"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T16:06:03+00:00",
        "updated_at": "2023-02-07T16:06:05+00:00",
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
        "customer_id": "56a12239-a819-463a-835e-b1135fe4548c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a",
        "stop_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a"
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
      "id": "ffd694e8-3df2-433c-bd71-8aeb10ed26c0",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:04+00:00",
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
        "item_id": "fc439f4b-d660-4413-818a-6a3ac4ee7b8d",
        "tax_category_id": "06b10382-0b32-46e4-81a7-6bc3d154ec79",
        "planning_id": "f123adc7-539a-4295-9f2b-9dda90f61034",
        "parent_line_id": null,
        "owner_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
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
      "id": "44edd862-d51c-47de-be6e-d0c932663343",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:04+00:00",
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
        "item_id": "0d246941-0fb5-4dea-aa34-c6fe12da3d85",
        "tax_category_id": "06b10382-0b32-46e4-81a7-6bc3d154ec79",
        "planning_id": "b6335d5a-476b-47e7-b16d-9bab06c46309",
        "parent_line_id": null,
        "owner_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
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
      "id": "f123adc7-539a-4295-9f2b-9dda90f61034",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:05+00:00",
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
        "item_id": "fc439f4b-d660-4413-818a-6a3ac4ee7b8d",
        "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
        "start_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a",
        "stop_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a",
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
      "id": "b6335d5a-476b-47e7-b16d-9bab06c46309",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:05+00:00",
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
        "item_id": "0d246941-0fb5-4dea-aa34-c6fe12da3d85",
        "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9",
        "start_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a",
        "stop_location_id": "a2799798-e2e4-4c7a-9282-54e677100e7a",
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
      "id": "58bd2007-a2f9-4853-a1bd-2ea993336aee",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f5db0c9b-b402-40e3-9511-b957b71e2127",
        "planning_id": "f123adc7-539a-4295-9f2b-9dda90f61034",
        "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9"
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
      "id": "2c651e3c-6a57-42d3-8aa6-adc13ae5b138",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c1eae07e-510d-48b9-aef4-372a033a3552",
        "planning_id": "f123adc7-539a-4295-9f2b-9dda90f61034",
        "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9"
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
      "id": "991482a0-26c0-42ac-8a2a-d00d037fdf62",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:04+00:00",
        "updated_at": "2023-02-07T16:06:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cc1a1ee8-a1ce-46c1-8a4c-bdf02bb374cf",
        "planning_id": "f123adc7-539a-4295-9f2b-9dda90f61034",
        "order_id": "133ecd98-5822-4a2c-a767-3477c6eadbb9"
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
          "order_id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9",
          "items": [
            {
              "type": "bundles",
              "id": "82ed14db-d93d-48ca-b657-423bd5342a46",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e2fa4056-849e-4b03-b7c3-9d01ea5f9101",
                  "id": "ad737ff1-974d-4e57-9a6e-a1f20e7567c4"
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
    "id": "790e6627-0628-538c-a466-78190b33d1f3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "20bdca06-9f2c-43c8-ad6f-67c8a6e92a92"
          },
          {
            "type": "lines",
            "id": "faada026-71ff-4baf-a470-7f6ad2ce5e13"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3151bf40-0609-4400-9bd4-7ab9f880a3a4"
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
      "id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T16:06:06+00:00",
        "updated_at": "2023-02-07T16:06:07+00:00",
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
        "starts_at": "2023-02-05T16:00:00+00:00",
        "stops_at": "2023-02-09T16:00:00+00:00",
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
        "start_location_id": "e8e820b8-7978-4bde-8d7d-4390063bc88c",
        "stop_location_id": "e8e820b8-7978-4bde-8d7d-4390063bc88c"
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
      "id": "20bdca06-9f2c-43c8-ad6f-67c8a6e92a92",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T16:06:07+00:00",
        "updated_at": "2023-02-07T16:06:07+00:00",
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
        "item_id": "82ed14db-d93d-48ca-b657-423bd5342a46",
        "tax_category_id": null,
        "planning_id": "3151bf40-0609-4400-9bd4-7ab9f880a3a4",
        "parent_line_id": null,
        "owner_id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9",
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
      "id": "faada026-71ff-4baf-a470-7f6ad2ce5e13",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T16:06:07+00:00",
        "updated_at": "2023-02-07T16:06:07+00:00",
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
        "item_id": "ad737ff1-974d-4e57-9a6e-a1f20e7567c4",
        "tax_category_id": null,
        "planning_id": "a85201bd-77b2-4fec-8146-aee1e6c33b3d",
        "parent_line_id": "20bdca06-9f2c-43c8-ad6f-67c8a6e92a92",
        "owner_id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9",
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
      "id": "3151bf40-0609-4400-9bd4-7ab9f880a3a4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T16:06:07+00:00",
        "updated_at": "2023-02-07T16:06:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T16:00:00+00:00",
        "stops_at": "2023-02-09T16:00:00+00:00",
        "reserved_from": "2023-02-05T16:00:00+00:00",
        "reserved_till": "2023-02-09T16:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "82ed14db-d93d-48ca-b657-423bd5342a46",
        "order_id": "6cbb5294-6b0d-456a-87ac-0ba0d91e46b9",
        "start_location_id": "e8e820b8-7978-4bde-8d7d-4390063bc88c",
        "stop_location_id": "e8e820b8-7978-4bde-8d7d-4390063bc88c",
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





