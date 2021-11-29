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

## Endpoints
`POST /api/boomerang/order_bookings`

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
          "order_id": "ba532b8c-b77f-4e2a-9708-d4488fb64d83",
          "items": [
            {
              "type": "products",
              "id": "b1c41041-66c8-4e2e-96b2-1e39271549f6",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "bc7f7178-81f2-45a6-ad2a-4a913a893480",
              "stock_item_ids": [
                "ef0f541d-28f8-4fc2-9ce7-b2dffafdf9b5",
                "1068f650-114e-454c-b7c0-35c80d4ddad3"
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
            "item_id": "b1c41041-66c8-4e2e-96b2-1e39271549f6",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "bc7f7178-81f2-45a6-ad2a-4a913a893480",
            "unavailable": [
              "ef0f541d-28f8-4fc2-9ce7-b2dffafdf9b5"
            ],
            "available": [
              "1068f650-114e-454c-b7c0-35c80d4ddad3"
            ]
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
          "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
          "items": [
            {
              "type": "products",
              "id": "6d420d5d-41ec-49c1-9be0-ddcf7229da96",
              "stock_item_ids": [
                "428aef89-9ace-4bfd-8d79-a62de39feb23",
                "362a39dd-6e01-4971-b4f8-d3ea089618b3",
                "195e8d21-a144-4d61-9c36-0e9d2b338273"
              ]
            },
            {
              "type": "products",
              "id": "e31a8b30-264e-41ca-ae41-87e5fcd993a3",
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
    "id": "d8bd473e-937b-5cba-b472-3c7a1f02d0bf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ee3c4188-9be0-48f1-8565-1c8b3019b541"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5c628f3f-3e5a-4323-aae6-58da6f28dceb"
          },
          {
            "type": "lines",
            "id": "edef481d-be3c-4e6b-a890-9c770362852b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f64571a1-99b1-4b1b-8246-56ef69e0e587"
          },
          {
            "type": "plannings",
            "id": "d0d45ce3-9e50-4ab0-860a-d46b04797575"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d7addcff-2778-4766-ae06-b703af87f935"
          },
          {
            "type": "stock_item_plannings",
            "id": "432e55bc-2297-4786-a541-b95eaa2501c0"
          },
          {
            "type": "stock_item_plannings",
            "id": "dd548f96-67c1-4788-8ad4-ee3933d41404"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-29T09:03:27+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
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
        "customer_id": "c42583fb-0d50-41f9-a9da-3d0415bf4757",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543",
        "stop_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543"
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
      "id": "5c628f3f-3e5a-4323-aae6-58da6f28dceb",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-29T09:03:28+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
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
        "item_id": "e31a8b30-264e-41ca-ae41-87e5fcd993a3",
        "tax_category_id": "77ed5d5b-e604-4ef2-ba6f-10edc698c75d",
        "parent_line_id": null,
        "owner_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
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
      "id": "edef481d-be3c-4e6b-a890-9c770362852b",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-29T09:03:29+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
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
        "item_id": "6d420d5d-41ec-49c1-9be0-ddcf7229da96",
        "tax_category_id": "77ed5d5b-e604-4ef2-ba6f-10edc698c75d",
        "parent_line_id": null,
        "owner_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
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
      "id": "f64571a1-99b1-4b1b-8246-56ef69e0e587",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:29+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
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
        "item_id": "6d420d5d-41ec-49c1-9be0-ddcf7229da96",
        "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
        "start_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543",
        "stop_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543",
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
      "id": "d0d45ce3-9e50-4ab0-860a-d46b04797575",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:28+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
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
        "item_id": "e31a8b30-264e-41ca-ae41-87e5fcd993a3",
        "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541",
        "start_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543",
        "stop_location_id": "47a54b68-0a9e-48f7-a6b6-8c200464f543",
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
      "id": "d7addcff-2778-4766-ae06-b703af87f935",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:29+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "428aef89-9ace-4bfd-8d79-a62de39feb23",
        "planning_id": "f64571a1-99b1-4b1b-8246-56ef69e0e587",
        "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541"
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
      "id": "432e55bc-2297-4786-a541-b95eaa2501c0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:29+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "362a39dd-6e01-4971-b4f8-d3ea089618b3",
        "planning_id": "f64571a1-99b1-4b1b-8246-56ef69e0e587",
        "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541"
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
      "id": "dd548f96-67c1-4788-8ad4-ee3933d41404",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:29+00:00",
        "updated_at": "2021-11-29T09:03:29+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "195e8d21-a144-4d61-9c36-0e9d2b338273",
        "planning_id": "f64571a1-99b1-4b1b-8246-56ef69e0e587",
        "order_id": "ee3c4188-9be0-48f1-8565-1c8b3019b541"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=6d420d5d-41ec-49c1-9be0-ddcf7229da96&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=428aef89-9ace-4bfd-8d79-a62de39feb23&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=362a39dd-6e01-4971-b4f8-d3ea089618b3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=195e8d21-a144-4d61-9c36-0e9d2b338273&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e31a8b30-264e-41ca-ae41-87e5fcd993a3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=ee3c4188-9be0-48f1-8565-1c8b3019b541&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e",
          "items": [
            {
              "type": "bundles",
              "id": "f39f9991-b63b-4e23-9727-44632185106f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "df75b489-6a30-43f6-a7da-3d7cf18052e3",
                  "id": "2ccbbd7f-b71d-4ff3-884d-a4d1343fc162"
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
    "id": "d2aa086f-4775-5e62-b59e-5db184f0e420",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "df066c73-8f79-47f5-96c0-b417c5abbd04"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "117f9d6c-86c6-4bd4-9e48-71d51f01adbf"
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
      "id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-29T09:03:31+00:00",
        "updated_at": "2021-11-29T09:03:32+00:00",
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
        "starts_at": "2021-11-27T09:00:00+00:00",
        "stops_at": "2021-12-01T09:00:00+00:00",
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
        "start_location_id": "b32f6b4f-aea3-4073-b09d-003fbdc231c2",
        "stop_location_id": "b32f6b4f-aea3-4073-b09d-003fbdc231c2"
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
      "id": "df066c73-8f79-47f5-96c0-b417c5abbd04",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-29T09:03:32+00:00",
        "updated_at": "2021-11-29T09:03:32+00:00",
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
        "item_id": "f39f9991-b63b-4e23-9727-44632185106f",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e",
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
      "id": "117f9d6c-86c6-4bd4-9e48-71d51f01adbf",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-29T09:03:32+00:00",
        "updated_at": "2021-11-29T09:03:32+00:00",
        "quantity": 1,
        "starts_at": "2021-11-27T09:00:00+00:00",
        "stops_at": "2021-12-01T09:00:00+00:00",
        "reserved_from": "2021-11-27T09:00:00+00:00",
        "reserved_till": "2021-12-01T09:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f39f9991-b63b-4e23-9727-44632185106f",
        "order_id": "4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e",
        "start_location_id": "b32f6b4f-aea3-4073-b09d-003fbdc231c2",
        "stop_location_id": "b32f6b4f-aea3-4073-b09d-003fbdc231c2",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&data%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&data%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&data%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&data%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=f39f9991-b63b-4e23-9727-44632185106f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=df75b489-6a30-43f6-a7da-3d7cf18052e3&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2ccbbd7f-b71d-4ff3-884d-a4d1343fc162&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4fc164b3-ea7d-4dec-bbeb-dcd1e04bba5e&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





