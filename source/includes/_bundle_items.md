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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=5fec7fee-28c9-4347-a11f-131ab8389e56' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c454e2ff-75c2-4359-920c-aa36aa32118a",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-01-05T13:42:32+00:00",
        "updated_at": "2023-01-05T13:42:32+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "5fec7fee-28c9-4347-a11f-131ab8389e56",
        "product_group_id": "fcf12e76-4206-4bd3-a21e-b33a447b249d",
        "product_id": "a1fe4103-1b22-47dc-9b06-db0a5699afc3"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/5fec7fee-28c9-4347-a11f-131ab8389e56"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/fcf12e76-4206-4bd3-a21e-b33a447b249d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a1fe4103-1b22-47dc-9b06-db0a5699afc3"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/f333a020-5fb7-459c-9fa8-4a92eab5cdc8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f333a020-5fb7-459c-9fa8-4a92eab5cdc8",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-01-05T13:42:33+00:00",
      "updated_at": "2023-01-05T13:42:33+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "b10008bf-31ac-488c-b817-311f9ce150be",
      "product_group_id": "d5b1cfdf-b62a-4ce4-97d3-a153bd6cc0dd",
      "product_id": "70723489-2eed-4149-bbd0-c843d066d456"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/b10008bf-31ac-488c-b817-311f9ce150be"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/d5b1cfdf-b62a-4ce4-97d3-a153bd6cc0dd"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/70723489-2eed-4149-bbd0-c843d066d456"
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
          "bundle_id": "b5b1feaa-096d-49c9-9329-8c47aaea5b12",
          "product_group_id": "b3fb42f4-faa0-4931-8120-69b20e810412",
          "product_id": "a2edba16-d5a7-4eef-9b49-5a224f14c6e5",
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
    "id": "c3cff5f0-abc3-4aba-b354-c8f398ce1e08",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-01-05T13:42:34+00:00",
      "updated_at": "2023-01-05T13:42:34+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "b5b1feaa-096d-49c9-9329-8c47aaea5b12",
      "product_group_id": "b3fb42f4-faa0-4931-8120-69b20e810412",
      "product_id": "a2edba16-d5a7-4eef-9b49-5a224f14c6e5"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7c235b25-9204-428a-ac9e-c8c440efc792' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "7c235b25-9204-428a-ac9e-c8c440efc792",
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
    "id": "7c235b25-9204-428a-ac9e-c8c440efc792",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-01-05T13:42:34+00:00",
      "updated_at": "2023-01-05T13:42:34+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "21af03fe-1b2d-438d-9377-42914ec506e7",
      "product_group_id": "b3b32d4d-da19-4913-8ca1-0314aac81eef",
      "product_id": "9839702c-6605-41f3-b1c9-a7d775b3e7ee"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/08ee6f1e-f9d6-4632-9fca-e52c38545267' \
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