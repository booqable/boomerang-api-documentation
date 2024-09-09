# Report stock items

Report on how stock items are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report stock item has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>
`created_at` | **Datetime** `readonly`<br>
`q` | **String** `writeonly`<br>Query for a specific stock item
`product_name` | **String** <br>Product name
`identifier` | **String** <br>Stock item identifier
`charge_duration_in_seconds` | **Integer** <br>How many seconds were charged
`planned_duration_in_seconds` | **Integer** <br>How many seconds the product was planned
`rented_count` | **Integer** <br>How many times the product was rented out
`turnover_in_cents` | **Integer** <br>Turnover during period
`stock_item_id` | **Uuid** <br>The associated Stock item
`product_id` | **Uuid** <br>The associated Product
`location_id` | **Uuid** <br>The associated Location


## Relationships
Report stock items have the following relationships:

Name | Description
-- | --
`location` | **Locations** `readonly`<br>Associated Location
`product` | **Products** `readonly`<br>Associated Product
`stock_item` | **Report stock items** `readonly`<br>Associated Stock item


## Listing performance for stock items



> How to fetch performance for stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2024-09-04+00%3A00%3A00+UTC&filter%5Btill%5D=2024-09-09+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9245f444-f2dc-46be-bb32-c451561533ef",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:08.683602+00:00",
        "product_name": "Product 1000028",
        "identifier": "id1000144",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 0,
        "stock_item_id": "f7fa1f99-a1a1-4623-906b-8687b73b1dca",
        "product_id": "fc794ee5-46cd-4ae1-a8f9-6db91baec5bc",
        "location_id": null
      },
      "relationships": {}
    },
    {
      "id": "92da8e37-5e66-4ddf-b9db-19a8520281ef",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:08.699312+00:00",
        "product_name": "Product 1000028",
        "identifier": "id1000145",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 0,
        "stock_item_id": "c5467642-3b47-42fd-a22b-354a5c8f3e57",
        "product_id": "fc794ee5-46cd-4ae1-a8f9-6db91baec5bc",
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







