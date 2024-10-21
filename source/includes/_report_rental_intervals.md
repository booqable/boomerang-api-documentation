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
    --url 'https://example.booqable.com/api/boomerang/report_rental_intervals?filter%5Bfrom%5D=2024-10-11+00%3A00%3A00+UTC&filter%5Bproduct_id%5D=273a50cb-6530-43ee-bc7e-52593f257caf&filter%5Btill%5D=2024-10-20+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e26baaef-d783-4d2e-af71-e1c08c9293c1",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-11",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "8d5a0418-a190-424e-8e9b-33ba738c9e7d",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-12",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "5907cfe4-ef1b-4d22-bc9a-427d4169ab94",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-13",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "bbfe03ea-5370-438d-b89e-22ce37511c6b",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-14",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "58ff9789-c93d-4d2f-8b0d-0e58888d1728",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-15",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "30e986bc-d3f2-43d2-9e69-63e2505f2ae2",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-16",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "34004fca-34a4-415a-96ed-5b5b4586f111",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-17",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "6ca01a27-504a-4366-b0c0-39cf39593d4e",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-18",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "03a8f33c-e052-4159-98f4-9b4ba16933f7",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-19",
        "rented_count": 1,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
      },
      "relationships": {}
    },
    {
      "id": "fd5d8386-5a56-4b43-af59-095dd09f66ad",
      "type": "report_rental_intervals",
      "attributes": {
        "date": "2024-10-20",
        "rented_count": 0,
        "interval": "day",
        "product_id": "273a50cb-6530-43ee-bc7e-52593f257caf"
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







