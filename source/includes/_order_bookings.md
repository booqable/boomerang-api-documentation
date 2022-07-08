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
          "order_id": "8d666d4d-1929-4f3e-bb08-eb46a435f6c8",
          "items": [
            {
              "type": "products",
              "id": "2d200bee-f744-45ee-b7a9-50becb8f1183",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "03d87225-8202-49fc-86da-ad839776d1bd",
              "stock_item_ids": [
                "a6ce17eb-d498-4901-adfc-88faf3ce6dde",
                "56aaf530-60df-4057-b614-b2f9d1ad4d23"
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
            "item_id": "2d200bee-f744-45ee-b7a9-50becb8f1183",
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
          "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
          "items": [
            {
              "type": "products",
              "id": "b6a400f7-464b-41b7-b08c-8235822a7e5a",
              "stock_item_ids": [
                "2eab0718-6846-4671-a89c-98e83fc90187",
                "1289269d-bee1-4d46-a8b2-58cf7dd74f3a",
                "ad7d2b8c-6d31-4931-90da-b82c5601a7ba"
              ]
            },
            {
              "type": "products",
              "id": "f7ff2524-e323-4a71-bc4c-c25531cc6566",
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
    "id": "c12e22c2-95b4-555d-a84f-fcf890bcd298",
    "type": "order_bookings",
    "attributes": {
      "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "064c81d4-8308-46e4-8abb-297eba8ad01e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f6356cab-aef7-4280-b6af-9e08390b9409"
          },
          {
            "type": "lines",
            "id": "616acd7b-d720-4c0e-ba37-6a993811e350"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "208ec08f-569c-49f1-a8de-eae6c2a2b786"
          },
          {
            "type": "plannings",
            "id": "7bce8202-c012-4413-861c-314fa7474cb3"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "795c0853-4311-421e-9247-a4b1b82fca94"
          },
          {
            "type": "stock_item_plannings",
            "id": "2f293e3d-d9c5-40b3-9326-cc084a215988"
          },
          {
            "type": "stock_item_plannings",
            "id": "4ddaaa9d-bea0-400d-bda0-3d23495c86e8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T11:45:29+00:00",
        "updated_at": "2022-07-08T11:45:32+00:00",
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
        "customer_id": "91e8df2f-a131-4211-b382-6abcee682b5f",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d",
        "stop_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d"
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
      "id": "f6356cab-aef7-4280-b6af-9e08390b9409",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T11:45:30+00:00",
        "updated_at": "2022-07-08T11:45:31+00:00",
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
        "item_id": "f7ff2524-e323-4a71-bc4c-c25531cc6566",
        "tax_category_id": "63692385-b664-43bb-8f66-5868ce5dfd54",
        "planning_id": "208ec08f-569c-49f1-a8de-eae6c2a2b786",
        "parent_line_id": null,
        "owner_id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
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
      "id": "616acd7b-d720-4c0e-ba37-6a993811e350",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T11:45:31+00:00",
        "updated_at": "2022-07-08T11:45:31+00:00",
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
        "item_id": "b6a400f7-464b-41b7-b08c-8235822a7e5a",
        "tax_category_id": "63692385-b664-43bb-8f66-5868ce5dfd54",
        "planning_id": "7bce8202-c012-4413-861c-314fa7474cb3",
        "parent_line_id": null,
        "owner_id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
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
      "id": "208ec08f-569c-49f1-a8de-eae6c2a2b786",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:30+00:00",
        "updated_at": "2022-07-08T11:45:32+00:00",
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
        "item_id": "f7ff2524-e323-4a71-bc4c-c25531cc6566",
        "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
        "start_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d",
        "stop_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d",
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
      "id": "7bce8202-c012-4413-861c-314fa7474cb3",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:31+00:00",
        "updated_at": "2022-07-08T11:45:32+00:00",
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
        "item_id": "b6a400f7-464b-41b7-b08c-8235822a7e5a",
        "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e",
        "start_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d",
        "stop_location_id": "8ce4477a-fe53-444c-af99-b20eb786657d",
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
      "id": "795c0853-4311-421e-9247-a4b1b82fca94",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:31+00:00",
        "updated_at": "2022-07-08T11:45:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "2eab0718-6846-4671-a89c-98e83fc90187",
        "planning_id": "7bce8202-c012-4413-861c-314fa7474cb3",
        "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e"
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
      "id": "2f293e3d-d9c5-40b3-9326-cc084a215988",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:31+00:00",
        "updated_at": "2022-07-08T11:45:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1289269d-bee1-4d46-a8b2-58cf7dd74f3a",
        "planning_id": "7bce8202-c012-4413-861c-314fa7474cb3",
        "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e"
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
      "id": "4ddaaa9d-bea0-400d-bda0-3d23495c86e8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:31+00:00",
        "updated_at": "2022-07-08T11:45:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ad7d2b8c-6d31-4931-90da-b82c5601a7ba",
        "planning_id": "7bce8202-c012-4413-861c-314fa7474cb3",
        "order_id": "064c81d4-8308-46e4-8abb-297eba8ad01e"
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
          "order_id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee",
          "items": [
            {
              "type": "bundles",
              "id": "9d2e64fa-0296-4244-a6a7-8e1c562e482e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "34565526-cdea-4d91-9c9d-355978a3ea00",
                  "id": "315b9128-ebc5-4e1a-b294-39ad0001e122"
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
    "id": "0d2c2faa-fb82-5479-8e4f-8053cf41dbed",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d11820de-4674-4cb1-b28f-e0affd3e8f87"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4600c71f-1e02-4a8d-9503-135cb37aa3c8"
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
      "id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-08T11:45:34+00:00",
        "updated_at": "2022-07-08T11:45:35+00:00",
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
        "starts_at": "2022-07-06T11:45:00+00:00",
        "stops_at": "2022-07-10T11:45:00+00:00",
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
        "start_location_id": "d4af147e-35af-4321-8e44-f1a795641c20",
        "stop_location_id": "d4af147e-35af-4321-8e44-f1a795641c20"
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
      "id": "d11820de-4674-4cb1-b28f-e0affd3e8f87",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-08T11:45:35+00:00",
        "updated_at": "2022-07-08T11:45:35+00:00",
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
        "item_id": "9d2e64fa-0296-4244-a6a7-8e1c562e482e",
        "tax_category_id": null,
        "planning_id": "4600c71f-1e02-4a8d-9503-135cb37aa3c8",
        "parent_line_id": null,
        "owner_id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee",
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
      "id": "4600c71f-1e02-4a8d-9503-135cb37aa3c8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-08T11:45:35+00:00",
        "updated_at": "2022-07-08T11:45:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-06T11:45:00+00:00",
        "stops_at": "2022-07-10T11:45:00+00:00",
        "reserved_from": "2022-07-06T11:45:00+00:00",
        "reserved_till": "2022-07-10T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9d2e64fa-0296-4244-a6a7-8e1c562e482e",
        "order_id": "cadcebc1-fd03-4c94-813c-0bd6aa6d18ee",
        "start_location_id": "d4af147e-35af-4321-8e44-f1a795641c20",
        "stop_location_id": "d4af147e-35af-4321-8e44-f1a795641c20",
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





