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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d39624c4-77a3-4cbd-ac7d-7fa62a32c100&filter%5Blocation_id%5D=d7700f34-396c-4f3c-a567-c233b859705b&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "6b4b1e13-3ae8-5a8d-9e48-cf6d41f806e2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "02d8e04b-e8d4-4092-b18d-36e782d0e277",
        "item_id": "d39624c4-77a3-4cbd-ac7d-7fa62a32c100",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/02d8e04b-e8d4-4092-b18d-36e782d0e277"
          }
        }
      }
    },
    {
      "id": "cd889f6c-2bda-5452-8399-01f3995b300f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "8caac724-322f-4f56-95db-255b46985943",
        "item_id": "d39624c4-77a3-4cbd-ac7d-7fa62a32c100",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/8caac724-322f-4f56-95db-255b46985943"
          }
        }
      }
    },
    {
      "id": "1972b9fc-0f51-5e09-9ee2-3c3a92834b7c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "76ec7d95-b17f-411c-8ca0-f930a62a223b",
        "item_id": "d39624c4-77a3-4cbd-ac7d-7fa62a32c100",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/76ec7d95-b17f-411c-8ca0-f930a62a223b"
          }
        }
      }
    },
    {
      "id": "3c1591b2-d09d-5549-9736-cad1d33deb26",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f6eb6145-7ffb-4001-a783-852221558ad5",
        "item_id": "d39624c4-77a3-4cbd-ac7d-7fa62a32c100",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f6eb6145-7ffb-4001-a783-852221558ad5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-01T13:17:47Z`
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





