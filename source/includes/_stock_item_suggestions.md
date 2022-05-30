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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=18d23cb1-d054-4df5-adfe-4f22e5f8f5a9&filter%5Blocation_id%5D=a83b842c-71bc-4247-a28a-440e01b2ae0b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "06d30974-03e1-5fd9-becd-93f1730bc5b4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "247c07f3-2e8b-46a1-8bd8-36ab6182e489",
        "item_id": "18d23cb1-d054-4df5-adfe-4f22e5f8f5a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/247c07f3-2e8b-46a1-8bd8-36ab6182e489"
          }
        }
      }
    },
    {
      "id": "f882a6c3-50e7-595e-bfa9-071afc5ef644",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6dc86063-8721-43d6-b8cd-7a14ef65e37c",
        "item_id": "18d23cb1-d054-4df5-adfe-4f22e5f8f5a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6dc86063-8721-43d6-b8cd-7a14ef65e37c"
          }
        }
      }
    },
    {
      "id": "c9ffda5e-d2c8-590d-bc16-2e99ad23d6d1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c70edf98-3524-4b9a-945b-8bd4e4ccb2a9",
        "item_id": "18d23cb1-d054-4df5-adfe-4f22e5f8f5a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c70edf98-3524-4b9a-945b-8bd4e4ccb2a9"
          }
        }
      }
    },
    {
      "id": "6eee1777-289c-56ec-b636-c9129344c4fd",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "078692dd-84c5-4115-942b-637639634d6f",
        "item_id": "18d23cb1-d054-4df5-adfe-4f22e5f8f5a9",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/078692dd-84c5-4115-942b-637639634d6f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-30T12:17:26Z`
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





