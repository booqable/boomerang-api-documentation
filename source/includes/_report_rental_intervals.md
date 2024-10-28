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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-10-18+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=a46135a8-bfb6-40b5-9851-095ebaa789b9&filter%5Btill%5D=2024-10-27+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "bcc0144d-1ba4-4fbb-afe7-5f9df2ef551f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "0f0e20ac-5eda-4e26-ad19-773f93ba8fe4",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "74f6d461-a754-4424-8315-2eae57f0abdf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "566de3c7-613d-471c-a45d-f298ea3f7c72",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "5e5df432-655e-4311-9c2b-9403dd18be50",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-22",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "a2eeb485-8d9b-4ac4-8082-608ede4a128e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "c9adc67a-da37-4af6-87a6-53e0a3b6b2fb",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-24",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "045f0ed4-2349-4832-b108-fe8fd25aa404",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-25",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "3dd8ff39-c81a-4bf9-ac6b-fd3e00d38816",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-26",
        "rented_count": 1,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
      },
      "relationships": {}
    },
    {
      "id": "5dd1f5a1-d885-4d0b-867a-26d04f54b5c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "a46135a8-bfb6-40b5-9851-095ebaa789b9"
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







