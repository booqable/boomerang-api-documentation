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
`quantity` | **Integer** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=f1a52d14-9c22-4d8b-8755-6a696bf74c0b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "427167d1-3a87-4f89-a780-7ea38e79375a",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-20T11:45:44+00:00",
        "updated_at": "2023-02-20T11:45:44+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "f1a52d14-9c22-4d8b-8755-6a696bf74c0b",
        "product_group_id": "f8e50808-5481-4dcd-9074-13ab9c58807a",
        "product_id": "ba332502-e18d-426b-9df5-7d196407c3dc"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/f1a52d14-9c22-4d8b-8755-6a696bf74c0b"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/f8e50808-5481-4dcd-9074-13ab9c58807a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ba332502-e18d-426b-9df5-7d196407c3dc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-20T11:45:20Z`
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
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/946dc3ff-43de-4e7d-add3-d5de90af5ef4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "946dc3ff-43de-4e7d-add3-d5de90af5ef4",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-20T11:45:44+00:00",
      "updated_at": "2023-02-20T11:45:44+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "f19d6f08-bf50-4a91-b78f-ba2f5acfbeea",
      "product_group_id": "e2f9c276-d0bb-4552-a809-35ae3c22b626",
      "product_id": "7ee3d583-b55e-491b-8f5a-f3b7ab3d10c8"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/f19d6f08-bf50-4a91-b78f-ba2f5acfbeea"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/e2f9c276-d0bb-4552-a809-35ae3c22b626"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/7ee3d583-b55e-491b-8f5a-f3b7ab3d10c8"
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
          "bundle_id": "3c65855d-acf8-4464-966a-fae89499223f",
          "product_group_id": "bfe32a2a-36bc-411e-b2f9-1b580ef6b6a6",
          "product_id": "050b58fb-f629-4f16-b180-21991cf48a98",
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
    "id": "2636ec7c-56f7-4256-b989-4bc42db4900e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-20T11:45:45+00:00",
      "updated_at": "2023-02-20T11:45:45+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "3c65855d-acf8-4464-966a-fae89499223f",
      "product_group_id": "bfe32a2a-36bc-411e-b2f9-1b580ef6b6a6",
      "product_id": "050b58fb-f629-4f16-b180-21991cf48a98"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/fdf01a99-9675-421d-b79d-4fec45b38b7f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fdf01a99-9675-421d-b79d-4fec45b38b7f",
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
    "id": "fdf01a99-9675-421d-b79d-4fec45b38b7f",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-20T11:45:45+00:00",
      "updated_at": "2023-02-20T11:45:45+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "c381dec7-7649-4a05-b577-5f36f0d0e26e",
      "product_group_id": "c5db7dd7-5f5f-42f7-8fe4-f852c51f1efa",
      "product_id": "d65c2d25-941a-46ca-aaf1-109751f2ebca"
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








## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/3a52a845-b690-4817-a096-9051720d37c6' \
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