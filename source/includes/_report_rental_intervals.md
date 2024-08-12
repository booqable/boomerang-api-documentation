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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-08-02+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=6850c16c-dd73-4fa8-8727-59a48dffa9be&filter%5Btill%5D=2024-08-11+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "086fabbe-584d-4cb0-84af-f13fe442b548",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-02",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "cf982f0d-51ba-4432-abfb-276cc5006d8e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-03",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "c5de5bb1-3c32-4208-9688-c27872f6a15a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-04",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "17cd4d8b-103f-4426-9311-dcddee81d2ed",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-05",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "b4f928b0-8034-480c-b9cd-6a424ba591e7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-06",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "0b9bf080-896a-4125-8fb2-f4968389c9fd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-07",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "cfc2e424-236f-4ab3-abba-3452ad19ba34",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-08",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "6685aede-6461-4760-bcb4-44488acaad57",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-09",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "803c0922-6fdf-4dfd-87f2-d7a6a573f7ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-10",
        "rented_count": 1,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
      },
      "relationships": {}
    },
    {
      "id": "e64c659f-3a48-45ea-8a48-533385086450",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-08-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "6850c16c-dd73-4fa8-8727-59a48dffa9be"
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







