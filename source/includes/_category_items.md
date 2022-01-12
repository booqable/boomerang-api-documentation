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
    --url 'https://example.booqable.com/api/boomerang/category_items?filter%5Bcategory_id%5D=e66d571b-cb5b-4534-9021-c32e48a1bacf&includes=item' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "2c0ede06-36ce-4380-8227-22a7dbf55428",
      "created_at": "2022-01-12T14:02:32+00:00",
      "updated_at": "2022-01-12T14:02:32+00:00",
      "position": null,
      "item_id": "4483a43d-c416-414d-af83-b6b06e86069e",
      "category_id": "e66d571b-cb5b-4534-9021-c32e48a1bacf"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-01-12T14:02:08Z`
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
          "category_id": "eaaf3e11-6c68-4b8e-80b2-ed75b2179021",
          "item_id": "a4986d63-23fd-40ce-af14-124f30cffaaf"
        }
      }
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "e6fa7e22-a0ef-4a6e-a1ea-70d8e492466c",
    "type": "category_items",
    "attributes": {
      "created_at": "2022-01-12T14:02:33+00:00",
      "updated_at": "2022-01-12T14:02:33+00:00",
      "position": null,
      "item_id": "a4986d63-23fd-40ce-af14-124f30cffaaf",
      "category_id": "eaaf3e11-6c68-4b8e-80b2-ed75b2179021"
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
    "self": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=eaaf3e11-6c68-4b8e-80b2-ed75b2179021&data%5Battributes%5D%5Bitem_id%5D=a4986d63-23fd-40ce-af14-124f30cffaaf&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "first": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=eaaf3e11-6c68-4b8e-80b2-ed75b2179021&data%5Battributes%5D%5Bitem_id%5D=a4986d63-23fd-40ce-af14-124f30cffaaf&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25",
    "last": "api/boomerang/category_items?data%5Battributes%5D%5Bcategory_id%5D=eaaf3e11-6c68-4b8e-80b2-ed75b2179021&data%5Battributes%5D%5Bitem_id%5D=a4986d63-23fd-40ce-af14-124f30cffaaf&data%5Btype%5D=category_item&page%5Bnumber%5D=1&page%5Bsize%5D=25"
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
    --url 'https://example.booqable.com/api/boomerang/category_items/bb523040-36c0-4586-814d-98dadc38cfe2' \
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