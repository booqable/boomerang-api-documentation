# Tax values

Tax values are always generated automatically by price calculations for `orders` and `carts`. They hold information about the amount taxed for a specific rate.

## Endpoints
`GET api/boomerang/tax_values`

`GET /api/boomerang/tax_values/{id}`

## Fields
Every tax value has the following fields:

Name | Description
- | -
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
- | -
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
      "id": "0612eb11-5c81-45a7-85cd-2d4c206c0dc3",
      "type": "tax_values",
      "attributes": {
        "created_at": "2022-10-07T11:59:33+00:00",
        "updated_at": "2022-10-07T11:59:33+00:00",
        "name": "VAT 19%",
        "percentage": 19.0,
        "value_in_cents": 13800,
        "tax_rate_id": "20372b4d-0297-4d46-aca2-ad91dd0bf249",
        "owner_id": "61c3eab6-45c3-4079-96cd-d3c63142820b",
        "owner_type": "orders"
      },
      "relationships": {
        "tax_rate": {
          "links": {
            "related": "api/boomerang/tax_rates/20372b4d-0297-4d46-aca2-ad91dd0bf249"
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/orders/61c3eab6-45c3-4079-96cd-d3c63142820b"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rate,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_values]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-07T11:55:31Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`
`value_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Fetching a tax value



> How to fetch a tax value:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_values/9fa27323-7108-4701-bf1b-26d4d1d81b4b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9fa27323-7108-4701-bf1b-26d4d1d81b4b",
    "type": "tax_values",
    "attributes": {
      "created_at": "2022-10-07T11:59:34+00:00",
      "updated_at": "2022-10-07T11:59:34+00:00",
      "name": "VAT 19%",
      "percentage": 19.0,
      "value_in_cents": 13800,
      "tax_rate_id": "dfa6626b-a1be-4486-a8c3-2a2ba3185844",
      "owner_id": "76798668-b449-43be-9edb-58c70ce1f9f0",
      "owner_type": "orders"
    },
    "relationships": {
      "tax_rate": {
        "links": {
          "related": "api/boomerang/tax_rates/dfa6626b-a1be-4486-a8c3-2a2ba3185844"
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/orders/76798668-b449-43be-9edb-58c70ce1f9f0"
        },
        "data": {
          "type": "orders",
          "id": "76798668-b449-43be-9edb-58c70ce1f9f0"
        }
      }
    }
  },
  "included": [
    {
      "id": "76798668-b449-43be-9edb-58c70ce1f9f0",
      "type": "orders",
      "attributes": {
        "created_at": "2022-10-07T11:59:34+00:00",
        "updated_at": "2022-10-07T11:59:34+00:00",
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {},
        "starts_at": "2022-10-05T11:45:00+00:00",
        "stops_at": "2022-10-09T11:45:00+00:00",
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
        "start_location_id": "24a9f546-c8a1-4433-84d3-fea84d6cd245",
        "stop_location_id": "24a9f546-c8a1-4433-84d3-fea84d6cd245"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=76798668-b449-43be-9edb-58c70ce1f9f0&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=76798668-b449-43be-9edb-58c70ce1f9f0&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/24a9f546-c8a1-4433-84d3-fea84d6cd245"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/24a9f546-c8a1-4433-84d3-fea84d6cd245"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=76798668-b449-43be-9edb-58c70ce1f9f0"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=76798668-b449-43be-9edb-58c70ce1f9f0&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=76798668-b449-43be-9edb-58c70ce1f9f0"
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=tax_rate,owner`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[tax_values]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`





