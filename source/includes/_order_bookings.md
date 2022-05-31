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
          "order_id": "b184231b-6b01-4e61-a68b-6d3e1389f90a",
          "items": [
            {
              "type": "products",
              "id": "10cb921b-3fac-4234-b08b-584d7d408a92",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b0b11c38-4314-447f-9270-c604babaf8f4",
              "stock_item_ids": [
                "9be37f9e-9a78-4852-94b2-8607d7a16d17",
                "83a75142-e68a-4786-84ff-8e1b29fa2878"
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
            "item_id": "10cb921b-3fac-4234-b08b-584d7d408a92",
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
          "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
          "items": [
            {
              "type": "products",
              "id": "74d376fb-d8d0-4dd5-94e8-56853f3c8d40",
              "stock_item_ids": [
                "4529e379-8c36-4503-9074-6ea9111db2eb",
                "bff36b14-29fa-42f5-892e-c072b12d7d5e",
                "34c07208-a8b8-4c04-8d8e-e1245fa8d67f"
              ]
            },
            {
              "type": "products",
              "id": "bc8064e5-7556-4730-a789-d6b88fba23d5",
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
    "id": "ba65f383-be6c-5050-9e04-f81f64fb9401",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7989d344-851c-4f30-ace9-eff032ca5c4a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cb472f2e-02e9-4981-8f96-774abd344a73"
          },
          {
            "type": "lines",
            "id": "8f7b266f-862f-4924-a5ea-eeff33c99a13"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "150dfc1c-e0bf-4076-9fba-6fdb96afe970"
          },
          {
            "type": "plannings",
            "id": "781215b3-ed4a-429b-9b79-fc3d2023be6f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1c72ec8c-c28b-447d-9b8b-139b2618b1e1"
          },
          {
            "type": "stock_item_plannings",
            "id": "0fc9d7ff-f226-4df0-99dc-f2656935990c"
          },
          {
            "type": "stock_item_plannings",
            "id": "0f07f2aa-072f-49cd-b757-63759347f18e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-31T08:26:44+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
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
        "customer_id": "f977e690-7619-4a45-b540-6c918e12e752",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f",
        "stop_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f"
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
      "id": "cb472f2e-02e9-4981-8f96-774abd344a73",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T08:26:44+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
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
        "item_id": "bc8064e5-7556-4730-a789-d6b88fba23d5",
        "tax_category_id": "2be538e2-dcef-4c34-bd2f-dc43c916c13c",
        "planning_id": "150dfc1c-e0bf-4076-9fba-6fdb96afe970",
        "parent_line_id": null,
        "owner_id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
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
      "id": "8f7b266f-862f-4924-a5ea-eeff33c99a13",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T08:26:45+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
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
        "item_id": "74d376fb-d8d0-4dd5-94e8-56853f3c8d40",
        "tax_category_id": "2be538e2-dcef-4c34-bd2f-dc43c916c13c",
        "planning_id": "781215b3-ed4a-429b-9b79-fc3d2023be6f",
        "parent_line_id": null,
        "owner_id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
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
      "id": "150dfc1c-e0bf-4076-9fba-6fdb96afe970",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:44+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
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
        "item_id": "bc8064e5-7556-4730-a789-d6b88fba23d5",
        "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
        "start_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f",
        "stop_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f",
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
      "id": "781215b3-ed4a-429b-9b79-fc3d2023be6f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:45+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
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
        "item_id": "74d376fb-d8d0-4dd5-94e8-56853f3c8d40",
        "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a",
        "start_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f",
        "stop_location_id": "0c40b93a-93b7-4ed4-94b5-4bb38d190d8f",
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
      "id": "1c72ec8c-c28b-447d-9b8b-139b2618b1e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:45+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4529e379-8c36-4503-9074-6ea9111db2eb",
        "planning_id": "781215b3-ed4a-429b-9b79-fc3d2023be6f",
        "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a"
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
      "id": "0fc9d7ff-f226-4df0-99dc-f2656935990c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:45+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bff36b14-29fa-42f5-892e-c072b12d7d5e",
        "planning_id": "781215b3-ed4a-429b-9b79-fc3d2023be6f",
        "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a"
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
      "id": "0f07f2aa-072f-49cd-b757-63759347f18e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:45+00:00",
        "updated_at": "2022-05-31T08:26:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "34c07208-a8b8-4c04-8d8e-e1245fa8d67f",
        "planning_id": "781215b3-ed4a-429b-9b79-fc3d2023be6f",
        "order_id": "7989d344-851c-4f30-ace9-eff032ca5c4a"
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
          "order_id": "08e8e137-8ea5-4f5a-acea-eae635036114",
          "items": [
            {
              "type": "bundles",
              "id": "7c2541f4-e5a4-460b-8040-7ec5eac55fc7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "92d42d36-0cc9-4334-9979-c38e4458216e",
                  "id": "f8faa543-43c9-4c44-bd8b-dec4e4443a49"
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
    "id": "276f7602-27dc-5c9b-ade2-9b63e2d23f3e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "08e8e137-8ea5-4f5a-acea-eae635036114"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "08e8e137-8ea5-4f5a-acea-eae635036114"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "32e92c98-be55-448a-a576-49ac07751d88"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c6414b58-2799-4bc1-a785-090abddd89f4"
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
      "id": "08e8e137-8ea5-4f5a-acea-eae635036114",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-31T08:26:47+00:00",
        "updated_at": "2022-05-31T08:26:48+00:00",
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
        "starts_at": "2022-05-29T08:15:00+00:00",
        "stops_at": "2022-06-02T08:15:00+00:00",
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
        "start_location_id": "029281ff-a310-4cf5-8283-253d92fce88b",
        "stop_location_id": "029281ff-a310-4cf5-8283-253d92fce88b"
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
      "id": "32e92c98-be55-448a-a576-49ac07751d88",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-31T08:26:47+00:00",
        "updated_at": "2022-05-31T08:26:48+00:00",
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
        "item_id": "7c2541f4-e5a4-460b-8040-7ec5eac55fc7",
        "tax_category_id": null,
        "planning_id": "c6414b58-2799-4bc1-a785-090abddd89f4",
        "parent_line_id": null,
        "owner_id": "08e8e137-8ea5-4f5a-acea-eae635036114",
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
      "id": "c6414b58-2799-4bc1-a785-090abddd89f4",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-31T08:26:47+00:00",
        "updated_at": "2022-05-31T08:26:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-29T08:15:00+00:00",
        "stops_at": "2022-06-02T08:15:00+00:00",
        "reserved_from": "2022-05-29T08:15:00+00:00",
        "reserved_till": "2022-06-02T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "7c2541f4-e5a4-460b-8040-7ec5eac55fc7",
        "order_id": "08e8e137-8ea5-4f5a-acea-eae635036114",
        "start_location_id": "029281ff-a310-4cf5-8283-253d92fce88b",
        "stop_location_id": "029281ff-a310-4cf5-8283-253d92fce88b",
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





