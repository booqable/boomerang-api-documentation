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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=973dd19c-f56f-4a17-b9d1-a8a1718503ca&filter%5Blocation_id%5D=d60f9836-09af-4786-aa7d-79dabea043bb&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "caecf4e3-76d7-5b15-afcf-febcd43f6f58",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1eec85cc-91f7-4968-8f73-34905b29bd9f",
        "item_id": "973dd19c-f56f-4a17-b9d1-a8a1718503ca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1eec85cc-91f7-4968-8f73-34905b29bd9f"
          }
        }
      }
    },
    {
      "id": "acf7d438-0aaf-55ec-9ef1-6ba6fcf547d5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3ed39b16-420f-4b20-b3e8-feda2987877a",
        "item_id": "973dd19c-f56f-4a17-b9d1-a8a1718503ca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3ed39b16-420f-4b20-b3e8-feda2987877a"
          }
        }
      }
    },
    {
      "id": "0fda9ef5-947f-5016-8bc7-c7529daf09cf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1ca5f5f4-c65c-4a1a-ab80-95ab3a98066d",
        "item_id": "973dd19c-f56f-4a17-b9d1-a8a1718503ca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1ca5f5f4-c65c-4a1a-ab80-95ab3a98066d"
          }
        }
      }
    },
    {
      "id": "a53a5c8c-00c8-5f1f-85db-f1fda00e4f5d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d102863c-284e-40e6-88dd-c095bf78f214",
        "item_id": "973dd19c-f56f-4a17-b9d1-a8a1718503ca",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d102863c-284e-40e6-88dd-c095bf78f214"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T14:49:43Z`
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





