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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-07-12+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0953c693-45ce-46d0-a6cf-ddb5be25c493&filter%5Btill%5D=2024-07-21+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "7223a4c0-2501-4305-8910-b43ba8d72fcd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "ed0ff63f-6ab0-4a27-b03f-06d92d35cfab",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "8947e8f9-4375-4b55-8319-1311a627e08f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "ba04e627-04b0-4ca0-b3ed-8d2a7c1efe06",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "6acce305-5ff3-46c1-b0ef-e58895fc230c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "8c4f2cd7-6286-421e-832d-7839bdd5e9fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "cb724e02-04f4-4a5b-9cff-f71891a289b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-18",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "3c90e4ea-353a-4e65-8801-8acfa8001f55",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "b32359ea-5b63-42d8-9f11-84bea02c468e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-20",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
      },
      "relationships": {}
    },
    {
      "id": "a6585029-d0df-40b3-b6f5-3c7dbff3e149",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0953c693-45ce-46d0-a6cf-ddb5be25c493"
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







