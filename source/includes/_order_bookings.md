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
          "order_id": "281ff41e-2d92-411e-8bb2-727ad190ea1c",
          "items": [
            {
              "type": "products",
              "id": "8acfefa2-dc8d-456d-924e-bc4dea342520",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7db5af25-4e63-4ae9-8ab4-74fa2eaafc5b",
              "stock_item_ids": [
                "45946be1-4cf5-4c9f-86e2-348262dac623",
                "b87ca804-c923-4f20-8420-9bdadc9376ba"
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
            "item_id": "8acfefa2-dc8d-456d-924e-bc4dea342520",
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
          "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
          "items": [
            {
              "type": "products",
              "id": "124e9822-b6f7-4c51-aa7a-6b0ae00f82eb",
              "stock_item_ids": [
                "faec41ca-0fb9-4030-9721-28a9357c3c8d",
                "4df06bab-22d9-46c2-8859-d9cbaf393088",
                "66d66673-b854-4bfd-9f99-46bd19cb3316"
              ]
            },
            {
              "type": "products",
              "id": "d1edf315-ba03-4840-a0df-c34ec323bf45",
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
    "id": "4645e810-5138-5946-840b-5d21d70a4d69",
    "type": "order_bookings",
    "attributes": {
      "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cd6ed08d-934f-4fce-b1dd-ab06dd363709"
          },
          {
            "type": "lines",
            "id": "4c9f96d4-6db4-4b77-9bd8-7e45e17ebe11"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88"
          },
          {
            "type": "plannings",
            "id": "16d2e480-18c9-4de0-9363-a8707f3f6701"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "bbae9b79-776a-4349-bfe2-38f16997cdd2"
          },
          {
            "type": "stock_item_plannings",
            "id": "45860082-4fbe-4517-9a02-5e62f30534de"
          },
          {
            "type": "stock_item_plannings",
            "id": "1f38ee2d-da2a-445e-aff4-96ae8b08ebec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T16:31:38+00:00",
        "updated_at": "2022-10-25T16:31:40+00:00",
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
        "customer_id": "6e33fb3d-90cb-4d66-b0c7-506dc1f7a009",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba",
        "stop_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba"
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
      "id": "cd6ed08d-934f-4fce-b1dd-ab06dd363709",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
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
        "item_id": "124e9822-b6f7-4c51-aa7a-6b0ae00f82eb",
        "tax_category_id": "63bbd262-353f-4f33-88f8-296fb75fe499",
        "planning_id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88",
        "parent_line_id": null,
        "owner_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
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
      "id": "4c9f96d4-6db4-4b77-9bd8-7e45e17ebe11",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
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
        "item_id": "d1edf315-ba03-4840-a0df-c34ec323bf45",
        "tax_category_id": "63bbd262-353f-4f33-88f8-296fb75fe499",
        "planning_id": "16d2e480-18c9-4de0-9363-a8707f3f6701",
        "parent_line_id": null,
        "owner_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
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
      "id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
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
        "item_id": "124e9822-b6f7-4c51-aa7a-6b0ae00f82eb",
        "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
        "start_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba",
        "stop_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba",
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
      "id": "16d2e480-18c9-4de0-9363-a8707f3f6701",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
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
        "item_id": "d1edf315-ba03-4840-a0df-c34ec323bf45",
        "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f",
        "start_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba",
        "stop_location_id": "b34b3678-d5c1-42f0-a6f9-23edb14220ba",
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
      "id": "bbae9b79-776a-4349-bfe2-38f16997cdd2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "faec41ca-0fb9-4030-9721-28a9357c3c8d",
        "planning_id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88",
        "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f"
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
      "id": "45860082-4fbe-4517-9a02-5e62f30534de",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4df06bab-22d9-46c2-8859-d9cbaf393088",
        "planning_id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88",
        "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f"
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
      "id": "1f38ee2d-da2a-445e-aff4-96ae8b08ebec",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:39+00:00",
        "updated_at": "2022-10-25T16:31:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "66d66673-b854-4bfd-9f99-46bd19cb3316",
        "planning_id": "ec7a7084-ed72-4490-bc1b-7d4b4a1b9d88",
        "order_id": "afb0bfe7-b79f-4209-9da3-d4f26a79470f"
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
          "order_id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032",
          "items": [
            {
              "type": "bundles",
              "id": "1f11463a-1003-4f72-b448-74c69b66a91e",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "75bb268c-685c-44f6-ada1-9812da8138a5",
                  "id": "4beaa2a4-c656-4875-b7b9-46a4a658dd7d"
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
    "id": "d19a812f-59c4-5e18-87d8-05f82f6f03cf",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "922915e1-251f-496c-9492-14e3f727d604"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a1a125eb-ccfe-446f-88bd-f72e819563a8"
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
      "id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-25T16:31:43+00:00",
        "updated_at": "2022-10-25T16:31:44+00:00",
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
        "starts_at": "2022-10-23T16:30:00+00:00",
        "stops_at": "2022-10-27T16:30:00+00:00",
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
        "start_location_id": "9afd4dec-9c00-4596-b5f2-b233385ebba9",
        "stop_location_id": "9afd4dec-9c00-4596-b5f2-b233385ebba9"
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
      "id": "922915e1-251f-496c-9492-14e3f727d604",
      "type": "lines",
      "attributes": {
        "created_at": "2022-10-25T16:31:43+00:00",
        "updated_at": "2022-10-25T16:31:43+00:00",
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
        "item_id": "1f11463a-1003-4f72-b448-74c69b66a91e",
        "tax_category_id": null,
        "planning_id": "a1a125eb-ccfe-446f-88bd-f72e819563a8",
        "parent_line_id": null,
        "owner_id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032",
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
      "id": "a1a125eb-ccfe-446f-88bd-f72e819563a8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-10-25T16:31:43+00:00",
        "updated_at": "2022-10-25T16:31:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-10-23T16:30:00+00:00",
        "stops_at": "2022-10-27T16:30:00+00:00",
        "reserved_from": "2022-10-23T16:30:00+00:00",
        "reserved_till": "2022-10-27T16:30:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "1f11463a-1003-4f72-b448-74c69b66a91e",
        "order_id": "2cb9eae9-aad1-4ca2-b0b8-cb86cd9fa032",
        "start_location_id": "9afd4dec-9c00-4596-b5f2-b233385ebba9",
        "stop_location_id": "9afd4dec-9c00-4596-b5f2-b233385ebba9",
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





