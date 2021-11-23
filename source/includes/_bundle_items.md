# Bundle items

Bundle items define which products and product groups are associated with a bundle. When bundles are planned on an order the quantity and discount percentage defined in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations, the variation needs to be specified when adding this bundle to an order (see [bookings](#bookings) for more information).

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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c9ff83e3-7e6c-448a-a9b5-589f2582acf1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2021-11-23T12:47:48+00:00",
        "updated_at": "2021-11-23T12:47:48+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96",
        "product_group_id": "4953baaf-319b-4d53-a82c-bb714e0f7928",
        "product_id": "f303bb76-b024-4d91-a3bf-0f9fd93af07a"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/4953baaf-319b-4d53-a82c-bb714e0f7928"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/f303bb76-b024-4d91-a3bf-0f9fd93af07a"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?filter%5Bbundle_id%5D=3fe1c1ba-f0ae-4f8f-b5ab-c0cdfe0c7f96&page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-11-23T12:47:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/131b7ded-e6b1-426f-9c6d-1a65e1a29fc0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "131b7ded-e6b1-426f-9c6d-1a65e1a29fc0",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-23T12:47:48+00:00",
      "updated_at": "2021-11-23T12:47:48+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "2740c1f3-82fc-492b-bd7b-e10eca52d86c",
      "product_group_id": "bfbcc970-1e64-423a-a6b7-9a79a071b015",
      "product_id": "173ca465-4674-4d40-b734-218341ff271b"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/2740c1f3-82fc-492b-bd7b-e10eca52d86c"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/bfbcc970-1e64-423a-a6b7-9a79a071b015"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/173ca465-4674-4d40-b734-218341ff271b"
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
          "bundle_id": "78024bc6-3e08-4f52-985b-519fb9369686",
          "product_group_id": "b131cd92-f28e-48c0-b371-f88ba0d39d18",
          "product_id": "e23fc8cb-3e63-4e60-884c-31c8bc69ad2b",
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
    "id": "02f3119f-a9cc-465c-89a6-6639d8997134",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-23T12:47:49+00:00",
      "updated_at": "2021-11-23T12:47:49+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "78024bc6-3e08-4f52-985b-519fb9369686",
      "product_group_id": "b131cd92-f28e-48c0-b371-f88ba0d39d18",
      "product_id": "e23fc8cb-3e63-4e60-884c-31c8bc69ad2b"
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
  "links": {
    "self": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=78024bc6-3e08-4f52-985b-519fb9369686&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=b131cd92-f28e-48c0-b371-f88ba0d39d18&data%5Battributes%5D%5Bproduct_id%5D=e23fc8cb-3e63-4e60-884c-31c8bc69ad2b&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=78024bc6-3e08-4f52-985b-519fb9369686&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=b131cd92-f28e-48c0-b371-f88ba0d39d18&data%5Battributes%5D%5Bproduct_id%5D=e23fc8cb-3e63-4e60-884c-31c8bc69ad2b&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/bundle_items?data%5Battributes%5D%5Bbundle_id%5D=78024bc6-3e08-4f52-985b-519fb9369686&data%5Battributes%5D%5Bdiscount_percentage%5D=15&data%5Battributes%5D%5Bproduct_group_id%5D=b131cd92-f28e-48c0-b371-f88ba0d39d18&data%5Battributes%5D%5Bproduct_id%5D=e23fc8cb-3e63-4e60-884c-31c8bc69ad2b&data%5Battributes%5D%5Bquantity%5D=2&data%5Btype%5D=bundle_items&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/528ae71c-be6e-4989-93ee-59f1ccbce2a8' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "528ae71c-be6e-4989-93ee-59f1ccbce2a8",
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
    "id": "528ae71c-be6e-4989-93ee-59f1ccbce2a8",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2021-11-23T12:47:49+00:00",
      "updated_at": "2021-11-23T12:47:49+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "50f3d821-5063-432b-9eb8-1527786ced7f",
      "product_group_id": "a99941b8-dc38-4940-b48c-917eb032f251",
      "product_id": "1bbfa9cf-64e4-4be3-b5ec-dd3acc208cdc"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/56843636-37b0-4da9-8eda-f389f3107815' \
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