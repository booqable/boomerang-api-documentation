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
          "order_id": "653771c4-dbd0-43a7-831b-9caaf8c509d3",
          "items": [
            {
              "type": "products",
              "id": "b850a993-8833-442f-ab60-e8cfcc9e9872",
              "quantity": 10
            },
            {
              "type": "products",
              "id": "d4925322-fb69-4798-a0b7-0cc28f4e6c57",
              "stock_item_ids": [
                "ba6a79ba-1e4b-4032-9469-6c80c466c45c",
                "6bf583de-26eb-4a45-b46d-23e09349e201"
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
          "stock_item_id ba6a79ba-1e4b-4032-9469-6c80c466c45c has already been booked on this order"
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
          "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81",
          "items": [
            {
              "type": "products",
              "id": "0f144bdb-c042-4d05-aef0-88a8463e9111",
              "stock_item_ids": [
                "0294bf9e-17fe-471e-b084-175c06ec7940",
                "f633fb5f-2b23-4f1f-8623-0384aa89b2c8",
                "af05c922-e33b-4ca5-bf94-f0ae9fa0e482"
              ]
            },
            {
              "type": "products",
              "id": "caf471c4-99e2-49f4-a341-c555e11a0c7e",
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
    "id": "e78d355b-cca0-5f54-8248-61b8aafddc2d",
    "type": "order_bookings",
    "attributes": {
      "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "4d506b98-0e78-46fb-820a-c73a94964f81"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "4c4921b8-5ad3-4f66-8db6-ef32ed05ad08"
          },
          {
            "type": "lines",
            "id": "fe9ca3d9-efd5-49e8-9b59-8ab524d3ceff"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "9a641b0f-631f-4cf6-8583-862ff51c8b82"
          },
          {
            "type": "plannings",
            "id": "fe8363ef-eba3-4b64-ac19-6c760b0489ae"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "d48e317c-d987-488d-9f1d-5792020108f2"
          },
          {
            "type": "stock_item_plannings",
            "id": "cae1ad0b-b5dd-4a89-a3da-4782fecabce7"
          },
          {
            "type": "stock_item_plannings",
            "id": "728e7a91-b71a-40f6-af04-1afdcae6b8cd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4d506b98-0e78-46fb-820a-c73a94964f81",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T00:25:33+00:00",
        "updated_at": "2023-02-23T00:25:36+00:00",
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
        "customer_id": "5aa6f089-b73c-45fc-96f4-a0e804f642fb",
        "tax_region_id": null,
        "coupon_id": null,
        "start_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566",
        "stop_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566"
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
      "id": "4c4921b8-5ad3-4f66-8db6-ef32ed05ad08",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:36+00:00",
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
        "item_id": "0f144bdb-c042-4d05-aef0-88a8463e9111",
        "tax_category_id": "bcf32265-0291-41af-85f1-f07b597878de",
        "planning_id": "9a641b0f-631f-4cf6-8583-862ff51c8b82",
        "parent_line_id": null,
        "owner_id": "4d506b98-0e78-46fb-820a-c73a94964f81",
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
      "id": "fe9ca3d9-efd5-49e8-9b59-8ab524d3ceff",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:36+00:00",
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
        "item_id": "caf471c4-99e2-49f4-a341-c555e11a0c7e",
        "tax_category_id": "bcf32265-0291-41af-85f1-f07b597878de",
        "planning_id": "fe8363ef-eba3-4b64-ac19-6c760b0489ae",
        "parent_line_id": null,
        "owner_id": "4d506b98-0e78-46fb-820a-c73a94964f81",
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
      "id": "9a641b0f-631f-4cf6-8583-862ff51c8b82",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:35+00:00",
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
        "item_id": "0f144bdb-c042-4d05-aef0-88a8463e9111",
        "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81",
        "start_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566",
        "stop_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566",
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
      "id": "fe8363ef-eba3-4b64-ac19-6c760b0489ae",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:35+00:00",
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
        "item_id": "caf471c4-99e2-49f4-a341-c555e11a0c7e",
        "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81",
        "start_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566",
        "stop_location_id": "91c9688f-6ead-4b23-89d9-a1b2be95b566",
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
      "id": "d48e317c-d987-488d-9f1d-5792020108f2",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "0294bf9e-17fe-471e-b084-175c06ec7940",
        "planning_id": "9a641b0f-631f-4cf6-8583-862ff51c8b82",
        "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81"
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
      "id": "cae1ad0b-b5dd-4a89-a3da-4782fecabce7",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "f633fb5f-2b23-4f1f-8623-0384aa89b2c8",
        "planning_id": "9a641b0f-631f-4cf6-8583-862ff51c8b82",
        "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81"
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
      "id": "728e7a91-b71a-40f6-af04-1afdcae6b8cd",
      "type": "stock_item_plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:35+00:00",
        "updated_at": "2023-02-23T00:25:35+00:00",
        "archived": false,
        "archived_at": null,
        "reserved": true,
        "started": false,
        "stopped": false,
        "stock_item_id": "af05c922-e33b-4ca5-bf94-f0ae9fa0e482",
        "planning_id": "9a641b0f-631f-4cf6-8583-862ff51c8b82",
        "order_id": "4d506b98-0e78-46fb-820a-c73a94964f81"
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
          "order_id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4",
          "items": [
            {
              "type": "bundles",
              "id": "649debbe-1bf3-425c-a54c-b36370a978e2",
              "products": [
                {
                  "type": "products",
                  "bundle_item_id": "8935d390-96ff-411a-a561-d6f53bfc0b4e",
                  "id": "7526788b-83bf-494f-9e6f-60fed0992960"
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
    "id": "7e638ed3-a8b5-50f8-a5a4-2315edd39ac7",
    "type": "order_bookings",
    "attributes": {
      "order_id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "7e37a16f-807b-4855-8e35-ebdbdad7702d"
          },
          {
            "type": "lines",
            "id": "4f2811ef-5fe4-4a39-ba84-bf90cdf50956"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "7c52ccab-7687-4d3f-9bee-68d5dac07e68"
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
      "id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4",
      "type": "orders",
      "attributes": {
        "created_at": "2023-02-23T00:25:38+00:00",
        "updated_at": "2023-02-23T00:25:39+00:00",
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
        "starts_at": "2023-02-21T00:15:00+00:00",
        "stops_at": "2023-02-25T00:15:00+00:00",
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
        "start_location_id": "9ae708f2-56c5-4511-a3f0-cba473430387",
        "stop_location_id": "9ae708f2-56c5-4511-a3f0-cba473430387"
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
      "id": "7e37a16f-807b-4855-8e35-ebdbdad7702d",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T00:25:39+00:00",
        "updated_at": "2023-02-23T00:25:39+00:00",
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
        "item_id": "7526788b-83bf-494f-9e6f-60fed0992960",
        "tax_category_id": null,
        "planning_id": "01712487-c8ac-4567-9237-6b9ab899f3a0",
        "parent_line_id": "4f2811ef-5fe4-4a39-ba84-bf90cdf50956",
        "owner_id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4",
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
      "id": "4f2811ef-5fe4-4a39-ba84-bf90cdf50956",
      "type": "lines",
      "attributes": {
        "created_at": "2023-02-23T00:25:39+00:00",
        "updated_at": "2023-02-23T00:25:39+00:00",
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
        "item_id": "649debbe-1bf3-425c-a54c-b36370a978e2",
        "tax_category_id": null,
        "planning_id": "7c52ccab-7687-4d3f-9bee-68d5dac07e68",
        "parent_line_id": null,
        "owner_id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4",
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
      "id": "7c52ccab-7687-4d3f-9bee-68d5dac07e68",
      "type": "plannings",
      "attributes": {
        "created_at": "2023-02-23T00:25:39+00:00",
        "updated_at": "2023-02-23T00:25:39+00:00",
        "archived": false,
        "archived_at": null,
        "quantity": 1,
        "starts_at": "2023-02-21T00:15:00+00:00",
        "stops_at": "2023-02-25T00:15:00+00:00",
        "reserved_from": "2023-02-21T00:15:00+00:00",
        "reserved_till": "2023-02-25T00:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "649debbe-1bf3-425c-a54c-b36370a978e2",
        "order_id": "43291fc3-9aa5-4efc-b69e-23c90e8bfda4",
        "start_location_id": "9ae708f2-56c5-4511-a3f0-cba473430387",
        "stop_location_id": "9ae708f2-56c5-4511-a3f0-cba473430387",
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





