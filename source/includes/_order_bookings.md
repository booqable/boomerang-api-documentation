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
          "order_id": "39bdad17-8378-4a53-8d15-eaca1cd46de1",
          "items": [
            {
              "type": "products",
              "id": "1c07d038-0c8f-45a8-b938-463e49294228",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "47873187-6e01-4797-9dcb-2c6c4328fa66",
              "stock_item_ids": [
                "db29b2fc-e7be-44a2-bbaa-a588f8db97bb",
                "fe87f7ca-44da-498b-a1ab-3acac083577a"
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
          "stock_item_id db29b2fc-e7be-44a2-bbaa-a588f8db97bb has already been booked on this order"
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
          "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
          "items": [
            {
              "type": "products",
              "id": "f4d27e2a-116a-45f6-a47b-ef84f031ada2",
              "stock_item_ids": [
                "fc12821d-d539-496e-860a-fe36737cc39e",
                "9274cf8c-7ce4-4d88-b53d-3ffefeba6b58",
                "e289e175-acfd-4bf8-9513-aa18eae3e6d9"
              ]
            },
            {
              "type": "products",
              "id": "2bf0471b-edfc-460d-93f8-2281f82d03b1",
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
    "id": "32beedd5-3d39-5d4b-9452-be6648a8dffd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a82f4177-6aed-4e19-aacf-4af6f5d7d4e2"
          },
          {
            "type": "lines",
            "id": "e1b945dc-955d-43ad-8eb6-1804cb7aebf7"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "502e671d-d551-4dd0-a478-4c3dff785296"
          },
          {
            "type": "plannings",
            "id": "44fadf10-69f0-4ab2-bb9e-6fc1af230672"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "20b8ccb5-208e-49e2-9173-dc038f51f835"
          },
          {
            "type": "stock_item_plannings",
            "id": "1399cee3-665c-4343-9b69-9a700bba9f24"
          },
          {
            "type": "stock_item_plannings",
            "id": "47c1f987-f275-4b64-bb48-582abdf49000"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T14:57:15+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
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
        "customer_id": "1a1a03f4-efd2-48be-8cfe-e6af44528ae3",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "182549f2-6366-4d85-a297-d25d823f7207",
        "stop_location_id": "182549f2-6366-4d85-a297-d25d823f7207"
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
      "id": "a82f4177-6aed-4e19-aacf-4af6f5d7d4e2",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
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
        "item_id": "f4d27e2a-116a-45f6-a47b-ef84f031ada2",
        "tax_category_id": "0f730742-acb9-4660-9f03-13d028251e22",
        "planning_id": "502e671d-d551-4dd0-a478-4c3dff785296",
        "parent_line_id": null,
        "owner_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
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
      "id": "e1b945dc-955d-43ad-8eb6-1804cb7aebf7",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
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
        "item_id": "2bf0471b-edfc-460d-93f8-2281f82d03b1",
        "tax_category_id": "0f730742-acb9-4660-9f03-13d028251e22",
        "planning_id": "44fadf10-69f0-4ab2-bb9e-6fc1af230672",
        "parent_line_id": null,
        "owner_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
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
      "id": "502e671d-d551-4dd0-a478-4c3dff785296",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
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
        "item_id": "f4d27e2a-116a-45f6-a47b-ef84f031ada2",
        "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
        "start_location_id": "182549f2-6366-4d85-a297-d25d823f7207",
        "stop_location_id": "182549f2-6366-4d85-a297-d25d823f7207",
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
      "id": "44fadf10-69f0-4ab2-bb9e-6fc1af230672",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
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
        "item_id": "2bf0471b-edfc-460d-93f8-2281f82d03b1",
        "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6",
        "start_location_id": "182549f2-6366-4d85-a297-d25d823f7207",
        "stop_location_id": "182549f2-6366-4d85-a297-d25d823f7207",
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
      "id": "20b8ccb5-208e-49e2-9173-dc038f51f835",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fc12821d-d539-496e-860a-fe36737cc39e",
        "planning_id": "502e671d-d551-4dd0-a478-4c3dff785296",
        "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6"
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
      "id": "1399cee3-665c-4343-9b69-9a700bba9f24",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9274cf8c-7ce4-4d88-b53d-3ffefeba6b58",
        "planning_id": "502e671d-d551-4dd0-a478-4c3dff785296",
        "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6"
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
      "id": "47c1f987-f275-4b64-bb48-582abdf49000",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:17+00:00",
        "updated_at": "2023-02-24T14:57:17+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e289e175-acfd-4bf8-9513-aa18eae3e6d9",
        "planning_id": "502e671d-d551-4dd0-a478-4c3dff785296",
        "order_id": "fe32adf5-ed2c-4667-8d72-7580adbac2e6"
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
          "order_id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1",
          "items": [
            {
              "type": "bundles",
              "id": "df9d3c54-dddd-44ee-b9cc-0cb558e7c05a",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "fed984b5-b824-4ff9-aef3-aebffb49574d",
                  "id": "ccba4a73-473d-490a-a09e-efef9d9fba02"
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
    "id": "442800a8-0d4e-5f20-9782-9ec29a016741",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "d3ae7c35-51fb-42b6-840c-5c5dbb919d0d"
          },
          {
            "type": "lines",
            "id": "e251ebed-66d1-40c2-a630-bf7b77121223"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c7b78b70-4c0b-41cd-8091-0808bb9dd1b2"
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
      "id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-24T14:57:21+00:00",
        "updated_at": "2023-02-24T14:57:22+00:00",
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
        "starts_at": "2023-02-22T14:45:00+00:00",
        "stops_at": "2023-02-26T14:45:00+00:00",
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
        "start_location_id": "21aa4215-9131-4ee2-94b0-53eb2553a119",
        "stop_location_id": "21aa4215-9131-4ee2-94b0-53eb2553a119"
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
      "id": "d3ae7c35-51fb-42b6-840c-5c5dbb919d0d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:57:22+00:00",
        "updated_at": "2023-02-24T14:57:22+00:00",
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
        "item_id": "df9d3c54-dddd-44ee-b9cc-0cb558e7c05a",
        "tax_category_id": null,
        "planning_id": "c7b78b70-4c0b-41cd-8091-0808bb9dd1b2",
        "parent_line_id": null,
        "owner_id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1",
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
      "id": "e251ebed-66d1-40c2-a630-bf7b77121223",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-24T14:57:22+00:00",
        "updated_at": "2023-02-24T14:57:22+00:00",
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
        "item_id": "ccba4a73-473d-490a-a09e-efef9d9fba02",
        "tax_category_id": null,
        "planning_id": "ecf9a6cb-fa35-4389-8385-e139f58d56cd",
        "parent_line_id": "d3ae7c35-51fb-42b6-840c-5c5dbb919d0d",
        "owner_id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1",
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
      "id": "c7b78b70-4c0b-41cd-8091-0808bb9dd1b2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-24T14:57:22+00:00",
        "updated_at": "2023-02-24T14:57:22+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-22T14:45:00+00:00",
        "stops_at": "2023-02-26T14:45:00+00:00",
        "reserved_from": "2023-02-22T14:45:00+00:00",
        "reserved_till": "2023-02-26T14:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "df9d3c54-dddd-44ee-b9cc-0cb558e7c05a",
        "order_id": "f8272b90-d3a7-408f-bc4e-1fd70b9f2bd1",
        "start_location_id": "21aa4215-9131-4ee2-94b0-53eb2553a119",
        "stop_location_id": "21aa4215-9131-4ee2-94b0-53eb2553a119",
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





