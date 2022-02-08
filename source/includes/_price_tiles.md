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
`name` | **String**<br>Name of the tile as it's going to be used in charge labels
`quantity` | **Integer**<br>Used in combination with period (e.g. `3` with period `days`)
`length` | **Integer** `readonly`<br>Length in seconds (is computed based on `quantity` and `period`)
`multiplier` | **Float**<br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`period` | **String**<br>One of `hours`, `days`, `weeks`, `months`, `years`
`price_structure_id` | **Uuid**<br>The associated Price structure


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
      "id": "5c675a8e-e7ad-44f5-990e-043dd9f3ef4b",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-02-08T09:14:29+00:00",
        "updated_at": "2022-02-08T09:14:29+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "4a24abae-08b1-467b-869e-4dce81aae9d8"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/4a24abae-08b1-467b-869e-4dce81aae9d8"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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
`price_structure_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price tile



> How to fetch a price tile:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/f5643c72-35ed-4936-8e9a-30e1835acc68?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f5643c72-35ed-4936-8e9a-30e1835acc68",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-02-08T09:14:29+00:00",
      "updated_at": "2022-02-08T09:14:29+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "856907dd-8828-45e3-8bf3-da7280952641"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/856907dd-8828-45e3-8bf3-da7280952641"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


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
          "price_structure_id": "62ab17fd-a08a-48be-9ca9-4d229fd68be1",
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
    "id": "d3a95408-fb69-4bd1-a1a3-fa0691a41bab",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-02-08T09:14:30+00:00",
      "updated_at": "2022-02-08T09:14:30+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "62ab17fd-a08a-48be-9ca9-4d229fd68be1"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tile as it's going to be used in charge labels
`data[attributes][quantity]` | **Integer**<br>Used in combination with period (e.g. `3` with period `days`)
`data[attributes][multiplier]` | **Float**<br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][period]` | **String**<br>One of `hours`, `days`, `weeks`, `months`, `years`
`data[attributes][price_structure_id]` | **Uuid**<br>The associated Price structure


### Includes

This request accepts the following includes:

`price_structure`






## Updating a price tile



> How to update a price tile:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/5f634a80-fab5-471b-80bd-6d6046cf86de' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5f634a80-fab5-471b-80bd-6d6046cf86de",
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
    "id": "5f634a80-fab5-471b-80bd-6d6046cf86de",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-02-08T09:14:30+00:00",
      "updated_at": "2022-02-08T09:14:30+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "22fb037f-c6a8-4fe4-99bc-ae7739d2055b"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][name]` | **String**<br>Name of the tile as it's going to be used in charge labels
`data[attributes][quantity]` | **Integer**<br>Used in combination with period (e.g. `3` with period `days`)
`data[attributes][multiplier]` | **Float**<br>The amount to multiply a product's base price with (e.g. `2.8` for three days).
`data[attributes][period]` | **String**<br>One of `hours`, `days`, `weeks`, `months`, `years`
`data[attributes][price_structure_id]` | **Uuid**<br>The associated Price structure


### Includes

This request accepts the following includes:

`price_structure`






## Deleting a price tile



> How to delete a price tile:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/price_tiles/7c14dbdf-479e-4f64-8c68-3e345d07b200' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=price_structure`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[price_tiles]=id,created_at,updated_at`


### Includes

This request does not accept any includes