# Bookings

Add products, bundles and specific stock items to an order.

Items can be added quantitatively or, for trackable products, specific stock items can be specified. Specifying stock items is not required on booking; they can also be defined when transitioning the order status to a `started` state.

> Adding items quantitatively:

```
  "items": [
    {
      "type": "Product",
      "id": "69a6ac18-244e-4b1e-b2e1-c88d155b51e5",
      "quantity": 10
    }
  ]
```

> Adding specific stock items:

```
  "items": [
    {
      "type": "Product",
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

```
  "items": [
    {
      "type": "Bundle",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
    }
  ]
```

> Adding a bundle and specifying a variation (for product that has variations)

```
  "items": [
    {
      "type": "Bundle",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "products": [
        {
          type: "Product",
          bundle_item_id: "1456d221-029c-42ad-abcd-ad8d70c9e3f0",
          id: "ee64a622-3ac5-4859-a582-b3467b8027e8"
        }
      }
    }
  ]
```

**When a booking is successful, the price and status information of the order will be updated, and the following resources are created:**

- **Plannings** Quantitative data about the planning of an item.
- **Stock item plannings** Planning for specific stock items (when stock items are specified).
- **Lines** Individual elements on order, which in the case of bookings contain price and planning information.

Note that these newly created or updated resources can be included in the response. Also, lines will automatically be synced with a proforma invoice (and prorated if there was already a finalized invoice for this order).

**Adding items (and stock items) to a reserved order can result in shortage errors. There are three kinds of errors:**

1. **Stock item specified** This Means that one of the specified stock items is not available.
2. **Blocking shortage** A blocking shortage occurs when an item is quantitively unavailable and exceeds its `shortage_limit`.
3. **Shortage warning** Warns about a quantitive shortage for an item that is within limits of its `shortage_limit`.  The action can be retried with by setting `confirm_shortage` to `true`.

## Endpoints
`POST /api/boomerang/bookings`

## Fields
Every booking has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


## Relationships
Bookings have the following relationships:

Name | Description
- | -
`order` | **Orders** `readonly`<br>Associated Order
`lines` | **Lines** `readonly`<br>Associated Lines
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Creating a booking



> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "67b6e36a-6edc-43fa-932a-c75081c74fb6",
          "items": [
            {
              "type": "Product",
              "id": "ba76f59d-e784-491c-809c-eb8d08413803",
              "quantity": 10
            },
            {
              "type": "Product",
              "id": "52a53657-0208-4672-baa0-aebdf92fb5fe",
              "stock_item_ids": [
                "43d0de09-f40d-4361-b81f-a53035e4a41d",
                "947c67f8-2698-4c16-af63-6607d61d83fa"
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
            "item_id": "ba76f59d-e784-491c-809c-eb8d08413803",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "52a53657-0208-4672-baa0-aebdf92fb5fe",
            "unavailable": [
              "43d0de09-f40d-4361-b81f-a53035e4a41d"
            ],
            "available": [
              "947c67f8-2698-4c16-af63-6607d61d83fa"
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
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
          "items": [
            {
              "type": "Product",
              "id": "d88c4600-4a70-4299-9b4c-a401089a4f6d",
              "stock_item_ids": [
                "60e327ae-f6a1-4bca-a037-f7e29d4a6e79",
                "beacdeb6-dc8f-428b-9d70-b5105cd32e28",
                "80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd"
              ]
            },
            {
              "type": "Product",
              "id": "791c88c5-b222-44f9-b6fa-28a4330ba41e",
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
    "id": "51401b46-ee83-55d2-9197-ac5a82f5be46",
    "type": "bookings",
    "attributes": {
      "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "778b7009-32aa-469a-9d72-e52fe12f36f6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9c3b2f83-a99b-44b8-827b-f64264f0cc2a"
          },
          {
            "type": "lines",
            "id": "455c2be8-016e-4ea3-85be-6df2d0ed9e83"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e0509e1c-6833-42e3-8df5-e0e6ac4f1e16"
          },
          {
            "type": "plannings",
            "id": "6bb58fe2-6937-4695-ba92-5aa4402dfc3d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b5f15995-feec-4bf0-9765-23575fa74107"
          },
          {
            "type": "stock_item_plannings",
            "id": "4ef51a8b-ab97-4e81-8aa2-928cb3deba82"
          },
          {
            "type": "stock_item_plannings",
            "id": "3c296c46-fc7f-40e2-953a-41183ec70a96"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-17T21:04:20+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
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
        "customer_id": "0ef4dc95-9891-4e96-96f5-61d8ebab21b2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "ee30f0bc-7479-4343-82b6-09802554255a",
        "stop_location_id": "ee30f0bc-7479-4343-82b6-09802554255a"
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
        }
      }
    },
    {
      "id": "9c3b2f83-a99b-44b8-827b-f64264f0cc2a",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-17T21:04:21+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
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
        "owner_id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
        "owner_type": "Order",
        "item_id": "791c88c5-b222-44f9-b6fa-28a4330ba41e",
        "tax_category_id": "8602e506-2454-4d2b-9c22-3402b4e9c871",
        "parent_line_id": null
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
      "id": "455c2be8-016e-4ea3-85be-6df2d0ed9e83",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-17T21:04:22+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
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
        "owner_id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
        "owner_type": "Order",
        "item_id": "d88c4600-4a70-4299-9b4c-a401089a4f6d",
        "tax_category_id": "8602e506-2454-4d2b-9c22-3402b4e9c871",
        "parent_line_id": null
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
      "id": "e0509e1c-6833-42e3-8df5-e0e6ac4f1e16",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:21+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
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
        "item_id": "791c88c5-b222-44f9-b6fa-28a4330ba41e",
        "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
        "start_location_id": "ee30f0bc-7479-4343-82b6-09802554255a",
        "stop_location_id": "ee30f0bc-7479-4343-82b6-09802554255a",
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
      "id": "6bb58fe2-6937-4695-ba92-5aa4402dfc3d",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:22+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
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
        "item_id": "d88c4600-4a70-4299-9b4c-a401089a4f6d",
        "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6",
        "start_location_id": "ee30f0bc-7479-4343-82b6-09802554255a",
        "stop_location_id": "ee30f0bc-7479-4343-82b6-09802554255a",
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
      "id": "b5f15995-feec-4bf0-9765-23575fa74107",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:22+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "60e327ae-f6a1-4bca-a037-f7e29d4a6e79",
        "planning_id": "6bb58fe2-6937-4695-ba92-5aa4402dfc3d",
        "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6"
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
      "id": "4ef51a8b-ab97-4e81-8aa2-928cb3deba82",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:22+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "beacdeb6-dc8f-428b-9d70-b5105cd32e28",
        "planning_id": "6bb58fe2-6937-4695-ba92-5aa4402dfc3d",
        "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6"
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
      "id": "3c296c46-fc7f-40e2-953a-41183ec70a96",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:22+00:00",
        "updated_at": "2021-11-17T21:04:22+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd",
        "planning_id": "6bb58fe2-6937-4695-ba92-5aa4402dfc3d",
        "order_id": "778b7009-32aa-469a-9d72-e52fe12f36f6"
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d88c4600-4a70-4299-9b4c-a401089a4f6d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=60e327ae-f6a1-4bca-a037-f7e29d4a6e79&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=beacdeb6-dc8f-428b-9d70-b5105cd32e28&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=80b3d6c1-eb57-4f38-bb37-c5dc3c02afbd&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=791c88c5-b222-44f9-b6fa-28a4330ba41e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=778b7009-32aa-469a-9d72-e52fe12f36f6&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```


> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bookings",
        "attributes": {
          "order_id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81",
          "items": [
            {
              "type": "Bundle",
              "id": "5226daf9-cf99-456e-af8b-eaa3e32dfdc3",
              "products": [
                {
                  "type": "Product",
                  "bundle_item_id": "796e0595-afa4-4e0c-9afc-5cb1cea90eaa",
                  "id": "290bef13-3bbe-4b60-bf13-d477f78f8dd4"
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
    "id": "4119243b-d2ec-5964-b4fb-cd737d15c01a",
    "type": "bookings",
    "attributes": {
      "order_id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "ea8d82d4-a39d-4480-90bf-ee3e353ce074"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f0591d9e-61bb-455f-8866-4a2901532421"
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
      "id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-17T21:04:24+00:00",
        "updated_at": "2021-11-17T21:04:25+00:00",
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
        "starts_at": "2021-11-15T21:00:00+00:00",
        "stops_at": "2021-11-19T21:00:00+00:00",
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
        "start_location_id": "acdd2fae-b08e-403e-9a7b-876384aee0db",
        "stop_location_id": "acdd2fae-b08e-403e-9a7b-876384aee0db"
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
        }
      }
    },
    {
      "id": "ea8d82d4-a39d-4480-90bf-ee3e353ce074",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-17T21:04:25+00:00",
        "updated_at": "2021-11-17T21:04:25+00:00",
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
        "owner_id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81",
        "owner_type": "Order",
        "item_id": "5226daf9-cf99-456e-af8b-eaa3e32dfdc3",
        "tax_category_id": null,
        "parent_line_id": null
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
      "id": "f0591d9e-61bb-455f-8866-4a2901532421",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-17T21:04:25+00:00",
        "updated_at": "2021-11-17T21:04:25+00:00",
        "quantity": 1,
        "starts_at": "2021-11-15T21:00:00+00:00",
        "stops_at": "2021-11-19T21:00:00+00:00",
        "reserved_from": "2021-11-15T21:00:00+00:00",
        "reserved_till": "2021-11-19T21:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5226daf9-cf99-456e-af8b-eaa3e32dfdc3",
        "order_id": "4f970d78-5f3f-4fd4-bfe4-415e78f09d81",
        "start_location_id": "acdd2fae-b08e-403e-9a7b-876384aee0db",
        "stop_location_id": "acdd2fae-b08e-403e-9a7b-876384aee0db",
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&data%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&data%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&data%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=Bundle&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=5226daf9-cf99-456e-af8b-eaa3e32dfdc3&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=Product&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=796e0595-afa4-4e0c-9afc-5cb1cea90eaa&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=290bef13-3bbe-4b60-bf13-d477f78f8dd4&data%5Battributes%5D%5Border_id%5D=4f970d78-5f3f-4fd4-bfe4-415e78f09d81&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bookings`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bookings]=id,created_at,updated_at`


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





