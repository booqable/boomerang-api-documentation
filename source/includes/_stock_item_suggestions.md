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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=31ae1998-f6a4-4f00-be0d-df959cad8e75&filter%5Blocation_id%5D=61cce951-3361-4e97-9c4c-194c363489b8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0db27dcc-a14c-5f80-846a-49dbc9fd011b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fc278247-fbd7-4737-9c2b-14f759a144f5",
        "item_id": "31ae1998-f6a4-4f00-be0d-df959cad8e75",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fc278247-fbd7-4737-9c2b-14f759a144f5"
          }
        }
      }
    },
    {
      "id": "1964d625-3510-5fc6-ad55-09a53fb8a61e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c7585132-28d9-47de-bf14-54c59000cbce",
        "item_id": "31ae1998-f6a4-4f00-be0d-df959cad8e75",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c7585132-28d9-47de-bf14-54c59000cbce"
          }
        }
      }
    },
    {
      "id": "f7ad815c-2493-5074-ac93-fb83b22a692a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fea4b27b-c171-4ec4-abc8-35a0314a289d",
        "item_id": "31ae1998-f6a4-4f00-be0d-df959cad8e75",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fea4b27b-c171-4ec4-abc8-35a0314a289d"
          }
        }
      }
    },
    {
      "id": "55887369-e935-5f84-b10f-95e2ec44db64",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b0e8b3fd-3b8f-4aa8-ade6-aa4971380259",
        "item_id": "31ae1998-f6a4-4f00-be0d-df959cad8e75",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b0e8b3fd-3b8f-4aa8-ade6-aa4971380259"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-30T08:56:45Z`
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





