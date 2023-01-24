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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=58e5b9c6-1357-4d23-8f0a-0e4a566950db&filter%5Blocation_id%5D=f7af4954-6b16-4053-b908-fb10049e6853&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "12e3af51-7e0b-5bd3-94c6-8e1bafdb5a53",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "1d62b1be-d49d-4680-bbcd-48f8a532b6e7",
        "item_id": "58e5b9c6-1357-4d23-8f0a-0e4a566950db",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/1d62b1be-d49d-4680-bbcd-48f8a532b6e7"
          }
        }
      }
    },
    {
      "id": "e34f8529-c5ae-5101-b751-5147a091ddbf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f1d622f2-0419-4f83-8946-9cdb1386b7c2",
        "item_id": "58e5b9c6-1357-4d23-8f0a-0e4a566950db",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f1d622f2-0419-4f83-8946-9cdb1386b7c2"
          }
        }
      }
    },
    {
      "id": "9cfb35f5-f85c-5348-9f6a-88ba2584880d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b8d255be-dd2d-49a3-94ae-27efcc85a088",
        "item_id": "58e5b9c6-1357-4d23-8f0a-0e4a566950db",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b8d255be-dd2d-49a3-94ae-27efcc85a088"
          }
        }
      }
    },
    {
      "id": "50419b02-0250-545e-a611-1d8525e67bcf",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9543d7de-58f8-46bf-b98d-7e05f40f5c5e",
        "item_id": "58e5b9c6-1357-4d23-8f0a-0e4a566950db",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9543d7de-58f8-46bf-b98d-7e05f40f5c5e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-24T16:30:48Z`
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





