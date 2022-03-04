# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid**<br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the item belonging to the suggested stock item
`status` | **String_enum** `readonly`<br>Status of the suggestion. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=c1493dbd-47b0-4d13-8e76-03541709e43f&filter%5Blocation_id%5D=c7bcfb01-9167-445a-99c9-af4679f45308&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b1cbc071-e069-5c9b-a8a1-ce885a14eeb1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "fe877dc5-307f-4225-a82c-a2fcedd03c5d",
        "item_id": "c1493dbd-47b0-4d13-8e76-03541709e43f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/fe877dc5-307f-4225-a82c-a2fcedd03c5d"
          }
        }
      }
    },
    {
      "id": "3e411101-7c5f-59ea-bc3e-dc7385be2411",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8f9ab8c6-a612-4fd9-b107-854a36a30e72",
        "item_id": "c1493dbd-47b0-4d13-8e76-03541709e43f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8f9ab8c6-a612-4fd9-b107-854a36a30e72"
          }
        }
      }
    },
    {
      "id": "f6a9f578-438e-5947-a5e7-907b533e57c9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "eedc169a-0e83-41b8-a393-37973ae36e82",
        "item_id": "c1493dbd-47b0-4d13-8e76-03541709e43f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/eedc169a-0e83-41b8-a393-37973ae36e82"
          }
        }
      }
    },
    {
      "id": "4ee7fbb2-fbba-5a72-8695-edc3109187e7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1a95077d-9a83-4e5e-a345-310ae7fb36b8",
        "item_id": "c1493dbd-47b0-4d13-8e76-03541709e43f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1a95077d-9a83-4e5e-a345-310ae7fb36b8"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-04T10:57:02Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum**<br>`eq`
`order_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`action` | **String_enum**<br>`eq`
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`





