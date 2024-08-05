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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=861f100e-0f5f-4e0a-a1ab-315d10eb0634' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9be53c4e-594d-4391-917f-c6c8a9447a6c",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:45.300746+00:00",
        "updated_at": "2024-08-05T09:24:45.300746+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "861f100e-0f5f-4e0a-a1ab-315d10eb0634",
        "product_group_id": "1b2f1f7d-6084-4e50-9011-dae158b32a34",
        "product_id": "75db6ee0-41a4-4c97-84a0-7ae49d73ab40"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/7cd35da0-3eda-4082-aba6-30b57d2d2a41' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7cd35da0-3eda-4082-aba6-30b57d2d2a41",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-08-05T09:24:43.969771+00:00",
      "updated_at": "2024-08-05T09:24:43.969771+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "89f2cac5-4bfd-43a0-bb40-91c55af4704f",
      "product_group_id": "da4fabb8-756c-404e-b5b7-99c8f0aa59c5",
      "product_id": "1e7e223e-5620-4413-8900-4dc170f04715"
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
          "bundle_id": "d1c36659-de21-4293-b596-c69bf5477797",
          "product_group_id": "e3f5c2e8-d306-4ed6-b420-01da20d82e55",
          "product_id": "1d35fa8d-443a-4a9b-b530-0b43262cb7e1",
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
    "id": "a574ec80-03aa-46c0-8655-b3dc47bb865e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-08-05T09:24:42.575518+00:00",
      "updated_at": "2024-08-05T09:24:42.575518+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "d1c36659-de21-4293-b596-c69bf5477797",
      "product_group_id": "e3f5c2e8-d306-4ed6-b420-01da20d82e55",
      "product_id": "1d35fa8d-443a-4a9b-b530-0b43262cb7e1"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/332efe06-d4db-4b8f-a1ec-cdf2c21845b1' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "332efe06-d4db-4b8f-a1ec-cdf2c21845b1",
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
    "id": "332efe06-d4db-4b8f-a1ec-cdf2c21845b1",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-08-05T09:24:47.430529+00:00",
      "updated_at": "2024-08-05T09:24:47.537735+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "7b2f940f-ca14-4fd1-874f-41f524071da9",
      "product_group_id": "2c76e65d-0317-49c1-9ceb-1aea2d829896",
      "product_id": "ac436214-e17b-4f29-a025-fd6c609defaf"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/83bf8447-111a-4faf-980e-2706f29ee6b1' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "83bf8447-111a-4faf-980e-2706f29ee6b1",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-08-05T09:24:46.331753+00:00",
      "updated_at": "2024-08-05T09:24:46.331753+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "e5f3adc9-63fa-41c0-b348-3adf52477867",
      "product_group_id": "f09c4ac1-d6e0-4852-bc88-3f2a33ba9759",
      "product_id": "264f997c-d252-4b4a-a06c-c5c430ce935f"
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