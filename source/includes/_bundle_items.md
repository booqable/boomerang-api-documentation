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
    --url 'https://example.booqable.com/api/boomerang/bundle_items?filter%5Bbundle_id%5D=2a110fde-70d1-474b-a3ee-c28c55dd7afb' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "278273fe-96fd-41dc-8cec-e252d769accb",
      "type": "bundle_items",
      "attributes": {
        "created_at": "2024-12-02T09:23:27.981112+00:00",
        "updated_at": "2024-12-02T09:23:27.981112+00:00",
        "quantity": 2,
        "discount_percentage": 15.0,
        "position": 1,
        "bundle_id": "2a110fde-70d1-474b-a3ee-c28c55dd7afb",
        "product_group_id": "283688b7-f340-425d-8a03-505b45e49e12",
        "product_id": "6f84e65f-a4f4-4c55-a5fa-ef6a20f535a1"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/dbc96719-b4bc-4d2f-a2ca-41f16533005e' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dbc96719-b4bc-4d2f-a2ca-41f16533005e",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T09:23:28.800663+00:00",
      "updated_at": "2024-12-02T09:23:28.800663+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "6669feef-a168-448c-bd47-903ff90c5b38",
      "product_group_id": "d2336073-ac4d-4d9e-b381-fda52fd0fe10",
      "product_id": "867f54e4-bcd1-48b1-804f-9f332797d88f"
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
          "bundle_id": "05ef383f-d217-4f08-b376-4e3d54e2748e",
          "product_group_id": "e2507b25-e87e-4a6a-b63c-d3bd602fa69c",
          "product_id": "67f3e239-3b7b-4d45-879f-0f17e9f4588a",
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
    "id": "475e8ac2-16e1-43ae-b6a5-30a6e596f746",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T09:23:29.949436+00:00",
      "updated_at": "2024-12-02T09:23:29.949436+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 2,
      "bundle_id": "05ef383f-d217-4f08-b376-4e3d54e2748e",
      "product_group_id": "e2507b25-e87e-4a6a-b63c-d3bd602fa69c",
      "product_id": "67f3e239-3b7b-4d45-879f-0f17e9f4588a"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/9dcea341-5a3b-4a5d-80cd-d96a83166241' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9dcea341-5a3b-4a5d-80cd-d96a83166241",
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
    "id": "9dcea341-5a3b-4a5d-80cd-d96a83166241",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T09:23:27.138556+00:00",
      "updated_at": "2024-12-02T09:23:27.218228+00:00",
      "quantity": 3,
      "discount_percentage": 20.0,
      "position": 1,
      "bundle_id": "4a10489b-38dc-4186-b0a6-fc26f051a4cb",
      "product_group_id": "0d6a0b99-5f86-4d08-8745-d84945f19111",
      "product_id": "aac90fbd-8c67-4df9-8711-5f7dce073bfe"
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
    --url 'https://example.booqable.com/api/boomerang/bundle_items/06587338-ae03-4c0d-adea-01190c2ada92' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "06587338-ae03-4c0d-adea-01190c2ada92",
    "type": "bundle_items",
    "attributes": {
      "created_at": "2024-12-02T09:23:26.357173+00:00",
      "updated_at": "2024-12-02T09:23:26.357173+00:00",
      "quantity": 2,
      "discount_percentage": 15.0,
      "position": 1,
      "bundle_id": "d7aaa73c-39ed-4148-b040-2621ae93adbc",
      "product_group_id": "dd97f353-d211-48c5-a6ed-d161b771a3b3",
      "product_id": "69ec3e5a-6a5a-4f6d-91cb-14f7d17ae50a"
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