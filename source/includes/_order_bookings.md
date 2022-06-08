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
          "order_id": "e41af2c9-f747-4aeb-9590-502c9c98d781",
          "items": [
            {
              "type": "products",
              "id": "8974fa33-7db4-4c72-8051-e4a99c992f15",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "a2927196-4d11-4133-84be-93b16499d3c7",
              "stock_item_ids": [
                "5fc8eb9a-d28d-4dee-92b5-34d83f291c11",
                "e09fb3bd-8d92-4960-8654-4e8ab2965186"
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
            "item_id": "8974fa33-7db4-4c72-8051-e4a99c992f15",
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
          "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
          "items": [
            {
              "type": "products",
              "id": "4883d682-38ae-4395-9754-9d11685aee44",
              "stock_item_ids": [
                "8d4ab8b1-a168-4692-82c2-1f179f43859a",
                "49d84fab-d85e-453a-ac88-6fd4a629d01d",
                "08400925-9f38-4f46-8c89-16e4cd75272d"
              ]
            },
            {
              "type": "products",
              "id": "d4ec73ab-80a2-4f30-abe3-8a9a1c1e5db3",
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
    "id": "32d9d389-dc87-5381-bafc-08c3fbc900b3",
    "type": "order_bookings",
    "attributes": {
      "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "118a0d96-0c7e-48a3-a14b-49a9014276db"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "074a33f3-3fa8-43be-ba3d-c992a7203e67"
          },
          {
            "type": "lines",
            "id": "1e0e722c-d018-448b-bab0-f22a2d3d4623"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "4237be27-08d9-45dc-b814-e82bd0b3573e"
          },
          {
            "type": "plannings",
            "id": "fadf23ab-89f5-4373-b786-b695fe577f56"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "0546f851-cb68-4859-b49b-53879c90a2ca"
          },
          {
            "type": "stock_item_plannings",
            "id": "02d453e0-d35b-4333-ad25-9738d112e367"
          },
          {
            "type": "stock_item_plannings",
            "id": "1f6513f3-19fa-46e0-8294-adea39c7a5aa"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-08T08:06:19+00:00",
        "updated_at": "2022-06-08T08:06:22+00:00",
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
        "customer_id": "697a046d-f601-4562-be4d-8cee9197c199",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1",
        "stop_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1"
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
      "id": "074a33f3-3fa8-43be-ba3d-c992a7203e67",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T08:06:20+00:00",
        "updated_at": "2022-06-08T08:06:21+00:00",
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
        "item_id": "d4ec73ab-80a2-4f30-abe3-8a9a1c1e5db3",
        "tax_category_id": "3a021401-c02e-4a16-b6c5-dc51cd16b92f",
        "planning_id": "4237be27-08d9-45dc-b814-e82bd0b3573e",
        "parent_line_id": null,
        "owner_id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
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
      "id": "1e0e722c-d018-448b-bab0-f22a2d3d4623",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T08:06:21+00:00",
        "updated_at": "2022-06-08T08:06:21+00:00",
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
        "item_id": "4883d682-38ae-4395-9754-9d11685aee44",
        "tax_category_id": "3a021401-c02e-4a16-b6c5-dc51cd16b92f",
        "planning_id": "fadf23ab-89f5-4373-b786-b695fe577f56",
        "parent_line_id": null,
        "owner_id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
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
      "id": "4237be27-08d9-45dc-b814-e82bd0b3573e",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:20+00:00",
        "updated_at": "2022-06-08T08:06:22+00:00",
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
        "item_id": "d4ec73ab-80a2-4f30-abe3-8a9a1c1e5db3",
        "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
        "start_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1",
        "stop_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1",
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
      "id": "fadf23ab-89f5-4373-b786-b695fe577f56",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:21+00:00",
        "updated_at": "2022-06-08T08:06:22+00:00",
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
        "item_id": "4883d682-38ae-4395-9754-9d11685aee44",
        "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db",
        "start_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1",
        "stop_location_id": "373526d4-3aca-414b-be7c-8b0d312ad0e1",
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
      "id": "0546f851-cb68-4859-b49b-53879c90a2ca",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:21+00:00",
        "updated_at": "2022-06-08T08:06:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8d4ab8b1-a168-4692-82c2-1f179f43859a",
        "planning_id": "fadf23ab-89f5-4373-b786-b695fe577f56",
        "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db"
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
      "id": "02d453e0-d35b-4333-ad25-9738d112e367",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:21+00:00",
        "updated_at": "2022-06-08T08:06:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "49d84fab-d85e-453a-ac88-6fd4a629d01d",
        "planning_id": "fadf23ab-89f5-4373-b786-b695fe577f56",
        "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db"
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
      "id": "1f6513f3-19fa-46e0-8294-adea39c7a5aa",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:21+00:00",
        "updated_at": "2022-06-08T08:06:21+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "08400925-9f38-4f46-8c89-16e4cd75272d",
        "planning_id": "fadf23ab-89f5-4373-b786-b695fe577f56",
        "order_id": "118a0d96-0c7e-48a3-a14b-49a9014276db"
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
          "order_id": "441b1979-5414-470b-b9bb-521c642176c5",
          "items": [
            {
              "type": "bundles",
              "id": "41b82c11-71cd-4b45-ae42-c4e5f8782ef6",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "feecb654-9c48-4618-8222-1d1d1ff6e049",
                  "id": "f0d5dab2-238c-4d60-b4d0-af0a1927c638"
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
    "id": "40da1d2b-14e5-5fe9-ada3-c567f4aa1bee",
    "type": "order_bookings",
    "attributes": {
      "order_id": "441b1979-5414-470b-b9bb-521c642176c5"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "441b1979-5414-470b-b9bb-521c642176c5"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "0b3989a3-b055-4be9-8eef-deaf43047abd"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "8aeb1180-bf21-482e-b09d-62bca826059b"
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
      "id": "441b1979-5414-470b-b9bb-521c642176c5",
      "type": "orders",
      "attributes": {
        "created_at": "2022-06-08T08:06:24+00:00",
        "updated_at": "2022-06-08T08:06:25+00:00",
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
        "starts_at": "2022-06-06T08:00:00+00:00",
        "stops_at": "2022-06-10T08:00:00+00:00",
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
        "start_location_id": "2274e35e-c76c-444b-aea0-177d03ae9eed",
        "stop_location_id": "2274e35e-c76c-444b-aea0-177d03ae9eed"
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
      "id": "0b3989a3-b055-4be9-8eef-deaf43047abd",
      "type": "lines",
      "attributes": {
        "created_at": "2022-06-08T08:06:25+00:00",
        "updated_at": "2022-06-08T08:06:25+00:00",
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
        "item_id": "41b82c11-71cd-4b45-ae42-c4e5f8782ef6",
        "tax_category_id": null,
        "planning_id": "8aeb1180-bf21-482e-b09d-62bca826059b",
        "parent_line_id": null,
        "owner_id": "441b1979-5414-470b-b9bb-521c642176c5",
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
      "id": "8aeb1180-bf21-482e-b09d-62bca826059b",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-06-08T08:06:25+00:00",
        "updated_at": "2022-06-08T08:06:25+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-06-06T08:00:00+00:00",
        "stops_at": "2022-06-10T08:00:00+00:00",
        "reserved_from": "2022-06-06T08:00:00+00:00",
        "reserved_till": "2022-06-10T08:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "41b82c11-71cd-4b45-ae42-c4e5f8782ef6",
        "order_id": "441b1979-5414-470b-b9bb-521c642176c5",
        "start_location_id": "2274e35e-c76c-444b-aea0-177d03ae9eed",
        "stop_location_id": "2274e35e-c76c-444b-aea0-177d03ae9eed",
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





