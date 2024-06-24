# Items

The Item resource gives the ability to fetch the following resources:

- Product groups
- Products
- Bundles

The description of the behavior for these resources can be found in their respective sections

## Endpoints
`GET /api/boomerang/items`

`POST api/boomerang/items/search`

`GET /api/boomerang/items/{id}`

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
      "id": "1f7f0f91-6a8a-49d5-9ed2-cbdf7b55a381",
      "type": "bundles",
      "attributes": {
        "created_at": "2024-06-24T09:27:12.115021+00:00",
        "updated_at": "2024-06-24T09:27:12.115021+00:00",
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
        "seo_title": null,
        "seo_description": null,
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=1f7f0f91-6a8a-49d5-9ed2-cbdf7b55a381"
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=1f7f0f91-6a8a-49d5-9ed2-cbdf7b55a381"
          }
        }
      }
    },
    {
      "id": "44119230-b203-49e4-9398-d8ddc4dab359",
      "type": "product_groups",
      "attributes": {
        "created_at": "2024-06-24T09:27:12.210119+00:00",
        "updated_at": "2024-06-24T09:27:12.210119+00:00",
        "archived": false,
        "archived_at": null,
        "type": "product_groups",
        "name": "iPad Pro",
        "group_name": null,
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "has_variations": false,
        "variation": false,
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
        "seo_title": null,
        "seo_description": null,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "tax_category_id": "f4d3ba87-d599-4466-a813-5a1731a7ae97",
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": [],
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/f4d3ba87-d599-4466-a813-5a1731a7ae97"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=44119230-b203-49e4-9398-d8ddc4dab359"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=44119230-b203-49e4-9398-d8ddc4dab359&filter[owner_type]=product_groups"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[product_group_id]=44119230-b203-49e4-9398-d8ddc4dab359"
          }
        }
      }
    },
    {
      "id": "6f5f6784-b368-48bf-b2bc-362846df7bff",
      "type": "products",
      "attributes": {
        "created_at": "2024-06-24T09:27:12.223404+00:00",
        "updated_at": "2024-06-24T09:27:12.223404+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro",
        "group_name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": "SKU",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "trackable",
        "trackable": true,
        "has_variations": false,
        "variation": false,
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
        "seo_title": null,
        "seo_description": null,
        "tag_list": [
          "tablets",
          "apple"
        ],
        "properties": {},
        "photo_id": null,
        "tax_category_id": "f4d3ba87-d599-4466-a813-5a1731a7ae97",
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "44119230-b203-49e4-9398-d8ddc4dab359"
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "tax_category": {
          "links": {
            "related": "api/boomerang/tax_categories/f4d3ba87-d599-4466-a813-5a1731a7ae97"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=6f5f6784-b368-48bf-b2bc-362846df7bff"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=44119230-b203-49e4-9398-d8ddc4dab359&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/44119230-b203-49e4-9398-d8ddc4dab359"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=6f5f6784-b368-48bf-b2bc-362846df7bff&filter[owner_type]=products"
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

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[items]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`variation` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`taxable` | **Array** <br>`count`
`discountable` | **Array** <br>`count`
`product_type` | **Array** <br>`count`
`tracking_type` | **Array** <br>`count`
`show_in_store` | **Array** <br>`count`
`price_type` | **Array** <br>`count`
`price_period` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`inventory_levels`


`photo`






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
      "id": "a933ffff-a2ad-4953-8299-77b13a813c95"
    },
    {
      "id": "91e0c621-3d2b-4db2-a032-a69ee226b4a6"
    },
    {
      "id": "a79a5a76-0108-435e-a4e1-d768aa6b92f9"
    },
    {
      "id": "c3268376-6cb8-460b-afaf-d27019067982"
    },
    {
      "id": "e4622ecf-b83f-45d7-af52-910f7af70047"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/items/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[items]=created_at,updated_at,archived`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`, `gt`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`group_name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
`variation` | **Boolean** <br>`eq`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`base_price_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`price_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`price_period` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`deposit_in_cents` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`
`conditions` | **Hash** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`
`archived` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`taxable` | **Array** <br>`count`
`discountable` | **Array** <br>`count`
`product_type` | **Array** <br>`count`
`tracking_type` | **Array** <br>`count`
`show_in_store` | **Array** <br>`count`
`price_type` | **Array** <br>`count`
`price_period` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`
`deposit_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`
`base_price_in_cents` | **Array** <br>`sum`, `maximum`, `minimum`, `average`


### Includes

This request accepts the following includes:

`inventory_levels`


`photo`






## Fetching an item



> How to fetch an item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/items/64a30c6e-74ab-40ed-8fc6-75351236fe88' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "64a30c6e-74ab-40ed-8fc6-75351236fe88",
    "type": "product_groups",
    "attributes": {
      "created_at": "2024-06-24T09:27:17.971363+00:00",
      "updated_at": "2024-06-24T09:27:17.971363+00:00",
      "archived": false,
      "archived_at": null,
      "type": "product_groups",
      "name": "iPad Pro",
      "group_name": null,
      "slug": "ipad-pro",
      "sku": "SKU",
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "trackable",
      "trackable": true,
      "has_variations": false,
      "variation": false,
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
      "seo_title": null,
      "seo_description": null,
      "tag_list": [
        "tablets",
        "apple"
      ],
      "properties": {},
      "photo_id": null,
      "tax_category_id": "4a54328a-3702-4960-9722-2ecea0b011f3",
      "price_ruleset_id": null,
      "price_structure_id": null,
      "allow_shortage": true,
      "shortage_limit": 3,
      "variation_fields": [],
      "flat_fee_price_in_cents": 1995,
      "structure_price_in_cents": 0,
      "stock_item_properties": []
    },
    "relationships": {
      "photo": {
        "links": {
          "related": null
        }
      },
      "tax_category": {
        "links": {
          "related": "api/boomerang/tax_categories/4a54328a-3702-4960-9722-2ecea0b011f3"
        }
      },
      "price_ruleset": {
        "links": {
          "related": null
        }
      },
      "price_structure": {
        "links": {
          "related": null
        }
      },
      "inventory_levels": {
        "links": {
          "related": "api/boomerang/inventory_levels?filter[item_id]=64a30c6e-74ab-40ed-8fc6-75351236fe88"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=64a30c6e-74ab-40ed-8fc6-75351236fe88&filter[owner_type]=product_groups"
        }
      },
      "products": {
        "links": {
          "related": "api/boomerang/products?filter[product_group_id]=64a30c6e-74ab-40ed-8fc6-75351236fe88"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=inventory_levels,photo`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[items]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`inventory_levels`


`photo`





