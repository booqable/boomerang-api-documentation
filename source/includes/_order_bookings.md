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
          "order_id": "34322567-fe55-4fa2-a9c1-86e7376882c5",
          "items": [
            {
              "type": "products",
              "id": "f5a66a2a-7e53-45a3-8ec1-73af45515b31",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "25a40d77-9568-4366-82e0-fec25b4988a5",
              "stock_item_ids": [
                "a429ebb0-0919-461f-8c03-ed3fbc15a43c",
                "c721f6a5-67ad-4720-8926-09dc1cdf5bad"
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
            "item_id": "f5a66a2a-7e53-45a3-8ec1-73af45515b31",
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
          "order_id": "337139f1-37c5-4013-bc97-0e2573468c97",
          "items": [
            {
              "type": "products",
              "id": "a624c208-a220-4836-9ac7-24c0056249fd",
              "stock_item_ids": [
                "18d88aa8-d200-4e6c-9b3b-5aaaad0b02f5",
                "8e616315-1d3d-4e63-b9c0-284e5b6c4320",
                "bfd2ae2f-234a-40b3-8210-3bf844a73845"
              ]
            },
            {
              "type": "products",
              "id": "03e54b33-33ad-4fbf-bbd6-dab3f1556ce3",
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
    "id": "d3d27539-561d-5baf-bb25-350d003d505c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "337139f1-37c5-4013-bc97-0e2573468c97"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "337139f1-37c5-4013-bc97-0e2573468c97"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "66014914-9f6e-4f00-b5a8-2d18e026d9d1"
          },
          {
            "type": "lines",
            "id": "6b2bbcdb-d58d-4ad9-9e6b-6547edd65d02"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "46ab0a84-69ad-4512-8074-975c4c17e68e"
          },
          {
            "type": "plannings",
            "id": "829dd43b-9952-46ab-b53e-a31be5d8a5c4"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9f52d4b9-d9e2-47db-abcc-175be63641c2"
          },
          {
            "type": "stock_item_plannings",
            "id": "69ac2cdf-c3d2-478f-8c8a-f8d419bbb23f"
          },
          {
            "type": "stock_item_plannings",
            "id": "1c945e5b-01b4-428c-ba7e-2b97ffaa0d39"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "337139f1-37c5-4013-bc97-0e2573468c97",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-10T11:16:50+00:00",
        "updated_at": "2023-02-10T11:16:52+00:00",
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
        "customer_id": "0b1a2c61-66be-419e-8a1b-64050c8bc642",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248",
        "stop_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248"
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
      "id": "66014914-9f6e-4f00-b5a8-2d18e026d9d1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:52+00:00",
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
        "item_id": "a624c208-a220-4836-9ac7-24c0056249fd",
        "tax_category_id": "8b729aa7-f4e9-4bdf-95ca-a32e8dbdac19",
        "planning_id": "46ab0a84-69ad-4512-8074-975c4c17e68e",
        "parent_line_id": null,
        "owner_id": "337139f1-37c5-4013-bc97-0e2573468c97",
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
      "id": "6b2bbcdb-d58d-4ad9-9e6b-6547edd65d02",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:52+00:00",
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
        "item_id": "03e54b33-33ad-4fbf-bbd6-dab3f1556ce3",
        "tax_category_id": "8b729aa7-f4e9-4bdf-95ca-a32e8dbdac19",
        "planning_id": "829dd43b-9952-46ab-b53e-a31be5d8a5c4",
        "parent_line_id": null,
        "owner_id": "337139f1-37c5-4013-bc97-0e2573468c97",
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
      "id": "46ab0a84-69ad-4512-8074-975c4c17e68e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:52+00:00",
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
        "item_id": "a624c208-a220-4836-9ac7-24c0056249fd",
        "order_id": "337139f1-37c5-4013-bc97-0e2573468c97",
        "start_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248",
        "stop_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248",
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
      "id": "829dd43b-9952-46ab-b53e-a31be5d8a5c4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:52+00:00",
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
        "item_id": "03e54b33-33ad-4fbf-bbd6-dab3f1556ce3",
        "order_id": "337139f1-37c5-4013-bc97-0e2573468c97",
        "start_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248",
        "stop_location_id": "aa01d92b-17d9-40ba-a493-6a908f40e248",
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
      "id": "9f52d4b9-d9e2-47db-abcc-175be63641c2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "18d88aa8-d200-4e6c-9b3b-5aaaad0b02f5",
        "planning_id": "46ab0a84-69ad-4512-8074-975c4c17e68e",
        "order_id": "337139f1-37c5-4013-bc97-0e2573468c97"
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
      "id": "69ac2cdf-c3d2-478f-8c8a-f8d419bbb23f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e616315-1d3d-4e63-b9c0-284e5b6c4320",
        "planning_id": "46ab0a84-69ad-4512-8074-975c4c17e68e",
        "order_id": "337139f1-37c5-4013-bc97-0e2573468c97"
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
      "id": "1c945e5b-01b4-428c-ba7e-2b97ffaa0d39",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:51+00:00",
        "updated_at": "2023-02-10T11:16:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "bfd2ae2f-234a-40b3-8210-3bf844a73845",
        "planning_id": "46ab0a84-69ad-4512-8074-975c4c17e68e",
        "order_id": "337139f1-37c5-4013-bc97-0e2573468c97"
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
          "order_id": "7e13e949-9549-4e23-b129-07bcf9a022d8",
          "items": [
            {
              "type": "bundles",
              "id": "b36d6ac8-6030-4885-86d5-5b0282e2b8e8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2600dfea-1e19-4a12-bd2e-deee8c31040f",
                  "id": "f037df94-dfc6-4125-99de-602d0fa323c2"
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
    "id": "b756e41f-16cf-53c4-8f58-38801d334230",
    "type": "order_bookings",
    "attributes": {
      "order_id": "7e13e949-9549-4e23-b129-07bcf9a022d8"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "7e13e949-9549-4e23-b129-07bcf9a022d8"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "69ae8968-22b3-4563-967a-92a31da8cde8"
          },
          {
            "type": "lines",
            "id": "4a527317-b910-4061-827c-63c63815643c"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "28553ac3-50eb-4e12-aeb7-e29d1992f2de"
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
      "id": "7e13e949-9549-4e23-b129-07bcf9a022d8",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-10T11:16:54+00:00",
        "updated_at": "2023-02-10T11:16:54+00:00",
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
        "starts_at": "2023-02-08T11:15:00+00:00",
        "stops_at": "2023-02-12T11:15:00+00:00",
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
        "start_location_id": "892e37b1-edc0-4597-a534-fc5decbc42c1",
        "stop_location_id": "892e37b1-edc0-4597-a534-fc5decbc42c1"
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
      "id": "69ae8968-22b3-4563-967a-92a31da8cde8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-10T11:16:54+00:00",
        "updated_at": "2023-02-10T11:16:54+00:00",
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
        "item_id": "b36d6ac8-6030-4885-86d5-5b0282e2b8e8",
        "tax_category_id": null,
        "planning_id": "28553ac3-50eb-4e12-aeb7-e29d1992f2de",
        "parent_line_id": null,
        "owner_id": "7e13e949-9549-4e23-b129-07bcf9a022d8",
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
      "id": "4a527317-b910-4061-827c-63c63815643c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-10T11:16:54+00:00",
        "updated_at": "2023-02-10T11:16:54+00:00",
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
        "item_id": "f037df94-dfc6-4125-99de-602d0fa323c2",
        "tax_category_id": null,
        "planning_id": "c044c5de-b562-4816-97ad-78f03c638f70",
        "parent_line_id": "69ae8968-22b3-4563-967a-92a31da8cde8",
        "owner_id": "7e13e949-9549-4e23-b129-07bcf9a022d8",
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
      "id": "28553ac3-50eb-4e12-aeb7-e29d1992f2de",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-10T11:16:54+00:00",
        "updated_at": "2023-02-10T11:16:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-08T11:15:00+00:00",
        "stops_at": "2023-02-12T11:15:00+00:00",
        "reserved_from": "2023-02-08T11:15:00+00:00",
        "reserved_till": "2023-02-12T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b36d6ac8-6030-4885-86d5-5b0282e2b8e8",
        "order_id": "7e13e949-9549-4e23-b129-07bcf9a022d8",
        "start_location_id": "892e37b1-edc0-4597-a534-fc5decbc42c1",
        "stop_location_id": "892e37b1-edc0-4597-a534-fc5decbc42c1",
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





