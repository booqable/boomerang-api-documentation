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
    --url 'https://example.booqable.com/api/boomerang/category_items?filter%5Bcategory_id%5D=f43b12e5-25c6-4903-808b-301549557f2d&includes=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "8f9ebb00-c4cd-4d64-ade4-d907eee3d433",
      "created_at": "2021-12-07T11:01:00+00:00",
      "updated_at": "2021-12-07T11:01:00+00:00",
      "position": null,
      "item_id": "106705fa-c536-4fae-9ece-600f09f9e845",
      "category_id": "f43b12e5-25c6-4903-808b-301549557f2d"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-07T11:00:38Z`
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
          "category_id": "4c6911ec-19a5-4252-ab98-590ad880f6cd",
          "item_id": "8e855681-d9e9-478d-904f-fd8277945a28"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "89bb1142-e272-4e60-be9f-9cdcc90716e8",
    "type": "category_items",
    "attributes": {
      "created_at": "2021-12-07T11:01:00+00:00",
      "updated_at": "2021-12-07T11:01:00+00:00",
      "position": null,
      "item_id": "8e855681-d9e9-478d-904f-fd8277945a28",
      "category_id": "4c6911ec-19a5-4252-ab98-590ad880f6cd"
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
  "links": {
    "self": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=4c6911ec-19a5-4252-ab98-590ad880f6cd&data%5Battributes%5D%5Bitem_id%5D=8e855681-d9e9-478d-904f-fd8277945a28&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=4c6911ec-19a5-4252-ab98-590ad880f6cd&data%5Battributes%5D%5Bitem_id%5D=8e855681-d9e9-478d-904f-fd8277945a28&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=4c6911ec-19a5-4252-ab98-590ad880f6cd&data%5Battributes%5D%5Bitem_id%5D=8e855681-d9e9-478d-904f-fd8277945a28&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/category_items/b11bb8e3-8d6b-49d0-8ce9-57a8a48838f1' \
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