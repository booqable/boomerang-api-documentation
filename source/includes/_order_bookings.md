# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
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
          "order_id": "9b4b10be-f4f7-4e9f-b420-e3567b988bef",
          "items": [
            {
              "type": "products",
              "id": "354ff869-2770-4fa1-9959-c2453e889ff5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4d5c5d05-2365-4295-b299-0d705a98389b",
              "stock_item_ids": [
                "f7b144ff-5d94-4452-a032-b8f575b8f77b",
                "9c0f161b-2277-48f1-9b25-0a80bba01391"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id f7b144ff-5d94-4452-a032-b8f575b8f77b has already been booked on this order"
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
          "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
          "items": [
            {
              "type": "products",
              "id": "780fa97d-de00-4eaa-8235-98e1f6a46e2a",
              "stock_item_ids": [
                "718159c8-ebee-45bd-acf1-d585e6bf1c97",
                "479f1a11-12a5-4928-91d0-4622e3ca538f",
                "a69551ff-13b8-4069-93ae-dfbdbf7837a0"
              ]
            },
            {
              "type": "products",
              "id": "5a9dc424-d981-44fd-97fd-85543764650a",
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
    "id": "f31a7e70-d08d-5eee-a57a-cda6bf805729",
    "type": "order_bookings",
    "attributes": {
      "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "0144f644-c22d-4307-901d-6cf5d3b7d60d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "52c7ec9c-c867-46e2-af38-1f35d6986145"
          },
          {
            "type": "lines",
            "id": "063a3465-85e7-4f98-9240-c0f2427ca1bd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "04165ca2-28e4-45c8-a132-a2306ec1a8be"
          },
          {
            "type": "plannings",
            "id": "faf9f28b-4e81-4509-8ff1-40c66ce75427"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "1208d117-4b6a-4826-9b3e-8891b7fb623e"
          },
          {
            "type": "stock_item_plannings",
            "id": "6a02e8a7-d1fa-47f1-bbc4-a8274b76ab29"
          },
          {
            "type": "stock_item_plannings",
            "id": "e7399787-635f-4731-bd8e-35d077fb31a0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-07T18:41:30+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
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
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "84cf0d8b-b9a2-469e-a375-c117b8688bfa",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036",
        "stop_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036"
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
      "id": "52c7ec9c-c867-46e2-af38-1f35d6986145",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "item_id": "780fa97d-de00-4eaa-8235-98e1f6a46e2a",
        "tax_category_id": "37391443-a2b0-49cd-89ae-58bbcf75069e",
        "planning_id": "04165ca2-28e4-45c8-a132-a2306ec1a8be",
        "parent_line_id": null,
        "owner_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "063a3465-85e7-4f98-9240-c0f2427ca1bd",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "item_id": "5a9dc424-d981-44fd-97fd-85543764650a",
        "tax_category_id": "37391443-a2b0-49cd-89ae-58bbcf75069e",
        "planning_id": "faf9f28b-4e81-4509-8ff1-40c66ce75427",
        "parent_line_id": null,
        "owner_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "04165ca2-28e4-45c8-a132-a2306ec1a8be",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
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
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "item_id": "780fa97d-de00-4eaa-8235-98e1f6a46e2a",
        "start_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036",
        "stop_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "faf9f28b-4e81-4509-8ff1-40c66ce75427",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
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
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d",
        "item_id": "5a9dc424-d981-44fd-97fd-85543764650a",
        "start_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036",
        "stop_location_id": "84e8d1d2-7c80-44cc-87bc-6555f13e0036",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "1208d117-4b6a-4826-9b3e-8891b7fb623e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "718159c8-ebee-45bd-acf1-d585e6bf1c97",
        "planning_id": "04165ca2-28e4-45c8-a132-a2306ec1a8be",
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d"
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
      "id": "6a02e8a7-d1fa-47f1-bbc4-a8274b76ab29",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "479f1a11-12a5-4928-91d0-4622e3ca538f",
        "planning_id": "04165ca2-28e4-45c8-a132-a2306ec1a8be",
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d"
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
      "id": "e7399787-635f-4731-bd8e-35d077fb31a0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:32+00:00",
        "updated_at": "2023-12-07T18:41:32+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a69551ff-13b8-4069-93ae-dfbdbf7837a0",
        "planning_id": "04165ca2-28e4-45c8-a132-a2306ec1a8be",
        "order_id": "0144f644-c22d-4307-901d-6cf5d3b7d60d"
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
          "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
          "items": [
            {
              "type": "bundles",
              "id": "6445632a-6334-41c9-b60b-b67602575775",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "85f5a712-a854-4aad-986b-305b44e8d651",
                  "id": "1eb7c58e-a590-4c7f-b6f4-4b308443097b"
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
    "id": "46ea673e-ae97-5178-a46f-013a4f8fc401",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "455e9ced-2ecf-4225-bacf-aebdd2686eb8"
          },
          {
            "type": "lines",
            "id": "d528349d-161c-4535-b4b9-3fb1929d2275"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "46347588-5972-44c2-8959-81ff061c4a5c"
          },
          {
            "type": "plannings",
            "id": "87d850f2-8113-4ad0-b8b0-069851bb8fbb"
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
      "id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
      "type": "orders",
      "attributes": {
        "created_at": "2023-12-07T18:41:35+00:00",
        "updated_at": "2023-12-07T18:41:35+00:00",
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
        "starts_at": "2023-12-05T18:30:00+00:00",
        "stops_at": "2023-12-09T18:30:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea",
        "stop_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea"
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
      "id": "455e9ced-2ecf-4225-bacf-aebdd2686eb8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T18:41:35+00:00",
        "updated_at": "2023-12-07T18:41:35+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 7",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "item_id": "6445632a-6334-41c9-b60b-b67602575775",
        "tax_category_id": null,
        "planning_id": "46347588-5972-44c2-8959-81ff061c4a5c",
        "parent_line_id": null,
        "owner_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "d528349d-161c-4535-b4b9-3fb1929d2275",
      "type": "lines",
      "attributes": {
        "created_at": "2023-12-07T18:41:35+00:00",
        "updated_at": "2023-12-07T18:41:35+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000040 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
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
        "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "item_id": "1eb7c58e-a590-4c7f-b6f4-4b308443097b",
        "tax_category_id": null,
        "planning_id": "87d850f2-8113-4ad0-b8b0-069851bb8fbb",
        "parent_line_id": "455e9ced-2ecf-4225-bacf-aebdd2686eb8",
        "owner_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
      "id": "46347588-5972-44c2-8959-81ff061c4a5c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:35+00:00",
        "updated_at": "2023-12-07T18:41:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-05T18:30:00+00:00",
        "stops_at": "2023-12-09T18:30:00+00:00",
        "reserved_from": "2023-12-05T18:30:00+00:00",
        "reserved_till": "2023-12-09T18:30:00+00:00",
        "reserved": false,
        "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "item_id": "6445632a-6334-41c9-b60b-b67602575775",
        "start_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea",
        "stop_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "87d850f2-8113-4ad0-b8b0-069851bb8fbb",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-12-07T18:41:35+00:00",
        "updated_at": "2023-12-07T18:41:35+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-12-05T18:30:00+00:00",
        "stops_at": "2023-12-09T18:30:00+00:00",
        "reserved_from": "2023-12-05T18:30:00+00:00",
        "reserved_till": "2023-12-09T18:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "3ecd1151-69ad-4d0f-8bf8-d35eb3131821",
        "item_id": "1eb7c58e-a590-4c7f-b6f4-4b308443097b",
        "start_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea",
        "stop_location_id": "2c5b94ed-a6c2-408d-b7b4-4a62149285ea",
        "parent_planning_id": "46347588-5972-44c2-8959-81ff061c4a5c",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





