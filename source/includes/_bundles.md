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
`slug` | **String** <br>Slug of the item
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
`photo_id` | **Uuid** `nullable` `readonly`<br>Associated Photo
`tax_category_id` | **Uuid** `nullable`<br>Associated Tax category


## Relationships
Bundles have the following relationships:

Name | Description
-- | --
`bundle_items` | **[Bundle items](#bundle-items)** <br>Associated Bundle items
`inventory_levels` | **[Inventory levels](#inventory-levels)** <br>Associated Inventory levels
`photo` | **[Photo](#photos)** <br>Associated Photo
`tax_category` | **[Tax category](#tax-categories)** <br>Associated Tax category


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
      "id": "2bc8255c-4b99-4f46-ad11-2bd66a4b47ee",
      "type": "bundles",
      "attributes": {
        "created_at": "2024-12-02T13:02:33.706285+00:00",
        "updated_at": "2024-12-02T13:02:33.706285+00:00",
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
`photo_id` | **Uuid** <br>`eq`, `not_eq`
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
      "id": "2ad322c7-0908-462a-a8fe-5f4e752eaace"
    },
    {
      "id": "fe39b15b-7c32-47af-96a4-0940e2932174"
    },
    {
      "id": "06749a32-29c3-44c6-acbf-2c6b6340ae47"
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
`photo_id` | **Uuid** <br>`eq`, `not_eq`
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
    --url 'https://example.booqable.com/api/boomerang/bundles/d6e49911-f1ee-480b-8134-ec446a9dd802' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d6e49911-f1ee-480b-8134-ec446a9dd802",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-12-02T13:02:30.815721+00:00",
      "updated_at": "2024-12-02T13:02:30.815721+00:00",
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


`products` => 
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
              "product_group_id": "e58aa43f-71e0-4247-8d28-e9c35d5f1ff8",
              "product_id": "9c4ac907-6903-4239-a6f0-203358688229"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "9ae7c8a8-2137-4bcd-9bd2-c5cdc266de6d",
              "product_id": "6e5bb0b8-b76a-4a47-a9ef-fc71634e4363"
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
    "id": "8e8773cf-4433-4681-8bf8-9adab95ff241",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-12-02T13:02:28.751295+00:00",
      "updated_at": "2024-12-02T13:02:29.005225+00:00",
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
            "id": "e0becddb-bb15-4192-a67d-e6b97bb9a287"
          },
          {
            "type": "bundle_items",
            "id": "a5e8d6be-4f24-43bb-ba55-1b5f150c6bc0"
          },
          {
            "type": "bundle_items",
            "id": "05569204-5bcc-4508-8c82-23d8e1054f94"
          },
          {
            "type": "bundle_items",
            "id": "6a67aa2b-61d4-4af4-adeb-b0f8a60e8e3b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e0becddb-bb15-4192-a67d-e6b97bb9a287",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:28.754443+00:00",
        "updated_at": "2024-12-02T13:02:28.754443+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 1,
        "bundle_id": "8e8773cf-4433-4681-8bf8-9adab95ff241",
        "product_group_id": "e58aa43f-71e0-4247-8d28-e9c35d5f1ff8",
        "product_id": "9c4ac907-6903-4239-a6f0-203358688229"
      },
      "relationships": {}
    },
    {
      "id": "a5e8d6be-4f24-43bb-ba55-1b5f150c6bc0",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:28.756356+00:00",
        "updated_at": "2024-12-02T13:02:28.756356+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "8e8773cf-4433-4681-8bf8-9adab95ff241",
        "product_group_id": "9ae7c8a8-2137-4bcd-9bd2-c5cdc266de6d",
        "product_id": "6e5bb0b8-b76a-4a47-a9ef-fc71634e4363"
      },
      "relationships": {}
    },
    {
      "id": "05569204-5bcc-4508-8c82-23d8e1054f94",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:28.757772+00:00",
        "updated_at": "2024-12-02T13:02:28.757772+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 3,
        "bundle_id": "8e8773cf-4433-4681-8bf8-9adab95ff241",
        "product_group_id": "e58aa43f-71e0-4247-8d28-e9c35d5f1ff8",
        "product_id": "9c4ac907-6903-4239-a6f0-203358688229"
      },
      "relationships": {}
    },
    {
      "id": "6a67aa2b-61d4-4af4-adeb-b0f8a60e8e3b",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:28.759090+00:00",
        "updated_at": "2024-12-02T13:02:28.759090+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 4,
        "bundle_id": "8e8773cf-4433-4681-8bf8-9adab95ff241",
        "product_group_id": "9ae7c8a8-2137-4bcd-9bd2-c5cdc266de6d",
        "product_id": "6e5bb0b8-b76a-4a47-a9ef-fc71634e4363"
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
`data[attributes][slug]` | **String** <br>Slug of the item
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
`data[attributes][tax_category_id]` | **Uuid** <br>Associated Tax category


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
    --url 'https://example.booqable.com/api/boomerang/bundles/60bdf3c2-598b-40a6-8275-b3cb8736d13e' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "60bdf3c2-598b-40a6-8275-b3cb8736d13e",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "540dba11-087e-4323-b95b-e78ed6e03abf",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "1f7d7ed4-74c1-4951-9c46-93cabf5242a6",
              "product_id": "ed551051-3a2d-4435-b81f-cbc0883db95a"
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
    "id": "60bdf3c2-598b-40a6-8275-b3cb8736d13e",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-12-02T13:02:32.002082+00:00",
      "updated_at": "2024-12-02T13:02:32.872089+00:00",
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
            "id": "db5bd8f5-bf7d-482e-85f8-100db94f8846"
          },
          {
            "type": "bundle_items",
            "id": "9e72be2e-0dff-4dbb-bf6a-ea5649bf7850"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "db5bd8f5-bf7d-482e-85f8-100db94f8846",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:32.656734+00:00",
        "updated_at": "2024-12-02T13:02:32.656734+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "60bdf3c2-598b-40a6-8275-b3cb8736d13e",
        "product_group_id": "1f7d7ed4-74c1-4951-9c46-93cabf5242a6",
        "product_id": "ed551051-3a2d-4435-b81f-cbc0883db95a"
      },
      "relationships": {}
    },
    {
      "id": "9e72be2e-0dff-4dbb-bf6a-ea5649bf7850",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:02:32.658365+00:00",
        "updated_at": "2024-12-02T13:02:32.658365+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 3,
        "bundle_id": "60bdf3c2-598b-40a6-8275-b3cb8736d13e",
        "product_group_id": "1f7d7ed4-74c1-4951-9c46-93cabf5242a6",
        "product_id": "ed551051-3a2d-4435-b81f-cbc0883db95a"
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
`data[attributes][slug]` | **String** <br>Slug of the item
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
`data[attributes][tax_category_id]` | **Uuid** <br>Associated Tax category


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
    --url 'https://example.booqable.com/api/boomerang/bundles/331e8676-1d7f-449b-ace8-5cf08b2cec42' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "331e8676-1d7f-449b-ace8-5cf08b2cec42",
    "type": "bundles",
    "attributes": {
      "created_at": "2024-12-02T13:02:31.396517+00:00",
      "updated_at": "2024-12-02T13:02:31.480428+00:00",
      "archived": true,
      "archived_at": "2024-12-02T13:02:31.480428+00:00",
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