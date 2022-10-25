# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=eda291a0-4be6-47c5-a8ed-c815c37748d7&filter%5Blocation_id%5D=87e19214-64c6-4fd5-a42c-15c87e6fbbc8&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8c3852ca-a2ee-508b-bd5d-3a9772da1b24",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8b750ab9-57ff-4f86-952a-deb189e79bbe",
        "item_id": "eda291a0-4be6-47c5-a8ed-c815c37748d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8b750ab9-57ff-4f86-952a-deb189e79bbe"
          }
        }
      }
    },
    {
      "id": "599d2d28-0928-5645-a1c7-3cdc619f6479",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0fbb368e-0382-40df-ab6b-4590a4578964",
        "item_id": "eda291a0-4be6-47c5-a8ed-c815c37748d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0fbb368e-0382-40df-ab6b-4590a4578964"
          }
        }
      }
    },
    {
      "id": "262599ac-f045-5210-910a-e71edea86690",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "50fd5332-1d84-4d8f-8f3e-4c5239869e3e",
        "item_id": "eda291a0-4be6-47c5-a8ed-c815c37748d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/50fd5332-1d84-4d8f-8f3e-4c5239869e3e"
          }
        }
      }
    },
    {
      "id": "ed435c0a-7d69-5970-886a-755affd0f217",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b5d39975-5fe9-4e8b-ad63-4d2c53e57e26",
        "item_id": "eda291a0-4be6-47c5-a8ed-c815c37748d7",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b5d39975-5fe9-4e8b-ad63-4d2c53e57e26"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T18:48:25Z`
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





