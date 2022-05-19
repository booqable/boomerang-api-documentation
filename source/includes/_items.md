# Items

The Item resource gives the ability to fetch the following resources:

- Product groups
- Products
- Bundles

The description of the behavior for these resources can be found in their respective sections

## Endpoints
`GET /api/boomerang/items`

`POST api/boomerang/items/search`

## Fields
For this resource fields are described in the following resources:

- Product groups
- Products
- Bundles

## Relationships
For this resource relationships are described in the following resources:

- Product groups
- Products
- Bundles

## Listing items



> How to fetch a list of items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d886fe2f-1943-4c80-adce-b68fc14c3168",
      "type": "bundles",
      "attributes": {
        "created_at": "2022-05-19T14:23:21+00:00",
        "updated_at": "2022-05-19T14:23:21+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "bundle_items": {
          "links": {
            "related": "api/boomerang/bundle_items?filter[bundle_id]=d886fe2f-1943-4c80-adce-b68fc14c3168"
          }
        },
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=d886fe2f-1943-4c80-adce-b68fc14c3168"
          }
        }
      }
    },
    {
      "id": "c153c852-4527-4ba6-8aaf-bc4f83eefb57",
      "type": "product_groups",
      "attributes": {
        "created_at": "2022-05-19T14:23:21+00:00",
        "updated_at": "2022-05-19T14:23:21+00:00",
        "archived": false,
        "archived_at": null,
        "type": "product_groups",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "extra_information": "Charging cable and case included",
        "photo_url": null,
        "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
        "show_in_store": true,
        "sorting_weight": 0,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": [],
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "tax_category_id": "c5a8f7a8-ccdd-4218-8e95-f98e51ad22a8"
      },
      "relationships": {
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=c153c852-4527-4ba6-8aaf-bc4f83eefb57"
          }
        },
        "photo": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[product_group_id]=c153c852-4527-4ba6-8aaf-bc4f83eefb57"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/c5a8f7a8-ccdd-4218-8e95-f98e51ad22a8"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=c153c852-4527-4ba6-8aaf-bc4f83eefb57&filter[owner_type]=product_groups"
          }
        }
      }
    },
    {
      "id": "7b52e0e2-cf37-4016-a49a-d5f53b5f5645",
      "type": "products",
      "attributes": {
        "created_at": "2022-05-19T14:23:21+00:00",
        "updated_at": "2022-05-19T14:23:21+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "sku",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "extra_information": "Charging cable and case included",
        "photo_url": null,
        "description": "The Apple iPad Pro (2021) 12.9 inches 128GB Space Gray is one of the most powerful and fastest tablets of this moment thanks to the new M1 chip. This chip ensures that demanding apps from Adobe or 3D games run smoothly",
        "show_in_store": true,
        "sorting_weight": 1,
        "base_price_in_cents": 1995,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 10000,
        "discountable": true,
        "taxable": true,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "c153c852-4527-4ba6-8aaf-bc4f83eefb57",
        "tax_category_id": "c5a8f7a8-ccdd-4218-8e95-f98e51ad22a8",
        "price_structure_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/c153c852-4527-4ba6-8aaf-bc4f83eefb57"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/c5a8f7a8-ccdd-4218-8e95-f98e51ad22a8"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=7b52e0e2-cf37-4016-a49a-d5f53b5f5645&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=c153c852-4527-4ba6-8aaf-bc4f83eefb57&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=c153c852-4527-4ba6-8aaf-bc4f83eefb57"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:16Z`
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
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String**<br>`eq`, `not_eq`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean**<br>`eq`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean**<br>`eq`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean**<br>`eq`
`taxable` | **Boolean**<br>`eq`
`tag_list` | **String**<br>`eq`
`category_id` | **Uuid**<br>`eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`discountable` | **Array**<br>`count`
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request does not accept any includes
## Searching items

Use advanced search to make logical filter groups with and/or operators.


> How to search for items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/items/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "items": "id"
      },
      "filter": {
        "conditions": {
          "operator": "or",
          "attributes": [
            {
              "operator": "and",
              "attributes": [
                {
                  "discountable": true
                },
                {
                  "taxable": true
                }
              ]
            },
            {
              "operator": "and",
              "attributes": [
                {
                  "show_in_store": true
                },
                {
                  "taxable": true
                }
              ]
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "716c1bd5-3cbb-4b53-934d-95b26e60f0da"
    },
    {
      "id": "ca52e7f4-bc77-4881-b9d5-8f2ed2c83607"
    },
    {
      "id": "d5819f15-3f70-4e86-8351-797faddaada9"
    },
    {
      "id": "b4585769-c58a-4a12-bad5-34750e7a7a6c"
    },
    {
      "id": "741b72d5-4f92-4b9f-91fc-5b0c246239c3"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/items/search`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-19T14:22:16Z`
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
`archived` | **Boolean**<br>`eq`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String**<br>`eq`, `not_eq`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean**<br>`eq`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean**<br>`eq`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean**<br>`eq`
`taxable` | **Boolean**<br>`eq`
`tag_list` | **String**<br>`eq`
`category_id` | **Uuid**<br>`eq`
`tax_category_id` | **Uuid**<br>`eq`, `not_eq`
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`
`q` | **String**<br>`eq`
`product_group_id` | **Uuid**<br>`eq`
`conditions` | **Hash**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`discountable` | **Array**<br>`count`
`product_type` | **Array**<br>`count`
`tracking_type` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`price_type` | **Array**<br>`count`
`price_period` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`
`deposit_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array**<br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request does not accept any includes