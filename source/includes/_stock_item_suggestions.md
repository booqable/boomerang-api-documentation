# Stock item suggestions

Use stock item suggestions to figure out which stock item can be booked, started, or stopped. These suggestions are sorted by relevancy. Available and temporary stock items first.

## Fields
Every stock item suggestion has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>
`stock_item_id` | **Uuid**<br>The associated Stock item
`item_id` | **Uuid** `readonly`<br>ID of the item belonging to the suggested stock item
`status` | **String_enum** `readonly`<br>Status of the suggestion. One of `available_in_location`, `available_in_cluster`, `overdue`, `unavailable`


## Relationships
Stock item suggestions have the following relationships:

Name | Description
- | -
`stock_item` | **Stock items** `readonly`<br>Associated Stock item


## Listing stock item suggestions



> How to fetch a list of stock item suggestions:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=6d7dc9c1-1c50-4902-acce-8b8f9babc60f&filter%5Blocation_id%5D=b2a81ab4-e24e-4d0c-b7f7-1a1233167198&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "e4d0f61b-4b48-5b49-a840-624c98b74959",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9105f8f4-7947-4b3a-b164-428efb0d36d0",
        "item_id": "6d7dc9c1-1c50-4902-acce-8b8f9babc60f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9105f8f4-7947-4b3a-b164-428efb0d36d0"
          }
        }
      }
    },
    {
      "id": "be4bfccd-c514-5272-8280-540a0c0c364f",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "c9adcaaf-778b-4481-9084-740455d23681",
        "item_id": "6d7dc9c1-1c50-4902-acce-8b8f9babc60f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/c9adcaaf-778b-4481-9084-740455d23681"
          }
        }
      }
    },
    {
      "id": "6d45fe09-4183-5707-94a1-238ce77b53e8",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "3ad8b30b-009d-4cca-8900-c656b5e67a9a",
        "item_id": "6d7dc9c1-1c50-4902-acce-8b8f9babc60f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/3ad8b30b-009d-4cca-8900-c656b5e67a9a"
          }
        }
      }
    },
    {
      "id": "c1d8c584-4401-5ad3-a083-ffaeb34d0473",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "5b242547-3a8e-4b5e-9c03-6853f6db15d4",
        "item_id": "6d7dc9c1-1c50-4902-acce-8b8f9babc60f",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/5b242547-3a8e-4b5e-9c03-6853f6db15d4"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=stock_item`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[stock_item_suggestions]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-03-29T09:19:16Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`item_id` | **Uuid** `required`<br>`eq`
`status` | **String_enum**<br>`eq`
`order_id` | **Uuid**<br>`eq`
`location_id` | **Uuid**<br>`eq`
`from` | **Datetime**<br>`eq`
`till` | **Datetime**<br>`eq`
`action` | **String_enum**<br>`eq`
`q` | **String**<br>`eq`
`stock_item_id` | **Uuid**<br>`eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`stock_item`





