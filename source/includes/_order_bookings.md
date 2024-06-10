# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
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
          "order_id": "fe405acc-4180-47cc-995a-982165242293",
          "items": [
            {
              "type": "products",
              "id": "ed92d6f9-c1b5-47cf-b40d-4edb2c482344",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "8c5d6a5a-29fd-4eb7-9ae3-ef524241ff48",
              "stock_item_ids": [
                "5b23f0a7-d15c-4be1-b785-5ef933b4ea85",
                "e1485b80-bf35-4495-a5dd-78e9faeb5b99"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id 5b23f0a7-d15c-4be1-b785-5ef933b4ea85 has already been booked on this order"
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
          "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
          "items": [
            {
              "type": "products",
              "id": "a43e5ab2-a414-4907-a892-2c1eb867b084",
              "stock_item_ids": [
                "f4e0cf1b-36c3-4fd9-9823-344dd79d485e",
                "7a0a854a-4043-4174-85ac-75ad040674d9",
                "cca01523-a725-4bde-ac4a-e543eb33e305"
              ]
            },
            {
              "type": "products",
              "id": "32847ba6-661f-4cc5-939a-94e236b23c6f",
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
    "id": "b3b53c61-9f80-5f27-ab55-6fd2bf20aaed",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7342d776-05bf-4899-a02d-b61370b3ba82"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "edb9938b-8d35-4614-8bd0-38615a8248fa"
          },
          {
            "type": "lines",
            "id": "2854ab28-408f-41d0-ae45-867c4e2c4ff4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1e4901e1-1eab-4f50-958e-8d182c697730"
          },
          {
            "type": "plannings",
            "id": "cca32cf9-1767-4748-a81f-9563ad9aefdc"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "27b75722-c2f6-4572-9f41-576b253056c8"
          },
          {
            "type": "stock_item_plannings",
            "id": "42f2ac36-1a76-44cc-baf4-40c3229f73c7"
          },
          {
            "type": "stock_item_plannings",
            "id": "bdf8e19f-994d-4fc7-96b3-749fd0bd9bc2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7342d776-05bf-4899-a02d-b61370b3ba82",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-10T09:27:09.766360+00:00",
        "updated_at": "2024-06-10T09:27:11.991557+00:00",
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
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "deposit_type": "percentage",
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "40d4ae19-fb42-432c-9405-7c2206351a7c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0",
        "stop_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0"
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
        "documents": {
          "meta": {
            "included": false
          }
        },
        "transfers": {
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
      "id": "edb9938b-8d35-4614-8bd0-38615a8248fa",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.838799+00:00",
        "updated_at": "2024-06-10T09:27:12.026031+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "display_price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 7750
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "item_id": "a43e5ab2-a414-4907-a892-2c1eb867b084",
        "tax_category_id": "dd586b22-bcbc-4728-b27b-1441ec95275a",
        "planning_id": "1e4901e1-1eab-4f50-958e-8d182c697730",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "2854ab28-408f-41d0-ae45-867c4e2c4ff4",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.838799+00:00",
        "updated_at": "2024-06-10T09:27:12.026031+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "display_price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 7750
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "item_id": "32847ba6-661f-4cc5-939a-94e236b23c6f",
        "tax_category_id": "dd586b22-bcbc-4728-b27b-1441ec95275a",
        "planning_id": "cca32cf9-1767-4748-a81f-9563ad9aefdc",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "1e4901e1-1eab-4f50-958e-8d182c697730",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.758744+00:00",
        "updated_at": "2024-06-10T09:27:11.758744+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 3,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "item_id": "a43e5ab2-a414-4907-a892-2c1eb867b084",
        "start_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0",
        "stop_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "cca32cf9-1767-4748-a81f-9563ad9aefdc",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.758744+00:00",
        "updated_at": "2024-06-10T09:27:11.758744+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "1980-04-01T12:00:00.000000+00:00",
        "stops_at": "1980-05-01T12:00:00.000000+00:00",
        "reserved_from": "1980-04-01T12:00:00.000000+00:00",
        "reserved_till": "1980-05-01T12:00:00.000000+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82",
        "item_id": "32847ba6-661f-4cc5-939a-94e236b23c6f",
        "start_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0",
        "stop_location_id": "2c1032d9-0535-4d1d-9b67-963e6af6b1a0",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "27b75722-c2f6-4572-9f41-576b253056c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.767884+00:00",
        "updated_at": "2024-06-10T09:27:11.767884+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f4e0cf1b-36c3-4fd9-9823-344dd79d485e",
        "planning_id": "1e4901e1-1eab-4f50-958e-8d182c697730",
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82"
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
      "id": "42f2ac36-1a76-44cc-baf4-40c3229f73c7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.767884+00:00",
        "updated_at": "2024-06-10T09:27:11.767884+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7a0a854a-4043-4174-85ac-75ad040674d9",
        "planning_id": "1e4901e1-1eab-4f50-958e-8d182c697730",
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82"
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
      "id": "bdf8e19f-994d-4fc7-96b3-749fd0bd9bc2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:11.767884+00:00",
        "updated_at": "2024-06-10T09:27:11.767884+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cca01523-a725-4bde-ac4a-e543eb33e305",
        "planning_id": "1e4901e1-1eab-4f50-958e-8d182c697730",
        "order_id": "7342d776-05bf-4899-a02d-b61370b3ba82"
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
          "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
          "items": [
            {
              "type": "bundles",
              "id": "43daf42c-930c-49dd-9ac2-a7645cfb330a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2bb314c2-c085-4108-acbe-57b9b3c5a356",
                  "id": "74b9c009-4358-4c66-a333-515544a740d5"
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
    "id": "a4189670-adbb-5e69-88d1-b4516ff72e26",
    "type": "order_bookings",
    "attributes": {
      "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6efdbc30-a59c-443f-b96d-e23d5773715b"
          },
          {
            "type": "lines",
            "id": "d336c97c-145c-4698-98e7-b5605c306086"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3db9297f-bc46-484c-b42d-cebdf6ba3bc2"
          },
          {
            "type": "plannings",
            "id": "2c5ef36d-044e-48c8-8ec9-331ffd883617"
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
      "id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-10T09:27:08.036481+00:00",
        "updated_at": "2024-06-10T09:27:08.408032+00:00",
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
        "starts_at": "2024-06-08T09:15:00.000000+00:00",
        "stops_at": "2024-06-12T09:15:00.000000+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47",
        "stop_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47"
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
        "documents": {
          "meta": {
            "included": false
          }
        },
        "transfers": {
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
      "id": "6efdbc30-a59c-443f-b96d-e23d5773715b",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-10T09:27:08.450735+00:00",
        "updated_at": "2024-06-10T09:27:08.526292+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "item_id": "43daf42c-930c-49dd-9ac2-a7645cfb330a",
        "tax_category_id": null,
        "planning_id": "3db9297f-bc46-484c-b42d-cebdf6ba3bc2",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "d336c97c-145c-4698-98e7-b5605c306086",
      "type": "lines",
      "attributes": {
        "created_at": "2024-06-10T09:27:08.456327+00:00",
        "updated_at": "2024-06-10T09:27:08.526292+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000049 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "item_id": "74b9c009-4358-4c66-a333-515544a740d5",
        "tax_category_id": null,
        "planning_id": "2c5ef36d-044e-48c8-8ec9-331ffd883617",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "6efdbc30-a59c-443f-b96d-e23d5773715b",
        "owner_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "3db9297f-bc46-484c-b42d-cebdf6ba3bc2",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:08.392115+00:00",
        "updated_at": "2024-06-10T09:27:08.392115+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-06-08T09:15:00.000000+00:00",
        "stops_at": "2024-06-12T09:15:00.000000+00:00",
        "reserved_from": "2024-06-08T09:15:00.000000+00:00",
        "reserved_till": "2024-06-12T09:15:00.000000+00:00",
        "reserved": false,
        "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "item_id": "43daf42c-930c-49dd-9ac2-a7645cfb330a",
        "start_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47",
        "stop_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "2c5ef36d-044e-48c8-8ec9-331ffd883617",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-06-10T09:27:08.392115+00:00",
        "updated_at": "2024-06-10T09:27:08.392115+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-06-08T09:15:00.000000+00:00",
        "stops_at": "2024-06-12T09:15:00.000000+00:00",
        "reserved_from": "2024-06-08T09:15:00.000000+00:00",
        "reserved_till": "2024-06-12T09:15:00.000000+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "74cc3b23-93df-4fee-b687-1e0fdcc580bf",
        "item_id": "74b9c009-4358-4c66-a333-515544a740d5",
        "start_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47",
        "stop_location_id": "27e2ee49-c44e-4917-be28-f0eabdfcfe47",
        "parent_planning_id": "3db9297f-bc46-484c-b42d-cebdf6ba3bc2",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





