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
          "order_id": "ca174040-04d1-4f35-ad33-a0cb7526cc18",
          "items": [
            {
              "type": "products",
              "id": "cfb7bd23-31aa-456c-aee9-ce1d7046c489",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "77c8f9a6-9dfc-4b47-ae34-5560a6769faa",
              "stock_item_ids": [
                "83bf4214-3aa8-40ef-9971-44852088184f",
                "0c5f8046-86a6-45ae-a4be-6ea33d52567f"
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
            "item_id": "cfb7bd23-31aa-456c-aee9-ce1d7046c489",
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
          "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
          "items": [
            {
              "type": "products",
              "id": "630da645-ae2b-49ea-8d6c-8cf64f613f98",
              "stock_item_ids": [
                "616b8d33-1b52-4a0d-bee4-8bccfb91dfc1",
                "779b752b-516c-4fc7-9866-5c5111453a8e",
                "37e21925-78d9-4729-8d66-c32331fdc4c5"
              ]
            },
            {
              "type": "products",
              "id": "5e132e92-7c90-4984-a434-944adb9698ae",
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
    "id": "826e62e7-33ab-5983-b3a2-676d808dcd1c",
    "type": "order_bookings",
    "attributes": {
      "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "cce1e5d9-2027-466c-876e-45a9fbc0e756"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "75bcf953-ddb4-4b10-a377-c543dba94ad4"
          },
          {
            "type": "lines",
            "id": "2bbc7254-7509-4e0b-8f16-5f768278f391"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c"
          },
          {
            "type": "plannings",
            "id": "94ef852d-8ed6-437f-ae81-25d8e1e49f88"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c355b50f-13c4-4e26-b01c-74bb746ef621"
          },
          {
            "type": "stock_item_plannings",
            "id": "2761a36f-d49c-47d8-9016-1c93690e3f17"
          },
          {
            "type": "stock_item_plannings",
            "id": "ae4cdca3-5714-4ff3-b3cd-db1a602f4ace"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T08:57:42+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
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
        "customer_id": "69dfeff4-5e18-4d32-b161-db9212786124",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "5e535c05-ae73-4532-8416-5610024d5701",
        "stop_location_id": "5e535c05-ae73-4532-8416-5610024d5701"
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
      "id": "75bcf953-ddb4-4b10-a377-c543dba94ad4",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
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
        "item_id": "630da645-ae2b-49ea-8d6c-8cf64f613f98",
        "tax_category_id": "49a375e4-2272-4858-a666-7139bd14c93f",
        "planning_id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c",
        "parent_line_id": null,
        "owner_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
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
      "id": "2bbc7254-7509-4e0b-8f16-5f768278f391",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
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
        "item_id": "5e132e92-7c90-4984-a434-944adb9698ae",
        "tax_category_id": "49a375e4-2272-4858-a666-7139bd14c93f",
        "planning_id": "94ef852d-8ed6-437f-ae81-25d8e1e49f88",
        "parent_line_id": null,
        "owner_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
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
      "id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
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
        "item_id": "630da645-ae2b-49ea-8d6c-8cf64f613f98",
        "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
        "start_location_id": "5e535c05-ae73-4532-8416-5610024d5701",
        "stop_location_id": "5e535c05-ae73-4532-8416-5610024d5701",
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
      "id": "94ef852d-8ed6-437f-ae81-25d8e1e49f88",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
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
        "item_id": "5e132e92-7c90-4984-a434-944adb9698ae",
        "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756",
        "start_location_id": "5e535c05-ae73-4532-8416-5610024d5701",
        "stop_location_id": "5e535c05-ae73-4532-8416-5610024d5701",
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
      "id": "c355b50f-13c4-4e26-b01c-74bb746ef621",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "616b8d33-1b52-4a0d-bee4-8bccfb91dfc1",
        "planning_id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c",
        "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756"
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
      "id": "2761a36f-d49c-47d8-9016-1c93690e3f17",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "779b752b-516c-4fc7-9866-5c5111453a8e",
        "planning_id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c",
        "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756"
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
      "id": "ae4cdca3-5714-4ff3-b3cd-db1a602f4ace",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:44+00:00",
        "updated_at": "2022-10-13T08:57:44+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "37e21925-78d9-4729-8d66-c32331fdc4c5",
        "planning_id": "f0ad63b1-8923-4c6c-9902-468f7eb4e20c",
        "order_id": "cce1e5d9-2027-466c-876e-45a9fbc0e756"
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
          "order_id": "1a0df923-9481-464f-8206-bd5dcfa65db4",
          "items": [
            {
              "type": "bundles",
              "id": "17f872a3-00fb-4f90-b9cf-de3a1f3f45e6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "051e4475-d024-4194-bd31-dc988a283bd0",
                  "id": "cb481592-2963-4137-b6ef-6f5b8b020270"
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
    "id": "d02f7411-7002-5e75-8da0-6787741a859a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1a0df923-9481-464f-8206-bd5dcfa65db4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1a0df923-9481-464f-8206-bd5dcfa65db4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "be137619-8f51-42a0-8642-cb5e70541881"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8a9f9bed-5780-4033-aea6-373dfd4c8387"
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
      "id": "1a0df923-9481-464f-8206-bd5dcfa65db4",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-13T08:57:46+00:00",
        "updated_at": "2022-10-13T08:57:47+00:00",
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
        "starts_at": "2022-10-11T08:45:00+00:00",
        "stops_at": "2022-10-15T08:45:00+00:00",
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
        "start_location_id": "38978082-21af-4b2a-bdff-080f7e2ac56f",
        "stop_location_id": "38978082-21af-4b2a-bdff-080f7e2ac56f"
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
      "id": "be137619-8f51-42a0-8642-cb5e70541881",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-13T08:57:47+00:00",
        "updated_at": "2022-10-13T08:57:47+00:00",
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
        "item_id": "17f872a3-00fb-4f90-b9cf-de3a1f3f45e6",
        "tax_category_id": null,
        "planning_id": "8a9f9bed-5780-4033-aea6-373dfd4c8387",
        "parent_line_id": null,
        "owner_id": "1a0df923-9481-464f-8206-bd5dcfa65db4",
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
      "id": "8a9f9bed-5780-4033-aea6-373dfd4c8387",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-13T08:57:47+00:00",
        "updated_at": "2022-10-13T08:57:47+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-11T08:45:00+00:00",
        "stops_at": "2022-10-15T08:45:00+00:00",
        "reserved_from": "2022-10-11T08:45:00+00:00",
        "reserved_till": "2022-10-15T08:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "17f872a3-00fb-4f90-b9cf-de3a1f3f45e6",
        "order_id": "1a0df923-9481-464f-8206-bd5dcfa65db4",
        "start_location_id": "38978082-21af-4b2a-bdff-080f7e2ac56f",
        "stop_location_id": "38978082-21af-4b2a-bdff-080f7e2ac56f",
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





