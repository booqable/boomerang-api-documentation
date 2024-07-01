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
      "id": "b9c3fedb-4ead-4111-af03-62dcb47554c7",
      "type": "bundles",
      "attributes": {
        "created_at": "2024-07-01T09:28:12.690351+00:00",
        "updated_at": "2024-07-01T09:28:12.690351+00:00",
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
      "relationships": {}
    },
    {
      "id": "63aa2a54-e8b1-4664-bb7d-775a2cd58223",
      "type": "product_groups",
      "attributes": {
        "created_at": "2024-07-01T09:28:12.883932+00:00",
        "updated_at": "2024-07-01T09:28:12.883932+00:00",
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
        "tax_category_id": "c345c94e-69e9-4d90-bd7c-db5b250c93f4",
        "price_ruleset_id": null,
        "price_structure_id": null,
        "allow_shortage": true,
        "shortage_limit": 3,
        "variation_fields": [],
        "flat_fee_price_in_cents": 1995,
        "structure_price_in_cents": 0,
        "stock_item_properties": []
      },
      "relationships": {}
    },
    {
      "id": "b74de071-068e-4d4a-90dd-3ac4a4e30082",
      "type": "products",
      "attributes": {
        "created_at": "2024-07-01T09:28:12.894514+00:00",
        "updated_at": "2024-07-01T09:28:12.894514+00:00",
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
        "tax_category_id": "c345c94e-69e9-4d90-bd7c-db5b250c93f4",
        "price_ruleset_id": null,
        "price_structure_id": null,
        "variation_values": [],
        "allow_shortage": true,
        "shortage_limit": 3,
        "product_group_id": "63aa2a54-e8b1-4664-bb7d-775a2cd58223"
      },
      "relationships": {}
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
      "id": "eb3feaf4-063f-436c-b208-fad63fd80457"
    },
    {
      "id": "af2bf186-7aec-4184-8df6-06433d76d33e"
    },
    {
      "id": "9a373d42-fc0c-4b49-9bb9-da3225bb1789"
    },
    {
      "id": "c1f47f6b-a9e6-4faf-964f-4a2178faf191"
    },
    {
      "id": "067bb1b6-41d7-4a2b-b91d-474ce825a7e8"
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
    --url 'https://example.booqable.com/api/boomerang/items/64be3963-c51e-4f45-87fd-e10026b41754' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "64be3963-c51e-4f45-87fd-e10026b41754",
    "type": "product_groups",
    "attributes": {
      "created_at": "2024-07-01T09:28:18.493938+00:00",
      "updated_at": "2024-07-01T09:28:18.493938+00:00",
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
      "tax_category_id": "4bf0d2e5-522b-49a3-9c4e-5f43d0c70ea9",
      "price_ruleset_id": null,
      "price_structure_id": null,
      "allow_shortage": true,
      "shortage_limit": 3,
      "variation_fields": [],
      "flat_fee_price_in_cents": 1995,
      "structure_price_in_cents": 0,
      "stock_item_properties": []
    },
    "relationships": {}
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





