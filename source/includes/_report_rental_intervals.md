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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-08-23+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=47cee8a5-c525-44ee-aca8-5d102cd96985&filter%5Btill%5D=2024-09-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8ebf1924-7c8f-4756-b5b5-84fb94649c20",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "3a91760e-afe3-41eb-b39f-77d526653f9c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "591292e4-043a-4cf8-bf99-7001f3e029a6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "df7b4552-05e5-4ad4-ac12-e69862884f01",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "67882dca-7284-484a-9d27-5a72826cc456",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "3462c6a8-7c7c-4c2e-856e-5fabe61bbe91",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "303c97cc-13da-49a1-b362-39b147a557f4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "4874f222-9423-4ef0-a88f-399e1b6cb340",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "fa6cff69-347d-4ffb-bed5-2fad31022dbc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-31",
        "rented_count": 1,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
      },
      "relationships": {}
    },
    {
      "id": "cf39333d-5635-4cfe-a889-c6a428d40692",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "47cee8a5-c525-44ee-aca8-5d102cd96985"
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







