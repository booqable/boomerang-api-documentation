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
`bundle_id` | **Uuid** `readonly-after-create`<br>Associated Bundle
`product_group_id` | **Uuid** `readonly-after-create`<br>Associated Product group
`product_id` | **Uuid** `nullable`<br>Associated Product


## Relationships
Bundle items have the following relationships:

Name | Description
-- | --
`bundle` | **[Bundle](#bundles)** <br>Associated Bundle
`product` | **[Product](#products)** <br>Associated Product
`product_group` | **[Product group](#product-groups)** <br>Associated Product group


## Listing bundle items



> How to fetch a list of bundle items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=5517c252-34bb-4d35-904d-52c40b9c083c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a6201576-4802-4320-a9e4-07ce1e5db2c1",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T13:06:03.506662+00:00",
        "updated_at": "2024-12-02T13:06:03.506662+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "5517c252-34bb-4d35-904d-52c40b9c083c",
        "product_group_id": "97d4ae97-9ce7-4122-a302-3b77221fcf42",
        "product_id": "e0dcd33d-20e3-4a3f-a0b4-913c10faeb49"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/d6f77169-f694-415f-8c87-ea58cc043570' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d6f77169-f694-415f-8c87-ea58cc043570",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T13:06:01.735727+00:00",
      "updated_at": "2024-12-02T13:06:01.735727+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "f69e60b8-9bf0-4263-9d95-9fb1f15e57a4",
      "product_group_id": "e8c0570d-d1ed-4866-9544-b6380dd36af3",
      "product_id": "79295b5d-33bb-4a1e-8c45-6ae0205f9c2a"
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
          "bundle_id": "4c556d94-6b6a-450c-9c3a-9a0eb453352a",
          "product_group_id": "075fa240-9b55-4ea7-b9c9-89dc7426b23e",
          "product_id": "953ffdea-43a9-414c-bb3a-f107c99b9210",
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
    "id": "c792614f-c3ae-45f4-8760-c4a494912ef3",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T13:06:02.759798+00:00",
      "updated_at": "2024-12-02T13:06:02.759798+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "4c556d94-6b6a-450c-9c3a-9a0eb453352a",
      "product_group_id": "075fa240-9b55-4ea7-b9c9-89dc7426b23e",
      "product_id": "953ffdea-43a9-414c-bb3a-f107c99b9210"
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
`data[attributes][bundle_id]` | **Uuid** <br>Associated Bundle
`data[attributes][product_group_id]` | **Uuid** <br>Associated Product group
`data[attributes][product_id]` | **Uuid** <br>Associated Product


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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/300dfcbb-f267-4124-8326-f6ad1b37cce4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "300dfcbb-f267-4124-8326-f6ad1b37cce4",
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
    "id": "300dfcbb-f267-4124-8326-f6ad1b37cce4",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T13:06:00.079229+00:00",
      "updated_at": "2024-12-02T13:06:00.153430+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "1921a694-2047-457b-bd9b-c2c30ba08adb",
      "product_group_id": "3e46a9ba-55a7-43ea-ae7f-eb07d6ad9dfd",
      "product_id": "2d010170-5dab-460d-b230-994d1e64e18c"
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
`data[attributes][bundle_id]` | **Uuid** <br>Associated Bundle
`data[attributes][product_group_id]` | **Uuid** <br>Associated Product group
`data[attributes][product_id]` | **Uuid** <br>Associated Product


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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/a72429bd-b377-44f6-918d-58a41270ffce' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a72429bd-b377-44f6-918d-58a41270ffce",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T13:06:00.964264+00:00",
      "updated_at": "2024-12-02T13:06:00.964264+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "6925e600-b48e-4ece-b31d-576b99d26dfe",
      "product_group_id": "3ae1d134-cab0-4591-81e4-b3bca7beee58",
      "product_id": "c52b6639-a500-4dba-b35a-2f8d768cf4ac"
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