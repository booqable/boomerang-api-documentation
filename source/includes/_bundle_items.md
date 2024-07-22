# Bundle items

Bundle items define which products and product groups are associated with a bundle.
When bundles are planned on an order the quantity and discount percentage defined
in a bundle item will apply.

When `product_id` is left blank, and the associated product group has variations,
the variation needs to be specified when adding this bundle to an order.
See the `book_bundle` action under [OrderFulfilments](#order-fulfilments).

## Endpoints
`GET /api/boomerang/bundle_items`

`GET /api/boomerang/bundle_items/{id}`

`POST /api/boomerang/bundle_items`

`PUT /api/boomerang/bundle_items/{id}`

`DELETE /api/boomerang/bundle_items/{id}`

## Fields
Every bundle item has the following fields:

Name | Description
-- | --
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
-- | --
`bundle` | **Bundles** `readonly`<br>Associated Bundle
`product_group` | **Product groups**<br>Associated Product group
`product` | **Products** `readonly`<br>Associated Product


## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=8f4c7b46-da2f-4923-814b-68f19edc2714' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "223a78e7-57bb-4ac3-987a-f43bcb538f7c",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-07-22T09:28:18.994265+00:00",
        "updated_at": "2024-07-22T09:28:18.994265+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "8f4c7b46-da2f-4923-814b-68f19edc2714",
        "product_group_id": "570d39ad-8b80-4575-863b-e976e6ffc0c0",
        "product_id": "9a1500d6-f031-4fa4-8245-9a49a0f3741b"
      },
      "relationships": {}
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
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
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/ef1c2af3-0146-4648-96e8-c46202efab50' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ef1c2af3-0146-4648-96e8-c46202efab50",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-07-22T09:28:25.192207+00:00",
      "updated_at": "2024-07-22T09:28:25.192207+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "b69f2b2d-5a9a-40c1-bacd-2cd31066d09d",
      "product_group_id": "c5d5ced7-421c-40ab-abde-607397cd2edb",
      "product_id": "246c5f3e-92f0-49bc-a7bd-a05d2940018b"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


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
          "bundle_id": "eb049e25-7ad1-4ddc-8a10-bfe5550529b8",
          "product_group_id": "ae7a8b0f-2bcb-47c6-88e0-e3dfb2008ce2",
          "product_id": "58a5e25c-b94a-4589-bc1f-9dfa763c1532",
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
    "id": "fbd168e2-4e6d-4c35-b3a7-bd8182d226b7",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-07-22T09:28:23.871639+00:00",
      "updated_at": "2024-07-22T09:28:23.871639+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "eb049e25-7ad1-4ddc-8a10-bfe5550529b8",
      "product_group_id": "ae7a8b0f-2bcb-47c6-88e0-e3dfb2008ce2",
      "product_id": "58a5e25c-b94a-4589-bc1f-9dfa763c1532"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/bundle_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/eeb68ddd-f4f5-4c18-83b7-a769e1719e4e' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "eeb68ddd-f4f5-4c18-83b7-a769e1719e4e",
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
    "id": "eeb68ddd-f4f5-4c18-83b7-a769e1719e4e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-07-22T09:28:21.754468+00:00",
      "updated_at": "2024-07-22T09:28:21.935601+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "d1142f49-1dfd-4244-a3f7-06a5ddd2023a",
      "product_group_id": "c0842191-49e7-444c-aa1e-b28ae8390c17",
      "product_id": "b024865f-7323-44b8-9c77-7f81bd8c0b56"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=bundle,product,product_group`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Request body

This request accepts the following body:

Name | Description
-- | --
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/6a29bbcb-40c5-4011-a34f-5d4b768092a5' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6a29bbcb-40c5-4011-a34f-5d4b768092a5",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-07-22T09:28:20.302287+00:00",
      "updated_at": "2024-07-22T09:28:20.302287+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "e12dbf40-2e4b-41ea-8904-ef6bc36f3c7a",
      "product_group_id": "47b5c5af-ba5a-421d-b424-75e2f1837842",
      "product_id": "5af7e41f-6499-4070-9a08-d465aada5ace"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/bundle_items/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[bundle_items]=created_at,updated_at,quantity`


### Includes

This request does not accept any includes