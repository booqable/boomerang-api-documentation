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
          "order_id": "ab155fa9-ae57-4d4d-b752-fd8645fc49ff",
          "items": [
            {
              "type": "products",
              "id": "3ada16c4-13d7-47c3-8d88-3924e11a9a90",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "701b82dc-3203-4b06-aadf-ed1270ce126a",
              "stock_item_ids": [
                "420e14b9-0096-4d2a-9efb-cde183afdb21",
                "e9799a25-8a4e-4f7e-9a34-c8196655fe24"
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
            "item_id": "3ada16c4-13d7-47c3-8d88-3924e11a9a90",
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
          "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
          "items": [
            {
              "type": "products",
              "id": "131e1d8f-735c-4d6e-abeb-a45b27b96c04",
              "stock_item_ids": [
                "85447b35-7551-4507-9323-4b878f64ed1a",
                "407f0fc3-d478-4320-80b8-9742ff503c0f",
                "43117eda-7068-4526-ac44-57c59abd6429"
              ]
            },
            {
              "type": "products",
              "id": "4244754e-8148-4954-a3cf-16f55f0f3af7",
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
    "id": "e1b4fdd5-320f-5edc-8a5f-8287ec10f60c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "390d1de0-3111-4036-9058-e8b5a93a8dac"
          },
          {
            "type": "lines",
            "id": "a297d691-c79b-424a-9196-6dc177b5cf4f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "edd19a71-5d33-4cfe-b393-241f303e3092"
          },
          {
            "type": "plannings",
            "id": "8467502f-25ba-4a9c-8740-3448386927ce"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ef4d9b19-7adc-40df-9f2b-301d5d0f5ef8"
          },
          {
            "type": "stock_item_plannings",
            "id": "8501658c-5684-49c5-adca-5d793ef44153"
          },
          {
            "type": "stock_item_plannings",
            "id": "24372983-b147-4f41-916b-ae9920929889"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-15T08:06:04+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
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
        "customer_id": "b572590c-8492-4344-b5e2-bcf41cc008de",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3",
        "stop_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3"
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
      "id": "390d1de0-3111-4036-9058-e8b5a93a8dac",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
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
        "item_id": "131e1d8f-735c-4d6e-abeb-a45b27b96c04",
        "tax_category_id": "8821cc67-5a09-4b53-9ad0-6182d00625c3",
        "planning_id": "edd19a71-5d33-4cfe-b393-241f303e3092",
        "parent_line_id": null,
        "owner_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
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
      "id": "a297d691-c79b-424a-9196-6dc177b5cf4f",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
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
        "item_id": "4244754e-8148-4954-a3cf-16f55f0f3af7",
        "tax_category_id": "8821cc67-5a09-4b53-9ad0-6182d00625c3",
        "planning_id": "8467502f-25ba-4a9c-8740-3448386927ce",
        "parent_line_id": null,
        "owner_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
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
      "id": "edd19a71-5d33-4cfe-b393-241f303e3092",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
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
        "item_id": "131e1d8f-735c-4d6e-abeb-a45b27b96c04",
        "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
        "start_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3",
        "stop_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3",
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
      "id": "8467502f-25ba-4a9c-8740-3448386927ce",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
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
        "item_id": "4244754e-8148-4954-a3cf-16f55f0f3af7",
        "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c",
        "start_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3",
        "stop_location_id": "7f5e659f-6b3a-456c-9ec2-329f435143f3",
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
      "id": "ef4d9b19-7adc-40df-9f2b-301d5d0f5ef8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "85447b35-7551-4507-9323-4b878f64ed1a",
        "planning_id": "edd19a71-5d33-4cfe-b393-241f303e3092",
        "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c"
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
      "id": "8501658c-5684-49c5-adca-5d793ef44153",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "407f0fc3-d478-4320-80b8-9742ff503c0f",
        "planning_id": "edd19a71-5d33-4cfe-b393-241f303e3092",
        "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c"
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
      "id": "24372983-b147-4f41-916b-ae9920929889",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:05+00:00",
        "updated_at": "2022-11-15T08:06:05+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "43117eda-7068-4526-ac44-57c59abd6429",
        "planning_id": "edd19a71-5d33-4cfe-b393-241f303e3092",
        "order_id": "4b32a53a-4abd-4d7e-9f92-c317aa4f389c"
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
          "order_id": "22ec7d0b-4f67-4374-91da-11293571b1ae",
          "items": [
            {
              "type": "bundles",
              "id": "970f3121-5333-4fef-8a98-fcf2b5530f3d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4b50fcf7-16e8-4b7e-8966-2c5dd3f9b398",
                  "id": "5adb7910-c3c1-4699-a527-4ac7312c3a33"
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
    "id": "dd9bf4e2-533c-5be7-bfed-cbdae85da94b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "22ec7d0b-4f67-4374-91da-11293571b1ae"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "22ec7d0b-4f67-4374-91da-11293571b1ae"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1b44dfec-eed2-429e-9e95-b75a95b5abc8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "365c6379-a60a-4d56-ad8a-3d37d532db06"
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
      "id": "22ec7d0b-4f67-4374-91da-11293571b1ae",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-15T08:06:09+00:00",
        "updated_at": "2022-11-15T08:06:09+00:00",
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
        "starts_at": "2022-11-13T08:00:00+00:00",
        "stops_at": "2022-11-17T08:00:00+00:00",
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
        "start_location_id": "ad358372-597d-48e9-a63f-c04295cce67d",
        "stop_location_id": "ad358372-597d-48e9-a63f-c04295cce67d"
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
      "id": "1b44dfec-eed2-429e-9e95-b75a95b5abc8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-15T08:06:09+00:00",
        "updated_at": "2022-11-15T08:06:09+00:00",
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
        "item_id": "970f3121-5333-4fef-8a98-fcf2b5530f3d",
        "tax_category_id": null,
        "planning_id": "365c6379-a60a-4d56-ad8a-3d37d532db06",
        "parent_line_id": null,
        "owner_id": "22ec7d0b-4f67-4374-91da-11293571b1ae",
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
      "id": "365c6379-a60a-4d56-ad8a-3d37d532db06",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-15T08:06:09+00:00",
        "updated_at": "2022-11-15T08:06:09+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-13T08:00:00+00:00",
        "stops_at": "2022-11-17T08:00:00+00:00",
        "reserved_from": "2022-11-13T08:00:00+00:00",
        "reserved_till": "2022-11-17T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "970f3121-5333-4fef-8a98-fcf2b5530f3d",
        "order_id": "22ec7d0b-4f67-4374-91da-11293571b1ae",
        "start_location_id": "ad358372-597d-48e9-a63f-c04295cce67d",
        "stop_location_id": "ad358372-597d-48e9-a63f-c04295cce67d",
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





