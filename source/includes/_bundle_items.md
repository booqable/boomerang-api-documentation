# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`PUT /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

`POST /api/boomerang/bundle_items`

`DELETE /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items/{id}`

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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/2f95e7b0-3d0b-476c-bcf0-03ddfbf7f40e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2f95e7b0-3d0b-476c-bcf0-03ddfbf7f40e",
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
    "id": "2f95e7b0-3d0b-476c-bcf0-03ddfbf7f40e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-06-03T09:29:09.180729+00:00",
      "updated_at": "2024-06-03T09:29:09.299064+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "3024ad7e-6893-407b-b112-464cbf07d133",
      "product_group_id": "bd9d0039-d6ec-40e5-9899-ed7c7a016988",
      "product_id": "92f199bd-9b52-48aa-9b76-bc4c75315b45"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=b2400523-86b5-4543-ac99-71bea9a2d945' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "54f178bb-d5ef-400e-997d-ce83d45f0370",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-06-03T09:29:10.620328+00:00",
        "updated_at": "2024-06-03T09:29:10.620328+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "b2400523-86b5-4543-ac99-71bea9a2d945",
        "product_group_id": "b2f2fc3a-808f-4ce2-8db9-c603db330932",
        "product_id": "1da0b870-23f6-4ff3-b071-4a3fcc8e2d4a"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/b2400523-86b5-4543-ac99-71bea9a2d945"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/b2f2fc3a-808f-4ce2-8db9-c603db330932"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/1da0b870-23f6-4ff3-b071-4a3fcc8e2d4a"
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
          "bundle_id": "3a95f3e8-b105-46aa-b449-dee1f7d6c1b1",
          "product_group_id": "11eb4cd7-2984-4224-9d6d-1c0a5b1616a3",
          "product_id": "550b17e4-b9fe-42eb-bd3a-63cda3be3826",
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
    "id": "4b98f672-de86-4d04-9d9b-0c88cdcccccf",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-06-03T09:29:12.373000+00:00",
      "updated_at": "2024-06-03T09:29:12.373000+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "3a95f3e8-b105-46aa-b449-dee1f7d6c1b1",
      "product_group_id": "11eb4cd7-2984-4224-9d6d-1c0a5b1616a3",
      "product_id": "550b17e4-b9fe-42eb-bd3a-63cda3be3826"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/dfd9a324-e2c7-4e11-8a07-f6c8a7bac925' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dfd9a324-e2c7-4e11-8a07-f6c8a7bac925",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-06-03T09:29:14.717026+00:00",
      "updated_at": "2024-06-03T09:29:14.717026+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "297a2923-619c-478a-9ee5-3d3fd97d8de8",
      "product_group_id": "39009873-e37c-4c52-878b-02557aa19d8b",
      "product_id": "53632f1f-2c73-4f79-92a1-2446ebabfd5a"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/75376021-ea59-400b-b601-ca7b3e6bb076' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "75376021-ea59-400b-b601-ca7b3e6bb076",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-06-03T09:29:16.476904+00:00",
      "updated_at": "2024-06-03T09:29:16.476904+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "025e3406-4c11-4c35-a782-1247ca46d71a",
      "product_group_id": "2c7188d3-2c94-4711-a1e7-c69a7d40dd09",
      "product_id": "aa51f960-58bb-41b2-bee4-070715463c97"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/025e3406-4c11-4c35-a782-1247ca46d71a"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/2c7188d3-2c94-4711-a1e7-c69a7d40dd09"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/aa51f960-58bb-41b2-bee4-070715463c97"
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







