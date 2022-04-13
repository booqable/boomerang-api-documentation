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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=f078da8b-fb3a-4792-8218-6e6b40f55af2&filter%5Blocation_id%5D=b8227414-3516-4bda-ae6b-898da5a3b148&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fa38e86c-0637-56b3-bae6-6cd3d586c7d3",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5bcd3ac1-3530-43a9-b143-0e5f1d65ba89",
        "item_id": "f078da8b-fb3a-4792-8218-6e6b40f55af2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5bcd3ac1-3530-43a9-b143-0e5f1d65ba89"
          }
        }
      }
    },
    {
      "id": "5781f2e3-27f5-52ed-b392-6260b8119a32",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "01d4fc0e-64a5-497d-b6fe-ca0465e02422",
        "item_id": "f078da8b-fb3a-4792-8218-6e6b40f55af2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/01d4fc0e-64a5-497d-b6fe-ca0465e02422"
          }
        }
      }
    },
    {
      "id": "5f82db66-1d73-529d-9477-b70454bd3e60",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f329bdce-8b80-483e-af10-31cea815857e",
        "item_id": "f078da8b-fb3a-4792-8218-6e6b40f55af2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f329bdce-8b80-483e-af10-31cea815857e"
          }
        }
      }
    },
    {
      "id": "8baf6428-5135-5afc-afbf-bdce823983a7",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5d7b0e9e-c9de-424e-b384-20ac12b1d44d",
        "item_id": "f078da8b-fb3a-4792-8218-6e6b40f55af2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5d7b0e9e-c9de-424e-b384-20ac12b1d44d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-04-13T07:09:33Z`
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





