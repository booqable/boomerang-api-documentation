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
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-11-15+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=1d8507f1-85f8-4dd7-a48e-f320cdcc2384&filter%5Btill%5D=2024-11-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "670ae912-a312-4972-b583-f912ccf2266a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "b0f7e81b-aa96-497b-81d5-c1a94b9974f3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "17de246d-bba2-4540-a5be-41f75b97b19d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "289a7b33-d7e2-47c1-af51-d0fcbfa1c334",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "2464f273-bfbc-4953-a68d-6a4b976f74b3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "b1dbc6f3-6150-4221-aec3-2c8709b91f4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "ccd7db70-e580-4dd7-9df0-eb3686708abf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "b4c5c4d9-0367-484d-97b4-9caf86f7e3c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "3aee90d1-4392-4e18-9bbe-87c311beb75e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
      },
      "relationships": {}
    },
    {
      "id": "6e41ebc7-9c35-46a7-86ca-83fc57b193b9",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "1d8507f1-85f8-4dd7-a48e-f320cdcc2384"
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







