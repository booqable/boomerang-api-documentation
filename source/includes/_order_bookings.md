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
          "order_id": "008f53b3-07cf-4c45-9e5c-cdb5d8088501",
          "items": [
            {
              "type": "products",
              "id": "20765774-77b4-4ff7-ac58-7005e6be43ec",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "82d1d979-d006-4b80-84a3-6bdb9b559a1b",
              "stock_item_ids": [
                "14532919-52ef-4d00-8d59-129ed9c838c0",
                "19ce7b82-de7a-4204-8011-ffc76da58c70"
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
            "item_id": "20765774-77b4-4ff7-ac58-7005e6be43ec",
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
          "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
          "items": [
            {
              "type": "products",
              "id": "841572f3-32ba-4bb4-94c3-1bb9318adf11",
              "stock_item_ids": [
                "664e61f2-f0a2-4a51-a6c7-bafe61379440",
                "8482b405-49d9-4999-940f-7d65fe6729a3",
                "facad946-20cc-48d2-8992-6fc44b478916"
              ]
            },
            {
              "type": "products",
              "id": "d09d01ec-6094-4638-8cf7-46d9908ff0c8",
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
    "id": "91a275b6-1b2c-564f-a879-9f56258faa8c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8a2c9510-7902-4554-8d9a-3ae01fc41423"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b5ec3857-f301-4326-9e53-e447734ef5b1"
          },
          {
            "type": "lines",
            "id": "54b0b0f1-c0cc-43ad-a47c-46e94fded373"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fe39302b-17aa-4e1e-9463-599281767828"
          },
          {
            "type": "plannings",
            "id": "9bc18754-a7a7-424a-a0a9-612629004ef7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "81d0d5b5-4d7d-42de-8672-dd4c94a87553"
          },
          {
            "type": "stock_item_plannings",
            "id": "e2cce7a7-7e1b-4894-9405-445edcc3d406"
          },
          {
            "type": "stock_item_plannings",
            "id": "a086a808-81e3-4bc7-b2a9-23b95597bbcd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T14:51:47+00:00",
        "updated_at": "2023-02-07T14:51:49+00:00",
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
        "customer_id": "3e717c40-ee09-4abf-a85a-670dcd230c0f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c",
        "stop_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c"
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
      "id": "b5ec3857-f301-4326-9e53-e447734ef5b1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:49+00:00",
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
        "item_id": "841572f3-32ba-4bb4-94c3-1bb9318adf11",
        "tax_category_id": "37591b40-2ccd-475c-bf93-099573f1ec12",
        "planning_id": "fe39302b-17aa-4e1e-9463-599281767828",
        "parent_line_id": null,
        "owner_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
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
      "id": "54b0b0f1-c0cc-43ad-a47c-46e94fded373",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:49+00:00",
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
        "item_id": "d09d01ec-6094-4638-8cf7-46d9908ff0c8",
        "tax_category_id": "37591b40-2ccd-475c-bf93-099573f1ec12",
        "planning_id": "9bc18754-a7a7-424a-a0a9-612629004ef7",
        "parent_line_id": null,
        "owner_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
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
      "id": "fe39302b-17aa-4e1e-9463-599281767828",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:49+00:00",
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
        "item_id": "841572f3-32ba-4bb4-94c3-1bb9318adf11",
        "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
        "start_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c",
        "stop_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c",
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
      "id": "9bc18754-a7a7-424a-a0a9-612629004ef7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:49+00:00",
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
        "item_id": "d09d01ec-6094-4638-8cf7-46d9908ff0c8",
        "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423",
        "start_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c",
        "stop_location_id": "a5a58374-af90-45ea-8cd8-59182d58a66c",
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
      "id": "81d0d5b5-4d7d-42de-8672-dd4c94a87553",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "664e61f2-f0a2-4a51-a6c7-bafe61379440",
        "planning_id": "fe39302b-17aa-4e1e-9463-599281767828",
        "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423"
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
      "id": "e2cce7a7-7e1b-4894-9405-445edcc3d406",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8482b405-49d9-4999-940f-7d65fe6729a3",
        "planning_id": "fe39302b-17aa-4e1e-9463-599281767828",
        "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423"
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
      "id": "a086a808-81e3-4bc7-b2a9-23b95597bbcd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:48+00:00",
        "updated_at": "2023-02-07T14:51:48+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "facad946-20cc-48d2-8992-6fc44b478916",
        "planning_id": "fe39302b-17aa-4e1e-9463-599281767828",
        "order_id": "8a2c9510-7902-4554-8d9a-3ae01fc41423"
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
          "order_id": "0ce97c28-c924-4be3-ae10-b71689a1983d",
          "items": [
            {
              "type": "bundles",
              "id": "9f85e58c-db19-4f0a-9c4d-cf19c833e7b3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5bde9bdb-2046-41de-b1f2-11a3ec504ddb",
                  "id": "f022afa7-744f-46d6-8940-69bc061ce385"
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
    "id": "3db5a3a0-b3ed-5625-ac74-93b8c7632fc2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0ce97c28-c924-4be3-ae10-b71689a1983d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0ce97c28-c924-4be3-ae10-b71689a1983d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4f80a181-41fa-4588-8bef-4e5cfea6e21d"
          },
          {
            "type": "lines",
            "id": "5f456fcc-d1ed-4d2a-b820-70c9d813d144"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6d98ad66-ed49-4c5f-9f39-551006d7f283"
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
      "id": "0ce97c28-c924-4be3-ae10-b71689a1983d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T14:51:51+00:00",
        "updated_at": "2023-02-07T14:51:52+00:00",
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
        "starts_at": "2023-02-05T14:45:00+00:00",
        "stops_at": "2023-02-09T14:45:00+00:00",
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
        "start_location_id": "1e28cda9-0b4e-4642-b0e3-2c471ab39058",
        "stop_location_id": "1e28cda9-0b4e-4642-b0e3-2c471ab39058"
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
      "id": "4f80a181-41fa-4588-8bef-4e5cfea6e21d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:51:51+00:00",
        "updated_at": "2023-02-07T14:51:51+00:00",
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
        "item_id": "9f85e58c-db19-4f0a-9c4d-cf19c833e7b3",
        "tax_category_id": null,
        "planning_id": "6d98ad66-ed49-4c5f-9f39-551006d7f283",
        "parent_line_id": null,
        "owner_id": "0ce97c28-c924-4be3-ae10-b71689a1983d",
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
      "id": "5f456fcc-d1ed-4d2a-b820-70c9d813d144",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T14:51:51+00:00",
        "updated_at": "2023-02-07T14:51:51+00:00",
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
        "item_id": "f022afa7-744f-46d6-8940-69bc061ce385",
        "tax_category_id": null,
        "planning_id": "7ca96c59-e8d2-48d1-bdfc-6bd123c72d95",
        "parent_line_id": "4f80a181-41fa-4588-8bef-4e5cfea6e21d",
        "owner_id": "0ce97c28-c924-4be3-ae10-b71689a1983d",
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
      "id": "6d98ad66-ed49-4c5f-9f39-551006d7f283",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T14:51:51+00:00",
        "updated_at": "2023-02-07T14:51:51+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T14:45:00+00:00",
        "stops_at": "2023-02-09T14:45:00+00:00",
        "reserved_from": "2023-02-05T14:45:00+00:00",
        "reserved_till": "2023-02-09T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9f85e58c-db19-4f0a-9c4d-cf19c833e7b3",
        "order_id": "0ce97c28-c924-4be3-ae10-b71689a1983d",
        "start_location_id": "1e28cda9-0b4e-4642-b0e3-2c471ab39058",
        "stop_location_id": "1e28cda9-0b4e-4642-b0e3-2c471ab39058",
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





