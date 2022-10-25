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
`quantity` | **String** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=ffe49ea3-a667-4039-896b-2cde4f36c6da' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7796f97e-ac9e-42e4-82f9-bb3779f585fc",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-10-25T18:48:44+00:00",
        "updated_at": "2022-10-25T18:48:44+00:00",
        "quantity": "2",
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "ffe49ea3-a667-4039-896b-2cde4f36c6da",
        "product_group_id": "955b1328-e219-4d83-9efe-d27dddf27e29",
        "product_id": "d7bd8280-f606-4f54-ab82-321a84d5b1cc"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/ffe49ea3-a667-4039-896b-2cde4f36c6da"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/955b1328-e219-4d83-9efe-d27dddf27e29"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/d7bd8280-f606-4f54-ab82-321a84d5b1cc"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T18:48:24Z`
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
`quantity` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/653aacf3-f360-4b5e-b094-45537f89ff18' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "653aacf3-f360-4b5e-b094-45537f89ff18",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T18:48:44+00:00",
      "updated_at": "2022-10-25T18:48:44+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "671d7bf6-6f7d-4be8-8c1f-290761e804f1",
      "product_group_id": "6ab2a09f-f118-4e4b-b13e-92cd918696aa",
      "product_id": "745f93e5-72ae-4d90-9cb2-55f3e77ff4f8"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/671d7bf6-6f7d-4be8-8c1f-290761e804f1"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/6ab2a09f-f118-4e4b-b13e-92cd918696aa"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/745f93e5-72ae-4d90-9cb2-55f3e77ff4f8"
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
          "bundle_id": "b70c82af-23bd-4f79-87bb-bff4f1c7ec2b",
          "product_group_id": "5a514135-d6fd-4cdb-9861-19fed3f59338",
          "product_id": "1f73627c-17f8-466c-9909-900983c462fd",
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
    "id": "3c12cc84-cc9b-44b9-b508-f02b0c2c7626",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T18:48:45+00:00",
      "updated_at": "2022-10-25T18:48:45+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "b70c82af-23bd-4f79-87bb-bff4f1c7ec2b",
      "product_group_id": "5a514135-d6fd-4cdb-9861-19fed3f59338",
      "product_id": "1f73627c-17f8-466c-9909-900983c462fd"
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
`data[attributes][quantity]` | **String** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/2de981f4-d429-46be-aea2-3f62c9b1d60c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2de981f4-d429-46be-aea2-3f62c9b1d60c",
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
    "id": "2de981f4-d429-46be-aea2-3f62c9b1d60c",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T18:48:46+00:00",
      "updated_at": "2022-10-25T18:48:46+00:00",
      "quantity": "3",
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "1c76fb0f-5815-4672-9358-9a57c144fc9d",
      "product_group_id": "22e49670-adcd-4d39-b20f-3c94bf58455b",
      "product_id": "8f762dac-f6a5-40b8-b4c1-62d71362fd35"
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
`data[attributes][quantity]` | **String** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/8327cc79-1712-4679-900e-9c3f11909637' \
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