# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`GET /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

`PUT /api/boomerang/bundle_items/{id}`

## Fields
Every bundle item has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`quantity` | **Integer** <br>The quantity of the item
`discount_percentage` | **Float** <br>The discount percentage for this product when rented out in a bundle
`position` | **Integer** <br>Position of the product in bundle list
`bundle_id` | **Uuid** <br>The associated Bundle
`product_group_id` | **Uuid** <br>The associated Product group
`product_id` | **Uuid** `nullable`<br>The associated Product


## Relationships
Bundle items have the following relationships:

Name | Description
-- | --
`bundle` | **Bundles** `readonly`<br>Associated Bundle
`product_group` | **Product groups**<br>Associated Product group
`product` | **Products** `readonly`<br>Associated Product


## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=470037f0-426f-4f2c-86d7-1c18b0e4cb2d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "210a3fe2-8ec4-429d-a01b-29ea359c4171",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-05-27T09:24:22.060020+00:00",
        "updated_at": "2024-05-27T09:24:22.060020+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "470037f0-426f-4f2c-86d7-1c18b0e4cb2d",
        "product_group_id": "879e59f5-df9c-4164-8c98-ef0e19c46727",
        "product_id": "9af53ba7-7c4e-4c2f-988b-9fc28d99d364"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/470037f0-426f-4f2c-86d7-1c18b0e4cb2d"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/879e59f5-df9c-4164-8c98-ef0e19c46727"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/9af53ba7-7c4e-4c2f-988b-9fc28d99d364"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`
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
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`discount_percentage` | **Float** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`position` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`bundle_id` | **Uuid** <br>`eq`, `not_eq`
`product_group_id` | **Uuid** <br>`eq`, `not_eq`
`product_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/f328ae9e-2312-4783-8d3a-84ab0bb117c8' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f328ae9e-2312-4783-8d3a-84ab0bb117c8",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-27T09:24:23.275555+00:00",
      "updated_at": "2024-05-27T09:24:23.275555+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "4ea57af7-febb-40c6-b999-8bd03d73a316",
      "product_group_id": "fff871a8-632d-43aa-9510-bd1dc94c5521",
      "product_id": "dc0477b9-9df8-46c5-be34-f0ca9149e5bf"
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

`DELETE /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Includes

This request does not accept any includes
## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/be4ef1a3-0d68-4a24-be96-d8f82ff8bf79' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be4ef1a3-0d68-4a24-be96-d8f82ff8bf79",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-27T09:24:24.606333+00:00",
      "updated_at": "2024-05-27T09:24:24.606333+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "ff3d5ae6-8b4f-41ce-8a04-705f22db6a96",
      "product_group_id": "4b7d3994-d8a6-4686-b8a7-0f49f32061ed",
      "product_id": "b69dcb2f-195e-4df3-9f96-68013d2f4598"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/ff3d5ae6-8b4f-41ce-8a04-705f22db6a96"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/4b7d3994-d8a6-4686-b8a7-0f49f32061ed"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/b69dcb2f-195e-4df3-9f96-68013d2f4598"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


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
          "bundle_id": "ff804f6e-b2a6-4ec6-84f0-c672c25ea1c2",
          "product_group_id": "a249230f-a6a6-4172-98eb-81a812580c36",
          "product_id": "7c488fa4-835b-49fb-941b-8d48dbf0f035",
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
    "id": "46cc0d5e-ede2-4f0f-9b98-73a65a11569d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-27T09:24:26.093979+00:00",
      "updated_at": "2024-05-27T09:24:26.093979+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "ff804f6e-b2a6-4ec6-84f0-c672c25ea1c2",
      "product_group_id": "a249230f-a6a6-4172-98eb-81a812580c36",
      "product_id": "7c488fa4-835b-49fb-941b-8d48dbf0f035"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][quantity]` | **Integer** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/21a546a9-9831-4cda-9558-ac076aeb7dd2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "21a546a9-9831-4cda-9558-ac076aeb7dd2",
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
    "id": "21a546a9-9831-4cda-9558-ac076aeb7dd2",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-27T09:24:27.350144+00:00",
      "updated_at": "2024-05-27T09:24:27.452846+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "6a526d3b-f9bb-40a9-906d-47edc5a3982a",
      "product_group_id": "4dc0b79d-b366-4481-9403-6575f65953b7",
      "product_id": "83304941-8f2a-4dcb-b86f-a10d10697e79"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][quantity]` | **Integer** <br>The quantity of the item
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







