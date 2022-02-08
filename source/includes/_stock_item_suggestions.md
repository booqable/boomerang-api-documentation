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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=796c4c70-3be8-4ea3-b28a-74013b982dd0&filter%5Blocation_id%5D=f0b3e2c8-d41b-4ad0-95a4-29a568ca6fd7&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "ba63af38-449f-561c-a6f8-e0cf5e8b4fe1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b4a4becf-525c-49ff-8db6-77579af5bf74",
        "item_id": "796c4c70-3be8-4ea3-b28a-74013b982dd0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b4a4becf-525c-49ff-8db6-77579af5bf74"
          }
        }
      }
    },
    {
      "id": "133d4cf0-6397-50b7-a365-b0fa140f333c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7df0cb48-c352-48ff-90cc-051a7e4fe819",
        "item_id": "796c4c70-3be8-4ea3-b28a-74013b982dd0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7df0cb48-c352-48ff-90cc-051a7e4fe819"
          }
        }
      }
    },
    {
      "id": "6c412934-ae48-5aca-a148-ec47c061f34b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ce209742-73e5-448a-8809-47821d03703f",
        "item_id": "796c4c70-3be8-4ea3-b28a-74013b982dd0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ce209742-73e5-448a-8809-47821d03703f"
          }
        }
      }
    },
    {
      "id": "301e37f9-bb97-531f-8e0b-c962dadcf547",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "69f9fc2d-e126-428f-8fc5-558c14387d11",
        "item_id": "796c4c70-3be8-4ea3-b28a-74013b982dd0",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/69f9fc2d-e126-428f-8fc5-558c14387d11"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-08T09:12:26Z`
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





