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
      "id": "5eb67607-c9ed-44f7-8f89-91f68d40eaff",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-10-25T17:54:21+00:00",
        "updated_at": "2022-10-25T17:54:21+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "82459378-fe86-4cc8-9ec3-f2af55d57713"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/82459378-fe86-4cc8-9ec3-f2af55d57713"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/3fb2127e-118f-4aa1-9182-36e722490dab?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fb2127e-118f-4aa1-9182-36e722490dab",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-10-25T17:54:22+00:00",
      "updated_at": "2022-10-25T17:54:22+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "f8cf9b8a-512f-46dd-b06c-4f4e4a9aa86b"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/f8cf9b8a-512f-46dd-b06c-4f4e4a9aa86b"
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
          "price_structure_id": "418d81c2-77e5-4c3d-970c-c7307fd93250",
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
    "id": "0955b668-86bc-4263-a094-fad167ae88fb",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-10-25T17:54:22+00:00",
      "updated_at": "2022-10-25T17:54:22+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "418d81c2-77e5-4c3d-970c-c7307fd93250"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/d9361c3e-c4ec-437f-b9a5-60836c5d9724' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d9361c3e-c4ec-437f-b9a5-60836c5d9724",
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
    "id": "d9361c3e-c4ec-437f-b9a5-60836c5d9724",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-10-25T17:54:23+00:00",
      "updated_at": "2022-10-25T17:54:23+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "57ff5dfb-fd52-474c-b1f0-a62136eea212"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/ddd94b56-93a2-4e6f-9ade-177c72594ac8' \
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