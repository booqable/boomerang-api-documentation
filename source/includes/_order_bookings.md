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
          "order_id": "8c77791e-1f81-42ff-b43e-74527f4225b6",
          "items": [
            {
              "type": "products",
              "id": "bc05c88c-e60c-4ccf-95c5-f24d490edfd5",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "83912718-368a-4e39-9413-f6e4b5290183",
              "stock_item_ids": [
                "a4f954b8-ef6c-4b61-9087-8bc6c9e4105e",
                "77b5c8dd-3250-4dcd-8bcf-4a680d5ea4de"
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
            "item_id": "bc05c88c-e60c-4ccf-95c5-f24d490edfd5",
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
          "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
          "items": [
            {
              "type": "products",
              "id": "0c1e54b9-7b4a-49d1-9ee8-50ebf9818b18",
              "stock_item_ids": [
                "964d34b1-b60c-4dd2-9bf9-c014c8903cf7",
                "93db43fd-abde-4d7e-a6c7-3a3c3aea090b",
                "57c2e052-7af7-4448-9903-8a286e4b041f"
              ]
            },
            {
              "type": "products",
              "id": "3f8e9cb6-4bba-4696-8def-71a9b8b61f8f",
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
    "id": "440aa40b-f0f7-5779-8087-089492f73624",
    "type": "order_bookings",
    "attributes": {
      "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "9ec81691-2495-41aa-8e23-127f5f4d6f66"
          },
          {
            "type": "lines",
            "id": "bb36d33a-e736-43cf-9c29-8e0f06b541e6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "e20489d5-608a-4d37-a37c-4463e4b62d02"
          },
          {
            "type": "plannings",
            "id": "14905312-9fae-4b98-9045-893b9b9fa89a"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "021219ae-ae85-4c78-9129-39f7a5d257cc"
          },
          {
            "type": "stock_item_plannings",
            "id": "8f379c43-e43b-4f9c-943e-853db0f73c7d"
          },
          {
            "type": "stock_item_plannings",
            "id": "e6dc4088-8829-4559-b644-7640f2e56ccc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-19T13:59:03+00:00",
        "updated_at": "2022-05-19T13:59:05+00:00",
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
        "customer_id": "d2b7b9ae-68ce-4023-9be0-b643acc3051c",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233",
        "stop_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233"
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
      "id": "9ec81691-2495-41aa-8e23-127f5f4d6f66",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T13:59:03+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
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
        "item_id": "3f8e9cb6-4bba-4696-8def-71a9b8b61f8f",
        "tax_category_id": "17696034-2588-4226-bc25-f08527f21175",
        "planning_id": "e20489d5-608a-4d37-a37c-4463e4b62d02",
        "parent_line_id": null,
        "owner_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
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
      "id": "bb36d33a-e736-43cf-9c29-8e0f06b541e6",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T13:59:04+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
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
        "item_id": "0c1e54b9-7b4a-49d1-9ee8-50ebf9818b18",
        "tax_category_id": "17696034-2588-4226-bc25-f08527f21175",
        "planning_id": "14905312-9fae-4b98-9045-893b9b9fa89a",
        "parent_line_id": null,
        "owner_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
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
      "id": "e20489d5-608a-4d37-a37c-4463e4b62d02",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:03+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
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
        "item_id": "3f8e9cb6-4bba-4696-8def-71a9b8b61f8f",
        "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
        "start_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233",
        "stop_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233",
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
      "id": "14905312-9fae-4b98-9045-893b9b9fa89a",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:04+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
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
        "item_id": "0c1e54b9-7b4a-49d1-9ee8-50ebf9818b18",
        "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f",
        "start_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233",
        "stop_location_id": "0962e008-bdb8-48d2-afef-f79b9b55f233",
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
      "id": "021219ae-ae85-4c78-9129-39f7a5d257cc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:04+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "964d34b1-b60c-4dd2-9bf9-c014c8903cf7",
        "planning_id": "14905312-9fae-4b98-9045-893b9b9fa89a",
        "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f"
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
      "id": "8f379c43-e43b-4f9c-943e-853db0f73c7d",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:04+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "93db43fd-abde-4d7e-a6c7-3a3c3aea090b",
        "planning_id": "14905312-9fae-4b98-9045-893b9b9fa89a",
        "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f"
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
      "id": "e6dc4088-8829-4559-b644-7640f2e56ccc",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:04+00:00",
        "updated_at": "2022-05-19T13:59:04+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "57c2e052-7af7-4448-9903-8a286e4b041f",
        "planning_id": "14905312-9fae-4b98-9045-893b9b9fa89a",
        "order_id": "c72c1b2f-8414-469b-a2b8-07dd9aeee18f"
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
          "order_id": "e530ba8a-4114-48b9-9542-666de2f73447",
          "items": [
            {
              "type": "bundles",
              "id": "bdc33524-0cc3-4ef8-9c1a-132f8aa7690f",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "49167119-c3da-435d-a994-8df430c4ad93",
                  "id": "dc9acabd-10ca-4976-a24c-b21880977485"
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
    "id": "50f66467-6d39-509e-870d-3457e43c3431",
    "type": "order_bookings",
    "attributes": {
      "order_id": "e530ba8a-4114-48b9-9542-666de2f73447"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "e530ba8a-4114-48b9-9542-666de2f73447"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "6a62b162-ff77-4436-82a6-a274bb235298"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "a2a86521-5a38-4252-a193-ed6798b5f776"
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
      "id": "e530ba8a-4114-48b9-9542-666de2f73447",
      "type": "orders",
      "attributes": {
        "created_at": "2022-05-19T13:59:07+00:00",
        "updated_at": "2022-05-19T13:59:08+00:00",
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
        "starts_at": "2022-05-17T13:45:00+00:00",
        "stops_at": "2022-05-21T13:45:00+00:00",
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
        "start_location_id": "ed12e92a-e918-4561-aa96-396ff038201a",
        "stop_location_id": "ed12e92a-e918-4561-aa96-396ff038201a"
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
      "id": "6a62b162-ff77-4436-82a6-a274bb235298",
      "type": "lines",
      "attributes": {
        "created_at": "2022-05-19T13:59:07+00:00",
        "updated_at": "2022-05-19T13:59:07+00:00",
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
        "item_id": "bdc33524-0cc3-4ef8-9c1a-132f8aa7690f",
        "tax_category_id": null,
        "planning_id": "a2a86521-5a38-4252-a193-ed6798b5f776",
        "parent_line_id": null,
        "owner_id": "e530ba8a-4114-48b9-9542-666de2f73447",
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
      "id": "a2a86521-5a38-4252-a193-ed6798b5f776",
      "type": "plannings",
      "attributes": {
        "created_at": "2022-05-19T13:59:07+00:00",
        "updated_at": "2022-05-19T13:59:07+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2022-05-17T13:45:00+00:00",
        "stops_at": "2022-05-21T13:45:00+00:00",
        "reserved_from": "2022-05-17T13:45:00+00:00",
        "reserved_till": "2022-05-21T13:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "bdc33524-0cc3-4ef8-9c1a-132f8aa7690f",
        "order_id": "e530ba8a-4114-48b9-9542-666de2f73447",
        "start_location_id": "ed12e92a-e918-4561-aa96-396ff038201a",
        "stop_location_id": "ed12e92a-e918-4561-aa96-396ff038201a",
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





