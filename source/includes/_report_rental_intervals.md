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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-08-16+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1eb0a459-0fc1-4d64-b18d-81ad821342fe&filter%5Btill%5D=2024-08-25+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ff29932-c2e6-409a-abee-23e850306f79",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "d0f4e716-6bc8-4da2-be09-5db517941f34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "2026a39d-2be6-404e-9b15-307837c7fbec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "4e3f9b3b-fe9e-43d9-b663-3147dd0b37b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "f61a0f4c-830a-4881-97f0-875cb50ce140",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "c195d4b3-6e75-40ea-b3ee-cb9abf813ed0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "d651fdd8-584d-4178-94f4-7c6fbb928caa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "a93c5704-5133-4315-aea6-cc60d6d80c44",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "f64da547-a1b6-449b-9ae1-e5bcb47676b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
      },
      "relationships": {}
    },
    {
      "id": "e686cc9e-7842-4134-bbe9-20297dc8c0b6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1eb0a459-0fc1-4d64-b18d-81ad821342fe"
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







