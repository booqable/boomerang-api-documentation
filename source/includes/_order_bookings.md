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
          "order_id": "f750afd2-2e5a-44b2-9c2a-783937d3aa47",
          "items": [
            {
              "type": "products",
              "id": "82949b80-70c4-4edd-bb0a-77449ccab079",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0a83c9dd-bed1-4f87-99e3-4b46be15defb",
              "stock_item_ids": [
                "81ee3522-dc12-4f5a-9d9a-fab4e9fb5b6b",
                "82d986ed-a3af-4f91-b52f-3509b824064e"
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
          "stock_item_id 81ee3522-dc12-4f5a-9d9a-fab4e9fb5b6b has already been booked on this order"
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
          "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
          "items": [
            {
              "type": "products",
              "id": "76a68d57-974e-495d-b28d-978c3435326a",
              "stock_item_ids": [
                "ca04c86a-8981-4304-86f2-9cfdb3214b5b",
                "d3b9ac8e-f4ac-4938-b21e-4eae6e80b425",
                "18893a6c-935a-40bd-a672-17ae96dc8251"
              ]
            },
            {
              "type": "products",
              "id": "68f70b0a-cdbf-4844-a148-bbc68bfa9558",
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
    "id": "b5d695e9-cece-5420-8800-55ecad36df11",
    "type": "order_bookings",
    "attributes": {
      "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "51699a2a-4f12-46fc-9753-00d5c53b3d43"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "8c3f7d9c-f1bd-4738-99a3-70e11deb3696"
          },
          {
            "type": "lines",
            "id": "d91f9104-9d81-4876-a8a2-b2d178ee95f6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c05487d8-f15b-4460-9351-535832ea706d"
          },
          {
            "type": "plannings",
            "id": "721d7fba-3c50-46bb-aa6c-6010c5314eed"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "9035efde-f26e-41cd-bf1b-6f4e77431613"
          },
          {
            "type": "stock_item_plannings",
            "id": "1d70c8f0-3383-4d11-8b60-7350a2118a51"
          },
          {
            "type": "stock_item_plannings",
            "id": "5170a70b-f07d-439b-af1b-ba5146c18847"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T17:38:29+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
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
        "customer_id": "547daed9-8f52-4c15-bd48-a050b0a4f923",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae",
        "stop_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae"
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
      "id": "8c3f7d9c-f1bd-4738-99a3-70e11deb3696",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
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
        "item_id": "76a68d57-974e-495d-b28d-978c3435326a",
        "tax_category_id": "4d1dc53b-e54b-40b7-a942-6c32f2582726",
        "planning_id": "c05487d8-f15b-4460-9351-535832ea706d",
        "parent_line_id": null,
        "owner_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
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
      "id": "d91f9104-9d81-4876-a8a2-b2d178ee95f6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
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
        "item_id": "68f70b0a-cdbf-4844-a148-bbc68bfa9558",
        "tax_category_id": "4d1dc53b-e54b-40b7-a942-6c32f2582726",
        "planning_id": "721d7fba-3c50-46bb-aa6c-6010c5314eed",
        "parent_line_id": null,
        "owner_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
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
      "id": "c05487d8-f15b-4460-9351-535832ea706d",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
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
        "item_id": "76a68d57-974e-495d-b28d-978c3435326a",
        "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
        "start_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae",
        "stop_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae",
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
      "id": "721d7fba-3c50-46bb-aa6c-6010c5314eed",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
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
        "item_id": "68f70b0a-cdbf-4844-a148-bbc68bfa9558",
        "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43",
        "start_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae",
        "stop_location_id": "9a616a08-f770-4823-ad3c-02ff5f5a01ae",
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
      "id": "9035efde-f26e-41cd-bf1b-6f4e77431613",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "ca04c86a-8981-4304-86f2-9cfdb3214b5b",
        "planning_id": "c05487d8-f15b-4460-9351-535832ea706d",
        "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43"
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
      "id": "1d70c8f0-3383-4d11-8b60-7350a2118a51",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "d3b9ac8e-f4ac-4938-b21e-4eae6e80b425",
        "planning_id": "c05487d8-f15b-4460-9351-535832ea706d",
        "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43"
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
      "id": "5170a70b-f07d-439b-af1b-ba5146c18847",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:31+00:00",
        "updated_at": "2023-03-01T17:38:31+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "18893a6c-935a-40bd-a672-17ae96dc8251",
        "planning_id": "c05487d8-f15b-4460-9351-535832ea706d",
        "order_id": "51699a2a-4f12-46fc-9753-00d5c53b3d43"
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
          "order_id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0",
          "items": [
            {
              "type": "bundles",
              "id": "cdbffe1e-8c9d-4d64-8895-7cb1318243c8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "e51eca4a-6dda-456c-8c6f-75ffe5407d58",
                  "id": "ab1cb11e-7d31-43af-8f54-e9811ddc39dc"
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
    "id": "56d14b10-2f09-5a85-abd9-9b871c573531",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "de8c461f-8072-42d2-b78d-e3d4f4cf7a7c"
          },
          {
            "type": "lines",
            "id": "6847932a-b25b-478e-ba10-b71e76144938"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "87809766-0212-47c4-94a6-e585f16b90a2"
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
      "id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-01T17:38:34+00:00",
        "updated_at": "2023-03-01T17:38:35+00:00",
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
        "starts_at": "2023-02-27T17:30:00+00:00",
        "stops_at": "2023-03-03T17:30:00+00:00",
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
        "start_location_id": "b126481b-7d28-49e9-9f09-d4adde3d0285",
        "stop_location_id": "b126481b-7d28-49e9-9f09-d4adde3d0285"
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
      "id": "de8c461f-8072-42d2-b78d-e3d4f4cf7a7c",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T17:38:34+00:00",
        "updated_at": "2023-03-01T17:38:34+00:00",
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
        "item_id": "ab1cb11e-7d31-43af-8f54-e9811ddc39dc",
        "tax_category_id": null,
        "planning_id": "6eb233d4-a0d1-4344-9bfe-0dc6445976da",
        "parent_line_id": "6847932a-b25b-478e-ba10-b71e76144938",
        "owner_id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0",
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
      "id": "6847932a-b25b-478e-ba10-b71e76144938",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-01T17:38:34+00:00",
        "updated_at": "2023-03-01T17:38:34+00:00",
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
        "item_id": "cdbffe1e-8c9d-4d64-8895-7cb1318243c8",
        "tax_category_id": null,
        "planning_id": "87809766-0212-47c4-94a6-e585f16b90a2",
        "parent_line_id": null,
        "owner_id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0",
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
      "id": "87809766-0212-47c4-94a6-e585f16b90a2",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-01T17:38:34+00:00",
        "updated_at": "2023-03-01T17:38:34+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-27T17:30:00+00:00",
        "stops_at": "2023-03-03T17:30:00+00:00",
        "reserved_from": "2023-02-27T17:30:00+00:00",
        "reserved_till": "2023-03-03T17:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "cdbffe1e-8c9d-4d64-8895-7cb1318243c8",
        "order_id": "8d09a9b8-2491-414b-a0ac-d82ea7198ab0",
        "start_location_id": "b126481b-7d28-49e9-9f09-d4adde3d0285",
        "stop_location_id": "b126481b-7d28-49e9-9f09-d4adde3d0285",
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





