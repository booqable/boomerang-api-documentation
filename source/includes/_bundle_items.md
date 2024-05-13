# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`PUT /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

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


## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/91b74957-8be7-4338-9343-bc283dcd5dce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "91b74957-8be7-4338-9343-bc283dcd5dce",
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
    "id": "91b74957-8be7-4338-9343-bc283dcd5dce",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-13T09:25:57+00:00",
      "updated_at": "2024-05-13T09:25:57+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "3f31df91-f86e-49d7-8085-f8ec3dc2b3c8",
      "product_group_id": "1d5bc670-6444-493f-b7b3-99ddbe8d3e4a",
      "product_id": "0332ad63-c102-456f-a58a-114960684291"
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
          "bundle_id": "b91e6520-b4f4-424a-9ef9-7f02fe93b333",
          "product_group_id": "9703a93a-854e-49a1-83f9-d9083a1d32c5",
          "product_id": "8d04abb1-5a9d-482c-8bdc-f66258cdee81",
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
    "id": "7e906cf2-9007-4791-9b9d-a768bb894e3d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-13T09:25:59+00:00",
      "updated_at": "2024-05-13T09:25:59+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "b91e6520-b4f4-424a-9ef9-7f02fe93b333",
      "product_group_id": "9703a93a-854e-49a1-83f9-d9083a1d32c5",
      "product_id": "8d04abb1-5a9d-482c-8bdc-f66258cdee81"
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








## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/87118b41-ab13-446b-9de0-256cc6bf5b0a' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "87118b41-ab13-446b-9de0-256cc6bf5b0a",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-13T09:26:00+00:00",
      "updated_at": "2024-05-13T09:26:00+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "a5c3a709-7f5f-463c-88e8-11f073785665",
      "product_group_id": "3ba8f212-f19c-45ba-a6e6-534651923da0",
      "product_id": "622a6b18-239b-4d19-b19f-13b0f21325c6"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/b89fc5bf-c71c-4082-9302-241c71fa8d9b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b89fc5bf-c71c-4082-9302-241c71fa8d9b",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-13T09:26:01+00:00",
      "updated_at": "2024-05-13T09:26:01+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "9f35f9d4-98ae-43ef-b9e3-39a817683731",
      "product_group_id": "535ced18-3ace-423d-8520-81c986b2742f",
      "product_id": "03889b0d-90bb-419c-9c9d-f60a358fca55"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/9f35f9d4-98ae-43ef-b9e3-39a817683731"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/535ced18-3ace-423d-8520-81c986b2742f"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/03889b0d-90bb-419c-9c9d-f60a358fca55"
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








## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=9834139d-0d72-4625-b7ce-c1884c9f20ae' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f34bc762-13a5-4db3-8f15-98554e6ed626",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-05-13T09:26:03+00:00",
        "updated_at": "2024-05-13T09:26:03+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "9834139d-0d72-4625-b7ce-c1884c9f20ae",
        "product_group_id": "ff7b8e7f-63b5-4a1b-9f0e-e2dc2a9abd4b",
        "product_id": "232d11b1-2c77-43d8-868c-df2363210ab4"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/9834139d-0d72-4625-b7ce-c1884c9f20ae"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/ff7b8e7f-63b5-4a1b-9f0e-e2dc2a9abd4b"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/232d11b1-2c77-43d8-868c-df2363210ab4"
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







