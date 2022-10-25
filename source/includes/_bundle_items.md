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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=44ef8199-2e63-4525-ac3b-469ae0bea6d7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f038c45c-4c68-4308-9e4f-9a38dcc7fa93",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-10-25T17:51:21+00:00",
        "updated_at": "2022-10-25T17:51:21+00:00",
        "quantity": "2",
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "44ef8199-2e63-4525-ac3b-469ae0bea6d7",
        "product_group_id": "b1b34ce6-f7de-4676-9ec7-fd60bbba4e1f",
        "product_id": "dfa34d77-abf9-4f68-a65d-ed740ca2a342"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/44ef8199-2e63-4525-ac3b-469ae0bea6d7"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/b1b34ce6-f7de-4676-9ec7-fd60bbba4e1f"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/dfa34d77-abf9-4f68-a65d-ed740ca2a342"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d074a92c-4ebf-45ea-ae3f-75962a607cc7' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d074a92c-4ebf-45ea-ae3f-75962a607cc7",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T17:51:21+00:00",
      "updated_at": "2022-10-25T17:51:21+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "5f14458a-c2e1-4e46-a9a2-17fee4eb1948",
      "product_group_id": "53ada5da-e6f2-4173-868c-7c54aa222e47",
      "product_id": "1b6a4597-f8f0-4842-ad80-48f9204fd438"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/5f14458a-c2e1-4e46-a9a2-17fee4eb1948"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/53ada5da-e6f2-4173-868c-7c54aa222e47"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/1b6a4597-f8f0-4842-ad80-48f9204fd438"
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
          "bundle_id": "1fa2421c-e2a2-4a64-ba08-c6fc9fa723d5",
          "product_group_id": "29242b59-5b1d-45cb-a255-684674f0472d",
          "product_id": "b6183f81-cdb8-4ccd-b62e-6d78ed792795",
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
    "id": "cf69e1d5-e1cd-491e-b1fb-b94bba4a41bb",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T17:51:22+00:00",
      "updated_at": "2022-10-25T17:51:22+00:00",
      "quantity": "2",
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "1fa2421c-e2a2-4a64-ba08-c6fc9fa723d5",
      "product_group_id": "29242b59-5b1d-45cb-a255-684674f0472d",
      "product_id": "b6183f81-cdb8-4ccd-b62e-6d78ed792795"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/b73b7975-244a-413b-bc80-2ca7a968c108' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b73b7975-244a-413b-bc80-2ca7a968c108",
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
    "id": "b73b7975-244a-413b-bc80-2ca7a968c108",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-10-25T17:51:22+00:00",
      "updated_at": "2022-10-25T17:51:23+00:00",
      "quantity": "3",
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "851ea00d-6e75-4213-8449-32581ee023e4",
      "product_group_id": "a90354bb-21c5-4f13-af65-896b4a5809de",
      "product_id": "9b367f54-1c67-41eb-b3df-b1431cc277f0"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/11463b50-5d6e-45d2-b67d-2157ffbc0260' \
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