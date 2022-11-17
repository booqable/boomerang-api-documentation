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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1281070f-0413-42bc-a6c5-f900fe665abd&filter%5Blocation_id%5D=19f72e14-98a1-45d7-8ae3-d3d6ee280c65&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f2e284bf-75b1-5f25-a196-46e39c4c32a2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d636a5fd-7446-41db-b150-0fd508870524",
        "item_id": "1281070f-0413-42bc-a6c5-f900fe665abd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d636a5fd-7446-41db-b150-0fd508870524"
          }
        }
      }
    },
    {
      "id": "2cdc9c83-b55d-588e-8322-879901d0f194",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8236466b-080f-4885-94c9-4d395efd231c",
        "item_id": "1281070f-0413-42bc-a6c5-f900fe665abd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8236466b-080f-4885-94c9-4d395efd231c"
          }
        }
      }
    },
    {
      "id": "a9c07b97-78bb-5011-a1d9-daeb34093296",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9a39e2ee-4e2c-4cfa-bbbe-96d3bda72c54",
        "item_id": "1281070f-0413-42bc-a6c5-f900fe665abd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9a39e2ee-4e2c-4cfa-bbbe-96d3bda72c54"
          }
        }
      }
    },
    {
      "id": "f2ee107b-1d5e-52ae-88e6-3ce689048d1e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c6acc239-79fa-4c67-9e7a-b988a57c5ec5",
        "item_id": "1281070f-0413-42bc-a6c5-f900fe665abd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c6acc239-79fa-4c67-9e7a-b988a57c5ec5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T10:15:41Z`
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





