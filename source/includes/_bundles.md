# Bundles

Bundles allow for a single product to be made up of multiple other products. This makes it possible to track the status of multiple smaller products within a single larger product (the bundle).

## Endpoints
`GET /api/boomerang/bundles`

`POST api/boomerang/bundles/search`

`GET /api/boomerang/bundles/{id}`

`POST /api/boomerang/bundles`

`PUT /api/boomerang/bundles/{id}`

`DELETE /api/boomerang/bundles/{id}`

## Fields
Every bundle has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `nullable` `readonly`<br>When the item was archived
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
`name` | **String** <br>Name of the item
`slug` | **String** `readonly`<br>Slug of the item
`product_type` | **String** `readonly`<br>One of `rental`, `consumable`, `service`
`extra_information` | **String** `nullable`<br>Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`remote_photo_url` | **String** `writeonly`<br>Url to an image on the web
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `nullable`<br>Description used in the online store
`excerpt` | **String** <br>Excerpt used in the online store
`show_in_store` | **Boolean** <br>Whether to show this item in the online
`sorting_weight` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`discountable` | **Boolean** <br>Whether discounts should be applied to items in this bundle
`taxable` | **Boolean** <br>Whether item is taxable
`bundle_items_attributes` | **Array** `writeonly`<br>The bundle items to associate
`seo_title` | **String** <br>SEO title tag
`seo_description` | **String** <br>SEO meta description tag
`tag_list` | **Array** <br>List of tags
`photo_id` | **Uuid** <br>The associated Photo
`tax_category_id` | **Uuid** <br>The associated Tax category


## Relationships
Bundles have the following relationships:

Name | Description
-- | --
`photo` | **Photos** `readonly`<br>Associated Photo
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`bundle_items` | **Bundle items** `readonly`<br>Associated Bundle items
`inventory_levels` | **Inventory levels** `readonly`<br>Associated Inventory levels


## Listing bundles



> How to fetch a list of bundles:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d01c9c86-4150-4e61-a748-12b9a7a4674a",
      "type": "bundles",
      "attributes": {
        "created_at": "2024-08-05T09:25:38.601887+00:00",
        "updated_at": "2024-08-05T09:25:38.601887+00:00",
        "archived": false,
        "archived_at": null,
        "type": "bundles",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "excerpt": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "seo_title": null,
        "seo_description": null,
        "tag_list": [],
        "photo_id": null,
        "tax_category_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=photo,inventory_levels`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String** <br>`eq`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`excerpt` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`


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
`show_in_store` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`photo`


`inventory_levels`






## Searching bundles

Use advanced search to make logical filter groups with and/or operators.


> How to search for bundles:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bundles/search' \
    --header 'content-type: application/json' \
    --data '{
      "fields": {
        "bundles": "id"
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
      "id": "c1ccfafd-b52c-4272-9d6c-3ee60f98639f"
    },
    {
      "id": "f3a0377c-8c39-49e6-b401-0970e141c98d"
    },
    {
      "id": "4c6effbc-ef15-4d16-9fed-8323af365d25"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/bundles/search`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=photo,inventory_levels`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`
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
`archived` | **Boolean** <br>`eq`
`archived_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String** <br>`eq`
`type` | **String** <br>`eq`, `not_eq`
`name` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`product_type` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`extra_information` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`excerpt` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`show_in_store` | **Boolean** <br>`eq`
`sorting_weight` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discountable` | **Boolean** <br>`eq`
`taxable` | **Boolean** <br>`eq`
`seo_title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`seo_description` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`tag_list` | **String** <br>`eq`
`tax_category_id` | **Uuid** <br>`eq`, `not_eq`


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
`show_in_store` | **Array** <br>`count`
`tax_category_id` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`photo`


`inventory_levels`






## Fetching a bundle



> How to fetch a bundle:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundles/77f08486-a2ea-4fe9-a4b9-4889a87bc169' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "77f08486-a2ea-4fe9-a4b9-4889a87bc169",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-08-05T09:25:37.849105+00:00",
      "updated_at": "2024-08-05T09:25:37.849105+00:00",
      "archived": false,
      "archived_at": null,
      "type": "bundles",
      "name": "iPad Bundle",
      "slug": "ipad-bundle",
      "product_type": "bundle",
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=photo,bundle_items,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`


### Includes

This request accepts the following includes:

`photo`


`bundle_items` => 
`product_group` => 
`photo`




`product` => 
`photo`






`tax_category`






## Creating a bundle



> How to create a bundle with bundle items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bundles' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "quantity": 2,
              "discount_percentage": 10,
              "product_group_id": "5e09cab0-38f0-48ff-9e4f-8212b0bfc588",
              "product_id": "f3d58f76-1c53-4027-9c52-350f3631f179"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "4a36a4e5-143a-4a9f-bf86-7fe5e8e62bbd",
              "product_id": "95ed8282-71e8-40cd-9636-5b9fb8b4e667"
            }
          ]
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e53b06eb-2463-43bb-9a45-456477a90cc4",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-08-05T09:25:35.176540+00:00",
      "updated_at": "2024-08-05T09:25:35.574232+00:00",
      "archived": false,
      "archived_at": null,
      "type": "bundles",
      "name": "iPad Pro Bundle",
      "slug": "ipad-pro-bundle",
      "product_type": "bundle",
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "29286bfe-9241-43b4-8c19-210a6439e9e1"
          },
          {
            "type": "bundle_items",
            "id": "67682eea-fe3f-4a45-9831-69db82d74829"
          },
          {
            "type": "bundle_items",
            "id": "67ef1a4d-08da-4ffc-a85d-158660425f57"
          },
          {
            "type": "bundle_items",
            "id": "dc4ab043-6f19-4bcb-9df2-ae81b94deeef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "29286bfe-9241-43b4-8c19-210a6439e9e1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:35.181697+00:00",
        "updated_at": "2024-08-05T09:25:35.181697+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 1,
        "bundle_id": "e53b06eb-2463-43bb-9a45-456477a90cc4",
        "product_group_id": "5e09cab0-38f0-48ff-9e4f-8212b0bfc588",
        "product_id": "f3d58f76-1c53-4027-9c52-350f3631f179"
      },
      "relationships": {}
    },
    {
      "id": "67682eea-fe3f-4a45-9831-69db82d74829",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:35.184959+00:00",
        "updated_at": "2024-08-05T09:25:35.184959+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "e53b06eb-2463-43bb-9a45-456477a90cc4",
        "product_group_id": "4a36a4e5-143a-4a9f-bf86-7fe5e8e62bbd",
        "product_id": "95ed8282-71e8-40cd-9636-5b9fb8b4e667"
      },
      "relationships": {}
    },
    {
      "id": "67ef1a4d-08da-4ffc-a85d-158660425f57",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:35.187966+00:00",
        "updated_at": "2024-08-05T09:25:35.187966+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 3,
        "bundle_id": "e53b06eb-2463-43bb-9a45-456477a90cc4",
        "product_group_id": "5e09cab0-38f0-48ff-9e4f-8212b0bfc588",
        "product_id": "f3d58f76-1c53-4027-9c52-350f3631f179"
      },
      "relationships": {}
    },
    {
      "id": "dc4ab043-6f19-4bcb-9df2-ae81b94deeef",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:35.190880+00:00",
        "updated_at": "2024-08-05T09:25:35.190880+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 4,
        "bundle_id": "e53b06eb-2463-43bb-9a45-456477a90cc4",
        "product_group_id": "4a36a4e5-143a-4a9f-bf86-7fe5e8e62bbd",
        "product_id": "95ed8282-71e8-40cd-9636-5b9fb8b4e667"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bundles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=photo,bundle_items,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the item
`data[attributes][extra_information]` | **String** <br>Extra information about the item, shown on orders and documents
`data[attributes][remote_photo_url]` | **String** <br>Url to an image on the web
`data[attributes][photo_base64]` | **String** <br>Base64 encoded photo, use this field to store a main photo
`data[attributes][excerpt]` | **String** <br>Excerpt used in the online store
`data[attributes][show_in_store]` | **Boolean** <br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean** <br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean** <br>Whether item is taxable
`data[attributes][bundle_items_attributes][]` | **Array** <br>The bundle items to associate
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][tag_list][]` | **Array** <br>List of tags
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid** <br>The associated Tax category


### Includes

This request accepts the following includes:

`photo`


`bundle_items` => 
`product_group` => 
`photo`




`product` => 
`photo`






`tax_category`






## Updating a bundle



> How to update a bundle with bundle items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundles/a3045d8a-5604-48e2-96d3-179ad4361688' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "a3045d8a-5604-48e2-96d3-179ad4361688",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "5dc9974f-df30-4517-acbf-d11609deb77a",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "7eb4d0eb-7e17-4d28-a3bd-842de0d15c4e",
              "product_id": "2e06e4cd-5766-4f1e-bcf4-70483fd575a6"
            }
          ]
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a3045d8a-5604-48e2-96d3-179ad4361688",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-08-05T09:25:39.293835+00:00",
      "updated_at": "2024-08-05T09:25:40.558554+00:00",
      "archived": false,
      "archived_at": null,
      "type": "bundles",
      "name": "iPad Pro Bundle",
      "slug": "ipad-bundle",
      "product_type": "bundle",
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "d0c395dd-5219-4be7-bad6-5d08707f913e"
          },
          {
            "type": "bundle_items",
            "id": "b33bba57-a7e0-4c66-982f-3504e38d5114"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d0c395dd-5219-4be7-bad6-5d08707f913e",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:40.304595+00:00",
        "updated_at": "2024-08-05T09:25:40.304595+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "a3045d8a-5604-48e2-96d3-179ad4361688",
        "product_group_id": "7eb4d0eb-7e17-4d28-a3bd-842de0d15c4e",
        "product_id": "2e06e4cd-5766-4f1e-bcf4-70483fd575a6"
      },
      "relationships": {}
    },
    {
      "id": "b33bba57-a7e0-4c66-982f-3504e38d5114",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:25:40.307599+00:00",
        "updated_at": "2024-08-05T09:25:40.307599+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 3,
        "bundle_id": "a3045d8a-5604-48e2-96d3-179ad4361688",
        "product_group_id": "7eb4d0eb-7e17-4d28-a3bd-842de0d15c4e",
        "product_id": "2e06e4cd-5766-4f1e-bcf4-70483fd575a6"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=photo,bundle_items,tax_category`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the item
`data[attributes][extra_information]` | **String** <br>Extra information about the item, shown on orders and documents
`data[attributes][remote_photo_url]` | **String** <br>Url to an image on the web
`data[attributes][photo_base64]` | **String** <br>Base64 encoded photo, use this field to store a main photo
`data[attributes][excerpt]` | **String** <br>Excerpt used in the online store
`data[attributes][show_in_store]` | **Boolean** <br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer** <br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean** <br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean** <br>Whether item is taxable
`data[attributes][bundle_items_attributes][]` | **Array** <br>The bundle items to associate
`data[attributes][seo_title]` | **String** <br>SEO title tag
`data[attributes][seo_description]` | **String** <br>SEO meta description tag
`data[attributes][tag_list][]` | **Array** <br>List of tags
`data[attributes][photo_id]` | **Uuid** <br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid** <br>The associated Tax category


### Includes

This request accepts the following includes:

`photo`


`bundle_items` => 
`product_group` => 
`photo`




`product` => 
`photo`






`tax_category`






## Archiving a bundle



> How to delete a bundle:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundles/f03f06ef-0bed-4692-8950-0ad9492cd329' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f03f06ef-0bed-4692-8950-0ad9492cd329",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-08-05T09:25:41.326571+00:00",
      "updated_at": "2024-08-05T09:25:41.450065+00:00",
      "archived": true,
      "archived_at": "2024-08-05T09:25:41.450065+00:00",
      "type": "bundles",
      "name": "iPad Bundle",
      "slug": "ipad-bundle",
      "product_type": "bundle",
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "excerpt": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "seo_title": null,
      "seo_description": null,
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=created_at,updated_at,archived`


### Includes

This request does not accept any includes