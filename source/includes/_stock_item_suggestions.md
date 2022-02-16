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
    --url 'https://example.booqable.com/api/boomerang/stock_item_suggestions?filter%5Bfrom%5D=2022-01-01&filter%5Bitem_id%5D=2c62a141-1c65-4a6a-8421-986ece167de8&filter%5Blocation_id%5D=bf18bc61-ab45-4380-b622-5dc3aece3b27&filter%5Btill%5D=2022-01-07' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "94e548e4-dba1-51bf-90ab-83f824b5dc14",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "4834edec-9da9-479b-8d92-848a3ad93eaf",
        "item_id": "2c62a141-1c65-4a6a-8421-986ece167de8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/4834edec-9da9-479b-8d92-848a3ad93eaf"
          }
        }
      }
    },
    {
      "id": "dd2a5d30-785d-59b0-8bd7-57b697eacb14",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "0a5e17f0-3a61-48ba-8378-54bd01946061",
        "item_id": "2c62a141-1c65-4a6a-8421-986ece167de8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/0a5e17f0-3a61-48ba-8378-54bd01946061"
          }
        }
      }
    },
    {
      "id": "df6fab8b-0ded-52ed-885b-f64ec04c41d0",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "b9d39b35-2681-40e2-92e4-b749e2c37087",
        "item_id": "2c62a141-1c65-4a6a-8421-986ece167de8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/b9d39b35-2681-40e2-92e4-b749e2c37087"
          }
        }
      }
    },
    {
      "id": "fa64ec30-476b-5a7d-a070-25af5b0c5d23",
      "type": "stock_item_suggestions",
      "attributes": {
        "stock_item_id": "f11f22cb-e7ea-44cd-83a8-af898d594375",
        "item_id": "2c62a141-1c65-4a6a-8421-986ece167de8",
        "status": "available_in_location"
      },
      "relationships": {
        "stock_item": {
          "links": {
            "related": "api/boomerang/stock_items/f11f22cb-e7ea-44cd-83a8-af898d594375"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-02-16T10:48:54Z`
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





