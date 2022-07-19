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
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


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
          "order_id": "6b0e96ea-1b94-489a-a042-88dffeb0ee71",
          "items": [
            {
              "type": "products",
              "id": "2ec8581e-f5e9-4e82-9458-09ad3775fdb4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b07eb480-6cf9-4c88-83c9-5f4ce59fb161",
              "stock_item_ids": [
                "febd9aab-c0b1-4529-be33-9a9c146720fa",
                "34835eb1-06b1-45b5-a7a7-32b445964fe6"
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
            "item_id": "2ec8581e-f5e9-4e82-9458-09ad3775fdb4",
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
          "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
          "items": [
            {
              "type": "products",
              "id": "8f0645eb-882d-4065-829b-2760b0d79298",
              "stock_item_ids": [
                "3ec06fb0-fec0-442f-8c1c-e76e7bbf2bb0",
                "629262d2-f93c-45ec-8aac-a5519e61ed4c",
                "af33c75c-479a-4a44-bde6-7e89ea5e3a64"
              ]
            },
            {
              "type": "products",
              "id": "480ac04b-1678-4bec-8ac1-fb8ddec27590",
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
    "id": "06d5e04f-0a5b-5737-aa52-79fff4ece11f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "125d66f8-0067-4e61-ba51-411df7fa1382"
          },
          {
            "type": "lines",
            "id": "f2451ff5-37f8-4e78-ad3f-65b613daef16"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "88fca626-ad77-4c24-9281-8d1463c709aa"
          },
          {
            "type": "plannings",
            "id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b27120d3-797d-4886-a5c3-e3aa36690238"
          },
          {
            "type": "stock_item_plannings",
            "id": "4583c078-e0ad-426a-8a85-76eb29c05adf"
          },
          {
            "type": "stock_item_plannings",
            "id": "acaaca5a-ba1a-432e-a9a7-5b1d044673ae"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-19T12:37:04+00:00",
        "updated_at": "2022-07-19T12:37:08+00:00",
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
        "customer_id": "198e7d22-9240-4861-9a08-267da9dd65b4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13",
        "stop_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13"
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
      "id": "125d66f8-0067-4e61-ba51-411df7fa1382",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-19T12:37:05+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 2,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 160500,
        "position": 1,
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
        "item_id": "480ac04b-1678-4bec-8ac1-fb8ddec27590",
        "tax_category_id": "0300db0b-4601-4a84-8691-591640a8560d",
        "planning_id": "88fca626-ad77-4c24-9281-8d1463c709aa",
        "parent_line_id": null,
        "owner_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
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
      "id": "f2451ff5-37f8-4e78-ad3f-65b613daef16",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-19T12:37:07+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
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
        "item_id": "8f0645eb-882d-4065-829b-2760b0d79298",
        "tax_category_id": "0300db0b-4601-4a84-8691-591640a8560d",
        "planning_id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e",
        "parent_line_id": null,
        "owner_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
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
      "id": "88fca626-ad77-4c24-9281-8d1463c709aa",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:05+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "480ac04b-1678-4bec-8ac1-fb8ddec27590",
        "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
        "start_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13",
        "stop_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13",
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
      "id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:07+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
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
        "item_id": "8f0645eb-882d-4065-829b-2760b0d79298",
        "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6",
        "start_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13",
        "stop_location_id": "f5478da8-b7d0-42f7-83eb-9f897c81bf13",
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
      "id": "b27120d3-797d-4886-a5c3-e3aa36690238",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:07+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3ec06fb0-fec0-442f-8c1c-e76e7bbf2bb0",
        "planning_id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e",
        "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6"
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
      "id": "4583c078-e0ad-426a-8a85-76eb29c05adf",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:07+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "629262d2-f93c-45ec-8aac-a5519e61ed4c",
        "planning_id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e",
        "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6"
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
      "id": "acaaca5a-ba1a-432e-a9a7-5b1d044673ae",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:07+00:00",
        "updated_at": "2022-07-19T12:37:07+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af33c75c-479a-4a44-bde6-7e89ea5e3a64",
        "planning_id": "76a4d5e4-d2c9-4031-bc6b-9ac71c62969e",
        "order_id": "f74bc72d-7eda-4d4e-a0f7-2b8a871e99c6"
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
          "order_id": "e1893207-0e2f-4259-a4e1-952e2e71aec7",
          "items": [
            {
              "type": "bundles",
              "id": "ffa1427c-dec6-47d8-97ec-4ffb9d7c5869",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "9c512833-5606-4676-9657-78b0d8479b33",
                  "id": "cb3bae97-4cd8-4729-a194-1e6a49a1b315"
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
    "id": "ac4d24e1-9f9d-5603-9789-1cae8bd965b4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e1893207-0e2f-4259-a4e1-952e2e71aec7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e1893207-0e2f-4259-a4e1-952e2e71aec7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "74d3810d-8bef-4cb1-a3eb-f1bc6f8a1d82"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8e95053e-b17e-42c3-949b-eca92eda83de"
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
      "id": "e1893207-0e2f-4259-a4e1-952e2e71aec7",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-19T12:37:10+00:00",
        "updated_at": "2022-07-19T12:37:11+00:00",
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
        "starts_at": "2022-07-17T12:30:00+00:00",
        "stops_at": "2022-07-21T12:30:00+00:00",
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
        "start_location_id": "3cc62ec1-1190-4db6-af8f-91125926d8bf",
        "stop_location_id": "3cc62ec1-1190-4db6-af8f-91125926d8bf"
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
      "id": "74d3810d-8bef-4cb1-a3eb-f1bc6f8a1d82",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-19T12:37:11+00:00",
        "updated_at": "2022-07-19T12:37:11+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "ffa1427c-dec6-47d8-97ec-4ffb9d7c5869",
        "tax_category_id": null,
        "planning_id": "8e95053e-b17e-42c3-949b-eca92eda83de",
        "parent_line_id": null,
        "owner_id": "e1893207-0e2f-4259-a4e1-952e2e71aec7",
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
      "id": "8e95053e-b17e-42c3-949b-eca92eda83de",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-19T12:37:11+00:00",
        "updated_at": "2022-07-19T12:37:11+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-17T12:30:00+00:00",
        "stops_at": "2022-07-21T12:30:00+00:00",
        "reserved_from": "2022-07-17T12:30:00+00:00",
        "reserved_till": "2022-07-21T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ffa1427c-dec6-47d8-97ec-4ffb9d7c5869",
        "order_id": "e1893207-0e2f-4259-a4e1-952e2e71aec7",
        "start_location_id": "3cc62ec1-1190-4db6-af8f-91125926d8bf",
        "stop_location_id": "3cc62ec1-1190-4db6-af8f-91125926d8bf",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>
`data[attributes][items][]` | **Array**<br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





