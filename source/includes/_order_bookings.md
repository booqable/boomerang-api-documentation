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
          "order_id": "49542b98-de54-4721-866b-a6ab10ec281e",
          "items": [
            {
              "type": "products",
              "id": "e28c175e-8729-49e6-9415-0ff776a07590",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "07db76eb-bed1-487c-91a5-52cc74921553",
              "stock_item_ids": [
                "f70bcc10-e4e1-4bce-80ee-654d6caf0ff0",
                "e76fd3d4-a7ea-4d0f-9c44-318705807b10"
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
            "item_id": "e28c175e-8729-49e6-9415-0ff776a07590",
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
          "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
          "items": [
            {
              "type": "products",
              "id": "37e1cd42-b2bc-4923-b9dd-66f29ea59f0c",
              "stock_item_ids": [
                "203a6dd1-51c4-4aa3-8847-ca0b443a59d4",
                "acd0438b-500d-4583-b6fb-f35aa16d6fc8",
                "626b6b0b-ecd3-4959-bf79-5aa7d8076b94"
              ]
            },
            {
              "type": "products",
              "id": "4977afed-23ba-4a4b-8942-b1f0cc437cf8",
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
    "id": "1b029e5f-fea0-561b-9f5d-c68cc6e696fa",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "81ee1500-0019-400f-8000-990095748ef4"
          },
          {
            "type": "lines",
            "id": "90d144a5-7073-4989-bd19-71e503a9aa38"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e29d3acf-218d-44f7-8b65-c1969da5c8af"
          },
          {
            "type": "plannings",
            "id": "4c6e5c76-0f6a-48e1-96ea-496a934a2824"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d4c2fc3d-7bf8-4c7f-aead-4e902674b742"
          },
          {
            "type": "stock_item_plannings",
            "id": "9338324b-bc71-48e5-bbb5-fb1d43271da8"
          },
          {
            "type": "stock_item_plannings",
            "id": "a6b8fd19-3b08-4d93-af5c-8308512c68b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T08:07:42+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
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
        "customer_id": "cfd8f8ca-de5f-4f0d-9b79-37111ff3b945",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b5194bac-1994-47af-aef3-668ea662988b",
        "stop_location_id": "b5194bac-1994-47af-aef3-668ea662988b"
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
      "id": "81ee1500-0019-400f-8000-990095748ef4",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
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
        "item_id": "37e1cd42-b2bc-4923-b9dd-66f29ea59f0c",
        "tax_category_id": "7ef3f537-aaa5-4f3e-8087-ff4d2ac90470",
        "planning_id": "e29d3acf-218d-44f7-8b65-c1969da5c8af",
        "parent_line_id": null,
        "owner_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
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
      "id": "90d144a5-7073-4989-bd19-71e503a9aa38",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
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
        "item_id": "4977afed-23ba-4a4b-8942-b1f0cc437cf8",
        "tax_category_id": "7ef3f537-aaa5-4f3e-8087-ff4d2ac90470",
        "planning_id": "4c6e5c76-0f6a-48e1-96ea-496a934a2824",
        "parent_line_id": null,
        "owner_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
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
      "id": "e29d3acf-218d-44f7-8b65-c1969da5c8af",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
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
        "item_id": "37e1cd42-b2bc-4923-b9dd-66f29ea59f0c",
        "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
        "start_location_id": "b5194bac-1994-47af-aef3-668ea662988b",
        "stop_location_id": "b5194bac-1994-47af-aef3-668ea662988b",
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
      "id": "4c6e5c76-0f6a-48e1-96ea-496a934a2824",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
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
        "item_id": "4977afed-23ba-4a4b-8942-b1f0cc437cf8",
        "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f",
        "start_location_id": "b5194bac-1994-47af-aef3-668ea662988b",
        "stop_location_id": "b5194bac-1994-47af-aef3-668ea662988b",
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
      "id": "d4c2fc3d-7bf8-4c7f-aead-4e902674b742",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "203a6dd1-51c4-4aa3-8847-ca0b443a59d4",
        "planning_id": "e29d3acf-218d-44f7-8b65-c1969da5c8af",
        "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f"
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
      "id": "9338324b-bc71-48e5-bbb5-fb1d43271da8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "acd0438b-500d-4583-b6fb-f35aa16d6fc8",
        "planning_id": "e29d3acf-218d-44f7-8b65-c1969da5c8af",
        "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f"
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
      "id": "a6b8fd19-3b08-4d93-af5c-8308512c68b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:44+00:00",
        "updated_at": "2023-02-07T08:07:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "626b6b0b-ecd3-4959-bf79-5aa7d8076b94",
        "planning_id": "e29d3acf-218d-44f7-8b65-c1969da5c8af",
        "order_id": "a684f09c-5f6a-46d0-b1eb-977c6901af9f"
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
          "order_id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe",
          "items": [
            {
              "type": "bundles",
              "id": "6f9e173a-b493-4957-91f2-2313e12af51c",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "88627a3c-1d51-433c-a401-6f09033690a9",
                  "id": "b06c61c5-591a-4885-94ac-0251f8846945"
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
    "id": "5e70bafc-764f-546b-a935-719c498507f4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "829d7390-61b3-419a-b006-826a36948d8a"
          },
          {
            "type": "lines",
            "id": "6a0296f2-56d6-448a-a375-d73fdfde7d0c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "81918c36-f6fd-4492-acb5-0892b4f1e553"
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
      "id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-07T08:07:46+00:00",
        "updated_at": "2023-02-07T08:07:47+00:00",
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
        "starts_at": "2023-02-05T08:00:00+00:00",
        "stops_at": "2023-02-09T08:00:00+00:00",
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
        "start_location_id": "3dc461e6-b4f1-4448-9f51-5dc96a82a9a1",
        "stop_location_id": "3dc461e6-b4f1-4448-9f51-5dc96a82a9a1"
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
      "id": "829d7390-61b3-419a-b006-826a36948d8a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T08:07:47+00:00",
        "updated_at": "2023-02-07T08:07:47+00:00",
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
        "item_id": "b06c61c5-591a-4885-94ac-0251f8846945",
        "tax_category_id": null,
        "planning_id": "6cb1ef1e-b370-435e-9993-fd889ad5c387",
        "parent_line_id": "6a0296f2-56d6-448a-a375-d73fdfde7d0c",
        "owner_id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe",
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
      "id": "6a0296f2-56d6-448a-a375-d73fdfde7d0c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-07T08:07:47+00:00",
        "updated_at": "2023-02-07T08:07:47+00:00",
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
        "item_id": "6f9e173a-b493-4957-91f2-2313e12af51c",
        "tax_category_id": null,
        "planning_id": "81918c36-f6fd-4492-acb5-0892b4f1e553",
        "parent_line_id": null,
        "owner_id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe",
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
      "id": "81918c36-f6fd-4492-acb5-0892b4f1e553",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-07T08:07:47+00:00",
        "updated_at": "2023-02-07T08:07:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-05T08:00:00+00:00",
        "stops_at": "2023-02-09T08:00:00+00:00",
        "reserved_from": "2023-02-05T08:00:00+00:00",
        "reserved_till": "2023-02-09T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "6f9e173a-b493-4957-91f2-2313e12af51c",
        "order_id": "e9a45f38-4f72-4f81-ab09-f0189b0fc2fe",
        "start_location_id": "3dc461e6-b4f1-4448-9f51-5dc96a82a9a1",
        "stop_location_id": "3dc461e6-b4f1-4448-9f51-5dc96a82a9a1",
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





