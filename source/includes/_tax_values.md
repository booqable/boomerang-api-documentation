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
      "id": "d0858857-6e12-45f8-9b3c-f69dde9c3e32",
      "type": "tax_values",
      "attributes": {
        "created_at": "2021-12-08T12:35:44+00:00",
        "updated_at": "2021-12-08T12:35:44+00:00",
        "name": "VAT 19%",
        "percentage": 19.0,
        "value_in_cents": 13800,
        "tax_rate_id": "16ca0c70-fedd-457b-9148-5ee62d34c7fc",
        "owner_id": "63725055-2fba-47e1-b680-55af23a4bf67",
        "owner_type": "orders"
      },
      "relationships": {
        "tax_rate": {
          "links": {
            "related": "api/boomerang/tax_rates/16ca0c70-fedd-457b-9148-5ee62d34c7fc"
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/orders/63725055-2fba-47e1-b680-55af23a4bf67"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/tax_values?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/tax_values?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/tax_values?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET api/boomerang/tax_values`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rate,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_values]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T12:33:46Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`percentage` | **Float**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`tax_rate_id` | **Uuid**<br>`eq`, `not_eq`
`owner_id` | **Uuid**<br>`eq`, `not_eq`
`owner_type` | **String**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`value_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a tax value



> How to fetch a tax value:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/tax_values/fc40b62c-bbb8-4842-98c9-a13fd0fe2237?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fc40b62c-bbb8-4842-98c9-a13fd0fe2237",
    "type": "tax_values",
    "attributes": {
      "created_at": "2021-12-08T12:35:45+00:00",
      "updated_at": "2021-12-08T12:35:45+00:00",
      "name": "VAT 19%",
      "percentage": 19.0,
      "value_in_cents": 13800,
      "tax_rate_id": "b7bb5a68-3ab8-4dc0-ac18-ab2a132636c3",
      "owner_id": "eed252a7-ce54-4d60-a79d-2eb36288da73",
      "owner_type": "orders"
    },
    "relationships": {
      "tax_rate": {
        "links": {
          "related": "api/boomerang/tax_rates/b7bb5a68-3ab8-4dc0-ac18-ab2a132636c3"
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/orders/eed252a7-ce54-4d60-a79d-2eb36288da73"
        },
        "data": {
          "type": "orders",
          "id": "eed252a7-ce54-4d60-a79d-2eb36288da73"
        }
      }
    }
  },
  "included": [
    {
      "id": "eed252a7-ce54-4d60-a79d-2eb36288da73",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-08T12:35:45+00:00",
        "updated_at": "2021-12-08T12:35:45+00:00",
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {},
        "starts_at": "2021-12-06T12:30:00+00:00",
        "stops_at": "2021-12-10T12:30:00+00:00",
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
        "start_location_id": "4a4d6a2a-ee88-4efe-b54d-ec15c803f0cd",
        "stop_location_id": "4a4d6a2a-ee88-4efe-b54d-ec15c803f0cd"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=eed252a7-ce54-4d60-a79d-2eb36288da73&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=eed252a7-ce54-4d60-a79d-2eb36288da73&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/4a4d6a2a-ee88-4efe-b54d-ec15c803f0cd"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/4a4d6a2a-ee88-4efe-b54d-ec15c803f0cd"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=eed252a7-ce54-4d60-a79d-2eb36288da73"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=eed252a7-ce54-4d60-a79d-2eb36288da73&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=eed252a7-ce54-4d60-a79d-2eb36288da73"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=tax_rate,owner`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[tax_values]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`owner`





