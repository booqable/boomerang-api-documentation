# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [order bookings](#order-bookings) for more information).

## Endpoints
`DELETE /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items`

`PUT /api/boomerang/bundle_items/{id}`

`GET /api/boomerang/bundle_items/{id}`

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


## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/a0ac5c4d-dae6-486f-91ef-fcc73506e9c6' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0ac5c4d-dae6-486f-91ef-fcc73506e9c6",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-09T07:38:09+00:00",
      "updated_at": "2024-04-09T07:38:09+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "1c5ac11f-3407-482d-a926-23b9cefee2d6",
      "product_group_id": "ddb862d9-d6e3-46cf-a82c-798e7811bff1",
      "product_id": "91c69ad5-0d7f-45f3-8789-9775eb7d53aa"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=d7b506de-3ecc-41b4-b054-82e1fb9246ce' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0da95fd6-c011-4d77-95e7-45374c611783",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-04-09T07:38:10+00:00",
        "updated_at": "2024-04-09T07:38:10+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "d7b506de-3ecc-41b4-b054-82e1fb9246ce",
        "product_group_id": "94f0d1e7-c8bf-401b-90a8-6c270238fb9a",
        "product_id": "a275bd6c-4101-4147-bf85-39c961a71cc1"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/d7b506de-3ecc-41b4-b054-82e1fb9246ce"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/94f0d1e7-c8bf-401b-90a8-6c270238fb9a"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/a275bd6c-4101-4147-bf85-39c961a71cc1"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/b51cf04c-83ee-463b-9e89-2e5dd692e295' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b51cf04c-83ee-463b-9e89-2e5dd692e295",
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
    "id": "b51cf04c-83ee-463b-9e89-2e5dd692e295",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-09T07:38:11+00:00",
      "updated_at": "2024-04-09T07:38:11+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "53d67766-a102-4109-a5c2-f0fdc40d09f4",
      "product_group_id": "5248973d-b88a-425f-919c-9fd87c0f4370",
      "product_id": "72d0c6d7-8a82-42c9-9739-ae510e7eb561"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/a62a4cfb-968c-4a51-872f-2cf2bec96000' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a62a4cfb-968c-4a51-872f-2cf2bec96000",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-09T07:38:12+00:00",
      "updated_at": "2024-04-09T07:38:12+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "65370cb8-87a0-4318-8fe2-c740bdef86ce",
      "product_group_id": "ae23aeb2-3b9c-4e4c-a35d-274ddf167346",
      "product_id": "bbb799b2-bd2d-46fb-b329-b6e326dbb2b7"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/65370cb8-87a0-4318-8fe2-c740bdef86ce"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/ae23aeb2-3b9c-4e4c-a35d-274ddf167346"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/bbb799b2-bd2d-46fb-b329-b6e326dbb2b7"
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
          "bundle_id": "ee036c76-6a6f-4673-854e-b71fd3b974c4",
          "product_group_id": "3e8c33ff-0f2e-447e-827b-ca613e589ff6",
          "product_id": "2a72a40c-4590-4ff4-92cd-9538096ad8e3",
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
    "id": "f5b65b49-9bef-430b-8309-b0f8b8f0830e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-04-09T07:38:13+00:00",
      "updated_at": "2024-04-09T07:38:13+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "ee036c76-6a6f-4673-854e-b71fd3b974c4",
      "product_group_id": "3e8c33ff-0f2e-447e-827b-ca613e589ff6",
      "product_id": "2a72a40c-4590-4ff4-92cd-9538096ad8e3"
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







