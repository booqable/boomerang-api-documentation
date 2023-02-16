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
          "order_id": "2da2fb22-ad42-469b-9dc9-ed0cb6ada452",
          "items": [
            {
              "type": "products",
              "id": "dc32455e-aca4-49ae-b988-18728f65e213",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f07c8a9d-11da-442c-89d3-3d8d5b30c0b7",
              "stock_item_ids": [
                "f29976bc-30a2-4c5a-a9c7-68512bf9fa91",
                "866569c7-884b-449c-902c-58ac4b0f2949"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id f29976bc-30a2-4c5a-a9c7-68512bf9fa91 has already been booked on this order"
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
          "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
          "items": [
            {
              "type": "products",
              "id": "f2ea25c3-7536-42a9-8c19-562eb198918d",
              "stock_item_ids": [
                "a00e23bd-78b3-40c4-be12-f1940dc30935",
                "d06f2df0-6960-4ae4-a035-40fc80783fa0",
                "c2c19811-5557-49eb-878e-82d3be52aacd"
              ]
            },
            {
              "type": "products",
              "id": "32581ad1-8d37-4d82-bca7-d43352005bc4",
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
    "id": "f92ce1d6-e570-579d-bb85-5aba18c33ac2",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2a2e7030-0e9a-4906-90ea-a027d9090d3f"
          },
          {
            "type": "lines",
            "id": "02b9b562-1947-4593-8f4c-66d6cda19868"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b"
          },
          {
            "type": "plannings",
            "id": "5b614bc5-2ba1-401f-945b-484006071512"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "324289aa-02bc-48c5-83f2-c5ff753643e8"
          },
          {
            "type": "stock_item_plannings",
            "id": "d3af3d7b-cd31-4f56-9661-152e9f0a492c"
          },
          {
            "type": "stock_item_plannings",
            "id": "e52bcd37-432f-42dd-827b-80e250db508d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T09:16:08+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
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
        "customer_id": "7dce6678-5806-48f0-8306-b1ffc6046b8b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "190af297-c187-4846-990d-da408b3d7b34",
        "stop_location_id": "190af297-c187-4846-990d-da408b3d7b34"
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
      "id": "2a2e7030-0e9a-4906-90ea-a027d9090d3f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
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
              "price_in_cents": 3100,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "f2ea25c3-7536-42a9-8c19-562eb198918d",
        "tax_category_id": "3a005456-caac-44c7-ade7-8a8d182688ae",
        "planning_id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b",
        "parent_line_id": null,
        "owner_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
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
      "id": "02b9b562-1947-4593-8f4c-66d6cda19868",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
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
              "price_in_cents": 7750,
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "item_id": "32581ad1-8d37-4d82-bca7-d43352005bc4",
        "tax_category_id": "3a005456-caac-44c7-ade7-8a8d182688ae",
        "planning_id": "5b614bc5-2ba1-401f-945b-484006071512",
        "parent_line_id": null,
        "owner_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
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
      "id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
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
        "item_id": "f2ea25c3-7536-42a9-8c19-562eb198918d",
        "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
        "start_location_id": "190af297-c187-4846-990d-da408b3d7b34",
        "stop_location_id": "190af297-c187-4846-990d-da408b3d7b34",
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
      "id": "5b614bc5-2ba1-401f-945b-484006071512",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
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
        "item_id": "32581ad1-8d37-4d82-bca7-d43352005bc4",
        "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef",
        "start_location_id": "190af297-c187-4846-990d-da408b3d7b34",
        "stop_location_id": "190af297-c187-4846-990d-da408b3d7b34",
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
      "id": "324289aa-02bc-48c5-83f2-c5ff753643e8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a00e23bd-78b3-40c4-be12-f1940dc30935",
        "planning_id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b",
        "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef"
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
      "id": "d3af3d7b-cd31-4f56-9661-152e9f0a492c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d06f2df0-6960-4ae4-a035-40fc80783fa0",
        "planning_id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b",
        "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef"
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
      "id": "e52bcd37-432f-42dd-827b-80e250db508d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:10+00:00",
        "updated_at": "2023-02-16T09:16:10+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c2c19811-5557-49eb-878e-82d3be52aacd",
        "planning_id": "e48bc57e-8af6-4c69-85be-bb4d73faaa6b",
        "order_id": "ed8edc37-2973-4700-83d6-f56d6cdeeeef"
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
          "order_id": "db224423-7bc5-40df-83ed-0a54fa763027",
          "items": [
            {
              "type": "bundles",
              "id": "3325ee31-97ad-43fd-a713-156c9e4ba1b3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "5176fedc-d0e2-4e86-b75a-d14cb77168c4",
                  "id": "31e7aba5-5fe2-4e05-800f-5789eadef90a"
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
    "id": "f3270574-e18c-52e9-8475-88b3b51a402b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "db224423-7bc5-40df-83ed-0a54fa763027"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "db224423-7bc5-40df-83ed-0a54fa763027"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f71ec86a-60fb-43cf-95d0-3e9913af1524"
          },
          {
            "type": "lines",
            "id": "3e2cb7f0-b13c-44d9-9dd9-76968c44cd21"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3012def4-273d-4e79-8b3e-362db6caa0a6"
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
      "id": "db224423-7bc5-40df-83ed-0a54fa763027",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T09:16:13+00:00",
        "updated_at": "2023-02-16T09:16:13+00:00",
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
        "starts_at": "2023-02-14T09:15:00+00:00",
        "stops_at": "2023-02-18T09:15:00+00:00",
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
        "start_location_id": "741b4555-8162-48c1-a7b7-da7e349a1689",
        "stop_location_id": "741b4555-8162-48c1-a7b7-da7e349a1689"
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
      "id": "f71ec86a-60fb-43cf-95d0-3e9913af1524",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:16:13+00:00",
        "updated_at": "2023-02-16T09:16:13+00:00",
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
        "item_id": "31e7aba5-5fe2-4e05-800f-5789eadef90a",
        "tax_category_id": null,
        "planning_id": "06aa3ba3-c630-4370-9043-178101a6ede1",
        "parent_line_id": "3e2cb7f0-b13c-44d9-9dd9-76968c44cd21",
        "owner_id": "db224423-7bc5-40df-83ed-0a54fa763027",
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
      "id": "3e2cb7f0-b13c-44d9-9dd9-76968c44cd21",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T09:16:13+00:00",
        "updated_at": "2023-02-16T09:16:13+00:00",
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
        "item_id": "3325ee31-97ad-43fd-a713-156c9e4ba1b3",
        "tax_category_id": null,
        "planning_id": "3012def4-273d-4e79-8b3e-362db6caa0a6",
        "parent_line_id": null,
        "owner_id": "db224423-7bc5-40df-83ed-0a54fa763027",
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
      "id": "3012def4-273d-4e79-8b3e-362db6caa0a6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T09:16:13+00:00",
        "updated_at": "2023-02-16T09:16:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T09:15:00+00:00",
        "stops_at": "2023-02-18T09:15:00+00:00",
        "reserved_from": "2023-02-14T09:15:00+00:00",
        "reserved_till": "2023-02-18T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3325ee31-97ad-43fd-a713-156c9e4ba1b3",
        "order_id": "db224423-7bc5-40df-83ed-0a54fa763027",
        "start_location_id": "741b4555-8162-48c1-a7b7-da7e349a1689",
        "stop_location_id": "741b4555-8162-48c1-a7b7-da7e349a1689",
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





