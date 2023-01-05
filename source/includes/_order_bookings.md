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
          "order_id": "0b3d9c8c-bc8e-497a-8098-019f3825fdec",
          "items": [
            {
              "type": "products",
              "id": "dda0aad5-d1db-4e18-8ef4-ff242266bbef",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "9b50572b-33f7-43e8-b70f-9391d5bccda5",
              "stock_item_ids": [
                "c9c31f97-78bd-412b-8028-e9158e14c774",
                "ce95d66b-c864-4d69-aaf8-28f9419a1ea9"
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
            "item_id": "dda0aad5-d1db-4e18-8ef4-ff242266bbef",
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
          "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
          "items": [
            {
              "type": "products",
              "id": "eef2e36a-5d11-4d85-99ab-516f86f11fbe",
              "stock_item_ids": [
                "da770470-78c5-43fe-9439-7b2235d6f60c",
                "af6eaaa9-7f16-40b0-8877-d058954ae333",
                "0b7bdd34-a0db-4c92-b4c1-a48aa293271c"
              ]
            },
            {
              "type": "products",
              "id": "311d314b-1bff-4d45-9a92-299477205b5a",
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
    "id": "0002bf58-02de-5398-b1cc-31cb8ab33cb0",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f9bcfb7e-2ab7-4606-90b8-1ed3f2a4f867"
          },
          {
            "type": "lines",
            "id": "603e9edb-7e36-4dd9-9af1-e4c3f5655589"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb"
          },
          {
            "type": "plannings",
            "id": "0cb4da82-57ed-4c25-8b36-c2d3638d7840"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d9f5aff9-818f-4aad-9d51-bccb1f8461fd"
          },
          {
            "type": "stock_item_plannings",
            "id": "bb8facac-f772-4c9c-a9c3-3f5515d4daf2"
          },
          {
            "type": "stock_item_plannings",
            "id": "6f893f35-1d95-41dc-bd67-a53668109511"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:10:28+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
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
        "customer_id": "5aaec429-5b7e-4545-9bfb-d06218c6fd9e",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0",
        "stop_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0"
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
      "id": "f9bcfb7e-2ab7-4606-90b8-1ed3f2a4f867",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
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
        "item_id": "eef2e36a-5d11-4d85-99ab-516f86f11fbe",
        "tax_category_id": "21c99e4f-06a6-495e-ba6b-b4cf52afed01",
        "planning_id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb",
        "parent_line_id": null,
        "owner_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
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
      "id": "603e9edb-7e36-4dd9-9af1-e4c3f5655589",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
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
        "item_id": "311d314b-1bff-4d45-9a92-299477205b5a",
        "tax_category_id": "21c99e4f-06a6-495e-ba6b-b4cf52afed01",
        "planning_id": "0cb4da82-57ed-4c25-8b36-c2d3638d7840",
        "parent_line_id": null,
        "owner_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
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
      "id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
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
        "item_id": "eef2e36a-5d11-4d85-99ab-516f86f11fbe",
        "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
        "start_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0",
        "stop_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0",
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
      "id": "0cb4da82-57ed-4c25-8b36-c2d3638d7840",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
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
        "item_id": "311d314b-1bff-4d45-9a92-299477205b5a",
        "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082",
        "start_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0",
        "stop_location_id": "53cda731-4b8a-44dd-9c39-b9328ad334a0",
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
      "id": "d9f5aff9-818f-4aad-9d51-bccb1f8461fd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "da770470-78c5-43fe-9439-7b2235d6f60c",
        "planning_id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb",
        "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082"
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
      "id": "bb8facac-f772-4c9c-a9c3-3f5515d4daf2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af6eaaa9-7f16-40b0-8877-d058954ae333",
        "planning_id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb",
        "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082"
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
      "id": "6f893f35-1d95-41dc-bd67-a53668109511",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:30+00:00",
        "updated_at": "2023-01-05T13:10:30+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0b7bdd34-a0db-4c92-b4c1-a48aa293271c",
        "planning_id": "01c1eb71-1c39-4c99-af25-50f5fd3c1feb",
        "order_id": "ccbd2bbb-1f66-48b6-9177-4f65824c8082"
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
          "order_id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433",
          "items": [
            {
              "type": "bundles",
              "id": "4cbb3313-21b8-4d01-9fa9-ff30d7c08962",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4e4ad9d4-9070-45f3-b4f3-0961b65e7a5f",
                  "id": "ea447bf9-6d27-49d5-a147-8bd1442d8326"
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
    "id": "d692e921-1565-5ef1-9d01-a967b983b26c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "87c35add-2593-4aa5-bb57-24e2015d8308"
          },
          {
            "type": "lines",
            "id": "0a4fb10a-d7ae-47a5-9feb-028dae98b895"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c586fd5d-bf4b-4476-92b4-5a43926b3dfe"
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
      "id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-05T13:10:33+00:00",
        "updated_at": "2023-01-05T13:10:33+00:00",
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
        "starts_at": "2023-01-03T13:00:00+00:00",
        "stops_at": "2023-01-07T13:00:00+00:00",
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
        "start_location_id": "09860314-cee2-47e5-b682-4aacdc610d91",
        "stop_location_id": "09860314-cee2-47e5-b682-4aacdc610d91"
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
      "id": "87c35add-2593-4aa5-bb57-24e2015d8308",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:10:33+00:00",
        "updated_at": "2023-01-05T13:10:33+00:00",
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
        "item_id": "ea447bf9-6d27-49d5-a147-8bd1442d8326",
        "tax_category_id": null,
        "planning_id": "1616d24c-7038-4cb7-ac0c-b25c9ab9f43c",
        "parent_line_id": "0a4fb10a-d7ae-47a5-9feb-028dae98b895",
        "owner_id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433",
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
      "id": "0a4fb10a-d7ae-47a5-9feb-028dae98b895",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-05T13:10:33+00:00",
        "updated_at": "2023-01-05T13:10:33+00:00",
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
        "item_id": "4cbb3313-21b8-4d01-9fa9-ff30d7c08962",
        "tax_category_id": null,
        "planning_id": "c586fd5d-bf4b-4476-92b4-5a43926b3dfe",
        "parent_line_id": null,
        "owner_id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433",
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
      "id": "c586fd5d-bf4b-4476-92b4-5a43926b3dfe",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-05T13:10:33+00:00",
        "updated_at": "2023-01-05T13:10:33+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-03T13:00:00+00:00",
        "stops_at": "2023-01-07T13:00:00+00:00",
        "reserved_from": "2023-01-03T13:00:00+00:00",
        "reserved_till": "2023-01-07T13:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4cbb3313-21b8-4d01-9fa9-ff30d7c08962",
        "order_id": "69c6d803-4fa4-4ad2-a91d-16a931c8b433",
        "start_location_id": "09860314-cee2-47e5-b682-4aacdc610d91",
        "stop_location_id": "09860314-cee2-47e5-b682-4aacdc610d91",
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





