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


## Relationships
Bundles have the following relationships:

Name | Description
- | -
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
      "id": "f7e927c2-e1ed-4130-8ce7-e709c7b90cc2",
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
        "tag_list": []
      },
      "relationships": {
        "bundle_items": {
          "links": {
            "related": "api/boomerang/bundle_items?filter[bundle_id]=f7e927c2-e1ed-4130-8ce7-e709c7b90cc2"
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
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-20T13:38:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundles/abd76c50-690b-4ed1-8b39-68775325ce4a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "abd76c50-690b-4ed1-8b39-68775325ce4a",
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
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "links": {
          "related": "api/boomerang/bundle_items?filter[bundle_id]=abd76c50-690b-4ed1-8b39-68775325ce4a"
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
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle_items` => 
`product_group`


`product`




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
              "product_group_id": "21cd8380-865c-4e59-a54b-ffc0244deef5",
              "product_id": "6b7d86fb-0a96-4518-a1cb-81c93a10cfa4"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "5cf817de-e48d-443e-bc34-50db2ff2890c",
              "product_id": "2eb1415d-1129-49e8-b5c6-1f10f75d6bf8"
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
    "id": "3787a24d-9abd-419d-8816-29a3044d708b",
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
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "37a980d8-24db-4cef-99f6-ec85667922d7"
          },
          {
            "type": "bundle_items",
            "id": "302ea79f-b2a6-4638-a060-8bf51bf55ef3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "37a980d8-24db-4cef-99f6-ec85667922d7",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 10,
        "position": 1,
        "bundle_id": "3787a24d-9abd-419d-8816-29a3044d708b",
        "product_group_id": "21cd8380-865c-4e59-a54b-ffc0244deef5",
        "product_id": "6b7d86fb-0a96-4518-a1cb-81c93a10cfa4"
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
      "id": "302ea79f-b2a6-4638-a060-8bf51bf55ef3",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "3787a24d-9abd-419d-8816-29a3044d708b",
        "product_group_id": "5cf817de-e48d-443e-bc34-50db2ff2890c",
        "product_id": "2eb1415d-1129-49e8-b5c6-1f10f75d6bf8"
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
    "self": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=21cd8380-865c-4e59-a54b-ffc0244deef5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6b7d86fb-0a96-4518-a1cb-81c93a10cfa4&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5cf817de-e48d-443e-bc34-50db2ff2890c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=2eb1415d-1129-49e8-b5c6-1f10f75d6bf8&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=21cd8380-865c-4e59-a54b-ffc0244deef5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6b7d86fb-0a96-4518-a1cb-81c93a10cfa4&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5cf817de-e48d-443e-bc34-50db2ff2890c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=2eb1415d-1129-49e8-b5c6-1f10f75d6bf8&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=21cd8380-865c-4e59-a54b-ffc0244deef5&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=6b7d86fb-0a96-4518-a1cb-81c93a10cfa4&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=5cf817de-e48d-443e-bc34-50db2ff2890c&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=2eb1415d-1129-49e8-b5c6-1f10f75d6bf8&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items`
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

`bundle_items` => 
`product_group`


`product`




`tax_category`


`products`






## Updating a bundle

> How to update a bundle with bundle items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundles/e15d57ea-1875-4bf8-8b7c-3331fbd42405' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "e15d57ea-1875-4bf8-8b7c-3331fbd42405",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "9dee9777-6776-4314-b057-d4be02d73be8",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "e62388d2-ee39-4373-a1f2-1a055e4821d5",
              "product_id": "474de1c0-f35a-4a6c-a52e-d6ebbb5fef1d"
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
    "id": "e15d57ea-1875-4bf8-8b7c-3331fbd42405",
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
      "tag_list": []
    },
    "relationships": {
      "bundle_items": {
        "data": [
          {
            "type": "bundle_items",
            "id": "0925041e-c8b0-493c-8441-c4885a561506"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0925041e-c8b0-493c-8441-c4885a561506",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "e15d57ea-1875-4bf8-8b7c-3331fbd42405",
        "product_group_id": "e62388d2-ee39-4373-a1f2-1a055e4821d5",
        "product_id": "474de1c0-f35a-4a6c-a52e-d6ebbb5fef1d"
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
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items`
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

`bundle_items` => 
`product_group`


`product`




`tax_category`






## Archiving a bundle

> How to delete a bundle:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundles/78096256-11cf-4583-8fd5-2adb316c62d8' \
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
`include` | **String**<br>List of comma seperated relationships `?include=bundle_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundles]=id,created_at,updated_at`


### Includes

This request does not accept any includes