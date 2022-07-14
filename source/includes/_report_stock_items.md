# Report stock items

Report on how stock items are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report stock item has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`created_at` | **Datetime** `readonly`<br>
`q` | **String** `writeonly`<br>Query for a specific stock item
`product_name` | **String**<br>Product name
`identifier` | **String**<br>Stock item identifier
`charge_duration_in_seconds` | **Integer**<br>How many seconds were charged
`planned_duration_in_seconds` | **Integer**<br>How many seconds the product was planned
`rented_count` | **Integer**<br>How many times the product was rented out
`turnover_in_cents` | **Integer**<br>Turnover during period
`stock_item_id` | **Uuid**<br>The associated Stock item
`product_id` | **Uuid**<br>The associated Product
`location_id` | **Uuid**<br>The associated Location


## Relationships
Report stock items have the following relationships:

Name | Description
- | -
`stock_item` | **Report stock items** `readonly`<br>Associated Stock item
`product` | **Products** `readonly`<br>Associated Product
`location` | **Locations** `readonly`<br>Associated Location


## Listing performance for stock items



> How to fetch performance for stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2022-07-09+00%3A00%3A00+UTC&filter%5Btill%5D=2022-07-14+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-ff53aacb-402e-54e5-9ba2-05442488ffa9",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2022-07-14T10:19:16+00:00",
        "product_name": "Product 22",
        "identifier": "id157",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 2000,
        "stock_item_id": "8a0896e1-0e77-4115-974a-63ac20a0c56a",
        "product_id": "7f8329ae-c445-4539-943b-1f496c275f18",
        "location_id": null
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": null
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/7f8329ae-c445-4539-943b-1f496c275f18"
          }
        },
        "location": {
          "links": {
            "related": null
          }
        }
      }
    },
    {
      "id": "virtual-3a00c139-239e-5074-b774-c55156838cc4",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2022-07-14T10:19:16+00:00",
        "product_name": "Product 22",
        "identifier": "id158",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 2000,
        "stock_item_id": "d4c21938-ca44-4e0f-a50c-80106390b2a0",
        "product_id": "7f8329ae-c445-4539-943b-1f496c275f18",
        "location_id": null
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": null
          }
        },
        "product": {
          "links": {
            "related": "api/boomerang/products/7f8329ae-c445-4539-943b-1f496c275f18"
          }
        },
        "location": {
          "links": {
            "related": null
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/report_stock_items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item,product,location`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[report_stock_items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:15:47Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`
`product_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`turnover_type` | **String**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`


`product` => 
`photo`







