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
          "order_id": "779d69ee-c46e-4502-bda8-d0f4d35577db",
          "items": [
            {
              "type": "products",
              "id": "157f60b5-a39c-4c1c-aea1-40c6ba036217",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d2c41578-def2-4b01-8734-de94ba40b1de",
              "stock_item_ids": [
                "d8ac3884-777b-497d-8d7f-7f7add640dd6",
                "ebfa0cea-217f-424a-9609-c6d8f69d91df"
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
            "item_id": "157f60b5-a39c-4c1c-aea1-40c6ba036217",
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
          "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce",
          "items": [
            {
              "type": "products",
              "id": "4dc316d6-9432-4240-b288-b455ef739a07",
              "stock_item_ids": [
                "251a106a-0991-4f82-a7a2-eb355bdf85c6",
                "6c506dbb-30d4-450d-bf20-78e8f945c601",
                "ac173982-32ae-4108-8bdd-01069362f5cc"
              ]
            },
            {
              "type": "products",
              "id": "36e8c70e-084a-407b-8c88-3eb93d480e07",
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
    "id": "5d9b0d3c-63e5-50a4-b21d-24da045f3280",
    "type": "order_bookings",
    "attributes": {
      "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "333ff82b-c42b-444b-b596-a5b399b609ce"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cd3dc744-5e53-4c33-a5a9-694ba3614282"
          },
          {
            "type": "lines",
            "id": "1b21dd3d-6a9c-40ec-a856-29e76b9c15e2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "661c0deb-2bee-43fe-9a8f-3c0b88401863"
          },
          {
            "type": "plannings",
            "id": "983b511f-75e4-4bcf-afd4-84fc2696995d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a35d9ba6-7744-40c3-b34b-84ecba8991d6"
          },
          {
            "type": "stock_item_plannings",
            "id": "62592314-440d-4e32-af87-d2f524db5f39"
          },
          {
            "type": "stock_item_plannings",
            "id": "cc39c380-e413-4db2-8ca7-548219e4acba"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "333ff82b-c42b-444b-b596-a5b399b609ce",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-11T12:49:57+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
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
        "customer_id": "e72e4a5d-5031-4134-a154-ca946706748c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955",
        "stop_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955"
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
      "id": "cd3dc744-5e53-4c33-a5a9-694ba3614282",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-11T12:49:57+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
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
        "item_id": "36e8c70e-084a-407b-8c88-3eb93d480e07",
        "tax_category_id": "ed8262ef-24d3-4fe3-ab49-ba25fb64032a",
        "planning_id": "661c0deb-2bee-43fe-9a8f-3c0b88401863",
        "parent_line_id": null,
        "owner_id": "333ff82b-c42b-444b-b596-a5b399b609ce",
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
      "id": "1b21dd3d-6a9c-40ec-a856-29e76b9c15e2",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-11T12:49:58+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
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
        "item_id": "4dc316d6-9432-4240-b288-b455ef739a07",
        "tax_category_id": "ed8262ef-24d3-4fe3-ab49-ba25fb64032a",
        "planning_id": "983b511f-75e4-4bcf-afd4-84fc2696995d",
        "parent_line_id": null,
        "owner_id": "333ff82b-c42b-444b-b596-a5b399b609ce",
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
      "id": "661c0deb-2bee-43fe-9a8f-3c0b88401863",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-11T12:49:57+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
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
        "item_id": "36e8c70e-084a-407b-8c88-3eb93d480e07",
        "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce",
        "start_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955",
        "stop_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955",
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
      "id": "983b511f-75e4-4bcf-afd4-84fc2696995d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-11T12:49:58+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
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
        "item_id": "4dc316d6-9432-4240-b288-b455ef739a07",
        "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce",
        "start_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955",
        "stop_location_id": "b5266758-f4a7-4fc9-b3cd-a6413e014955",
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
      "id": "a35d9ba6-7744-40c3-b34b-84ecba8991d6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-11T12:49:58+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "251a106a-0991-4f82-a7a2-eb355bdf85c6",
        "planning_id": "983b511f-75e4-4bcf-afd4-84fc2696995d",
        "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce"
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
      "id": "62592314-440d-4e32-af87-d2f524db5f39",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-11T12:49:58+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6c506dbb-30d4-450d-bf20-78e8f945c601",
        "planning_id": "983b511f-75e4-4bcf-afd4-84fc2696995d",
        "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce"
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
      "id": "cc39c380-e413-4db2-8ca7-548219e4acba",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-11T12:49:58+00:00",
        "updated_at": "2022-03-11T12:49:58+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ac173982-32ae-4108-8bdd-01069362f5cc",
        "planning_id": "983b511f-75e4-4bcf-afd4-84fc2696995d",
        "order_id": "333ff82b-c42b-444b-b596-a5b399b609ce"
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
          "order_id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002",
          "items": [
            {
              "type": "bundles",
              "id": "0fedcdca-d0d7-4e6e-a8d7-a142c79ebefe",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "0f2bec5e-9ed0-4321-867e-8308e57fa8ef",
                  "id": "6e59009e-b4ae-4cdb-a93a-f4b7a495c0de"
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
    "id": "7075b28e-0fc6-5564-a4e9-a7f514c7a4da",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2df83f89-50ba-4435-ac4a-cf5d0c15c185"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "377730ed-13a6-4041-a41d-a466af521620"
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
      "id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-11T12:50:00+00:00",
        "updated_at": "2022-03-11T12:50:01+00:00",
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
        "starts_at": "2022-03-09T12:45:00+00:00",
        "stops_at": "2022-03-13T12:45:00+00:00",
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
        "start_location_id": "94fce122-e13d-441d-9e93-8db7bf226b19",
        "stop_location_id": "94fce122-e13d-441d-9e93-8db7bf226b19"
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
      "id": "2df83f89-50ba-4435-ac4a-cf5d0c15c185",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-11T12:50:01+00:00",
        "updated_at": "2022-03-11T12:50:01+00:00",
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
        "item_id": "0fedcdca-d0d7-4e6e-a8d7-a142c79ebefe",
        "tax_category_id": null,
        "planning_id": "377730ed-13a6-4041-a41d-a466af521620",
        "parent_line_id": null,
        "owner_id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002",
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
      "id": "377730ed-13a6-4041-a41d-a466af521620",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-11T12:50:01+00:00",
        "updated_at": "2022-03-11T12:50:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-09T12:45:00+00:00",
        "stops_at": "2022-03-13T12:45:00+00:00",
        "reserved_from": "2022-03-09T12:45:00+00:00",
        "reserved_till": "2022-03-13T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "0fedcdca-d0d7-4e6e-a8d7-a142c79ebefe",
        "order_id": "ed2f4042-d1d8-4fc0-b873-d17549f8b002",
        "start_location_id": "94fce122-e13d-441d-9e93-8db7bf226b19",
        "stop_location_id": "94fce122-e13d-441d-9e93-8db7bf226b19",
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





