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
- | -
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
- | -
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
      "id": "a5f50db9-f603-4064-9ca3-2e06b08e1128",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-11-17T10:19:10+00:00",
        "updated_at": "2022-11-17T10:19:10+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "e366bd12-c0c6-4f0f-9544-8204250deb07"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/e366bd12-c0c6-4f0f-9544-8204250deb07"
          }
        }
      }
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
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T10:15:41Z`
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
`price_structure_id` | **Uuid** <br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price tile



> How to fetch a price tile:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/94bb5644-8e6e-490f-ab0f-9b7d02605651?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "94bb5644-8e6e-490f-ab0f-9b7d02605651",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-11-17T10:19:10+00:00",
      "updated_at": "2022-11-17T10:19:10+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "caba3a94-7be6-46e0-9c18-9b5dcc19da10"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/caba3a94-7be6-46e0-9c18-9b5dcc19da10"
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


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
          "price_structure_id": "9f2f1fdc-17f8-45ca-a615-d3b9147cb556",
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
    "id": "c3aa8107-5f53-4556-bab0-52f3f532e3f8",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-11-17T10:19:11+00:00",
      "updated_at": "2022-11-17T10:19:11+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "9f2f1fdc-17f8-45ca-a615-d3b9147cb556"
    },
    "relationships": {
      "price_structure": {
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

`POST /api/boomerang/price_tiles`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/6438a313-22e3-4c6a-b077-c3a8c90d5d06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6438a313-22e3-4c6a-b077-c3a8c90d5d06",
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
    "id": "6438a313-22e3-4c6a-b077-c3a8c90d5d06",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-11-17T10:19:11+00:00",
      "updated_at": "2022-11-17T10:19:11+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "06528c08-d353-486b-8f42-5ddc95648fea"
    },
    "relationships": {
      "price_structure": {
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

`PUT /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/2f0f4e52-12e0-4c0e-bbd2-e3f72f592274' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/price_tiles/{id}`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Includes

This request does not accept any includes