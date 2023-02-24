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
`quantity` | **Integer** <br>The quantity of the item
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=c82824aa-205e-4091-ac29-65b00d78cdd9' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2bdcb8be-9ff5-46d1-8293-5b659199d4b3",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2023-02-24T09:46:45+00:00",
        "updated_at": "2023-02-24T09:46:45+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "c82824aa-205e-4091-ac29-65b00d78cdd9",
        "product_group_id": "36038500-018c-409f-990a-71c94de67aaa",
        "product_id": "41d7c205-fb12-4509-b936-c8fe0b01500b"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/c82824aa-205e-4091-ac29-65b00d78cdd9"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/36038500-018c-409f-990a-71c94de67aaa"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/41d7c205-fb12-4509-b936-c8fe0b01500b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:20Z`
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
`quantity` | **Integer** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/c03a83ca-189f-4787-add7-cd2f6b2327ea' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c03a83ca-189f-4787-add7-cd2f6b2327ea",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-24T09:46:45+00:00",
      "updated_at": "2023-02-24T09:46:45+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "b16208ab-3921-4bcd-b0d5-adcb2f2dfb75",
      "product_group_id": "135da3fc-b254-49b1-9a94-e7c548739167",
      "product_id": "cbb47886-b6dd-4545-a975-3f8d29881988"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/b16208ab-3921-4bcd-b0d5-adcb2f2dfb75"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/135da3fc-b254-49b1-9a94-e7c548739167"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/cbb47886-b6dd-4545-a975-3f8d29881988"
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
          "bundle_id": "901ea08c-e018-4348-bb83-6832c6c7691e",
          "product_group_id": "67f0ee97-c5e5-49c8-a472-0b9108d6ca6e",
          "product_id": "f0c972f2-25bf-440c-aee5-287190f4c190",
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
    "id": "b2fd695b-5e6f-4e41-be19-c74d7e01b547",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-24T09:46:46+00:00",
      "updated_at": "2023-02-24T09:46:46+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "901ea08c-e018-4348-bb83-6832c6c7691e",
      "product_group_id": "67f0ee97-c5e5-49c8-a472-0b9108d6ca6e",
      "product_id": "f0c972f2-25bf-440c-aee5-287190f4c190"
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








## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/5d24d145-f040-4ea6-9db3-4bd199ea139f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5d24d145-f040-4ea6-9db3-4bd199ea139f",
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
    "id": "5d24d145-f040-4ea6-9db3-4bd199ea139f",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2023-02-24T09:46:46+00:00",
      "updated_at": "2023-02-24T09:46:46+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "58b60c86-920a-40a7-9515-86ea459b6021",
      "product_group_id": "4ae292a9-0a9c-4636-828e-17cd7588ea58",
      "product_id": "15fba93b-92bd-46f8-8011-a53e9dd80eeb"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/96f9b35a-a623-453e-b627-e3602092857c' \
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