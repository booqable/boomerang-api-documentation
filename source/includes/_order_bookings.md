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
          "order_id": "fa937d9c-29b2-4494-afb8-faf3af9809c3",
          "items": [
            {
              "type": "products",
              "id": "5b3cf800-ed01-4a63-b64b-de1c491d4e9d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "60836613-e752-477f-a53b-4732a76623ba",
              "stock_item_ids": [
                "d6fe8ecf-6504-42e6-a088-1462139416fa",
                "5f11575b-b3c7-4e25-a13b-40b2b7297db6"
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
            "item_id": "5b3cf800-ed01-4a63-b64b-de1c491d4e9d",
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
          "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
          "items": [
            {
              "type": "products",
              "id": "75783b08-dfb1-4a2f-a23e-63945b677c6f",
              "stock_item_ids": [
                "2651a0d4-1086-4596-b8e4-d5115844820c",
                "d291b28d-bf3a-4c6e-a5c2-c046b29ae8a3",
                "73d5e096-5ba5-4771-9a2e-f824e007f559"
              ]
            },
            {
              "type": "products",
              "id": "216ac171-069a-4235-8b15-30a718a66f86",
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
    "id": "d071cbc1-f785-58a4-83b5-0764ce59de4f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6759296b-af0c-49e5-a309-bb7f02a7e31a"
          },
          {
            "type": "lines",
            "id": "23734fe4-5128-4d16-a03d-ae24d4cad348"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1"
          },
          {
            "type": "plannings",
            "id": "88735320-37bc-42b6-a1ac-19a774090bb6"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "51488ad6-569d-434c-bbea-eff68e7e4ab8"
          },
          {
            "type": "stock_item_plannings",
            "id": "10ffe82f-1c3d-43bd-b8cc-94d63b379d7f"
          },
          {
            "type": "stock_item_plannings",
            "id": "9943df1e-2717-4b9c-a3ed-485a79970c62"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T08:36:49+00:00",
        "updated_at": "2023-02-08T08:36:52+00:00",
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
        "customer_id": "22b16b83-a02a-4b66-89d4-a4a7329bad59",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1",
        "stop_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1"
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
      "id": "6759296b-af0c-49e5-a309-bb7f02a7e31a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:51+00:00",
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
        "item_id": "75783b08-dfb1-4a2f-a23e-63945b677c6f",
        "tax_category_id": "ba6c71d5-1841-4115-8d21-608d561fb5e0",
        "planning_id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1",
        "parent_line_id": null,
        "owner_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
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
      "id": "23734fe4-5128-4d16-a03d-ae24d4cad348",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:51+00:00",
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
        "item_id": "216ac171-069a-4235-8b15-30a718a66f86",
        "tax_category_id": "ba6c71d5-1841-4115-8d21-608d561fb5e0",
        "planning_id": "88735320-37bc-42b6-a1ac-19a774090bb6",
        "parent_line_id": null,
        "owner_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
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
      "id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:52+00:00",
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
        "item_id": "75783b08-dfb1-4a2f-a23e-63945b677c6f",
        "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
        "start_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1",
        "stop_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1",
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
      "id": "88735320-37bc-42b6-a1ac-19a774090bb6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:52+00:00",
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
        "item_id": "216ac171-069a-4235-8b15-30a718a66f86",
        "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee",
        "start_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1",
        "stop_location_id": "02fbccb3-eb6e-4e74-9a17-9ad2051a49b1",
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
      "id": "51488ad6-569d-434c-bbea-eff68e7e4ab8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2651a0d4-1086-4596-b8e4-d5115844820c",
        "planning_id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1",
        "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee"
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
      "id": "10ffe82f-1c3d-43bd-b8cc-94d63b379d7f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d291b28d-bf3a-4c6e-a5c2-c046b29ae8a3",
        "planning_id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1",
        "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee"
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
      "id": "9943df1e-2717-4b9c-a3ed-485a79970c62",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:51+00:00",
        "updated_at": "2023-02-08T08:36:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "73d5e096-5ba5-4771-9a2e-f824e007f559",
        "planning_id": "63a4c0e6-7b0d-46ed-8b48-c493d28c65e1",
        "order_id": "06c5db83-1a96-4beb-96a1-0debb4b6e0ee"
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
          "order_id": "0e4d65e9-9b82-491a-993e-9f2409af31b1",
          "items": [
            {
              "type": "bundles",
              "id": "776d55de-b5eb-4002-ba00-bbcb3e23cb76",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "82d73278-9653-49ad-9c54-da9e9d4f8e94",
                  "id": "90cce9d8-1eba-427d-b5c9-8f0ccacabda0"
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
    "id": "a8d87d8d-e411-52fc-b8fa-85cd941fac75",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0e4d65e9-9b82-491a-993e-9f2409af31b1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0e4d65e9-9b82-491a-993e-9f2409af31b1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3cae21f6-f38d-4c94-9fa3-87a42ed57279"
          },
          {
            "type": "lines",
            "id": "deb6fbf4-b9df-4deb-abe6-f5a3df5ab385"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "93a4026e-a816-45a2-8c3f-10d06a9fa96d"
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
      "id": "0e4d65e9-9b82-491a-993e-9f2409af31b1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T08:36:54+00:00",
        "updated_at": "2023-02-08T08:36:55+00:00",
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
        "starts_at": "2023-02-06T08:30:00+00:00",
        "stops_at": "2023-02-10T08:30:00+00:00",
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
        "start_location_id": "fae9fea7-f5fa-40f4-b7a9-30d19d2f8b2e",
        "stop_location_id": "fae9fea7-f5fa-40f4-b7a9-30d19d2f8b2e"
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
      "id": "3cae21f6-f38d-4c94-9fa3-87a42ed57279",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:55+00:00",
        "updated_at": "2023-02-08T08:36:55+00:00",
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
        "item_id": "776d55de-b5eb-4002-ba00-bbcb3e23cb76",
        "tax_category_id": null,
        "planning_id": "93a4026e-a816-45a2-8c3f-10d06a9fa96d",
        "parent_line_id": null,
        "owner_id": "0e4d65e9-9b82-491a-993e-9f2409af31b1",
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
      "id": "deb6fbf4-b9df-4deb-abe6-f5a3df5ab385",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T08:36:55+00:00",
        "updated_at": "2023-02-08T08:36:55+00:00",
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
        "item_id": "90cce9d8-1eba-427d-b5c9-8f0ccacabda0",
        "tax_category_id": null,
        "planning_id": "e6043957-a3b2-44f3-b945-ed1789c6ef14",
        "parent_line_id": "3cae21f6-f38d-4c94-9fa3-87a42ed57279",
        "owner_id": "0e4d65e9-9b82-491a-993e-9f2409af31b1",
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
      "id": "93a4026e-a816-45a2-8c3f-10d06a9fa96d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T08:36:55+00:00",
        "updated_at": "2023-02-08T08:36:55+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T08:30:00+00:00",
        "stops_at": "2023-02-10T08:30:00+00:00",
        "reserved_from": "2023-02-06T08:30:00+00:00",
        "reserved_till": "2023-02-10T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "776d55de-b5eb-4002-ba00-bbcb3e23cb76",
        "order_id": "0e4d65e9-9b82-491a-993e-9f2409af31b1",
        "start_location_id": "fae9fea7-f5fa-40f4-b7a9-30d19d2f8b2e",
        "stop_location_id": "fae9fea7-f5fa-40f4-b7a9-30d19d2f8b2e",
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





