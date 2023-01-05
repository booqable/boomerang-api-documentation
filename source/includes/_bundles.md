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
      "id": "70a46831-303b-4042-b7e6-6ba6c599f79c",
      "type": "bundles",
      "attributes": {
        "created_at": "2023-01-05T13:42:35+00:00",
        "updated_at": "2023-01-05T13:42:35+00:00",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=70a46831-303b-4042-b7e6-6ba6c599f79c"
          }
        },
        "inventory_levels": {
          "links": {
            "related": "api/boomerang/inventory_levels?filter[item_id]=70a46831-303b-4042-b7e6-6ba6c599f79c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
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
      "id": "7ffb8ecc-9b3e-43c0-a83e-526e6a75e7c3"
    },
    {
      "id": "09676ca0-a84f-4030-bd96-fc839165c91a"
    },
    {
      "id": "1cdb833b-31b4-4da2-8793-33b52f171431"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:42:08Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundles/aa401f34-33b2-43fa-8af0-f22a88f96e40' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "aa401f34-33b2-43fa-8af0-f22a88f96e40",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-01-05T13:42:38+00:00",
      "updated_at": "2023-01-05T13:42:38+00:00",
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
          "related": "api/boomerang/bundle_items?filter[bundle_id]=aa401f34-33b2-43fa-8af0-f22a88f96e40"
        }
      },
      "inventory_levels": {
        "links": {
          "related": "api/boomerang/inventory_levels?filter[item_id]=aa401f34-33b2-43fa-8af0-f22a88f96e40"
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
              "product_group_id": "ab7eeb0a-219d-41b5-9dbc-710346b68793",
              "product_id": "53676725-08c0-4f7d-a3cc-5cc8f976d67e"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "e35b0d2a-60b0-4f54-9bc8-42f61403181d",
              "product_id": "a2ce5fa5-4074-46a5-bee4-1aaae6114cad"
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
    "id": "5fe6f7f4-9777-4d6c-bfd9-85af097add0a",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-01-05T13:42:39+00:00",
      "updated_at": "2023-01-05T13:42:39+00:00",
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
            "id": "155ab81a-ef9c-4654-92d8-01f9d742012f"
          },
          {
            "type": "bundle_items",
            "id": "0011e7c7-667f-41de-979f-58e5f3f847a7"
          },
          {
            "type": "bundle_items",
            "id": "ee4e2e19-0e6e-4cf1-b01e-2ce2bc46718e"
          },
          {
            "type": "bundle_items",
            "id": "a16e23de-4421-4b46-a84c-eeaaafe32e9c"
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
      "id": "155ab81a-ef9c-4654-92d8-01f9d742012f",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:39+00:00",
        "updated_at": "2023-01-05T13:42:39+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 1,
        "bundle_id": "5fe6f7f4-9777-4d6c-bfd9-85af097add0a",
        "product_group_id": "ab7eeb0a-219d-41b5-9dbc-710346b68793",
        "product_id": "53676725-08c0-4f7d-a3cc-5cc8f976d67e"
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
      "id": "0011e7c7-667f-41de-979f-58e5f3f847a7",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:39+00:00",
        "updated_at": "2023-01-05T13:42:39+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "5fe6f7f4-9777-4d6c-bfd9-85af097add0a",
        "product_group_id": "e35b0d2a-60b0-4f54-9bc8-42f61403181d",
        "product_id": "a2ce5fa5-4074-46a5-bee4-1aaae6114cad"
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
      "id": "ee4e2e19-0e6e-4cf1-b01e-2ce2bc46718e",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:39+00:00",
        "updated_at": "2023-01-05T13:42:39+00:00",
        "quantity": 2,
        "discount_percentage": 10.0,
        "position": 3,
        "bundle_id": "5fe6f7f4-9777-4d6c-bfd9-85af097add0a",
        "product_group_id": "ab7eeb0a-219d-41b5-9dbc-710346b68793",
        "product_id": "53676725-08c0-4f7d-a3cc-5cc8f976d67e"
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
      "id": "a16e23de-4421-4b46-a84c-eeaaafe32e9c",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:39+00:00",
        "updated_at": "2023-01-05T13:42:39+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 4,
        "bundle_id": "5fe6f7f4-9777-4d6c-bfd9-85af097add0a",
        "product_group_id": "e35b0d2a-60b0-4f54-9bc8-42f61403181d",
        "product_id": "a2ce5fa5-4074-46a5-bee4-1aaae6114cad"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/9fd7cfd3-ca41-4656-9ba3-08c0887bbb80' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "9fd7cfd3-ca41-4656-9ba3-08c0887bbb80",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "4495cea5-e465-442a-b4e5-87c71da7589a",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "ac0a5f9b-14d5-474d-be5f-ce4354b160e1",
              "product_id": "e94d7f71-b848-4004-994e-e9cc5b728b05"
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
    "id": "9fd7cfd3-ca41-4656-9ba3-08c0887bbb80",
    "type": "bundles",
    "attributes": {
      "created_at": "2023-01-05T13:42:39+00:00",
      "updated_at": "2023-01-05T13:42:40+00:00",
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
            "id": "2c7d34a2-22fa-42cd-8e85-4ae4a9fe4aa0"
          },
          {
            "type": "bundle_items",
            "id": "5a82d089-8951-4532-b974-a41b93dfe0b2"
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
      "id": "2c7d34a2-22fa-42cd-8e85-4ae4a9fe4aa0",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:40+00:00",
        "updated_at": "2023-01-05T13:42:40+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 2,
        "bundle_id": "9fd7cfd3-ca41-4656-9ba3-08c0887bbb80",
        "product_group_id": "ac0a5f9b-14d5-474d-be5f-ce4354b160e1",
        "product_id": "e94d7f71-b848-4004-994e-e9cc5b728b05"
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
      "id": "5a82d089-8951-4532-b974-a41b93dfe0b2",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:40+00:00",
        "updated_at": "2023-01-05T13:42:40+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 3,
        "bundle_id": "9fd7cfd3-ca41-4656-9ba3-08c0887bbb80",
        "product_group_id": "ac0a5f9b-14d5-474d-be5f-ce4354b160e1",
        "product_id": "e94d7f71-b848-4004-994e-e9cc5b728b05"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/9c37e438-8976-464f-9d04-74e150341d6b' \
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