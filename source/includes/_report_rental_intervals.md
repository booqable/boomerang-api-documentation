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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-09-06+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=06310ac9-5bfc-4a11-89fd-c49992b009f7&filter%5Btill%5D=2024-09-15+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2e25e5b4-c92c-4f2a-80c4-7c70479459c7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "642ff05d-025d-429b-af9c-5cd2e951ed07",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "d0a0b31d-d28f-4d72-a812-0016d1eca2f3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "f537317c-adf1-4a71-b17f-8710c782a386",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "931c98f1-169a-4553-a30b-e0af356ee283",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "db3e4581-9dce-47a3-880d-96fb07c65ff3",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "57212886-ee0d-410c-a1fa-db40e3ad9688",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "bacc7da0-c6d3-477a-866e-c145948f8104",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "ac263a75-3903-4e85-91e8-1292196fd5b0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
      },
      "relationships": {}
    },
    {
      "id": "df8ac515-67b9-4c4c-80c8-40d6b668f475",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "06310ac9-5bfc-4a11-89fd-c49992b009f7"
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







