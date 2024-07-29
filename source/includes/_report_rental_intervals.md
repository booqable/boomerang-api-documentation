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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-07-19+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=bd098f96-a371-4fa5-8113-586960a20903&filter%5Btill%5D=2024-07-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "742ca7ec-8af1-46e4-9306-8097d2ed6c89",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-19",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "9c358557-e0ff-497f-ab56-dd7386ae84f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "460a0f53-f1fe-4e70-bcae-3fa664d8d3cd",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-21",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "c7ff16e5-caef-43c8-abb6-d004e62b2f9e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-22",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "8b959b6c-5c7c-430a-9b12-9a2dc5016c94",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-23",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "7690a387-967f-4d30-90dc-101ea7779a9a",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-24",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "187f57b4-37d2-4565-a279-0b35b5e72b04",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-25",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "fb36e8d8-14a6-47a9-8bb8-00cf9a1f96c2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-26",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "f4abea9d-0e32-409a-beaf-092e6264d773",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-27",
        "rented_count": 1,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
      },
      "relationships": {}
    },
    {
      "id": "430e43c7-38e9-4c32-b706-535b335438fc",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-07-28",
        "rented_count": 0,
        "interval": "day",
        "product_id": "bd098f96-a371-4fa5-8113-586960a20903"
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







