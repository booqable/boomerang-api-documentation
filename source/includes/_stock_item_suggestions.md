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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=a8375f8a-1b79-466b-9d0a-d79ab348a811&filter%5Blocation_id%5D=904addb5-b1a8-40dd-aac8-b4e3ed0c4558&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b581a742-f563-5022-9f3a-b731912d5f3d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "658d685c-3cfe-4a66-9a58-4776def5f1c8",
        "item_id": "a8375f8a-1b79-466b-9d0a-d79ab348a811",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/658d685c-3cfe-4a66-9a58-4776def5f1c8"
          }
        }
      }
    },
    {
      "id": "60092c13-0de7-559e-987e-025d846607e5",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "6119b811-d259-44cd-ae70-9597cfaacc99",
        "item_id": "a8375f8a-1b79-466b-9d0a-d79ab348a811",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/6119b811-d259-44cd-ae70-9597cfaacc99"
          }
        }
      }
    },
    {
      "id": "3161f5c8-341f-5cf8-8b39-03e02a63e3d0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1b391602-2bbb-4d27-bb7e-258d2143ed3d",
        "item_id": "a8375f8a-1b79-466b-9d0a-d79ab348a811",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1b391602-2bbb-4d27-bb7e-258d2143ed3d"
          }
        }
      }
    },
    {
      "id": "2dea5010-ddb9-5374-8a53-feedda4aebde",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7ea6cb88-0079-45a6-9aed-9d1412ff2136",
        "item_id": "a8375f8a-1b79-466b-9d0a-d79ab348a811",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7ea6cb88-0079-45a6-9aed-9d1412ff2136"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T12:59:53Z`
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





