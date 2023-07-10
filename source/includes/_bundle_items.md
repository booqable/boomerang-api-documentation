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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=7886e719-2576-4c7d-94ef-59a3d6f222be' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "21b01a72-eb38-4b55-b637-9122b3452a24",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-07-10T09:15:53+00:00",
        "updated_at": "2023-07-10T09:15:53+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "7886e719-2576-4c7d-94ef-59a3d6f222be",
        "product_group_id": "67d5c495-7a7a-434b-92e0-90b30a3cd799",
        "product_id": "97c85ef4-45d5-4017-b941-c2529de75e63"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/7886e719-2576-4c7d-94ef-59a3d6f222be"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/67d5c495-7a7a-434b-92e0-90b30a3cd799"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/97c85ef4-45d5-4017-b941-c2529de75e63"
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








## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/504171a7-5751-483c-b504-fc751150c670' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "504171a7-5751-483c-b504-fc751150c670",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-07-10T09:15:53+00:00",
      "updated_at": "2023-07-10T09:15:53+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "176c3d4a-9beb-4599-bd57-fe98ba3d443d",
      "product_group_id": "25014bf6-39cc-4e7c-9373-1090a2f6c553",
      "product_id": "06bc4e07-9a36-4ed5-a6a2-2909d960f5ad"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/176c3d4a-9beb-4599-bd57-fe98ba3d443d"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/25014bf6-39cc-4e7c-9373-1090a2f6c553"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/06bc4e07-9a36-4ed5-a6a2-2909d960f5ad"
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
          "bundle_id": "227e2a19-4486-4a2f-9f38-d0af5af20042",
          "product_group_id": "d5243106-e34c-4bb2-a2a3-d6ee5dcbef6b",
          "product_id": "fa6d2df2-9a56-4256-a12e-eea1ec13e840",
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
    "id": "50453ef7-3744-40c4-946d-53441230d61a",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-07-10T09:15:54+00:00",
      "updated_at": "2023-07-10T09:15:54+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "227e2a19-4486-4a2f-9f38-d0af5af20042",
      "product_group_id": "d5243106-e34c-4bb2-a2a3-d6ee5dcbef6b",
      "product_id": "fa6d2df2-9a56-4256-a12e-eea1ec13e840"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/4566243e-cad0-4a82-85b2-b29097d31491' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4566243e-cad0-4a82-85b2-b29097d31491",
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
    "id": "4566243e-cad0-4a82-85b2-b29097d31491",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-07-10T09:15:55+00:00",
      "updated_at": "2023-07-10T09:15:55+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "3b3ad812-6bde-4a71-a287-4a29638ff963",
      "product_group_id": "2fb0e71b-220a-40eb-b40f-d8e06f5a94a3",
      "product_id": "8d911c0b-b1eb-4597-8a33-2a183c2a0551"
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








## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/20991498-364d-48a9-94d3-0bfbcea8cc3e' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Includes

This request does not accept any includes