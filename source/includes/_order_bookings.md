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
          "order_id": "40b4ee14-fdc6-4aac-93c7-285ddc1de03c",
          "items": [
            {
              "type": "products",
              "id": "3c0a68b0-9fd4-4f4c-88ac-72c4f829dea2",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a15ca4e1-726b-4b2e-b7a5-37fe4284995a",
              "stock_item_ids": [
                "f9d9b970-a262-495b-9d30-81c32a10c6af",
                "1fe9dbd0-3353-43a3-8150-94813f6e991b"
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
          "stock_item_id f9d9b970-a262-495b-9d30-81c32a10c6af has already been booked on this order"
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
          "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
          "items": [
            {
              "type": "products",
              "id": "7bfe1a1a-a8e5-4fc3-b90d-66a5d0f47173",
              "stock_item_ids": [
                "9cb163f0-70db-4744-bba3-2dfeba3fb1fc",
                "8b52116b-190e-473a-8990-09cc2cdef61b",
                "08146493-fb6e-4576-ba6a-0e8aebc316a2"
              ]
            },
            {
              "type": "products",
              "id": "f9cdda9b-0131-43d4-8f16-ea94a2c82668",
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
    "id": "4338bc74-e69f-5b57-b4c4-569887f5e80a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "5e61feff-349b-4e04-a10f-55e5604c79ea"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "df970ad2-3901-4f38-ace2-1b3542b013f2"
          },
          {
            "type": "lines",
            "id": "1a669122-49aa-4d86-badf-601f0f49ec48"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "73e161ce-409a-4403-9572-6f46d116491c"
          },
          {
            "type": "plannings",
            "id": "483aa179-bb0c-4405-ade2-d010ff5d11cb"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "93f705e3-a54e-4e12-bb3a-f7e172d03ea9"
          },
          {
            "type": "stock_item_plannings",
            "id": "0b039378-2a7c-4bc5-acd2-c14f58d80b5f"
          },
          {
            "type": "stock_item_plannings",
            "id": "c68bdb61-a755-40e1-9078-dac785f8b05f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-17T10:34:15+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
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
        "customer_id": "c443011a-4588-4964-8f79-1a23d9d86749",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "146322d6-3294-493b-8080-3858afc37367",
        "stop_location_id": "146322d6-3294-493b-8080-3858afc37367"
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
      "id": "df970ad2-3901-4f38-ace2-1b3542b013f2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
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
        "item_id": "7bfe1a1a-a8e5-4fc3-b90d-66a5d0f47173",
        "tax_category_id": "eae1744e-57ad-4874-931b-07c5d3704230",
        "planning_id": "73e161ce-409a-4403-9572-6f46d116491c",
        "parent_line_id": null,
        "owner_id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
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
      "id": "1a669122-49aa-4d86-badf-601f0f49ec48",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
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
        "item_id": "f9cdda9b-0131-43d4-8f16-ea94a2c82668",
        "tax_category_id": "eae1744e-57ad-4874-931b-07c5d3704230",
        "planning_id": "483aa179-bb0c-4405-ade2-d010ff5d11cb",
        "parent_line_id": null,
        "owner_id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
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
      "id": "73e161ce-409a-4403-9572-6f46d116491c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
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
        "item_id": "7bfe1a1a-a8e5-4fc3-b90d-66a5d0f47173",
        "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
        "start_location_id": "146322d6-3294-493b-8080-3858afc37367",
        "stop_location_id": "146322d6-3294-493b-8080-3858afc37367",
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
      "id": "483aa179-bb0c-4405-ade2-d010ff5d11cb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
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
        "item_id": "f9cdda9b-0131-43d4-8f16-ea94a2c82668",
        "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea",
        "start_location_id": "146322d6-3294-493b-8080-3858afc37367",
        "stop_location_id": "146322d6-3294-493b-8080-3858afc37367",
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
      "id": "93f705e3-a54e-4e12-bb3a-f7e172d03ea9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9cb163f0-70db-4744-bba3-2dfeba3fb1fc",
        "planning_id": "73e161ce-409a-4403-9572-6f46d116491c",
        "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea"
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
      "id": "0b039378-2a7c-4bc5-acd2-c14f58d80b5f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8b52116b-190e-473a-8990-09cc2cdef61b",
        "planning_id": "73e161ce-409a-4403-9572-6f46d116491c",
        "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea"
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
      "id": "c68bdb61-a755-40e1-9078-dac785f8b05f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:17+00:00",
        "updated_at": "2023-02-17T10:34:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "08146493-fb6e-4576-ba6a-0e8aebc316a2",
        "planning_id": "73e161ce-409a-4403-9572-6f46d116491c",
        "order_id": "5e61feff-349b-4e04-a10f-55e5604c79ea"
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
          "order_id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e",
          "items": [
            {
              "type": "bundles",
              "id": "577e639d-c969-49c4-b0de-09af97be1180",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "4d14aeab-7c64-45af-9a55-711d9b5d672c",
                  "id": "85558efc-e8cd-4b03-b354-6d01c09d327b"
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
    "id": "25c98c4f-e59d-5f22-87f2-e2c223081eb9",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6f8477d4-cb49-452f-9b2a-7b66bb90dbf9"
          },
          {
            "type": "lines",
            "id": "18cdb148-b23a-4a22-bbf6-e6388f59a30b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "6d0d64b1-244c-4b2a-b7d9-a71ea837deea"
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
      "id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-17T10:34:20+00:00",
        "updated_at": "2023-02-17T10:34:21+00:00",
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
        "starts_at": "2023-02-15T10:30:00+00:00",
        "stops_at": "2023-02-19T10:30:00+00:00",
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
        "start_location_id": "2d51da52-2666-43c6-a56e-7312c812934d",
        "stop_location_id": "2d51da52-2666-43c6-a56e-7312c812934d"
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
      "id": "6f8477d4-cb49-452f-9b2a-7b66bb90dbf9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T10:34:20+00:00",
        "updated_at": "2023-02-17T10:34:20+00:00",
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
        "item_id": "85558efc-e8cd-4b03-b354-6d01c09d327b",
        "tax_category_id": null,
        "planning_id": "59519c56-6b4f-4f13-aba8-013104923a80",
        "parent_line_id": "18cdb148-b23a-4a22-bbf6-e6388f59a30b",
        "owner_id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e",
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
      "id": "18cdb148-b23a-4a22-bbf6-e6388f59a30b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-17T10:34:20+00:00",
        "updated_at": "2023-02-17T10:34:20+00:00",
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
        "item_id": "577e639d-c969-49c4-b0de-09af97be1180",
        "tax_category_id": null,
        "planning_id": "6d0d64b1-244c-4b2a-b7d9-a71ea837deea",
        "parent_line_id": null,
        "owner_id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e",
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
      "id": "6d0d64b1-244c-4b2a-b7d9-a71ea837deea",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-17T10:34:20+00:00",
        "updated_at": "2023-02-17T10:34:20+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-15T10:30:00+00:00",
        "stops_at": "2023-02-19T10:30:00+00:00",
        "reserved_from": "2023-02-15T10:30:00+00:00",
        "reserved_till": "2023-02-19T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "577e639d-c969-49c4-b0de-09af97be1180",
        "order_id": "b75f8d4b-688f-4561-87bf-c39d215e4c5e",
        "start_location_id": "2d51da52-2666-43c6-a56e-7312c812934d",
        "stop_location_id": "2d51da52-2666-43c6-a56e-7312c812934d",
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





