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
      "id": "11253709-3380-46de-8300-9505c8ea8445",
      "type": "price_tiles",
      "attributes": {
        "created_at": "2021-12-08T11:26:13+00:00",
        "updated_at": "2021-12-08T11:26:13+00:00",
        "name": "3 hours",
        "quantity": 3,
        "length": 10800,
        "multiplier": 3.0,
        "period": "hours",
        "price_structure_id": "0ac722ed-64d5-496c-a27c-720746d2e063"
      },
      "relationships": {
        "price_structure": {
          "links": {
            "related": "api/boomerang/price_structures/0ac722ed-64d5-496c-a27c-720746d2e063"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-08T11:24:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/8e307bc5-8c96-42bf-a2cc-6442f5ee688e?include=price_tiles' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8e307bc5-8c96-42bf-a2cc-6442f5ee688e",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2021-12-08T11:26:14+00:00",
      "updated_at": "2021-12-08T11:26:14+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "f65f656f-9d63-4253-8948-5535584a410b"
    },
    "relationships": {
      "price_structure": {
        "links": {
          "related": "api/boomerang/price_structures/f65f656f-9d63-4253-8948-5535584a410b"
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
          "price_structure_id": "001b9084-4c91-453f-b0b1-91ab1b514876",
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
    "id": "1ac19e8f-5a61-48ae-92f7-f29f34db4b11",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2021-12-08T11:26:14+00:00",
      "updated_at": "2021-12-08T11:26:14+00:00",
      "name": "3 hours",
      "quantity": 3,
      "length": 10800,
      "multiplier": 3.0,
      "period": "hours",
      "price_structure_id": "001b9084-4c91-453f-b0b1-91ab1b514876"
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
    "self": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles",
    "first": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles",
    "last": "api/boomerang/price_tiles?data%5Battributes%5D%5Bmultiplier%5D=3&data%5Battributes%5D%5Bname%5D=3+hours&data%5Battributes%5D%5Bperiod%5D=hours&data%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&data%5Battributes%5D%5Bquantity%5D=3&data%5Btype%5D=price_tiles&page%5Bnumber%5D=1&page%5Bsize%5D=25&price_tile%5Bdata%5D%5Battributes%5D%5Bmultiplier%5D=3&price_tile%5Bdata%5D%5Battributes%5D%5Bname%5D=3+hours&price_tile%5Bdata%5D%5Battributes%5D%5Bperiod%5D=hours&price_tile%5Bdata%5D%5Battributes%5D%5Bprice_structure_id%5D=001b9084-4c91-453f-b0b1-91ab1b514876&price_tile%5Bdata%5D%5Battributes%5D%5Bquantity%5D=3&price_tile%5Bdata%5D%5Btype%5D=price_tiles"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/8989ceb5-54a7-4e12-bc73-09d44385e472' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8989ceb5-54a7-4e12-bc73-09d44385e472",
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
    "id": "8989ceb5-54a7-4e12-bc73-09d44385e472",
    "type": "price_tiles",
    "attributes": {
      "created_at": "2021-12-08T11:26:14+00:00",
      "updated_at": "2021-12-08T11:26:14+00:00",
      "name": "4 days",
      "quantity": 4,
      "length": 345600,
      "multiplier": 4.0,
      "period": "days",
      "price_structure_id": "e55a5562-e022-4600-b77a-cf9c0c8af3d2"
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
    --url 'https://example.booqable.com/api/boomerang/price_tiles/dd9a0615-0d8e-4e02-ada6-041e47e56665' \
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