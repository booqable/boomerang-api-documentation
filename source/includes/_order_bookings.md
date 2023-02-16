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
          "order_id": "214a2048-65de-4cef-9c05-0b35d93202be",
          "items": [
            {
              "type": "products",
              "id": "ef60dec9-b47f-457e-8d5e-9581dca227fd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "96c43a68-468d-4d55-a97d-6da4e7006305",
              "stock_item_ids": [
                "2d9c913f-036e-40e1-a510-6481cb9154c7",
                "2345a9c6-7baf-47fd-aaaf-4186975eaa4d"
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
          "stock_item_id 2d9c913f-036e-40e1-a510-6481cb9154c7 has already been booked on this order"
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
          "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
          "items": [
            {
              "type": "products",
              "id": "dbce4f82-ca06-4489-9a61-94b1bfe37a36",
              "stock_item_ids": [
                "7c2f1a16-02e6-4a2f-80b3-d935d3ccd806",
                "4ce8ffa8-15b3-491e-90c7-487a3b020736",
                "d9f18d32-50e4-45c3-90de-743df1afd573"
              ]
            },
            {
              "type": "products",
              "id": "4dd45622-f633-4f72-bd77-3f36e007ee6b",
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
    "id": "dc1035a5-536f-5269-97c8-26f9ca9139f5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "63f278c9-4147-4fe2-aa9d-b393fe469736"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6b364e19-1bf0-40b2-96fe-d5ae485cc62a"
          },
          {
            "type": "lines",
            "id": "57886d95-4713-454e-8beb-0a77e1030642"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1e3bf443-aaef-4407-850c-6eecc0d55005"
          },
          {
            "type": "plannings",
            "id": "b39f08a8-4285-4f0f-bcf4-3b55be620194"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2738f42f-3f75-4453-86ec-e231fa4cfd81"
          },
          {
            "type": "stock_item_plannings",
            "id": "f3655dc8-6ae6-44b9-962d-b3b142d3e88c"
          },
          {
            "type": "stock_item_plannings",
            "id": "ca477b79-87f8-4e27-bd81-6453653267ed"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T11:21:35+00:00",
        "updated_at": "2023-02-16T11:21:37+00:00",
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
        "customer_id": "7a8b833f-2257-4b10-b6b9-602a7b7a4cc4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c",
        "stop_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c"
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
      "id": "6b364e19-1bf0-40b2-96fe-d5ae485cc62a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
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
        "item_id": "dbce4f82-ca06-4489-9a61-94b1bfe37a36",
        "tax_category_id": "6852557c-a1ba-4f6f-9ad8-2f934c4b1c2a",
        "planning_id": "1e3bf443-aaef-4407-850c-6eecc0d55005",
        "parent_line_id": null,
        "owner_id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
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
      "id": "57886d95-4713-454e-8beb-0a77e1030642",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
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
        "item_id": "4dd45622-f633-4f72-bd77-3f36e007ee6b",
        "tax_category_id": "6852557c-a1ba-4f6f-9ad8-2f934c4b1c2a",
        "planning_id": "b39f08a8-4285-4f0f-bcf4-3b55be620194",
        "parent_line_id": null,
        "owner_id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
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
      "id": "1e3bf443-aaef-4407-850c-6eecc0d55005",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
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
        "item_id": "dbce4f82-ca06-4489-9a61-94b1bfe37a36",
        "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
        "start_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c",
        "stop_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c",
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
      "id": "b39f08a8-4285-4f0f-bcf4-3b55be620194",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
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
        "item_id": "4dd45622-f633-4f72-bd77-3f36e007ee6b",
        "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736",
        "start_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c",
        "stop_location_id": "b3719b0b-058b-4fd2-8369-14b066c5081c",
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
      "id": "2738f42f-3f75-4453-86ec-e231fa4cfd81",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7c2f1a16-02e6-4a2f-80b3-d935d3ccd806",
        "planning_id": "1e3bf443-aaef-4407-850c-6eecc0d55005",
        "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736"
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
      "id": "f3655dc8-6ae6-44b9-962d-b3b142d3e88c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4ce8ffa8-15b3-491e-90c7-487a3b020736",
        "planning_id": "1e3bf443-aaef-4407-850c-6eecc0d55005",
        "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736"
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
      "id": "ca477b79-87f8-4e27-bd81-6453653267ed",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:36+00:00",
        "updated_at": "2023-02-16T11:21:36+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d9f18d32-50e4-45c3-90de-743df1afd573",
        "planning_id": "1e3bf443-aaef-4407-850c-6eecc0d55005",
        "order_id": "63f278c9-4147-4fe2-aa9d-b393fe469736"
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
          "order_id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a",
          "items": [
            {
              "type": "bundles",
              "id": "4067b14d-918f-42c5-96f4-8748c2bb3d7b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "7abd10ae-89ae-4852-8c7f-e480b09cf553",
                  "id": "c0a49321-a7bb-4dbf-8df6-d8f548921166"
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
    "id": "95957355-6a02-5ea1-9d83-16e9e7526404",
    "type": "order_bookings",
    "attributes": {
      "order_id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "517d9cf7-4aa3-4308-b990-4e4d29b726a3"
          },
          {
            "type": "lines",
            "id": "26760274-381f-4df5-bb9e-f13c2ab0a419"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f522b741-29ec-4203-b8e4-6e6220052980"
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
      "id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-16T11:21:39+00:00",
        "updated_at": "2023-02-16T11:21:40+00:00",
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
        "starts_at": "2023-02-14T11:15:00+00:00",
        "stops_at": "2023-02-18T11:15:00+00:00",
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
        "start_location_id": "3be4967e-402b-453e-b376-a61e1a23e766",
        "stop_location_id": "3be4967e-402b-453e-b376-a61e1a23e766"
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
      "id": "517d9cf7-4aa3-4308-b990-4e4d29b726a3",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:21:40+00:00",
        "updated_at": "2023-02-16T11:21:40+00:00",
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
        "item_id": "c0a49321-a7bb-4dbf-8df6-d8f548921166",
        "tax_category_id": null,
        "planning_id": "6130d617-1ba7-41b5-bedb-549e19212732",
        "parent_line_id": "26760274-381f-4df5-bb9e-f13c2ab0a419",
        "owner_id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a",
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
      "id": "26760274-381f-4df5-bb9e-f13c2ab0a419",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-16T11:21:40+00:00",
        "updated_at": "2023-02-16T11:21:40+00:00",
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
        "item_id": "4067b14d-918f-42c5-96f4-8748c2bb3d7b",
        "tax_category_id": null,
        "planning_id": "f522b741-29ec-4203-b8e4-6e6220052980",
        "parent_line_id": null,
        "owner_id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a",
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
      "id": "f522b741-29ec-4203-b8e4-6e6220052980",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-16T11:21:39+00:00",
        "updated_at": "2023-02-16T11:21:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-14T11:15:00+00:00",
        "stops_at": "2023-02-18T11:15:00+00:00",
        "reserved_from": "2023-02-14T11:15:00+00:00",
        "reserved_till": "2023-02-18T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "4067b14d-918f-42c5-96f4-8748c2bb3d7b",
        "order_id": "903d71fa-f9b5-45a6-97ed-44e33434fc9a",
        "start_location_id": "3be4967e-402b-453e-b376-a61e1a23e766",
        "stop_location_id": "3be4967e-402b-453e-b376-a61e1a23e766",
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





