# Bundles

Bundles allow for a single product to be made up of multiple other booqable products from within Booqable. This makes it possible for you to track the status of multiple smaller products within a single larger products (the bundle).

## Endpoints
`GET /api/boomerang/bundles`

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
`name` | **String**<br>Name of the item
`slug` | **String** `readonly`<br>Slug of the item
`product_type` | **String** `readonly`<br>One of `rental`, `consumable`, `service`
`archived` | **Boolean** `readonly`<br>Whether item is archived
`archived_at` | **Datetime** `readonly`<br>When the item was archived
`extra_information` | **String** `nullable`<br>Extra information about the item, shown on orders and documents
`photo_url` | **String** `readonly`<br>Main photo url
`photo_base64` | **String** `writeonly`<br>Base64 encoded photo, use this field to store a main photo
`description` | **String** `nullable`<br>Description used in the online store
`show_in_store` | **Boolean**<br>Whether to show this item in the online
`sorting_weight` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`discountable` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`taxable` | **Boolean**<br>Whether item is taxable
`type` | **String**<br>One of `ProductGroup`, `Product`, `Bundle`
`bundle_items_attributes` | **Array** `writeonly`<br>The bundle items to associate
`tag_list` | **Array**<br>List of tags


## Relationships
Bundles have the following relationships:

Name | Description
- | -
`bundle_items` | **Bundle items** `readonly`<br>Associated Bundle items
`products` | **Products** `readonly`<br>Associated Products


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
      "id": "aa85017c-da4f-486e-9c1f-5fc9c8c80643",
      "type": "bundles",
      "attributes": {
        "created_at": "2021-10-13T22:09:24+00:00",
        "updated_at": "2021-10-13T22:09:24+00:00",
        "name": "iPad Bundle",
        "slug": "ipad-bundle",
        "product_type": "bundle",
        "archived": false,
        "archived_at": null,
        "extra_information": null,
        "photo_url": null,
        "description": null,
        "show_in_store": true,
        "sorting_weight": 0,
        "discountable": true,
        "taxable": true,
        "type": "Bundle",
        "tag_list": []
      },
      "relationships": {
        "bundle_items": {
          "links": {
            "related": "api/boomerang/bundle_items?filter[bundle_id]=aa85017c-da4f-486e-9c1f-5fc9c8c80643"
          }
        },
        "products": {
          "links": {
            "related": "api/boomerang/products?filter[bundle_id]=aa85017c-da4f-486e-9c1f-5fc9c8c80643"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-13T22:09:22Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[per]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_url` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`type` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`product_type` | **Array**<br>`count`
`archived` | **Array**<br>`count`
`show_in_store` | **Array**<br>`count`
`discountable` | **Array**<br>`count`
`taxable` | **Array**<br>`count`
`tag_list` | **Array**<br>`count`
`total` | **Array**<br>`count`
`tax_category_id` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a bundle

> How to fetch a bundle:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundles/7fd7f2a3-0578-4246-8c77-84d5f8da6346' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7fd7f2a3-0578-4246-8c77-84d5f8da6346",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-10-13T22:09:25+00:00",
      "updated_at": "2021-10-13T22:09:25+00:00",
      "name": "iPad Bundle",
      "slug": "ipad-bundle",
      "product_type": "bundle",
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "type": "Bundle",
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "links": {
          "related": "api/boomerang/bundle_items?filter[bundle_id]=7fd7f2a3-0578-4246-8c77-84d5f8da6346"
        }
      },
      "products": {
        "links": {
          "related": "api/boomerang/products?filter[bundle_id]=7fd7f2a3-0578-4246-8c77-84d5f8da6346"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle_items`


`tax_category`


`products`






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
              "product_group_id": "bd99e4d1-3fde-4c64-82ec-01ec23041152",
              "product_id": "d4c1da68-d441-45c9-b84f-17f5b198ac3b"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "1984e376-40a5-42ee-b280-6ed4ae2dba3b",
              "product_id": "3b733798-db46-4904-81dd-36f435cdba6f"
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
    "id": "2f0ea477-ec46-4dee-afb3-960d8e4d627a",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-10-13T22:09:27+00:00",
      "updated_at": "2021-10-13T22:09:27+00:00",
      "name": "iPad Pro Bundle",
      "slug": "ipad-pro-bundle",
      "product_type": "bundle",
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "type": "Bundle",
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "105364df-a503-45b5-831e-1dce820a08ac"
          },
          {
            "type": "bundle_items",
            "id": "7fd1c5e7-71e9-4e0f-8cd9-e42b2dd9ee12"
          }
        ]
      },
      "products": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "105364df-a503-45b5-831e-1dce820a08ac",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-10-13T22:09:27+00:00",
        "updated_at": "2021-10-13T22:09:27+00:00",
        "quantity": "2",
        "discount_percentage": 10,
        "position": 1,
        "bundle_id": "2f0ea477-ec46-4dee-afb3-960d8e4d627a",
        "product_group_id": "bd99e4d1-3fde-4c64-82ec-01ec23041152",
        "product_id": "d4c1da68-d441-45c9-b84f-17f5b198ac3b"
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
      "id": "7fd1c5e7-71e9-4e0f-8cd9-e42b2dd9ee12",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-10-13T22:09:27+00:00",
        "updated_at": "2021-10-13T22:09:27+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "2f0ea477-ec46-4dee-afb3-960d8e4d627a",
        "product_group_id": "1984e376-40a5-42ee-b280-6ed4ae2dba3b",
        "product_id": "3b733798-db46-4904-81dd-36f435cdba6f"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the item
`data[attributes][extra_information]` | **String**<br>Extra information about the item, shown on orders and documents
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][show_in_store]` | **Boolean**<br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][type]` | **String**<br>One of `ProductGroup`, `Product`, `Bundle`
`data[attributes][bundle_items_attributes][]` | **Array**<br>The bundle items to associate
`data[attributes][tag_list][]` | **Array**<br>List of tags


### Includes

This request accepts the following includes:

`bundle_items`


`tax_category`


`products`






## Updating a bundle

> How to update a bundle with bundle items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundles/323a9c44-d5a6-4f42-a254-630dd522f4e1' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "323a9c44-d5a6-4f42-a254-630dd522f4e1",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "f3fac545-2e04-4718-9e52-4abd6fd09be8",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "13b57c3c-162a-453c-8a65-62f5bfe78457",
              "product_id": "719bfa4f-c16b-4435-b3e1-026c32f3e2d7"
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
    "id": "323a9c44-d5a6-4f42-a254-630dd522f4e1",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-10-13T22:09:27+00:00",
      "updated_at": "2021-10-13T22:09:27+00:00",
      "name": "iPad Pro Bundle",
      "slug": "ipad-bundle",
      "product_type": "bundle",
      "archived": false,
      "archived_at": null,
      "extra_information": null,
      "photo_url": null,
      "description": null,
      "show_in_store": true,
      "sorting_weight": 0,
      "discountable": true,
      "taxable": true,
      "type": "Bundle",
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "6e672b04-9a1f-447d-b747-ca2879197fc3"
          }
        ]
      },
      "products": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "6e672b04-9a1f-447d-b747-ca2879197fc3",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-10-13T22:09:27+00:00",
        "updated_at": "2021-10-13T22:09:27+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "323a9c44-d5a6-4f42-a254-630dd522f4e1",
        "product_group_id": "13b57c3c-162a-453c-8a65-62f5bfe78457",
        "product_id": "719bfa4f-c16b-4435-b3e1-026c32f3e2d7"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the item
`data[attributes][extra_information]` | **String**<br>Extra information about the item, shown on orders and documents
`data[attributes][photo_base64]` | **String**<br>Base64 encoded photo, use this field to store a main photo
`data[attributes][show_in_store]` | **Boolean**<br>Whether to show this item in the online
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the higher the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][type]` | **String**<br>One of `ProductGroup`, `Product`, `Bundle`
`data[attributes][bundle_items_attributes][]` | **Array**<br>The bundle items to associate
`data[attributes][tag_list][]` | **Array**<br>List of tags


### Includes

This request accepts the following includes:

`bundle_items`


`tax_category`


`products`






## Archiving a bundle

> How to delete a bundle:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundles/122d1c3d-aa7f-4ccd-bea2-5e216e17e4bd' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items,products`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request does not accept any includes