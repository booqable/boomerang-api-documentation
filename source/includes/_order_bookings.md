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
          "order_id": "d6b676fb-b314-42f3-bd1a-387bc913881b",
          "items": [
            {
              "type": "products",
              "id": "a4832a1c-5a7b-40ed-a08c-025ad9bb6bfc",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "0df6b5d8-13b6-4519-8772-aab4d089c5c0",
              "stock_item_ids": [
                "2c793f0b-16dc-482d-b106-3780087a9fdb",
                "6c15d8cd-73c1-4790-b163-d8312e76d594"
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
            "item_id": "a4832a1c-5a7b-40ed-a08c-025ad9bb6bfc",
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
          "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
          "items": [
            {
              "type": "products",
              "id": "b6f0c804-6ef5-4561-baa3-3ab0a83003a3",
              "stock_item_ids": [
                "021bc639-7a58-4902-9d32-c54e031de157",
                "36eae081-e516-4ca1-93c3-1f4032bba11a",
                "6c52d4c3-6b9d-4539-8c57-ec52a1bb2828"
              ]
            },
            {
              "type": "products",
              "id": "6f6a605f-0224-4015-9c86-3c4d74c3385e",
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
    "id": "4b115339-cae3-59cb-8396-30f199f0a8e4",
    "type": "order_bookings",
    "attributes": {
      "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "10ab1162-8e84-4a92-8296-27f0c114cc3c"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a3f258ac-425d-47cd-93b3-9735e42484f8"
          },
          {
            "type": "lines",
            "id": "f2b07041-4a0a-4535-8dc1-b938caefcc32"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "f70b5e9f-1284-4341-ae71-e47300622368"
          },
          {
            "type": "plannings",
            "id": "e6ad462f-10b8-402e-9b81-38ab712efb5f"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "8448706e-d5f0-4761-adc1-e11e4044277c"
          },
          {
            "type": "stock_item_plannings",
            "id": "d737f034-92b1-4cdd-aa3b-2691dc242893"
          },
          {
            "type": "stock_item_plannings",
            "id": "b5c4354b-32cf-4d62-94fd-514bb456bab9"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-14T09:24:17+00:00",
        "updated_at": "2022-02-14T09:24:19+00:00",
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
        "customer_id": "7bf53d44-6f6c-4152-a137-bd30de187977",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910",
        "stop_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910"
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
      "id": "a3f258ac-425d-47cd-93b3-9735e42484f8",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-14T09:24:17+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
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
        "item_id": "6f6a605f-0224-4015-9c86-3c4d74c3385e",
        "tax_category_id": "9ea91efe-3069-4b51-92e7-e879f4d7d095",
        "planning_id": "f70b5e9f-1284-4341-ae71-e47300622368",
        "parent_line_id": null,
        "owner_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
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
      "id": "f2b07041-4a0a-4535-8dc1-b938caefcc32",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-14T09:24:18+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
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
        "item_id": "b6f0c804-6ef5-4561-baa3-3ab0a83003a3",
        "tax_category_id": "9ea91efe-3069-4b51-92e7-e879f4d7d095",
        "planning_id": "e6ad462f-10b8-402e-9b81-38ab712efb5f",
        "parent_line_id": null,
        "owner_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
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
      "id": "f70b5e9f-1284-4341-ae71-e47300622368",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:17+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
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
        "item_id": "6f6a605f-0224-4015-9c86-3c4d74c3385e",
        "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
        "start_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910",
        "stop_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910",
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
      "id": "e6ad462f-10b8-402e-9b81-38ab712efb5f",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:18+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
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
        "item_id": "b6f0c804-6ef5-4561-baa3-3ab0a83003a3",
        "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c",
        "start_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910",
        "stop_location_id": "fc94a546-7095-4f3b-8dd0-20ec82c44910",
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
      "id": "8448706e-d5f0-4761-adc1-e11e4044277c",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:18+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "021bc639-7a58-4902-9d32-c54e031de157",
        "planning_id": "e6ad462f-10b8-402e-9b81-38ab712efb5f",
        "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c"
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
      "id": "d737f034-92b1-4cdd-aa3b-2691dc242893",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:18+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "36eae081-e516-4ca1-93c3-1f4032bba11a",
        "planning_id": "e6ad462f-10b8-402e-9b81-38ab712efb5f",
        "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c"
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
      "id": "b5c4354b-32cf-4d62-94fd-514bb456bab9",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:18+00:00",
        "updated_at": "2022-02-14T09:24:18+00:00",
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "6c52d4c3-6b9d-4539-8c57-ec52a1bb2828",
        "planning_id": "e6ad462f-10b8-402e-9b81-38ab712efb5f",
        "order_id": "10ab1162-8e84-4a92-8296-27f0c114cc3c"
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
          "order_id": "b1b56148-4450-4dc7-a7ea-bef813602d4e",
          "items": [
            {
              "type": "bundles",
              "id": "79433242-1111-4652-89fb-2eca4239d0ec",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "49301b84-3a01-42c3-a167-13e5411a5d9a",
                  "id": "93ccab35-fbbb-4e75-a97a-7a6a0202396e"
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
    "id": "f09cbf09-8b99-558d-a2b3-bf612bbbaa7e",
    "type": "order_bookings",
    "attributes": {
      "order_id": "b1b56148-4450-4dc7-a7ea-bef813602d4e"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "b1b56148-4450-4dc7-a7ea-bef813602d4e"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "b23ca282-c672-4458-a43e-2da417ca02ca"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "86a62d9d-25aa-4c3d-b971-fe7ecb5ace68"
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
      "id": "b1b56148-4450-4dc7-a7ea-bef813602d4e",
      "type": "orders",
      "attributes": {
        "created_at": "2022-02-14T09:24:20+00:00",
        "updated_at": "2022-02-14T09:24:21+00:00",
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
        "starts_at": "2022-02-12T09:15:00+00:00",
        "stops_at": "2022-02-16T09:15:00+00:00",
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
        "start_location_id": "3aecc25e-725b-469d-bb4d-8ab78f34ecc9",
        "stop_location_id": "3aecc25e-725b-469d-bb4d-8ab78f34ecc9"
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
      "id": "b23ca282-c672-4458-a43e-2da417ca02ca",
      "type": "lines",
      "attributes": {
        "created_at": "2022-02-14T09:24:21+00:00",
        "updated_at": "2022-02-14T09:24:21+00:00",
        "archived": false,
        "archived_at": null,
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
        "item_id": "79433242-1111-4652-89fb-2eca4239d0ec",
        "tax_category_id": null,
        "planning_id": "86a62d9d-25aa-4c3d-b971-fe7ecb5ace68",
        "parent_line_id": null,
        "owner_id": "b1b56148-4450-4dc7-a7ea-bef813602d4e",
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
      "id": "86a62d9d-25aa-4c3d-b971-fe7ecb5ace68",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-02-14T09:24:21+00:00",
        "updated_at": "2022-02-14T09:24:21+00:00",
        "quantity": 1,
        "starts_at": "2022-02-12T09:15:00+00:00",
        "stops_at": "2022-02-16T09:15:00+00:00",
        "reserved_from": "2022-02-12T09:15:00+00:00",
        "reserved_till": "2022-02-16T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "79433242-1111-4652-89fb-2eca4239d0ec",
        "order_id": "b1b56148-4450-4dc7-a7ea-bef813602d4e",
        "start_location_id": "3aecc25e-725b-469d-bb4d-8ab78f34ecc9",
        "stop_location_id": "3aecc25e-725b-469d-bb4d-8ab78f34ecc9",
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





