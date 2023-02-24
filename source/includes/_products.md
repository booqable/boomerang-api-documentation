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
`tax_category_id` | **Uuid** `readonly`<br>The associated Tax category
`price_ruleset_id` | **Uuid** `readonly`<br>The associated Price ruleset
`price_structure_id` | **Uuid** `readonly`<br>The associated Price structure
`product_group_id` | **Uuid** <br>The associated Product group
`variation_values` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`allow_shortage` | **Boolean** `readonly`<br>**Inherited from product group**: Whether shortages are allowed
`shortage_limit` | **Integer** `readonly`<br>**Inherited from product group**: The maximum allowed shortage for any date range
`confirm_shortage` | **Boolean** `writeonly`<br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


## Relationships
Products have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`price_ruleset` | **Price rulesets** `readonly`<br>Associated Price ruleset
`price_structure` | **Price structures** `readonly`<br>Associated Price structure
`inventory_levels` | **Inventory levels** `readonly`<br>Associated Inventory levels
`properties` | **Properties** `readonly`<br>Associated Properties
`product_group` | **Product groups** `readonly`<br>Associated Product group
`barcode` | **Barcodes**<br>Associated Barcode


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
      "id": "b9c036eb-408e-4a59-b880-04a3f8e103c1",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-24T08:55:40+00:00",
        "updated_at": "2023-02-24T08:55:40+00:00",
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [
          "green"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "9991da0d-672c-44c2-a56e-489d7a6f168b"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=b9c036eb-408e-4a59-b880-04a3f8e103c1"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=9991da0d-672c-44c2-a56e-489d7a6f168b&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/9991da0d-672c-44c2-a56e-489d7a6f168b"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=b9c036eb-408e-4a59-b880-04a3f8e103c1&filter[owner_type]=products"
          }
        }
      }
    },
    {
      "id": "20b94006-8c8f-47eb-80ae-651073c93f21",
      "type": "products",
      "attributes": {
        "created_at": "2023-02-24T08:55:40+00:00",
        "updated_at": "2023-02-24T08:55:40+00:00",
        "archived": false,
        "archived_at": null,
        "type": "products",
        "name": "iPad Pro - blue",
        "slug": "ipad-pro-blue",
        "sku": "PRODUCT 55",
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
        "tax_category_id": null,
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [
          "blue"
        ],
        "allow_shortage": false,
        "shortage_limit": 0,
        "product_group_id": "9991da0d-672c-44c2-a56e-489d7a6f168b"
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
            "related": "api/boomerang/inventory_levels?filter[item_id]=20b94006-8c8f-47eb-80ae-651073c93f21"
          }
        },
        "properties": {
          "links": {
            "related": "api/boomerang/properties?filter[owner_id]=9991da0d-672c-44c2-a56e-489d7a6f168b&filter[owner_type]=products"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/9991da0d-672c-44c2-a56e-489d7a6f168b"
          }
        },
        "barcode": {
          "links": {
            "related": "api/boomerang/barcodes?filter[owner_id]=20b94006-8c8f-47eb-80ae-651073c93f21&filter[owner_type]=products"
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:52:15Z`
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
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`


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
      "id": "166c55a3-9195-42c8-9545-157baf573312"
    },
    {
      "id": "68da03f3-0c76-4b08-a9ed-26fc4f8c10b4"
    },
    {
      "id": "e5ce2514-52b4-40f5-aa81-9aea5b218179"
    },
    {
      "id": "b36e1329-0cfb-4ad3-b055-eff2ee8889b9"
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T08:52:15Z`
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
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`
`price_ruleset_id` | **Uuid** <br>`eq`, `not_eq`
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`
`q` | **String** <br>`eq`
`collection_id` | **Uuid** <br>`eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`allow_shortage` | **Boolean** <br>`eq`
`shortage_limit` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`photo_id` | **Uuid** <br>`eq`, `not_eq`


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
    --url 'https://example.booqable.com/api/boomerang/products/565f7ff0-3637-436d-9414-c1473fcfb64d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "565f7ff0-3637-436d-9414-c1473fcfb64d",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-24T08:55:43+00:00",
      "updated_at": "2023-02-24T08:55:43+00:00",
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "green"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "1cf02f91-6a29-4028-98b2-30b8391e1809"
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
          "related": "api/boomerang/inventory_levels?filter[item_id]=565f7ff0-3637-436d-9414-c1473fcfb64d"
        }
      },
      "properties": {
        "links": {
          "related": "api/boomerang/properties?filter[owner_id]=1cf02f91-6a29-4028-98b2-30b8391e1809&filter[owner_type]=products"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/1cf02f91-6a29-4028-98b2-30b8391e1809"
        }
      },
      "barcode": {
        "links": {
          "related": "api/boomerang/barcodes?filter[owner_id]=565f7ff0-3637-436d-9414-c1473fcfb64d&filter[owner_type]=products"
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
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
          "product_group_id": "532abe4e-47b2-4023-be7d-754e9ea796e2",
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
    "id": "4190f05d-d341-4674-beb1-1034b8215ae1",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-24T08:55:43+00:00",
      "updated_at": "2023-02-24T08:55:43+00:00",
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "532abe4e-47b2-4023-be7d-754e9ea796e2"
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
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
      "properties": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
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
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


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
    --url 'https://example.booqable.com/api/boomerang/products/c078662d-45ec-4f3e-9bbb-a10701032cbc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c078662d-45ec-4f3e-9bbb-a10701032cbc",
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
    "id": "c078662d-45ec-4f3e-9bbb-a10701032cbc",
    "type": "products",
    "attributes": {
      "created_at": "2023-02-24T08:55:44+00:00",
      "updated_at": "2023-02-24T08:55:44+00:00",
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
      "tax_category_id": null,
      "price_ruleset_id": null,
      "price_structure_id": null,
      "variation_values": [
        "red"
      ],
      "allow_shortage": false,
      "shortage_limit": 0,
      "product_group_id": "9dab92db-89bd-48b2-a606-bc4b9283dcef"
    },
    "relationships": {
      "photo": {
        "meta": {
          "included": false
        }
      },
      "tax_category": {
        "meta": {
          "included": false
        }
      },
      "price_ruleset": {
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
      "properties": {
        "meta": {
          "included": false
        }
      },
      "product_group": {
        "meta": {
          "included": false
        }
      },
      "barcode": {
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
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
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][variation_values][]` | **Array** <br>List of values for `product_group.variation_fields` (Should be in the same order)
`data[attributes][confirm_shortage]` | **Boolean** <br>Whether to confirm the shortage (over limit by changing `shortage_limit`)


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
    --url 'https://example.booqable.com/api/boomerang/products/a1c9dcf3-1c60-4d40-b5fa-e2ed3932ae58' \
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
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,price_ruleset`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[products]=id,created_at,updated_at`


### Includes

This request does not accept any includes