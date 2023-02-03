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
          "order_id": "16b76bc6-6427-4c8c-929b-8621011cf214",
          "items": [
            {
              "type": "products",
              "id": "b3209eb1-65b2-4975-b8cb-794bb72ee9dd",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "b7136e6f-826b-4a3b-92f9-9f26db591ad7",
              "stock_item_ids": [
                "535bb94c-1af9-4b6e-96ff-8dc44690606a",
                "1e3bf610-d03f-4537-a475-28dcfe8667fc"
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
            "item_id": "b3209eb1-65b2-4975-b8cb-794bb72ee9dd",
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
          "order_id": "92f93331-739a-458c-ba66-7254cdf86597",
          "items": [
            {
              "type": "products",
              "id": "eb437bed-ab40-48f3-8d26-4c5c39ac5c39",
              "stock_item_ids": [
                "a4573cf5-1952-49bc-beca-5711db65647c",
                "fe751a70-7374-400c-846b-a0421670adcf",
                "073c6986-b5b2-4252-ad13-b260cfcbe869"
              ]
            },
            {
              "type": "products",
              "id": "ab126fcc-e649-4642-b594-87c18ca3c2df",
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
    "id": "c80e7963-3e8a-5004-a6fb-cb75808163ba",
    "type": "order_bookings",
    "attributes": {
      "order_id": "92f93331-739a-458c-ba66-7254cdf86597"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "92f93331-739a-458c-ba66-7254cdf86597"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "3eb2f219-9318-4ffc-b3e3-11bc719b2772"
          },
          {
            "type": "lines",
            "id": "6599c8bf-3c30-4cf4-9e78-fe2db7054aa6"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6"
          },
          {
            "type": "plannings",
            "id": "753540f1-cf99-4e8c-80ec-a47463c7c394"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "632d7238-1943-4495-a630-52ea0e8542e5"
          },
          {
            "type": "stock_item_plannings",
            "id": "46503509-0cf0-4bcf-9422-78c23b965822"
          },
          {
            "type": "stock_item_plannings",
            "id": "3dbd1956-767c-4fa4-9b61-c4830617eb27"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "92f93331-739a-458c-ba66-7254cdf86597",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T11:10:58+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
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
        "customer_id": "017ecda2-8de7-427a-b6b0-9aabde11e3d2",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a",
        "stop_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a"
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
      "id": "3eb2f219-9318-4ffc-b3e3-11bc719b2772",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
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
        "item_id": "eb437bed-ab40-48f3-8d26-4c5c39ac5c39",
        "tax_category_id": "520790b6-865e-455f-995c-1238717d5812",
        "planning_id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6",
        "parent_line_id": null,
        "owner_id": "92f93331-739a-458c-ba66-7254cdf86597",
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
      "id": "6599c8bf-3c30-4cf4-9e78-fe2db7054aa6",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
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
        "item_id": "ab126fcc-e649-4642-b594-87c18ca3c2df",
        "tax_category_id": "520790b6-865e-455f-995c-1238717d5812",
        "planning_id": "753540f1-cf99-4e8c-80ec-a47463c7c394",
        "parent_line_id": null,
        "owner_id": "92f93331-739a-458c-ba66-7254cdf86597",
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
      "id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
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
        "item_id": "eb437bed-ab40-48f3-8d26-4c5c39ac5c39",
        "order_id": "92f93331-739a-458c-ba66-7254cdf86597",
        "start_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a",
        "stop_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a",
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
      "id": "753540f1-cf99-4e8c-80ec-a47463c7c394",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
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
        "item_id": "ab126fcc-e649-4642-b594-87c18ca3c2df",
        "order_id": "92f93331-739a-458c-ba66-7254cdf86597",
        "start_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a",
        "stop_location_id": "fbb54876-c5b6-4f7d-b9ed-337f0572f31a",
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
      "id": "632d7238-1943-4495-a630-52ea0e8542e5",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "a4573cf5-1952-49bc-beca-5711db65647c",
        "planning_id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6",
        "order_id": "92f93331-739a-458c-ba66-7254cdf86597"
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
      "id": "46503509-0cf0-4bcf-9422-78c23b965822",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "fe751a70-7374-400c-846b-a0421670adcf",
        "planning_id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6",
        "order_id": "92f93331-739a-458c-ba66-7254cdf86597"
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
      "id": "3dbd1956-767c-4fa4-9b61-c4830617eb27",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-03T11:10:59+00:00",
        "updated_at": "2023-02-03T11:10:59+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "073c6986-b5b2-4252-ad13-b260cfcbe869",
        "planning_id": "1435d0f6-c2c9-46c9-a70f-3c0e4d98dfe6",
        "order_id": "92f93331-739a-458c-ba66-7254cdf86597"
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
          "order_id": "36d535d4-703c-4828-aea1-a31bb1ec46be",
          "items": [
            {
              "type": "bundles",
              "id": "385f3859-52ff-4983-932b-0f11fa8330a1",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "969b6e21-f769-4f19-b7f2-009168d01192",
                  "id": "c13ef380-12fa-4c64-9f57-200aa07603f1"
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
    "id": "7a5d0794-aa20-52dc-b260-c04d6f9ad59b",
    "type": "order_bookings",
    "attributes": {
      "order_id": "36d535d4-703c-4828-aea1-a31bb1ec46be"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "36d535d4-703c-4828-aea1-a31bb1ec46be"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "fb7f4982-cfd0-431e-a92b-b9d5910c7bf8"
          },
          {
            "type": "lines",
            "id": "b6248042-3381-4570-9c3a-bf70f48880c9"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "2bcdf6c0-ad99-4eac-b8fd-76cad1741a19"
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
      "id": "36d535d4-703c-4828-aea1-a31bb1ec46be",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-03T11:11:01+00:00",
        "updated_at": "2023-02-03T11:11:02+00:00",
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
        "starts_at": "2023-02-01T11:00:00+00:00",
        "stops_at": "2023-02-05T11:00:00+00:00",
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
        "start_location_id": "e904a705-4e0c-429a-88a1-5b09371b37f1",
        "stop_location_id": "e904a705-4e0c-429a-88a1-5b09371b37f1"
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
      "id": "fb7f4982-cfd0-431e-a92b-b9d5910c7bf8",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:01+00:00",
        "updated_at": "2023-02-03T11:11:02+00:00",
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
        "item_id": "385f3859-52ff-4983-932b-0f11fa8330a1",
        "tax_category_id": null,
        "planning_id": "2bcdf6c0-ad99-4eac-b8fd-76cad1741a19",
        "parent_line_id": null,
        "owner_id": "36d535d4-703c-4828-aea1-a31bb1ec46be",
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
      "id": "b6248042-3381-4570-9c3a-bf70f48880c9",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-03T11:11:01+00:00",
        "updated_at": "2023-02-03T11:11:02+00:00",
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
        "item_id": "c13ef380-12fa-4c64-9f57-200aa07603f1",
        "tax_category_id": null,
        "planning_id": "eb42df97-bd92-438d-965a-630cac17efb6",
        "parent_line_id": "fb7f4982-cfd0-431e-a92b-b9d5910c7bf8",
        "owner_id": "36d535d4-703c-4828-aea1-a31bb1ec46be",
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
      "id": "2bcdf6c0-ad99-4eac-b8fd-76cad1741a19",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-03T11:11:01+00:00",
        "updated_at": "2023-02-03T11:11:01+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-01T11:00:00+00:00",
        "stops_at": "2023-02-05T11:00:00+00:00",
        "reserved_from": "2023-02-01T11:00:00+00:00",
        "reserved_till": "2023-02-05T11:00:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "385f3859-52ff-4983-932b-0f11fa8330a1",
        "order_id": "36d535d4-703c-4828-aea1-a31bb1ec46be",
        "start_location_id": "e904a705-4e0c-429a-88a1-5b09371b37f1",
        "stop_location_id": "e904a705-4e0c-429a-88a1-5b09371b37f1",
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





