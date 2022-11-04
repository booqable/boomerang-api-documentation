# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`GET /api/boomerang/bundle_items`

`GET /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

`PUT /api/boomerang/bundle_items/{id}`

`DELETE /api/boomerang/bundle_items/{id}`

## Fields
Every bundle item has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`quantity` | **String** <br>The quantity of the item
`discount_percentage` | **Float** <br>The discount percentage for this product when rented out in a bundle
`position` | **Integer** <br>Position of the product in bundle list
`bundle_id` | **Uuid** <br>The associated Bundle
`product_group_id` | **Uuid** <br>The associated Product group
`product_id` | **Uuid** `nullable`<br>The associated Product


## Relationships
Bundle items have the following relationships:

Name | Description
- | -
`bundle` | **Bundles** `readonly`<br>Associated Bundle
`product_group` | **Product groups**<br>Associated Product group
`product` | **Products** `readonly`<br>Associated Product


## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=7875d4e0-98c0-49c6-803c-e1745602d593' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b9231b43-da1c-40c9-9edd-cfe158828c70",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-11-04T15:23:09+00:00",
        "updated_at": "2022-11-04T15:23:09+00:00",
        "quantity": "2",
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "7875d4e0-98c0-49c6-803c-e1745602d593",
        "product_group_id": "16474329-59e9-4aaf-aae4-0e5f310b12aa",
        "product_id": "63cbe763-1bd2-4113-8af6-2cf2d5d47ae9"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/7875d4e0-98c0-49c6-803c-e1745602d593"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/16474329-59e9-4aaf-aae4-0e5f310b12aa"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/63cbe763-1bd2-4113-8af6-2cf2d5d47ae9"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundle_items`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:22:44Z`
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
`quantity` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`position` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`bundle_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`product_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`bundle`


`product` => 
`photo`




`product_group` => 
`photo`








## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/a0ef3fe7-ea87-4420-9783-a8b8867e5646' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0ef3fe7-ea87-4420-9783-a8b8867e5646",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-04T15:23:09+00:00",
      "updated_at": "2022-11-04T15:23:09+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "ccc3b2fa-ae3c-44e2-b68e-8c4e2f2f3de9",
      "product_group_id": "ac6719c6-4335-49ee-8774-58e4169007dd",
      "product_id": "847f33c0-2100-4c44-b54b-b2aac86644c6"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/ccc3b2fa-ae3c-44e2-b68e-8c4e2f2f3de9"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/ac6719c6-4335-49ee-8774-58e4169007dd"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/847f33c0-2100-4c44-b54b-b2aac86644c6"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle`


`product` => 
`photo`




`product_group` => 
`photo`








## Creating a bundle item



> How to create a bundle item:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/bundle_items' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "bundle_items",
        "attributes": {
          "bundle_id": "efbe4106-faf0-4d41-8fdd-4a229eb57141",
          "product_group_id": "88202ac1-d018-4a5d-85a0-f40ceddf31f0",
          "product_id": "546e9313-74b7-4bfe-a4b1-8936b81f3aa5",
          "quantity": 2,
          "discount_percentage": 15
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "1b904c90-f8dd-4ae6-99ba-0444df1788eb",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-04T15:23:10+00:00",
      "updated_at": "2022-11-04T15:23:10+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "efbe4106-faf0-4d41-8fdd-4a229eb57141",
      "product_group_id": "88202ac1-d018-4a5d-85a0-f40ceddf31f0",
      "product_id": "546e9313-74b7-4bfe-a4b1-8936b81f3aa5"
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
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bundle_items`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String** <br>The quantity of the item
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer** <br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid** <br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][product_id]` | **Uuid** <br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product` => 
`photo`




`product_group` => 
`photo`








## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/f9a89983-dce0-4576-9b10-6e76c9cab126' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f9a89983-dce0-4576-9b10-6e76c9cab126",
        "type": "bundle_items",
        "attributes": {
          "quantity": 3,
          "discount_percentage": 20
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f9a89983-dce0-4576-9b10-6e76c9cab126",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-04T15:23:10+00:00",
      "updated_at": "2022-11-04T15:23:10+00:00",
      "quantity": "3",
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "e187ea41-d351-48e5-b3ff-7e239b9baf9c",
      "product_group_id": "fb7fb861-7ec0-442c-84ff-50d96a5f2fc2",
      "product_id": "c6e7f840-7542-4e39-ab82-206d0a64e975"
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
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String** <br>The quantity of the item
`data[attributes][discount_percentage]` | **Float** <br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer** <br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid** <br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid** <br>The associated Product group
`data[attributes][product_id]` | **Uuid** <br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product` => 
`photo`




`product_group` => 
`photo`








## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/8edbd50c-086e-4d54-9229-a5e3291a0e67' \
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

`DELETE /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes