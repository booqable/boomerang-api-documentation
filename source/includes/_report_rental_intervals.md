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
`product` | **[Product](#products)** <br>Associated Product


## Listing performance for a rental product per interval



> How to fetch performance per interval for a product:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-11-22+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c783dd21-74e8-4158-9619-8d8e895462ad&filter%5Btill%5D=2024-12-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "4d923fff-6670-43bc-a0bd-6aed4ee68f06",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "8179d237-6f73-47df-a625-5b7e7492cfcf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "15aa5c45-07a9-4e45-b0c2-1d2226f3cfc1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "177142e2-f5f6-4e0e-bd87-8732ac3e0196",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "b3f5b638-ce3b-4cde-9cdd-6a6ec81c70e5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "239a40e2-7a43-4c75-a024-9d7a9d5a313f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "6b2107bc-f94b-4121-b1f9-0d4a1b08477d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-28",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "1449de72-bf50-4b18-9e5a-6b237e775efa",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "82fcd679-ec39-455c-a9cd-4d9cedcb4543",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
      },
      "relationships": {}
    },
    {
      "id": "74edece7-72c1-4685-8148-66aada0e35cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-12-01",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c783dd21-74e8-4158-9619-8d8e895462ad"
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







