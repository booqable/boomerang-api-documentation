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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9644a29e-ff45-4d03-8c93-218776ea2827&filter%5Blocation_id%5D=a2e48e87-e5e5-4912-9b45-78aa48ad7964&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "61a40cf0-3cd0-5380-95f9-85ea3b6754b6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "572e9d4a-4412-436a-88aa-7913a2c93657",
        "item_id": "9644a29e-ff45-4d03-8c93-218776ea2827",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/572e9d4a-4412-436a-88aa-7913a2c93657"
          }
        }
      }
    },
    {
      "id": "8e24e318-b9d5-52ae-85f3-a527e97c2deb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5b1f1537-a97b-46b8-b3ec-a841aa0f2165",
        "item_id": "9644a29e-ff45-4d03-8c93-218776ea2827",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5b1f1537-a97b-46b8-b3ec-a841aa0f2165"
          }
        }
      }
    },
    {
      "id": "a9db0c72-3f58-56ca-831a-421a1dccd623",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "977c9ee0-5d21-4c4f-969f-80acb4ff324a",
        "item_id": "9644a29e-ff45-4d03-8c93-218776ea2827",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/977c9ee0-5d21-4c4f-969f-80acb4ff324a"
          }
        }
      }
    },
    {
      "id": "fada62c2-d1d2-5dc1-b5b8-f1ad9524cba8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "edc499a0-b6e5-4d98-91cd-e08516b05a25",
        "item_id": "9644a29e-ff45-4d03-8c93-218776ea2827",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/edc499a0-b6e5-4d98-91cd-e08516b05a25"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-07T08:05:40Z`
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





