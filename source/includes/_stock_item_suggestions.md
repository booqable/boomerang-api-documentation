# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked,
started, or stopped.

The suggestions are sorted:
  1. Temporary stock items are sorted before permanent stock items.
  2. Available stock items are sorted before unavailable and overdue stock items.
  3. Equally relevant stock items are sorted by the identifier.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid** <br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the Product the suggested stock item belongs to.
`status` | **String_enum** `readonly`<br>Status of the suggested stock item. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable` 


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=e799018b-1ca2-4bb0-9ab2-96b345b2f65d&filter%5Blocation_id%5D=c8f22541-8aff-4a7d-9944-5bc532fced81&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5679bebb-0e95-5f14-8500-a9791865ccaa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "522fc1b1-8128-43af-ac80-437de598790f",
        "item_id": "e799018b-1ca2-4bb0-9ab2-96b345b2f65d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/522fc1b1-8128-43af-ac80-437de598790f"
          }
        }
      }
    },
    {
      "id": "8d0a4bed-6112-5d4e-9a8d-6b1193c37c8b",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "94619fa7-210a-454b-af43-6886a09eaaef",
        "item_id": "e799018b-1ca2-4bb0-9ab2-96b345b2f65d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/94619fa7-210a-454b-af43-6886a09eaaef"
          }
        }
      }
    },
    {
      "id": "43941caa-f8a1-54a3-b39e-f76cefda7036",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8784c6e0-0b45-4ef3-bd97-0211460a0373",
        "item_id": "e799018b-1ca2-4bb0-9ab2-96b345b2f65d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8784c6e0-0b45-4ef3-bd97-0211460a0373"
          }
        }
      }
    },
    {
      "id": "3bc0c9a7-ab03-5220-bc75-b8011bc55f8e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "dea2d53b-b234-4007-9fce-20aa1e5000b4",
        "item_id": "e799018b-1ca2-4bb0-9ab2-96b345b2f65d",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/dea2d53b-b234-4007-9fce-20aa1e5000b4"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-21T10:28:05Z`
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





