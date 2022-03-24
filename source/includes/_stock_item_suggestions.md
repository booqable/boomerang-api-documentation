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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d88e8203-1416-47a1-9fe0-366ce3217a85&filter%5Blocation_id%5D=f79b2655-cf2a-49bf-8d63-b84396bd57d5&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ef96f81b-48d3-5d55-a414-979bb2ef14a4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8e6b34b8-99e9-40fb-99c5-373a0959c2ad",
        "item_id": "d88e8203-1416-47a1-9fe0-366ce3217a85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8e6b34b8-99e9-40fb-99c5-373a0959c2ad"
          }
        }
      }
    },
    {
      "id": "75cb0c00-d5c8-5682-88f5-21ed2b2b62f1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "851b14ed-4ccd-4475-a790-956ba4a7e322",
        "item_id": "d88e8203-1416-47a1-9fe0-366ce3217a85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/851b14ed-4ccd-4475-a790-956ba4a7e322"
          }
        }
      }
    },
    {
      "id": "7f50345c-c098-5da4-bcf7-bd1b08265ca3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c3bb6ace-c18f-4434-9ac7-6c11a2982f71",
        "item_id": "d88e8203-1416-47a1-9fe0-366ce3217a85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c3bb6ace-c18f-4434-9ac7-6c11a2982f71"
          }
        }
      }
    },
    {
      "id": "cfccc517-d2aa-5785-9bee-ea82a88ed4d5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b5d53a29-207a-4daa-8dc0-75797620030d",
        "item_id": "d88e8203-1416-47a1-9fe0-366ce3217a85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b5d53a29-207a-4daa-8dc0-75797620030d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-24T12:35:48Z`
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





