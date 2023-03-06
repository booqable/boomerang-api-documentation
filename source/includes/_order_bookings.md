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
          "order_id": "b21e4231-089e-424c-8362-c5ce257ab61b",
          "items": [
            {
              "type": "products",
              "id": "16a5bf00-43a2-4102-81ca-f606438bcb83",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d90dc3ce-bfe9-4a83-b10a-4df0c05e796e",
              "stock_item_ids": [
                "e8af58da-c3ac-4317-89fe-5f1b81b2ae80",
                "0002bcba-4bf6-4118-ba6f-43d9bf8d9a40"
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
          "stock_item_id e8af58da-c3ac-4317-89fe-5f1b81b2ae80 has already been booked on this order"
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
          "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
          "items": [
            {
              "type": "products",
              "id": "e4f048fd-ebac-414c-9de1-2ad541eab2f2",
              "stock_item_ids": [
                "059e79e4-f9f2-43f9-8cba-478a5c107235",
                "516d8869-1d13-4677-867e-6c285ebd480a",
                "eab5da8d-67b7-49b8-b93a-d935e68ff7e2"
              ]
            },
            {
              "type": "products",
              "id": "0418308e-c5fb-42a4-88d2-96dd48cf80bb",
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
    "id": "eacbe99c-5d7c-5a68-a485-2aefcffc307e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d5f7e241-2fcb-4f42-acd0-4f75d45babcf"
          },
          {
            "type": "lines",
            "id": "7914a7fa-b5c7-4fd4-b1f5-45a32b1bb6fa"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "96f9edac-5bae-4950-b40d-79cbd1c039b4"
          },
          {
            "type": "plannings",
            "id": "997ae4af-b1eb-4713-8c31-47a21af4786c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "4aab9107-f1aa-4f65-b6b7-ee9e39de5281"
          },
          {
            "type": "stock_item_plannings",
            "id": "01071f70-f3ea-42a3-94d4-9e2197948087"
          },
          {
            "type": "stock_item_plannings",
            "id": "4a41c023-df0f-4ce3-8b11-2149f976c7a3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-06T08:24:12+00:00",
        "updated_at": "2023-03-06T08:24:14+00:00",
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
        "customer_id": "9c953129-914a-4709-879c-3e4dda01dffe",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194",
        "stop_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194"
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
      "id": "d5f7e241-2fcb-4f42-acd0-4f75d45babcf",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:14+00:00",
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
        "item_id": "e4f048fd-ebac-414c-9de1-2ad541eab2f2",
        "tax_category_id": "3527b101-7825-4c94-8813-44e5516ed4e3",
        "planning_id": "96f9edac-5bae-4950-b40d-79cbd1c039b4",
        "parent_line_id": null,
        "owner_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
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
      "id": "7914a7fa-b5c7-4fd4-b1f5-45a32b1bb6fa",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:14+00:00",
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
        "item_id": "0418308e-c5fb-42a4-88d2-96dd48cf80bb",
        "tax_category_id": "3527b101-7825-4c94-8813-44e5516ed4e3",
        "planning_id": "997ae4af-b1eb-4713-8c31-47a21af4786c",
        "parent_line_id": null,
        "owner_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
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
      "id": "96f9edac-5bae-4950-b40d-79cbd1c039b4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:13+00:00",
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
        "item_id": "e4f048fd-ebac-414c-9de1-2ad541eab2f2",
        "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
        "start_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194",
        "stop_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194",
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
      "id": "997ae4af-b1eb-4713-8c31-47a21af4786c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:13+00:00",
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
        "item_id": "0418308e-c5fb-42a4-88d2-96dd48cf80bb",
        "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99",
        "start_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194",
        "stop_location_id": "7505397a-20c4-4fbd-b124-0235c2ddc194",
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
      "id": "4aab9107-f1aa-4f65-b6b7-ee9e39de5281",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "059e79e4-f9f2-43f9-8cba-478a5c107235",
        "planning_id": "96f9edac-5bae-4950-b40d-79cbd1c039b4",
        "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99"
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
      "id": "01071f70-f3ea-42a3-94d4-9e2197948087",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "516d8869-1d13-4677-867e-6c285ebd480a",
        "planning_id": "96f9edac-5bae-4950-b40d-79cbd1c039b4",
        "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99"
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
      "id": "4a41c023-df0f-4ce3-8b11-2149f976c7a3",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:13+00:00",
        "updated_at": "2023-03-06T08:24:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eab5da8d-67b7-49b8-b93a-d935e68ff7e2",
        "planning_id": "96f9edac-5bae-4950-b40d-79cbd1c039b4",
        "order_id": "ee2a2973-717e-4d3f-9fdc-5d504c893f99"
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
          "order_id": "56a0349d-92fc-4d45-ab96-23884fe473d6",
          "items": [
            {
              "type": "bundles",
              "id": "93915e6e-26df-4307-a813-32dff1c46b43",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6a777bbc-5101-4d66-8ee5-74bc77865628",
                  "id": "2548bddf-03c6-4803-8c04-6e8ee45e8277"
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
    "id": "a5a91e73-b293-5a95-9727-14cc25839523",
    "type": "order_bookings",
    "attributes": {
      "order_id": "56a0349d-92fc-4d45-ab96-23884fe473d6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "56a0349d-92fc-4d45-ab96-23884fe473d6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6efed99e-0842-4915-b129-5d21f395bdf5"
          },
          {
            "type": "lines",
            "id": "74208206-e880-495e-b7cf-d7770d20d6ec"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7ff32b73-5c98-43a1-a6b6-9decc5fb698c"
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
      "id": "56a0349d-92fc-4d45-ab96-23884fe473d6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-06T08:24:17+00:00",
        "updated_at": "2023-03-06T08:24:18+00:00",
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
        "starts_at": "2023-03-04T08:15:00+00:00",
        "stops_at": "2023-03-08T08:15:00+00:00",
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
        "start_location_id": "39ac1715-eefc-4ef0-9337-cfca2ed1c6fc",
        "stop_location_id": "39ac1715-eefc-4ef0-9337-cfca2ed1c6fc"
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
      "id": "6efed99e-0842-4915-b129-5d21f395bdf5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-06T08:24:17+00:00",
        "updated_at": "2023-03-06T08:24:17+00:00",
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
        "item_id": "93915e6e-26df-4307-a813-32dff1c46b43",
        "tax_category_id": null,
        "planning_id": "7ff32b73-5c98-43a1-a6b6-9decc5fb698c",
        "parent_line_id": null,
        "owner_id": "56a0349d-92fc-4d45-ab96-23884fe473d6",
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
      "id": "74208206-e880-495e-b7cf-d7770d20d6ec",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-06T08:24:17+00:00",
        "updated_at": "2023-03-06T08:24:17+00:00",
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
        "item_id": "2548bddf-03c6-4803-8c04-6e8ee45e8277",
        "tax_category_id": null,
        "planning_id": "8f81447b-c910-4258-b1f2-7f78ca9a1bbf",
        "parent_line_id": "6efed99e-0842-4915-b129-5d21f395bdf5",
        "owner_id": "56a0349d-92fc-4d45-ab96-23884fe473d6",
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
      "id": "7ff32b73-5c98-43a1-a6b6-9decc5fb698c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-06T08:24:17+00:00",
        "updated_at": "2023-03-06T08:24:17+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-04T08:15:00+00:00",
        "stops_at": "2023-03-08T08:15:00+00:00",
        "reserved_from": "2023-03-04T08:15:00+00:00",
        "reserved_till": "2023-03-08T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "93915e6e-26df-4307-a813-32dff1c46b43",
        "order_id": "56a0349d-92fc-4d45-ab96-23884fe473d6",
        "start_location_id": "39ac1715-eefc-4ef0-9337-cfca2ed1c6fc",
        "stop_location_id": "39ac1715-eefc-4ef0-9337-cfca2ed1c6fc",
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





