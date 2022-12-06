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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=d32e1e84-a613-4cfd-bfb8-d23f1584fa69&filter%5Blocation_id%5D=71b64830-de9d-459f-8fbd-95d38bc52729&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "dd5d2cee-b89e-5bcf-865a-ba15626495bb",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "2aa6f56e-f47b-4c98-8dda-3fa2feeb4706",
        "item_id": "d32e1e84-a613-4cfd-bfb8-d23f1584fa69",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/2aa6f56e-f47b-4c98-8dda-3fa2feeb4706"
          }
        }
      }
    },
    {
      "id": "587f3258-3f24-5a45-96cf-0fde9697e025",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "648742ed-3bd3-455e-97f6-da32d6e13802",
        "item_id": "d32e1e84-a613-4cfd-bfb8-d23f1584fa69",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/648742ed-3bd3-455e-97f6-da32d6e13802"
          }
        }
      }
    },
    {
      "id": "6a9ae168-c391-535c-b503-8c61ffb4a300",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "913b70d9-21c2-48c8-a78f-bd58a5f4fc13",
        "item_id": "d32e1e84-a613-4cfd-bfb8-d23f1584fa69",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/913b70d9-21c2-48c8-a78f-bd58a5f4fc13"
          }
        }
      }
    },
    {
      "id": "55149f58-7498-5939-b129-c663c4057e0f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "aa5ebf5a-2349-46b9-a1ad-91237e2e1445",
        "item_id": "d32e1e84-a613-4cfd-bfb8-d23f1584fa69",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/aa5ebf5a-2349-46b9-a1ad-91237e2e1445"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-06T11:16:36Z`
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





