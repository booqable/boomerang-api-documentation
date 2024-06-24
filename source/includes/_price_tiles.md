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
      "id": "790158ca-96ac-4d6c-b61c-056b1500697f",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-06-24T09:23:58.332060+00:00",
        "updated_at": "2024-06-24T09:23:58.332060+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "abc29057-6517-40c5-a54a-9adb9a233b05"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/abc29057-6517-40c5-a54a-9adb9a233b05"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/a24786c0-f433-4e12-80b5-51e12e388910?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a24786c0-f433-4e12-80b5-51e12e388910",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-06-24T09:24:00.895165+00:00",
      "updated_at": "2024-06-24T09:24:00.895165+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "1fda1e49-bd5b-459e-bba9-045e2b00fea5"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/1fda1e49-bd5b-459e-bba9-045e2b00fea5"
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
          "price_structure_id": "76eb0b62-af81-43e2-86cf-4c4e56b209f1",
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
    "id": "7710884b-7425-4b11-8d87-3031d7ce689f",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-06-24T09:23:58.970579+00:00",
      "updated_at": "2024-06-24T09:23:58.970579+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "76eb0b62-af81-43e2-86cf-4c4e56b209f1"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/1ea36a26-7ca7-42c1-9551-0296e12ed8c3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1ea36a26-7ca7-42c1-9551-0296e12ed8c3",
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
    "id": "1ea36a26-7ca7-42c1-9551-0296e12ed8c3",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-06-24T09:23:59.485666+00:00",
      "updated_at": "2024-06-24T09:23:59.528981+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "f054f4b5-71cf-4fcc-9549-80e3b81ed4e6"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/39a4e2b1-274f-4edc-a913-7b2640261cd3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "39a4e2b1-274f-4edc-a913-7b2640261cd3",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-06-24T09:24:00.114814+00:00",
      "updated_at": "2024-06-24T09:24:00.114814+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "c1f72229-fde3-4743-92b7-a3b2986861bc"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/c1f72229-fde3-4743-92b7-a3b2986861bc"
        }
      }
    }
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