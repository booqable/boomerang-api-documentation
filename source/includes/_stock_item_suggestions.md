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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=93d445d0-1fca-44a8-b325-0bdd6dcfdf08&filter%5Blocation_id%5D=740e6043-8e8c-48e5-a24b-b35cb9080ee6&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cda89dbc-ed40-538f-b51b-c6a5da6bc551",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ef634bad-6c50-45ca-b0d4-f90b649feb97",
        "item_id": "93d445d0-1fca-44a8-b325-0bdd6dcfdf08",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ef634bad-6c50-45ca-b0d4-f90b649feb97"
          }
        }
      }
    },
    {
      "id": "30658a80-655f-5174-bbb3-0634122555cf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3c53e8af-41ad-4799-8de3-461023477d2a",
        "item_id": "93d445d0-1fca-44a8-b325-0bdd6dcfdf08",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3c53e8af-41ad-4799-8de3-461023477d2a"
          }
        }
      }
    },
    {
      "id": "0c7634f3-fc0f-5295-a91d-998d69725092",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9fa147cb-b9e0-4772-98de-a3b83fb533f3",
        "item_id": "93d445d0-1fca-44a8-b325-0bdd6dcfdf08",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9fa147cb-b9e0-4772-98de-a3b83fb533f3"
          }
        }
      }
    },
    {
      "id": "412ac232-983d-5446-9351-48824b33d30a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b8c5107f-b5d1-45fe-9a07-e1121ee7bc32",
        "item_id": "93d445d0-1fca-44a8-b325-0bdd6dcfdf08",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b8c5107f-b5d1-45fe-9a07-e1121ee7bc32"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-08T11:02:06Z`
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





