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
          "order_id": "8d22596c-8fef-452c-a32d-665c18937369",
          "items": [
            {
              "type": "products",
              "id": "c36dd8bb-5877-4c74-8b38-16758460795d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "00d94ca7-0a15-402a-879d-718e537a54fe",
              "stock_item_ids": [
                "fc26a89f-2f06-4fe6-b718-e804e78d8757",
                "01fc2433-4021-469f-a7e3-278ee2a883f4"
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
            "item_id": "c36dd8bb-5877-4c74-8b38-16758460795d",
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
          "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
          "items": [
            {
              "type": "products",
              "id": "2bd399ec-726f-41e2-b342-bd6192f15e2b",
              "stock_item_ids": [
                "47fe542d-7a96-4a02-bbab-4ad69f0c8284",
                "e02369cb-ea8a-4493-beaf-40d7e1048075",
                "e9ff2b16-c5a3-40fd-9788-bf52c8e17d32"
              ]
            },
            {
              "type": "products",
              "id": "d19e9fe0-0860-43ab-aa11-c72b1fee543c",
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
    "id": "1aad13a2-ca5f-5f7f-8596-81f9a5fc4ca8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "610ce032-5915-41fa-817c-c28cdcba1de7"
          },
          {
            "type": "lines",
            "id": "acc552cc-b05b-4941-b70e-56ad72c24a56"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "320525b2-4296-4924-97ba-3afcc1219143"
          },
          {
            "type": "plannings",
            "id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "57128868-8427-4ebc-9a79-88fbbde46296"
          },
          {
            "type": "stock_item_plannings",
            "id": "bd63b0d7-a8cb-4f8d-9d6f-800e2c750fd9"
          },
          {
            "type": "stock_item_plannings",
            "id": "d565034a-94ff-41bd-aaff-e42a5f7801c7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-15T10:35:43+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
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
        "customer_id": "4d62cb68-2d07-4007-9926-7e23a7114fca",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2",
        "stop_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2"
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
      "id": "610ce032-5915-41fa-817c-c28cdcba1de7",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T10:35:44+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
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
        "item_id": "d19e9fe0-0860-43ab-aa11-c72b1fee543c",
        "tax_category_id": "2d7652c7-965d-4c4b-8676-676ec365bbd8",
        "planning_id": "320525b2-4296-4924-97ba-3afcc1219143",
        "parent_line_id": null,
        "owner_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
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
      "id": "acc552cc-b05b-4941-b70e-56ad72c24a56",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T10:35:45+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
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
        "item_id": "2bd399ec-726f-41e2-b342-bd6192f15e2b",
        "tax_category_id": "2d7652c7-965d-4c4b-8676-676ec365bbd8",
        "planning_id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd",
        "parent_line_id": null,
        "owner_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
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
      "id": "320525b2-4296-4924-97ba-3afcc1219143",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:44+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
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
        "item_id": "d19e9fe0-0860-43ab-aa11-c72b1fee543c",
        "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
        "start_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2",
        "stop_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2",
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
      "id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:45+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
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
        "item_id": "2bd399ec-726f-41e2-b342-bd6192f15e2b",
        "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26",
        "start_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2",
        "stop_location_id": "b79fdfc7-4300-4ec3-bac7-637158849cd2",
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
      "id": "57128868-8427-4ebc-9a79-88fbbde46296",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:45+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "47fe542d-7a96-4a02-bbab-4ad69f0c8284",
        "planning_id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd",
        "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26"
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
      "id": "bd63b0d7-a8cb-4f8d-9d6f-800e2c750fd9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:45+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e02369cb-ea8a-4493-beaf-40d7e1048075",
        "planning_id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd",
        "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26"
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
      "id": "d565034a-94ff-41bd-aaff-e42a5f7801c7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:45+00:00",
        "updated_at": "2022-03-15T10:35:45+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e9ff2b16-c5a3-40fd-9788-bf52c8e17d32",
        "planning_id": "2458e470-baf3-4a2f-a4a8-d766c7bd6efd",
        "order_id": "32c5521f-ac92-46a2-9ae2-eb97ca682e26"
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
          "order_id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de",
          "items": [
            {
              "type": "bundles",
              "id": "5fac8465-432a-40b1-845e-04ad00c2f484",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8e4dfcc5-181d-4344-9350-9b86ab928ab8",
                  "id": "4381a830-00ba-49e9-9a2d-6699673032c0"
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
    "id": "2d47191e-914d-5a43-b941-5c13a0d22c43",
    "type": "order_bookings",
    "attributes": {
      "order_id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f1024998-2056-4227-a20d-93e6a5f20f4a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "5626fe4d-f57d-41de-9770-f2fbb4aca135"
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
      "id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de",
      "type": "orders",
      "attributes": {
        "created_at": "2022-03-15T10:35:48+00:00",
        "updated_at": "2022-03-15T10:35:49+00:00",
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
        "starts_at": "2022-03-13T10:30:00+00:00",
        "stops_at": "2022-03-17T10:30:00+00:00",
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
        "start_location_id": "5998e5d4-8b09-4395-8dee-0ceb4f2cf899",
        "stop_location_id": "5998e5d4-8b09-4395-8dee-0ceb4f2cf899"
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
      "id": "f1024998-2056-4227-a20d-93e6a5f20f4a",
      "type": "lines",
      "attributes": {
        "created_at": "2022-03-15T10:35:48+00:00",
        "updated_at": "2022-03-15T10:35:48+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "5fac8465-432a-40b1-845e-04ad00c2f484",
        "tax_category_id": null,
        "planning_id": "5626fe4d-f57d-41de-9770-f2fbb4aca135",
        "parent_line_id": null,
        "owner_id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de",
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
      "id": "5626fe4d-f57d-41de-9770-f2fbb4aca135",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-03-15T10:35:48+00:00",
        "updated_at": "2022-03-15T10:35:48+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-03-13T10:30:00+00:00",
        "stops_at": "2022-03-17T10:30:00+00:00",
        "reserved_from": "2022-03-13T10:30:00+00:00",
        "reserved_till": "2022-03-17T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5fac8465-432a-40b1-845e-04ad00c2f484",
        "order_id": "6025db98-5bc5-4f8d-aaa0-7228ae9664de",
        "start_location_id": "5998e5d4-8b09-4395-8dee-0ceb4f2cf899",
        "stop_location_id": "5998e5d4-8b09-4395-8dee-0ceb4f2cf899",
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





