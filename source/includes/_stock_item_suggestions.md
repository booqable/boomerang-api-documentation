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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=3939d0d3-15e0-46de-812e-ad4695644789&filter%5Blocation_id%5D=f92f4528-ffb3-4892-96e8-13ccc45b7659&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "871838ce-75bc-5800-8478-f58a623db2f0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "23f35846-cb3c-4e65-af26-6ffa7da0df37",
        "item_id": "3939d0d3-15e0-46de-812e-ad4695644789",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/23f35846-cb3c-4e65-af26-6ffa7da0df37"
          }
        }
      }
    },
    {
      "id": "7cfdf8df-659b-5873-9066-f976ffd017b2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "e24cb462-3c44-46f8-8297-fc0736eda4c1",
        "item_id": "3939d0d3-15e0-46de-812e-ad4695644789",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/e24cb462-3c44-46f8-8297-fc0736eda4c1"
          }
        }
      }
    },
    {
      "id": "69844866-82c4-5640-b7b2-3ec7f84cbf3e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "64d266d1-5e43-4c80-ba59-8690b86830a0",
        "item_id": "3939d0d3-15e0-46de-812e-ad4695644789",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/64d266d1-5e43-4c80-ba59-8690b86830a0"
          }
        }
      }
    },
    {
      "id": "5ce1ef33-ebb8-545f-88b2-2c0567ff74f2",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2ff80395-7095-40ef-8dfa-63b35af38062",
        "item_id": "3939d0d3-15e0-46de-812e-ad4695644789",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2ff80395-7095-40ef-8dfa-63b35af38062"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-02T07:55:22Z`
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





