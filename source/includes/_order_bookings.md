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
          "order_id": "c36d1a72-4e39-4385-822b-a2ff94325f8f",
          "items": [
            {
              "type": "products",
              "id": "9e89e06c-08c2-4702-8da3-f7121ef62d9c",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "6b391f73-babe-4ae1-b82c-bacb94102dda",
              "stock_item_ids": [
                "6d60e5c2-f98a-4cb7-bfc3-b6c46b693583",
                "6b4ed269-821b-4157-a248-d1c937faae03"
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
          "stock_item_id 6d60e5c2-f98a-4cb7-bfc3-b6c46b693583 has already been booked on this order"
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
          "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
          "items": [
            {
              "type": "products",
              "id": "31313ab8-22ec-4058-8d5f-70004b19bb5b",
              "stock_item_ids": [
                "600a9f84-59f9-4da2-be7e-5584c0b597ed",
                "677da49f-6e06-4932-9c5b-714c4bdf27d8",
                "3c66ef5a-032b-4fe3-ac3c-1e8f4f239a81"
              ]
            },
            {
              "type": "products",
              "id": "168c96e1-5bfc-420d-9e71-64540cb655cd",
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
    "id": "d813b7e9-8b7f-53ec-b088-2b534b42e6fd",
    "type": "order_bookings",
    "attributes": {
      "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "328225a0-e1aa-48e3-b58e-c82020ad5774"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c614dea8-c48c-4d0b-ae6f-76f1c330d532"
          },
          {
            "type": "lines",
            "id": "8acfe67b-3231-4a95-92a2-748344f90804"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3ded86a6-dab8-481d-884c-c6a528ca1850"
          },
          {
            "type": "plannings",
            "id": "8b12cb5b-fde4-4707-a337-8186343a292c"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "3409fb81-396f-43fb-a3de-723b908f3331"
          },
          {
            "type": "stock_item_plannings",
            "id": "0d4947e8-4e2e-4382-84c8-adc5d887812d"
          },
          {
            "type": "stock_item_plannings",
            "id": "2ea7645c-74de-471a-b247-882f3443495e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T14:18:14+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
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
        "customer_id": "0a6d4027-29e8-4282-9596-e300b613e113",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db",
        "stop_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db"
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
      "id": "c614dea8-c48c-4d0b-ae6f-76f1c330d532",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
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
        "item_id": "31313ab8-22ec-4058-8d5f-70004b19bb5b",
        "tax_category_id": "3f6fecee-7d78-44df-a45a-17939cedff89",
        "planning_id": "3ded86a6-dab8-481d-884c-c6a528ca1850",
        "parent_line_id": null,
        "owner_id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
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
      "id": "8acfe67b-3231-4a95-92a2-748344f90804",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
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
        "item_id": "168c96e1-5bfc-420d-9e71-64540cb655cd",
        "tax_category_id": "3f6fecee-7d78-44df-a45a-17939cedff89",
        "planning_id": "8b12cb5b-fde4-4707-a337-8186343a292c",
        "parent_line_id": null,
        "owner_id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
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
      "id": "3ded86a6-dab8-481d-884c-c6a528ca1850",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
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
        "item_id": "31313ab8-22ec-4058-8d5f-70004b19bb5b",
        "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
        "start_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db",
        "stop_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db",
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
      "id": "8b12cb5b-fde4-4707-a337-8186343a292c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
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
        "item_id": "168c96e1-5bfc-420d-9e71-64540cb655cd",
        "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774",
        "start_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db",
        "stop_location_id": "4f22e10b-1776-472b-ae13-63d8e54aa6db",
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
      "id": "3409fb81-396f-43fb-a3de-723b908f3331",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "600a9f84-59f9-4da2-be7e-5584c0b597ed",
        "planning_id": "3ded86a6-dab8-481d-884c-c6a528ca1850",
        "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774"
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
      "id": "0d4947e8-4e2e-4382-84c8-adc5d887812d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "677da49f-6e06-4932-9c5b-714c4bdf27d8",
        "planning_id": "3ded86a6-dab8-481d-884c-c6a528ca1850",
        "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774"
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
      "id": "2ea7645c-74de-471a-b247-882f3443495e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:16+00:00",
        "updated_at": "2023-03-01T14:18:16+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3c66ef5a-032b-4fe3-ac3c-1e8f4f239a81",
        "planning_id": "3ded86a6-dab8-481d-884c-c6a528ca1850",
        "order_id": "328225a0-e1aa-48e3-b58e-c82020ad5774"
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
          "order_id": "4c847b35-713b-4a60-bb10-75f9ba3ec551",
          "items": [
            {
              "type": "bundles",
              "id": "639af0b2-3dff-475b-b5ae-1c12f1c9b6bc",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "399e72b0-d010-4724-8cc9-d3b512df622b",
                  "id": "a4635641-8921-4ed2-aa0c-2aa8eb10ecdd"
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
    "id": "1d2950bc-0548-5e17-ab48-94e358507f10",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4c847b35-713b-4a60-bb10-75f9ba3ec551"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4c847b35-713b-4a60-bb10-75f9ba3ec551"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2841c8d9-b5a0-4546-b7f3-d1766aa6dbc8"
          },
          {
            "type": "lines",
            "id": "c6ed617d-ac3e-4652-a6aa-ebe7d52930f8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "609f0f33-55d0-4b24-a642-718b1e330d99"
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
      "id": "4c847b35-713b-4a60-bb10-75f9ba3ec551",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T14:18:19+00:00",
        "updated_at": "2023-03-01T14:18:20+00:00",
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
        "starts_at": "2023-02-27T14:15:00+00:00",
        "stops_at": "2023-03-03T14:15:00+00:00",
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
        "start_location_id": "85e4d0e9-5cab-4e14-909e-e96bea338740",
        "stop_location_id": "85e4d0e9-5cab-4e14-909e-e96bea338740"
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
      "id": "2841c8d9-b5a0-4546-b7f3-d1766aa6dbc8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:18:19+00:00",
        "updated_at": "2023-03-01T14:18:19+00:00",
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
        "item_id": "a4635641-8921-4ed2-aa0c-2aa8eb10ecdd",
        "tax_category_id": null,
        "planning_id": "341217fe-425b-41ff-8844-e8e128f54813",
        "parent_line_id": "c6ed617d-ac3e-4652-a6aa-ebe7d52930f8",
        "owner_id": "4c847b35-713b-4a60-bb10-75f9ba3ec551",
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
      "id": "c6ed617d-ac3e-4652-a6aa-ebe7d52930f8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T14:18:19+00:00",
        "updated_at": "2023-03-01T14:18:19+00:00",
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
        "item_id": "639af0b2-3dff-475b-b5ae-1c12f1c9b6bc",
        "tax_category_id": null,
        "planning_id": "609f0f33-55d0-4b24-a642-718b1e330d99",
        "parent_line_id": null,
        "owner_id": "4c847b35-713b-4a60-bb10-75f9ba3ec551",
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
      "id": "609f0f33-55d0-4b24-a642-718b1e330d99",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T14:18:19+00:00",
        "updated_at": "2023-03-01T14:18:19+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-27T14:15:00+00:00",
        "stops_at": "2023-03-03T14:15:00+00:00",
        "reserved_from": "2023-02-27T14:15:00+00:00",
        "reserved_till": "2023-03-03T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "639af0b2-3dff-475b-b5ae-1c12f1c9b6bc",
        "order_id": "4c847b35-713b-4a60-bb10-75f9ba3ec551",
        "start_location_id": "85e4d0e9-5cab-4e14-909e-e96bea338740",
        "stop_location_id": "85e4d0e9-5cab-4e14-909e-e96bea338740",
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





