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
          "order_id": "967c1d5a-fc4b-40a4-ae2b-6dbc73f3a3f6",
          "items": [
            {
              "type": "products",
              "id": "a3c04a5c-ee45-4975-b30d-a0ba9511d87b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "e5906862-07e6-4d50-bb91-05747d3f78a7",
              "stock_item_ids": [
                "3cb7f3b0-796a-45e1-a539-af301dc92212",
                "c8464bda-7445-4769-a829-d1f23db23dac"
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
            "item_id": "a3c04a5c-ee45-4975-b30d-a0ba9511d87b",
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
          "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
          "items": [
            {
              "type": "products",
              "id": "f9902946-4cc6-4297-9448-dee3f2dffa28",
              "stock_item_ids": [
                "e8b35b39-e4c3-436f-981e-3dbe57aac3bd",
                "c653cfb7-a71b-4bab-a5dd-3823cbed537d",
                "248bcac3-c5d6-434d-913f-16944fb21f43"
              ]
            },
            {
              "type": "products",
              "id": "84f1d983-dcdf-4299-960b-6e6277337ee8",
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
    "id": "f25d1882-8f0f-5def-91d5-9071e9c057ed",
    "type": "order_bookings",
    "attributes": {
      "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "72285f97-a015-4c05-8da2-20f6a8a773ca"
          },
          {
            "type": "lines",
            "id": "eb1ad1d1-43ab-49f8-ab76-85eef2439375"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9a2e635e-ac37-415c-b623-14acaea94b3c"
          },
          {
            "type": "plannings",
            "id": "9580752b-ad4b-4a63-b954-56e5e69c1e5e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "07f7db68-0a7b-4fe4-9ae9-9f5c7bfa38e5"
          },
          {
            "type": "stock_item_plannings",
            "id": "43556a90-5e7e-4af5-8b13-27ccd4b53b5f"
          },
          {
            "type": "stock_item_plannings",
            "id": "c2dcdf0f-cf66-472c-a4ab-f08b79880391"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-07T11:57:28+00:00",
        "updated_at": "2022-10-07T11:57:30+00:00",
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
        "customer_id": "5c5452c7-a5d5-4407-ab7d-b6e11a619061",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952",
        "stop_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952"
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
      "id": "72285f97-a015-4c05-8da2-20f6a8a773ca",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:30+00:00",
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
        "item_id": "f9902946-4cc6-4297-9448-dee3f2dffa28",
        "tax_category_id": "c23c1519-4566-42fe-bce0-38d45999a723",
        "planning_id": "9a2e635e-ac37-415c-b623-14acaea94b3c",
        "parent_line_id": null,
        "owner_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
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
      "id": "eb1ad1d1-43ab-49f8-ab76-85eef2439375",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:30+00:00",
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
        "item_id": "84f1d983-dcdf-4299-960b-6e6277337ee8",
        "tax_category_id": "c23c1519-4566-42fe-bce0-38d45999a723",
        "planning_id": "9580752b-ad4b-4a63-b954-56e5e69c1e5e",
        "parent_line_id": null,
        "owner_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
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
      "id": "9a2e635e-ac37-415c-b623-14acaea94b3c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:30+00:00",
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
        "item_id": "f9902946-4cc6-4297-9448-dee3f2dffa28",
        "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
        "start_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952",
        "stop_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952",
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
      "id": "9580752b-ad4b-4a63-b954-56e5e69c1e5e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:30+00:00",
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
        "item_id": "84f1d983-dcdf-4299-960b-6e6277337ee8",
        "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d",
        "start_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952",
        "stop_location_id": "347977a6-fe39-488f-bd5b-f36c0aa7c952",
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
      "id": "07f7db68-0a7b-4fe4-9ae9-9f5c7bfa38e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "e8b35b39-e4c3-436f-981e-3dbe57aac3bd",
        "planning_id": "9a2e635e-ac37-415c-b623-14acaea94b3c",
        "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d"
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
      "id": "43556a90-5e7e-4af5-8b13-27ccd4b53b5f",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "c653cfb7-a71b-4bab-a5dd-3823cbed537d",
        "planning_id": "9a2e635e-ac37-415c-b623-14acaea94b3c",
        "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d"
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
      "id": "c2dcdf0f-cf66-472c-a4ab-f08b79880391",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:29+00:00",
        "updated_at": "2022-10-07T11:57:29+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "248bcac3-c5d6-434d-913f-16944fb21f43",
        "planning_id": "9a2e635e-ac37-415c-b623-14acaea94b3c",
        "order_id": "ec3d4c87-4607-4ccc-ae04-2f6825c0a15d"
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
          "order_id": "27cb4275-8aac-458b-a78b-2faf50b01f60",
          "items": [
            {
              "type": "bundles",
              "id": "36b2a18a-40ea-430f-baf4-20169869d9c6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3728526a-8fbb-4129-b172-be20211821c0",
                  "id": "c1e4ad6a-71d5-4dce-b874-1c00163ad2fc"
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
    "id": "99a2ecf0-aab9-51ca-81fd-f8d95da85687",
    "type": "order_bookings",
    "attributes": {
      "order_id": "27cb4275-8aac-458b-a78b-2faf50b01f60"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "27cb4275-8aac-458b-a78b-2faf50b01f60"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "be7b2127-9c04-4058-b72b-4c4a5011ee11"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "02ef5f2a-6705-490a-9684-cabf144f08d9"
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
      "id": "27cb4275-8aac-458b-a78b-2faf50b01f60",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-07T11:57:32+00:00",
        "updated_at": "2022-10-07T11:57:33+00:00",
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
        "starts_at": "2022-10-05T11:45:00+00:00",
        "stops_at": "2022-10-09T11:45:00+00:00",
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
        "start_location_id": "da1e9c85-86a9-4465-85e3-952bb392bb02",
        "stop_location_id": "da1e9c85-86a9-4465-85e3-952bb392bb02"
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
      "id": "be7b2127-9c04-4058-b72b-4c4a5011ee11",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-07T11:57:32+00:00",
        "updated_at": "2022-10-07T11:57:32+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle item 7",
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
        "item_id": "36b2a18a-40ea-430f-baf4-20169869d9c6",
        "tax_category_id": null,
        "planning_id": "02ef5f2a-6705-490a-9684-cabf144f08d9",
        "parent_line_id": null,
        "owner_id": "27cb4275-8aac-458b-a78b-2faf50b01f60",
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
      "id": "02ef5f2a-6705-490a-9684-cabf144f08d9",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-07T11:57:32+00:00",
        "updated_at": "2022-10-07T11:57:32+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-05T11:45:00+00:00",
        "stops_at": "2022-10-09T11:45:00+00:00",
        "reserved_from": "2022-10-05T11:45:00+00:00",
        "reserved_till": "2022-10-09T11:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "36b2a18a-40ea-430f-baf4-20169869d9c6",
        "order_id": "27cb4275-8aac-458b-a78b-2faf50b01f60",
        "start_location_id": "da1e9c85-86a9-4465-85e3-952bb392bb02",
        "stop_location_id": "da1e9c85-86a9-4465-85e3-952bb392bb02",
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





