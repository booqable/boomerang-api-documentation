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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=483d26da-e954-4db6-a835-811a40b46c85&filter%5Blocation_id%5D=f9802c35-5356-444c-bec9-cbe244d39816&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "cac9748c-ba77-51b9-a40a-a65612d5ceca",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "a0859faa-f934-4d78-ba36-9d05935c1ed1",
        "item_id": "483d26da-e954-4db6-a835-811a40b46c85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/a0859faa-f934-4d78-ba36-9d05935c1ed1"
          }
        }
      }
    },
    {
      "id": "bd1d2e15-e54b-5dca-83cb-34390101a811",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9ddf754d-4745-4f61-a665-c32e6564dcd1",
        "item_id": "483d26da-e954-4db6-a835-811a40b46c85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9ddf754d-4745-4f61-a665-c32e6564dcd1"
          }
        }
      }
    },
    {
      "id": "be131b48-c8f2-5316-bbf6-1b78f1816e0d",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "9dad3621-845a-4bf9-9f69-163a53a3333e",
        "item_id": "483d26da-e954-4db6-a835-811a40b46c85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/9dad3621-845a-4bf9-9f69-163a53a3333e"
          }
        }
      }
    },
    {
      "id": "8569513b-cbee-58aa-ae11-de25220def7c",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "ba4b80cc-f3ea-450e-b1af-04dfceecf460",
        "item_id": "483d26da-e954-4db6-a835-811a40b46c85",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/ba4b80cc-f3ea-450e-b1af-04dfceecf460"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T13:03:03Z`
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





