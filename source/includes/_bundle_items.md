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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=47d02902-2ffc-45df-bece-36202edb30e5' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "01087750-bc8e-41f7-89dc-0f93432f09e7",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-05-05T09:12:30+00:00",
        "updated_at": "2022-05-05T09:12:30+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "47d02902-2ffc-45df-bece-36202edb30e5",
        "product_group_id": "d0d2d7d6-f877-48f3-ba00-a9ea1d10db60",
        "product_id": "edc61ae3-1cc4-4b8d-9f68-823ec51f636a"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/47d02902-2ffc-45df-bece-36202edb30e5"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/d0d2d7d6-f877-48f3-ba00-a9ea1d10db60"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/edc61ae3-1cc4-4b8d-9f68-823ec51f636a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-05T09:12:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/75cb0c6e-f493-4cd8-95af-02e3c4af029d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "75cb0c6e-f493-4cd8-95af-02e3c4af029d",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-05-05T09:12:30+00:00",
      "updated_at": "2022-05-05T09:12:30+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "6fb4bae2-f7e6-40ab-b2bc-b2a598297135",
      "product_group_id": "0f6ddd60-7952-4d55-859a-930fd230dc4e",
      "product_id": "3f35fb51-1b17-45fe-8cb8-28ebf374e816"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/6fb4bae2-f7e6-40ab-b2bc-b2a598297135"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/0f6ddd60-7952-4d55-859a-930fd230dc4e"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/3f35fb51-1b17-45fe-8cb8-28ebf374e816"
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
          "bundle_id": "25585733-5f61-4519-8715-f59fa7048208",
          "product_group_id": "eeb94dea-a787-47be-9a05-f0d84d88b6ce",
          "product_id": "800461e9-6649-44e9-9255-f937e73834e2",
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
    "id": "3fe4373d-7094-42e1-bdba-f0317ecb1494",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-05-05T09:12:31+00:00",
      "updated_at": "2022-05-05T09:12:31+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "25585733-5f61-4519-8715-f59fa7048208",
      "product_group_id": "eeb94dea-a787-47be-9a05-f0d84d88b6ce",
      "product_id": "800461e9-6649-44e9-9255-f937e73834e2"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/034b953c-a01c-49c8-a139-dc4dd45dbe09' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "034b953c-a01c-49c8-a139-dc4dd45dbe09",
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
    "id": "034b953c-a01c-49c8-a139-dc4dd45dbe09",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-05-05T09:12:31+00:00",
      "updated_at": "2022-05-05T09:12:31+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "b052c049-f5a4-432c-bb3c-b17d5db09dd4",
      "product_group_id": "8e11871c-0fe1-4ad3-bd2b-fef4dcb66fc2",
      "product_id": "0f91b1ef-42e4-4cae-aabb-54f26cbb2594"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/44a47dc4-3b6e-4d46-8991-2abee87da30d' \
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