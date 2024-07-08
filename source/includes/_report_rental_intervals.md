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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-06-28+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=af009ab3-a6fd-411a-ac76-442b4e2ad4c6&filter%5Btill%5D=2024-07-07+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5d955f59-3862-41d1-8e3d-858bee0093e1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "887aaf6d-0826-45b8-a22f-0ef09b7e841c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "4554a90f-1e28-4728-bd6f-0c85c968ab68",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "19b2e826-b090-4e1e-be55-fddeda890115",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "34cd052b-14a9-4628-8623-446addb132c4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-02",
        "rented_count": 1,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "2c11b266-e21b-4fcd-9b7a-2e964c7be4b2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "c8ebdba7-1695-4147-89f1-317e4efb1227",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-04",
        "rented_count": 1,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "abfeb82c-1070-43bc-aa8c-17eba3ca6cd9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "0c07a69a-8401-4525-986f-428281500dba",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
      },
      "relationships": {}
    },
    {
      "id": "608e87d3-3632-4228-b1c4-9a15655ed8fa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "af009ab3-a6fd-411a-ac76-442b4e2ad4c6"
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







