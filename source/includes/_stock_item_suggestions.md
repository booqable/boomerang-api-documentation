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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=de4c0672-7637-4b67-b08a-dd32254e4f64&filter%5Blocation_id%5D=247e7654-3785-48ed-bc4c-7bb044f4cc10&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "a92f1a28-f57c-5b12-856e-418139fad911",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dd708dff-1789-4d5e-b546-2b8bba32be80",
        "item_id": "de4c0672-7637-4b67-b08a-dd32254e4f64",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dd708dff-1789-4d5e-b546-2b8bba32be80"
          }
        }
      }
    },
    {
      "id": "d9e2bcaa-34cd-5d2a-8e1f-4ef16c2ed991",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e55eb434-a01c-4d98-957c-743e55072d5f",
        "item_id": "de4c0672-7637-4b67-b08a-dd32254e4f64",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e55eb434-a01c-4d98-957c-743e55072d5f"
          }
        }
      }
    },
    {
      "id": "bb4d96f5-c262-565d-9762-d632152b023b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "829c0e05-aba7-42a0-ac66-233c43a24123",
        "item_id": "de4c0672-7637-4b67-b08a-dd32254e4f64",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/829c0e05-aba7-42a0-ac66-233c43a24123"
          }
        }
      }
    },
    {
      "id": "4991d9c1-ef4c-52b9-beab-10759d97255c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "80ba43ff-71d3-4d69-a4ab-9f96019eaab0",
        "item_id": "de4c0672-7637-4b67-b08a-dd32254e4f64",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/80ba43ff-71d3-4d69-a4ab-9f96019eaab0"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-15T09:52:45Z`
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





