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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4e304be4-47ab-41fe-8077-a75957668e19&filter%5Blocation_id%5D=eee57af1-8e04-40de-8800-7c368880d6a3&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cef1ac45-32f8-51d8-9d50-605e9bf335d1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "be4e6688-e775-49bb-9076-9a2d9429f998",
        "item_id": "4e304be4-47ab-41fe-8077-a75957668e19",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/be4e6688-e775-49bb-9076-9a2d9429f998"
          }
        }
      }
    },
    {
      "id": "ba70668b-5599-52d6-a8bb-43c708323d64",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "73b7f6b0-cd60-4eae-a513-c6136e114b2b",
        "item_id": "4e304be4-47ab-41fe-8077-a75957668e19",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/73b7f6b0-cd60-4eae-a513-c6136e114b2b"
          }
        }
      }
    },
    {
      "id": "a564293e-41a9-5aec-8ad1-421dc508431b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4cf0e0f6-6416-4156-8c93-9b4162110a3f",
        "item_id": "4e304be4-47ab-41fe-8077-a75957668e19",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4cf0e0f6-6416-4156-8c93-9b4162110a3f"
          }
        }
      }
    },
    {
      "id": "43d92a1c-65fc-55cb-9f62-1e05e7f88be8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2a7aea2b-1f7f-41aa-a07c-f068f6ee46a2",
        "item_id": "4e304be4-47ab-41fe-8077-a75957668e19",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2a7aea2b-1f7f-41aa-a07c-f068f6ee46a2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:45:10Z`
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





