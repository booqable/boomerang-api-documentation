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
    --url 'https://example.booqable.com/api/boomerang/report_stock_items?filter%5Bfrom%5D=2023-02-24+00%3A00%3A00+UTC&filter%5Btill%5D=2023-03-01+23%3A59%3A59+UTC' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "virtual-2fba4f1c-71f4-502d-95e8-f85de193859a",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2023-03-01T10:34:20+00:00",
        "product_name": "Product 61",
        "identifier": "id191",
        "charge_duration_in_seconds": 7200,
        "planned_duration_in_seconds": 7200,
        "rented_count": 1,
        "turnover_in_cents": 0,
        "stock_item_id": "20d54869-4601-49c5-b57b-d66b1a4fbf31",
        "product_id": "7b1a5030-4f11-4e03-be49-be4c4f7bdca8",
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
            "related": "api/boomerang/products/7b1a5030-4f11-4e03-be49-be4c4f7bdca8"
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
      "id": "virtual-75ab91cf-a92b-5cf2-9803-3912be34cbf2",
      "type": "report_stock_items",
      "attributes": {
        "created_at": "2023-03-01T10:34:20+00:00",
        "product_name": "Product 61",
        "identifier": "id192",
        "charge_duration_in_seconds": 0,
        "planned_duration_in_seconds": 0,
        "rented_count": 0,
        "turnover_in_cents": 0,
        "stock_item_id": "9e7e7a87-8e51-4f7a-83fe-a2694b702d61",
        "product_id": "7b1a5030-4f11-4e03-be49-be4c4f7bdca8",
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
            "related": "api/boomerang/products/7b1a5030-4f11-4e03-be49-be4c4f7bdca8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T10:30:12Z`
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







