# Category items

Connects items and categories

## Endpoints
`GET /api/boomerang/category_items`

`POST /api/boomerang/category_items`

`DELETE /api/boomerang/category_items/{id}`

## Fields
Every category item has the following fields:

Name | Description
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`position` | **Integer**<br>Determines item order in the category
`item_id` | **Uuid**<br>The associated Item
`category_id` | **Uuid**<br>The associated Category


## Relationships
Category items have the following relationships:

Name | Description
- | -
`item` | **Items** `readonly`<br>Associated Item
`category` | **Categories** `readonly`<br>Associated Category


## Listing category items



> How to fetch a list of category items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/category_items?filter%5Bcategory_id%5D=87f316af-9f4c-4d37-a84d-d89cd7f6c7ad&includes=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "06273806-fb17-49c6-9512-68ecf335f005",
      "created_at": "2022-06-01T08:55:43+00:00",
      "updated_at": "2022-06-01T08:55:43+00:00",
      "position": null,
      "item_id": "261fcee9-41f3-4542-905d-ffc07323bbdf",
      "category_id": "87f316af-9f4c-4d37-a84d-d89cd7f6c7ad"
    }
  ]
}
```

### HTTP Request

`GET /api/boomerang/category_items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[category_items]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-01T08:55:19Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`position` | **Integer**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`item_id` | **Uuid**<br>`eq`, `not_eq`
`category_id` | **Uuid**<br>`eq`, `not_eq`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request accepts the following includes:

`item` => 
`photo`








## Adding an item to a category



> How to create a category item:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/category_items' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "category_item",
        "attributes": {
          "category_id": "7ba98403-c7ba-4b0d-acfe-98010d07ca80",
          "item_id": "9f06075a-7237-45bf-afbd-6aaf8caff9ac"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "9aa7f8d3-c2e1-40e9-86ae-0183231d4b94",
    "type": "category_items",
    "attributes": {
      "created_at": "2022-06-01T08:55:43+00:00",
      "updated_at": "2022-06-01T08:55:43+00:00",
      "position": null,
      "item_id": "9f06075a-7237-45bf-afbd-6aaf8caff9ac",
      "category_id": "7ba98403-c7ba-4b0d-acfe-98010d07ca80"
    },
    "relationships": {
      "item": {
        "meta": {
          "included": false
        }
      },
      "category": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/category_items`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[category_items]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][position]` | **Integer**<br>Determines item order in the category
`data[attributes][item_id]` | **Uuid**<br>The associated Item
`data[attributes][category_id]` | **Uuid**<br>The associated Category


### Includes

This request accepts the following includes:

`item` => 
`photo`




`category`






## Removing an item from a category



> How to delete a category item:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/category_items/5649bd32-0892-4f6f-a4a4-8135f424ee97' \
    --header 'content-type: application/json' \
    --data '{}'
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/category_items/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=item,category`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[category_items]=id,created_at,updated_at`


### Includes

This request does not accept any includes