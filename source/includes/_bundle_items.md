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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=44ba9474-c8c3-4b61-86ba-f7e3e4984f46' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a4495e71-3ec3-4fae-a159-b3d4aed94ff6",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-04-08T17:51:31+00:00",
        "updated_at": "2022-04-08T17:51:31+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "44ba9474-c8c3-4b61-86ba-f7e3e4984f46",
        "product_group_id": "2ad80a3c-3681-4f5c-9c14-98b55bf2c7c7",
        "product_id": "c58ed60c-4c3c-45ac-b1df-dc41493cedff"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/44ba9474-c8c3-4b61-86ba-f7e3e4984f46"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/2ad80a3c-3681-4f5c-9c14-98b55bf2c7c7"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/c58ed60c-4c3c-45ac-b1df-dc41493cedff"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-08T17:51:17Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/6adf0c80-9cdc-42fc-be4a-b837d588fadc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6adf0c80-9cdc-42fc-be4a-b837d588fadc",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-04-08T17:51:31+00:00",
      "updated_at": "2022-04-08T17:51:31+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "c56cd681-d902-41d7-bb23-179927bb98eb",
      "product_group_id": "7cb64430-14bf-4073-8102-cf741caf2897",
      "product_id": "8558c3d2-ce3b-49aa-9f6e-357e7b6bbc76"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/c56cd681-d902-41d7-bb23-179927bb98eb"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/7cb64430-14bf-4073-8102-cf741caf2897"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/8558c3d2-ce3b-49aa-9f6e-357e7b6bbc76"
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
          "bundle_id": "96f91848-1450-4e69-9e6c-ddd90506bd7a",
          "product_group_id": "9a8e4cf0-db74-4e78-8cc1-d63372d55148",
          "product_id": "5ef70194-e064-4415-87f1-7be1458731ce",
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
    "id": "e60474d8-c421-4efb-afce-a08315e26167",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-04-08T17:51:32+00:00",
      "updated_at": "2022-04-08T17:51:32+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "96f91848-1450-4e69-9e6c-ddd90506bd7a",
      "product_group_id": "9a8e4cf0-db74-4e78-8cc1-d63372d55148",
      "product_id": "5ef70194-e064-4415-87f1-7be1458731ce"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/bee1d6dd-2c87-4bda-8e7f-4fa14f02ddb8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "bee1d6dd-2c87-4bda-8e7f-4fa14f02ddb8",
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
    "id": "bee1d6dd-2c87-4bda-8e7f-4fa14f02ddb8",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-04-08T17:51:32+00:00",
      "updated_at": "2022-04-08T17:51:32+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "a2a879a3-c31a-432f-8e47-14fef5283601",
      "product_group_id": "c4716c8d-d27e-43cc-b1e7-a0247d11075a",
      "product_id": "1c3c0792-6cf9-47cb-b925-469d9d56889a"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d166895b-88f3-4ff4-a4dc-92a116ce19a4' \
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