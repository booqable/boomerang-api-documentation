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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-09-27+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7f83985f-b246-4502-a21c-c67bc9616fd4&filter%5Btill%5D=2024-10-06+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "32837252-3873-46a0-a0bc-20c0308d135d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "f6e731ec-699c-45b5-8360-0507a64ec92d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "3b9540c6-cb1c-4d34-975f-ac6a5171def1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "e9887279-9daf-4caa-9b3c-de2043cf5852",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "d1a24b01-fbb7-4107-9739-49be856f8634",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "bf345d08-adb2-426b-ab0c-b68b53aabba2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "0b19d8eb-cc74-44d9-b957-d90ce2b72bc0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "80296d61-3e2d-464a-b3d1-e5e22ae68695",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "d3e7d7b4-8572-49af-a8e3-9fa77cc0120d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-05",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
      },
      "relationships": {}
    },
    {
      "id": "9a8d9c90-c9ec-4b18-b011-4d2fbfa558b5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7f83985f-b246-4502-a21c-c67bc9616fd4"
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







