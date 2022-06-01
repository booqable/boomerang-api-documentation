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
          "order_id": "741eb92e-9540-4ccf-9821-f6a606c4f7a1",
          "items": [
            {
              "type": "products",
              "id": "f02764e1-d946-40ea-9ca7-434284d1f353",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2f2d21af-9981-43e2-8e41-7407d89d1479",
              "stock_item_ids": [
                "8cd9cac6-9ce5-4d77-b02f-27513748a93c",
                "0985bb17-749b-4027-b513-6a89ec1627c3"
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
            "item_id": "f02764e1-d946-40ea-9ca7-434284d1f353",
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
          "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
          "items": [
            {
              "type": "products",
              "id": "5e979276-071b-405b-b89a-504652474cb2",
              "stock_item_ids": [
                "f07a5628-d3d6-4ac5-9d6d-03e9e04b5f66",
                "6fad70bc-f4f3-4c6e-88ce-67a5fa9640ab",
                "0b5e76cd-91ea-4661-9a84-dd48c03dc4a0"
              ]
            },
            {
              "type": "products",
              "id": "542fc533-b5f4-492b-9639-bbd1ebce84a5",
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
    "id": "610ddd13-50a6-5ba5-add9-e1952e0d88c1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ef2c7582-271e-49b1-875b-38248a3fdd42"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "345fd8f1-89ce-4e99-b3b4-f00b81eeaae1"
          },
          {
            "type": "lines",
            "id": "6003ea5f-44b8-4f0d-8359-c9e7a5ddc835"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "522f7c77-8406-47f5-88b4-54fcc7f46af0"
          },
          {
            "type": "plannings",
            "id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c516d6fd-6ed8-4a5d-bc5a-1979d2c8dc8e"
          },
          {
            "type": "stock_item_plannings",
            "id": "99567e29-e602-499f-90a5-7b1fc73be56d"
          },
          {
            "type": "stock_item_plannings",
            "id": "8b382c1c-591e-4915-b1a9-8a47ccb8b577"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-01T08:56:48+00:00",
        "updated_at": "2022-06-01T08:56:51+00:00",
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
        "customer_id": "2f51d9c5-474a-44e6-a6b0-01706ccc0e92",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc",
        "stop_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc"
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
      "id": "345fd8f1-89ce-4e99-b3b4-f00b81eeaae1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-01T08:56:49+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
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
        "item_id": "542fc533-b5f4-492b-9639-bbd1ebce84a5",
        "tax_category_id": "ee4728e4-40b2-4a0e-a478-dc860f2a1101",
        "planning_id": "522f7c77-8406-47f5-88b4-54fcc7f46af0",
        "parent_line_id": null,
        "owner_id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
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
      "id": "6003ea5f-44b8-4f0d-8359-c9e7a5ddc835",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-01T08:56:50+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
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
        "item_id": "5e979276-071b-405b-b89a-504652474cb2",
        "tax_category_id": "ee4728e4-40b2-4a0e-a478-dc860f2a1101",
        "planning_id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847",
        "parent_line_id": null,
        "owner_id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
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
      "id": "522f7c77-8406-47f5-88b4-54fcc7f46af0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:49+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
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
        "item_id": "542fc533-b5f4-492b-9639-bbd1ebce84a5",
        "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
        "start_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc",
        "stop_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc",
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
      "id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:50+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
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
        "item_id": "5e979276-071b-405b-b89a-504652474cb2",
        "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42",
        "start_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc",
        "stop_location_id": "7c85b771-c3db-4929-842b-9f9c40a802bc",
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
      "id": "c516d6fd-6ed8-4a5d-bc5a-1979d2c8dc8e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:50+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f07a5628-d3d6-4ac5-9d6d-03e9e04b5f66",
        "planning_id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847",
        "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42"
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
      "id": "99567e29-e602-499f-90a5-7b1fc73be56d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:50+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6fad70bc-f4f3-4c6e-88ce-67a5fa9640ab",
        "planning_id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847",
        "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42"
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
      "id": "8b382c1c-591e-4915-b1a9-8a47ccb8b577",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:50+00:00",
        "updated_at": "2022-06-01T08:56:50+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0b5e76cd-91ea-4661-9a84-dd48c03dc4a0",
        "planning_id": "e5a2e3c3-70ba-4acc-a9cb-996ea4b56847",
        "order_id": "ef2c7582-271e-49b1-875b-38248a3fdd42"
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
          "order_id": "7a7cef92-6722-4ad5-9de1-676e42eaff15",
          "items": [
            {
              "type": "bundles",
              "id": "e74fa14b-02c4-4d0d-bbfa-5826406ff895",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "720ba361-20ab-4424-8db7-56b8b97c1fce",
                  "id": "32b8f20f-7dc5-4a7b-ade7-63c19a042025"
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
    "id": "1049cccd-b1b0-5d6e-a191-612b37e219c5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7a7cef92-6722-4ad5-9de1-676e42eaff15"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7a7cef92-6722-4ad5-9de1-676e42eaff15"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "62ecd771-a74d-4bca-a3e9-dc049caf766c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a14214e5-635b-4907-b867-a10a29963f9a"
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
      "id": "7a7cef92-6722-4ad5-9de1-676e42eaff15",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-01T08:56:52+00:00",
        "updated_at": "2022-06-01T08:56:54+00:00",
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
        "starts_at": "2022-05-30T08:45:00+00:00",
        "stops_at": "2022-06-03T08:45:00+00:00",
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
        "start_location_id": "dae9e019-213f-4ad4-8c61-1d152852ad67",
        "stop_location_id": "dae9e019-213f-4ad4-8c61-1d152852ad67"
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
      "id": "62ecd771-a74d-4bca-a3e9-dc049caf766c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-01T08:56:53+00:00",
        "updated_at": "2022-06-01T08:56:53+00:00",
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
        "item_id": "e74fa14b-02c4-4d0d-bbfa-5826406ff895",
        "tax_category_id": null,
        "planning_id": "a14214e5-635b-4907-b867-a10a29963f9a",
        "parent_line_id": null,
        "owner_id": "7a7cef92-6722-4ad5-9de1-676e42eaff15",
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
      "id": "a14214e5-635b-4907-b867-a10a29963f9a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-01T08:56:53+00:00",
        "updated_at": "2022-06-01T08:56:53+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-30T08:45:00+00:00",
        "stops_at": "2022-06-03T08:45:00+00:00",
        "reserved_from": "2022-05-30T08:45:00+00:00",
        "reserved_till": "2022-06-03T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e74fa14b-02c4-4d0d-bbfa-5826406ff895",
        "order_id": "7a7cef92-6722-4ad5-9de1-676e42eaff15",
        "start_location_id": "dae9e019-213f-4ad4-8c61-1d152852ad67",
        "stop_location_id": "dae9e019-213f-4ad4-8c61-1d152852ad67",
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





