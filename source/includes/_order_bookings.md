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
          "order_id": "dde747c5-038f-48d5-8edc-0e0304791205",
          "items": [
            {
              "type": "products",
              "id": "9d0ccfb7-6211-4c19-a42b-82f9b171b63a",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4e3109dc-fb48-4d6f-a27f-75e4e4ec3eb5",
              "stock_item_ids": [
                "0863a935-9ab4-4045-94e4-8f56fffc8acf",
                "ccd3711d-0c69-4bff-951e-11ddd9a4c41e"
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
          "stock_item_id 0863a935-9ab4-4045-94e4-8f56fffc8acf has already been booked on this order"
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
          "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
          "items": [
            {
              "type": "products",
              "id": "42a1a5db-b7c3-4fe0-a8a1-6afd2debf0f1",
              "stock_item_ids": [
                "b473c12d-0b46-41c3-abfe-17cf230ba394",
                "cadfe5d3-a8ff-4cb5-99e6-24f28a639754",
                "ee8bbab8-3e82-437c-87d2-3a1791fed8ce"
              ]
            },
            {
              "type": "products",
              "id": "f6c1e86d-a256-4282-a0bb-925193092528",
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
    "id": "604b65c2-a7c4-58e6-b5ef-016fec899658",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ca7f6d1e-233a-4c44-ade4-d105decceb72"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "5acef49e-5841-440d-8adc-05a8810c7dc5"
          },
          {
            "type": "lines",
            "id": "095d1267-412c-4e91-a79d-9e9a3a122fb1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "afc68320-c114-478f-a0a2-5b93f3df35c9"
          },
          {
            "type": "plannings",
            "id": "c613c5a7-b7c7-492d-8fbc-5f701a1a91de"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6b03bd8d-7caa-4e62-a0c2-e37ba3314090"
          },
          {
            "type": "stock_item_plannings",
            "id": "806cb52b-e789-402b-ae43-053bd7b343dc"
          },
          {
            "type": "stock_item_plannings",
            "id": "a80e4b00-1440-4d80-8862-cec7eb5fb0df"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T10:32:13+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
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
        "customer_id": "fae102bb-121d-461b-8fbb-0fe5fbbc9234",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08",
        "stop_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08"
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
      "id": "5acef49e-5841-440d-8adc-05a8810c7dc5",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
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
        "item_id": "42a1a5db-b7c3-4fe0-a8a1-6afd2debf0f1",
        "tax_category_id": "ea4d32ea-c2e7-4ab3-bad5-4814f4c16bc6",
        "planning_id": "afc68320-c114-478f-a0a2-5b93f3df35c9",
        "parent_line_id": null,
        "owner_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
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
      "id": "095d1267-412c-4e91-a79d-9e9a3a122fb1",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
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
        "item_id": "f6c1e86d-a256-4282-a0bb-925193092528",
        "tax_category_id": "ea4d32ea-c2e7-4ab3-bad5-4814f4c16bc6",
        "planning_id": "c613c5a7-b7c7-492d-8fbc-5f701a1a91de",
        "parent_line_id": null,
        "owner_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
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
      "id": "afc68320-c114-478f-a0a2-5b93f3df35c9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
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
        "item_id": "42a1a5db-b7c3-4fe0-a8a1-6afd2debf0f1",
        "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
        "start_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08",
        "stop_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08",
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
      "id": "c613c5a7-b7c7-492d-8fbc-5f701a1a91de",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
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
        "item_id": "f6c1e86d-a256-4282-a0bb-925193092528",
        "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72",
        "start_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08",
        "stop_location_id": "d60bf5aa-b282-474f-ba35-9602f7a8ca08",
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
      "id": "6b03bd8d-7caa-4e62-a0c2-e37ba3314090",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b473c12d-0b46-41c3-abfe-17cf230ba394",
        "planning_id": "afc68320-c114-478f-a0a2-5b93f3df35c9",
        "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72"
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
      "id": "806cb52b-e789-402b-ae43-053bd7b343dc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cadfe5d3-a8ff-4cb5-99e6-24f28a639754",
        "planning_id": "afc68320-c114-478f-a0a2-5b93f3df35c9",
        "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72"
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
      "id": "a80e4b00-1440-4d80-8862-cec7eb5fb0df",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:15+00:00",
        "updated_at": "2023-03-01T10:32:15+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ee8bbab8-3e82-437c-87d2-3a1791fed8ce",
        "planning_id": "afc68320-c114-478f-a0a2-5b93f3df35c9",
        "order_id": "ca7f6d1e-233a-4c44-ade4-d105decceb72"
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
          "order_id": "d3b0b16b-9918-405a-894a-eec43c136ea4",
          "items": [
            {
              "type": "bundles",
              "id": "e7f5100c-079b-497b-8dec-1a9bcb68ce8a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "51ea6e1e-2598-4d81-9aa8-d221fd5ed72d",
                  "id": "c66dcd9f-cb97-4a07-ba3b-da210cb41545"
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
    "id": "b11dc060-6134-5e0e-9823-9aa0e5d196a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "d3b0b16b-9918-405a-894a-eec43c136ea4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "d3b0b16b-9918-405a-894a-eec43c136ea4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0232f821-ea69-4ecd-8335-1ced04769430"
          },
          {
            "type": "lines",
            "id": "0c000381-5088-4f7e-bdcf-7440a4e96aff"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fd3712c9-fc66-49c2-a2a4-5fd0eece05c3"
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
      "id": "d3b0b16b-9918-405a-894a-eec43c136ea4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T10:32:18+00:00",
        "updated_at": "2023-03-01T10:32:18+00:00",
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
        "starts_at": "2023-02-27T10:30:00+00:00",
        "stops_at": "2023-03-03T10:30:00+00:00",
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
        "start_location_id": "75c5f9f2-a606-4299-b093-a2b50ecfea84",
        "stop_location_id": "75c5f9f2-a606-4299-b093-a2b50ecfea84"
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
      "id": "0232f821-ea69-4ecd-8335-1ced04769430",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:32:18+00:00",
        "updated_at": "2023-03-01T10:32:18+00:00",
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
        "item_id": "c66dcd9f-cb97-4a07-ba3b-da210cb41545",
        "tax_category_id": null,
        "planning_id": "1683a01a-e32c-47c7-8891-8cba5b232bf1",
        "parent_line_id": "0c000381-5088-4f7e-bdcf-7440a4e96aff",
        "owner_id": "d3b0b16b-9918-405a-894a-eec43c136ea4",
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
      "id": "0c000381-5088-4f7e-bdcf-7440a4e96aff",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T10:32:18+00:00",
        "updated_at": "2023-03-01T10:32:18+00:00",
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
        "item_id": "e7f5100c-079b-497b-8dec-1a9bcb68ce8a",
        "tax_category_id": null,
        "planning_id": "fd3712c9-fc66-49c2-a2a4-5fd0eece05c3",
        "parent_line_id": null,
        "owner_id": "d3b0b16b-9918-405a-894a-eec43c136ea4",
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
      "id": "fd3712c9-fc66-49c2-a2a4-5fd0eece05c3",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T10:32:18+00:00",
        "updated_at": "2023-03-01T10:32:18+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-27T10:30:00+00:00",
        "stops_at": "2023-03-03T10:30:00+00:00",
        "reserved_from": "2023-02-27T10:30:00+00:00",
        "reserved_till": "2023-03-03T10:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e7f5100c-079b-497b-8dec-1a9bcb68ce8a",
        "order_id": "d3b0b16b-9918-405a-894a-eec43c136ea4",
        "start_location_id": "75c5f9f2-a606-4299-b093-a2b50ecfea84",
        "stop_location_id": "75c5f9f2-a606-4299-b093-a2b50ecfea84",
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





