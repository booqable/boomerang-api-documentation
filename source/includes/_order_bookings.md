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
          "order_id": "b4392ae8-294e-4cd5-8693-0ec1c84bd6cb",
          "items": [
            {
              "type": "products",
              "id": "1f57741a-6211-4599-aae6-5cc02d2415d7",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d7fde81f-e975-47be-97d0-afe9e9ac46c4",
              "stock_item_ids": [
                "961a888f-40b6-4f49-b9cf-b33fbb1becce",
                "1eefbf08-1afb-44f6-ace8-73c6b4d055c1"
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
            "item_id": "1f57741a-6211-4599-aae6-5cc02d2415d7",
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
          "order_id": "da6c645c-5c54-4440-8017-dc40622baa81",
          "items": [
            {
              "type": "products",
              "id": "55d8c51b-a20e-4f14-b70b-16673d8bdb97",
              "stock_item_ids": [
                "fbe9fc0b-6f28-49f7-aff6-fc1770a636ad",
                "81cb7b96-bb9b-4ee8-a6bc-fa9498bce173",
                "dcc6786d-b22e-453a-8f06-5cacc4718828"
              ]
            },
            {
              "type": "products",
              "id": "fad49e9b-7859-4745-b586-86908a975083",
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
    "id": "a4777531-5f5c-5dfc-887e-24571c95a974",
    "type": "order_bookings",
    "attributes": {
      "order_id": "da6c645c-5c54-4440-8017-dc40622baa81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "da6c645c-5c54-4440-8017-dc40622baa81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "48062f17-4f86-4e1c-a49f-988c953896df"
          },
          {
            "type": "lines",
            "id": "3b8ed516-7df2-44f9-9043-a7f821d81b15"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d04c83d4-aac1-4a43-ae73-d0273743f715"
          },
          {
            "type": "plannings",
            "id": "03f88bc4-5315-44e2-8895-e8527c262c2c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b5e2b480-a9c2-4960-817e-40312dc69183"
          },
          {
            "type": "stock_item_plannings",
            "id": "cae1db88-c2f8-486c-bbcb-68be9f98d265"
          },
          {
            "type": "stock_item_plannings",
            "id": "14193c42-8acc-4ed3-b2b7-d4cd41e3f2b2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "da6c645c-5c54-4440-8017-dc40622baa81",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:20:23+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
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
        "customer_id": "9d5d3962-b7ec-42c2-a6c1-5bcc5343b232",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167",
        "stop_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167"
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
      "id": "48062f17-4f86-4e1c-a49f-988c953896df",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:20:24+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
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
        "item_id": "fad49e9b-7859-4745-b586-86908a975083",
        "tax_category_id": "827b236d-6a58-406f-bbcb-34e2e145edb4",
        "planning_id": "d04c83d4-aac1-4a43-ae73-d0273743f715",
        "parent_line_id": null,
        "owner_id": "da6c645c-5c54-4440-8017-dc40622baa81",
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
      "id": "3b8ed516-7df2-44f9-9043-a7f821d81b15",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:20:25+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
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
        "item_id": "55d8c51b-a20e-4f14-b70b-16673d8bdb97",
        "tax_category_id": "827b236d-6a58-406f-bbcb-34e2e145edb4",
        "planning_id": "03f88bc4-5315-44e2-8895-e8527c262c2c",
        "parent_line_id": null,
        "owner_id": "da6c645c-5c54-4440-8017-dc40622baa81",
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
      "id": "d04c83d4-aac1-4a43-ae73-d0273743f715",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:24+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
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
        "item_id": "fad49e9b-7859-4745-b586-86908a975083",
        "order_id": "da6c645c-5c54-4440-8017-dc40622baa81",
        "start_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167",
        "stop_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167",
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
      "id": "03f88bc4-5315-44e2-8895-e8527c262c2c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:25+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
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
        "item_id": "55d8c51b-a20e-4f14-b70b-16673d8bdb97",
        "order_id": "da6c645c-5c54-4440-8017-dc40622baa81",
        "start_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167",
        "stop_location_id": "6163b791-1807-4213-bc3d-4891f0e3e167",
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
      "id": "b5e2b480-a9c2-4960-817e-40312dc69183",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:25+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fbe9fc0b-6f28-49f7-aff6-fc1770a636ad",
        "planning_id": "03f88bc4-5315-44e2-8895-e8527c262c2c",
        "order_id": "da6c645c-5c54-4440-8017-dc40622baa81"
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
      "id": "cae1db88-c2f8-486c-bbcb-68be9f98d265",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:25+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "81cb7b96-bb9b-4ee8-a6bc-fa9498bce173",
        "planning_id": "03f88bc4-5315-44e2-8895-e8527c262c2c",
        "order_id": "da6c645c-5c54-4440-8017-dc40622baa81"
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
      "id": "14193c42-8acc-4ed3-b2b7-d4cd41e3f2b2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:25+00:00",
        "updated_at": "2022-05-24T07:20:25+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "dcc6786d-b22e-453a-8f06-5cacc4718828",
        "planning_id": "03f88bc4-5315-44e2-8895-e8527c262c2c",
        "order_id": "da6c645c-5c54-4440-8017-dc40622baa81"
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
          "order_id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9",
          "items": [
            {
              "type": "bundles",
              "id": "8c9bd077-7c49-4d2e-8aac-3af13f66d1ce",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "80ab0e17-ad50-4804-9d8c-34f80e7c9b0b",
                  "id": "27d551ee-12c6-4ce6-bddc-2c39c0dcdef1"
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
    "id": "b420ceeb-020c-557f-9460-025ac22fdb62",
    "type": "order_bookings",
    "attributes": {
      "order_id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "89a8ebc5-2cc2-40c8-ab61-23826a4dc269"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c727f5b4-791f-44ad-b023-de5424d6e730"
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
      "id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-24T07:20:27+00:00",
        "updated_at": "2022-05-24T07:20:28+00:00",
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
        "starts_at": "2022-05-22T07:15:00+00:00",
        "stops_at": "2022-05-26T07:15:00+00:00",
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
        "start_location_id": "f2852b30-b5aa-4b04-889e-1d046836afaa",
        "stop_location_id": "f2852b30-b5aa-4b04-889e-1d046836afaa"
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
      "id": "89a8ebc5-2cc2-40c8-ab61-23826a4dc269",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-24T07:20:28+00:00",
        "updated_at": "2022-05-24T07:20:28+00:00",
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
        "item_id": "8c9bd077-7c49-4d2e-8aac-3af13f66d1ce",
        "tax_category_id": null,
        "planning_id": "c727f5b4-791f-44ad-b023-de5424d6e730",
        "parent_line_id": null,
        "owner_id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9",
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
      "id": "c727f5b4-791f-44ad-b023-de5424d6e730",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-24T07:20:28+00:00",
        "updated_at": "2022-05-24T07:20:28+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-22T07:15:00+00:00",
        "stops_at": "2022-05-26T07:15:00+00:00",
        "reserved_from": "2022-05-22T07:15:00+00:00",
        "reserved_till": "2022-05-26T07:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "8c9bd077-7c49-4d2e-8aac-3af13f66d1ce",
        "order_id": "aa01cd4a-4029-458a-86b5-7700a75fb4c9",
        "start_location_id": "f2852b30-b5aa-4b04-889e-1d046836afaa",
        "stop_location_id": "f2852b30-b5aa-4b04-889e-1d046836afaa",
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





