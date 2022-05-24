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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e8e3ef6a-44ae-4903-aa2e-7c3a2c904682&filter%5Blocation_id%5D=55702e37-740e-422c-97e1-921ac6e6469c&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "0821635f-06cc-548a-a7aa-4d4012fa23c2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "614d654e-1858-4fe3-8ccb-723d9f57b980",
        "item_id": "e8e3ef6a-44ae-4903-aa2e-7c3a2c904682",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/614d654e-1858-4fe3-8ccb-723d9f57b980"
          }
        }
      }
    },
    {
      "id": "246a5346-2af9-51da-854f-d8e8d279f491",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "35d987cd-2aef-4e18-a453-911c8db7a22d",
        "item_id": "e8e3ef6a-44ae-4903-aa2e-7c3a2c904682",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/35d987cd-2aef-4e18-a453-911c8db7a22d"
          }
        }
      }
    },
    {
      "id": "cdf854b5-9a9a-5b9a-9a4b-64b8336135a4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8fc8c6db-905d-4e1a-97ce-9b265fda5ff0",
        "item_id": "e8e3ef6a-44ae-4903-aa2e-7c3a2c904682",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8fc8c6db-905d-4e1a-97ce-9b265fda5ff0"
          }
        }
      }
    },
    {
      "id": "012bd99a-557b-5339-bd38-6aad07672836",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4d6890fc-2fb1-4930-bcb9-cce0736c848f",
        "item_id": "e8e3ef6a-44ae-4903-aa2e-7c3a2c904682",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4d6890fc-2fb1-4930-bcb9-cce0736c848f"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-05-24T07:44:57Z`
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





