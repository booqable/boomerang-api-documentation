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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=d0fe912d-f177-4dea-9ec2-2b89bf2eb039' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "37b1bad1-846b-499c-bbb3-a1b6b8ecd415",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-03-02T09:23:20+00:00",
        "updated_at": "2023-03-02T09:23:20+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "d0fe912d-f177-4dea-9ec2-2b89bf2eb039",
        "product_group_id": "2995f650-6d77-4bff-90aa-a2257e01db7e",
        "product_id": "ef7b9b67-a592-4a95-8786-c72a8a1d4805"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/d0fe912d-f177-4dea-9ec2-2b89bf2eb039"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/2995f650-6d77-4bff-90aa-a2257e01db7e"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ef7b9b67-a592-4a95-8786-c72a8a1d4805"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-02T09:22:41Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/4be95377-3c1d-45e2-b124-01cd5942a3e4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "4be95377-3c1d-45e2-b124-01cd5942a3e4",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-03-02T09:23:21+00:00",
      "updated_at": "2023-03-02T09:23:21+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "567b83e1-398a-40cc-8832-810b2ba49583",
      "product_group_id": "6cea0d0a-7598-4e6b-a6d7-2b9b950060f1",
      "product_id": "fa3a79e1-54b0-4f7e-b9f6-bab27fd84a35"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/567b83e1-398a-40cc-8832-810b2ba49583"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/6cea0d0a-7598-4e6b-a6d7-2b9b950060f1"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/fa3a79e1-54b0-4f7e-b9f6-bab27fd84a35"
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
          "bundle_id": "d5f4d6ad-7d59-495e-97da-b9faddaaab3b",
          "product_group_id": "a14b2dfa-5756-4050-b1fe-19cb39404235",
          "product_id": "c4c2898b-1d85-4c05-a5db-041f47ebe168",
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
    "id": "a416abeb-4801-424f-a4dc-67a93ff147e1",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-03-02T09:23:23+00:00",
      "updated_at": "2023-03-02T09:23:23+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "d5f4d6ad-7d59-495e-97da-b9faddaaab3b",
      "product_group_id": "a14b2dfa-5756-4050-b1fe-19cb39404235",
      "product_id": "c4c2898b-1d85-4c05-a5db-041f47ebe168"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/9eda06aa-706a-43f8-a7e9-7a9603127c17' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9eda06aa-706a-43f8-a7e9-7a9603127c17",
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
    "id": "9eda06aa-706a-43f8-a7e9-7a9603127c17",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-03-02T09:23:24+00:00",
      "updated_at": "2023-03-02T09:23:24+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "0f5aea55-35ce-40c6-9156-703f89b96669",
      "product_group_id": "cd551c1e-a909-487d-a6b2-da232d96c345",
      "product_id": "8fd4c0cd-a49c-4439-aee8-d493f02e74c3"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/11587c38-f031-41be-a51b-6159ad986ef9' \
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