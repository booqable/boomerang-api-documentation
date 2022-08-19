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
          "order_id": "7e5ea66d-737d-4020-ad04-453fe2a667e1",
          "items": [
            {
              "type": "products",
              "id": "45102d1c-296a-4b9a-b22f-2144a4a40d7d",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "7a59f4ec-58d7-48ca-aa2e-20bcbc346e26",
              "stock_item_ids": [
                "20d11d70-6f76-46b0-9cad-02aeec9e2dae",
                "a1a8648e-9a21-4ce4-9308-e4e7f80c90a8"
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
            "item_id": "45102d1c-296a-4b9a-b22f-2144a4a40d7d",
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
          "order_id": "f0ff734e-1965-4364-8a22-797cecd78973",
          "items": [
            {
              "type": "products",
              "id": "f1d942f7-feb7-4674-902b-9ece3084aa4c",
              "stock_item_ids": [
                "eae6b5ee-0f9d-4b32-9776-6565ae2ff7b3",
                "55e5f494-f506-4da7-a6f9-ec3b18d769ca",
                "79922a0c-d75f-46ec-9cb4-de6295ee7680"
              ]
            },
            {
              "type": "products",
              "id": "9d4b8fe6-9566-4129-9149-6b031ca24dfc",
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
    "id": "053a4619-ec9b-5ea0-bdc9-6f3806cb812a",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f0ff734e-1965-4364-8a22-797cecd78973"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f0ff734e-1965-4364-8a22-797cecd78973"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "338c6d69-d324-47dc-a192-758ceb56133b"
          },
          {
            "type": "lines",
            "id": "5e0aea70-53cf-44e6-844a-2d6a27281b5d"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "54c601e2-c5ac-4fff-8753-b5def5aa0855"
          },
          {
            "type": "plannings",
            "id": "37c577a6-142d-4b10-bde7-29a886844182"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "2c5be0f8-edaa-4bc7-bd40-44ee3011b93e"
          },
          {
            "type": "stock_item_plannings",
            "id": "ac23031b-7365-43ad-b27e-b6b6ec27dfe6"
          },
          {
            "type": "stock_item_plannings",
            "id": "fdffaf72-b633-4e9a-a995-29e8eff38242"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f0ff734e-1965-4364-8a22-797cecd78973",
      "type": "orders",
      "attributes": {
        "created_at": "2022-08-19T07:57:38+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
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
        "customer_id": "a5e98fd2-3b59-4f62-8336-9c6af005de08",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39",
        "stop_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39"
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
      "id": "338c6d69-d324-47dc-a192-758ceb56133b",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-19T07:57:40+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
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
        "item_id": "f1d942f7-feb7-4674-902b-9ece3084aa4c",
        "tax_category_id": "0bac5901-c810-4807-a28e-857327fe33c5",
        "planning_id": "54c601e2-c5ac-4fff-8753-b5def5aa0855",
        "parent_line_id": null,
        "owner_id": "f0ff734e-1965-4364-8a22-797cecd78973",
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
      "id": "5e0aea70-53cf-44e6-844a-2d6a27281b5d",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-19T07:57:40+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
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
        "item_id": "9d4b8fe6-9566-4129-9149-6b031ca24dfc",
        "tax_category_id": "0bac5901-c810-4807-a28e-857327fe33c5",
        "planning_id": "37c577a6-142d-4b10-bde7-29a886844182",
        "parent_line_id": null,
        "owner_id": "f0ff734e-1965-4364-8a22-797cecd78973",
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
      "id": "54c601e2-c5ac-4fff-8753-b5def5aa0855",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:39+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
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
        "item_id": "f1d942f7-feb7-4674-902b-9ece3084aa4c",
        "order_id": "f0ff734e-1965-4364-8a22-797cecd78973",
        "start_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39",
        "stop_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39",
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
      "id": "37c577a6-142d-4b10-bde7-29a886844182",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:39+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
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
        "item_id": "9d4b8fe6-9566-4129-9149-6b031ca24dfc",
        "order_id": "f0ff734e-1965-4364-8a22-797cecd78973",
        "start_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39",
        "stop_location_id": "9ef0d685-d74a-4866-9855-2abe5ea7fc39",
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
      "id": "2c5be0f8-edaa-4bc7-bd40-44ee3011b93e",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:39+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "eae6b5ee-0f9d-4b32-9776-6565ae2ff7b3",
        "planning_id": "54c601e2-c5ac-4fff-8753-b5def5aa0855",
        "order_id": "f0ff734e-1965-4364-8a22-797cecd78973"
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
      "id": "ac23031b-7365-43ad-b27e-b6b6ec27dfe6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:39+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "55e5f494-f506-4da7-a6f9-ec3b18d769ca",
        "planning_id": "54c601e2-c5ac-4fff-8753-b5def5aa0855",
        "order_id": "f0ff734e-1965-4364-8a22-797cecd78973"
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
      "id": "fdffaf72-b633-4e9a-a995-29e8eff38242",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:39+00:00",
        "updated_at": "2022-08-19T07:57:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "79922a0c-d75f-46ec-9cb4-de6295ee7680",
        "planning_id": "54c601e2-c5ac-4fff-8753-b5def5aa0855",
        "order_id": "f0ff734e-1965-4364-8a22-797cecd78973"
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
          "order_id": "1de8070e-8fff-437b-bd07-490a22f3c3af",
          "items": [
            {
              "type": "bundles",
              "id": "41f6aae9-8c5e-4113-b2a9-664a2928961d",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "24e9d233-c252-42f2-8560-4d4e8e5a40cc",
                  "id": "c15f9951-5de9-4fc4-9086-fbca39defe2b"
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
    "id": "5a238b9d-cbd4-547d-9802-bcaac90ddf3d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "1de8070e-8fff-437b-bd07-490a22f3c3af"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "1de8070e-8fff-437b-bd07-490a22f3c3af"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7060be40-5668-4b84-9e8a-08a07cb0c6a1"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "cfe402a3-c9cd-4312-8209-9af70ef60b76"
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
      "id": "1de8070e-8fff-437b-bd07-490a22f3c3af",
      "type": "orders",
      "attributes": {
        "created_at": "2022-08-19T07:57:43+00:00",
        "updated_at": "2022-08-19T07:57:44+00:00",
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
        "starts_at": "2022-08-17T07:45:00+00:00",
        "stops_at": "2022-08-21T07:45:00+00:00",
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
        "start_location_id": "fb683c2f-d704-45d0-90d5-9117fdff6188",
        "stop_location_id": "fb683c2f-d704-45d0-90d5-9117fdff6188"
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
      "id": "7060be40-5668-4b84-9e8a-08a07cb0c6a1",
      "type": "lines",
      "attributes": {
        "created_at": "2022-08-19T07:57:44+00:00",
        "updated_at": "2022-08-19T07:57:44+00:00",
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
        "item_id": "41f6aae9-8c5e-4113-b2a9-664a2928961d",
        "tax_category_id": null,
        "planning_id": "cfe402a3-c9cd-4312-8209-9af70ef60b76",
        "parent_line_id": null,
        "owner_id": "1de8070e-8fff-437b-bd07-490a22f3c3af",
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
      "id": "cfe402a3-c9cd-4312-8209-9af70ef60b76",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-08-19T07:57:44+00:00",
        "updated_at": "2022-08-19T07:57:44+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-08-17T07:45:00+00:00",
        "stops_at": "2022-08-21T07:45:00+00:00",
        "reserved_from": "2022-08-17T07:45:00+00:00",
        "reserved_till": "2022-08-21T07:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "41f6aae9-8c5e-4113-b2a9-664a2928961d",
        "order_id": "1de8070e-8fff-437b-bd07-490a22f3c3af",
        "start_location_id": "fb683c2f-d704-45d0-90d5-9117fdff6188",
        "stop_location_id": "fb683c2f-d704-45d0-90d5-9117fdff6188",
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





