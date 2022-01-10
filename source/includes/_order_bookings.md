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
          "order_id": "f28136a7-929a-42d2-a600-b395cc607a7c",
          "items": [
            {
              "type": "products",
              "id": "041c159c-b5c0-40ba-a2d9-694e99e79019",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "ff12a2f7-2f84-4495-a59e-38cf0310bfca",
              "stock_item_ids": [
                "f8347426-1f56-45f5-9d71-7247f6f0da2e",
                "24c5b2b8-96b7-4c3c-b5d8-b7f61bfe6079"
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
            "item_id": "041c159c-b5c0-40ba-a2d9-694e99e79019",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "ff12a2f7-2f84-4495-a59e-38cf0310bfca",
            "unavailable": [
              "f8347426-1f56-45f5-9d71-7247f6f0da2e"
            ],
            "available": [
              "24c5b2b8-96b7-4c3c-b5d8-b7f61bfe6079"
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
          "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
          "items": [
            {
              "type": "products",
              "id": "7d6737bf-fea5-4669-9f36-085f3fc8c610",
              "stock_item_ids": [
                "b2195a62-dd71-442a-a971-8c4784eed859",
                "17a3cf20-de89-45ab-bb50-610a6ab01c7f",
                "448b2d2a-e516-41a9-aef9-f2b25437cdde"
              ]
            },
            {
              "type": "products",
              "id": "64120bc6-46e9-49e7-b3b9-f4dcc0fc521b",
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
    "id": "6ecd6ae0-3e15-5760-82e1-a203f36a1874",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c97adf88-43cc-4e06-af64-49ab003f4a5d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "df202b0a-a34c-4096-88c4-111d97374ed1"
          },
          {
            "type": "lines",
            "id": "781ae7ef-a71a-4a45-8ee3-5878238045cf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a2043996-ba92-41de-b475-65bf096b2d9d"
          },
          {
            "type": "plannings",
            "id": "32746a71-cec0-4fa7-939b-bbed934c3d4c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0287e368-a3bc-4c3a-b731-d7ae59ebe5de"
          },
          {
            "type": "stock_item_plannings",
            "id": "7be10ae7-26d7-4826-8fff-7e91ce2c08e4"
          },
          {
            "type": "stock_item_plannings",
            "id": "3a273353-b8a1-4067-b8cc-9ba38ef4964a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-10T13:51:49+00:00",
        "updated_at": "2022-01-10T13:51:52+00:00",
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
        "customer_id": "45f64212-ae7e-4f98-a1fe-468c5ab35ca3",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701",
        "stop_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701"
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
      "id": "df202b0a-a34c-4096-88c4-111d97374ed1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-10T13:51:50+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
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
        "item_id": "64120bc6-46e9-49e7-b3b9-f4dcc0fc521b",
        "tax_category_id": "f53d0349-551b-4aa1-b080-e278ecc9a261",
        "planning_id": "a2043996-ba92-41de-b475-65bf096b2d9d",
        "parent_line_id": null,
        "owner_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
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
      "id": "781ae7ef-a71a-4a45-8ee3-5878238045cf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-10T13:51:51+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
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
        "item_id": "7d6737bf-fea5-4669-9f36-085f3fc8c610",
        "tax_category_id": "f53d0349-551b-4aa1-b080-e278ecc9a261",
        "planning_id": "32746a71-cec0-4fa7-939b-bbed934c3d4c",
        "parent_line_id": null,
        "owner_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
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
      "id": "a2043996-ba92-41de-b475-65bf096b2d9d",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:50+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
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
        "item_id": "64120bc6-46e9-49e7-b3b9-f4dcc0fc521b",
        "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
        "start_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701",
        "stop_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701",
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
      "id": "32746a71-cec0-4fa7-939b-bbed934c3d4c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:51+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
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
        "item_id": "7d6737bf-fea5-4669-9f36-085f3fc8c610",
        "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d",
        "start_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701",
        "stop_location_id": "56408fcc-8ded-438c-b18e-ba18df3e0701",
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
      "id": "0287e368-a3bc-4c3a-b731-d7ae59ebe5de",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:51+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b2195a62-dd71-442a-a971-8c4784eed859",
        "planning_id": "32746a71-cec0-4fa7-939b-bbed934c3d4c",
        "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d"
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
      "id": "7be10ae7-26d7-4826-8fff-7e91ce2c08e4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:51+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "17a3cf20-de89-45ab-bb50-610a6ab01c7f",
        "planning_id": "32746a71-cec0-4fa7-939b-bbed934c3d4c",
        "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d"
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
      "id": "3a273353-b8a1-4067-b8cc-9ba38ef4964a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:51+00:00",
        "updated_at": "2022-01-10T13:51:51+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "448b2d2a-e516-41a9-aef9-f2b25437cdde",
        "planning_id": "32746a71-cec0-4fa7-939b-bbed934c3d4c",
        "order_id": "c97adf88-43cc-4e06-af64-49ab003f4a5d"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=7d6737bf-fea5-4669-9f36-085f3fc8c610&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b2195a62-dd71-442a-a971-8c4784eed859&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=17a3cf20-de89-45ab-bb50-610a6ab01c7f&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=448b2d2a-e516-41a9-aef9-f2b25437cdde&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=64120bc6-46e9-49e7-b3b9-f4dcc0fc521b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=c97adf88-43cc-4e06-af64-49ab003f4a5d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "2348a0ac-baf6-4951-a962-1a88d96a298f",
          "items": [
            {
              "type": "bundles",
              "id": "3619c293-1803-42cc-b4f5-681748fce446",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d6f0aa7a-aa4c-4b38-85a1-25e850ced07b",
                  "id": "42921f4c-b09c-43b9-9029-29855d1bf2dd"
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
    "id": "bf890ae4-d893-57a2-8a58-1af209d04bac",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2348a0ac-baf6-4951-a962-1a88d96a298f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2348a0ac-baf6-4951-a962-1a88d96a298f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2f980e84-e5fa-4aff-868d-68953d616b33"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2798758c-7ddb-43e2-9127-16b60f7c3a2c"
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
      "id": "2348a0ac-baf6-4951-a962-1a88d96a298f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-01-10T13:51:55+00:00",
        "updated_at": "2022-01-10T13:51:56+00:00",
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
        "starts_at": "2022-01-08T13:45:00+00:00",
        "stops_at": "2022-01-12T13:45:00+00:00",
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
        "start_location_id": "fd8c6743-5bdb-4c35-bcfe-b496a6e6de00",
        "stop_location_id": "fd8c6743-5bdb-4c35-bcfe-b496a6e6de00"
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
      "id": "2f980e84-e5fa-4aff-868d-68953d616b33",
      "type": "lines",
      "attributes": {
        "created_at": "2022-01-10T13:51:56+00:00",
        "updated_at": "2022-01-10T13:51:56+00:00",
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
        "item_id": "3619c293-1803-42cc-b4f5-681748fce446",
        "tax_category_id": null,
        "planning_id": "2798758c-7ddb-43e2-9127-16b60f7c3a2c",
        "parent_line_id": null,
        "owner_id": "2348a0ac-baf6-4951-a962-1a88d96a298f",
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
      "id": "2798758c-7ddb-43e2-9127-16b60f7c3a2c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-01-10T13:51:56+00:00",
        "updated_at": "2022-01-10T13:51:56+00:00",
        "quantity": 1,
        "starts_at": "2022-01-08T13:45:00+00:00",
        "stops_at": "2022-01-12T13:45:00+00:00",
        "reserved_from": "2022-01-08T13:45:00+00:00",
        "reserved_till": "2022-01-12T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3619c293-1803-42cc-b4f5-681748fce446",
        "order_id": "2348a0ac-baf6-4951-a962-1a88d96a298f",
        "start_location_id": "fd8c6743-5bdb-4c35-bcfe-b496a6e6de00",
        "stop_location_id": "fd8c6743-5bdb-4c35-bcfe-b496a6e6de00",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&data%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&data%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&data%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&data%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3619c293-1803-42cc-b4f5-681748fce446&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=d6f0aa7a-aa4c-4b38-85a1-25e850ced07b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=42921f4c-b09c-43b9-9029-29855d1bf2dd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=2348a0ac-baf6-4951-a962-1a88d96a298f&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





