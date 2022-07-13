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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=296bffb8-839a-43c1-a21b-03458efdfbdd&filter%5Blocation_id%5D=b985ec20-481e-4f6b-b3b0-c1827c62c238&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "234f3fe9-f6c6-5edb-8f23-1626bc258e23",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5c160b40-81b8-48c1-99d4-f38c0347d0ec",
        "item_id": "296bffb8-839a-43c1-a21b-03458efdfbdd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5c160b40-81b8-48c1-99d4-f38c0347d0ec"
          }
        }
      }
    },
    {
      "id": "3877604c-a669-52d0-af10-d049634ddd5d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c90cedec-ae42-4627-aa7c-3830b2b11f99",
        "item_id": "296bffb8-839a-43c1-a21b-03458efdfbdd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c90cedec-ae42-4627-aa7c-3830b2b11f99"
          }
        }
      }
    },
    {
      "id": "faf5bb58-d303-5078-b395-36ce96c0e3f2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "543026ee-f4c6-4cae-8ef4-5b3168dcfe0c",
        "item_id": "296bffb8-839a-43c1-a21b-03458efdfbdd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/543026ee-f4c6-4cae-8ef4-5b3168dcfe0c"
          }
        }
      }
    },
    {
      "id": "7d6c154e-6696-5a16-9b7c-9dd9ff978774",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aaba894b-7bea-4ec5-b807-dce5fd19e13a",
        "item_id": "296bffb8-839a-43c1-a21b-03458efdfbdd",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aaba894b-7bea-4ec5-b807-dce5fd19e13a"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-13T11:17:18Z`
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





