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
          "order_id": "dd25384b-ba1f-4520-988a-8baa12ef2105",
          "items": [
            {
              "type": "products",
              "id": "2e4fbb3c-49bc-4c04-a545-e4af467f6a83",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1b0510ff-942b-46a8-9208-4c351dbda391",
              "stock_item_ids": [
                "c7812405-6745-4110-848c-9b1134e482e1",
                "6a61496b-51c0-4a12-81ea-69919ea64e70"
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
            "item_id": "2e4fbb3c-49bc-4c04-a545-e4af467f6a83",
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
          "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
          "items": [
            {
              "type": "products",
              "id": "5e4f7def-0395-459e-8cc1-caac68222857",
              "stock_item_ids": [
                "8e607ada-cf1a-4630-8c0d-17ee4b7f8269",
                "6702eab6-75c4-4f7c-b821-aa6f295304d0",
                "f982b6d4-cfb2-4cf6-bdbb-b2c1e0d7c213"
              ]
            },
            {
              "type": "products",
              "id": "9dcaf3ad-3aec-4442-8d9b-cefb683bd689",
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
    "id": "882c189b-f946-5de3-a66c-7ce12d979097",
    "type": "order_bookings",
    "attributes": {
      "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4beeb3cb-691a-4e60-95eb-6424aba44695"
          },
          {
            "type": "lines",
            "id": "7307eba4-3b2d-4cfe-a9f1-0e087fcc1c68"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9706d302-13a6-4aae-b54e-3fc42783de23"
          },
          {
            "type": "plannings",
            "id": "dccc9378-ccf1-4094-9fad-dd5a92a8e23a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "aeff5bb4-90b1-4106-ae34-7ed1d3544268"
          },
          {
            "type": "stock_item_plannings",
            "id": "2e42e7ed-a3b1-471e-8a56-3c5fcb4264ff"
          },
          {
            "type": "stock_item_plannings",
            "id": "431cddfe-8f58-4d52-9164-947a1ff9a050"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T14:28:44+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
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
        "customer_id": "4df562e9-17c4-4373-be50-4f229cce85ff",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945",
        "stop_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945"
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
      "id": "4beeb3cb-691a-4e60-95eb-6424aba44695",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:28:46+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
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
        "item_id": "5e4f7def-0395-459e-8cc1-caac68222857",
        "tax_category_id": "7020b022-7232-424e-899e-133adf81edc3",
        "planning_id": "9706d302-13a6-4aae-b54e-3fc42783de23",
        "parent_line_id": null,
        "owner_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
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
      "id": "7307eba4-3b2d-4cfe-a9f1-0e087fcc1c68",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:28:46+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
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
        "item_id": "9dcaf3ad-3aec-4442-8d9b-cefb683bd689",
        "tax_category_id": "7020b022-7232-424e-899e-133adf81edc3",
        "planning_id": "dccc9378-ccf1-4094-9fad-dd5a92a8e23a",
        "parent_line_id": null,
        "owner_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
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
      "id": "9706d302-13a6-4aae-b54e-3fc42783de23",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:45+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
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
        "item_id": "5e4f7def-0395-459e-8cc1-caac68222857",
        "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
        "start_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945",
        "stop_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945",
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
      "id": "dccc9378-ccf1-4094-9fad-dd5a92a8e23a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:45+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
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
        "item_id": "9dcaf3ad-3aec-4442-8d9b-cefb683bd689",
        "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd",
        "start_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945",
        "stop_location_id": "7ecbdb9d-98bf-43fc-9816-745622825945",
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
      "id": "aeff5bb4-90b1-4106-ae34-7ed1d3544268",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:45+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e607ada-cf1a-4630-8c0d-17ee4b7f8269",
        "planning_id": "9706d302-13a6-4aae-b54e-3fc42783de23",
        "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd"
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
      "id": "2e42e7ed-a3b1-471e-8a56-3c5fcb4264ff",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:45+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6702eab6-75c4-4f7c-b821-aa6f295304d0",
        "planning_id": "9706d302-13a6-4aae-b54e-3fc42783de23",
        "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd"
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
      "id": "431cddfe-8f58-4d52-9164-947a1ff9a050",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:45+00:00",
        "updated_at": "2023-02-02T14:28:46+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f982b6d4-cfb2-4cf6-bdbb-b2c1e0d7c213",
        "planning_id": "9706d302-13a6-4aae-b54e-3fc42783de23",
        "order_id": "59b419ec-6d86-4dfc-9eb0-657f345ca2bd"
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
          "order_id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e",
          "items": [
            {
              "type": "bundles",
              "id": "43ef4a1f-1171-440b-90da-89279063dc97",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0a0ec3c7-9bd3-4a68-889b-382389a0a414",
                  "id": "741982da-d9cb-43e5-b9c0-05edfd334eed"
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
    "id": "72368a6a-8789-511a-9d80-18eaa6675d8b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "290f4793-254c-4e15-ba73-52a85b18cd94"
          },
          {
            "type": "lines",
            "id": "18e76709-2a4b-4558-9695-9e488d7f8d71"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "be819f2a-c781-4b57-8708-09e17384ee35"
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
      "id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-02T14:28:48+00:00",
        "updated_at": "2023-02-02T14:28:49+00:00",
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
        "starts_at": "2023-01-31T14:15:00+00:00",
        "stops_at": "2023-02-04T14:15:00+00:00",
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
        "start_location_id": "afeeb2e5-d8dc-4973-acbe-41d4907198d1",
        "stop_location_id": "afeeb2e5-d8dc-4973-acbe-41d4907198d1"
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
      "id": "290f4793-254c-4e15-ba73-52a85b18cd94",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:28:49+00:00",
        "updated_at": "2023-02-02T14:28:49+00:00",
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
        "item_id": "741982da-d9cb-43e5-b9c0-05edfd334eed",
        "tax_category_id": null,
        "planning_id": "a5e878b4-50dd-43b8-bf3d-c51c9428150a",
        "parent_line_id": "18e76709-2a4b-4558-9695-9e488d7f8d71",
        "owner_id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e",
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
      "id": "18e76709-2a4b-4558-9695-9e488d7f8d71",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-02T14:28:49+00:00",
        "updated_at": "2023-02-02T14:28:49+00:00",
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
        "item_id": "43ef4a1f-1171-440b-90da-89279063dc97",
        "tax_category_id": null,
        "planning_id": "be819f2a-c781-4b57-8708-09e17384ee35",
        "parent_line_id": null,
        "owner_id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e",
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
      "id": "be819f2a-c781-4b57-8708-09e17384ee35",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-02T14:28:49+00:00",
        "updated_at": "2023-02-02T14:28:49+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-31T14:15:00+00:00",
        "stops_at": "2023-02-04T14:15:00+00:00",
        "reserved_from": "2023-01-31T14:15:00+00:00",
        "reserved_till": "2023-02-04T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "43ef4a1f-1171-440b-90da-89279063dc97",
        "order_id": "5d6caa24-4628-4a16-b2f3-ad136f7b954e",
        "start_location_id": "afeeb2e5-d8dc-4973-acbe-41d4907198d1",
        "stop_location_id": "afeeb2e5-d8dc-4973-acbe-41d4907198d1",
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





