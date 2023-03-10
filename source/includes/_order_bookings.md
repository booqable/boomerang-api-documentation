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
          "order_id": "daefe981-42bd-4d18-aa7f-fc6e0deee364",
          "items": [
            {
              "type": "products",
              "id": "569ce066-4169-4906-9a0d-99091f15515e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "af3110c7-5890-450b-9e69-55343371b989",
              "stock_item_ids": [
                "f0c51479-56fd-4b67-bcf4-70b6691c64e4",
                "988eacbe-a7fa-4cfb-93f3-f9c3d00332a6"
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
          "stock_item_id f0c51479-56fd-4b67-bcf4-70b6691c64e4 has already been booked on this order"
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
          "order_id": "4453c479-1c2e-471f-941a-877fb46f7525",
          "items": [
            {
              "type": "products",
              "id": "7214cfd3-36c5-48d5-a1d7-c00ea310dfa1",
              "stock_item_ids": [
                "7c74ca0e-3c58-4e67-9382-a09953785240",
                "58e38aa2-ec52-4a88-a559-f9f3e98426a9",
                "7e299c60-9fd5-4bcc-9fb4-9bb1bc737ffe"
              ]
            },
            {
              "type": "products",
              "id": "110e2e30-1823-4be9-b3c1-7761c98b9a81",
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
    "id": "d441c2ae-4b75-542a-8ba1-94cfee1c9c15",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4453c479-1c2e-471f-941a-877fb46f7525"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4453c479-1c2e-471f-941a-877fb46f7525"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "793f0893-be91-442c-949a-de4e5234ecd7"
          },
          {
            "type": "lines",
            "id": "fed70bf5-acfb-4e11-86e3-78de6c04ca9b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "440bf88e-ec92-485d-bb31-48f18252f5f7"
          },
          {
            "type": "plannings",
            "id": "c0c1eca6-01b3-4ac5-8e61-e9049bc6096a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "ef431444-fd0e-46ed-8bf4-d99fa545b5a8"
          },
          {
            "type": "stock_item_plannings",
            "id": "2b27b545-e0cb-47a3-9d03-4c3cfc308500"
          },
          {
            "type": "stock_item_plannings",
            "id": "66edbde6-1d39-484e-b2fd-82908f1560e1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4453c479-1c2e-471f-941a-877fb46f7525",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-10T08:38:59+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
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
        "customer_id": "a3184cf3-cd2f-46ea-a53c-ef29003a9b6d",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae",
        "stop_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae"
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
      "id": "793f0893-be91-442c-949a-de4e5234ecd7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-10T08:39:02+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
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
        "item_id": "7214cfd3-36c5-48d5-a1d7-c00ea310dfa1",
        "tax_category_id": "c0077819-bafb-47d5-9baa-f5de5cb16971",
        "planning_id": "440bf88e-ec92-485d-bb31-48f18252f5f7",
        "parent_line_id": null,
        "owner_id": "4453c479-1c2e-471f-941a-877fb46f7525",
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
      "id": "fed70bf5-acfb-4e11-86e3-78de6c04ca9b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-10T08:39:02+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
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
        "item_id": "110e2e30-1823-4be9-b3c1-7761c98b9a81",
        "tax_category_id": "c0077819-bafb-47d5-9baa-f5de5cb16971",
        "planning_id": "c0c1eca6-01b3-4ac5-8e61-e9049bc6096a",
        "parent_line_id": null,
        "owner_id": "4453c479-1c2e-471f-941a-877fb46f7525",
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
      "id": "440bf88e-ec92-485d-bb31-48f18252f5f7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:01+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
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
        "item_id": "7214cfd3-36c5-48d5-a1d7-c00ea310dfa1",
        "order_id": "4453c479-1c2e-471f-941a-877fb46f7525",
        "start_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae",
        "stop_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae",
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
      "id": "c0c1eca6-01b3-4ac5-8e61-e9049bc6096a",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:01+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
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
        "item_id": "110e2e30-1823-4be9-b3c1-7761c98b9a81",
        "order_id": "4453c479-1c2e-471f-941a-877fb46f7525",
        "start_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae",
        "stop_location_id": "624cd8e5-4512-4a19-8420-a8473ad6feae",
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
      "id": "ef431444-fd0e-46ed-8bf4-d99fa545b5a8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:01+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7c74ca0e-3c58-4e67-9382-a09953785240",
        "planning_id": "440bf88e-ec92-485d-bb31-48f18252f5f7",
        "order_id": "4453c479-1c2e-471f-941a-877fb46f7525"
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
      "id": "2b27b545-e0cb-47a3-9d03-4c3cfc308500",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:01+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "58e38aa2-ec52-4a88-a559-f9f3e98426a9",
        "planning_id": "440bf88e-ec92-485d-bb31-48f18252f5f7",
        "order_id": "4453c479-1c2e-471f-941a-877fb46f7525"
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
      "id": "66edbde6-1d39-484e-b2fd-82908f1560e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:01+00:00",
        "updated_at": "2023-03-10T08:39:02+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7e299c60-9fd5-4bcc-9fb4-9bb1bc737ffe",
        "planning_id": "440bf88e-ec92-485d-bb31-48f18252f5f7",
        "order_id": "4453c479-1c2e-471f-941a-877fb46f7525"
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
          "order_id": "d98d2640-a8b7-4149-bdbb-538d2736ba98",
          "items": [
            {
              "type": "bundles",
              "id": "e7e49a1d-3a96-4e9e-8ca6-80ab41ac3699",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e9f037b4-07a8-4a2e-be7f-dcf02f303828",
                  "id": "dfa1b696-f831-4888-86c9-1b6ba0db461a"
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
    "id": "bbe9faf6-e95f-55e0-a682-38d8edc98768",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d98d2640-a8b7-4149-bdbb-538d2736ba98"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d98d2640-a8b7-4149-bdbb-538d2736ba98"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "daff1c87-1ab7-46fd-86ec-81e749141331"
          },
          {
            "type": "lines",
            "id": "2f4387fc-7598-43a3-8659-cbca5d893a38"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ceac6512-bfae-470c-a568-9fa2fb5bdf42"
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
      "id": "d98d2640-a8b7-4149-bdbb-538d2736ba98",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-10T08:39:05+00:00",
        "updated_at": "2023-03-10T08:39:05+00:00",
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
        "starts_at": "2023-03-08T08:30:00+00:00",
        "stops_at": "2023-03-12T08:30:00+00:00",
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
        "start_location_id": "7adcfb20-a131-4490-8694-c4124cb888e0",
        "stop_location_id": "7adcfb20-a131-4490-8694-c4124cb888e0"
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
      "id": "daff1c87-1ab7-46fd-86ec-81e749141331",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-10T08:39:05+00:00",
        "updated_at": "2023-03-10T08:39:05+00:00",
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
        "item_id": "dfa1b696-f831-4888-86c9-1b6ba0db461a",
        "tax_category_id": null,
        "planning_id": "1e37aa22-628c-4c22-8b23-fe9a47feb535",
        "parent_line_id": "2f4387fc-7598-43a3-8659-cbca5d893a38",
        "owner_id": "d98d2640-a8b7-4149-bdbb-538d2736ba98",
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
      "id": "2f4387fc-7598-43a3-8659-cbca5d893a38",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-10T08:39:05+00:00",
        "updated_at": "2023-03-10T08:39:05+00:00",
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
        "item_id": "e7e49a1d-3a96-4e9e-8ca6-80ab41ac3699",
        "tax_category_id": null,
        "planning_id": "ceac6512-bfae-470c-a568-9fa2fb5bdf42",
        "parent_line_id": null,
        "owner_id": "d98d2640-a8b7-4149-bdbb-538d2736ba98",
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
      "id": "ceac6512-bfae-470c-a568-9fa2fb5bdf42",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-10T08:39:05+00:00",
        "updated_at": "2023-03-10T08:39:05+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-08T08:30:00+00:00",
        "stops_at": "2023-03-12T08:30:00+00:00",
        "reserved_from": "2023-03-08T08:30:00+00:00",
        "reserved_till": "2023-03-12T08:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e7e49a1d-3a96-4e9e-8ca6-80ab41ac3699",
        "order_id": "d98d2640-a8b7-4149-bdbb-538d2736ba98",
        "start_location_id": "7adcfb20-a131-4490-8694-c4124cb888e0",
        "stop_location_id": "7adcfb20-a131-4490-8694-c4124cb888e0",
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





