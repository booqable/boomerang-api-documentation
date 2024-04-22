# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`PUT /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

`POST /api/boomerang/bundle_items`

`GET /api/boomerang/bundle_items/{id}`

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


## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/0ab72728-cb53-4604-b5eb-730c68ea2f87' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0ab72728-cb53-4604-b5eb-730c68ea2f87",
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
    "id": "0ab72728-cb53-4604-b5eb-730c68ea2f87",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-22T09:24:23+00:00",
      "updated_at": "2024-04-22T09:24:24+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "c0a75f4c-8d13-42e8-b710-fc0745d73ba7",
      "product_group_id": "9e26f75d-e492-4737-9cae-241ae638ada5",
      "product_id": "17314c61-d5d8-426f-a536-1fb68619d3ff"
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








## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=5d17197d-0cb7-448c-b0bc-ba90546d9b53' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "678e1da7-194e-445f-abde-d1889597ae03",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-04-22T09:24:24+00:00",
        "updated_at": "2024-04-22T09:24:24+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "5d17197d-0cb7-448c-b0bc-ba90546d9b53",
        "product_group_id": "adb3f651-441b-4f08-a49c-7b92c279b89d",
        "product_id": "ccfd3d76-377d-4358-8de4-0c2fa9eda0ba"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/5d17197d-0cb7-448c-b0bc-ba90546d9b53"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/adb3f651-441b-4f08-a49c-7b92c279b89d"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ccfd3d76-377d-4358-8de4-0c2fa9eda0ba"
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
          "bundle_id": "d03bd0ef-27e2-42c0-a2df-7a120d011cbd",
          "product_group_id": "49fa0a15-2787-4b4b-a21f-2c735d849782",
          "product_id": "716760c1-7411-47a2-ab69-1a13ee667cd9",
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
    "id": "2ceba899-0769-46fa-ae25-235d789df972",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-22T09:24:25+00:00",
      "updated_at": "2024-04-22T09:24:25+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "d03bd0ef-27e2-42c0-a2df-7a120d011cbd",
      "product_group_id": "49fa0a15-2787-4b4b-a21f-2c735d849782",
      "product_id": "716760c1-7411-47a2-ab69-1a13ee667cd9"
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








## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/0f776ded-4f62-4564-ba2d-fcc09b09c71a' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0f776ded-4f62-4564-ba2d-fcc09b09c71a",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-22T09:24:26+00:00",
      "updated_at": "2024-04-22T09:24:26+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "7dc8be94-3713-4273-a607-e5b020dcd696",
      "product_group_id": "f658b9ae-1a09-496a-9726-6240cb7ec4bb",
      "product_id": "a63cb888-3303-4172-88ff-f5aae18b9a66"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/7dc8be94-3713-4273-a607-e5b020dcd696"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/f658b9ae-1a09-496a-9726-6240cb7ec4bb"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/a63cb888-3303-4172-88ff-f5aae18b9a66"
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








## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/5429ab26-5022-47ac-a00e-f6b3ecbe381c' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5429ab26-5022-47ac-a00e-f6b3ecbe381c",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-22T09:24:27+00:00",
      "updated_at": "2024-04-22T09:24:27+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "32912304-5204-4a25-9a10-cccc52a6633b",
      "product_group_id": "a7355ab9-4d3e-4aa8-b163-b4178070e4de",
      "product_id": "6bd70c83-b288-481e-b17f-2d6a0b9b6fcb"
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