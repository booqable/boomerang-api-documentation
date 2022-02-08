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
          "order_id": "3ddff104-c27a-415d-b8da-de4180b59914",
          "items": [
            {
              "type": "products",
              "id": "6c5e17ea-955f-49f8-80ad-53e2efaf4510",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "414f4a4c-c276-4509-8b7f-bff4f1a25cc5",
              "stock_item_ids": [
                "63cf93f8-e625-4fb1-9989-e539db87b28c",
                "b4af97af-790a-4c34-84f3-91a53a8e1e2d"
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
            "item_id": "6c5e17ea-955f-49f8-80ad-53e2efaf4510",
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
          "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb",
          "items": [
            {
              "type": "products",
              "id": "c8ad7341-fe1a-47b7-8e63-d30ca3de35af",
              "stock_item_ids": [
                "35236571-8ff7-4d96-8ca7-07cf4ca07197",
                "a2870400-0efd-4c20-868e-363f77c38f0e",
                "173b4e58-aada-4383-aad7-63a1dc256923"
              ]
            },
            {
              "type": "products",
              "id": "7abfabe1-033b-4843-be1e-ffc46cf39bc5",
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
    "id": "6aaab8bb-6e42-510f-8eda-88a1f4a090e8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e007552b-6968-4753-a3d9-ba971b3baebb"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6e143767-e4fd-4ed6-a29d-823ee662b54e"
          },
          {
            "type": "lines",
            "id": "0421fd14-3355-4cfb-b899-eff2a08e1740"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3770b070-d674-4737-a6dd-f6f969e09abe"
          },
          {
            "type": "plannings",
            "id": "a4045abe-b2d4-44dc-8e82-27522e94d585"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2a5a890d-09f1-4ae6-a0f0-9a548082a8a4"
          },
          {
            "type": "stock_item_plannings",
            "id": "eb26695d-b5cc-4d05-8455-3578d0e4fde5"
          },
          {
            "type": "stock_item_plannings",
            "id": "cd197ddd-93e7-4a49-8782-64ba99eb84ef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e007552b-6968-4753-a3d9-ba971b3baebb",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-08T09:13:58+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
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
        "customer_id": "3ac0668f-c3b8-4a63-bd1c-a2860c90bc38",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e",
        "stop_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e"
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
      "id": "6e143767-e4fd-4ed6-a29d-823ee662b54e",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-08T09:13:59+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
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
        "item_id": "7abfabe1-033b-4843-be1e-ffc46cf39bc5",
        "tax_category_id": "11437feb-aa3a-471c-9272-70df82e2dab8",
        "planning_id": "3770b070-d674-4737-a6dd-f6f969e09abe",
        "parent_line_id": null,
        "owner_id": "e007552b-6968-4753-a3d9-ba971b3baebb",
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
      "id": "0421fd14-3355-4cfb-b899-eff2a08e1740",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-08T09:14:00+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
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
        "item_id": "c8ad7341-fe1a-47b7-8e63-d30ca3de35af",
        "tax_category_id": "11437feb-aa3a-471c-9272-70df82e2dab8",
        "planning_id": "a4045abe-b2d4-44dc-8e82-27522e94d585",
        "parent_line_id": null,
        "owner_id": "e007552b-6968-4753-a3d9-ba971b3baebb",
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
      "id": "3770b070-d674-4737-a6dd-f6f969e09abe",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-08T09:13:59+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
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
        "item_id": "7abfabe1-033b-4843-be1e-ffc46cf39bc5",
        "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb",
        "start_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e",
        "stop_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e",
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
      "id": "a4045abe-b2d4-44dc-8e82-27522e94d585",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-08T09:14:00+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
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
        "item_id": "c8ad7341-fe1a-47b7-8e63-d30ca3de35af",
        "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb",
        "start_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e",
        "stop_location_id": "8130c043-f2a5-4b89-b960-75b7f8a7225e",
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
      "id": "2a5a890d-09f1-4ae6-a0f0-9a548082a8a4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-08T09:14:00+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "35236571-8ff7-4d96-8ca7-07cf4ca07197",
        "planning_id": "a4045abe-b2d4-44dc-8e82-27522e94d585",
        "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb"
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
      "id": "eb26695d-b5cc-4d05-8455-3578d0e4fde5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-08T09:14:00+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a2870400-0efd-4c20-868e-363f77c38f0e",
        "planning_id": "a4045abe-b2d4-44dc-8e82-27522e94d585",
        "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb"
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
      "id": "cd197ddd-93e7-4a49-8782-64ba99eb84ef",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-08T09:14:00+00:00",
        "updated_at": "2022-02-08T09:14:00+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "173b4e58-aada-4383-aad7-63a1dc256923",
        "planning_id": "a4045abe-b2d4-44dc-8e82-27522e94d585",
        "order_id": "e007552b-6968-4753-a3d9-ba971b3baebb"
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
          "order_id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f",
          "items": [
            {
              "type": "bundles",
              "id": "182d3661-43c4-4822-87f5-ae0143ff929d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "47b12bb9-de2d-45c8-94ec-f57075297e24",
                  "id": "352ec8bb-3ca2-4f62-b900-57cbe8633818"
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
    "id": "f5929577-c044-5c7a-bdf5-00cbea7f3ab5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "66189af4-bc0b-4d79-8a37-04cc39ceacd5"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a058469e-396d-4885-a74b-3d282c39c04e"
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
      "id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-08T09:14:02+00:00",
        "updated_at": "2022-02-08T09:14:03+00:00",
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
        "starts_at": "2022-02-06T09:00:00+00:00",
        "stops_at": "2022-02-10T09:00:00+00:00",
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
        "start_location_id": "b417bbd5-988b-4533-9950-b6fe281f969c",
        "stop_location_id": "b417bbd5-988b-4533-9950-b6fe281f969c"
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
      "id": "66189af4-bc0b-4d79-8a37-04cc39ceacd5",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-08T09:14:03+00:00",
        "updated_at": "2022-02-08T09:14:03+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 1",
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
        "item_id": "182d3661-43c4-4822-87f5-ae0143ff929d",
        "tax_category_id": null,
        "planning_id": "a058469e-396d-4885-a74b-3d282c39c04e",
        "parent_line_id": null,
        "owner_id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f",
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
      "id": "a058469e-396d-4885-a74b-3d282c39c04e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-08T09:14:03+00:00",
        "updated_at": "2022-02-08T09:14:03+00:00",
        "quantity": 1,
        "starts_at": "2022-02-06T09:00:00+00:00",
        "stops_at": "2022-02-10T09:00:00+00:00",
        "reserved_from": "2022-02-06T09:00:00+00:00",
        "reserved_till": "2022-02-10T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "182d3661-43c4-4822-87f5-ae0143ff929d",
        "order_id": "e24bf87a-1217-4ed8-856d-fa8bd3c4941f",
        "start_location_id": "b417bbd5-988b-4533-9950-b6fe281f969c",
        "stop_location_id": "b417bbd5-988b-4533-9950-b6fe281f969c",
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





