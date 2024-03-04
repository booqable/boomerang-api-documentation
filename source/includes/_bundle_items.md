# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`POST /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

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
          "bundle_id": "f583d036-2528-48a3-8614-a7f87d2b85f5",
          "product_group_id": "12143357-ffff-415f-b9f6-26927a94cc80",
          "product_id": "4a53c3e7-00b3-4d61-9794-522176992621",
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
    "id": "2ba37db1-4b9e-4847-b2da-66e4dfad787e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:41+00:00",
      "updated_at": "2024-03-04T09:16:41+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "f583d036-2528-48a3-8614-a7f87d2b85f5",
      "product_group_id": "12143357-ffff-415f-b9f6-26927a94cc80",
      "product_id": "4a53c3e7-00b3-4d61-9794-522176992621"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/15c72aca-b866-48d9-b146-de4737b7db54' \
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
## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/daa34449-70e7-4288-a0b3-355a0018b254' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "daa34449-70e7-4288-a0b3-355a0018b254",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:43+00:00",
      "updated_at": "2024-03-04T09:16:43+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "96c845da-8b28-49c0-9ba8-a648b20fca69",
      "product_group_id": "1db4d650-cd0c-4e94-9ef9-f6d2185be7e7",
      "product_id": "7e85c75b-7678-48d9-8b9a-88b5677404bf"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/96c845da-8b28-49c0-9ba8-a648b20fca69"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/1db4d650-cd0c-4e94-9ef9-f6d2185be7e7"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/7e85c75b-7678-48d9-8b9a-88b5677404bf"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=de8c3024-3337-4097-aae3-1b9cd36097db' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7d0627e3-0641-4568-bdab-ef3dbbe564fe",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-03-04T09:16:44+00:00",
        "updated_at": "2024-03-04T09:16:44+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "de8c3024-3337-4097-aae3-1b9cd36097db",
        "product_group_id": "4da845d0-1a73-4b0b-a9fe-ca0f3b2e2bbc",
        "product_id": "b2ac45e9-9253-4437-90bd-8197747736bc"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/de8c3024-3337-4097-aae3-1b9cd36097db"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/4da845d0-1a73-4b0b-a9fe-ca0f3b2e2bbc"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/b2ac45e9-9253-4437-90bd-8197747736bc"
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








## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d383b8a9-5665-4af6-a7c3-03e6f8cbd73d' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d383b8a9-5665-4af6-a7c3-03e6f8cbd73d",
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
    "id": "d383b8a9-5665-4af6-a7c3-03e6f8cbd73d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-03-04T09:16:45+00:00",
      "updated_at": "2024-03-04T09:16:45+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "2fc797f4-b79b-493c-86c6-129ce424c335",
      "product_group_id": "f98da09c-bb20-434d-a000-cf0ff16f58ce",
      "product_id": "f424c040-c85e-4779-b533-d374e833ae24"
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







