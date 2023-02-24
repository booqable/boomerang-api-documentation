# Report stock items

Report on how stock items are performing. The report is filterable by date and can be requested by one of the following turnover types: `invoices`, `orders`.

## Fields
Every report stock item has the following fields:

Name | Description
- | -
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
- | -
`stock_item` | **Report stock items** `readonly`<br>Associated Stock item
`product` | **Products** `readonly`<br>Associated Product
`location` | **Locations** `readonly`<br>Associated Location


## Listing performance for stock items



> How to fetch performance for stock items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2023-02-19+00%3A00%3A00+UTC&filter%5Btill%5D=2023-02-24+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-03af3774-e9a1-5d97-a8b5-cf5f9aaac052",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2023-02-24T09:50:54+00:00",
        "product_name": "Product 61",
        "identifier": "id191",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 0,
        "stock_item_id": "f7abc4d4-b1a1-4904-bb11-f7c242290fe6",
        "product_id": "e3120e7e-f1e6-401f-92f1-281a00e6d3ff",
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
            "related": "api/boomerang/products/e3120e7e-f1e6-401f-92f1-281a00e6d3ff"
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
      "id": "virtual-7c3eadfb-3e6c-529b-ad81-2e30af1e366f",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2023-02-24T09:50:54+00:00",
        "product_name": "Product 61",
        "identifier": "id192",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 0,
        "stock_item_id": "227b494e-ae8e-4e37-b9ba-b4cae2ce2690",
        "product_id": "e3120e7e-f1e6-401f-92f1-281a00e6d3ff",
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
            "related": "api/boomerang/products/e3120e7e-f1e6-401f-92f1-281a00e6d3ff"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item,product,location`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[report_stock_items]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-24T09:46:21Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
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
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`


`product` => 
`photo`







