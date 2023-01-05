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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=4d73b73f-4139-485f-8f3f-6813a15d4c89&filter%5Blocation_id%5D=d7cead9a-c2cc-4573-b684-50cbcbe96a9e&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b0ff7059-93a2-5375-8e59-25166e2a9c98",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "397aa859-f885-432d-b5ad-d59e60e7e084",
        "item_id": "4d73b73f-4139-485f-8f3f-6813a15d4c89",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/397aa859-f885-432d-b5ad-d59e60e7e084"
          }
        }
      }
    },
    {
      "id": "77954cfe-7a18-5000-9180-8573abe6522f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "df2cdd8c-4e0a-485e-a5ea-33471e1555ea",
        "item_id": "4d73b73f-4139-485f-8f3f-6813a15d4c89",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/df2cdd8c-4e0a-485e-a5ea-33471e1555ea"
          }
        }
      }
    },
    {
      "id": "30f76d1b-32d7-5aa3-9abb-329448523cc0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a71074f3-bcf0-45d1-9029-7f3ddba4bf3c",
        "item_id": "4d73b73f-4139-485f-8f3f-6813a15d4c89",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a71074f3-bcf0-45d1-9029-7f3ddba4bf3c"
          }
        }
      }
    },
    {
      "id": "3e6dd16c-9445-5245-9916-0b8ea04225fe",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "20db8b5b-24ab-4c1c-ad33-045b74fc77d5",
        "item_id": "4d73b73f-4139-485f-8f3f-6813a15d4c89",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/20db8b5b-24ab-4c1c-ad33-045b74fc77d5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T11:02:34Z`
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





