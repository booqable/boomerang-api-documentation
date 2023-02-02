# Products

Products are items that are plannable on orders. They always belong to a product group and can only be created separately if the group has variations enabled.

Most of the settings are inherited from the associated product group. When the group has variations enabled, the `base_price_in_cents` field is not inherited from the group anymore but can be set individually.

## Endpoints
`GET /api/boomerang/products`

`POST api/boomerang/products/search`

`GET /api/boomerang/products/{id}`

`POST /api/boomerang/products`

`PUT /api/boomerang/products/{id}`

`DELETE /api/boomerang/products/{id}`

## Fields
Every product has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
`name` | **String** `readonly`<br>Name of the item (based on product group and `variations_values`)
`slug` | **String** `readonly`<br>Slug of the item
`sku` | **String** <br>Stock keeping unit
`lead_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable before a reservation
`lag_time` | **Integer** `readonly`<br>**Inherited from product group**: The amount of seconds the item should be unavailable after a reservation
`product_type` | **String** `readonly`<br>**Inherited from product group**: One of `rental`, `consumable`, `service`
`tracking_type` | **String** `readonly`<br>**Inherited from product group**: Tracking type (One of `none`, `bulk`, `trackable`, can only be set on creating ProductGroups)
`trackable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether stock items are tracked
`has_variations` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`extra_information` | **String** `readonly`<br>**Inherited from product group**: Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`description` | **String** `readonly`<br>**Inherited from product group**: Description used in the online store
`show_in_store` | **Boolean** `readonly`<br>**Inherited from product group**: Whether to show this item in the online
`sorting_weight` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`base_price_in_cents` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`price_type` | **String** `readonly`<br>**Inherited from product group**: One of `structure`, `private_structure`, `fixed`, `simple`, `none`
`price_period` | **String** `readonly`<br>**Inherited from product group**: One of `hour`, `day`, `week`, `month` (Only used for price type `simple`)
`deposit_in_cents` | **Integer** <br>The value to use for deposit calculations
`discountable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether discounts should be applied to this item (note that price rules will still apply)
`taxable` | **Boolean** `readonly`<br>**Inherited from product group**: Whether item is taxable
`seo_title` | **String** <br>SEO title tag
`seo_description` | **String** <br>SEO meta description tag
`tag_list` | **Array** `readonly`<br>**Inherited from product group**: List of tags
`properties` | **Hash** `readonly`<br>**Inherited from product group**: Key value pairs of associated properties
`photo_id` | **Uuid** <br>The associated Photo
`variation_values` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`product_group_id` | **Uuid** <br>The associated Product group
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category
`price_structure_id` | **Uuid** `readonly`<br>The associated Price structure
`price_ruleset_id` | **Uuid** `readonly`<br>The associated Price ruleset


## Relationships
Products have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`product_group` | **Product groups** `readonly`<br>Associated Product group
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`barcode` | **Barcodes**<br>Associated Barcode
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`inventory_levels` | **Inventory levels** `readonly`<br>Associated Inventory levels
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`properties` | **Properties** `readonly`<br>Associated Properties


## Listing products



> How to fetch a list of products:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "791dfbce-136b-472c-a051-8853b2f23789",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-02T15:27:53+00:00",
        "updated_at": "2023-02-02T15:27:53+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro",
        "slug": "ipad-pro",
        "sku": null,
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": true,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 1,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "10df661d-caff-4ea9-bd04-99b8d6c59aa6",
        "tax_category_id": null,
        "price_structure_id": null,
        "price_ruleset_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/10df661d-caff-4ea9-bd04-99b8d6c59aa6"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=791dfbce-136b-472c-a051-8853b2f23789&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=791dfbce-136b-472c-a051-8853b2f23789"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=10df661d-caff-4ea9-bd04-99b8d6c59aa6&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "506a2b80-f100-4bff-a714-dacf8d67ab2c",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-02T15:27:53+00:00",
        "updated_at": "2023-02-02T15:27:53+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro - blue",
        "slug": "ipad-pro-blue",
        "sku": "PRODUCT 49",
        "lead_time": 0,
        "lag_time": 0,
        "product_type": "rental",
        "tracking_type": "bulk",
        "trackable": false,
        "has_variations": true,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 2,
        "base_price_in_cents": 0,
        "price_type": "simple",
        "price_period": "day",
        "deposit_in_cents": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "properties": {},
        "photo_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "10df661d-caff-4ea9-bd04-99b8d6c59aa6",
        "tax_category_id": null,
        "price_structure_id": null,
        "price_ruleset_id": null
      },
      "relationships": {
        "photo": {
          "links": {
            "related": null
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/10df661d-caff-4ea9-bd04-99b8d6c59aa6"
          }
        },
        "tax_category": {
          "links": {
            "related": null
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=506a2b80-f100-4bff-a714-dacf8d67ab2c&filter[owner_type]=products"
          }
        },
        "price_structure": {
          "links": {
            "related": null
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=506a2b80-f100-4bff-a714-dacf8d67ab2c"
          }
        },
        "price_ruleset": {
          "links": {
            "related": null
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=10df661d-caff-4ea9-bd04-99b8d6c59aa6&filter[owner_type]=products"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T15:24:28Z`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
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
`tag_list` | **Array** <br>`eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
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

`photo`


`barcode`


`inventory_levels`


`product_group`






## Searching products

Use advanced search to make logical filter groups with and/or operators.


> How to search for products:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/products/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "products": "id"
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
      "id": "2c5a1aab-51ae-42bb-b473-637ca5aa6438"
    },
    {
      "id": "45e2c5c1-0180-4948-a142-730f2a6195ba"
    },
    {
      "id": "b6b28e43-4c4f-430e-9956-22c4604736e4"
    },
    {
      "id": "97304d59-0b59-499e-b1f2-b19a5d5f2032"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/products/search`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T15:24:28Z`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sku` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`lead_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`lag_time` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tracking_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`trackable` | **Boolean** <br>`eq`
`has_variations` | **Boolean** <br>`eq`
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
`tag_list` | **Array** <br>`eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
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

`photo`


`barcode`


`inventory_levels`


`product_group`






## Fetching a product



> How to fetch a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/products/5fbafdec-4b0a-4d9c-baf9-8c5c036ad924' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5fbafdec-4b0a-4d9c-baf9-8c5c036ad924",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-02T15:27:57+00:00",
      "updated_at": "2023-02-02T15:27:57+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro",
      "slug": "ipad-pro",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 1,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "f90febf3-78c2-4c9b-a00e-e01f6a9fba55",
      "tax_category_id": null,
      "price_structure_id": null,
      "price_ruleset_id": null
    },
    "relationships": {
      "photo": {
        "links": {
          "related": null
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/f90febf3-78c2-4c9b-a00e-e01f6a9fba55"
        }
      },
      "tax_category": {
        "links": {
          "related": null
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=5fbafdec-4b0a-4d9c-baf9-8c5c036ad924&filter[owner_type]=products"
        }
      },
      "price_structure": {
        "links": {
          "related": null
        }
      },
      "inventory_levels": {
        "links": {
          "related": "api/boomerang/inventory_levels?filter[item_id]=5fbafdec-4b0a-4d9c-baf9-8c5c036ad924"
        }
      },
      "price_ruleset": {
        "links": {
          "related": null
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=f90febf3-78c2-4c9b-a00e-e01f6a9fba55&filter[owner_type]=products"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`price_structure` => 
`price_tiles`








## Creating a product



> How to create a product:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/products' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "products",
        "attributes": {
          "product_group_id": "e387e912-fc2b-46b5-8ded-97e801af2538",
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "465540fd-e489-4b69-abe7-ebc80a28ac46",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-02T15:27:57+00:00",
      "updated_at": "2023-02-02T15:27:57+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "slug": "ipad-pro-red",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 3,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "e387e912-fc2b-46b5-8ded-97e801af2538",
      "tax_category_id": null,
      "price_structure_id": null,
      "price_ruleset_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "price_structure": {
        "meta": {
          "included": false
        }
      },
      "inventory_levels": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/products`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][sorting_weight]` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`price_structure` => 
`price_tiles`








## Updating a product



> How to update a product:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/products/a2a6ee52-1df8-4193-8c8a-d0fb8ff8941c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a2a6ee52-1df8-4193-8c8a-d0fb8ff8941c",
        "type": "products",
        "attributes": {
          "variation_values": [
            "red"
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a2a6ee52-1df8-4193-8c8a-d0fb8ff8941c",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-02T15:27:58+00:00",
      "updated_at": "2023-02-02T15:27:58+00:00",
      "archived": false,
      "archived_at": null,
      "type": "products",
      "name": "iPad Pro - red",
      "slug": "ipad-pro",
      "sku": null,
      "lead_time": 0,
      "lag_time": 0,
      "product_type": "rental",
      "tracking_type": "bulk",
      "trackable": false,
      "has_variations": true,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 1,
      "base_price_in_cents": 0,
      "price_type": "simple",
      "price_period": "day",
      "deposit_in_cents": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "properties": {},
      "photo_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "21f29e5e-03bb-4619-be88-5b71b8d77e9b",
      "tax_category_id": null,
      "price_structure_id": null,
      "price_ruleset_id": null
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
        "meta": {
          "included": false
        }
      },
      "price_structure": {
        "meta": {
          "included": false
        }
      },
      "inventory_levels": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
        "meta": {
          "included": false
        }
      },
      "properties": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][sku]` | **String** <br>Stock keeping unit
`data[attributes][has_variations]` | **Boolean** <br>Whether variations are enabled. Not applicable for product_type `service`
`data[attributes][sorting_weight]` | **Integer** <br>Defines sorting weight within its associated product group, the lower the weight - the higher it shows up in lists
`data[attributes][base_price_in_cents]` | **Integer** <br>The value that is being calculated with. This value is writable if group has variations enabled, otherwise it's inherited from the group
`data[attributes][deposit_in_cents]` | **Integer** <br>The value to use for deposit calculations
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group


### Includes

This request accepts the following includes:

`photo`


`properties`


`tax_category`


`barcode`


`price_structure` => 
`price_tiles`








## Archiving a product



> How to delete a product:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/products/3c3f6fd3-49e7-41dc-910e-37a443abb544' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/products/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,product_group,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request does not accept any includes