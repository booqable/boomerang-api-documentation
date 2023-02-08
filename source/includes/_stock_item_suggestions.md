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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=5ae1d033-21d9-4ab2-bf48-786a0ef57251&filter%5Blocation_id%5D=b3442c88-b352-466a-a7ed-8ebd4de95445&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "5d57f3dc-e911-517c-a781-a4f59539cc29",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "639405eb-d4c1-43b3-8ae6-245e4723effe",
        "item_id": "5ae1d033-21d9-4ab2-bf48-786a0ef57251",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/639405eb-d4c1-43b3-8ae6-245e4723effe"
          }
        }
      }
    },
    {
      "id": "ae360dca-bbbf-53f0-8d33-a42f8144a080",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "68951291-b8f9-429b-bd60-4b52d9239e19",
        "item_id": "5ae1d033-21d9-4ab2-bf48-786a0ef57251",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/68951291-b8f9-429b-bd60-4b52d9239e19"
          }
        }
      }
    },
    {
      "id": "3d5a5b74-4471-5631-8216-0b2bb261a72d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e045bf1c-d272-4ce5-bbc1-1b03ebb62b01",
        "item_id": "5ae1d033-21d9-4ab2-bf48-786a0ef57251",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e045bf1c-d272-4ce5-bbc1-1b03ebb62b01"
          }
        }
      }
    },
    {
      "id": "6c0668ae-1c52-588e-8784-b4d8bc3d59ee",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2d208478-0341-4e5e-bd54-650326e46130",
        "item_id": "5ae1d033-21d9-4ab2-bf48-786a0ef57251",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2d208478-0341-4e5e-bd54-650326e46130"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-08T09:43:44Z`
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





