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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-10-04+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=88712515-5011-4dc8-97ed-a50026198633&filter%5Btill%5D=2024-10-13+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e266ea4b-1455-4f73-86ed-817d1112cc05",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "ca534e0e-44f7-4443-a3a5-bc2788c45315",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "f7e3585a-5c44-4cd0-bc22-4f5ffb3dff3e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-06",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "ee1b3511-a8db-4b00-9fef-a19f044d9591",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "ef231901-f4ed-4e81-999d-ef997017abdc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "a56daf01-a0eb-40b9-988f-190cb0f69f0e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "689b11ad-19fe-47e2-a1b5-b285a05983de",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "87093de7-930b-40c3-a4e1-7d3e153a40bd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "3b059d61-b660-45b6-acf7-92561765d422",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
      },
      "relationships": {}
    },
    {
      "id": "43ca2503-033c-4ba5-93ff-f2bdacfa6b14",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "88712515-5011-4dc8-97ed-a50026198633"
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







