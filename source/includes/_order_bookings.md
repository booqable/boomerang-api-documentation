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
          "order_id": "e349d6bf-e5bc-4c19-b480-21b1a7b8e07e",
          "items": [
            {
              "type": "products",
              "id": "9b51f4ca-e641-45ed-8462-baac060643c4",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "f628d8bb-5abd-405f-b426-3624e6bf155b",
              "stock_item_ids": [
                "866643f9-d7f6-4010-bdff-e8aec75d9ba6",
                "1681ffc9-f965-4a3d-826c-bd1ecb406e3f"
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
          "stock_item_id 866643f9-d7f6-4010-bdff-e8aec75d9ba6 has already been booked on this order"
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
          "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
          "items": [
            {
              "type": "products",
              "id": "57709d24-b382-44d7-842a-95064a6a8a2e",
              "stock_item_ids": [
                "1b83cd2e-7716-4075-8a3f-fea06f513284",
                "aeb70a00-59de-4550-8fe1-55c1cdcaec9b",
                "9750820b-dd32-4518-9cf2-b5a6d0fa13c3"
              ]
            },
            {
              "type": "products",
              "id": "2fffc3af-d137-4876-8c59-7f811eb18dcf",
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
    "id": "3a3e8f69-c938-5010-ad0e-7b8b6ce745f5",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f7100953-4d72-4742-bdec-60ef1d698cb6"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a444e04f-beb3-4e36-8786-8b99fa92a311"
          },
          {
            "type": "lines",
            "id": "384fb90e-62de-47f6-b2d9-0bc41ed8ac87"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9818381b-d4f5-47e8-98f3-7036c24f5b42"
          },
          {
            "type": "plannings",
            "id": "01dd3cb5-be8c-44e3-9717-512925dccc4f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "c012d760-e5d0-468e-b640-1b90eef59735"
          },
          {
            "type": "stock_item_plannings",
            "id": "9d8f84fa-3c60-48b8-adde-5a2ab89772f0"
          },
          {
            "type": "stock_item_plannings",
            "id": "3ccd432e-de1a-4181-8f40-ed51ddcc9d3a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T11:27:40+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
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
        "customer_id": "23def91f-837d-4775-bfdc-8c8e05ff9617",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57",
        "stop_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57"
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
      "id": "a444e04f-beb3-4e36-8786-8b99fa92a311",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
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
        "item_id": "57709d24-b382-44d7-842a-95064a6a8a2e",
        "tax_category_id": "138ff3ca-add5-4deb-8fc4-095df2cd6a5d",
        "planning_id": "9818381b-d4f5-47e8-98f3-7036c24f5b42",
        "parent_line_id": null,
        "owner_id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
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
      "id": "384fb90e-62de-47f6-b2d9-0bc41ed8ac87",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
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
        "item_id": "2fffc3af-d137-4876-8c59-7f811eb18dcf",
        "tax_category_id": "138ff3ca-add5-4deb-8fc4-095df2cd6a5d",
        "planning_id": "01dd3cb5-be8c-44e3-9717-512925dccc4f",
        "parent_line_id": null,
        "owner_id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
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
      "id": "9818381b-d4f5-47e8-98f3-7036c24f5b42",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
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
        "item_id": "57709d24-b382-44d7-842a-95064a6a8a2e",
        "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
        "start_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57",
        "stop_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57",
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
      "id": "01dd3cb5-be8c-44e3-9717-512925dccc4f",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
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
        "item_id": "2fffc3af-d137-4876-8c59-7f811eb18dcf",
        "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6",
        "start_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57",
        "stop_location_id": "14a4fc92-b0f1-45a4-b311-5ddc156dad57",
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
      "id": "c012d760-e5d0-468e-b640-1b90eef59735",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "1b83cd2e-7716-4075-8a3f-fea06f513284",
        "planning_id": "9818381b-d4f5-47e8-98f3-7036c24f5b42",
        "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6"
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
      "id": "9d8f84fa-3c60-48b8-adde-5a2ab89772f0",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "aeb70a00-59de-4550-8fe1-55c1cdcaec9b",
        "planning_id": "9818381b-d4f5-47e8-98f3-7036c24f5b42",
        "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6"
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
      "id": "3ccd432e-de1a-4181-8f40-ed51ddcc9d3a",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:42+00:00",
        "updated_at": "2023-02-28T11:27:42+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "9750820b-dd32-4518-9cf2-b5a6d0fa13c3",
        "planning_id": "9818381b-d4f5-47e8-98f3-7036c24f5b42",
        "order_id": "f7100953-4d72-4742-bdec-60ef1d698cb6"
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
          "order_id": "2431d174-1dab-402a-bc21-004c4bb0c42a",
          "items": [
            {
              "type": "bundles",
              "id": "a5d44f63-b8fa-4090-b322-66670377b805",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "3e4a7ff1-1016-4203-9599-e7fd0ffd66c5",
                  "id": "4ffb65c3-580b-4d78-a447-8afabd74d15d"
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
    "id": "07e70f5e-d69b-5f2c-9bdf-276f1a6f311b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "2431d174-1dab-402a-bc21-004c4bb0c42a"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "2431d174-1dab-402a-bc21-004c4bb0c42a"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "1dc1258a-2a60-456a-97fa-81854d93ca41"
          },
          {
            "type": "lines",
            "id": "638a49ef-e35d-49ef-8f41-aa8d5f5e3ef8"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "17812fd7-9373-4ee7-8cbb-616922a41be9"
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
      "id": "2431d174-1dab-402a-bc21-004c4bb0c42a",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-28T11:27:45+00:00",
        "updated_at": "2023-02-28T11:27:45+00:00",
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
        "starts_at": "2023-02-26T11:15:00+00:00",
        "stops_at": "2023-03-02T11:15:00+00:00",
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
        "start_location_id": "1b91e3ef-93bc-47c6-9c10-609389a5ed25",
        "stop_location_id": "1b91e3ef-93bc-47c6-9c10-609389a5ed25"
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
      "id": "1dc1258a-2a60-456a-97fa-81854d93ca41",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T11:27:45+00:00",
        "updated_at": "2023-02-28T11:27:45+00:00",
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
        "item_id": "a5d44f63-b8fa-4090-b322-66670377b805",
        "tax_category_id": null,
        "planning_id": "17812fd7-9373-4ee7-8cbb-616922a41be9",
        "parent_line_id": null,
        "owner_id": "2431d174-1dab-402a-bc21-004c4bb0c42a",
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
      "id": "638a49ef-e35d-49ef-8f41-aa8d5f5e3ef8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-28T11:27:45+00:00",
        "updated_at": "2023-02-28T11:27:45+00:00",
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
        "item_id": "4ffb65c3-580b-4d78-a447-8afabd74d15d",
        "tax_category_id": null,
        "planning_id": "d7fdbf7d-e4d2-4ae8-aeac-287c5326dd62",
        "parent_line_id": "1dc1258a-2a60-456a-97fa-81854d93ca41",
        "owner_id": "2431d174-1dab-402a-bc21-004c4bb0c42a",
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
      "id": "17812fd7-9373-4ee7-8cbb-616922a41be9",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-28T11:27:45+00:00",
        "updated_at": "2023-02-28T11:27:45+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-26T11:15:00+00:00",
        "stops_at": "2023-03-02T11:15:00+00:00",
        "reserved_from": "2023-02-26T11:15:00+00:00",
        "reserved_till": "2023-03-02T11:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "a5d44f63-b8fa-4090-b322-66670377b805",
        "order_id": "2431d174-1dab-402a-bc21-004c4bb0c42a",
        "start_location_id": "1b91e3ef-93bc-47c6-9c10-609389a5ed25",
        "stop_location_id": "1b91e3ef-93bc-47c6-9c10-609389a5ed25",
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





