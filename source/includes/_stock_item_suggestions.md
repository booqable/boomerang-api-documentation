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



> Retrieve stock item suggestions for booking:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Baction%5D=book&filter%5Bitem_id%5D=0d1c1439-99f2-4a1d-97f7-5932fcbb2aa8&filter%5Border_id%5D=8d46d772-4e03-4e24-801d-29aa47971d0b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "c65cdcb1-f8eb-5688-b2af-f2109b1c0a5e",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "40952ecd-be5e-4707-8f09-aac119002e8e",
        "item_id": "0d1c1439-99f2-4a1d-97f7-5932fcbb2aa8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/40952ecd-be5e-4707-8f09-aac119002e8e"
          }
        }
      }
    },
    {
      "id": "1d00746b-e625-507f-be51-8a6720ad6313",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b2706d63-11ce-4099-8590-54322171c704",
        "item_id": "0d1c1439-99f2-4a1d-97f7-5932fcbb2aa8",
        "status": "unavailable"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b2706d63-11ce-4099-8590-54322171c704"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:13:58Z`
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
`order_id` | **Uuid** `required`<br>`eq`
`action` | **String_enum** `required`<br>`eq`
`q` | **String** <br>`eq`
`location_id` | **Uuid** <br>`eq`
`from` | **Datetime** <br>`eq`
`till` | **Datetime** <br>`eq`
`stock_item_id` | **Uuid** <br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`stock_item`





