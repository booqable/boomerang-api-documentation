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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f09925fe-030b-4522-8f85-2fb7a9c31edd&filter%5Blocation_id%5D=893f6627-59ee-4182-beed-3b0531910c7e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "42901f26-46b2-5407-b222-c60de05d266f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "80810019-c21b-4159-ba05-dc1b2935c4ae",
        "item_id": "f09925fe-030b-4522-8f85-2fb7a9c31edd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/80810019-c21b-4159-ba05-dc1b2935c4ae"
          }
        }
      }
    },
    {
      "id": "dc67be20-01b0-5d9d-8305-c08b156a2353",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "44aad817-f39c-44b0-a2ce-cdf39acfe19c",
        "item_id": "f09925fe-030b-4522-8f85-2fb7a9c31edd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/44aad817-f39c-44b0-a2ce-cdf39acfe19c"
          }
        }
      }
    },
    {
      "id": "f00f5e95-e03c-5bae-8280-c3b7c8df6224",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "279739f0-e83d-45c7-8bcf-23f0adebf24f",
        "item_id": "f09925fe-030b-4522-8f85-2fb7a9c31edd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/279739f0-e83d-45c7-8bcf-23f0adebf24f"
          }
        }
      }
    },
    {
      "id": "766fec11-a327-5a62-bd72-981c8b0f59b8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8d9480d1-1d72-4e02-b672-39e71c4235df",
        "item_id": "f09925fe-030b-4522-8f85-2fb7a9c31edd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8d9480d1-1d72-4e02-b672-39e71c4235df"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-14T09:22:50Z`
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





