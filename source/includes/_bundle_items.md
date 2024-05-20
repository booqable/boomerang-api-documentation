# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`POST /api/boomerang/bundle_items`

`GET /api/boomerang/bundle_items/{id}`

`PUT /api/boomerang/bundle_items/{id}`

`DELETE /api/boomerang/bundle_items/{id}`

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
          "bundle_id": "f879054a-e55f-4624-8f9a-53fd4601c18d",
          "product_group_id": "b27d966f-fff7-400f-93e0-e6048b64bd1f",
          "product_id": "5ad074f3-4365-40d4-8bb9-8a5f6056d361",
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
    "id": "3e2cc4bc-94e9-4f0c-97f2-e4cff85d24e3",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-20T09:25:05+00:00",
      "updated_at": "2024-05-20T09:25:05+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "f879054a-e55f-4624-8f9a-53fd4601c18d",
      "product_group_id": "b27d966f-fff7-400f-93e0-e6048b64bd1f",
      "product_id": "5ad074f3-4365-40d4-8bb9-8a5f6056d361"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7973389f-4940-43fd-9488-ff8a6f5f1917' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7973389f-4940-43fd-9488-ff8a6f5f1917",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-20T09:25:07+00:00",
      "updated_at": "2024-05-20T09:25:07+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "e3769496-c391-4260-80bf-5fc40e6191dd",
      "product_group_id": "aa0161aa-6873-4d12-83c2-83d1283cb813",
      "product_id": "05aad414-8b18-44e1-b4ed-07662365f18a"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/e3769496-c391-4260-80bf-5fc40e6191dd"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/aa0161aa-6873-4d12-83c2-83d1283cb813"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/05aad414-8b18-44e1-b4ed-07662365f18a"
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








## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/cd9dbffb-2725-4e79-8cb6-c466b9f0bd6e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "cd9dbffb-2725-4e79-8cb6-c466b9f0bd6e",
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
    "id": "cd9dbffb-2725-4e79-8cb6-c466b9f0bd6e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-20T09:25:08+00:00",
      "updated_at": "2024-05-20T09:25:08+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "caadaa7b-d041-4008-ac6f-4ccadbfc8bc7",
      "product_group_id": "874c87be-e1ce-4405-991d-d8f3f80f0bb1",
      "product_id": "f8cb4f9e-6d1f-4b26-86d0-6ab3edbb5217"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/1e7db8c2-fea3-478b-bb5d-8a55dd10ce12' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1e7db8c2-fea3-478b-bb5d-8a55dd10ce12",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-05-20T09:25:09+00:00",
      "updated_at": "2024-05-20T09:25:09+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "3bf2beb4-1898-4dbe-8fb7-9b14acdc4614",
      "product_group_id": "448959dc-1ee4-4414-a936-9cc832c5cb05",
      "product_id": "912da924-a7d0-4fbe-bec5-b573f0b02432"
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
## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=82fdf05a-71b7-4461-98a4-eb9829c60ed0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "39bb13a7-720d-4193-aab3-c1b497ad6801",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-05-20T09:25:10+00:00",
        "updated_at": "2024-05-20T09:25:10+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "82fdf05a-71b7-4461-98a4-eb9829c60ed0",
        "product_group_id": "f89ed267-060e-4d81-a5bb-2aa4a07accc2",
        "product_id": "aad90705-fe88-4609-860b-a45f371dda27"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/82fdf05a-71b7-4461-98a4-eb9829c60ed0"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/f89ed267-060e-4d81-a5bb-2aa4a07accc2"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/aad90705-fe88-4609-860b-a45f371dda27"
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







