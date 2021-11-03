# Order bookings

Order booking

## Endpoints
`POST /api/boomerang/order_bookings`

## Fields
Every order booking has the following fields:

Name | Description
- | -
`id` | **Uuid**<br>
`products` | **Array** `writeonly`<br>
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



> How to create an order booking:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/order_bookings' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "order_bookings",
        "attributes": {
          "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
          "products": [
            {
              "id": "b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3",
              "stock_item_ids": [
                "2b39a773-da1d-44f0-962e-42fa562d6019",
                "d052b65d-7bb0-460e-9306-a814eaef935a",
                "7387d37f-08d6-46aa-ba2e-798d8410f90b",
                "b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00"
              ]
            },
            {
              "id": "31999bba-ca0d-4090-91c8-da192aad1d93",
              "quantity": 3
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
    "id": "207fbb3f-ce78-53d2-8b6c-877393286f1f",
    "type": "order_bookings",
    "attributes": {
      "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
    },
    "relationships": {
      "order": {
        "data": {
          "type": "orders",
          "id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
        }
      },
      "lines": {
        "data": [
          {
            "type": "lines",
            "id": "c3546c92-c9a1-4b62-a5fc-1aafbf4881af"
          },
          {
            "type": "lines",
            "id": "627c6628-aa87-41fa-8452-4badcdeb0f5a"
          }
        ]
      },
      "plannings": {
        "data": [
          {
            "type": "plannings",
            "id": "1406db72-975a-42c6-aa4f-784fb83d928c"
          },
          {
            "type": "plannings",
            "id": "2105e890-f845-47fe-a65f-f485446470b7"
          }
        ]
      },
      "stock_item_plannings": {
        "data": [
          {
            "type": "stock_item_plannings",
            "id": "6ec51342-0642-4711-9292-24e88206ae50"
          },
          {
            "type": "stock_item_plannings",
            "id": "63b5964e-1924-4355-9d84-40e788586768"
          },
          {
            "type": "stock_item_plannings",
            "id": "46dad3cc-e02e-4cb9-9bf5-a7bf82f44a0f"
          },
          {
            "type": "stock_item_plannings",
            "id": "6a4d7abf-4e3e-473e-b7c7-4d4f71d9a6f8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
      "type": "orders",
      "attributes": {
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {
          "concept": 0,
          "new": 7,
          "reserved": 0,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "2021-11-01T20:15:00+00:00",
        "stops_at": "2021-11-05T20:15:00+00:00",
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
        "start_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4",
        "stop_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4"
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
        "start_location": {
          "meta": {
            "included": false
          }
        },
        "stop_location": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "c3546c92-c9a1-4b62-a5fc-1aafbf4881af",
      "type": "lines",
      "attributes": {
        "title": "Product 2",
        "extra_information": null,
        "quantity": 3,
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
        "owner_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
        "owner_type": "Order",
        "item_id": "31999bba-ca0d-4090-91c8-da192aad1d93",
        "tax_category_id": null,
        "parent_line_id": null
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
      "id": "627c6628-aa87-41fa-8452-4badcdeb0f5a",
      "type": "lines",
      "attributes": {
        "title": "Product 1",
        "extra_information": null,
        "quantity": 4,
        "original_price_each_in_cents": 0,
        "price_each_in_cents": 0,
        "price_in_cents": 0,
        "position": 2,
        "charge_label": "4 days",
        "charge_length": 345600,
        "price_rule_values": null,
        "discountable": true,
        "taxable": true,
        "line_type": "charge",
        "relevant": true,
        "owner_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
        "owner_type": "Order",
        "item_id": "b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3",
        "tax_category_id": null,
        "parent_line_id": null
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
      "id": "1406db72-975a-42c6-aa4f-784fb83d928c",
      "type": "plannings",
      "attributes": {
        "quantity": 3,
        "starts_at": "2021-11-01T20:15:00+00:00",
        "stops_at": "2021-11-05T20:15:00+00:00",
        "reserved_from": "2021-11-01T20:15:00+00:00",
        "reserved_till": "2021-11-05T20:15:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "31999bba-ca0d-4090-91c8-da192aad1d93",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
        "start_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4",
        "stop_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4",
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
      "id": "2105e890-f845-47fe-a65f-f485446470b7",
      "type": "plannings",
      "attributes": {
        "quantity": 4,
        "starts_at": "2021-11-01T20:15:00+00:00",
        "stops_at": "2021-11-05T20:15:00+00:00",
        "reserved_from": "2021-11-01T20:14:00+00:00",
        "reserved_till": "2021-11-05T20:16:00+00:00",
        "reserved": false,
        "started": 0,
        "stopped": 0,
        "location_shortage_amount": 0,
        "shortage_amount": 0,
        "item_id": "b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48",
        "start_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4",
        "stop_location_id": "9aa6b6cf-0a71-49ae-85ac-7ad0edbbdad4",
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
      "id": "6ec51342-0642-4711-9292-24e88206ae50",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "2b39a773-da1d-44f0-962e-42fa562d6019",
        "planning_id": "2105e890-f845-47fe-a65f-f485446470b7",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
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
      "id": "63b5964e-1924-4355-9d84-40e788586768",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "d052b65d-7bb0-460e-9306-a814eaef935a",
        "planning_id": "2105e890-f845-47fe-a65f-f485446470b7",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
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
      "id": "46dad3cc-e02e-4cb9-9bf5-a7bf82f44a0f",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "7387d37f-08d6-46aa-ba2e-798d8410f90b",
        "planning_id": "2105e890-f845-47fe-a65f-f485446470b7",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
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
      "id": "6a4d7abf-4e3e-473e-b7c7-4d4f71d9a6f8",
      "type": "stock_item_plannings",
      "attributes": {
        "reserved": false,
        "started": false,
        "stopped": false,
        "stock_item_id": "b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00",
        "planning_id": "2105e890-f845-47fe-a65f-f485446470b7",
        "order_id": "fdec1932-5da0-44dd-9e18-c04f79c96e48"
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
    "self": "api/boomerang/order_bookings?data%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/order_bookings?data%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/order_bookings?data%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=&page%5Bsize%5D=25",
    "next": "api/boomerang/order_bookings?data%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&data%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&data%5Btype%5D=order_bookings&include=order%2Clines%2Cplannings%2Cstock_item_plannings&order_booking%5Bdata%5D%5Battributes%5D%5Border_id%5D=fdec1932-5da0-44dd-9e18-c04f79c96e48&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=b7a9b4ff-4af9-4b58-96ea-5d8f128d1da3&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=2b39a773-da1d-44f0-962e-42fa562d6019&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=d052b65d-7bb0-460e-9306-a814eaef935a&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=7387d37f-08d6-46aa-ba2e-798d8410f90b&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bstock_item_ids%5D%5B%5D=b8d52dfd-9e45-4eee-a2c8-0d5605d3ab00&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bid%5D=31999bba-ca0d-4090-91c8-da192aad1d93&order_booking%5Bdata%5D%5Battributes%5D%5Bproducts%5D%5B%5D%5Bquantity%5D=3&order_booking%5Bdata%5D%5Btype%5D=order_bookings&order_booking%5Binclude%5D=order%2Clines%2Cplannings%2Cstock_item_plannings&page%5Bnumber%5D=2&page%5Bsize%5D=25"
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
`data[attributes][products][]` | **Array**<br>
`data[attributes][order_id]` | **Uuid**<br>The associated Order


### Includes

This request accepts the following includes:

`order`


`lines`


`plannings`


`stock_item_plannings`





