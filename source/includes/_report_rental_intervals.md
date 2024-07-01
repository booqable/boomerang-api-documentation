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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-06-21+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=debfd051-142d-48df-b838-fcb0fc02222c&filter%5Btill%5D=2024-06-30+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e3bd7992-487c-4c05-b5fb-88d855c158b1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "26f20276-3106-43b3-a393-ac665890a3d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "20b4f0c0-8266-4b36-b913-d0859d848340",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-23",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "031e1d20-122d-4e62-be40-56a038ef712e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "7c3ec830-69cb-42f6-b9e9-bbadc5152481",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "0d085cff-c61c-4bf0-94ae-f24ceec31844",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "4bbb4699-49d4-4766-95b7-a2f936e9bba0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "38a378eb-9172-4744-a534-7fa285cfae8b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "5b1fbc18-7aeb-492f-ae39-7c20e9a0a8b8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-29",
        "rented_count": 1,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
      },
      "relationships": {}
    },
    {
      "id": "2a5550fe-a2a4-428c-8468-91f7e504ef16",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-06-30",
        "rented_count": 0,
        "interval": "day",
        "product_id": "debfd051-142d-48df-b838-fcb0fc02222c"
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







