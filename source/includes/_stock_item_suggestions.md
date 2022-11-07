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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=16913e3d-a76c-48b4-aae0-ecb3be9e6518&filter%5Blocation_id%5D=ef401558-123e-45d8-8878-17985c995f08&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "26aa6b0d-d9a2-51bf-91a9-54095c7d1c28",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c3173d92-672b-4ac3-87e7-2ae234bed297",
        "item_id": "16913e3d-a76c-48b4-aae0-ecb3be9e6518",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c3173d92-672b-4ac3-87e7-2ae234bed297"
          }
        }
      }
    },
    {
      "id": "c51a5af4-6afa-52e9-a6cb-feb11abac994",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7a0ce848-6c7b-4fdf-81fd-ab056beaf4ba",
        "item_id": "16913e3d-a76c-48b4-aae0-ecb3be9e6518",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7a0ce848-6c7b-4fdf-81fd-ab056beaf4ba"
          }
        }
      }
    },
    {
      "id": "e1ea4fc0-2c36-539e-80e9-188e10ee5210",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8416671f-8304-4bcf-bc29-33d83189a490",
        "item_id": "16913e3d-a76c-48b4-aae0-ecb3be9e6518",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8416671f-8304-4bcf-bc29-33d83189a490"
          }
        }
      }
    },
    {
      "id": "ea5e4477-9a3b-5e62-b9ca-6548623d4aa4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "75154dfe-559c-47de-9ac3-01b24f571740",
        "item_id": "16913e3d-a76c-48b4-aae0-ecb3be9e6518",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/75154dfe-559c-47de-9ac3-01b24f571740"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-04T15:37:26Z`
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





