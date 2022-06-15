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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=b2855a3d-efde-4b96-8e60-3d804c00d466&filter%5Blocation_id%5D=fd598490-e1ab-4393-b6b6-e19babfc0b2f&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8fc1d0a5-bc3b-5fef-beed-81b3e026846d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2f5bc303-2fdb-405a-ae9e-80e709f70cb1",
        "item_id": "b2855a3d-efde-4b96-8e60-3d804c00d466",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2f5bc303-2fdb-405a-ae9e-80e709f70cb1"
          }
        }
      }
    },
    {
      "id": "ad9258f5-49fc-5116-abfa-0bdd3a811f40",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2d89855c-3edb-4a25-aa3e-5fa32f5f8d4f",
        "item_id": "b2855a3d-efde-4b96-8e60-3d804c00d466",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2d89855c-3edb-4a25-aa3e-5fa32f5f8d4f"
          }
        }
      }
    },
    {
      "id": "0180077e-8f88-5e5a-8a82-949a38834a11",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7809fc41-4e94-40c0-8d22-8a5c0b57f389",
        "item_id": "b2855a3d-efde-4b96-8e60-3d804c00d466",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7809fc41-4e94-40c0-8d22-8a5c0b57f389"
          }
        }
      }
    },
    {
      "id": "ae399c99-09ed-51ee-a384-a9e10d72320e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b99f5b4c-dc08-416f-b8fe-733d65288031",
        "item_id": "b2855a3d-efde-4b96-8e60-3d804c00d466",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b99f5b4c-dc08-416f-b8fe-733d65288031"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-15T09:33:55Z`
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





