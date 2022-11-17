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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=a5f7a094-0d97-4b3d-aece-58ebfe9d21ff&filter%5Blocation_id%5D=76179da0-2745-4661-931e-9f4de3e884cb&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "f09ac455-5a1d-5e27-a9a5-1eb4ebe328a2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "27e090d1-fb2c-437b-88ff-640df26a82bf",
        "item_id": "a5f7a094-0d97-4b3d-aece-58ebfe9d21ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/27e090d1-fb2c-437b-88ff-640df26a82bf"
          }
        }
      }
    },
    {
      "id": "1cdc1b25-0883-5e9f-bcb3-4aedef0b30ea",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a1f4e6d6-ddc0-44d2-84b2-b7e027457894",
        "item_id": "a5f7a094-0d97-4b3d-aece-58ebfe9d21ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a1f4e6d6-ddc0-44d2-84b2-b7e027457894"
          }
        }
      }
    },
    {
      "id": "68fcbdea-72c0-59a0-b6a1-2ebcb48e4b26",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "80036062-eaa1-47d0-84b9-2cf5ef54d809",
        "item_id": "a5f7a094-0d97-4b3d-aece-58ebfe9d21ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/80036062-eaa1-47d0-84b9-2cf5ef54d809"
          }
        }
      }
    },
    {
      "id": "f202f0e4-e0dc-5dcf-bf1f-af520c40c55d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "14acc0ea-d215-4821-9cb7-85b2da1404df",
        "item_id": "a5f7a094-0d97-4b3d-aece-58ebfe9d21ff",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/14acc0ea-d215-4821-9cb7-85b2da1404df"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-17T11:32:25Z`
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





