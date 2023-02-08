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
          "order_id": "873941f0-1b93-4471-a8c5-ab3e99c9dd5b",
          "items": [
            {
              "type": "products",
              "id": "f01a5892-c6dd-4410-8fa6-cdfc0afcc9c3",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "c904fe10-cc86-4591-86eb-2216b0598b22",
              "stock_item_ids": [
                "a92bcc3c-314a-4895-a4b1-d0e4efcd72cd",
                "9f5dc0da-35cc-4fac-b7cf-2a535fa81c8b"
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
            "item_id": "f01a5892-c6dd-4410-8fa6-cdfc0afcc9c3",
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
          "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
          "items": [
            {
              "type": "products",
              "id": "73d0014d-d7b1-4c94-b3d8-824b25d285d5",
              "stock_item_ids": [
                "8016ce09-3687-40ba-9d2f-6148045f5920",
                "a3f361f3-1609-47fc-9565-a18162636dce",
                "68d3aa55-8270-4ade-beea-1abc8a5c2380"
              ]
            },
            {
              "type": "products",
              "id": "65cf09d0-6c0a-4f5e-b3e3-1a4141ef06dd",
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
    "id": "d20505b8-834c-5b88-9c00-c546f5105394",
    "type": "order_bookings",
    "attributes": {
      "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "bd723767-cc44-4566-8a9a-d4205fc35a4e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0617f162-0a4e-44b9-9a32-339f6f524f88"
          },
          {
            "type": "lines",
            "id": "0ba2bee3-761e-488b-9207-36072f1b5a32"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "154841d8-5b94-4af1-9b37-6845dfabf507"
          },
          {
            "type": "plannings",
            "id": "15c9bcb6-67e7-4a2e-84c1-91cbc1e70b70"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "725cacd6-728c-463f-be20-69433b181f86"
          },
          {
            "type": "stock_item_plannings",
            "id": "e0596f25-a116-4a30-ab06-cb0ef6d7f9cb"
          },
          {
            "type": "stock_item_plannings",
            "id": "77dd853f-b008-4f9b-83d1-07e4b7206325"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T13:52:10+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
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
        "customer_id": "27108d23-f2a6-448d-8373-fc6eac4607d4",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07",
        "stop_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07"
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
      "id": "0617f162-0a4e-44b9-9a32-339f6f524f88",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
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
        "item_id": "73d0014d-d7b1-4c94-b3d8-824b25d285d5",
        "tax_category_id": "f042f6d0-6fe2-4c49-8aad-ad7ee4d55582",
        "planning_id": "154841d8-5b94-4af1-9b37-6845dfabf507",
        "parent_line_id": null,
        "owner_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
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
      "id": "0ba2bee3-761e-488b-9207-36072f1b5a32",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
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
        "item_id": "65cf09d0-6c0a-4f5e-b3e3-1a4141ef06dd",
        "tax_category_id": "f042f6d0-6fe2-4c49-8aad-ad7ee4d55582",
        "planning_id": "15c9bcb6-67e7-4a2e-84c1-91cbc1e70b70",
        "parent_line_id": null,
        "owner_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
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
      "id": "154841d8-5b94-4af1-9b37-6845dfabf507",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
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
        "item_id": "73d0014d-d7b1-4c94-b3d8-824b25d285d5",
        "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
        "start_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07",
        "stop_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07",
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
      "id": "15c9bcb6-67e7-4a2e-84c1-91cbc1e70b70",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
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
        "item_id": "65cf09d0-6c0a-4f5e-b3e3-1a4141ef06dd",
        "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e",
        "start_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07",
        "stop_location_id": "51e7ba58-233f-469d-a2e1-7b3185967f07",
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
      "id": "725cacd6-728c-463f-be20-69433b181f86",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8016ce09-3687-40ba-9d2f-6148045f5920",
        "planning_id": "154841d8-5b94-4af1-9b37-6845dfabf507",
        "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e"
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
      "id": "e0596f25-a116-4a30-ab06-cb0ef6d7f9cb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a3f361f3-1609-47fc-9565-a18162636dce",
        "planning_id": "154841d8-5b94-4af1-9b37-6845dfabf507",
        "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e"
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
      "id": "77dd853f-b008-4f9b-83d1-07e4b7206325",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:11+00:00",
        "updated_at": "2023-02-08T13:52:11+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "68d3aa55-8270-4ade-beea-1abc8a5c2380",
        "planning_id": "154841d8-5b94-4af1-9b37-6845dfabf507",
        "order_id": "bd723767-cc44-4566-8a9a-d4205fc35a4e"
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
          "order_id": "8c429411-ff3c-497c-9253-a7f2390d7da6",
          "items": [
            {
              "type": "bundles",
              "id": "453e6509-579a-4c55-bf99-8a5f3207ddc2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "f51e105c-37b1-4c8c-93fb-a55cf39e7569",
                  "id": "255195af-f7b8-4dbe-a557-d0bd276b1af9"
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
    "id": "e283bdfa-0b06-5097-9688-2c026013fb07",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8c429411-ff3c-497c-9253-a7f2390d7da6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8c429411-ff3c-497c-9253-a7f2390d7da6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "2bbd18a4-4f02-4107-b8d9-ad0f06dc2c62"
          },
          {
            "type": "lines",
            "id": "5402355e-b439-4239-beed-503c8adfa40b"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "45b9ed80-7477-4be9-939d-1377e95ea748"
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
      "id": "8c429411-ff3c-497c-9253-a7f2390d7da6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T13:52:13+00:00",
        "updated_at": "2023-02-08T13:52:13+00:00",
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
        "starts_at": "2023-02-06T13:45:00+00:00",
        "stops_at": "2023-02-10T13:45:00+00:00",
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
        "start_location_id": "dd414ff0-65b5-4f11-934b-9a99730862bd",
        "stop_location_id": "dd414ff0-65b5-4f11-934b-9a99730862bd"
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
      "id": "2bbd18a4-4f02-4107-b8d9-ad0f06dc2c62",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:52:13+00:00",
        "updated_at": "2023-02-08T13:52:13+00:00",
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
        "item_id": "453e6509-579a-4c55-bf99-8a5f3207ddc2",
        "tax_category_id": null,
        "planning_id": "45b9ed80-7477-4be9-939d-1377e95ea748",
        "parent_line_id": null,
        "owner_id": "8c429411-ff3c-497c-9253-a7f2390d7da6",
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
      "id": "5402355e-b439-4239-beed-503c8adfa40b",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T13:52:13+00:00",
        "updated_at": "2023-02-08T13:52:13+00:00",
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
        "item_id": "255195af-f7b8-4dbe-a557-d0bd276b1af9",
        "tax_category_id": null,
        "planning_id": "c4069a56-0116-4953-b46d-0ab46bd21057",
        "parent_line_id": "2bbd18a4-4f02-4107-b8d9-ad0f06dc2c62",
        "owner_id": "8c429411-ff3c-497c-9253-a7f2390d7da6",
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
      "id": "45b9ed80-7477-4be9-939d-1377e95ea748",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T13:52:13+00:00",
        "updated_at": "2023-02-08T13:52:13+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T13:45:00+00:00",
        "stops_at": "2023-02-10T13:45:00+00:00",
        "reserved_from": "2023-02-06T13:45:00+00:00",
        "reserved_till": "2023-02-10T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "453e6509-579a-4c55-bf99-8a5f3207ddc2",
        "order_id": "8c429411-ff3c-497c-9253-a7f2390d7da6",
        "start_location_id": "dd414ff0-65b5-4f11-934b-9a99730862bd",
        "stop_location_id": "dd414ff0-65b5-4f11-934b-9a99730862bd",
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





