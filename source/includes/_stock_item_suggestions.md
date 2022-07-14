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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1c65fb09-c458-4a76-9ee1-b6bfe69f2de2&filter%5Blocation_id%5D=3a567d41-adc8-4a62-bee7-8b2981f59298&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "225ead91-9fc0-5fc3-9952-33dd5b0c5dbe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "35798232-42df-472b-9ec5-73e9567fbdfa",
        "item_id": "1c65fb09-c458-4a76-9ee1-b6bfe69f2de2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/35798232-42df-472b-9ec5-73e9567fbdfa"
          }
        }
      }
    },
    {
      "id": "56359888-85b5-52f2-a77f-a0b0a87ad713",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "d91276f6-c82e-4056-ac65-10636a28563b",
        "item_id": "1c65fb09-c458-4a76-9ee1-b6bfe69f2de2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/d91276f6-c82e-4056-ac65-10636a28563b"
          }
        }
      }
    },
    {
      "id": "554f86e3-5927-5439-8925-bd7eef089f5d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e42a14ea-7e00-4d8e-aa4a-8d9c18a2c807",
        "item_id": "1c65fb09-c458-4a76-9ee1-b6bfe69f2de2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e42a14ea-7e00-4d8e-aa4a-8d9c18a2c807"
          }
        }
      }
    },
    {
      "id": "02d386d5-e44c-5cf7-90ee-c31fc4964dcf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6f239fb8-3e0f-4bd9-be58-7d2b0804a375",
        "item_id": "1c65fb09-c458-4a76-9ee1-b6bfe69f2de2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6f239fb8-3e0f-4bd9-be58-7d2b0804a375"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T12:38:59Z`
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





