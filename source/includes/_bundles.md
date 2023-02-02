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
- | -
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
- | -
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
      "id": "e2ca0e77-0a79-4877-82bd-cefaa8ce2d91",
      "type": "bundles",
      "attributes": {
        "created_at": "2023-02-02T16:28:24+00:00",
        "updated_at": "2023-02-02T16:28:24+00:00",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=e2ca0e77-0a79-4877-82bd-cefaa8ce2d91"
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=e2ca0e77-0a79-4877-82bd-cefaa8ce2d91"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:50Z`
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
- | -
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
      "id": "3dfb0cb6-4841-4817-bf10-d53c3dbe5ba7"
    },
    {
      "id": "b85aea58-d00c-4cf6-a604-e36a0db98336"
    },
    {
      "id": "f6499e44-0324-41e2-958e-718c11333404"
    }
  ]
}
```

### HTTP Request

`POST api/boomerang/bundles/search`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T16:27:50Z`
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
- | -
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
    --url 'https://example.booqable.com/api/boomerang/bundles/16d5429d-78d7-48db-8d09-fde3078bcfed' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "16d5429d-78d7-48db-8d09-fde3078bcfed",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-02-02T16:28:26+00:00",
      "updated_at": "2023-02-02T16:28:26+00:00",
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
          "related": "api/boomerang/bundle_items?filter[bundle_id]=16d5429d-78d7-48db-8d09-fde3078bcfed"
        }
      },
      "inventory_levels": {
        "links": {
          "related": "api/boomerang/inventory_levels?filter[item_id]=16d5429d-78d7-48db-8d09-fde3078bcfed"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


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
              "product_group_id": "24003158-d8cc-4b4b-9e10-57011f671134",
              "product_id": "742d8e81-bc0b-4cdf-a787-9d0f01d75131"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "d24ae688-33e3-4c71-922f-33ab0ff9b37e",
              "product_id": "b64016f9-c79e-4275-8657-9603cd4eeb38"
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
    "id": "c174b9b8-2b57-4d88-b676-567a8e5c759a",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-02-02T16:28:27+00:00",
      "updated_at": "2023-02-02T16:28:27+00:00",
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
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "ebb943d4-e963-4f31-81e9-ff22af4bde8d"
          },
          {
            "type": "bundle_items",
            "id": "2e974439-a7f7-4820-981c-c0b160fd71e8"
          },
          {
            "type": "bundle_items",
            "id": "02a8d2dc-49d0-4ec7-bce2-dd7da6734662"
          },
          {
            "type": "bundle_items",
            "id": "f584a0c2-3df8-442b-b93f-c096db613f7a"
          }
        ]
      },
      "inventory_levels": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "ebb943d4-e963-4f31-81e9-ff22af4bde8d",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:27+00:00",
        "updated_at": "2023-02-02T16:28:27+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 1,
        "bundle_id": "c174b9b8-2b57-4d88-b676-567a8e5c759a",
        "product_group_id": "24003158-d8cc-4b4b-9e10-57011f671134",
        "product_id": "742d8e81-bc0b-4cdf-a787-9d0f01d75131"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "2e974439-a7f7-4820-981c-c0b160fd71e8",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:27+00:00",
        "updated_at": "2023-02-02T16:28:27+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "c174b9b8-2b57-4d88-b676-567a8e5c759a",
        "product_group_id": "d24ae688-33e3-4c71-922f-33ab0ff9b37e",
        "product_id": "b64016f9-c79e-4275-8657-9603cd4eeb38"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "02a8d2dc-49d0-4ec7-bce2-dd7da6734662",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:27+00:00",
        "updated_at": "2023-02-02T16:28:27+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 3,
        "bundle_id": "c174b9b8-2b57-4d88-b676-567a8e5c759a",
        "product_group_id": "24003158-d8cc-4b4b-9e10-57011f671134",
        "product_id": "742d8e81-bc0b-4cdf-a787-9d0f01d75131"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "f584a0c2-3df8-442b-b93f-c096db613f7a",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:27+00:00",
        "updated_at": "2023-02-02T16:28:27+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 4,
        "bundle_id": "c174b9b8-2b57-4d88-b676-567a8e5c759a",
        "product_group_id": "d24ae688-33e3-4c71-922f-33ab0ff9b37e",
        "product_id": "b64016f9-c79e-4275-8657-9603cd4eeb38"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/bundles/7889910c-31c7-4211-800b-73956ceeb31a' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "7889910c-31c7-4211-800b-73956ceeb31a",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "b47cd6aa-5e23-4004-954e-ef990b351e31",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "72cf8d51-3e10-46be-a086-f93c6d527454",
              "product_id": "72b2eb4b-8fdd-468d-92a8-bfbef433f9c5"
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
    "id": "7889910c-31c7-4211-800b-73956ceeb31a",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-02-02T16:28:28+00:00",
      "updated_at": "2023-02-02T16:28:28+00:00",
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
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "90ad7a5b-d715-4556-90d7-04d075095b00"
          },
          {
            "type": "bundle_items",
            "id": "f9158e09-5f46-4c04-b35c-932cbbe35f0f"
          }
        ]
      },
      "inventory_levels": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "90ad7a5b-d715-4556-90d7-04d075095b00",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:28+00:00",
        "updated_at": "2023-02-02T16:28:28+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "7889910c-31c7-4211-800b-73956ceeb31a",
        "product_group_id": "72cf8d51-3e10-46be-a086-f93c6d527454",
        "product_id": "72b2eb4b-8fdd-468d-92a8-bfbef433f9c5"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "f9158e09-5f46-4c04-b35c-932cbbe35f0f",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-02T16:28:28+00:00",
        "updated_at": "2023-02-02T16:28:28+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 3,
        "bundle_id": "7889910c-31c7-4211-800b-73956ceeb31a",
        "product_group_id": "72cf8d51-3e10-46be-a086-f93c6d527454",
        "product_id": "72b2eb4b-8fdd-468d-92a8-bfbef433f9c5"
      },
      "relationships": {
        "bundle": {
          "meta": {
            "included": false
          }
        },
        "product_group": {
          "meta": {
            "included": false
          }
        },
        "product": {
          "meta": {
            "included": false
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/bundles/e699f68b-af2d-41f1-a299-51bed80119dc' \
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

`DELETE /api/boomerang/bundles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request does not accept any includes