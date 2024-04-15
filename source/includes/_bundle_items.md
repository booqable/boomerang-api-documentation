# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`POST /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`PUT /api/boomerang/bundle_items/{id}`

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
          "bundle_id": "e6bfd1cc-5495-4153-a8e1-8540c43289c4",
          "product_group_id": "64b958cb-3c12-4d37-a4f1-6b6d54d126c5",
          "product_id": "9fae8514-f45a-4d26-8508-b337522347b4",
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
    "id": "add3007b-0c71-43f9-9391-4a8c6806706e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-15T09:29:29+00:00",
      "updated_at": "2024-04-15T09:29:29+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "e6bfd1cc-5495-4153-a8e1-8540c43289c4",
      "product_group_id": "64b958cb-3c12-4d37-a4f1-6b6d54d126c5",
      "product_id": "9fae8514-f45a-4d26-8508-b337522347b4"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/904b633c-d3a1-4ae7-8c6e-1d69a001afc7' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "904b633c-d3a1-4ae7-8c6e-1d69a001afc7",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-15T09:29:30+00:00",
      "updated_at": "2024-04-15T09:29:30+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "6b888870-2b03-4004-8e86-6c9057b6104c",
      "product_group_id": "0b5d350f-1dd6-45eb-93cf-e78a153be778",
      "product_id": "70c1e5a5-84d7-4b08-94d6-9bc6b098be19"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/9216acbb-0e1e-40ff-b6d3-a31ad44197cb' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9216acbb-0e1e-40ff-b6d3-a31ad44197cb",
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
    "id": "9216acbb-0e1e-40ff-b6d3-a31ad44197cb",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-15T09:29:31+00:00",
      "updated_at": "2024-04-15T09:29:31+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "3e8653f0-bf64-4b50-af46-49cff83a1277",
      "product_group_id": "543a3089-1f10-4631-975f-84ffcf468ae6",
      "product_id": "51263a53-51d0-42dc-bea3-e0b6d0988c55"
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








## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/be95266e-f46b-4ae8-a793-69917adf3d6b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be95266e-f46b-4ae8-a793-69917adf3d6b",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-15T09:29:32+00:00",
      "updated_at": "2024-04-15T09:29:32+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "cd594cc2-c3e6-49d2-abf0-eb8a76dd4126",
      "product_group_id": "26a11c08-00e5-4cab-9987-5e3e2612d13a",
      "product_id": "7229ef79-3095-4c29-bc78-e9ad8638db8b"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/cd594cc2-c3e6-49d2-abf0-eb8a76dd4126"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/26a11c08-00e5-4cab-9987-5e3e2612d13a"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/7229ef79-3095-4c29-bc78-e9ad8638db8b"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=d00b8289-9378-4150-8173-ac20d40ae2a6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8d039209-8987-4f05-9c28-aaa8683073f8",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-04-15T09:29:33+00:00",
        "updated_at": "2024-04-15T09:29:33+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "d00b8289-9378-4150-8173-ac20d40ae2a6",
        "product_group_id": "a2ee2b0c-de82-4210-afd9-942150829001",
        "product_id": "c86d394f-5fdd-460f-9be2-b1e0704d5fd6"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/d00b8289-9378-4150-8173-ac20d40ae2a6"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/a2ee2b0c-de82-4210-afd9-942150829001"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/c86d394f-5fdd-460f-9be2-b1e0704d5fd6"
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







