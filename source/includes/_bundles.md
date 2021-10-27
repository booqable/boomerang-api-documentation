# Bundles

Bundles allow for a single product to be made up of multiple other booqable products from within Booqable. This makes it possible to track the status of multiple smaller products within a single larger product (the bundle).

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
`photo_id` | **Uuid**<br>The associated Photo
`tax_category_id` | **Uuid**<br>The associated Tax category


## Relationships
Bundles have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`bundle_items` | **Bundle items** `readonly`<br>Associated Bundle items


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
      "id": "acbc710d-e046-485d-a39d-5f7291b32a3d",
      "type": "bundles",
      "attributes": {
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=acbc710d-e046-485d-a39d-5f7291b32a3d"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/search/items?filter%5Btype%5D=bundle&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/search/items?filter%5Btype%5D=bundle&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/search/items?filter%5Btype%5D=bundle&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundles`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-27T11:02:32Z`
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
`photo_id` | **Uuid**<br>`eq`, `not_eq`


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
`tax_category_id` | **Array**<br>`count`
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a bundle



> How to fetch a bundle:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundles/73601423-7809-4ad7-94da-de17cbb04ca6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "73601423-7809-4ad7-94da-de17cbb04ca6",
    "type": "bundles",
    "attributes": {
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
          "related": "api/boomerang/bundle_items?filter[bundle_id]=73601423-7809-4ad7-94da-de17cbb04ca6"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`


`product`




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
              "product_group_id": "133133f9-224e-467b-a64d-fabe652ee91c",
              "product_id": "336a18f6-b94f-4575-bec3-f452edfe6a41"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "8676a1e4-e033-4fd2-8a8e-90a1142138ab",
              "product_id": "e493b39e-eb9a-4ae7-8dd8-6706f7b57382"
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
    "id": "0b219d32-5dd6-40c1-937b-84d5c9648ef9",
    "type": "bundles",
    "attributes": {
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
            "id": "f5171981-91d4-40c6-9912-e7d0f92be8cf"
          },
          {
            "type": "bundle_items",
            "id": "fd4bbe0b-1db8-4b8f-9e46-357483bffffe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f5171981-91d4-40c6-9912-e7d0f92be8cf",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 10,
        "position": 1,
        "bundle_id": "0b219d32-5dd6-40c1-937b-84d5c9648ef9",
        "product_group_id": "133133f9-224e-467b-a64d-fabe652ee91c",
        "product_id": "336a18f6-b94f-4575-bec3-f452edfe6a41"
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
      "id": "fd4bbe0b-1db8-4b8f-9e46-357483bffffe",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "0b219d32-5dd6-40c1-937b-84d5c9648ef9",
        "product_group_id": "8676a1e4-e033-4fd2-8a8e-90a1142138ab",
        "product_id": "e493b39e-eb9a-4ae7-8dd8-6706f7b57382"
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
  "links": {
    "self": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=133133f9-224e-467b-a64d-fabe652ee91c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=336a18f6-b94f-4575-bec3-f452edfe6a41&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=8676a1e4-e033-4fd2-8a8e-90a1142138ab&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=e493b39e-eb9a-4ae7-8dd8-6706f7b57382&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=133133f9-224e-467b-a64d-fabe652ee91c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=336a18f6-b94f-4575-bec3-f452edfe6a41&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=8676a1e4-e033-4fd2-8a8e-90a1142138ab&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=e493b39e-eb9a-4ae7-8dd8-6706f7b57382&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=133133f9-224e-467b-a64d-fabe652ee91c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=336a18f6-b94f-4575-bec3-f452edfe6a41&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=8676a1e4-e033-4fd2-8a8e-90a1142138ab&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=e493b39e-eb9a-4ae7-8dd8-6706f7b57382&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bundles`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
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
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`


`product`




`tax_category`






## Updating a bundle



> How to update a bundle with bundle items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundles/a944397e-088c-475e-8d01-9aa672562155' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "a944397e-088c-475e-8d01-9aa672562155",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "845ed373-7e97-4679-a250-13925aeaad37",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "a26b9b3f-b8b9-4a11-938b-7da76d5bd05f",
              "product_id": "11037403-150c-4d92-9383-08562ac5cf52"
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
    "id": "a944397e-088c-475e-8d01-9aa672562155",
    "type": "bundles",
    "attributes": {
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
            "id": "351f348d-d042-48d2-8f56-9804a40b6933"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "351f348d-d042-48d2-8f56-9804a40b6933",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "a944397e-088c-475e-8d01-9aa672562155",
        "product_group_id": "a26b9b3f-b8b9-4a11-938b-7da76d5bd05f",
        "product_id": "11037403-150c-4d92-9383-08562ac5cf52"
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
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
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`




`tax_category`






## Archiving a bundle



> How to delete a bundle:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundles/c49de75b-910c-4e8f-adf8-d232ac1366d3' \
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
`include` | **String**<br>List of comma seperated relationships `?include=photo,tax_category,bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request does not accept any includes