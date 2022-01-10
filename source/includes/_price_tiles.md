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
      "id": "9b8720d6-ea16-4f26-bcea-442dab53d072",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2022-01-10T13:52:36+00:00",
        "updated_at": "2022-01-10T13:52:36+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "07224c4f-3176-481e-b7c8-fc984b72e218"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/07224c4f-3176-481e-b7c8-fc984b72e218"
          }
        }
      }
    }
  ],
  "links": {
    "self": "api/boomerang/price_tiles?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/price_tiles?page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/price_tiles?page%5Bnumber%5D=1&page%5Bsize%5D=25"
  },
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-10T13:49:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/b5bda611-fc23-456d-aeda-7d6eebb873ce?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5bda611-fc23-456d-aeda-7d6eebb873ce",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-01-10T13:52:36+00:00",
      "updated_at": "2022-01-10T13:52:36+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "48dffca1-52af-4faf-8ca9-4bd205dc59f2"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/48dffca1-52af-4faf-8ca9-4bd205dc59f2"
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
          "price_structure_id": "77157742-1707-4082-96c0-2bae7a887f82",
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
    "id": "9173e162-2f61-4398-a293-d736a7a76347",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-01-10T13:52:37+00:00",
      "updated_at": "2022-01-10T13:52:37+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "77157742-1707-4082-96c0-2bae7a887f82"
    },
    "relationships": {
      "price_structure": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "links": {
    "self": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles",
    "first": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles",
    "last": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=77157742-1707-4082-96c0-2bae7a887f82&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/999a2377-2f18-45bd-820b-f361b8852f52' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "999a2377-2f18-45bd-820b-f361b8852f52",
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
    "id": "999a2377-2f18-45bd-820b-f361b8852f52",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2022-01-10T13:52:37+00:00",
      "updated_at": "2022-01-10T13:52:37+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "d2e19627-798c-456b-b1e5-090b0dc1d11b"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/96f58291-95dc-4c27-9c6f-13a76db67be0' \
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