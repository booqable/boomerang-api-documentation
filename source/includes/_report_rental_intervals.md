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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-10-25+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=b38e791c-245b-4011-9b44-72dd9ea2aea3&filter%5Btill%5D=2024-11-03+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3671bb04-674f-4854-a15a-cb84a0863bf2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "b819a925-17b3-4894-abdd-44230a982fa7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "c88d8863-3a91-4f50-bcfe-2a595d57c67f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "e8a0bf16-e2a5-4829-baa6-784bc910ddad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "33fd150e-d555-4c7b-a008-9df51a069bb9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "517e17b7-8168-4e29-9e40-7d1524f6610c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "dea7eae7-c3d5-4b01-ba84-6ddc6e5f54e9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "8de96450-26a0-4a5d-9053-6c619ef55d1b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "39b5e49b-d6fd-4427-b51c-4ed851b978ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
      },
      "relationships": {}
    },
    {
      "id": "43d1adbe-52fa-46f6-8957-bf315320491c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "b38e791c-245b-4011-9b44-72dd9ea2aea3"
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







