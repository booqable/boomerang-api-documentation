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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=40db748a-5d26-49ed-b788-06dd5671bd6f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c677d41f-4071-496d-b144-0df83b19cf8a",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2022-02-10T10:31:05+00:00",
        "updated_at": "2022-02-10T10:31:05+00:00",
        "quantity": "2",
        "discount_percentage": 15,
        "position": 1,
        "bundle_id": "40db748a-5d26-49ed-b788-06dd5671bd6f",
        "product_group_id": "8995b331-8374-45c5-9e04-5e089b67da27",
        "product_id": "ab8e5f47-6726-4585-9868-3ceb75373ea7"
      },
      "relationships": {
        "bundle": {
          "links": {
            "related": "api/boomerang/bundles/40db748a-5d26-49ed-b788-06dd5671bd6f"
          }
        },
        "product_group": {
          "links": {
            "related": "api/boomerang/product_groups/8995b331-8374-45c5-9e04-5e089b67da27"
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/ab8e5f47-6726-4585-9868-3ceb75373ea7"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-10T10:30:50Z`
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7b541fd9-3134-40b4-a5da-e6ef0b3bb2f0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7b541fd9-3134-40b4-a5da-e6ef0b3bb2f0",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-10T10:31:05+00:00",
      "updated_at": "2022-02-10T10:31:05+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 1,
      "bundle_id": "d1bfedba-9c29-49fb-9fc9-7a718a2020e3",
      "product_group_id": "8dad2cf6-e633-4f57-a4b8-aa58706ed213",
      "product_id": "0bba5669-6e09-400c-a945-37ae246c37fc"
    },
    "relationships": {
      "bundle": {
        "links": {
          "related": "api/boomerang/bundles/d1bfedba-9c29-49fb-9fc9-7a718a2020e3"
        }
      },
      "product_group": {
        "links": {
          "related": "api/boomerang/product_groups/8dad2cf6-e633-4f57-a4b8-aa58706ed213"
        }
      },
      "product": {
        "links": {
          "related": "api/boomerang/products/0bba5669-6e09-400c-a945-37ae246c37fc"
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
          "bundle_id": "556d4546-8a0f-48ca-a41a-6f6e65584630",
          "product_group_id": "7dca7551-41d9-4a93-b3f8-9d87931bcf85",
          "product_id": "b051c9ca-ead1-42f6-aa74-126870841459",
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
    "id": "fd517a44-bd63-4cb5-868e-b329d0c45848",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-10T10:31:06+00:00",
      "updated_at": "2022-02-10T10:31:06+00:00",
      "quantity": "2",
      "discount_percentage": 15,
      "position": 2,
      "bundle_id": "556d4546-8a0f-48ca-a41a-6f6e65584630",
      "product_group_id": "7dca7551-41d9-4a93-b3f8-9d87931bcf85",
      "product_id": "b051c9ca-ead1-42f6-aa74-126870841459"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d6e12d09-804e-4a9a-84e7-9243417e94ec' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d6e12d09-804e-4a9a-84e7-9243417e94ec",
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
    "id": "d6e12d09-804e-4a9a-84e7-9243417e94ec",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2022-02-10T10:31:07+00:00",
      "updated_at": "2022-02-10T10:31:07+00:00",
      "quantity": "3",
      "discount_percentage": 20,
      "position": 1,
      "bundle_id": "5ff6105e-18e3-43b3-8732-fa5f75b1d70a",
      "product_group_id": "4c26d48d-2724-46f4-a21a-16419da8f671",
      "product_id": "8fb21ace-4855-4fc8-a32d-a35ca3c0a152"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/a56a1278-1d82-4b6f-aad3-19042a0cc2bb' \
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