# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`GET /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`PUT /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

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


## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/28e90f81-b00d-47fd-b8ad-2dfaa9fdcb27' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "28e90f81-b00d-47fd-b8ad-2dfaa9fdcb27",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-06T09:26:19+00:00",
      "updated_at": "2024-05-06T09:26:19+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "9f4c9d9e-881f-4286-9a98-0faf9cfc9175",
      "product_group_id": "acafd729-3f09-4ffe-820a-b4c549436752",
      "product_id": "f44708a4-675f-4dea-9271-dd81c4968778"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/9f4c9d9e-881f-4286-9a98-0faf9cfc9175"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/acafd729-3f09-4ffe-820a-b4c549436752"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/f44708a4-675f-4dea-9271-dd81c4968778"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=1d20d708-d3a2-4bd0-a04b-9fab844d5c4c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "85debe01-e48c-4e56-bf99-29f665c16230",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-05-06T09:26:20+00:00",
        "updated_at": "2024-05-06T09:26:20+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "1d20d708-d3a2-4bd0-a04b-9fab844d5c4c",
        "product_group_id": "33534ad9-9276-42c2-994f-358f92f54d58",
        "product_id": "5250a098-c4ee-4616-b6e6-e47cfd703fdb"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/1d20d708-d3a2-4bd0-a04b-9fab844d5c4c"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/33534ad9-9276-42c2-994f-358f92f54d58"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/5250a098-c4ee-4616-b6e6-e47cfd703fdb"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/71175fcf-6b36-409c-b291-3f35a505dc01' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "71175fcf-6b36-409c-b291-3f35a505dc01",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-06T09:26:21+00:00",
      "updated_at": "2024-05-06T09:26:21+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "b3323bc0-ecdc-4370-9989-d0fe209d3859",
      "product_group_id": "27625f1e-9fe0-4ae7-b406-5312d9ed8793",
      "product_id": "bee7f46e-593d-4e6e-9330-b4fbf47fee23"
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
## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/8e29e8e5-e97e-48df-98cb-3008702cd1a5' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8e29e8e5-e97e-48df-98cb-3008702cd1a5",
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
    "id": "8e29e8e5-e97e-48df-98cb-3008702cd1a5",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-06T09:26:22+00:00",
      "updated_at": "2024-05-06T09:26:22+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "cba2bb9e-7187-4fee-b221-707e9339febe",
      "product_group_id": "10dbfcd5-625d-491f-8594-2fd8deab02d7",
      "product_id": "232617ab-ddaf-4c08-a08c-7e4566060579"
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
          "bundle_id": "405304bb-f321-4e67-9f8f-c15b37b6b998",
          "product_group_id": "353e258c-e915-432e-9599-1f5942731218",
          "product_id": "6d60818b-27d0-4a0f-987c-52cb01565ce8",
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
    "id": "8bd3d1f0-5e3e-4935-8178-29c2897d3e1f",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-06T09:26:23+00:00",
      "updated_at": "2024-05-06T09:26:23+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "405304bb-f321-4e67-9f8f-c15b37b6b998",
      "product_group_id": "353e258c-e915-432e-9599-1f5942731218",
      "product_id": "6d60818b-27d0-4a0f-987c-52cb01565ce8"
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







