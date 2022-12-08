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
          "order_id": "c796e168-165e-4ccb-8d8e-bf990b304f3d",
          "items": [
            {
              "type": "products",
              "id": "323c5ae1-5c39-4490-97d1-d05c4be87471",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8d9d8784-74b9-4583-b414-39b52d5a7b42",
              "stock_item_ids": [
                "43eaf801-c4b7-4f1e-a093-bd8809ec5429",
                "d0dc8638-b3b4-487e-b079-e671b61e552c"
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
            "item_id": "323c5ae1-5c39-4490-97d1-d05c4be87471",
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
          "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
          "items": [
            {
              "type": "products",
              "id": "471f0a24-c97c-4554-ad04-3eac81c7c45e",
              "stock_item_ids": [
                "e1ba7262-3837-418d-9b66-983d2216011f",
                "d17c0164-9f46-4fc9-a9ad-eeed3e0fa280",
                "4cdd4c54-9491-4a63-80c7-a14b78308a4c"
              ]
            },
            {
              "type": "products",
              "id": "8575a77f-e10a-4977-ad2c-948238241872",
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
    "id": "0d8db9f2-d675-5465-b143-5ba955efd233",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "efed7b35-ef69-4ff1-b124-8deedc36e988"
          },
          {
            "type": "lines",
            "id": "1a135f1d-3cf3-4d37-a231-590999791af1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5a42152d-b56f-427c-ad75-f4f567ae0549"
          },
          {
            "type": "plannings",
            "id": "f9c8e46f-9147-4ac2-bcec-d7b1c04a7b80"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "64cd4c43-e520-485c-9187-6da984989802"
          },
          {
            "type": "stock_item_plannings",
            "id": "3f6d6f93-f7e5-452f-b274-dbd44068e28f"
          },
          {
            "type": "stock_item_plannings",
            "id": "c7898231-8336-4ab6-b392-de3b9ca2abf1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-08T11:04:23+00:00",
        "updated_at": "2022-12-08T11:04:26+00:00",
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
        "customer_id": "afd5a00a-017b-44ea-88cf-c5d9ae529db0",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f",
        "stop_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f"
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
      "id": "efed7b35-ef69-4ff1-b124-8deedc36e988",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:25+00:00",
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
        "item_id": "471f0a24-c97c-4554-ad04-3eac81c7c45e",
        "tax_category_id": "7f05db25-426f-45f2-9ef7-f25867e9fd29",
        "planning_id": "5a42152d-b56f-427c-ad75-f4f567ae0549",
        "parent_line_id": null,
        "owner_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
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
      "id": "1a135f1d-3cf3-4d37-a231-590999791af1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:25+00:00",
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
        "item_id": "8575a77f-e10a-4977-ad2c-948238241872",
        "tax_category_id": "7f05db25-426f-45f2-9ef7-f25867e9fd29",
        "planning_id": "f9c8e46f-9147-4ac2-bcec-d7b1c04a7b80",
        "parent_line_id": null,
        "owner_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
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
      "id": "5a42152d-b56f-427c-ad75-f4f567ae0549",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:26+00:00",
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
        "item_id": "471f0a24-c97c-4554-ad04-3eac81c7c45e",
        "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
        "start_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f",
        "stop_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f",
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
      "id": "f9c8e46f-9147-4ac2-bcec-d7b1c04a7b80",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:26+00:00",
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
        "item_id": "8575a77f-e10a-4977-ad2c-948238241872",
        "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23",
        "start_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f",
        "stop_location_id": "63e656fd-1519-4ac9-a464-90af4d95fe9f",
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
      "id": "64cd4c43-e520-485c-9187-6da984989802",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e1ba7262-3837-418d-9b66-983d2216011f",
        "planning_id": "5a42152d-b56f-427c-ad75-f4f567ae0549",
        "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23"
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
      "id": "3f6d6f93-f7e5-452f-b274-dbd44068e28f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d17c0164-9f46-4fc9-a9ad-eeed3e0fa280",
        "planning_id": "5a42152d-b56f-427c-ad75-f4f567ae0549",
        "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23"
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
      "id": "c7898231-8336-4ab6-b392-de3b9ca2abf1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:25+00:00",
        "updated_at": "2022-12-08T11:04:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4cdd4c54-9491-4a63-80c7-a14b78308a4c",
        "planning_id": "5a42152d-b56f-427c-ad75-f4f567ae0549",
        "order_id": "9c96f9e0-e327-48eb-a0e7-94942a9ccc23"
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
          "order_id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb",
          "items": [
            {
              "type": "bundles",
              "id": "6ea4ea07-dfd8-40f8-99dd-8a6814db8006",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2d75b436-e535-4ed9-af49-8b35f3059b08",
                  "id": "bd077e2e-57e4-4525-b1f0-a80960146434"
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
    "id": "7bffe731-0ba2-5133-a288-7d70cdc2c7cd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ddad5bf3-2caa-4772-bdcd-5b4958dbd963"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "548b0b6b-0b45-4bf3-a95e-6d2a43aba455"
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
      "id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb",
      "type": "orders",
      "attributes": {
        "created_at": "2022-12-08T11:04:28+00:00",
        "updated_at": "2022-12-08T11:04:29+00:00",
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
        "starts_at": "2022-12-06T11:00:00+00:00",
        "stops_at": "2022-12-10T11:00:00+00:00",
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
        "start_location_id": "c44ece41-d342-435e-8479-3001ff54c89b",
        "stop_location_id": "c44ece41-d342-435e-8479-3001ff54c89b"
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
      "id": "ddad5bf3-2caa-4772-bdcd-5b4958dbd963",
      "type": "lines",
      "attributes": {
        "created_at": "2022-12-08T11:04:29+00:00",
        "updated_at": "2022-12-08T11:04:29+00:00",
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
        "item_id": "6ea4ea07-dfd8-40f8-99dd-8a6814db8006",
        "tax_category_id": null,
        "planning_id": "548b0b6b-0b45-4bf3-a95e-6d2a43aba455",
        "parent_line_id": null,
        "owner_id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb",
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
      "id": "548b0b6b-0b45-4bf3-a95e-6d2a43aba455",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-12-08T11:04:29+00:00",
        "updated_at": "2022-12-08T11:04:29+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-12-06T11:00:00+00:00",
        "stops_at": "2022-12-10T11:00:00+00:00",
        "reserved_from": "2022-12-06T11:00:00+00:00",
        "reserved_till": "2022-12-10T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6ea4ea07-dfd8-40f8-99dd-8a6814db8006",
        "order_id": "2c3bb19a-6073-4a8b-adee-e654bfa698eb",
        "start_location_id": "c44ece41-d342-435e-8479-3001ff54c89b",
        "stop_location_id": "c44ece41-d342-435e-8479-3001ff54c89b",
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





