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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4d749827-d859-4708-873e-d9323911393b&filter%5Blocation_id%5D=6a65d389-1be5-420f-981a-e0a79ca420d7&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd177ffa-3946-5917-9dd4-ed39b3400aa9",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c9db1434-8f86-4ae6-a1a4-265587c2d28a",
        "item_id": "4d749827-d859-4708-873e-d9323911393b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c9db1434-8f86-4ae6-a1a4-265587c2d28a"
          }
        }
      }
    },
    {
      "id": "d51d436f-67fb-5f9c-923c-3cd0a1ad07f4",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0990461c-9b3f-48a4-aa49-925c292300b0",
        "item_id": "4d749827-d859-4708-873e-d9323911393b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0990461c-9b3f-48a4-aa49-925c292300b0"
          }
        }
      }
    },
    {
      "id": "120b3821-c92b-5a50-be05-606bea2e57aa",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "50ecd5af-400b-426e-912d-040df22db3c7",
        "item_id": "4d749827-d859-4708-873e-d9323911393b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/50ecd5af-400b-426e-912d-040df22db3c7"
          }
        }
      }
    },
    {
      "id": "bbebd843-e36e-59dd-a675-5769cb00164a",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "7aaa5371-5e2d-454a-b267-81e8f7f12964",
        "item_id": "4d749827-d859-4708-873e-d9323911393b",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/7aaa5371-5e2d-454a-b267-81e8f7f12964"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T18:56:36Z`
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





