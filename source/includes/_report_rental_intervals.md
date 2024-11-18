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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-11-08+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=3d3d4bcb-70c9-44ec-99e6-bf3526cda84d&filter%5Btill%5D=2024-11-17+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cceb4d87-e5ac-4cf9-86a3-06c9645491fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-08",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "0a1978d1-65ce-4508-8847-f7c26111956f",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "95ba21e2-ad13-4d7d-8837-e599efb83870",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-10",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "87a6cecf-6599-447b-a065-ce36d3a70069",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "934b0816-6137-461f-ade0-d35e52c467c5",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-12",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "f2b81484-3cc3-4782-b57d-05df873d8330",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "ea779e9b-c3d8-4379-97bc-18e5114fc366",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-14",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "7187b9a5-6ad5-4a77-94f9-25edd4890f6e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-15",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "cc26b168-12d5-4c81-a796-77ce58c71c4b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-16",
        "rented_count": 1,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
      },
      "relationships": {}
    },
    {
      "id": "78199669-0ac6-4ec8-90ad-3f35925bb148",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-11-17",
        "rented_count": 0,
        "interval": "day",
        "product_id": "3d3d4bcb-70c9-44ec-99e6-bf3526cda84d"
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







