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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=2ea0e49a-526c-4c77-a41f-e35076d2bee3&filter%5Blocation_id%5D=d8877146-0ecb-4c46-a4b5-c543030f199a&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cbdabd5e-3cfc-52f0-b54c-b2b5828c1c9f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "580992dd-b45e-44e7-aae2-a0b4358ee479",
        "item_id": "2ea0e49a-526c-4c77-a41f-e35076d2bee3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/580992dd-b45e-44e7-aae2-a0b4358ee479"
          }
        }
      }
    },
    {
      "id": "8ad427f4-af9b-54bb-b3cd-8f579d875f01",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c85501ff-9e16-4aa1-8fc6-4c1505a3ef1d",
        "item_id": "2ea0e49a-526c-4c77-a41f-e35076d2bee3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c85501ff-9e16-4aa1-8fc6-4c1505a3ef1d"
          }
        }
      }
    },
    {
      "id": "fff4924c-8236-543e-89e6-28e8c7b2978a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b4a560ff-70f2-469b-937c-ec06ae734deb",
        "item_id": "2ea0e49a-526c-4c77-a41f-e35076d2bee3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b4a560ff-70f2-469b-937c-ec06ae734deb"
          }
        }
      }
    },
    {
      "id": "f5314aa5-e3d7-591d-b27a-e6acaf3675f6",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b7d4de5e-e5e1-459b-bba7-c556e5b6b16a",
        "item_id": "2ea0e49a-526c-4c77-a41f-e35076d2bee3",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b7d4de5e-e5e1-459b-bba7-c556e5b6b16a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-21T07:51:57Z`
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





