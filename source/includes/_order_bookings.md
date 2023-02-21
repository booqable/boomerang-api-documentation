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
          "order_id": "97faa1b1-f561-4c91-a39b-389a0499c6f9",
          "items": [
            {
              "type": "products",
              "id": "3531d05f-2740-460a-8a30-d8a65b778ac0",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b209f56c-2a52-4aa9-b963-1078cc1d496f",
              "stock_item_ids": [
                "d558c02f-4dcb-4c1e-99cd-1fa4edb6411f",
                "0421a179-2391-4b69-a92f-e6857f5f0ba2"
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
          "stock_item_id d558c02f-4dcb-4c1e-99cd-1fa4edb6411f has already been booked on this order"
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
          "order_id": "52976037-514c-4836-a20c-efd36ac73499",
          "items": [
            {
              "type": "products",
              "id": "e22448f0-765b-4cff-85da-713c5c43d03e",
              "stock_item_ids": [
                "af551db6-80d8-4a82-b38c-f246140cdd76",
                "05bed71b-db33-4b2a-b196-e1f1b632a2ed",
                "22034d6e-3867-46cb-bb15-387e498fdef4"
              ]
            },
            {
              "type": "products",
              "id": "8fcc3a22-05ca-4e17-95e6-73c0dfe3107a",
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
    "id": "8eff867b-4bcd-5b78-bdf8-0110f0b787d3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "52976037-514c-4836-a20c-efd36ac73499"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "52976037-514c-4836-a20c-efd36ac73499"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9ffe44d1-1553-4676-9fef-5932fcac0b21"
          },
          {
            "type": "lines",
            "id": "2be7764c-9168-4557-ab20-d5f10b92c672"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "68264e79-1457-4e95-bf80-138402244e39"
          },
          {
            "type": "plannings",
            "id": "5f95904f-b993-4f17-9e15-6ac52f827bf6"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "14d32ac0-5e58-4546-b909-cbcd8f1b0861"
          },
          {
            "type": "stock_item_plannings",
            "id": "bd89743f-bacc-4110-a4b0-b6c30a07f628"
          },
          {
            "type": "stock_item_plannings",
            "id": "d62cd6a5-d2bd-41cf-8473-b29ef887a36c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "52976037-514c-4836-a20c-efd36ac73499",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T08:20:23+00:00",
        "updated_at": "2023-02-21T08:20:25+00:00",
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
        "customer_id": "9056e8c7-96e1-473a-af97-8bdc4cc1009c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785",
        "stop_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785"
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
      "id": "9ffe44d1-1553-4676-9fef-5932fcac0b21",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
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
        "item_id": "e22448f0-765b-4cff-85da-713c5c43d03e",
        "tax_category_id": "3ab46741-97d7-4527-9e7d-6107aa387c6f",
        "planning_id": "68264e79-1457-4e95-bf80-138402244e39",
        "parent_line_id": null,
        "owner_id": "52976037-514c-4836-a20c-efd36ac73499",
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
      "id": "2be7764c-9168-4557-ab20-d5f10b92c672",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
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
        "item_id": "8fcc3a22-05ca-4e17-95e6-73c0dfe3107a",
        "tax_category_id": "3ab46741-97d7-4527-9e7d-6107aa387c6f",
        "planning_id": "5f95904f-b993-4f17-9e15-6ac52f827bf6",
        "parent_line_id": null,
        "owner_id": "52976037-514c-4836-a20c-efd36ac73499",
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
      "id": "68264e79-1457-4e95-bf80-138402244e39",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
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
        "item_id": "e22448f0-765b-4cff-85da-713c5c43d03e",
        "order_id": "52976037-514c-4836-a20c-efd36ac73499",
        "start_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785",
        "stop_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785",
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
      "id": "5f95904f-b993-4f17-9e15-6ac52f827bf6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
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
        "item_id": "8fcc3a22-05ca-4e17-95e6-73c0dfe3107a",
        "order_id": "52976037-514c-4836-a20c-efd36ac73499",
        "start_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785",
        "stop_location_id": "dd585c3b-9ef0-4f68-9bcc-f64c59966785",
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
      "id": "14d32ac0-5e58-4546-b909-cbcd8f1b0861",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af551db6-80d8-4a82-b38c-f246140cdd76",
        "planning_id": "68264e79-1457-4e95-bf80-138402244e39",
        "order_id": "52976037-514c-4836-a20c-efd36ac73499"
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
      "id": "bd89743f-bacc-4110-a4b0-b6c30a07f628",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "05bed71b-db33-4b2a-b196-e1f1b632a2ed",
        "planning_id": "68264e79-1457-4e95-bf80-138402244e39",
        "order_id": "52976037-514c-4836-a20c-efd36ac73499"
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
      "id": "d62cd6a5-d2bd-41cf-8473-b29ef887a36c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:24+00:00",
        "updated_at": "2023-02-21T08:20:24+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "22034d6e-3867-46cb-bb15-387e498fdef4",
        "planning_id": "68264e79-1457-4e95-bf80-138402244e39",
        "order_id": "52976037-514c-4836-a20c-efd36ac73499"
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
          "order_id": "2ce08bc8-8713-46f3-bec4-40e074e90a33",
          "items": [
            {
              "type": "bundles",
              "id": "5de26504-152e-4409-b378-aedfac889a49",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d7c13419-c2e3-41d9-bbe9-29372bc8b7cf",
                  "id": "c1893ffc-c202-4bc1-9bb5-3e0ed332c45a"
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
    "id": "04532a88-532a-5d0b-b73b-9c777a008dc1",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2ce08bc8-8713-46f3-bec4-40e074e90a33"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2ce08bc8-8713-46f3-bec4-40e074e90a33"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "dcbb906d-2733-4456-a0f0-b2845a9f775f"
          },
          {
            "type": "lines",
            "id": "94b4ffcf-1e61-4996-978a-d5caf53b5eed"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "d4703496-fc07-40c5-b6af-9ca4269bd8b4"
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
      "id": "2ce08bc8-8713-46f3-bec4-40e074e90a33",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-21T08:20:26+00:00",
        "updated_at": "2023-02-21T08:20:27+00:00",
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
        "starts_at": "2023-02-19T08:15:00+00:00",
        "stops_at": "2023-02-23T08:15:00+00:00",
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
        "start_location_id": "dd08878f-49b7-4996-9ed8-773704b7fa84",
        "stop_location_id": "dd08878f-49b7-4996-9ed8-773704b7fa84"
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
      "id": "dcbb906d-2733-4456-a0f0-b2845a9f775f",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T08:20:27+00:00",
        "updated_at": "2023-02-21T08:20:27+00:00",
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
        "item_id": "c1893ffc-c202-4bc1-9bb5-3e0ed332c45a",
        "tax_category_id": null,
        "planning_id": "56828f1f-8253-4774-955e-e2e86666c8c4",
        "parent_line_id": "94b4ffcf-1e61-4996-978a-d5caf53b5eed",
        "owner_id": "2ce08bc8-8713-46f3-bec4-40e074e90a33",
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
      "id": "94b4ffcf-1e61-4996-978a-d5caf53b5eed",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-21T08:20:27+00:00",
        "updated_at": "2023-02-21T08:20:27+00:00",
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
        "item_id": "5de26504-152e-4409-b378-aedfac889a49",
        "tax_category_id": null,
        "planning_id": "d4703496-fc07-40c5-b6af-9ca4269bd8b4",
        "parent_line_id": null,
        "owner_id": "2ce08bc8-8713-46f3-bec4-40e074e90a33",
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
      "id": "d4703496-fc07-40c5-b6af-9ca4269bd8b4",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-21T08:20:27+00:00",
        "updated_at": "2023-02-21T08:20:27+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-19T08:15:00+00:00",
        "stops_at": "2023-02-23T08:15:00+00:00",
        "reserved_from": "2023-02-19T08:15:00+00:00",
        "reserved_till": "2023-02-23T08:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "5de26504-152e-4409-b378-aedfac889a49",
        "order_id": "2ce08bc8-8713-46f3-bec4-40e074e90a33",
        "start_location_id": "dd08878f-49b7-4996-9ed8-773704b7fa84",
        "stop_location_id": "dd08878f-49b7-4996-9ed8-773704b7fa84",
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





