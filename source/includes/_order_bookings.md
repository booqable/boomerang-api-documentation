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
`id` | **Uuid**<br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid**<br>The associated Order


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
          "order_id": "250b4af4-a26d-4275-9974-da2eb8f5d062",
          "items": [
            {
              "type": "products",
              "id": "af2ea045-8c4e-4ef7-9c83-8825a03f091b",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4be97341-2af4-4500-b507-d74cc7192df4",
              "stock_item_ids": [
                "b9224284-7ab9-4c93-a1c4-0bef36ccf08d",
                "705f3bf2-ea24-4925-9ff2-8fb7ca823c1c"
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
            "item_id": "af2ea045-8c4e-4ef7-9c83-8825a03f091b",
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
          "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
          "items": [
            {
              "type": "products",
              "id": "bfe7b17a-0dca-4741-941a-e77183dfb58c",
              "stock_item_ids": [
                "adec65d7-7bf5-4eac-98e1-4859759c10f8",
                "1c9c7cf2-5ddb-403d-9011-bf1c159bfc82",
                "b0e6be74-6125-449c-8ce7-9a23107eaac8"
              ]
            },
            {
              "type": "products",
              "id": "ebcb19f1-5934-4175-9b45-96430fe38227",
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
    "id": "c8bd5345-d6d6-5147-894c-e3c418e43d1a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cd5bc321-438b-4cb9-8844-06fb76836bd9"
          },
          {
            "type": "lines",
            "id": "79d10c8c-30ca-49d7-a5fd-00854b01b0a0"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "3138c920-b94f-4832-a70b-7401123d5bae"
          },
          {
            "type": "plannings",
            "id": "fd6ba10b-331d-4a4c-b30e-3462ce634132"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "717f66ea-d20f-4562-ba58-270e86014187"
          },
          {
            "type": "stock_item_plannings",
            "id": "ba04e0ea-b28b-436f-9970-198c95a09105"
          },
          {
            "type": "stock_item_plannings",
            "id": "8d6dbd84-b34b-44c4-aba9-0df82ca85804"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T14:15:40+00:00",
        "updated_at": "2022-07-12T14:15:43+00:00",
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
        "customer_id": "0b3dcee0-f061-4615-ae18-a151e9c72618",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666",
        "stop_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666"
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
      "id": "cd5bc321-438b-4cb9-8844-06fb76836bd9",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:15:41+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 2,
        "original_price_each_in_cents": 72500,
        "price_each_in_cents": 80250,
        "price_in_cents": 160500,
        "position": 1,
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
        "item_id": "ebcb19f1-5934-4175-9b45-96430fe38227",
        "tax_category_id": "8700208b-dee1-49c5-ace9-05727a1345e6",
        "planning_id": "3138c920-b94f-4832-a70b-7401123d5bae",
        "parent_line_id": null,
        "owner_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
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
      "id": "79d10c8c-30ca-49d7-a5fd-00854b01b0a0",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:15:42+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
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
        "item_id": "bfe7b17a-0dca-4741-941a-e77183dfb58c",
        "tax_category_id": "8700208b-dee1-49c5-ace9-05727a1345e6",
        "planning_id": "fd6ba10b-331d-4a4c-b30e-3462ce634132",
        "parent_line_id": null,
        "owner_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
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
      "id": "3138c920-b94f-4832-a70b-7401123d5bae",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:41+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 2,
        "starts_at": "1980-04-01T12:00:00+00:00",
        "stops_at": "1980-05-01T12:00:00+00:00",
        "reserved_from": "1980-04-01T12:00:00+00:00",
        "reserved_till": "1980-05-01T12:00:00+00:00",
        "reserved": true,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ebcb19f1-5934-4175-9b45-96430fe38227",
        "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
        "start_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666",
        "stop_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666",
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
      "id": "fd6ba10b-331d-4a4c-b30e-3462ce634132",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:42+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
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
        "item_id": "bfe7b17a-0dca-4741-941a-e77183dfb58c",
        "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b",
        "start_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666",
        "stop_location_id": "c6ab303d-f99c-4f2a-9557-e9697e754666",
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
      "id": "717f66ea-d20f-4562-ba58-270e86014187",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:42+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "adec65d7-7bf5-4eac-98e1-4859759c10f8",
        "planning_id": "fd6ba10b-331d-4a4c-b30e-3462ce634132",
        "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b"
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
      "id": "ba04e0ea-b28b-436f-9970-198c95a09105",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:42+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1c9c7cf2-5ddb-403d-9011-bf1c159bfc82",
        "planning_id": "fd6ba10b-331d-4a4c-b30e-3462ce634132",
        "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b"
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
      "id": "8d6dbd84-b34b-44c4-aba9-0df82ca85804",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:42+00:00",
        "updated_at": "2022-07-12T14:15:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b0e6be74-6125-449c-8ce7-9a23107eaac8",
        "planning_id": "fd6ba10b-331d-4a4c-b30e-3462ce634132",
        "order_id": "b1324b00-f43e-497a-a6d2-8cd333e10b5b"
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
          "order_id": "12f7c54d-1b88-49ce-a786-675a3088b741",
          "items": [
            {
              "type": "bundles",
              "id": "f06cc6e7-3de6-4096-b1b4-9f5518137be8",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "aba474b4-b3cf-42f5-bdfa-1170ddd92ad0",
                  "id": "c691c446-9845-48e6-88a2-0ad0e5f79ad4"
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
    "id": "8d320ffa-5c3f-508a-b65c-d1f8bce05099",
    "type": "order_bookings",
    "attributes": {
      "order_id": "12f7c54d-1b88-49ce-a786-675a3088b741"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "12f7c54d-1b88-49ce-a786-675a3088b741"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9a0490cf-fdfa-4937-9e9a-a8e246407e47"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "52c6fd16-db14-42ad-902d-9b43cae447fa"
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
      "id": "12f7c54d-1b88-49ce-a786-675a3088b741",
      "type": "orders",
      "attributes": {
        "created_at": "2022-07-12T14:15:45+00:00",
        "updated_at": "2022-07-12T14:15:46+00:00",
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
        "starts_at": "2022-07-10T14:15:00+00:00",
        "stops_at": "2022-07-14T14:15:00+00:00",
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
        "start_location_id": "15341332-e318-4b83-8463-8079c32170ab",
        "stop_location_id": "15341332-e318-4b83-8463-8079c32170ab"
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
      "id": "9a0490cf-fdfa-4937-9e9a-a8e246407e47",
      "type": "lines",
      "attributes": {
        "created_at": "2022-07-12T14:15:46+00:00",
        "updated_at": "2022-07-12T14:15:46+00:00",
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
        "item_id": "f06cc6e7-3de6-4096-b1b4-9f5518137be8",
        "tax_category_id": null,
        "planning_id": "52c6fd16-db14-42ad-902d-9b43cae447fa",
        "parent_line_id": null,
        "owner_id": "12f7c54d-1b88-49ce-a786-675a3088b741",
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
      "id": "52c6fd16-db14-42ad-902d-9b43cae447fa",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-07-12T14:15:46+00:00",
        "updated_at": "2022-07-12T14:15:46+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-07-10T14:15:00+00:00",
        "stops_at": "2022-07-14T14:15:00+00:00",
        "reserved_from": "2022-07-10T14:15:00+00:00",
        "reserved_till": "2022-07-14T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "f06cc6e7-3de6-4096-b1b4-9f5518137be8",
        "order_id": "12f7c54d-1b88-49ce-a786-675a3088b741",
        "start_location_id": "15341332-e318-4b83-8463-8079c32170ab",
        "stop_location_id": "15341332-e318-4b83-8463-8079c32170ab",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[order_bookings]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][id]` | **Uuid**<br>
`data[attributes][items][]` | **Array**<br>Array with details about the items (and stock item) to add to the order
`data[attributes][confirm_shortage]` | **Boolean**<br>Whether to confirm the shortage if they are non-blocking
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines` => 
`item` => 
`photo`






`plannings`


`stock_item_plannings`





