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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-08-09+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=804457eb-cbbf-4fa1-a068-72b02ab3b443&filter%5Btill%5D=2024-08-18+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "988a3a34-8d90-4d25-94dd-6a13b710265d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "d784b892-1ba8-4e97-858a-2e71bc36f16e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "45fcc9d7-e2cd-4d5a-9e91-5472156def02",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "5a5174f2-1775-47f0-82b0-f8630b7ff153",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "67fd3082-40bd-48a5-b925-ce52c8b4ddb4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "5c71f7a3-132f-47dd-8233-7853047249af",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "92f65ef0-9f43-4cf8-9acc-dbb4e9e5d577",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "8ebfd9ba-9ed4-43b4-b875-3d1ffe78df9e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "a1dba854-f4e0-44b4-a27d-9426754f14ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
      },
      "relationships": {}
    },
    {
      "id": "0156abf4-84ce-41d4-a41d-fc33da4f8166",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "804457eb-cbbf-4fa1-a068-72b02ab3b443"
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







