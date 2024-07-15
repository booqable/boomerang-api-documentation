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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-07-05+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=c82911d9-0005-4359-9155-f88c81e3fe47&filter%5Btill%5D=2024-07-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "15e190d4-c3c0-4781-a445-6fbc6299cc8a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "ebcc27b1-44c4-4543-aee5-81ec01190e7c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "764ed138-7cc5-4675-a8d6-cf835dd96d54",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "6ea1fec1-56f2-4d13-a0fe-27adfab95b88",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "2e1c7229-d8ac-4884-a01f-9e6d49b03811",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-09",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "7400b1bb-b872-499c-9a36-67252805db1c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "168ca754-2389-4295-9b2a-91d10edb7f0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-11",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "a6b28884-2f3d-4410-96f8-fbd219abeb09",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "913c7702-711c-49c6-ae30-de6f2a9bda76",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-13",
        "rented_count": 1,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
      },
      "relationships": {}
    },
    {
      "id": "ae1ef53d-5b43-42ee-9369-a060cdbfd0ca",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "c82911d9-0005-4359-9155-f88c81e3fe47"
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







