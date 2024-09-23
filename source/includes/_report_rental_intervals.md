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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-09-13+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=7323d689-b910-45c2-9e93-dc7a82f1817f&filter%5Btill%5D=2024-09-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f02054cc-773e-49c2-a489-582d990a615e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "216c8d8c-5a38-4615-9949-33d953be4a2e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "27a8e9fe-3324-470e-a92e-7f691f6dd699",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "17b8146f-df6c-4c1c-9bd0-0150bb13c2dc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "f5c4ba0d-7fe3-4d61-a49a-cd5087ed5e6d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "ca9ef7d0-2189-426d-806b-40c4f564191a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "8ef80617-15bf-4f3d-a77c-fe8d432d043c",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "eb05ce14-9458-48d9-a8d4-626ffa908dc8",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "8156a1f8-3a56-4476-9522-77368eea2dd1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-21",
        "rented_count": 1,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
      },
      "relationships": {}
    },
    {
      "id": "71221b15-9ba5-4d9f-93d4-3919f5e7d132",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-09-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "7323d689-b910-45c2-9e93-dc7a82f1817f"
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







