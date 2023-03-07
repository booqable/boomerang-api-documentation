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
          "order_id": "8cbb797c-fb4c-46c1-986a-2a8a19eec5f4",
          "items": [
            {
              "type": "products",
              "id": "ca804ec1-02a1-435e-93b4-c703bb790981",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "54361d33-7044-4696-a98b-3dfc533b998c",
              "stock_item_ids": [
                "c603c515-0a42-42dc-aa1c-ecd38aba892f",
                "f69b5077-0fc5-431d-839f-8c4b30255040"
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
      "code": 422,
      "status": "422",
      "title": "422",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id c603c515-0a42-42dc-aa1c-ecd38aba892f has already been booked on this order"
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
          "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c",
          "items": [
            {
              "type": "products",
              "id": "0b77cfa5-3138-4164-9b9c-6558ce114176",
              "stock_item_ids": [
                "ebd83299-378e-4917-a207-0d5524a00568",
                "a343eae5-f4b3-4150-9869-b387a006b7a8",
                "5ea62b54-bb59-443b-ad5b-f5168d6e3af4"
              ]
            },
            {
              "type": "products",
              "id": "f510b60e-6c79-498b-bd1b-571628dadfc5",
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
    "id": "f0b5f1f3-4595-5d78-8588-d73f862adcd3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "a151d963-601f-4398-8b13-8d8d86205a3c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2efcf1e3-6446-4005-b494-1cff6100671d"
          },
          {
            "type": "lines",
            "id": "851a1f5b-35e5-4e0d-85f0-416cc5c31fdf"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "68220deb-2c1e-4e94-9c36-0547866417a0"
          },
          {
            "type": "plannings",
            "id": "3bb15f3e-a97d-4eb6-b0ef-3b1728e00677"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9708de7a-8c8f-4c76-a247-f277f57e017a"
          },
          {
            "type": "stock_item_plannings",
            "id": "0cdcf84e-ca5a-4bd1-9b6c-8b99d3147fef"
          },
          {
            "type": "stock_item_plannings",
            "id": "1a72887a-16ff-468f-b718-96ce0108bb33"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a151d963-601f-4398-8b13-8d8d86205a3c",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T08:28:49+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
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
        "customer_id": "3e472e97-81d8-4019-bc87-fd9945a16fdd",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b6c765a7-b656-4df8-9731-917998605ca9",
        "stop_location_id": "b6c765a7-b656-4df8-9731-917998605ca9"
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
      "id": "2efcf1e3-6446-4005-b494-1cff6100671d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
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
        "item_id": "0b77cfa5-3138-4164-9b9c-6558ce114176",
        "tax_category_id": "6025e4cb-31c6-4c19-b2d5-ee084ec6218f",
        "planning_id": "68220deb-2c1e-4e94-9c36-0547866417a0",
        "parent_line_id": null,
        "owner_id": "a151d963-601f-4398-8b13-8d8d86205a3c",
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
      "id": "851a1f5b-35e5-4e0d-85f0-416cc5c31fdf",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
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
        "item_id": "f510b60e-6c79-498b-bd1b-571628dadfc5",
        "tax_category_id": "6025e4cb-31c6-4c19-b2d5-ee084ec6218f",
        "planning_id": "3bb15f3e-a97d-4eb6-b0ef-3b1728e00677",
        "parent_line_id": null,
        "owner_id": "a151d963-601f-4398-8b13-8d8d86205a3c",
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
      "id": "68220deb-2c1e-4e94-9c36-0547866417a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
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
        "item_id": "0b77cfa5-3138-4164-9b9c-6558ce114176",
        "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c",
        "start_location_id": "b6c765a7-b656-4df8-9731-917998605ca9",
        "stop_location_id": "b6c765a7-b656-4df8-9731-917998605ca9",
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
      "id": "3bb15f3e-a97d-4eb6-b0ef-3b1728e00677",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
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
        "item_id": "f510b60e-6c79-498b-bd1b-571628dadfc5",
        "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c",
        "start_location_id": "b6c765a7-b656-4df8-9731-917998605ca9",
        "stop_location_id": "b6c765a7-b656-4df8-9731-917998605ca9",
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
      "id": "9708de7a-8c8f-4c76-a247-f277f57e017a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ebd83299-378e-4917-a207-0d5524a00568",
        "planning_id": "68220deb-2c1e-4e94-9c36-0547866417a0",
        "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c"
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
      "id": "0cdcf84e-ca5a-4bd1-9b6c-8b99d3147fef",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a343eae5-f4b3-4150-9869-b387a006b7a8",
        "planning_id": "68220deb-2c1e-4e94-9c36-0547866417a0",
        "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c"
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
      "id": "1a72887a-16ff-468f-b718-96ce0108bb33",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:51+00:00",
        "updated_at": "2023-03-07T08:28:51+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5ea62b54-bb59-443b-ad5b-f5168d6e3af4",
        "planning_id": "68220deb-2c1e-4e94-9c36-0547866417a0",
        "order_id": "a151d963-601f-4398-8b13-8d8d86205a3c"
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
          "order_id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982",
          "items": [
            {
              "type": "bundles",
              "id": "9652d4b0-9ded-4abc-86d9-f0900e6e5d1b",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "37ba1f55-356c-4029-89ba-d4c9c25be299",
                  "id": "8aa9453c-084d-4d4b-87d9-d1d38031aa47"
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
    "id": "fb7389eb-c469-509f-9004-40614cb16c1e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "204f43fa-f592-4b23-9c06-1fdc4fa0e495"
          },
          {
            "type": "lines",
            "id": "f4ff32eb-ffcd-4fca-8b9e-cc7beb3b425b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fe379591-7cdd-45c9-86ef-5e2d7262ecca"
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
      "id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-07T08:28:53+00:00",
        "updated_at": "2023-03-07T08:28:54+00:00",
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
        "starts_at": "2023-03-05T08:15:00+00:00",
        "stops_at": "2023-03-09T08:15:00+00:00",
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
        "start_location_id": "c13c098b-4dbc-4e48-892e-cc8cd5d9685e",
        "stop_location_id": "c13c098b-4dbc-4e48-892e-cc8cd5d9685e"
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
      "id": "204f43fa-f592-4b23-9c06-1fdc4fa0e495",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:28:54+00:00",
        "updated_at": "2023-03-07T08:28:54+00:00",
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
        "item_id": "8aa9453c-084d-4d4b-87d9-d1d38031aa47",
        "tax_category_id": null,
        "planning_id": "70612617-70b6-4c40-a12c-02f433e1b9c3",
        "parent_line_id": "f4ff32eb-ffcd-4fca-8b9e-cc7beb3b425b",
        "owner_id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982",
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
      "id": "f4ff32eb-ffcd-4fca-8b9e-cc7beb3b425b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-07T08:28:54+00:00",
        "updated_at": "2023-03-07T08:28:54+00:00",
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
        "item_id": "9652d4b0-9ded-4abc-86d9-f0900e6e5d1b",
        "tax_category_id": null,
        "planning_id": "fe379591-7cdd-45c9-86ef-5e2d7262ecca",
        "parent_line_id": null,
        "owner_id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982",
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
      "id": "fe379591-7cdd-45c9-86ef-5e2d7262ecca",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-07T08:28:54+00:00",
        "updated_at": "2023-03-07T08:28:54+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-05T08:15:00+00:00",
        "stops_at": "2023-03-09T08:15:00+00:00",
        "reserved_from": "2023-03-05T08:15:00+00:00",
        "reserved_till": "2023-03-09T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "9652d4b0-9ded-4abc-86d9-f0900e6e5d1b",
        "order_id": "0bdfcf51-1ce5-41aa-9ebb-523c3dbd8982",
        "start_location_id": "c13c098b-4dbc-4e48-892e-cc8cd5d9685e",
        "stop_location_id": "c13c098b-4dbc-4e48-892e-cc8cd5d9685e",
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





