# Bookings

Add products, bundles and specific stock items to an order.

Items can be added quantitatively or, for trackable products, specific stock items can be specified. Specifying stock items is not required on booking; they can also be defined when transitioning the order status to a `started` state.

> Adding items quantitatively:

```
  "items": [
    {
      "type": "products",
      "id": "69a6ac18-244e-4b1e-b2e1-c88d155b51e5",
      "quantity": 10
    }
  ]
```

> Adding specific stock items:

```
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

```
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3
    }
  ]
```

> Adding a bundle and specifying a variation (for product that has variations)

```
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "products": [
        {
          type: "products",
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
          "order_id": "2cd75933-98d0-4c54-aec1-09b83ffc471c",
          "items": [
            {
              "type": "products",
              "id": "c99dc8bc-ddd5-4933-a4fe-80db98eb248c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "5da1950c-8230-4b4a-bc03-6e1c92d355f1",
              "stock_item_ids": [
                "e295a989-0881-41be-ad01-4c103ec89b92",
                "e29ca7ab-c140-4203-8aed-06d5ee6b1684"
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
            "item_id": "c99dc8bc-ddd5-4933-a4fe-80db98eb248c",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "5da1950c-8230-4b4a-bc03-6e1c92d355f1",
            "unavailable": [
              "e295a989-0881-41be-ad01-4c103ec89b92"
            ],
            "available": [
              "e29ca7ab-c140-4203-8aed-06d5ee6b1684"
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
          "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
          "items": [
            {
              "type": "products",
              "id": "c839cbab-27e6-4db0-9796-fe94a9e794e7",
              "stock_item_ids": [
                "70e5c703-24d4-4363-bfde-3bac9c5eede6",
                "5a72f9f0-1d8f-4081-82e3-ba68aaf0970e",
                "f5d1c6dc-b892-45a1-88f8-ac7f1baccee7"
              ]
            },
            {
              "type": "products",
              "id": "0cfead44-b68c-49aa-96e9-1d846e703683",
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
    "id": "38f2eb67-47db-527b-b403-93693ec2a0a2",
    "type": "bookings",
    "attributes": {
      "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5c9f30b5-4689-4afc-a158-16233af54d97"
          },
          {
            "type": "lines",
            "id": "45dd248d-e693-4c1f-850f-740fa02ffb93"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "54a1c4bd-49be-4198-8edb-91a5478423a2"
          },
          {
            "type": "plannings",
            "id": "1f3e6d8c-9422-43c5-a7f1-9a82be18174d"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8fd30fc2-9430-4048-8362-69c4aab6515a"
          },
          {
            "type": "stock_item_plannings",
            "id": "cc59a27f-ae0c-4402-b9e7-f988fe164e1d"
          },
          {
            "type": "stock_item_plannings",
            "id": "2a0164bf-8027-427e-9f51-76fa3032cf5d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T14:41:46+00:00",
        "updated_at": "2021-11-18T14:41:49+00:00",
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
        "customer_id": "26371499-2d10-4ebb-91c8-3a390d9ff7cc",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626",
        "stop_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626"
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
      "id": "5c9f30b5-4689-4afc-a158-16233af54d97",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T14:41:47+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
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
        "item_id": "0cfead44-b68c-49aa-96e9-1d846e703683",
        "tax_category_id": "ac218401-e7e4-40f0-83d2-ebd6742ac24a",
        "parent_line_id": null,
        "owner_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
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
      "id": "45dd248d-e693-4c1f-850f-740fa02ffb93",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T14:41:48+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
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
        "item_id": "c839cbab-27e6-4db0-9796-fe94a9e794e7",
        "tax_category_id": "ac218401-e7e4-40f0-83d2-ebd6742ac24a",
        "parent_line_id": null,
        "owner_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
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
      "id": "54a1c4bd-49be-4198-8edb-91a5478423a2",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:47+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
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
        "item_id": "0cfead44-b68c-49aa-96e9-1d846e703683",
        "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
        "start_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626",
        "stop_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626",
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
      "id": "1f3e6d8c-9422-43c5-a7f1-9a82be18174d",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:48+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
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
        "item_id": "c839cbab-27e6-4db0-9796-fe94a9e794e7",
        "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd",
        "start_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626",
        "stop_location_id": "1b5caa1b-983e-4920-b13e-ace24a406626",
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
      "id": "8fd30fc2-9430-4048-8362-69c4aab6515a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:48+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "70e5c703-24d4-4363-bfde-3bac9c5eede6",
        "planning_id": "1f3e6d8c-9422-43c5-a7f1-9a82be18174d",
        "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd"
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
      "id": "cc59a27f-ae0c-4402-b9e7-f988fe164e1d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:48+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5a72f9f0-1d8f-4081-82e3-ba68aaf0970e",
        "planning_id": "1f3e6d8c-9422-43c5-a7f1-9a82be18174d",
        "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd"
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
      "id": "2a0164bf-8027-427e-9f51-76fa3032cf5d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:48+00:00",
        "updated_at": "2021-11-18T14:41:48+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f5d1c6dc-b892-45a1-88f8-ac7f1baccee7",
        "planning_id": "1f3e6d8c-9422-43c5-a7f1-9a82be18174d",
        "order_id": "5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd"
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=c839cbab-27e6-4db0-9796-fe94a9e794e7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=70e5c703-24d4-4363-bfde-3bac9c5eede6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=5a72f9f0-1d8f-4081-82e3-ba68aaf0970e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=f5d1c6dc-b892-45a1-88f8-ac7f1baccee7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=0cfead44-b68c-49aa-96e9-1d846e703683&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=5f31f2ee-a5c9-4ff6-a79e-0e85e017a4cd&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
          "order_id": "08ca5af6-6ad4-4282-b317-5231eb3522ec",
          "items": [
            {
              "type": "bundles",
              "id": "41c09787-bcd8-4012-af9d-3df48178c53e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "84ed74e9-dbb6-4685-b87f-5e47b19e3754",
                  "id": "9bd9432c-9916-4786-b9ac-b339f61f4e68"
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
    "id": "1ecda00b-8645-548f-a578-c98cb1ab5f35",
    "type": "bookings",
    "attributes": {
      "order_id": "08ca5af6-6ad4-4282-b317-5231eb3522ec"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "08ca5af6-6ad4-4282-b317-5231eb3522ec"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0fe3596c-9bcc-4383-8df5-d0e8188ee63a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ca367c53-040f-4647-ade6-f5a695dbdf37"
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
      "id": "08ca5af6-6ad4-4282-b317-5231eb3522ec",
      "type": "orders",
      "attributes": {
        "created_at": "2021-11-18T14:41:51+00:00",
        "updated_at": "2021-11-18T14:41:52+00:00",
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
        "starts_at": "2021-11-16T14:30:00+00:00",
        "stops_at": "2021-11-20T14:30:00+00:00",
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
        "start_location_id": "9aee75a0-fb6a-430c-ab82-7ceb0f93d0ea",
        "stop_location_id": "9aee75a0-fb6a-430c-ab82-7ceb0f93d0ea"
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
      "id": "0fe3596c-9bcc-4383-8df5-d0e8188ee63a",
      "type": "lines",
      "attributes": {
        "created_at": "2021-11-18T14:41:52+00:00",
        "updated_at": "2021-11-18T14:41:52+00:00",
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
        "item_id": "41c09787-bcd8-4012-af9d-3df48178c53e",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "08ca5af6-6ad4-4282-b317-5231eb3522ec",
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
      "id": "ca367c53-040f-4647-ade6-f5a695dbdf37",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-11-18T14:41:52+00:00",
        "updated_at": "2021-11-18T14:41:52+00:00",
        "quantity": 1,
        "starts_at": "2021-11-16T14:30:00+00:00",
        "stops_at": "2021-11-20T14:30:00+00:00",
        "reserved_from": "2021-11-16T14:30:00+00:00",
        "reserved_till": "2021-11-20T14:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "41c09787-bcd8-4012-af9d-3df48178c53e",
        "order_id": "08ca5af6-6ad4-4282-b317-5231eb3522ec",
        "start_location_id": "9aee75a0-fb6a-430c-ab82-7ceb0f93d0ea",
        "stop_location_id": "9aee75a0-fb6a-430c-ab82-7ceb0f93d0ea",
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
    "self": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&data%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&data%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&data%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/bookings?booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&booking%5Bdata%5D%5Btype%5D=bookings&booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=41c09787-bcd8-4012-af9d-3df48178c53e&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=84ed74e9-dbb6-4685-b87f-5e47b19e3754&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=9bd9432c-9916-4786-b9ac-b339f61f4e68&data%5Battributes%5D%5Border_id%5D=08ca5af6-6ad4-4282-b317-5231eb3522ec&data%5Btype%5D=bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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





