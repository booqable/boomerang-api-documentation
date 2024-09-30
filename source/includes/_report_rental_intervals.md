# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-09-20+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=08c0a73c-1d0f-4066-bb41-7af6a2d30944&filter%5Btill%5D=2024-09-29+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f8aba4bf-60dc-4c33-a61e-24909847a18a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "9fd83f66-37df-491f-aa45-2fba6d48a4c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "e1beff18-e848-4597-9420-c44935ea33a8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "975763c7-d51b-4655-a344-5b118296a8cc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "3a824f82-62c6-42a8-ad52-e6112de9d15c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "d72e5def-3cfb-4317-9266-e97f38da5905",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "99bf6a21-beeb-4509-966e-808e26c4d62f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "bf58f57f-984c-4571-b578-e66887ba090f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "e80e35fa-967b-4f90-926f-bf4b692afd7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    },
    {
      "id": "9ddee0f4-40d4-463f-89ae-91ffb0ff05fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "08c0a73c-1d0f-4066-bb41-7af6a2d30944"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_rental_intervals`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rental_intervals]=date,rented_count,interval`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`product_id` | **Uuid** `required`<br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







