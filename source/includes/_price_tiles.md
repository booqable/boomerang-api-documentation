# Price tiles

Price tiles hold information on how to calculate a price for a specific period. According to the `charge_length`, a tile will be picked in price calculations. Note that Booqable always rounds up to the highest tile it can find. The base price of a product is multiplied by the `multiplier`.

## Endpoints
`GET /api/boomerang/price_tiles`

`GET /api/boomerang/price_tiles/{id}`

`POST /api/boomerang/price_tiles`

`PUT /api/boomerang/price_tiles/{id}`

`DELETE /api/boomerang/price_tiles/{id}`

## Fields
Every price tile has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`name` | **String** <br>Name of the tile as it's going to be used in charge labels
`quantity` | **Integer** <br>Used in combination with period (e.g. `3` with period `days`)
`length` | **Integer** `readonly`<br>Length in seconds (is computed based on `quantity` and `period`)
`multiplier` | **Float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`period` | **String** <br>One of `hours`, `days`, `weeks`, `months`, `years`
`price_structure_id` | **Uuid** <br>The associated Price structure


## Relationships
Price tiles have the following relationships:

Name | Description
-- | --
`price_structure` | **Price structures** `readonly`<br>Associated Price structure


## Listing price tiles



> How to fetch a list of price tiles:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0c4c66ce-684e-4b7c-b5e6-ee436e5f647f",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-08-19T09:23:18.694897+00:00",
        "updated_at": "2024-08-19T09:23:18.694897+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "443f1a2d-c6f0-496b-b019-3406c52ef723"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_tiles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=created_at,updated_at,name`
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
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price tile



> How to fetch a price tile:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/cf6ccc5f-417e-4b3f-811f-e07f19e9a058?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "cf6ccc5f-417e-4b3f-811f-e07f19e9a058",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-08-19T09:23:19.299263+00:00",
      "updated_at": "2024-08-19T09:23:19.299263+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "200a0726-875b-468d-bc68-b8fa1397216c"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=created_at,updated_at,name`


### Includes

This request accepts the following includes:

`price_structure`






## Creating a price tile



> How to create a price tile:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/price_tiles' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "price_tiles",
        "attributes": {
          "price_structure_id": "c45396e4-726d-48ef-a0e4-7add4983d7c6",
          "name": "3 hours",
          "quantity": 3,
          "period": "hours",
          "multiplier": 3
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "4f8d46c1-2792-444b-af30-fd2b2459c983",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-08-19T09:23:21.101904+00:00",
      "updated_at": "2024-08-19T09:23:21.101904+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "c45396e4-726d-48ef-a0e4-7add4983d7c6"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/price_tiles`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tile as it's going to be used in charge labels
`data[attributes][quantity]` | **Integer** <br>Used in combination with period (e.g. `3` with period `days`)
`data[attributes][multiplier]` | **Float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][period]` | **String** <br>One of `hours`, `days`, `weeks`, `months`, `years`
`data[attributes][price_structure_id]` | **Uuid** <br>The associated Price structure


### Includes

This request accepts the following includes:

`price_structure`






## Updating a price tile



> How to update a price tile:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/94ceab49-214e-47f6-b020-797ab3640b86' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "94ceab49-214e-47f6-b020-797ab3640b86",
        "type": "price_tiles",
        "attributes": {
          "name": "4 days",
          "quantity": 4,
          "period": "days",
          "multiplier": 4
        }
      }
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "94ceab49-214e-47f6-b020-797ab3640b86",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-08-19T09:23:20.445208+00:00",
      "updated_at": "2024-08-19T09:23:20.490845+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "73d6eff3-e109-418f-917f-ac9d82af3a55"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=created_at,updated_at,name`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][name]` | **String** <br>Name of the tile as it's going to be used in charge labels
`data[attributes][quantity]` | **Integer** <br>Used in combination with period (e.g. `3` with period `days`)
`data[attributes][multiplier]` | **Float** <br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][period]` | **String** <br>One of `hours`, `days`, `weeks`, `months`, `years`
`data[attributes][price_structure_id]` | **Uuid** <br>The associated Price structure


### Includes

This request accepts the following includes:

`price_structure`






## Deleting a price tile



> How to delete a price tile:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/c0594d35-276b-4c6d-b033-cc33b470fd06' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c0594d35-276b-4c6d-b033-cc33b470fd06",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-08-19T09:23:19.838067+00:00",
      "updated_at": "2024-08-19T09:23:19.838067+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "dadbe8d6-60e9-4761-b7fd-3b0f5fe7f6d7"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=created_at,updated_at,name`


### Includes

This request does not accept any includes