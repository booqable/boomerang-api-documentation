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
          "order_id": "b2991c02-a704-4d58-8aeb-1b0624797e2d",
          "items": [
            {
              "type": "products",
              "id": "d4de6870-f455-43ad-9e51-d0441654fcd4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c39bc7c8-c566-4039-b95e-57719c4881d8",
              "stock_item_ids": [
                "22d463a2-235b-4976-9241-94ca07a6cd9b",
                "acaec06c-027f-4069-a670-d2f8328b51d2"
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
            "item_id": "d4de6870-f455-43ad-9e51-d0441654fcd4",
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
          "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
          "items": [
            {
              "type": "products",
              "id": "2718a398-9ec4-4e33-af3b-b322235c72a6",
              "stock_item_ids": [
                "c0e71006-c0f5-4557-9794-a73be568f204",
                "5a81a9f3-46cc-4917-8f6d-13ddfafad8cd",
                "c496c81a-9810-43ed-b9bb-5875baffe9ed"
              ]
            },
            {
              "type": "products",
              "id": "83f40f67-9db5-4470-a76b-7d529a4327dc",
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
    "id": "bb08b75c-e511-5a54-839e-18c276b056c5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "f8d26abe-6291-4033-a5d7-c15abd4e1adf"
          },
          {
            "type": "lines",
            "id": "b586adf6-0063-461a-ad11-7fc1ba4ee12b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "0925803c-c775-4c59-85c1-cec6bf9deb6e"
          },
          {
            "type": "plannings",
            "id": "0c1a8478-9219-4116-a9ca-65a096ed3da7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "a8c930d3-a1c2-4cc4-829c-d86d7dcd12f0"
          },
          {
            "type": "stock_item_plannings",
            "id": "923f7b85-e441-4f91-9096-da14e53f1719"
          },
          {
            "type": "stock_item_plannings",
            "id": "4eda2705-de33-481c-9dd0-d02d6ad6a9b5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T12:38:58+00:00",
        "updated_at": "2022-10-13T12:39:01+00:00",
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
        "customer_id": "a59f7fdb-c864-4c5f-ad4d-e27a540b9a91",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e",
        "stop_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e"
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
      "id": "f8d26abe-6291-4033-a5d7-c15abd4e1adf",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
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
        "item_id": "2718a398-9ec4-4e33-af3b-b322235c72a6",
        "tax_category_id": "b4c92404-01f0-43c3-95de-a67d85718d61",
        "planning_id": "0925803c-c775-4c59-85c1-cec6bf9deb6e",
        "parent_line_id": null,
        "owner_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
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
      "id": "b586adf6-0063-461a-ad11-7fc1ba4ee12b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
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
        "item_id": "83f40f67-9db5-4470-a76b-7d529a4327dc",
        "tax_category_id": "b4c92404-01f0-43c3-95de-a67d85718d61",
        "planning_id": "0c1a8478-9219-4116-a9ca-65a096ed3da7",
        "parent_line_id": null,
        "owner_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
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
      "id": "0925803c-c775-4c59-85c1-cec6bf9deb6e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
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
        "item_id": "2718a398-9ec4-4e33-af3b-b322235c72a6",
        "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
        "start_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e",
        "stop_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e",
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
      "id": "0c1a8478-9219-4116-a9ca-65a096ed3da7",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
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
        "item_id": "83f40f67-9db5-4470-a76b-7d529a4327dc",
        "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51",
        "start_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e",
        "stop_location_id": "5287454b-4a0e-498b-b100-e68866b58e9e",
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
      "id": "a8c930d3-a1c2-4cc4-829c-d86d7dcd12f0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c0e71006-c0f5-4557-9794-a73be568f204",
        "planning_id": "0925803c-c775-4c59-85c1-cec6bf9deb6e",
        "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51"
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
      "id": "923f7b85-e441-4f91-9096-da14e53f1719",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5a81a9f3-46cc-4917-8f6d-13ddfafad8cd",
        "planning_id": "0925803c-c775-4c59-85c1-cec6bf9deb6e",
        "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51"
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
      "id": "4eda2705-de33-481c-9dd0-d02d6ad6a9b5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:00+00:00",
        "updated_at": "2022-10-13T12:39:00+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c496c81a-9810-43ed-b9bb-5875baffe9ed",
        "planning_id": "0925803c-c775-4c59-85c1-cec6bf9deb6e",
        "order_id": "fde7e829-ef8b-4d67-8b2d-9d41709c6f51"
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
          "order_id": "ccab6178-919d-425b-bbf4-7287daa82293",
          "items": [
            {
              "type": "bundles",
              "id": "862abf94-8523-4e76-ab9c-17f0a891bf84",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e6d0f28b-4c1b-41d6-8b42-d3a04eb522e9",
                  "id": "1cb26095-ab31-41f2-af6f-1a57bf302aaa"
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
    "id": "ceda619f-db3f-5203-8b5a-1c1f1a3c21fd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ccab6178-919d-425b-bbf4-7287daa82293"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ccab6178-919d-425b-bbf4-7287daa82293"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "08fb185f-e660-4152-bd99-67dd756c2773"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "613434bc-1e3e-4677-9ee9-c621f326012e"
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
      "id": "ccab6178-919d-425b-bbf4-7287daa82293",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T12:39:03+00:00",
        "updated_at": "2022-10-13T12:39:04+00:00",
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
        "starts_at": "2022-10-11T12:30:00+00:00",
        "stops_at": "2022-10-15T12:30:00+00:00",
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
        "start_location_id": "5cd8d66e-caf7-43c2-8152-b829e304ec23",
        "stop_location_id": "5cd8d66e-caf7-43c2-8152-b829e304ec23"
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
      "id": "08fb185f-e660-4152-bd99-67dd756c2773",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T12:39:04+00:00",
        "updated_at": "2022-10-13T12:39:04+00:00",
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
        "item_id": "862abf94-8523-4e76-ab9c-17f0a891bf84",
        "tax_category_id": null,
        "planning_id": "613434bc-1e3e-4677-9ee9-c621f326012e",
        "parent_line_id": null,
        "owner_id": "ccab6178-919d-425b-bbf4-7287daa82293",
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
      "id": "613434bc-1e3e-4677-9ee9-c621f326012e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T12:39:04+00:00",
        "updated_at": "2022-10-13T12:39:04+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-11T12:30:00+00:00",
        "stops_at": "2022-10-15T12:30:00+00:00",
        "reserved_from": "2022-10-11T12:30:00+00:00",
        "reserved_till": "2022-10-15T12:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "862abf94-8523-4e76-ab9c-17f0a891bf84",
        "order_id": "ccab6178-919d-425b-bbf4-7287daa82293",
        "start_location_id": "5cd8d66e-caf7-43c2-8152-b829e304ec23",
        "stop_location_id": "5cd8d66e-caf7-43c2-8152-b829e304ec23",
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





