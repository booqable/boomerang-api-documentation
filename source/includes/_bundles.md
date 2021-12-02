# Bundles

Bundles allow for a single product to be made up of multiple other products. This makes it possible to track the status of multiple smaller products within a single larger product (the bundle).

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
`type` | **String** `readonly`<br>One of `product_groups`, `products`, `bundles`
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
`sorting_weight` | **Integer**<br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`discountable` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`taxable` | **Boolean**<br>Whether item is taxable
`bundle_items_attributes` | **Array** `writeonly`<br>The bundle items to associate
`tag_list` | **Array**<br>List of tags
`category_ids` | **Array** `writeonly`<br>Categories to associate
`photo_id` | **Uuid**<br>The associated Photo
`tax_category_id` | **Uuid**<br>The associated Tax category


## Relationships
Bundles have the following relationships:

Name | Description
- | -
`photo` | **Photos** `readonly`<br>Associated Photo
`tax_category` | **Tax categories** `readonly`<br>Associated Tax category
`bundle_items` | **Bundle items** `readonly`<br>Associated Bundle items
`categories` | **Categories** `readonly`<br>Associated Categories


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
      "id": "55eab0fa-445b-4829-8a80-3fc0f50ac54f",
      "type": "bundles",
      "attributes": {
        "created_at": "2021-12-02T15:11:14+00:00",
        "updated_at": "2021-12-02T15:11:14+00:00",
        "type": "bundles",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=55eab0fa-445b-4829-8a80-3fc0f50ac54f"
          }
        },
        "categories": {
          "links": {
            "related": "api/boomerang/categories?filter[item_id]=55eab0fa-445b-4829-8a80-3fc0f50ac54f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T15:10:57Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`q` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`type` | **String**<br>`eq`, `not_eq`
`name` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`slug` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`archived_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`extra_information` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`photo_url` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`description` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`sorting_weight` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
    --url 'https://example.booqable.com/api/boomerang/bundles/58b5753a-e9e4-4d93-ad5f-0566b88de0b0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "58b5753a-e9e4-4d93-ad5f-0566b88de0b0",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-12-02T15:11:14+00:00",
      "updated_at": "2021-12-02T15:11:14+00:00",
      "type": "bundles",
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
          "related": "api/boomerang/bundle_items?filter[bundle_id]=58b5753a-e9e4-4d93-ad5f-0566b88de0b0"
        }
      },
      "categories": {
        "links": {
          "related": "api/boomerang/categories?filter[item_id]=58b5753a-e9e4-4d93-ad5f-0566b88de0b0"
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


`categories`






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
              "product_group_id": "5deff92f-6503-4e29-9349-30c5e554bfb5",
              "product_id": "6cb62a55-ad7d-41f7-ab87-23176ae71cf3"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "e09bd921-b5d0-41b5-9a9e-229abd446e71",
              "product_id": "5674d27c-5287-4eb0-ba1f-8a2b7f6e5dc1"
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
    "id": "81f61a2c-fedf-4c13-a230-9fd6ce0747b8",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-12-02T15:11:15+00:00",
      "updated_at": "2021-12-02T15:11:15+00:00",
      "type": "bundles",
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
            "id": "289b76ad-7796-427c-b9a8-cf13566cda44"
          },
          {
            "type": "bundle_items",
            "id": "b33dceb2-6280-4505-bff4-89249ab9353d"
          }
        ]
      },
      "categories": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "289b76ad-7796-427c-b9a8-cf13566cda44",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-12-02T15:11:15+00:00",
        "updated_at": "2021-12-02T15:11:15+00:00",
        "quantity": "2",
        "discount_percentage": 10,
        "position": 1,
        "bundle_id": "81f61a2c-fedf-4c13-a230-9fd6ce0747b8",
        "product_group_id": "5deff92f-6503-4e29-9349-30c5e554bfb5",
        "product_id": "6cb62a55-ad7d-41f7-ab87-23176ae71cf3"
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
      "id": "b33dceb2-6280-4505-bff4-89249ab9353d",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-12-02T15:11:15+00:00",
        "updated_at": "2021-12-02T15:11:15+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "81f61a2c-fedf-4c13-a230-9fd6ce0747b8",
        "product_group_id": "e09bd921-b5d0-41b5-9a9e-229abd446e71",
        "product_id": "5674d27c-5287-4eb0-ba1f-8a2b7f6e5dc1"
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
    "self": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5deff92f-6503-4e29-9349-30c5e554bfb5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6cb62a55-ad7d-41f7-ab87-23176ae71cf3&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=e09bd921-b5d0-41b5-9a9e-229abd446e71&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=5674d27c-5287-4eb0-ba1f-8a2b7f6e5dc1&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5deff92f-6503-4e29-9349-30c5e554bfb5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6cb62a55-ad7d-41f7-ab87-23176ae71cf3&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=e09bd921-b5d0-41b5-9a9e-229abd446e71&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=5674d27c-5287-4eb0-ba1f-8a2b7f6e5dc1&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5deff92f-6503-4e29-9349-30c5e554bfb5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6cb62a55-ad7d-41f7-ab87-23176ae71cf3&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=e09bd921-b5d0-41b5-9a9e-229abd446e71&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=5674d27c-5287-4eb0-ba1f-8a2b7f6e5dc1&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][bundle_items_attributes][]` | **Array**<br>The bundle items to associate
`data[attributes][tag_list][]` | **Array**<br>List of tags
`data[attributes][category_ids][]` | **Array**<br>Categories to associate
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`


`product`




`tax_category`


`categories`






## Updating a bundle



> How to update a bundle with bundle items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundles/1f849d0c-bd96-499f-b32f-aa86c74b63e5' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "1f849d0c-bd96-499f-b32f-aa86c74b63e5",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "c9c86a31-a5a5-4d4c-b870-14035cfc03ee",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "24847433-19e5-46ca-ad45-b667f4809af2",
              "product_id": "472fafc0-c31e-40e8-802b-1672fe690b59"
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
    "id": "1f849d0c-bd96-499f-b32f-aa86c74b63e5",
    "type": "bundles",
    "attributes": {
      "created_at": "2021-12-02T15:11:15+00:00",
      "updated_at": "2021-12-02T15:11:16+00:00",
      "type": "bundles",
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
            "id": "ff61af7b-5d4e-4b0a-a64a-60ed35b0ee23"
          }
        ]
      },
      "categories": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "included": [
    {
      "id": "ff61af7b-5d4e-4b0a-a64a-60ed35b0ee23",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-12-02T15:11:16+00:00",
        "updated_at": "2021-12-02T15:11:16+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "1f849d0c-bd96-499f-b32f-aa86c74b63e5",
        "product_group_id": "24847433-19e5-46ca-ad45-b667f4809af2",
        "product_id": "472fafc0-c31e-40e8-802b-1672fe690b59"
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
`data[attributes][sorting_weight]` | **Integer**<br>Defines sort order in the online store, the lower the weight - the higher it shows up in lists
`data[attributes][discountable]` | **Boolean**<br>Whether discounts should be applied to items in this bundle
`data[attributes][taxable]` | **Boolean**<br>Whether item is taxable
`data[attributes][bundle_items_attributes][]` | **Array**<br>The bundle items to associate
`data[attributes][tag_list][]` | **Array**<br>List of tags
`data[attributes][category_ids][]` | **Array**<br>Categories to associate
`data[attributes][photo_id]` | **Uuid**<br>The associated Photo
`data[attributes][tax_category_id]` | **Uuid**<br>The associated Tax category


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`




`tax_category`


`categories`






## Archiving a bundle



> How to delete a bundle:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundles/403331ec-04fd-4b1f-9919-1e40277c804e' \
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