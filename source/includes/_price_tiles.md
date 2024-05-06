# Price tiles

Price tiles hold information on how to calculate a price for a specific period. According to the `charge_length`, a tile will be picked in price calculations. Note that Booqable always rounds up to the highest tile it can find. The base price of a product is multiplied by the `multiplier`.

## Endpoints
`POST /api/boomerang/price_tiles`

`PUT /api/boomerang/price_tiles/{id}`

`GET /api/boomerang/price_tiles/{id}`

`GET /api/boomerang/price_tiles`

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
          "price_structure_id": "d43bd444-1601-4bcb-bbd4-2024dc883d18",
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
    "id": "408764bb-81bc-4c19-8ba3-346185954bdd",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-05-06T09:23:26+00:00",
      "updated_at": "2024-05-06T09:23:26+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "d43bd444-1601-4bcb-bbd4-2024dc883d18"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/48a4a0e3-c9c3-4919-9489-9e786c2aa0d4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "48a4a0e3-c9c3-4919-9489-9e786c2aa0d4",
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
    "id": "48a4a0e3-c9c3-4919-9489-9e786c2aa0d4",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-05-06T09:23:27+00:00",
      "updated_at": "2024-05-06T09:23:27+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "d9cf6d73-83d1-4f3b-9d27-7d8d157e1b86"
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






## Fetching a price tile



> How to fetch a price tile:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/58614ee5-f598-44c4-be47-0f192dd051b7?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "58614ee5-f598-44c4-be47-0f192dd051b7",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-05-06T09:23:28+00:00",
      "updated_at": "2024-05-06T09:23:28+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "eb922c7a-6cef-496a-8366-f47ad4364fe3"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/eb922c7a-6cef-496a-8366-f47ad4364fe3"
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
      "id": "08eb9d8a-4ed5-43a0-a338-189bb6e8a5d4",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2024-05-06T09:23:28+00:00",
        "updated_at": "2024-05-06T09:23:28+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "d261a0b5-f20c-47b4-9610-de20f03b073f"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/d261a0b5-f20c-47b4-9610-de20f03b073f"
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
## Deleting a price tile



> How to delete a price tile:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/dd56fb1f-dd3a-44ca-9583-da906e1b1392' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "dd56fb1f-dd3a-44ca-9583-da906e1b1392",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2024-05-06T09:23:29+00:00",
      "updated_at": "2024-05-06T09:23:29+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "231b62f2-bfcf-4d13-b419-c58e75a6a8bb"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/231b62f2-bfcf-4d13-b419-c58e75a6a8bb"
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