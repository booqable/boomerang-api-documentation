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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=221bde0d-79a9-4cf5-822e-3d1e2cd5671d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f510aa2d-8fcd-4303-874c-eda3683cae27",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-11-03T11:05:42+00:00",
        "updated_at": "2022-11-03T11:05:42+00:00",
        "quantity": "2",
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "221bde0d-79a9-4cf5-822e-3d1e2cd5671d",
        "product_group_id": "e4ad2658-f822-4e00-b299-baa20f0ab2ed",
        "product_id": "af568a76-7e1e-4686-9bbd-708d49569d3f"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/221bde0d-79a9-4cf5-822e-3d1e2cd5671d"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/e4ad2658-f822-4e00-b299-baa20f0ab2ed"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/af568a76-7e1e-4686-9bbd-708d49569d3f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-03T11:05:11Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/537a3229-ef94-4d6d-ac47-8a3e2674578f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "537a3229-ef94-4d6d-ac47-8a3e2674578f",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-03T11:05:43+00:00",
      "updated_at": "2022-11-03T11:05:43+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "72403436-d0bc-4009-bcb9-a8ec2b8d28fa",
      "product_group_id": "a96b532d-d850-4f01-88db-95f6d7faed38",
      "product_id": "74d4ac6d-2f48-4361-a73e-276acc834816"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/72403436-d0bc-4009-bcb9-a8ec2b8d28fa"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/a96b532d-d850-4f01-88db-95f6d7faed38"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/74d4ac6d-2f48-4361-a73e-276acc834816"
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
          "bundle_id": "def9456e-db0e-4555-b0e5-442f28b58187",
          "product_group_id": "becfdf44-6686-4c7c-bc33-dfc10945c473",
          "product_id": "d2315231-04f3-42aa-a822-795a5edf7539",
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
    "id": "e34d1d8e-26a4-4f44-af0f-c882965b0c9a",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-03T11:05:44+00:00",
      "updated_at": "2022-11-03T11:05:44+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "def9456e-db0e-4555-b0e5-442f28b58187",
      "product_group_id": "becfdf44-6686-4c7c-bc33-dfc10945c473",
      "product_id": "d2315231-04f3-42aa-a822-795a5edf7539"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/29248b13-d428-4403-ae98-1e5558867c86' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "29248b13-d428-4403-ae98-1e5558867c86",
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
    "id": "29248b13-d428-4403-ae98-1e5558867c86",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-11-03T11:05:45+00:00",
      "updated_at": "2022-11-03T11:05:45+00:00",
      "quantity": "3",
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "df546df5-3198-4e2e-8e89-e758228fea8a",
      "product_group_id": "225fd7f0-3e22-4297-aee8-999eaf210be3",
      "product_id": "95c2dcea-8fd8-445c-9d8d-164a90fe0fd4"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7e30ffb7-cd6c-46e5-8dbc-052b1fb3dcf3' \
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