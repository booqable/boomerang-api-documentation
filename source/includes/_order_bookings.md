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
          "order_id": "1bfe1c7a-6861-4b1a-8d57-a86c7c50923d",
          "items": [
            {
              "type": "products",
              "id": "47987904-07dc-40a0-9018-2fb056694c62",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0338b71e-0345-4ae1-85d3-e1182047b865",
              "stock_item_ids": [
                "bf07290c-663a-45ba-98b6-fa84c13268b1",
                "92d54408-dee2-4048-82ce-bb5309ad3f80"
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
            "item_id": "47987904-07dc-40a0-9018-2fb056694c62",
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
          "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
          "items": [
            {
              "type": "products",
              "id": "ba4b3d77-e237-4dcb-b546-4c5aad2b3d80",
              "stock_item_ids": [
                "4c038543-7c72-44ec-9f63-703ab13339ff",
                "5fe1e6de-704e-4e4b-b109-d596439e97c3",
                "b0ceaa65-3345-4c6a-8bf4-6064f7c30453"
              ]
            },
            {
              "type": "products",
              "id": "41780693-92fa-474e-911f-b75773456273",
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
    "id": "e8a39d14-1c67-5460-b78d-7a460306615a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e126e49d-cbae-4b46-9074-aa688a3f74ff"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9c538ab1-ff59-46e4-b5f6-2041f2f0c39d"
          },
          {
            "type": "lines",
            "id": "8ac0726d-3d65-4d76-9420-d49f633ed365"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "db93f916-898d-4b85-b130-47bbf40333a0"
          },
          {
            "type": "plannings",
            "id": "5550e0fa-71a9-4732-a260-16bebd7f85a8"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "94a5ce65-4ad5-4e8c-ade9-6846c437a27c"
          },
          {
            "type": "stock_item_plannings",
            "id": "e2ccc292-c741-4626-97ce-b3446f5d3a4d"
          },
          {
            "type": "stock_item_plannings",
            "id": "c67d9742-e98e-4a0e-9dca-fddae649e5c8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-16T14:23:56+00:00",
        "updated_at": "2022-11-16T14:23:58+00:00",
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
        "customer_id": "fe4f8f58-a94e-406e-bdbf-7fde631a5ba5",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6",
        "stop_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6"
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
      "id": "9c538ab1-ff59-46e4-b5f6-2041f2f0c39d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:58+00:00",
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
        "item_id": "ba4b3d77-e237-4dcb-b546-4c5aad2b3d80",
        "tax_category_id": "a101d539-d060-4784-bcde-be718d72a447",
        "planning_id": "db93f916-898d-4b85-b130-47bbf40333a0",
        "parent_line_id": null,
        "owner_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
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
      "id": "8ac0726d-3d65-4d76-9420-d49f633ed365",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:58+00:00",
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
        "item_id": "41780693-92fa-474e-911f-b75773456273",
        "tax_category_id": "a101d539-d060-4784-bcde-be718d72a447",
        "planning_id": "5550e0fa-71a9-4732-a260-16bebd7f85a8",
        "parent_line_id": null,
        "owner_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
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
      "id": "db93f916-898d-4b85-b130-47bbf40333a0",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:58+00:00",
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
        "item_id": "ba4b3d77-e237-4dcb-b546-4c5aad2b3d80",
        "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
        "start_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6",
        "stop_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6",
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
      "id": "5550e0fa-71a9-4732-a260-16bebd7f85a8",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:58+00:00",
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
        "item_id": "41780693-92fa-474e-911f-b75773456273",
        "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff",
        "start_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6",
        "stop_location_id": "2b0f7c50-6416-4ec4-8380-28b3fa5af3d6",
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
      "id": "94a5ce65-4ad5-4e8c-ade9-6846c437a27c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "4c038543-7c72-44ec-9f63-703ab13339ff",
        "planning_id": "db93f916-898d-4b85-b130-47bbf40333a0",
        "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff"
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
      "id": "e2ccc292-c741-4626-97ce-b3446f5d3a4d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "5fe1e6de-704e-4e4b-b109-d596439e97c3",
        "planning_id": "db93f916-898d-4b85-b130-47bbf40333a0",
        "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff"
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
      "id": "c67d9742-e98e-4a0e-9dca-fddae649e5c8",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-11-16T14:23:57+00:00",
        "updated_at": "2022-11-16T14:23:57+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b0ceaa65-3345-4c6a-8bf4-6064f7c30453",
        "planning_id": "db93f916-898d-4b85-b130-47bbf40333a0",
        "order_id": "e126e49d-cbae-4b46-9074-aa688a3f74ff"
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
          "order_id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423",
          "items": [
            {
              "type": "bundles",
              "id": "e126cc05-6396-4b97-bc52-68e753a9e461",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "6b2217d0-2cf7-4305-bf32-c04f46343757",
                  "id": "252b1f96-0756-42ad-88b1-35c88c431166"
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
    "id": "b1b22d15-c32b-5c6b-9b10-40078d8fe8a8",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "03d3d5ed-3e09-4feb-8896-7f40ea80efb1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2bb1ce55-b886-4d66-9f55-5e19100ce924"
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
      "id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423",
      "type": "orders",
      "attributes": {
        "created_at": "2022-11-16T14:24:00+00:00",
        "updated_at": "2022-11-16T14:24:00+00:00",
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
        "starts_at": "2022-11-14T14:15:00+00:00",
        "stops_at": "2022-11-18T14:15:00+00:00",
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
        "start_location_id": "dd958061-2bb7-45dc-b1b9-4e5257fad85e",
        "stop_location_id": "dd958061-2bb7-45dc-b1b9-4e5257fad85e"
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
      "id": "03d3d5ed-3e09-4feb-8896-7f40ea80efb1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-11-16T14:24:00+00:00",
        "updated_at": "2022-11-16T14:24:00+00:00",
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
        "item_id": "e126cc05-6396-4b97-bc52-68e753a9e461",
        "tax_category_id": null,
        "planning_id": "2bb1ce55-b886-4d66-9f55-5e19100ce924",
        "parent_line_id": null,
        "owner_id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423",
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
      "id": "2bb1ce55-b886-4d66-9f55-5e19100ce924",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-11-16T14:24:00+00:00",
        "updated_at": "2022-11-16T14:24:00+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-11-14T14:15:00+00:00",
        "stops_at": "2022-11-18T14:15:00+00:00",
        "reserved_from": "2022-11-14T14:15:00+00:00",
        "reserved_till": "2022-11-18T14:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "e126cc05-6396-4b97-bc52-68e753a9e461",
        "order_id": "f58755a1-42c6-4db6-9bde-e0dd53bfc423",
        "start_location_id": "dd958061-2bb7-45dc-b1b9-4e5257fad85e",
        "stop_location_id": "dd958061-2bb7-45dc-b1b9-4e5257fad85e",
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





