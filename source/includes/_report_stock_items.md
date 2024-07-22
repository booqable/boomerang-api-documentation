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
`stock_item` | **Report stock items** `readonly`<br>Associated Stock item
`product` | **Products** `readonly`<br>Associated Product
`location` | **Locations** `readonly`<br>Associated Location


## Listing performance for stock items



> How to fetch performance for stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2024-07-17+00%3A00%3A00+UTC&filter%5Btill%5D=2024-07-22+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0ab10098-4eb0-4c05-86d5-59c95ca137de",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-07-22T09:25:39.602932+00:00",
        "product_name": "Product 1000027",
        "identifier": "id1000072",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 0,
        "stock_item_id": "67bd61d8-f902-4118-ae9f-265c3df5d9f2",
        "product_id": "e8e1e77c-8db8-4f82-b3ab-9fc43a5927d8",
        "location_id": null
      },
      "relationships": {}
    },
    {
      "id": "7170538c-5e79-4023-9b9c-06f41f2e5a9e",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2024-07-22T09:25:39.627799+00:00",
        "product_name": "Product 1000027",
        "identifier": "id1000073",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 0,
        "stock_item_id": "606c8c2f-f164-4820-a5e1-78e149c1ae2c",
        "product_id": "e8e1e77c-8db8-4f82-b3ab-9fc43a5927d8",
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







