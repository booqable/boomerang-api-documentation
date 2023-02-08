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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=bb2f20df-7554-4e27-b3b8-cf083648bd22&filter%5Blocation_id%5D=b344894c-e69f-4e33-90f4-c663ffc746a2&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "d19add73-66e6-5e35-bcb4-740e97439230",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "16e0a59e-6504-4337-bc25-14ab7dceaab6",
        "item_id": "bb2f20df-7554-4e27-b3b8-cf083648bd22",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/16e0a59e-6504-4337-bc25-14ab7dceaab6"
          }
        }
      }
    },
    {
      "id": "768bc09a-8a34-53e8-af02-ec2ed9aa1d00",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6214a7d0-1174-4574-8fc9-3b907e7e311f",
        "item_id": "bb2f20df-7554-4e27-b3b8-cf083648bd22",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6214a7d0-1174-4574-8fc9-3b907e7e311f"
          }
        }
      }
    },
    {
      "id": "1cfd0bca-d293-503b-9e6d-1d9866933938",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f01c6225-2cfa-4253-8168-0ea162a9e84c",
        "item_id": "bb2f20df-7554-4e27-b3b8-cf083648bd22",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f01c6225-2cfa-4253-8168-0ea162a9e84c"
          }
        }
      }
    },
    {
      "id": "9fa5bd62-4802-5511-8674-7bcd31ca5360",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "18cb286d-a0c9-406e-8f71-8aeb6b28626d",
        "item_id": "bb2f20df-7554-4e27-b3b8-cf083648bd22",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/18cb286d-a0c9-406e-8f71-8aeb6b28626d"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:17:24Z`
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





