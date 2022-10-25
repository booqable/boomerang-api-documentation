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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=e13512f1-4127-45d4-997f-9dd8cf28f835' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0931dd8f-5b42-417f-9a2c-f39675ba0a24",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-10-25T16:29:55+00:00",
        "updated_at": "2022-10-25T16:29:55+00:00",
        "quantity": "2",
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "e13512f1-4127-45d4-997f-9dd8cf28f835",
        "product_group_id": "01c77e6d-fea6-44e9-b225-24e757a25beb",
        "product_id": "e66f377e-9688-45f6-8b44-acfc1d402650"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/e13512f1-4127-45d4-997f-9dd8cf28f835"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/01c77e6d-fea6-44e9-b225-24e757a25beb"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/e66f377e-9688-45f6-8b44-acfc1d402650"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T16:29:21Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/cdd26b23-e796-48e2-800d-ebb4d25d2b72' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cdd26b23-e796-48e2-800d-ebb4d25d2b72",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T16:29:56+00:00",
      "updated_at": "2022-10-25T16:29:56+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "a887a653-eac1-4b7e-a01b-978a37fb0222",
      "product_group_id": "5e18fab6-3024-47af-8a7b-3d30ae9f964c",
      "product_id": "7f5d4c8c-a70d-4547-a100-d175a8ebe599"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/a887a653-eac1-4b7e-a01b-978a37fb0222"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/5e18fab6-3024-47af-8a7b-3d30ae9f964c"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/7f5d4c8c-a70d-4547-a100-d175a8ebe599"
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
          "bundle_id": "12179b36-2fb2-4443-97ff-55995bbb9fe3",
          "product_group_id": "33719fca-4aee-4891-8310-6d2d874d16db",
          "product_id": "ba1a4c31-70a7-43cc-8913-b50ce9cf5b05",
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
    "id": "59d43f49-5522-44a2-aac6-adf3e25836a6",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T16:29:56+00:00",
      "updated_at": "2022-10-25T16:29:56+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "12179b36-2fb2-4443-97ff-55995bbb9fe3",
      "product_group_id": "33719fca-4aee-4891-8310-6d2d874d16db",
      "product_id": "ba1a4c31-70a7-43cc-8913-b50ce9cf5b05"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/c9c216b8-57be-4b2e-95fd-6e87fdec49c4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "c9c216b8-57be-4b2e-95fd-6e87fdec49c4",
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
    "id": "c9c216b8-57be-4b2e-95fd-6e87fdec49c4",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T16:29:57+00:00",
      "updated_at": "2022-10-25T16:29:57+00:00",
      "quantity": "3",
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "27eee0c6-53f9-4220-a309-e18179f730fd",
      "product_group_id": "cc7eb24d-4f5a-4fc8-b5e6-f09969f264f0",
      "product_id": "a817ace8-3be5-46d0-8e28-df384d11600c"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/67ca7848-3dfc-46ff-981d-e76e0f0e735f' \
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