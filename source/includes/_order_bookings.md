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
          "order_id": "7d42ec10-402a-41b5-96b4-dcb2012ec93f",
          "items": [
            {
              "type": "products",
              "id": "648a6828-0986-407a-9cb8-47fc67066435",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "fc31e9ab-da2e-4e47-98bf-f1d8d9029308",
              "stock_item_ids": [
                "1e04a249-7128-4867-9fdf-202a1d706d84",
                "29cc022a-c288-44ff-bbca-d50f24b39d0a"
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
          "stock_item_id 1e04a249-7128-4867-9fdf-202a1d706d84 has already been booked on this order"
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
          "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
          "items": [
            {
              "type": "products",
              "id": "684910f6-18c0-4dbc-afef-abc0907e066d",
              "stock_item_ids": [
                "33f373f4-554c-411e-8b70-edb48e42971a",
                "7e6ec26b-d785-4c0a-bff3-e277c3b9b9a6",
                "3ca7da2a-e09a-4944-8c24-ce0f529d75ca"
              ]
            },
            {
              "type": "products",
              "id": "05bc1e31-b353-4b39-be64-d29a000b2899",
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
    "id": "4e20e9de-05a9-561c-950d-77b7657ab59c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7decabfb-41c1-4f4a-8a6c-27bca69b2a73"
          },
          {
            "type": "lines",
            "id": "878fc021-a0f4-40ca-a8a7-596b3fee9d24"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8eaab95f-13d3-4805-b588-4377b5a69f76"
          },
          {
            "type": "plannings",
            "id": "c3947fe5-4315-497d-830f-c543667550f7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "b45c393d-4aff-42e8-875c-47ea99f2e970"
          },
          {
            "type": "stock_item_plannings",
            "id": "96356cf7-c416-43be-9105-a47b19558fd9"
          },
          {
            "type": "stock_item_plannings",
            "id": "95fc373b-ca74-4722-963d-05f902c6670c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T12:47:26+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
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
        "customer_id": "2c2feb3b-bef2-4d29-ba0b-ecd712c3c057",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25",
        "stop_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25"
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
      "id": "7decabfb-41c1-4f4a-8a6c-27bca69b2a73",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
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
        "item_id": "684910f6-18c0-4dbc-afef-abc0907e066d",
        "tax_category_id": "fc82a14b-96b4-401f-959b-609063aac414",
        "planning_id": "8eaab95f-13d3-4805-b588-4377b5a69f76",
        "parent_line_id": null,
        "owner_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
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
      "id": "878fc021-a0f4-40ca-a8a7-596b3fee9d24",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
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
        "item_id": "05bc1e31-b353-4b39-be64-d29a000b2899",
        "tax_category_id": "fc82a14b-96b4-401f-959b-609063aac414",
        "planning_id": "c3947fe5-4315-497d-830f-c543667550f7",
        "parent_line_id": null,
        "owner_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
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
      "id": "8eaab95f-13d3-4805-b588-4377b5a69f76",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
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
        "item_id": "684910f6-18c0-4dbc-afef-abc0907e066d",
        "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
        "start_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25",
        "stop_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25",
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
      "id": "c3947fe5-4315-497d-830f-c543667550f7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
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
        "item_id": "05bc1e31-b353-4b39-be64-d29a000b2899",
        "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d",
        "start_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25",
        "stop_location_id": "f0c0c3e6-8618-4fcf-b569-f5fe29f3fc25",
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
      "id": "b45c393d-4aff-42e8-875c-47ea99f2e970",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "33f373f4-554c-411e-8b70-edb48e42971a",
        "planning_id": "8eaab95f-13d3-4805-b588-4377b5a69f76",
        "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d"
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
      "id": "96356cf7-c416-43be-9105-a47b19558fd9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7e6ec26b-d785-4c0a-bff3-e277c3b9b9a6",
        "planning_id": "8eaab95f-13d3-4805-b588-4377b5a69f76",
        "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d"
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
      "id": "95fc373b-ca74-4722-963d-05f902c6670c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:28+00:00",
        "updated_at": "2023-02-14T12:47:28+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3ca7da2a-e09a-4944-8c24-ce0f529d75ca",
        "planning_id": "8eaab95f-13d3-4805-b588-4377b5a69f76",
        "order_id": "2b7a728b-26d6-492d-8387-b11a1b0ed27d"
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
          "order_id": "41fac427-4339-4c4d-8909-e5c0935bf8af",
          "items": [
            {
              "type": "bundles",
              "id": "c2a9ecaf-bc51-4368-ac2b-658fa5b43823",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "a0e31f87-4c85-48bf-8e6c-6cc920d83aba",
                  "id": "c5d4c9cd-9314-4836-9c6a-84f51f307216"
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
    "id": "17a62aa6-b582-5786-afb8-55533020be2a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "41fac427-4339-4c4d-8909-e5c0935bf8af"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "41fac427-4339-4c4d-8909-e5c0935bf8af"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2318c710-7f7c-4680-a676-5829248e58a6"
          },
          {
            "type": "lines",
            "id": "e0ec0298-9488-4ae1-863e-f72c9a112ea9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2b449dbd-696f-432f-b356-ee097e5e2b55"
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
      "id": "41fac427-4339-4c4d-8909-e5c0935bf8af",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-14T12:47:31+00:00",
        "updated_at": "2023-02-14T12:47:31+00:00",
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
        "starts_at": "2023-02-12T12:45:00+00:00",
        "stops_at": "2023-02-16T12:45:00+00:00",
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
        "start_location_id": "9ccdd7af-4797-44ec-aff7-01b17be55d02",
        "stop_location_id": "9ccdd7af-4797-44ec-aff7-01b17be55d02"
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
      "id": "2318c710-7f7c-4680-a676-5829248e58a6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T12:47:31+00:00",
        "updated_at": "2023-02-14T12:47:31+00:00",
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
        "item_id": "c2a9ecaf-bc51-4368-ac2b-658fa5b43823",
        "tax_category_id": null,
        "planning_id": "2b449dbd-696f-432f-b356-ee097e5e2b55",
        "parent_line_id": null,
        "owner_id": "41fac427-4339-4c4d-8909-e5c0935bf8af",
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
      "id": "e0ec0298-9488-4ae1-863e-f72c9a112ea9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-14T12:47:31+00:00",
        "updated_at": "2023-02-14T12:47:31+00:00",
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
        "item_id": "c5d4c9cd-9314-4836-9c6a-84f51f307216",
        "tax_category_id": null,
        "planning_id": "46b6802d-b6e0-4d3f-878b-bf6c0965766a",
        "parent_line_id": "2318c710-7f7c-4680-a676-5829248e58a6",
        "owner_id": "41fac427-4339-4c4d-8909-e5c0935bf8af",
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
      "id": "2b449dbd-696f-432f-b356-ee097e5e2b55",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-14T12:47:31+00:00",
        "updated_at": "2023-02-14T12:47:31+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-12T12:45:00+00:00",
        "stops_at": "2023-02-16T12:45:00+00:00",
        "reserved_from": "2023-02-12T12:45:00+00:00",
        "reserved_till": "2023-02-16T12:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "c2a9ecaf-bc51-4368-ac2b-658fa5b43823",
        "order_id": "41fac427-4339-4c4d-8909-e5c0935bf8af",
        "start_location_id": "9ccdd7af-4797-44ec-aff7-01b17be55d02",
        "stop_location_id": "9ccdd7af-4797-44ec-aff7-01b17be55d02",
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





