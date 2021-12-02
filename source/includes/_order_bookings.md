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
          "order_id": "68edbef8-edd3-4326-a90b-8ed279d5e046",
          "items": [
            {
              "type": "products",
              "id": "3033e75f-2def-4f9b-8fb7-9e5ce4b5ff7d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c8b8ff1f-54fd-4bc2-a91c-982419c3728b",
              "stock_item_ids": [
                "9c5690d9-dec0-405f-9e32-ac5dd5feb52b",
                "d10480f7-d79d-4354-8e9a-6ecd7b209fd6"
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
            "item_id": "3033e75f-2def-4f9b-8fb7-9e5ce4b5ff7d",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "c8b8ff1f-54fd-4bc2-a91c-982419c3728b",
            "unavailable": [
              "9c5690d9-dec0-405f-9e32-ac5dd5feb52b"
            ],
            "available": [
              "d10480f7-d79d-4354-8e9a-6ecd7b209fd6"
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
          "order_id": "019699fa-c383-4813-8063-796d290fecf5",
          "items": [
            {
              "type": "products",
              "id": "9dd1108b-75c6-45f5-a602-7e7d907d8288",
              "stock_item_ids": [
                "9ba884e0-7aec-4c9e-b236-041cc1619dc7",
                "f1d29b42-675c-4603-9dfd-2f3328296381",
                "1f7f08e0-ead9-4a1e-8bbb-769e72d05915"
              ]
            },
            {
              "type": "products",
              "id": "ca793bcb-9dd3-4a29-9225-0f290ea84fa6",
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
    "id": "559dbd5c-55e3-51fc-9187-46ba8f854e5e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "019699fa-c383-4813-8063-796d290fecf5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "019699fa-c383-4813-8063-796d290fecf5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a5b80f6b-22e4-4615-a30f-2deeca2c902b"
          },
          {
            "type": "lines",
            "id": "022804fb-52fc-4f90-a23b-6990c1bdc774"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1d6f93bf-ee9d-4e0b-b212-142d429c2004"
          },
          {
            "type": "plannings",
            "id": "8e7329f3-1312-4149-ae6d-b9894d14ab7b"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "fa3f4b89-e6ce-4495-ac08-11385744a970"
          },
          {
            "type": "stock_item_plannings",
            "id": "fb3ca893-34f2-41d2-843b-6591e40361d9"
          },
          {
            "type": "stock_item_plannings",
            "id": "51d66ec7-b9b8-4c68-a3c1-95fda2a3965d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "019699fa-c383-4813-8063-796d290fecf5",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T16:48:47+00:00",
        "updated_at": "2021-12-02T16:48:50+00:00",
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
        "customer_id": "b1279c8b-d606-4397-b244-13ea3aa5a6b1",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9",
        "stop_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9"
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
      "id": "a5b80f6b-22e4-4615-a30f-2deeca2c902b",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T16:48:48+00:00",
        "updated_at": "2021-12-02T16:48:50+00:00",
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
        "item_id": "ca793bcb-9dd3-4a29-9225-0f290ea84fa6",
        "tax_category_id": "dd565cd7-a56a-4f87-8e54-13914bacf57d",
        "parent_line_id": null,
        "owner_id": "019699fa-c383-4813-8063-796d290fecf5",
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
      "id": "022804fb-52fc-4f90-a23b-6990c1bdc774",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T16:48:49+00:00",
        "updated_at": "2021-12-02T16:48:50+00:00",
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
        "item_id": "9dd1108b-75c6-45f5-a602-7e7d907d8288",
        "tax_category_id": "dd565cd7-a56a-4f87-8e54-13914bacf57d",
        "parent_line_id": null,
        "owner_id": "019699fa-c383-4813-8063-796d290fecf5",
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
      "id": "1d6f93bf-ee9d-4e0b-b212-142d429c2004",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:49+00:00",
        "updated_at": "2021-12-02T16:48:49+00:00",
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
        "item_id": "9dd1108b-75c6-45f5-a602-7e7d907d8288",
        "order_id": "019699fa-c383-4813-8063-796d290fecf5",
        "start_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9",
        "stop_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9",
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
      "id": "8e7329f3-1312-4149-ae6d-b9894d14ab7b",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:48+00:00",
        "updated_at": "2021-12-02T16:48:49+00:00",
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
        "item_id": "ca793bcb-9dd3-4a29-9225-0f290ea84fa6",
        "order_id": "019699fa-c383-4813-8063-796d290fecf5",
        "start_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9",
        "stop_location_id": "9833a7ef-ddc6-463b-9662-22d808ba7de9",
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
      "id": "fa3f4b89-e6ce-4495-ac08-11385744a970",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:49+00:00",
        "updated_at": "2021-12-02T16:48:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9ba884e0-7aec-4c9e-b236-041cc1619dc7",
        "planning_id": "1d6f93bf-ee9d-4e0b-b212-142d429c2004",
        "order_id": "019699fa-c383-4813-8063-796d290fecf5"
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
      "id": "fb3ca893-34f2-41d2-843b-6591e40361d9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:49+00:00",
        "updated_at": "2021-12-02T16:48:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f1d29b42-675c-4603-9dfd-2f3328296381",
        "planning_id": "1d6f93bf-ee9d-4e0b-b212-142d429c2004",
        "order_id": "019699fa-c383-4813-8063-796d290fecf5"
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
      "id": "51d66ec7-b9b8-4c68-a3c1-95fda2a3965d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:49+00:00",
        "updated_at": "2021-12-02T16:48:49+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1f7f08e0-ead9-4a1e-8bbb-769e72d05915",
        "planning_id": "1d6f93bf-ee9d-4e0b-b212-142d429c2004",
        "order_id": "019699fa-c383-4813-8063-796d290fecf5"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=9dd1108b-75c6-45f5-a602-7e7d907d8288&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=9ba884e0-7aec-4c9e-b236-041cc1619dc7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f1d29b42-675c-4603-9dfd-2f3328296381&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=1f7f08e0-ead9-4a1e-8bbb-769e72d05915&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=ca793bcb-9dd3-4a29-9225-0f290ea84fa6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=019699fa-c383-4813-8063-796d290fecf5&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "4da28894-6238-4efb-aec2-81140f0a89cc",
          "items": [
            {
              "type": "bundles",
              "id": "d6632539-9b5f-4695-b0c3-d0521d065c30",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "02523076-2681-44a2-b7ea-2230ba714d6c",
                  "id": "2c833976-d997-46e5-b945-0d4954e31653"
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
    "id": "a261b54f-5f6a-5f4c-bba2-48ae4d2cdcfd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4da28894-6238-4efb-aec2-81140f0a89cc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4da28894-6238-4efb-aec2-81140f0a89cc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "15302842-edca-4527-ad09-60cc521832e2"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8629ba2d-0a63-418a-8e59-295db9d814eb"
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
      "id": "4da28894-6238-4efb-aec2-81140f0a89cc",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T16:48:52+00:00",
        "updated_at": "2021-12-02T16:48:54+00:00",
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
        "starts_at": "2021-11-30T16:45:00+00:00",
        "stops_at": "2021-12-04T16:45:00+00:00",
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
        "start_location_id": "4de4792b-e28e-43eb-a609-adcc1d815e82",
        "stop_location_id": "4de4792b-e28e-43eb-a609-adcc1d815e82"
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
      "id": "15302842-edca-4527-ad09-60cc521832e2",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T16:48:53+00:00",
        "updated_at": "2021-12-02T16:48:53+00:00",
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
        "item_id": "d6632539-9b5f-4695-b0c3-d0521d065c30",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "4da28894-6238-4efb-aec2-81140f0a89cc",
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
      "id": "8629ba2d-0a63-418a-8e59-295db9d814eb",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T16:48:53+00:00",
        "updated_at": "2021-12-02T16:48:53+00:00",
        "quantity": 1,
        "starts_at": "2021-11-30T16:45:00+00:00",
        "stops_at": "2021-12-04T16:45:00+00:00",
        "reserved_from": "2021-11-30T16:45:00+00:00",
        "reserved_till": "2021-12-04T16:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "d6632539-9b5f-4695-b0c3-d0521d065c30",
        "order_id": "4da28894-6238-4efb-aec2-81140f0a89cc",
        "start_location_id": "4de4792b-e28e-43eb-a609-adcc1d815e82",
        "stop_location_id": "4de4792b-e28e-43eb-a609-adcc1d815e82",
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&data%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&data%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&data%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&data%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=d6632539-9b5f-4695-b0c3-d0521d065c30&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=02523076-2681-44a2-b7ea-2230ba714d6c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=2c833976-d997-46e5-b945-0d4954e31653&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=4da28894-6238-4efb-aec2-81140f0a89cc&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





