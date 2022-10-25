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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=9d1d2d0e-6267-4250-9ca3-f333d72051a4&filter%5Blocation_id%5D=6fdaf93d-a60e-43de-b7a3-af752b4e6acd&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "40f452b4-3c9d-5459-ad9a-a5a8ce923506",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8ab479ba-03dc-49da-b210-cfdcaf8b99f1",
        "item_id": "9d1d2d0e-6267-4250-9ca3-f333d72051a4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8ab479ba-03dc-49da-b210-cfdcaf8b99f1"
          }
        }
      }
    },
    {
      "id": "d3d75c37-2813-54f0-be79-9c85f69a30c0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "73f6ca20-b2c3-488a-80d5-e5fb914d6e8d",
        "item_id": "9d1d2d0e-6267-4250-9ca3-f333d72051a4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/73f6ca20-b2c3-488a-80d5-e5fb914d6e8d"
          }
        }
      }
    },
    {
      "id": "925215ba-1c0c-58a8-88e9-56815167bcec",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b0cc6315-501c-4713-be12-d59b064979cc",
        "item_id": "9d1d2d0e-6267-4250-9ca3-f333d72051a4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b0cc6315-501c-4713-be12-d59b064979cc"
          }
        }
      }
    },
    {
      "id": "6565ee55-301d-5b57-8cd5-eac495db53c1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a79875d2-1afb-41db-99d8-ae82304ad301",
        "item_id": "9d1d2d0e-6267-4250-9ca3-f333d72051a4",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a79875d2-1afb-41db-99d8-ae82304ad301"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-10-25T17:50:56Z`
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





