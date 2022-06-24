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
    --url 'https://example.booqable.com/api/boomerang/category_items?filter%5Bcategory_id%5D=02c0434e-10b9-4277-ba2e-eb69e4a659b8&includes=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "b103d158-22d4-4aef-abb0-881ba513a9a2",
      "created_at": "2022-06-24T14:45:13+00:00",
      "updated_at": "2022-06-24T14:45:13+00:00",
      "position": null,
      "item_id": "0adbdda9-7544-4639-b135-0b7ee85b23e9",
      "category_id": "02c0434e-10b9-4277-ba2e-eb69e4a659b8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-06-24T14:44:43Z`
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
          "category_id": "d1138408-51d0-4f51-a5cc-4726acdad217",
          "item_id": "33ea719a-1412-42d3-a43b-04068e04b3b1"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "50d21058-baf5-4ee3-80fb-099a6d8e719d",
    "type": "category_items",
    "attributes": {
      "created_at": "2022-06-24T14:45:13+00:00",
      "updated_at": "2022-06-24T14:45:13+00:00",
      "position": null,
      "item_id": "33ea719a-1412-42d3-a43b-04068e04b3b1",
      "category_id": "d1138408-51d0-4f51-a5cc-4726acdad217"
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
    --url 'https://example.booqable.com/api/boomerang/category_items/285e1b24-ed1f-45b4-8090-87bab93a3e24' \
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