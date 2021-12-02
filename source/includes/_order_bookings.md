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
          "order_id": "388d68fb-0c38-4f9b-8f9a-042b8903217d",
          "items": [
            {
              "type": "products",
              "id": "fa81873b-70c9-4ef2-9258-6021412e3d68",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d1718a2c-a7e8-4517-83cd-e2e941d20a39",
              "stock_item_ids": [
                "85f32462-339b-4716-899a-b96123d5624a",
                "693d7c3f-ba53-4d43-801d-c3e680762ae3"
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
            "item_id": "fa81873b-70c9-4ef2-9258-6021412e3d68",
            "stock_count": 4,
            "reserved": 0,
            "needed": 10,
            "shortage": 6
          },
          {
            "reason": "stock_item_specified",
            "item_id": "d1718a2c-a7e8-4517-83cd-e2e941d20a39",
            "unavailable": [
              "85f32462-339b-4716-899a-b96123d5624a"
            ],
            "available": [
              "693d7c3f-ba53-4d43-801d-c3e680762ae3"
            ]
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
          "order_id": "f4901fec-d31c-4247-9556-126e7aca697d",
          "items": [
            {
              "type": "products",
              "id": "e4580a78-b566-46dd-abe7-4b18cd4f0d4d",
              "stock_item_ids": [
                "7428a938-266a-4a52-a0cf-335e49b9edc6",
                "fb1a7ced-ef17-482b-bf5c-40ec89e87b7c",
                "8e5b8576-0183-45b1-82cf-2124c721a8d4"
              ]
            },
            {
              "type": "products",
              "id": "3b4997ec-2bde-48ef-a664-038170d1fe0b",
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
    "id": "12b86ce9-340c-5dc2-9db0-61a6df8b4635",
    "type": "order_bookings",
    "attributes": {
      "order_id": "f4901fec-d31c-4247-9556-126e7aca697d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "f4901fec-d31c-4247-9556-126e7aca697d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "40c05f68-b31c-43de-a7bc-72e8b05c23bd"
          },
          {
            "type": "lines",
            "id": "14591e2c-7be1-4147-9aee-fd5b102f4d82"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "298ef452-0af6-4453-923b-97adc7f79c94"
          },
          {
            "type": "plannings",
            "id": "d672ea6f-f133-4c13-b805-299733629bdc"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8f18fb78-6b7a-4574-982b-606ce8a48a9d"
          },
          {
            "type": "stock_item_plannings",
            "id": "512872d3-0697-4d6a-81e9-bdb3a2df4811"
          },
          {
            "type": "stock_item_plannings",
            "id": "7c902db9-8a60-4db1-bc8c-2dd115ccc6ea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f4901fec-d31c-4247-9556-126e7aca697d",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T15:12:11+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
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
        "customer_id": "d9e15df2-f986-4861-a94e-4646479c70aa",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb",
        "stop_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb"
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
      "id": "40c05f68-b31c-43de-a7bc-72e8b05c23bd",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T15:12:11+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
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
        "item_id": "3b4997ec-2bde-48ef-a664-038170d1fe0b",
        "tax_category_id": "5502e44d-a1ae-480c-8233-4284fce1cb8e",
        "parent_line_id": null,
        "owner_id": "f4901fec-d31c-4247-9556-126e7aca697d",
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
      "id": "14591e2c-7be1-4147-9aee-fd5b102f4d82",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T15:12:13+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
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
        "item_id": "e4580a78-b566-46dd-abe7-4b18cd4f0d4d",
        "tax_category_id": "5502e44d-a1ae-480c-8233-4284fce1cb8e",
        "parent_line_id": null,
        "owner_id": "f4901fec-d31c-4247-9556-126e7aca697d",
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
      "id": "298ef452-0af6-4453-923b-97adc7f79c94",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:11+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
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
        "item_id": "3b4997ec-2bde-48ef-a664-038170d1fe0b",
        "order_id": "f4901fec-d31c-4247-9556-126e7aca697d",
        "start_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb",
        "stop_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb",
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
      "id": "d672ea6f-f133-4c13-b805-299733629bdc",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:13+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
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
        "item_id": "e4580a78-b566-46dd-abe7-4b18cd4f0d4d",
        "order_id": "f4901fec-d31c-4247-9556-126e7aca697d",
        "start_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb",
        "stop_location_id": "72a8ebde-2be9-4cfa-880a-69ece260eecb",
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
      "id": "8f18fb78-6b7a-4574-982b-606ce8a48a9d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:13+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "7428a938-266a-4a52-a0cf-335e49b9edc6",
        "planning_id": "d672ea6f-f133-4c13-b805-299733629bdc",
        "order_id": "f4901fec-d31c-4247-9556-126e7aca697d"
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
      "id": "512872d3-0697-4d6a-81e9-bdb3a2df4811",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:13+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fb1a7ced-ef17-482b-bf5c-40ec89e87b7c",
        "planning_id": "d672ea6f-f133-4c13-b805-299733629bdc",
        "order_id": "f4901fec-d31c-4247-9556-126e7aca697d"
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
      "id": "7c902db9-8a60-4db1-bc8c-2dd115ccc6ea",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:13+00:00",
        "updated_at": "2021-12-02T15:12:13+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "8e5b8576-0183-45b1-82cf-2124c721a8d4",
        "planning_id": "d672ea6f-f133-4c13-b805-299733629bdc",
        "order_id": "f4901fec-d31c-4247-9556-126e7aca697d"
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&data%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=e4580a78-b566-46dd-abe7-4b18cd4f0d4d&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7428a938-266a-4a52-a0cf-335e49b9edc6&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=fb1a7ced-ef17-482b-bf5c-40ec89e87b7c&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=8e5b8576-0183-45b1-82cf-2124c721a8d4&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=3b4997ec-2bde-48ef-a664-038170d1fe0b&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bquantity%5D=1&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=f4901fec-d31c-4247-9556-126e7aca697d&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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
          "order_id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40",
          "items": [
            {
              "type": "bundles",
              "id": "724a8c70-a055-42f7-825f-f438606fdfd7",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "83df1373-66eb-4c66-8d1c-a32706dcf4ba",
                  "id": "905d038a-0af1-4c93-83af-0734033e45bd"
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
    "id": "c7d291c7-c64a-5f4d-baa4-55f83c6b7817",
    "type": "order_bookings",
    "attributes": {
      "order_id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "aa874229-eb91-4546-868a-42feb1b95e2f"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a36cea83-1a98-4dfb-9300-3181c5c24317"
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
      "id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-02T15:12:15+00:00",
        "updated_at": "2021-12-02T15:12:15+00:00",
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
        "starts_at": "2021-11-30T15:00:00+00:00",
        "stops_at": "2021-12-04T15:00:00+00:00",
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
        "start_location_id": "85288129-0e4a-40e5-9157-e298f09927e2",
        "stop_location_id": "85288129-0e4a-40e5-9157-e298f09927e2"
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
      "id": "aa874229-eb91-4546-868a-42feb1b95e2f",
      "type": "lines",
      "attributes": {
        "created_at": "2021-12-02T15:12:15+00:00",
        "updated_at": "2021-12-02T15:12:15+00:00",
        "title": "Bundle item 1",
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
        "item_id": "724a8c70-a055-42f7-825f-f438606fdfd7",
        "tax_category_id": null,
        "parent_line_id": null,
        "owner_id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40",
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
      "id": "a36cea83-1a98-4dfb-9300-3181c5c24317",
      "type": "plannings",
      "attributes": {
        "created_at": "2021-12-02T15:12:15+00:00",
        "updated_at": "2021-12-02T15:12:15+00:00",
        "quantity": 1,
        "starts_at": "2021-11-30T15:00:00+00:00",
        "stops_at": "2021-12-04T15:00:00+00:00",
        "reserved_from": "2021-11-30T15:00:00+00:00",
        "reserved_till": "2021-12-04T15:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "724a8c70-a055-42f7-825f-f438606fdfd7",
        "order_id": "65b8a820-2a34-4cf0-baa5-f2a5cb6eae40",
        "start_location_id": "85288129-0e4a-40e5-9157-e298f09927e2",
        "stop_location_id": "85288129-0e4a-40e5-9157-e298f09927e2",
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
  "links": {
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&data%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&data%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&data%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&data%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&data%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Btype%5D=bundles&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bid%5D=724a8c70-a055-42f7-825f-f438606fdfd7&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Btype%5D=products&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bbundle_item_id%5D=83df1373-66eb-4c66-8d1c-a32706dcf4ba&order_booking%5Bdata%5D%5Battributes%5D%5Bitems%5D%5B%5D%5Bproducts%5D%5B%5D%5Bid%5D=905d038a-0af1-4c93-83af-0734033e45bd&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=65b8a820-2a34-4cf0-baa5-f2a5cb6eae40&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
  },
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





