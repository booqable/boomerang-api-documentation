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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-11-01+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=194d7f6a-54fc-49e1-90fe-cad9222a799f&filter%5Btill%5D=2024-11-10+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f88e7f46-5b9b-42cf-8bb9-8a40eff75277",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "2ba81f0a-547c-4d53-b69f-a5a51a99a5fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "235ebac9-8536-470c-8056-92c87cfa880c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "45f94ee1-86f3-41c4-9e39-a2f8ec0baf61",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "b93d8341-9e40-4924-8251-78ce02ec1379",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "32de3066-dbbd-47fb-a100-f68236c0d7db",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "5ab8e943-7a34-402b-9aaa-e4dee991adec",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "caa945c4-423d-4374-9a1e-0b75b3a8571b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "e036144c-1ecf-433a-8e8e-92d79c52f413",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
      },
      "relationships": {}
    },
    {
      "id": "b311f11a-691e-407b-9254-cc02c7450a2b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "194d7f6a-54fc-49e1-90fe-cad9222a799f"
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







