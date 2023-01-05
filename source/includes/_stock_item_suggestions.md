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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=68e867e9-35d4-48bf-ac7e-8ff606650783&filter%5Blocation_id%5D=23e1cb46-070a-4169-aa9e-40183d8f3038&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a91082a6-ad31-5948-a1dd-e78b5751f017",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "526c4798-a8de-45c1-acf3-7619613a49ba",
        "item_id": "68e867e9-35d4-48bf-ac7e-8ff606650783",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/526c4798-a8de-45c1-acf3-7619613a49ba"
          }
        }
      }
    },
    {
      "id": "45c1cfc0-e82a-5812-ac83-51613072d4fb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0cd7a206-bece-4a64-8820-aa684d0fedbc",
        "item_id": "68e867e9-35d4-48bf-ac7e-8ff606650783",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0cd7a206-bece-4a64-8820-aa684d0fedbc"
          }
        }
      }
    },
    {
      "id": "67401080-4481-513d-b3ea-9fb5a17435c0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6cac6033-8937-4dd0-b056-31443019c98e",
        "item_id": "68e867e9-35d4-48bf-ac7e-8ff606650783",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6cac6033-8937-4dd0-b056-31443019c98e"
          }
        }
      }
    },
    {
      "id": "00b95591-a76d-5bce-97be-c5af7d3f93db",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1d841238-a483-448c-892c-cc89e559f572",
        "item_id": "68e867e9-35d4-48bf-ac7e-8ff606650783",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1d841238-a483-448c-892c-cc89e559f572"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T13:01:30Z`
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





