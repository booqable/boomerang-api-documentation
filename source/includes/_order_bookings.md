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
          "order_id": "8ad2af80-ab89-4b7a-8b2a-c4e7225d1292",
          "items": [
            {
              "type": "products",
              "id": "657c6bd0-f113-4ad7-a575-60e99304638e",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "4f62e118-782a-4200-bdf5-27d7284e2dbd",
              "stock_item_ids": [
                "e096c5b3-c9b0-43b7-b3bb-43341a924ca6",
                "9e5368c6-eeac-4f03-86b2-61d2f5ef6978"
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
          "stock_item_id e096c5b3-c9b0-43b7-b3bb-43341a924ca6 has already been booked on this order"
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
          "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
          "items": [
            {
              "type": "products",
              "id": "013969de-5a14-4b8c-ad89-59933e2b0b62",
              "stock_item_ids": [
                "0c65305f-dbc4-401d-8414-b899ddcbb1b0",
                "3b38d1f6-6e65-4fd1-87e7-66960a0b8307",
                "b963453f-f1e8-416f-b1d3-0d91f861e8a2"
              ]
            },
            {
              "type": "products",
              "id": "ec5cb222-1960-4134-86d6-a42a53a9ff9f",
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
    "id": "3fbc61ac-c528-50e2-a043-ff7ae64a14ce",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "a94c617f-8b67-4484-a357-91a6f9721482"
          },
          {
            "type": "lines",
            "id": "a03f3e84-6a11-4e17-b736-df2846443491"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7"
          },
          {
            "type": "plannings",
            "id": "3d0a9025-f1f1-402a-b5a6-068eab9e2e78"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "589dfb79-a3fb-464d-a3ac-1a1b0c49b4cb"
          },
          {
            "type": "stock_item_plannings",
            "id": "a4d9011e-fe15-4026-a87d-782986fd2a98"
          },
          {
            "type": "stock_item_plannings",
            "id": "ea4bba4e-edae-43af-9116-b9b757333bc2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T10:28:38+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
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
        "customer_id": "067b9dc2-656c-4abb-8621-c3ff450f905b",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754",
        "stop_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754"
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
      "id": "a94c617f-8b67-4484-a357-91a6f9721482",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
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
        "item_id": "013969de-5a14-4b8c-ad89-59933e2b0b62",
        "tax_category_id": "4b04bbce-6f5e-4fbe-bb37-489b98cadcee",
        "planning_id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7",
        "parent_line_id": null,
        "owner_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
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
      "id": "a03f3e84-6a11-4e17-b736-df2846443491",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
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
        "item_id": "ec5cb222-1960-4134-86d6-a42a53a9ff9f",
        "tax_category_id": "4b04bbce-6f5e-4fbe-bb37-489b98cadcee",
        "planning_id": "3d0a9025-f1f1-402a-b5a6-068eab9e2e78",
        "parent_line_id": null,
        "owner_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
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
      "id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
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
        "item_id": "013969de-5a14-4b8c-ad89-59933e2b0b62",
        "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
        "start_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754",
        "stop_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754",
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
      "id": "3d0a9025-f1f1-402a-b5a6-068eab9e2e78",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
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
        "item_id": "ec5cb222-1960-4134-86d6-a42a53a9ff9f",
        "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7",
        "start_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754",
        "stop_location_id": "e2dfe080-b822-465c-acd4-5b66a2e69754",
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
      "id": "589dfb79-a3fb-464d-a3ac-1a1b0c49b4cb",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0c65305f-dbc4-401d-8414-b899ddcbb1b0",
        "planning_id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7",
        "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7"
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
      "id": "a4d9011e-fe15-4026-a87d-782986fd2a98",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "3b38d1f6-6e65-4fd1-87e7-66960a0b8307",
        "planning_id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7",
        "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7"
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
      "id": "ea4bba4e-edae-43af-9116-b9b757333bc2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:40+00:00",
        "updated_at": "2023-03-09T10:28:40+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "b963453f-f1e8-416f-b1d3-0d91f861e8a2",
        "planning_id": "be37acfb-4837-4c82-bd98-1dc2e8f322e7",
        "order_id": "8cb0fbea-4a8a-4a85-9c8c-ea9db9a812d7"
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
          "order_id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d",
          "items": [
            {
              "type": "bundles",
              "id": "ceb8e3ce-77c2-427e-9926-02eac13a9d96",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "1b35fdfe-bf53-4406-942b-f9564f42d23e",
                  "id": "92eadfa4-69ce-4d46-b5bb-05f5efab711a"
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
    "id": "4f0e3987-431e-5cc1-ab41-7ee7a9cc9c84",
    "type": "order_bookings",
    "attributes": {
      "order_id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "e7472643-58cb-4df6-9c24-863966579378"
          },
          {
            "type": "lines",
            "id": "735e7f1f-c574-4278-aaa8-648200e35fad"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e9e3af81-ae73-466d-8787-e8850d7c5d9c"
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
      "id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-03-09T10:28:43+00:00",
        "updated_at": "2023-03-09T10:28:43+00:00",
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
        "starts_at": "2023-03-07T10:15:00+00:00",
        "stops_at": "2023-03-11T10:15:00+00:00",
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
        "start_location_id": "b0144bdc-6c6e-40ef-a815-d3d19cdb6e8b",
        "stop_location_id": "b0144bdc-6c6e-40ef-a815-d3d19cdb6e8b"
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
      "id": "e7472643-58cb-4df6-9c24-863966579378",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T10:28:43+00:00",
        "updated_at": "2023-03-09T10:28:43+00:00",
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
        "item_id": "92eadfa4-69ce-4d46-b5bb-05f5efab711a",
        "tax_category_id": null,
        "planning_id": "475232bd-32c8-48d1-a386-c21a661f5483",
        "parent_line_id": "735e7f1f-c574-4278-aaa8-648200e35fad",
        "owner_id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d",
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
      "id": "735e7f1f-c574-4278-aaa8-648200e35fad",
      "type": "lines",
      "attributes": {
        "created_at": "2023-03-09T10:28:43+00:00",
        "updated_at": "2023-03-09T10:28:43+00:00",
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
        "item_id": "ceb8e3ce-77c2-427e-9926-02eac13a9d96",
        "tax_category_id": null,
        "planning_id": "e9e3af81-ae73-466d-8787-e8850d7c5d9c",
        "parent_line_id": null,
        "owner_id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d",
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
      "id": "e9e3af81-ae73-466d-8787-e8850d7c5d9c",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-03-09T10:28:43+00:00",
        "updated_at": "2023-03-09T10:28:43+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-03-07T10:15:00+00:00",
        "stops_at": "2023-03-11T10:15:00+00:00",
        "reserved_from": "2023-03-07T10:15:00+00:00",
        "reserved_till": "2023-03-11T10:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "ceb8e3ce-77c2-427e-9926-02eac13a9d96",
        "order_id": "9fb4c2ed-c25d-4f90-8b33-378b66f6482d",
        "start_location_id": "b0144bdc-6c6e-40ef-a815-d3d19cdb6e8b",
        "stop_location_id": "b0144bdc-6c6e-40ef-a815-d3d19cdb6e8b",
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





