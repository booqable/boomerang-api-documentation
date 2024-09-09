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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-08-30+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=dc301675-aeee-4e25-9371-ae15856ab91f&filter%5Btill%5D=2024-09-08+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "04467e2d-0888-4cf7-9eb6-2a25eae9e5f3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "d80d59bb-6029-4feb-8433-76a4be47b3a9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "27d6fb82-26ce-4944-a825-3a4daf447f9d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "808ef193-42c3-4f74-8e13-748c1fa20941",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "37e5129c-1636-487f-a4f7-f752798a62b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "d897a12c-829c-44de-a8a9-3edaeb8989e0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "9f23a78a-2b8c-450c-b586-f994126c9ec2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "38cb6396-404f-4efc-b404-0b7035f5c03c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "2d5dd2e9-c926-44d9-a13d-9b5dbab64f88",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-07",
        "rented_count": 1,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
      },
      "relationships": {}
    },
    {
      "id": "34369857-215c-42b4-b595-d473b419ca97",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "dc301675-aeee-4e25-9371-ae15856ab91f"
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







