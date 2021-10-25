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
      "id": "7b90714e-ca4b-4dc8-813d-20f3da1331b4",
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
            "related": "api/boomerang/bundle_items?filter[bundle_id]=7b90714e-ca4b-4dc8-813d-20f3da1331b4"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-10-25T12:33:46Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundles/24531278-8468-43fe-b6a3-9aa867b225af' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "24531278-8468-43fe-b6a3-9aa867b225af",
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
          "related": "api/boomerang/bundle_items?filter[bundle_id]=24531278-8468-43fe-b6a3-9aa867b225af"
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
              "product_group_id": "38f2aabd-2be0-49cd-9939-503a5f688224",
              "product_id": "1ab29b09-5fc6-4d6a-945a-14775a10e53a"
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "a9fb949c-758b-4f8c-9a7a-01469ef52dec",
              "product_id": "62ec90c5-fe24-4028-a357-fbf7a31f12a7"
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
    "id": "6e5daf2c-88cd-4bc5-940b-73b6920720a5",
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
            "id": "c4888521-b3bc-46ab-9f6f-d44430c1ad1f"
          },
          {
            "type": "bundle_items",
            "id": "51818180-f555-430f-945d-425678dae2ac"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c4888521-b3bc-46ab-9f6f-d44430c1ad1f",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 10,
        "position": 1,
        "bundle_id": "6e5daf2c-88cd-4bc5-940b-73b6920720a5",
        "product_group_id": "38f2aabd-2be0-49cd-9939-503a5f688224",
        "product_id": "1ab29b09-5fc6-4d6a-945a-14775a10e53a"
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
      "id": "51818180-f555-430f-945d-425678dae2ac",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "6e5daf2c-88cd-4bc5-940b-73b6920720a5",
        "product_group_id": "a9fb949c-758b-4f8c-9a7a-01469ef52dec",
        "product_id": "62ec90c5-fe24-4028-a357-fbf7a31f12a7"
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
    "self": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=38f2aabd-2be0-49cd-9939-503a5f688224&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=1ab29b09-5fc6-4d6a-945a-14775a10e53a&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=a9fb949c-758b-4f8c-9a7a-01469ef52dec&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=62ec90c5-fe24-4028-a357-fbf7a31f12a7&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=38f2aabd-2be0-49cd-9939-503a5f688224&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=1ab29b09-5fc6-4d6a-945a-14775a10e53a&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=a9fb949c-758b-4f8c-9a7a-01469ef52dec&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=62ec90c5-fe24-4028-a357-fbf7a31f12a7&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundles?data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=10&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=38f2aabd-2be0-49cd-9939-503a5f688224&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=1ab29b09-5fc6-4d6a-945a-14775a10e53a&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bquantity%5D=2&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_group_id%5D=a9fb949c-758b-4f8c-9a7a-01469ef52dec&data%5Battributes%5D%5Bbundle_items_attributes%5D%5B%5D%5Bproduct_id%5D=62ec90c5-fe24-4028-a357-fbf7a31f12a7&data%5Battributes%5D%5Bname%5D=iPad+Pro+Bundle&data%5Btype%5D=bundles&include=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/bbe738e9-8714-4f7a-ac44-620690f7363f' \
    --header 'content-type: application/json' \
    --data '{
      "include": "bundle_items",
      "data": {
        "id": "bbe738e9-8714-4f7a-ac44-620690f7363f",
        "type": "bundles",
        "attributes": {
          "name": "iPad Pro Bundle",
          "bundle_items_attributes": [
            {
              "id": "75333052-e54d-4daa-8ff0-17e8453ebc96",
              "_destroy": true
            },
            {
              "quantity": 2,
              "discount_percentage": 15,
              "product_group_id": "e00410cb-eb6d-4bd1-9970-d84a64499fb1",
              "product_id": "f5faef32-e728-4dfd-802e-f3ade8d42b00"
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
    "id": "bbe738e9-8714-4f7a-ac44-620690f7363f",
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
            "id": "07fc1afe-cb26-4899-96c3-b665dbd9df63"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "07fc1afe-cb26-4899-96c3-b665dbd9df63",
      "type": "bundle_items",
      "attributes": {
        "quantity": "2",
        "discount_percentage": 15,
        "position": 2,
        "bundle_id": "bbe738e9-8714-4f7a-ac44-620690f7363f",
        "product_group_id": "e00410cb-eb6d-4bd1-9970-d84a64499fb1",
        "product_id": "f5faef32-e728-4dfd-802e-f3ade8d42b00"
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
    --url 'https://example.booqable.com/api/boomerang/bundles/3cd4ee68-2313-4bb9-a263-56ce64df65e3' \
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