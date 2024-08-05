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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-07-26+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=0ea0005a-1e97-486d-9032-c97797f52564&filter%5Btill%5D=2024-08-04+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0b3d4322-4462-4448-92c5-4d002d1bd7ef",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "f4ef31cd-17ef-49ec-a42f-d25ee8b33b43",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-27",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "83d93442-8095-49f0-9ece-e095525a19d1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "2d879a45-f5c0-41f4-9e78-0c8c32714655",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-29",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "8d9c316d-05dd-4d66-b158-476095ca6fdf",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-30",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "c3298dc2-33aa-4d63-a9a1-27ea189dca3f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-31",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "0ba31cf3-9c89-4a31-aea7-3f8de600ffd1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-01",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "d3f155b9-8cf4-4bd3-886b-6f88fdf5cbd0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "5e9f5412-0816-486b-a663-2b375bd1daf0",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-03",
        "rented_count": 1,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
      },
      "relationships": {}
    },
    {
      "id": "691231dc-023c-4ed9-9e53-362aed9dd5f6",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "0ea0005a-1e97-486d-9032-c97797f52564"
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







