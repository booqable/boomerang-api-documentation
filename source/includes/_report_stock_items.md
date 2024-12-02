# Report stock items

Report on how stock items are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report stock item has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`q` | **String** `writeonly`<br>Query for a specific stock item
`product_name` | **String** <br>Product name
`identifier` | **String** <br>Stock item identifier
`charge_duration_in_seconds` | **Integer** <br>How many seconds were charged
`planned_duration_in_seconds` | **Integer** <br>How many seconds the product was planned
`rented_count` | **Integer** <br>How many times the product was rented out
`turnover_in_cents` | **Integer** <br>Turnover during period
`stock_item_id` | **Uuid** <br>Associated Stock item
`product_id` | **Uuid** <br>Associated Product
`location_id` | **Uuid** <br>Associated Location


## Relationships
Report stock items have the following relationships:

Name | Description
-- | --
`location` | **[Location](#locations)** <br>Associated Location
`product` | **[Product](#products)** <br>Associated Product
`stock_item` | **[Report stock item](#report-stock-items)** <br>Associated Stock item


## Listing performance for stock items



> How to fetch performance for stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2024-11-27+00%3A00%3A00+UTC&filter%5Btill%5D=2024-12-02+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6c4685c6-ac2a-417c-8057-4eb366e7aaa0",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-12-02T13:07:04.464708+00:00",
        "product_name": "Product 1000081",
        "identifier": "id1000185",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 2000,
        "stock_item_id": "5685a83f-2670-4aa1-bf12-53e8899f1784",
        "product_id": "c3f25ec8-5146-4986-b1f5-9fd5aa49b158",
        "location_id": null
      },
      "relationships": {}
    },
    {
      "id": "ef95abac-ad09-49fd-8c6f-42c28d852a68",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-12-02T13:07:04.486915+00:00",
        "product_name": "Product 1000081",
        "identifier": "id1000186",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 2000,
        "stock_item_id": "77c4a427-a3e2-4b70-bd6d-19c7d9db62c0",
        "product_id": "c3f25ec8-5146-4986-b1f5-9fd5aa49b158",
        "location_id": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_stock_items`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=stock_item,product`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_stock_items]=created_at,product_name,identifier`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`q` | **String** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`
`product_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`turnover_type` | **String** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`


`product` => 
`photo`







