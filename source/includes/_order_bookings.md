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
          "order_id": "7ba3659a-bfcf-48c7-aaae-207021ed16b0",
          "items": [
            {
              "type": "products",
              "id": "2e9e0f03-aad2-40ca-accd-1c178bab307e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7fb54c1b-0062-4aa4-bb51-b891d0298d1c",
              "stock_item_ids": [
                "18291ddd-9747-4dad-9c2a-f97285358caa",
                "570d1a3f-f390-4930-afa9-e6fde47c9d42"
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
            "item_id": "2e9e0f03-aad2-40ca-accd-1c178bab307e",
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
          "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
          "items": [
            {
              "type": "products",
              "id": "47a4c0b0-8fe9-4a91-9680-906dbe72d931",
              "stock_item_ids": [
                "34dbc379-2e50-467c-a6d3-be893ee197f1",
                "5cae42d7-64d9-4bc8-beb2-2910541ee608",
                "31d3ca70-ebdb-4ee7-81be-2b6fa186d78f"
              ]
            },
            {
              "type": "products",
              "id": "7b894e1a-0d9c-49c2-a5e4-52161984b8f4",
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
    "id": "58d379cd-e225-5ce5-9777-3fc15a2d67cf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7bbbad14-8ef7-4532-834f-5dbbddabc51b"
          },
          {
            "type": "lines",
            "id": "027a2085-9b7a-4674-a96c-d741c6eb26dd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "fd6fa329-71cd-4844-9d35-f3d2b5729598"
          },
          {
            "type": "plannings",
            "id": "9f6c2e9b-49ae-4f2a-b6ac-6745ef87a51c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2bb41675-5428-4377-9aae-ab12273bd3eb"
          },
          {
            "type": "stock_item_plannings",
            "id": "1fb49612-f0b6-4f16-ab55-e904a4312375"
          },
          {
            "type": "stock_item_plannings",
            "id": "8de7b870-eadc-4f00-9213-5f9a76c8018c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T13:22:25+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
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
        "customer_id": "40e567e4-92a8-4682-8a97-e114d92205ce",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c",
        "stop_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c"
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
      "id": "7bbbad14-8ef7-4532-834f-5dbbddabc51b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
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
        "item_id": "47a4c0b0-8fe9-4a91-9680-906dbe72d931",
        "tax_category_id": "fb76c91f-a186-49b4-a5c2-6044f9852762",
        "planning_id": "fd6fa329-71cd-4844-9d35-f3d2b5729598",
        "parent_line_id": null,
        "owner_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
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
      "id": "027a2085-9b7a-4674-a96c-d741c6eb26dd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
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
        "item_id": "7b894e1a-0d9c-49c2-a5e4-52161984b8f4",
        "tax_category_id": "fb76c91f-a186-49b4-a5c2-6044f9852762",
        "planning_id": "9f6c2e9b-49ae-4f2a-b6ac-6745ef87a51c",
        "parent_line_id": null,
        "owner_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
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
      "id": "fd6fa329-71cd-4844-9d35-f3d2b5729598",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
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
        "item_id": "47a4c0b0-8fe9-4a91-9680-906dbe72d931",
        "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
        "start_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c",
        "stop_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c",
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
      "id": "9f6c2e9b-49ae-4f2a-b6ac-6745ef87a51c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
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
        "item_id": "7b894e1a-0d9c-49c2-a5e4-52161984b8f4",
        "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9",
        "start_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c",
        "stop_location_id": "bca077d1-f782-4d74-8d55-2435c52b879c",
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
      "id": "2bb41675-5428-4377-9aae-ab12273bd3eb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "34dbc379-2e50-467c-a6d3-be893ee197f1",
        "planning_id": "fd6fa329-71cd-4844-9d35-f3d2b5729598",
        "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9"
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
      "id": "1fb49612-f0b6-4f16-ab55-e904a4312375",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5cae42d7-64d9-4bc8-beb2-2910541ee608",
        "planning_id": "fd6fa329-71cd-4844-9d35-f3d2b5729598",
        "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9"
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
      "id": "8de7b870-eadc-4f00-9213-5f9a76c8018c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:27+00:00",
        "updated_at": "2023-01-24T13:22:27+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "31d3ca70-ebdb-4ee7-81be-2b6fa186d78f",
        "planning_id": "fd6fa329-71cd-4844-9d35-f3d2b5729598",
        "order_id": "609df77c-b5ca-462f-ad2d-d28e1c27d7c9"
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
          "order_id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b",
          "items": [
            {
              "type": "bundles",
              "id": "3fd6197c-b485-4a22-8cb7-72f2963533a3",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "d8a9fe81-2056-4ece-85bf-9875eefca050",
                  "id": "3a66891b-e523-4aa2-8fd2-6db3253a9b15"
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
    "id": "4a3d34c8-04b1-5934-ad66-bb7274ee9072",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a7f3b8e8-9354-415a-8077-7263789ac69a"
          },
          {
            "type": "lines",
            "id": "7d67eb53-c5a2-450b-8d5b-40f064aa7003"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "66662299-da4f-48cb-bb2d-d4f9d93df913"
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
      "id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b",
      "type": "orders",
      "attributes": {
        "created_at": "2023-01-24T13:22:29+00:00",
        "updated_at": "2023-01-24T13:22:30+00:00",
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
        "starts_at": "2023-01-22T13:15:00+00:00",
        "stops_at": "2023-01-26T13:15:00+00:00",
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
        "start_location_id": "583a0593-58c5-4cea-9ce0-3fdcda86bdb8",
        "stop_location_id": "583a0593-58c5-4cea-9ce0-3fdcda86bdb8"
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
      "id": "a7f3b8e8-9354-415a-8077-7263789ac69a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T13:22:30+00:00",
        "updated_at": "2023-01-24T13:22:30+00:00",
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
        "item_id": "3fd6197c-b485-4a22-8cb7-72f2963533a3",
        "tax_category_id": null,
        "planning_id": "66662299-da4f-48cb-bb2d-d4f9d93df913",
        "parent_line_id": null,
        "owner_id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b",
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
      "id": "7d67eb53-c5a2-450b-8d5b-40f064aa7003",
      "type": "lines",
      "attributes": {
        "created_at": "2023-01-24T13:22:30+00:00",
        "updated_at": "2023-01-24T13:22:30+00:00",
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
        "item_id": "3a66891b-e523-4aa2-8fd2-6db3253a9b15",
        "tax_category_id": null,
        "planning_id": "aace0a1b-c7f5-43bd-9bc9-e6246bd48786",
        "parent_line_id": "a7f3b8e8-9354-415a-8077-7263789ac69a",
        "owner_id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b",
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
      "id": "66662299-da4f-48cb-bb2d-d4f9d93df913",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-01-24T13:22:30+00:00",
        "updated_at": "2023-01-24T13:22:30+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-01-22T13:15:00+00:00",
        "stops_at": "2023-01-26T13:15:00+00:00",
        "reserved_from": "2023-01-22T13:15:00+00:00",
        "reserved_till": "2023-01-26T13:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "3fd6197c-b485-4a22-8cb7-72f2963533a3",
        "order_id": "c54a1ff2-acc4-4549-90b1-5147f79ad71b",
        "start_location_id": "583a0593-58c5-4cea-9ce0-3fdcda86bdb8",
        "stop_location_id": "583a0593-58c5-4cea-9ce0-3fdcda86bdb8",
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





