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
      "id": "bbc7aa09-6457-40b9-8d04-5fe318e5a8be",
      "type": "tax_values",
      "attributes": {
        "created_at": "2021-12-16T09:39:48+00:00",
        "updated_at": "2021-12-16T09:39:48+00:00",
        "name": "VAT 19%",
        "percentage": 19.0,
        "value_in_cents": 13800,
        "tax_rate_id": "51d913be-8d91-40c0-98d3-9c3b3071c7d2",
        "owner_id": "aa395e86-75cd-4f45-9dca-7d6b7285a47a",
        "owner_type": "orders"
      },
      "relationships": {
        "tax_rate": {
          "links": {
            "related": "api/boomerang/tax_rates/51d913be-8d91-40c0-98d3-9c3b3071c7d2"
          }
        },
        "owner": {
          "links": {
            "related": "api/boomerang/orders/aa395e86-75cd-4f45-9dca-7d6b7285a47a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-16T09:37:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/tax_values/3055b9b1-c5e7-4c2f-aecd-51625b86e26b?include=owner' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3055b9b1-c5e7-4c2f-aecd-51625b86e26b",
    "type": "tax_values",
    "attributes": {
      "created_at": "2021-12-16T09:39:49+00:00",
      "updated_at": "2021-12-16T09:39:49+00:00",
      "name": "VAT 19%",
      "percentage": 19.0,
      "value_in_cents": 13800,
      "tax_rate_id": "fc882a8d-4142-4455-a380-b4402da6b5e3",
      "owner_id": "402c514b-e91b-4c69-8870-cdd0166efca6",
      "owner_type": "orders"
    },
    "relationships": {
      "tax_rate": {
        "links": {
          "related": "api/boomerang/tax_rates/fc882a8d-4142-4455-a380-b4402da6b5e3"
        }
      },
      "owner": {
        "links": {
          "related": "api/boomerang/orders/402c514b-e91b-4c69-8870-cdd0166efca6"
        },
        "data": {
          "type": "orders",
          "id": "402c514b-e91b-4c69-8870-cdd0166efca6"
        }
      }
    }
  },
  "included": [
    {
      "id": "402c514b-e91b-4c69-8870-cdd0166efca6",
      "type": "orders",
      "attributes": {
        "created_at": "2021-12-16T09:39:48+00:00",
        "updated_at": "2021-12-16T09:39:48+00:00",
        "number": null,
        "status": "new",
        "statuses": [
          "new"
        ],
        "status_counts": {},
        "starts_at": "2021-12-14T09:30:00+00:00",
        "stops_at": "2021-12-18T09:30:00+00:00",
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
        "start_location_id": "9a2e7ae2-f9de-4d1a-813c-6758c2ecf6de",
        "stop_location_id": "9a2e7ae2-f9de-4d1a-813c-6758c2ecf6de"
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
            "related": "api/boomerang/barcodes?filter[owner_id]=402c514b-e91b-4c69-8870-cdd0166efca6&filter[owner_type]=orders"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=402c514b-e91b-4c69-8870-cdd0166efca6&filter[owner_type]=orders"
          }
        },
        "start_location": {
          "links": {
            "related": "api/boomerang/locations/9a2e7ae2-f9de-4d1a-813c-6758c2ecf6de"
          }
        },
        "stop_location": {
          "links": {
            "related": "api/boomerang/locations/9a2e7ae2-f9de-4d1a-813c-6758c2ecf6de"
          }
        },
        "tax_values": {
          "links": {
            "related": "api/boomerang/tax_values?filter[owner_id]=402c514b-e91b-4c69-8870-cdd0166efca6"
          }
        },
        "lines": {
          "links": {
            "related": "api/boomerang/lines?filter[owner_id]=402c514b-e91b-4c69-8870-cdd0166efca6&filter[owner_type]=orders"
          }
        },
        "stock_item_plannings": {
          "links": {
            "related": "api/boomerang/stock_item_plannings?filter[order_id]=402c514b-e91b-4c69-8870-cdd0166efca6"
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





