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
          "order_id": "a85b7776-5a34-4145-850c-94ab53014495",
          "items": [
            {
              "type": "products",
              "id": "85efcf7d-b75b-4814-a2a5-05f0e7f6744c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c90f29c4-7569-474d-bbb9-e65273c43e89",
              "stock_item_ids": [
                "88e46005-2580-4707-8493-872c8d300d40",
                "ec2b023e-ecc7-417f-8645-baf070b6a59e"
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
            "item_id": "85efcf7d-b75b-4814-a2a5-05f0e7f6744c",
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
          "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
          "items": [
            {
              "type": "products",
              "id": "64658610-27a8-40be-a88e-4343d6aa6a0a",
              "stock_item_ids": [
                "e78fe25b-3cc1-4144-b7a8-0587934dd862",
                "0d8cbbc0-f74b-44b7-b100-6941d8798f79",
                "2e5c086b-1199-4e3f-a4a8-50c81d6b0760"
              ]
            },
            {
              "type": "products",
              "id": "0455c855-89cb-477a-b203-571f6ddc7a0f",
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
    "id": "94447daa-f9c1-5af4-8be3-42ae9ed93041",
    "type": "order_bookings",
    "attributes": {
      "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "151a94ff-701f-4bf2-8b44-7c77f4c34563"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "095cce32-9fcd-4088-a77a-3fb31876b79a"
          },
          {
            "type": "lines",
            "id": "5ccbd573-01fa-4072-85de-1cfaf99fd3c3"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e"
          },
          {
            "type": "plannings",
            "id": "5e729f8f-5d04-456e-b7f0-52f69c41992e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d89b6e81-1825-4fa8-8cb9-2ab7af2bdc67"
          },
          {
            "type": "stock_item_plannings",
            "id": "c808acbe-a7a6-4d39-883c-20466e5995e3"
          },
          {
            "type": "stock_item_plannings",
            "id": "fbcfe3d4-91ab-453a-8825-9d1559db3324"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T14:34:15+00:00",
        "updated_at": "2022-11-22T14:34:17+00:00",
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
        "customer_id": "c4ddacf5-46f2-4990-a4fa-46f1744a8927",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635",
        "stop_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635"
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
      "id": "095cce32-9fcd-4088-a77a-3fb31876b79a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:17+00:00",
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
        "item_id": "64658610-27a8-40be-a88e-4343d6aa6a0a",
        "tax_category_id": "e2d37076-15d5-4975-9bcf-ddc8c6a06fb5",
        "planning_id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e",
        "parent_line_id": null,
        "owner_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
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
      "id": "5ccbd573-01fa-4072-85de-1cfaf99fd3c3",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:17+00:00",
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
        "item_id": "0455c855-89cb-477a-b203-571f6ddc7a0f",
        "tax_category_id": "e2d37076-15d5-4975-9bcf-ddc8c6a06fb5",
        "planning_id": "5e729f8f-5d04-456e-b7f0-52f69c41992e",
        "parent_line_id": null,
        "owner_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
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
      "id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:17+00:00",
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
        "item_id": "64658610-27a8-40be-a88e-4343d6aa6a0a",
        "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
        "start_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635",
        "stop_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635",
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
      "id": "5e729f8f-5d04-456e-b7f0-52f69c41992e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:17+00:00",
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
        "item_id": "0455c855-89cb-477a-b203-571f6ddc7a0f",
        "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563",
        "start_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635",
        "stop_location_id": "e30cf981-ffc4-45f8-9cf3-8b227cdbf635",
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
      "id": "d89b6e81-1825-4fa8-8cb9-2ab7af2bdc67",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e78fe25b-3cc1-4144-b7a8-0587934dd862",
        "planning_id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e",
        "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563"
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
      "id": "c808acbe-a7a6-4d39-883c-20466e5995e3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0d8cbbc0-f74b-44b7-b100-6941d8798f79",
        "planning_id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e",
        "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563"
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
      "id": "fbcfe3d4-91ab-453a-8825-9d1559db3324",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:16+00:00",
        "updated_at": "2022-11-22T14:34:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2e5c086b-1199-4e3f-a4a8-50c81d6b0760",
        "planning_id": "c5b349d6-e365-40cc-bc6e-82e81e6c8e7e",
        "order_id": "151a94ff-701f-4bf2-8b44-7c77f4c34563"
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
          "order_id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa",
          "items": [
            {
              "type": "bundles",
              "id": "41124ea1-b3a4-4933-b362-7508c782ff74",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "935bd7cb-bdb3-4773-a692-39212e2e9584",
                  "id": "dae44fa1-e000-45b8-bc07-6aa32674dbcf"
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
    "id": "bdff4d15-e67a-54de-a280-c3c21111ffc5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d17d29cf-5933-40fa-8dfc-4ac6705aae38"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c75c1ae0-b29b-4727-b90b-193f91c62d41"
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
      "id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-22T14:34:19+00:00",
        "updated_at": "2022-11-22T14:34:20+00:00",
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
        "starts_at": "2022-11-20T14:30:00+00:00",
        "stops_at": "2022-11-24T14:30:00+00:00",
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
        "start_location_id": "24456041-6fd3-409a-ab97-3f859184d985",
        "stop_location_id": "24456041-6fd3-409a-ab97-3f859184d985"
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
      "id": "d17d29cf-5933-40fa-8dfc-4ac6705aae38",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-22T14:34:20+00:00",
        "updated_at": "2022-11-22T14:34:20+00:00",
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
        "item_id": "41124ea1-b3a4-4933-b362-7508c782ff74",
        "tax_category_id": null,
        "planning_id": "c75c1ae0-b29b-4727-b90b-193f91c62d41",
        "parent_line_id": null,
        "owner_id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa",
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
      "id": "c75c1ae0-b29b-4727-b90b-193f91c62d41",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-22T14:34:19+00:00",
        "updated_at": "2022-11-22T14:34:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-20T14:30:00+00:00",
        "stops_at": "2022-11-24T14:30:00+00:00",
        "reserved_from": "2022-11-20T14:30:00+00:00",
        "reserved_till": "2022-11-24T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "41124ea1-b3a4-4933-b362-7508c782ff74",
        "order_id": "47c0ce4f-17eb-40be-9533-08cca2fe0afa",
        "start_location_id": "24456041-6fd3-409a-ab97-3f859184d985",
        "stop_location_id": "24456041-6fd3-409a-ab97-3f859184d985",
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





