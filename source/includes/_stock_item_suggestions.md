# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e14c7dff-05bf-4007-8355-f1b19bcf3e1d&filter%5Blocation_id%5D=bcadd938-bdc4-4d77-ae5c-06e4db40c967&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "de0689e8-0534-5ad6-8715-48122be9b008",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0fe307b5-2522-43ee-9423-4f8e3b63b218",
        "item_id": "e14c7dff-05bf-4007-8355-f1b19bcf3e1d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0fe307b5-2522-43ee-9423-4f8e3b63b218"
          }
        }
      }
    },
    {
      "id": "ef7d8efa-26c5-505a-b3ea-7e4b0922305a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ec1f9006-5225-47c2-87fa-ca44567f4032",
        "item_id": "e14c7dff-05bf-4007-8355-f1b19bcf3e1d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ec1f9006-5225-47c2-87fa-ca44567f4032"
          }
        }
      }
    },
    {
      "id": "d271dc21-7895-5c1c-a6ab-03952d7b1fc8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "376c6e68-478c-4481-89d1-da0a4defc90c",
        "item_id": "e14c7dff-05bf-4007-8355-f1b19bcf3e1d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/376c6e68-478c-4481-89d1-da0a4defc90c"
          }
        }
      }
    },
    {
      "id": "bf2914a7-c980-5e55-a951-aafd21f4445a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "678b6118-ea2c-4df9-8cff-b6d3935e7637",
        "item_id": "e14c7dff-05bf-4007-8355-f1b19bcf3e1d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/678b6118-ea2c-4df9-8cff-b6d3935e7637"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/stock_item_suggestions`

### Request params

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:09:11Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum** <br>`eq`
`order_id` | **Uuid** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`action` | **String_enum** <br>`eq`
`q` | **String** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





