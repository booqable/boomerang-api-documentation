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
    --url 'https://example.booqable.com/api/boomerang/category_items?filter%5Bcategory_id%5D=3a8ec700-05f1-4a7d-a943-d943aa7ee5b8&includes=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "fecd21e4-7a86-4ff2-80f9-3d4044fa8a36",
      "created_at": "2021-12-02T16:47:39+00:00",
      "updated_at": "2021-12-02T16:47:39+00:00",
      "position": null,
      "item_id": "8a5ea13e-b09a-4a9b-9b4e-f4f9375f9483",
      "category_id": "3a8ec700-05f1-4a7d-a943-d943aa7ee5b8"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2021-12-02T16:47:09Z`
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
          "category_id": "47d81e6a-98da-4ff3-b195-879ba843f3b4",
          "item_id": "f026f264-1637-4ddc-ad04-3e65783117a8"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "166e0929-ed45-4a90-b617-cd1bbb53ecc3",
    "type": "category_items",
    "attributes": {
      "created_at": "2021-12-02T16:47:40+00:00",
      "updated_at": "2021-12-02T16:47:40+00:00",
      "position": null,
      "item_id": "f026f264-1637-4ddc-ad04-3e65783117a8",
      "category_id": "47d81e6a-98da-4ff3-b195-879ba843f3b4"
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
    "self": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=47d81e6a-98da-4ff3-b195-879ba843f3b4&data%5Battributes%5D%5Bitem_id%5D=f026f264-1637-4ddc-ad04-3e65783117a8&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=47d81e6a-98da-4ff3-b195-879ba843f3b4&data%5Battributes%5D%5Bitem_id%5D=f026f264-1637-4ddc-ad04-3e65783117a8&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=47d81e6a-98da-4ff3-b195-879ba843f3b4&data%5Battributes%5D%5Bitem_id%5D=f026f264-1637-4ddc-ad04-3e65783117a8&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/category_items/3aa9b08a-cea3-43ec-a1d2-4d8b3b53df85' \
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