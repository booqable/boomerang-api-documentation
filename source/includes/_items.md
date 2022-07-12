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
      "id": "158fec94-5695-4257-9ece-cd7921fcdc32",
      "type": "bundles",
      "attributes": {
        "created_at": "2022-07-12T14:15:03+00:00",
        "updated_at": "2022-07-12T14:15:03+00:00",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=158fec94-5695-4257-9ece-cd7921fcdc32"
          }
        },
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=158fec94-5695-4257-9ece-cd7921fcdc32"
          }
        }
      }
    },
    {
      "id": "d645d5ba-1c81-469f-9a2f-622deb4f9e74",
      "type": "product_groups",
      "attributes": {
        "created_at": "2022-07-12T14:15:03+00:00",
        "updated_at": "2022-07-12T14:15:03+00:00",
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
        "tax_category_id": "14d22c89-c400-4173-94ba-b04b48886746"
      },
      "relationships": {
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=d645d5ba-1c81-469f-9a2f-622deb4f9e74"
          }
        },
        "photo": {
          "links": {
            "related": null
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[product_group_id]=d645d5ba-1c81-469f-9a2f-622deb4f9e74"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/14d22c89-c400-4173-94ba-b04b48886746"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=d645d5ba-1c81-469f-9a2f-622deb4f9e74&filter[owner_type]=product_groups"
          }
        }
      }
    },
    {
      "id": "6e305e94-e90c-4628-a250-facf897e0914",
      "type": "products",
      "attributes": {
        "created_at": "2022-07-12T14:15:03+00:00",
        "updated_at": "2022-07-12T14:15:03+00:00",
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
        "product_group_id": "d645d5ba-1c81-469f-9a2f-622deb4f9e74",
        "tax_category_id": "14d22c89-c400-4173-94ba-b04b48886746",
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
            "related": "api/boomerang/product_groups/d645d5ba-1c81-469f-9a2f-622deb4f9e74"
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/14d22c89-c400-4173-94ba-b04b48886746"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6e305e94-e90c-4628-a250-facf897e0914&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=d645d5ba-1c81-469f-9a2f-622deb4f9e74&filter[owner_type]=products"
          }
        },
        "categories": {
          "links": {
            "related": "/api/boomerang/categories?filter%5Bitem_id%5D=d645d5ba-1c81-469f-9a2f-622deb4f9e74"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:13:34Z`
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
      "id": "ea82ff5d-f407-404c-b1ce-8d6205eff19a"
    },
    {
      "id": "fe6ca361-2006-4890-b0dc-abf22d0092fa"
    },
    {
      "id": "99f8b1c5-b3dd-445b-bcca-f2f2169c26e4"
    },
    {
      "id": "709d617a-b169-49e0-b1a6-4f18f95fa162"
    },
    {
      "id": "e89ecdf6-2950-4105-846b-2cf565311756"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-12T14:13:34Z`
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