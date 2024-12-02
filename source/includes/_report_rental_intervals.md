# Report rental intervals

Breakdown of how many times a product was rented during a specific period.

## Fields
Every report rental interval has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`date` | **Date** <br>Interval date
`rented_count` | **Integer** <br>Times the product was rented
`interval` | **String** <br>The interval of the breakdown
`product_id` | **Uuid** <br>Associated Product


## Relationships
Report rental intervals have the following relationships:

Name | Description
-- | --
`product` | **[Product](#products)** <br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-11-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=de21c82b-52b6-4574-83ca-ba29078d9143&filter%5Btill%5D=2024-12-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "513444e2-9aa6-4a64-82c4-8136b46793f5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "9aeac109-c21d-4cfe-b4b7-91460733f5ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "670b4567-e8d0-4dbd-a91c-fbab6b867c55",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "47e270d3-3791-4079-b617-82a32339da87",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "adf83670-e350-4c4a-abd3-213759c1550e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "8c7c309d-ff98-453c-abb7-19c3baea3202",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "30b83d96-edba-4757-80b9-737d240784a1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "35dd5c5f-4707-4bda-b6fe-f2089f254f99",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "c423844b-5bea-4290-80d6-8b281f84d61e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
      },
      "relationships": {}
    },
    {
      "id": "0c2d64a4-7606-4254-97f8-5827008b90a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "de21c82b-52b6-4574-83ca-ba29078d9143"
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







