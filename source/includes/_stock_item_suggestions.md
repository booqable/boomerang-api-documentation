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



> Retrieve stock item suggestions for booking:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Baction%5D=book&filter%5Bitem_id%5D=ac0dfd6d-f963-4376-8380-93bfdbc27371&filter%5Border_id%5D=54c0442f-17cd-4542-afaa-cd075457f265' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2f98e378-87f9-57d2-b96f-4a39c1a04b35",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9a3a81ec-ba1d-4aec-b112-a2c0538bb63b",
        "item_id": "ac0dfd6d-f963-4376-8380-93bfdbc27371",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9a3a81ec-ba1d-4aec-b112-a2c0538bb63b"
          }
        }
      }
    },
    {
      "id": "22d0183a-3367-5639-9081-fa4760bd70b6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f3e80d0a-2d79-4f5b-844f-b34f09f4b4c2",
        "item_id": "ac0dfd6d-f963-4376-8380-93bfdbc27371",
        "status": "unavailable"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f3e80d0a-2d79-4f5b-844f-b34f09f4b4c2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:18Z`
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
`order_id` | **Uuid** `required`<br>`eq`
`action` | **String_enum** `required`<br>`eq`
`q` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





