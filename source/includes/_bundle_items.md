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
`quantity` | **String**<br>The quantity of the item
`discount_percentage` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`position` | **Integer**<br>Position of the product in bundle list
`bundle_id` | **Uuid**<br>The associated Bundle
`product_group_id` | **Uuid**<br>The associated Product group
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=b1bf50ee-da71-4fc4-91cf-9bf59d3f702f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "eda7d51a-57ed-41c4-9635-7278b1ffeac1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-02-08T09:12:42+00:00",
        "updated_at": "2022-02-08T09:12:42+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "b1bf50ee-da71-4fc4-91cf-9bf59d3f702f",
        "product_group_id": "c8d8f31c-28a6-4fe8-803a-40f42b02f2d2",
        "product_id": "df21bb81-cd5c-4084-b0ee-d8caf3f3501b"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/b1bf50ee-da71-4fc4-91cf-9bf59d3f702f"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/c8d8f31c-28a6-4fe8-803a-40f42b02f2d2"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/df21bb81-cd5c-4084-b0ee-d8caf3f3501b"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`quantity` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`discount_percentage` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`position` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`bundle_id` | **Uuid**<br>`eq`, `not_eq`
`product_group_id` | **Uuid**<br>`eq`, `not_eq`
`product_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Fetching a bundle item



> How to fetch a bundle item:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/f42bf2bd-6a55-49bc-8e5a-d4464024cac4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f42bf2bd-6a55-49bc-8e5a-d4464024cac4",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-08T09:12:43+00:00",
      "updated_at": "2022-02-08T09:12:43+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "44d54d5b-8932-426d-b877-ee99c9257348",
      "product_group_id": "2085c0ad-e67d-46be-aad0-4b3aeb9aa125",
      "product_id": "ddfeb95d-7e74-46f7-a6fa-7dc1ca92fd09"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/44d54d5b-8932-426d-b877-ee99c9257348"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/2085c0ad-e67d-46be-aad0-4b3aeb9aa125"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/ddfeb95d-7e74-46f7-a6fa-7dc1ca92fd09"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






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
          "bundle_id": "cd80c63e-8803-40bc-8666-00c48a5a58d8",
          "product_group_id": "9ca45753-da47-41bb-9549-835e58e691a8",
          "product_id": "2cb2e522-9fa1-4f4b-b06f-77794322a767",
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
    "id": "bc6cf00f-e63f-4dfd-ad96-d8051f34cc13",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-08T09:12:43+00:00",
      "updated_at": "2022-02-08T09:12:43+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "cd80c63e-8803-40bc-8666-00c48a5a58d8",
      "product_group_id": "9ca45753-da47-41bb-9549-835e58e691a8",
      "product_id": "2cb2e522-9fa1-4f4b-b06f-77794322a767"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String**<br>The quantity of the item
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer**<br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid**<br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group
`data[attributes][product_id]` | **Uuid**<br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Updating a bundle item



> How to update a bundle item:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d949569b-0931-493c-b7b4-34311875a538' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d949569b-0931-493c-b7b4-34311875a538",
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
    "id": "d949569b-0931-493c-b7b4-34311875a538",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-08T09:12:44+00:00",
      "updated_at": "2022-02-08T09:12:44+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "68808ac3-b80c-4cff-b0de-d308a879b054",
      "product_group_id": "21d7ec21-bdfe-44a3-8157-3b1fe2778d5a",
      "product_id": "ba183f5a-d1f5-4eb6-9b29-596f77f4618d"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][quantity]` | **String**<br>The quantity of the item
`data[attributes][discount_percentage]` | **Integer**<br>The discount percentage for this product when rented out in a bundle
`data[attributes][position]` | **Integer**<br>Position of the product in bundle list
`data[attributes][bundle_id]` | **Uuid**<br>The associated Bundle
`data[attributes][product_group_id]` | **Uuid**<br>The associated Product group
`data[attributes][product_id]` | **Uuid**<br>The associated Product


### Includes

This request accepts the following includes:

`bundle`


`product`


`product_group`






## Deleting a bundle item



> How to delete a bundle item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/bundle_items/892bf10e-da61-4139-a304-c30598b95e52' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=bundle,product_group,product`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[bundle_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes