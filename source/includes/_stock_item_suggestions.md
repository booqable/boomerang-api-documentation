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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=89a282bc-5391-4d17-9a7c-1ad0b2f507a2&filter%5Blocation_id%5D=5dbaffb3-fdd1-4fc2-a380-510094314f05&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "52ef547d-e37b-5df1-98bd-05f41792e3d9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "641f62f7-c8f4-4fa7-b5d8-6f18f68445bd",
        "item_id": "89a282bc-5391-4d17-9a7c-1ad0b2f507a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/641f62f7-c8f4-4fa7-b5d8-6f18f68445bd"
          }
        }
      }
    },
    {
      "id": "19d689f9-ce95-5e2c-849f-b3ea43bd1a9c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5a16c8df-3c50-43cb-960e-5651e2e07e1c",
        "item_id": "89a282bc-5391-4d17-9a7c-1ad0b2f507a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5a16c8df-3c50-43cb-960e-5651e2e07e1c"
          }
        }
      }
    },
    {
      "id": "74d0e49d-80a4-543a-93f9-91aabc7010d1",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e18a8e58-5699-41bd-8eb7-700750459426",
        "item_id": "89a282bc-5391-4d17-9a7c-1ad0b2f507a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e18a8e58-5699-41bd-8eb7-700750459426"
          }
        }
      }
    },
    {
      "id": "c6a516cc-3b2f-5eb0-baa8-8e8afaa106f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e635455c-3222-4d47-9aab-274fd4e4f88f",
        "item_id": "89a282bc-5391-4d17-9a7c-1ad0b2f507a2",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e635455c-3222-4d47-9aab-274fd4e4f88f"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:46:51Z`
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





