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
      "id": "cd35b7e6-3744-4256-b205-6657ac8a70d2",
      "type": "bundles",
      "attributes": {
        "created_at": "2024-07-22T09:28:32.880351+00:00",
        "updated_at": "2024-07-22T09:28:32.880351+00:00",
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
      "id": "35a61b7f-b3b1-4fe8-a95e-14df087e64a6"
    },
    {
      "id": "bdb18f9d-1d30-47b5-abc7-63d0a2b4c336"
    },
    {
      "id": "93b7e4cf-2e7e-4d74-9315-15e337d58862"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/13e6cc38-30bf-4ab7-a528-51f2dadd9b45' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "13e6cc38-30bf-4ab7-a528-51f2dadd9b45",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-07-22T09:28:36.827323+00:00",
      "updated_at": "2024-07-22T09:28:36.827323+00:00",
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
              "product_group_id": "a56a117b-5101-47a0-a8af-0f7e5231531d",
              "product_id": "3b76b92c-5968-4afc-af20-fb4607c5b547"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "111c142f-d94c-4371-becf-d724c8626375",
              "product_id": "c241d518-ce13-420b-9bf5-0d795690168c"
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
    "id": "078ad43b-1c50-42fe-acbf-510afd458a82",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-07-22T09:28:42.144662+00:00",
      "updated_at": "2024-07-22T09:28:42.698907+00:00",
      "archived": false,
      "archived_at": null,
      "type": "bundles",
      "name": "iPad Pro Bundle",
      "slug": "ipad-pro-bundle",
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
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "fde98636-84a9-475d-b180-90899db960b0"
          },
          {
            "type": "bundle_items",
            "id": "890c658e-ff28-4e31-bde0-645b935d0b41"
          },
          {
            "type": "bundle_items",
            "id": "e1f81391-b12e-4186-bc86-696b59ec7dc7"
          },
          {
            "type": "bundle_items",
            "id": "d16b066d-ce06-4090-9f58-87382cff5cf3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "fde98636-84a9-475d-b180-90899db960b0",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:42.150516+00:00",
        "updated_at": "2024-07-22T09:28:42.150516+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 1,
        "bundle_id": "078ad43b-1c50-42fe-acbf-510afd458a82",
        "product_group_id": "a56a117b-5101-47a0-a8af-0f7e5231531d",
        "product_id": "3b76b92c-5968-4afc-af20-fb4607c5b547"
      },
      "relationships": {}
    },
    {
      "id": "890c658e-ff28-4e31-bde0-645b935d0b41",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:42.154412+00:00",
        "updated_at": "2024-07-22T09:28:42.154412+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "078ad43b-1c50-42fe-acbf-510afd458a82",
        "product_group_id": "111c142f-d94c-4371-becf-d724c8626375",
        "product_id": "c241d518-ce13-420b-9bf5-0d795690168c"
      },
      "relationships": {}
    },
    {
      "id": "e1f81391-b12e-4186-bc86-696b59ec7dc7",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:42.158303+00:00",
        "updated_at": "2024-07-22T09:28:42.158303+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 3,
        "bundle_id": "078ad43b-1c50-42fe-acbf-510afd458a82",
        "product_group_id": "a56a117b-5101-47a0-a8af-0f7e5231531d",
        "product_id": "3b76b92c-5968-4afc-af20-fb4607c5b547"
      },
      "relationships": {}
    },
    {
      "id": "d16b066d-ce06-4090-9f58-87382cff5cf3",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:42.162067+00:00",
        "updated_at": "2024-07-22T09:28:42.162067+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 4,
        "bundle_id": "078ad43b-1c50-42fe-acbf-510afd458a82",
        "product_group_id": "111c142f-d94c-4371-becf-d724c8626375",
        "product_id": "c241d518-ce13-420b-9bf5-0d795690168c"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/21d4bce0-0dbb-4d19-85d5-28d240c9f793' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "21d4bce0-0dbb-4d19-85d5-28d240c9f793",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "c738c950-3c80-4276-82d9-d35e96a537b4",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "e64d3a78-9c4f-4b91-863c-462e0f8756a5",
              "product_id": "37ec6c58-afca-4ecc-872c-aeffdc1c6bf1"
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
    "id": "21d4bce0-0dbb-4d19-85d5-28d240c9f793",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-07-22T09:28:33.750290+00:00",
      "updated_at": "2024-07-22T09:28:35.547772+00:00",
      "archived": false,
      "archived_at": null,
      "type": "bundles",
      "name": "iPad Pro Bundle",
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
      "tag_list": [],
      "photo_id": null,
      "tax_category_id": null
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "659b434c-54c2-48e4-abff-de549f9f5f1d"
          },
          {
            "type": "bundle_items",
            "id": "4b9aa72b-55cc-43c5-9e2f-26d0e6fd71ed"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "659b434c-54c2-48e4-abff-de549f9f5f1d",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:35.114457+00:00",
        "updated_at": "2024-07-22T09:28:35.114457+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "21d4bce0-0dbb-4d19-85d5-28d240c9f793",
        "product_group_id": "e64d3a78-9c4f-4b91-863c-462e0f8756a5",
        "product_id": "37ec6c58-afca-4ecc-872c-aeffdc1c6bf1"
      },
      "relationships": {}
    },
    {
      "id": "4b9aa72b-55cc-43c5-9e2f-26d0e6fd71ed",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:35.119260+00:00",
        "updated_at": "2024-07-22T09:28:35.119260+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 3,
        "bundle_id": "21d4bce0-0dbb-4d19-85d5-28d240c9f793",
        "product_group_id": "e64d3a78-9c4f-4b91-863c-462e0f8756a5",
        "product_id": "37ec6c58-afca-4ecc-872c-aeffdc1c6bf1"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/a2a0a363-f945-456b-b103-0132dcedde77' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a2a0a363-f945-456b-b103-0132dcedde77",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-07-22T09:28:37.574547+00:00",
      "updated_at": "2024-07-22T09:28:37.750741+00:00",
      "archived": true,
      "archived_at": "2024-07-22T09:28:37.750741+00:00",
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