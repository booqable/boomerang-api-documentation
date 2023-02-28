# Report rentals

Report on how rental products are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report rental has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`created_at` | **Datetime** `readonly`<br>
`name` | **String** `readonly`<br>Product name
`charge_duration_in_seconds` | **Integer** `readonly`<br>How many seconds were charged
`planned_duration_in_seconds` | **Integer** `readonly`<br>How many seconds the product was planned
`rented_count` | **Integer** `readonly`<br>How many times the product was rented out
`turnover_in_cents` | **Integer** `readonly`<br>Turnover during period
`quantity` | **Integer** `readonly`<br>Quantity in stock during period
`product_id` | **Uuid** <br>The associated Product


## Relationships
Report rentals have the following relationships:

Name | Description
- | -
`product` | **Products** `readonly`<br>Associated Product


## Listing performance for rental products



> How to fetch performance for products:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_rentals?filter%5Bfrom%5D=2023-02-23+00%3A00%3A00+UTC&filter%5Btill%5D=2023-02-28+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-10dfb94a-0317-5613-a818-89af25e9c21f",
      "type": "report_rentals",
      "attributes": {
        "created_at": "2023-02-28T11:29:14+00:00",
        "name": "Product 60",
        "charge_duration_in_seconds": 14400,
        "planned_duration_in_seconds": 14400,
        "rented_count": 2,
        "turnover_in_cents": 0,
        "quantity": 10,
        "product_id": "4d6a21fd-f9c0-4ba9-90dc-78c07e03f055"
      },
      "relationships": {
        "product": {
          "links": {
            "related": "api/boomerang/products/4d6a21fd-f9c0-4ba9-90dc-78c07e03f055"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_rentals`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_rentals]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T11:25:30Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`q` | **String** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`turnover_type` | **String** <br>`eq`
`tag_list` | **Array** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`archived` | **Boolean** <br>`eq`
`tracking_type` | **String** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`
`tag_list` | **Array** <br>`count`
`tracking_type` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`product` => 
`photo`







