# Tax values

Tax values are always generated automatically by price calculations for `orders` and `carts`. They hold information about the amount taxed for a specific rate.

## Endpoints
`GET api/boomerang/tax_values`

`GET /api/boomerang/tax_values/{id}`

## Fields
Every tax value has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** `readonly`<br>Name of the tax rate
`percentage` | **Float** `readonly`<br>The percentage taxed
`value_in_cents` | **Integer** `readonly`<br>Amount of tax in cents
`tax_rate_id` | **Uuid** `readonly`<br>The associated Tax rate
`owner_id` | **Uuid** `readonly`<br>ID of its owner
`owner_type` | **String** `readonly`<br>The resource type of the owner. One of `orders`, `documents`, `carts`, `lines`


## Relationships
Tax values have the following relationships:

Name | Description
-- | --
`tax_rate` | **Tax rates** `readonly`<br>Associated Tax rate
`owner` | **Order**<br>Associated Owner


## Listing tax values



> How to fetch a list of tax values:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_values' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e238c968-38ed-425b-8a86-ab2ab4317d60",
      "type": "tax_values",
      "attributes": {
        "created_at": "2024-06-03T09:23:22.313528+00:00",
        "updated_at": "2024-06-03T09:23:22.313528+00:00",
        "name": "VAT 19%",
        "percentage": 19.0,
        "value_in_cents": 13800,
        "tax_rate_id": "38c7c5fd-12a5-41bb-85dc-a1496b416f07",
        "owner_id": "64c8c008-c5ba-4fbd-80b5-0a08d76d9fa3",
        "owner_type": "orders"
      },
      "relationships": {
        "tax_rate": {
          "links": {
            "related": "api/boomerang/tax_rates/38c7c5fd-12a5-41bb-85dc-a1496b416f07"
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/orders/64c8c008-c5ba-4fbd-80b5-0a08d76d9fa3"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_values`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_values]=created_at,updated_at,name`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`value_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_rate_id` | **Uuid** <br>`eq`, `not_eq`
`owner_id` | **Uuid** <br>`eq`, `not_eq`
`owner_type` | **String** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`value_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Fetching a tax value



> How to fetch a tax value:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_values/bacd3fe3-4e82-475b-8811-45c8c97fbf72?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bacd3fe3-4e82-475b-8811-45c8c97fbf72",
    "type": "tax_values",
    "attributes": {
      "created_at": "2024-06-03T09:23:23.107148+00:00",
      "updated_at": "2024-06-03T09:23:23.107148+00:00",
      "name": "VAT 19%",
      "percentage": 19.0,
      "value_in_cents": 13800,
      "tax_rate_id": "9dd0f4d0-2b5f-4dfe-9938-efd710dcc3e3",
      "owner_id": "b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6",
      "owner_type": "orders"
    },
    "relationships": {
      "tax_rate": {
        "links": {
          "related": "api/boomerang/tax_rates/9dd0f4d0-2b5f-4dfe-9938-efd710dcc3e3"
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/orders/b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6"
        },
        "data": {
          "type": "orders",
          "id": "b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6"
        }
      }
    }
  },
  "included": [
    {
      "id": "b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6",
      "type": "orders",
      "attributes": {
        "created_at": "2024-06-03T09:23:23.067522+00:00",
        "updated_at": "2024-06-03T09:23:23.067522+00:00",
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {
          "new": 0,
          "concept": 0,
          "reserved": 0,
          "started": 0,
          "stopped": 0
        },
        "starts_at": "2024-06-01T09:15:00.000000+00:00",
        "stops_at": "2024-06-05T09:15:00.000000+00:00",
        "deposit_type": "percentage",
        "deposit_value": 100.0,
        "entirely_started": true,
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
        "start_location_id": "9677e24a-8f2a-42fa-a126-f6cb0740674b",
        "stop_location_id": "9677e24a-8f2a-42fa-a126-f6cb0740674b"
      },
      "relationships": {
        "customer": {
          "links": {
            "related": null
          }
        },
        "tax_region": {
          "links": {
            "related": null
          }
        },
        "coupon": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/9677e24a-8f2a-42fa-a126-f6cb0740674b"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/9677e24a-8f2a-42fa-a126-f6cb0740674b"
          }
        },
        "transfers": {
          "links": {
            "related": "api/boomerang/transfers?filter[order_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6&filter[owner_type]=orders"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=b4f3ff7f-7a05-41d9-ab4e-da14d8cb50a6"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/tax_values/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_values]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`owner`





