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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e7add219-00b7-4039-8743-84d0d1ff5031&filter%5Blocation_id%5D=61597115-a3e0-41d6-b288-0ceaf11d1d92&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b307bedb-c0e9-5187-8c97-d0de7f867530",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "772a80e2-3e16-4420-acc7-224d44ba6e65",
        "item_id": "e7add219-00b7-4039-8743-84d0d1ff5031",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/772a80e2-3e16-4420-acc7-224d44ba6e65"
          }
        }
      }
    },
    {
      "id": "7b0e54a9-bcf0-53cf-a5d4-8b2100513afe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "67d28b07-5e1b-4e05-9bfb-d3e7f4c07b5b",
        "item_id": "e7add219-00b7-4039-8743-84d0d1ff5031",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/67d28b07-5e1b-4e05-9bfb-d3e7f4c07b5b"
          }
        }
      }
    },
    {
      "id": "bad05efd-693f-5750-8586-74288fa120d4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c6a3b502-7cf9-45ea-bf59-eab02b866f40",
        "item_id": "e7add219-00b7-4039-8743-84d0d1ff5031",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c6a3b502-7cf9-45ea-bf59-eab02b866f40"
          }
        }
      }
    },
    {
      "id": "10f91672-d9a3-5bbf-95f9-2d460e398733",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b1f9cd89-db6f-4629-a945-24c9a95622c8",
        "item_id": "e7add219-00b7-4039-8743-84d0d1ff5031",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b1f9cd89-db6f-4629-a945-24c9a95622c8"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-09-16T14:12:39Z`
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





