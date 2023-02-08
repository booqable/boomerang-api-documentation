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
          "order_id": "829a0b12-dacb-41d2-bf68-cc95badd3d1c",
          "items": [
            {
              "type": "products",
              "id": "22921595-8a49-498a-81d7-bf4a85291bda",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "2d387dbc-c570-46f1-8591-60ae29f0b124",
              "stock_item_ids": [
                "88f17bea-35ae-4376-bcf9-ba647ba4282d",
                "22bf9cf8-01a2-435f-9827-a423f0e1449b"
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
            "item_id": "22921595-8a49-498a-81d7-bf4a85291bda",
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
          "order_id": "8af46eab-e936-428a-b90e-335ce30471fc",
          "items": [
            {
              "type": "products",
              "id": "eb40ca51-50e8-4e67-b581-79e9a6f6bd3c",
              "stock_item_ids": [
                "cdf5650d-957c-4a30-8c76-80bea1e252a8",
                "a7909050-b0c1-4b6b-97b3-d9ee523f6ded",
                "49f9a335-a62e-41e1-a0d8-5f236092dd4a"
              ]
            },
            {
              "type": "products",
              "id": "bf4c6467-9db1-4b18-ba73-bf98f2bffde7",
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
    "id": "bbf83de9-03fd-559f-9057-62bbc3113a28",
    "type": "order_bookings",
    "attributes": {
      "order_id": "8af46eab-e936-428a-b90e-335ce30471fc"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "8af46eab-e936-428a-b90e-335ce30471fc"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "cfcbb0bf-c485-423d-9677-33e9dac12edc"
          },
          {
            "type": "lines",
            "id": "25574fa5-7e7c-48b9-9467-b7da5841e31a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "14c7bc18-188e-4b0a-95f4-c61c940f1615"
          },
          {
            "type": "plannings",
            "id": "a36f78ee-d4f8-4037-b1b6-fff6e2e5c42e"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "110bf672-55ac-4c82-8b90-65db7b5471e6"
          },
          {
            "type": "stock_item_plannings",
            "id": "7941407e-108c-4a86-8860-84f14c8e1766"
          },
          {
            "type": "stock_item_plannings",
            "id": "71ad8eef-03e5-471f-8f36-9c9cf6a222b4"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8af46eab-e936-428a-b90e-335ce30471fc",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T09:46:11+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
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
        "customer_id": "e8e4058d-febe-401b-bf26-03703e6c0742",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752",
        "stop_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752"
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
      "id": "cfcbb0bf-c485-423d-9677-33e9dac12edc",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
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
        "item_id": "eb40ca51-50e8-4e67-b581-79e9a6f6bd3c",
        "tax_category_id": "f3c0042b-c7ca-453e-80f0-446180f78bb9",
        "planning_id": "14c7bc18-188e-4b0a-95f4-c61c940f1615",
        "parent_line_id": null,
        "owner_id": "8af46eab-e936-428a-b90e-335ce30471fc",
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
      "id": "25574fa5-7e7c-48b9-9467-b7da5841e31a",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
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
        "item_id": "bf4c6467-9db1-4b18-ba73-bf98f2bffde7",
        "tax_category_id": "f3c0042b-c7ca-453e-80f0-446180f78bb9",
        "planning_id": "a36f78ee-d4f8-4037-b1b6-fff6e2e5c42e",
        "parent_line_id": null,
        "owner_id": "8af46eab-e936-428a-b90e-335ce30471fc",
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
      "id": "14c7bc18-188e-4b0a-95f4-c61c940f1615",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
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
        "item_id": "eb40ca51-50e8-4e67-b581-79e9a6f6bd3c",
        "order_id": "8af46eab-e936-428a-b90e-335ce30471fc",
        "start_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752",
        "stop_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752",
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
      "id": "a36f78ee-d4f8-4037-b1b6-fff6e2e5c42e",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
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
        "item_id": "bf4c6467-9db1-4b18-ba73-bf98f2bffde7",
        "order_id": "8af46eab-e936-428a-b90e-335ce30471fc",
        "start_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752",
        "stop_location_id": "89bf6172-a39a-4fca-8a86-ff9e0ae82752",
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
      "id": "110bf672-55ac-4c82-8b90-65db7b5471e6",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "cdf5650d-957c-4a30-8c76-80bea1e252a8",
        "planning_id": "14c7bc18-188e-4b0a-95f4-c61c940f1615",
        "order_id": "8af46eab-e936-428a-b90e-335ce30471fc"
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
      "id": "7941407e-108c-4a86-8860-84f14c8e1766",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a7909050-b0c1-4b6b-97b3-d9ee523f6ded",
        "planning_id": "14c7bc18-188e-4b0a-95f4-c61c940f1615",
        "order_id": "8af46eab-e936-428a-b90e-335ce30471fc"
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
      "id": "71ad8eef-03e5-471f-8f36-9c9cf6a222b4",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:13+00:00",
        "updated_at": "2023-02-08T09:46:13+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "49f9a335-a62e-41e1-a0d8-5f236092dd4a",
        "planning_id": "14c7bc18-188e-4b0a-95f4-c61c940f1615",
        "order_id": "8af46eab-e936-428a-b90e-335ce30471fc"
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
          "order_id": "3c51940f-b14d-4a09-ae4d-0537c217579d",
          "items": [
            {
              "type": "bundles",
              "id": "72b7b1cb-0808-491d-9f66-55b4b918fe47",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "af6c8f7c-d7f1-4f79-ba7d-5abbdddbbd6d",
                  "id": "83b99faf-bb61-4d3f-a876-79bc30a64757"
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
    "id": "1d2823fe-715f-5967-9d3c-c214c5bfbaff",
    "type": "order_bookings",
    "attributes": {
      "order_id": "3c51940f-b14d-4a09-ae4d-0537c217579d"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "3c51940f-b14d-4a09-ae4d-0537c217579d"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "437681a1-bd90-4a5f-ade0-4a249a98a167"
          },
          {
            "type": "lines",
            "id": "aed6896c-6fee-4d9b-b9a1-36f562290963"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9aab494f-1cbb-477a-acb2-51239af8b647"
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
      "id": "3c51940f-b14d-4a09-ae4d-0537c217579d",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-08T09:46:15+00:00",
        "updated_at": "2023-02-08T09:46:16+00:00",
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
        "starts_at": "2023-02-06T09:45:00+00:00",
        "stops_at": "2023-02-10T09:45:00+00:00",
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
        "start_location_id": "2f2017dc-9bff-4645-b6e0-546f29ba2de7",
        "stop_location_id": "2f2017dc-9bff-4645-b6e0-546f29ba2de7"
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
      "id": "437681a1-bd90-4a5f-ade0-4a249a98a167",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:46:16+00:00",
        "updated_at": "2023-02-08T09:46:16+00:00",
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
        "item_id": "83b99faf-bb61-4d3f-a876-79bc30a64757",
        "tax_category_id": null,
        "planning_id": "4fc7acbd-606e-4004-93f4-6f2b99adea73",
        "parent_line_id": "aed6896c-6fee-4d9b-b9a1-36f562290963",
        "owner_id": "3c51940f-b14d-4a09-ae4d-0537c217579d",
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
      "id": "aed6896c-6fee-4d9b-b9a1-36f562290963",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-08T09:46:16+00:00",
        "updated_at": "2023-02-08T09:46:16+00:00",
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
        "item_id": "72b7b1cb-0808-491d-9f66-55b4b918fe47",
        "tax_category_id": null,
        "planning_id": "9aab494f-1cbb-477a-acb2-51239af8b647",
        "parent_line_id": null,
        "owner_id": "3c51940f-b14d-4a09-ae4d-0537c217579d",
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
      "id": "9aab494f-1cbb-477a-acb2-51239af8b647",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-08T09:46:16+00:00",
        "updated_at": "2023-02-08T09:46:16+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-06T09:45:00+00:00",
        "stops_at": "2023-02-10T09:45:00+00:00",
        "reserved_from": "2023-02-06T09:45:00+00:00",
        "reserved_till": "2023-02-10T09:45:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "72b7b1cb-0808-491d-9f66-55b4b918fe47",
        "order_id": "3c51940f-b14d-4a09-ae4d-0537c217579d",
        "start_location_id": "2f2017dc-9bff-4645-b6e0-546f29ba2de7",
        "stop_location_id": "2f2017dc-9bff-4645-b6e0-546f29ba2de7",
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





