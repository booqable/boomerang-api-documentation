# Order bookings

<aside class="warning">
<b>DEPRECATED:</b> Replacement: Submit <code>book_</code> actions to the OrderFulfillmentAPI.
</aside>

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

> Adding a bundle without specifying variations:

```json
  "items": [
    {
      "type": "bundles",
      "id": "9bf34d16-2144-45a5-8461-ebae7bf0f4ca",
      "quantity": 3,
      "products": []  // Nothing to choose for the customer
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
-- | --
`id` | **Uuid** <br>
`items` | **Array** `writeonly`<br>Array with details about the items (and stock item) to add to the order
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage if they are non-blocking
`order_id` | **Uuid** <br>The associated Order


## Relationships
Order bookings have the following relationships:

Name | Description
-- | --
`order` | **Orders** `readonly`<br>Associated Order
`lines` | **Lines** `readonly`<br>Associated Lines
`plannings` | **Plannings** `readonly`<br>Associated Plannings
`stock_item_plannings` | **Stock item plannings** `readonly`<br>Associated Stock item plannings


## Creating an order booking



> How to add a bundle with unspecified variation to an order:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
          "items": [
            {
              "type": "bundles",
              "id": "6efa0072-4b7c-4a06-b20e-accf23255181",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "2d760f36-c002-4774-b1c3-8ebf8f91ba60",
                  "id": "c74efc2c-9bb9-4e97-a8c5-f8248fd40d8e"
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
    "id": "dea551dd-d106-5682-b25b-0957eb266679",
    "type": "order_bookings",
    "attributes": {
      "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "45ca56d2-0865-492c-a29d-ca8eb1e65ec5"
          },
          {
            "type": "lines",
            "id": "c95b98a9-baa0-4361-8d84-c98fb353f0b4"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "c42af4e7-aed5-4c05-a704-85707a78d96f"
          },
          {
            "type": "plannings",
            "id": "f999a5b0-80a8-40fe-9a97-837a6138ba19"
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
      "id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-06T09:24:33+00:00",
        "updated_at": "2024-05-06T09:24:33+00:00",
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
        "starts_at": "2024-05-04T09:15:00+00:00",
        "stops_at": "2024-05-08T09:15:00+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "paid",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 0.0,
        "customer_id": null,
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150",
        "stop_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150"
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
        "transfers": {
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
      "id": "45ca56d2-0865-492c-a29d-ca8eb1e65ec5",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-06T09:24:33+00:00",
        "updated_at": "2024-05-06T09:24:33+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Bundle 4",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": null,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "item_id": "6efa0072-4b7c-4a06-b20e-accf23255181",
        "tax_category_id": null,
        "planning_id": "c42af4e7-aed5-4c05-a704-85707a78d96f",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "c95b98a9-baa0-4361-8d84-c98fb353f0b4",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-06T09:24:33+00:00",
        "updated_at": "2024-05-06T09:24:33+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Product 1000032 - red",
        "extra_information": null,
        "quantity": 1,
        "original_price_each_in_cents": 0,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "display_price_in_cents": 0,
        "position": 1,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "item_id": "c74efc2c-9bb9-4e97-a8c5-f8248fd40d8e",
        "tax_category_id": null,
        "planning_id": "f999a5b0-80a8-40fe-9a97-837a6138ba19",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": "45ca56d2-0865-492c-a29d-ca8eb1e65ec5",
        "owner_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "c42af4e7-aed5-4c05-a704-85707a78d96f",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:33+00:00",
        "updated_at": "2024-05-06T09:24:33+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-04T09:15:00+00:00",
        "stops_at": "2024-05-08T09:15:00+00:00",
        "reserved_from": "2024-05-04T09:15:00+00:00",
        "reserved_till": "2024-05-08T09:15:00+00:00",
        "reserved": false,
        "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "item_id": "6efa0072-4b7c-4a06-b20e-accf23255181",
        "start_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150",
        "stop_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "f999a5b0-80a8-40fe-9a97-837a6138ba19",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:33+00:00",
        "updated_at": "2024-05-06T09:24:33+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2024-05-04T09:15:00+00:00",
        "stops_at": "2024-05-08T09:15:00+00:00",
        "reserved_from": "2024-05-04T09:15:00+00:00",
        "reserved_till": "2024-05-08T09:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "order_id": "20a60780-0c23-4065-bbe1-fe1bdbc5a56f",
        "item_id": "c74efc2c-9bb9-4e97-a8c5-f8248fd40d8e",
        "start_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150",
        "stop_location_id": "9e047dce-6d67-43f7-913d-61e50b4d9150",
        "parent_planning_id": "c42af4e7-aed5-4c05-a704-85707a78d96f",
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
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


> Adding products to an order resulting in a shortage:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "a0b5c136-2b39-4a06-bb9f-42bbce66400d",
          "items": [
            {
              "type": "products",
              "id": "2ab5618d-5cff-4806-b7ba-1cc6d5c86687",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "eac55367-5df5-4ab4-bf44-b394f0700e12",
              "stock_item_ids": [
                "ae2a18f1-ff01-4580-8a36-28fc18143143",
                "b42748a1-768d-4210-99a8-b493c0b868ef"
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
      "code": "fulfillment_request_invalid",
      "status": "422",
      "title": "Fulfillment request invalid",
      "detail": "invalid request",
      "meta": {
        "messages": [
          "stock_item_id ae2a18f1-ff01-4580-8a36-28fc18143143 has already been booked on this order"
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
          "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
          "items": [
            {
              "type": "products",
              "id": "6effaa6f-1b21-449e-9709-3f9f467fe80b",
              "stock_item_ids": [
                "3b5abcdc-9bd8-474e-b5d9-6549f4c683fe",
                "0ae5a60c-8f70-4970-8ea0-df37c66e3b81",
                "37875254-a09d-46e8-a29b-89cccb3a4d64"
              ]
            },
            {
              "type": "products",
              "id": "8adaa0c1-617d-4d4d-aaac-8b24176b2786",
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
    "id": "6a4b82fc-c598-5153-b878-71a23fab1fbb",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6d644925-c36f-4e6f-a1f0-680d2c0732da"
          },
          {
            "type": "lines",
            "id": "30bff294-669c-4b82-90f5-0a240be05972"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e55a3262-482d-48ea-a6fb-9483473aea19"
          },
          {
            "type": "plannings",
            "id": "86c0bc7b-a30b-42da-9570-73855d4cb224"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "730ae285-f329-4ad8-a8e6-c104bcce4cf4"
          },
          {
            "type": "stock_item_plannings",
            "id": "27aa0e2a-a01d-4e62-be83-238e08c62987"
          },
          {
            "type": "stock_item_plannings",
            "id": "25d0d90c-1f65-44a3-808a-6780c5e864e1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
      "type": "orders",
      "attributes": {
        "created_at": "2024-05-06T09:24:37+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
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
        "deposit_value": 10.0,
        "entirely_started": false,
        "entirely_stopped": false,
        "location_shortage": false,
        "shortage": false,
        "payment_status": "payment_due",
        "override_period_restrictions": false,
        "has_signed_contract": false,
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
        "discount_type": "percentage",
        "discount_percentage": 10.0,
        "customer_id": "5e74aa97-b759-46d8-a2ed-635841eb6098",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a",
        "stop_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a"
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
        "transfers": {
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
      "id": "6d644925-c36f-4e6f-a1f0-680d2c0732da",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "title": "iPad Pro",
        "extra_information": "Comes with a case",
        "quantity": 3,
        "original_price_each_in_cents": 29000,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 32100,
        "price_in_cents": 96300,
        "display_price_in_cents": 96300,
        "position": 2,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 3100,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "item_id": "6effaa6f-1b21-449e-9709-3f9f467fe80b",
        "tax_category_id": "bbc52de1-ef08-45c1-94c2-5dbd92c5c257",
        "planning_id": "e55a3262-482d-48ea-a6fb-9483473aea19",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "30bff294-669c-4b82-90f5-0a240be05972",
      "type": "lines",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "title": "Macbook Pro",
        "extra_information": "Comes with a mouse",
        "quantity": 1,
        "original_price_each_in_cents": 72500,
        "original_charge_length": null,
        "original_charge_label": null,
        "price_each_in_cents": 80250,
        "price_in_cents": 80250,
        "display_price_in_cents": 80250,
        "position": 3,
        "charge_label": "29 days",
        "charge_length": 2505600,
        "price_rule_values": {
          "charge": {
            "from": "1980-04-02T00:00:00.000Z",
            "till": "1980-05-01T00:00:00.000Z",
            "adjustments": [
              {
                "name": "Pickup day"
              },
              {
                "name": "Return day"
              }
            ]
          },
          "price": [
            {
              "name": "High-Season",
              "charge_length": 1339200,
              "multiplier": "0.2",
              "price_in_cents": 7750,
              "adjustments": [
                {
                  "from": "1980-04-15T12:00:00.000Z",
                  "till": "1980-05-01T00:00:00.000Z",
                  "charge_length": 1339200,
                  "charge_label": "372 hours",
                  "price_in_cents": 3100
                }
              ],
              "stacked": false
            }
          ]
        },
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "item_id": "8adaa0c1-617d-4d4d-aaac-8b24176b2786",
        "tax_category_id": "bbc52de1-ef08-45c1-94c2-5dbd92c5c257",
        "planning_id": "86c0bc7b-a30b-42da-9570-73855d4cb224",
        "price_structure_id": null,
        "price_tile_id": null,
        "parent_line_id": null,
        "owner_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "owner_type": "orders"
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
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
        "price_structure": {
          "meta": {
            "included": false
          }
        },
        "price_tile": {
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
      "id": "e55a3262-482d-48ea-a6fb-9483473aea19",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
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
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "item_id": "6effaa6f-1b21-449e-9709-3f9f467fe80b",
        "start_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a",
        "stop_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "86c0bc7b-a30b-42da-9570-73855d4cb224",
      "type": "plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
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
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9",
        "item_id": "8adaa0c1-617d-4d4d-aaac-8b24176b2786",
        "start_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a",
        "stop_location_id": "2fe06b5f-8ff5-4989-b1e0-f419a0480c8a",
        "parent_planning_id": null,
        "price_tile_id": null
      },
      "relationships": {
        "order": {
          "meta": {
            "included": false
          }
        },
        "item": {
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
        },
        "price_tile": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "730ae285-f329-4ad8-a8e6-c104bcce4cf4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b5abcdc-9bd8-474e-b5d9-6549f4c683fe",
        "planning_id": "e55a3262-482d-48ea-a6fb-9483473aea19",
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9"
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
      "id": "27aa0e2a-a01d-4e62-be83-238e08c62987",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0ae5a60c-8f70-4970-8ea0-df37c66e3b81",
        "planning_id": "e55a3262-482d-48ea-a6fb-9483473aea19",
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9"
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
      "id": "25d0d90c-1f65-44a3-808a-6780c5e864e1",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2024-05-06T09:24:39+00:00",
        "updated_at": "2024-05-06T09:24:39+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "37875254-a09d-46e8-a29b-89cccb3a4d64",
        "planning_id": "e55a3262-482d-48ea-a6fb-9483473aea19",
        "order_id": "8f2eb858-130f-4c62-b6e7-b9e8e4a233b9"
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

### HTTP Request

`POST /api/boomerang/order_bookings`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=order,lines,plannings`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[order_bookings]=order_id`


### Request body

This request accepts the following body:

Name | Description
-- | --
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





