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
          "order_id": "574121dd-ee4d-41c2-ae87-fc996b2a058d",
          "items": [
            {
              "type": "products",
              "id": "46b5d4d8-1814-433c-a1f9-4d3c242d8ea2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "1540402f-6163-4b7e-ae36-55c2ea6ec2b7",
              "stock_item_ids": [
                "c4f371cf-e155-4b53-8e41-74c35f6465e7",
                "0ee49fd5-8858-4945-a3d3-ecc95b6bfa80"
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
            "item_id": "46b5d4d8-1814-433c-a1f9-4d3c242d8ea2",
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
          "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
          "items": [
            {
              "type": "products",
              "id": "a24b31d6-c02c-40d7-8830-edb3734728a6",
              "stock_item_ids": [
                "046243cd-12c3-4bd6-982e-196f2c5ce8b5",
                "a4235fad-3321-4e19-a128-2f55f92895ba",
                "9fe40251-8d91-48cd-94cb-82fe1f970576"
              ]
            },
            {
              "type": "products",
              "id": "dd5e44bb-3cdb-4ded-9db4-5367b0132a5c",
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
    "id": "c4355c19-3783-5636-bc8a-562664f4d353",
    "type": "order_bookings",
    "attributes": {
      "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e3b8a1cb-6e88-494b-802d-ddea36d8407c"
          },
          {
            "type": "lines",
            "id": "641e3718-181f-4146-bc7b-28fa95ae07ca"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6a0cbb15-32d5-4136-bb87-88cfeaa09eb2"
          },
          {
            "type": "plannings",
            "id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "51d873f1-3ab3-4ff1-b4b2-4a7788fc6fe6"
          },
          {
            "type": "stock_item_plannings",
            "id": "31ecc6d0-f654-4682-ab1c-e7af419720cb"
          },
          {
            "type": "stock_item_plannings",
            "id": "52f98b00-9796-4322-9660-2b3f11e653d2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-06T08:14:16+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
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
        "customer_id": "6cd040c0-4f3b-40ec-9d93-646b9b7b5c1a",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b",
        "stop_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b"
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
      "id": "e3b8a1cb-6e88-494b-802d-ddea36d8407c",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-06T08:14:17+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
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
        "item_id": "dd5e44bb-3cdb-4ded-9db4-5367b0132a5c",
        "tax_category_id": "440ee412-e350-41b5-914e-88a410b34b17",
        "planning_id": "6a0cbb15-32d5-4136-bb87-88cfeaa09eb2",
        "parent_line_id": null,
        "owner_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
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
      "id": "641e3718-181f-4146-bc7b-28fa95ae07ca",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-06T08:14:18+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
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
        "item_id": "a24b31d6-c02c-40d7-8830-edb3734728a6",
        "tax_category_id": "440ee412-e350-41b5-914e-88a410b34b17",
        "planning_id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52",
        "parent_line_id": null,
        "owner_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
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
      "id": "6a0cbb15-32d5-4136-bb87-88cfeaa09eb2",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:17+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
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
        "item_id": "dd5e44bb-3cdb-4ded-9db4-5367b0132a5c",
        "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
        "start_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b",
        "stop_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b",
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
      "id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:18+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
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
        "item_id": "a24b31d6-c02c-40d7-8830-edb3734728a6",
        "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71",
        "start_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b",
        "stop_location_id": "dd35bdd3-7e7d-40ba-bbe8-157bbdbf4e2b",
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
      "id": "51d873f1-3ab3-4ff1-b4b2-4a7788fc6fe6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:18+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "046243cd-12c3-4bd6-982e-196f2c5ce8b5",
        "planning_id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52",
        "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71"
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
      "id": "31ecc6d0-f654-4682-ab1c-e7af419720cb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:18+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a4235fad-3321-4e19-a128-2f55f92895ba",
        "planning_id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52",
        "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71"
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
      "id": "52f98b00-9796-4322-9660-2b3f11e653d2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:18+00:00",
        "updated_at": "2022-07-06T08:14:18+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9fe40251-8d91-48cd-94cb-82fe1f970576",
        "planning_id": "ac2d456f-5f9b-4d9c-a5f2-b9e3134e3c52",
        "order_id": "dbc545a1-98cd-42a2-b6a8-5425dfc01b71"
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
          "order_id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac",
          "items": [
            {
              "type": "bundles",
              "id": "58366375-35a7-4905-987b-62347d52f7c1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "53959b59-b10d-40c2-98c3-e09261fbf4bf",
                  "id": "f3fea939-62ee-45e4-b71a-316a1d872ca5"
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
    "id": "be2df09a-7a4c-5354-b1f3-bc4cd95c5e9a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0d206463-f57d-4cf8-bce8-bcc7b3bda97b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cf95e344-6be3-41d8-8361-818707b0cfb8"
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
      "id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-06T08:14:21+00:00",
        "updated_at": "2022-07-06T08:14:22+00:00",
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
        "starts_at": "2022-07-04T08:00:00+00:00",
        "stops_at": "2022-07-08T08:00:00+00:00",
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
        "start_location_id": "b110e5eb-1fd4-401c-ab47-d9fc40f782de",
        "stop_location_id": "b110e5eb-1fd4-401c-ab47-d9fc40f782de"
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
      "id": "0d206463-f57d-4cf8-bce8-bcc7b3bda97b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-06T08:14:22+00:00",
        "updated_at": "2022-07-06T08:14:22+00:00",
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
        "item_id": "58366375-35a7-4905-987b-62347d52f7c1",
        "tax_category_id": null,
        "planning_id": "cf95e344-6be3-41d8-8361-818707b0cfb8",
        "parent_line_id": null,
        "owner_id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac",
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
      "id": "cf95e344-6be3-41d8-8361-818707b0cfb8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-06T08:14:22+00:00",
        "updated_at": "2022-07-06T08:14:22+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-04T08:00:00+00:00",
        "stops_at": "2022-07-08T08:00:00+00:00",
        "reserved_from": "2022-07-04T08:00:00+00:00",
        "reserved_till": "2022-07-08T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "58366375-35a7-4905-987b-62347d52f7c1",
        "order_id": "fd47ac1e-fc23-490f-bbb5-871e9efc2cac",
        "start_location_id": "b110e5eb-1fd4-401c-ab47-d9fc40f782de",
        "stop_location_id": "b110e5eb-1fd4-401c-ab47-d9fc40f782de",
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





