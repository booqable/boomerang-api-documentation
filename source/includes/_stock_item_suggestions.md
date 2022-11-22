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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=1863cfb3-0059-4a45-83a4-145d5e300010&filter%5Blocation_id%5D=16f17a85-d62a-4c13-8845-4d8e23fb0687&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "3aaf2c7b-0141-5f46-914e-f1bd5dccc0b4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9f331918-8269-49f8-bf94-ff6af6914189",
        "item_id": "1863cfb3-0059-4a45-83a4-145d5e300010",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9f331918-8269-49f8-bf94-ff6af6914189"
          }
        }
      }
    },
    {
      "id": "92c42b5f-d432-5bc5-af7c-8dfa4b88154f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "76c83352-825e-4763-9dd4-6ee90c525620",
        "item_id": "1863cfb3-0059-4a45-83a4-145d5e300010",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/76c83352-825e-4763-9dd4-6ee90c525620"
          }
        }
      }
    },
    {
      "id": "e58f9518-ea11-57ef-bfd9-3ea89dcac066",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ffd8798d-cc72-4fbb-90ca-3b5c7843793c",
        "item_id": "1863cfb3-0059-4a45-83a4-145d5e300010",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ffd8798d-cc72-4fbb-90ca-3b5c7843793c"
          }
        }
      }
    },
    {
      "id": "75605b91-dc76-513a-bc03-b4731f2a89f9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aba0f678-9004-40b6-afb6-4b61e73f05c2",
        "item_id": "1863cfb3-0059-4a45-83a4-145d5e300010",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aba0f678-9004-40b6-afb6-4b61e73f05c2"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:42:25Z`
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





