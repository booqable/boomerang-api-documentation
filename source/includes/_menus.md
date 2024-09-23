# Menus

Allows creating and managing menus for your shop.

## Endpoints
`GET /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Listing menus



> How to fetch a list of menus:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": [
    {
      "id": "9968887e-e936-40ae-8ff8-b99c0c7851a7",
      "type": "menus",
      "attributes": {
        "created_at": "2024-09-23T09:24:42.643892+00:00",
        "updated_at": "2024-09-23T09:24:42.643892+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/677369cd-513c-4e71-9dd9-26c99e68a747?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "677369cd-513c-4e71-9dd9-26c99e68a747",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-23T09:24:43.771301+00:00",
      "updated_at": "2024-09-23T09:24:43.771301+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d9ef5e33-5418-46e3-9ba6-ddfe59807a2e"
          },
          {
            "type": "menu_items",
            "id": "e4aaeca0-3f0c-4f81-9790-b948886ddc7c"
          },
          {
            "type": "menu_items",
            "id": "c1e74b24-4065-4701-a7e6-35351973826d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d9ef5e33-5418-46e3-9ba6-ddfe59807a2e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:43.772973+00:00",
        "updated_at": "2024-09-23T09:24:43.772973+00:00",
        "menu_id": "677369cd-513c-4e71-9dd9-26c99e68a747",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "e4aaeca0-3f0c-4f81-9790-b948886ddc7c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:43.774703+00:00",
        "updated_at": "2024-09-23T09:24:43.774703+00:00",
        "menu_id": "677369cd-513c-4e71-9dd9-26c99e68a747",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "c1e74b24-4065-4701-a7e6-35351973826d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:43.776075+00:00",
        "updated_at": "2024-09-23T09:24:43.776075+00:00",
        "menu_id": "677369cd-513c-4e71-9dd9-26c99e68a747",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






## Creating a menu with items



> How to create a menu with menu items:

```shell
  curl --request POST \
    --url 'https://example.booqable.com/api/boomerang/menus' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "key": "header",
          "menu_items_attributes": [
            {
              "title": "Home",
              "target_type": "Static",
              "value": "/"
            },
            {
              "title": "Resources",
              "target_type": "Static",
              "value": "/resources",
              "menu_items_attributes": [
                {
                  "title": "Blog",
                  "target_type": "Static",
                  "value": "/resources/blog",
                  "menu_items_attributes": [
                    {
                      "title": "Customer stories",
                      "target_type": "Static",
                      "value": "/resources/blog/customer-stories"
                    }
                  ]
                }
              ]
            }
          ]
        }
      },
      "include": "menus"
    }'
```

> A 201 status response looks like this:

```json
  {
  "data": {
    "id": "060f0734-322f-482d-81a9-941046087a0c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-23T09:24:43.262720+00:00",
      "updated_at": "2024-09-23T09:24:43.262720+00:00",
      "title": "Header menu",
      "key": "header"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/menus`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/0d811f97-ac24-4a10-a7f5-8f4b93d50dfd' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0d811f97-ac24-4a10-a7f5-8f4b93d50dfd",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1a8768dc-3e66-40d7-8eba-8373fff40014",
              "title": "Contact us"
            },
            {
              "id": "9a08e1bb-27c7-47e3-8107-b559b4044946",
              "title": "Start"
            },
            {
              "id": "eae5466a-05e1-4951-81d3-8c1af306f4ef",
              "title": "Rent from us"
            }
          ]
        }
      },
      "include": "menu_items"
    }'
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0d811f97-ac24-4a10-a7f5-8f4b93d50dfd",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-23T09:24:42.148556+00:00",
      "updated_at": "2024-09-23T09:24:42.179394+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1a8768dc-3e66-40d7-8eba-8373fff40014"
          },
          {
            "type": "menu_items",
            "id": "9a08e1bb-27c7-47e3-8107-b559b4044946"
          },
          {
            "type": "menu_items",
            "id": "eae5466a-05e1-4951-81d3-8c1af306f4ef"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1a8768dc-3e66-40d7-8eba-8373fff40014",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:42.150361+00:00",
        "updated_at": "2024-09-23T09:24:42.181069+00:00",
        "menu_id": "0d811f97-ac24-4a10-a7f5-8f4b93d50dfd",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "9a08e1bb-27c7-47e3-8107-b559b4044946",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:42.152169+00:00",
        "updated_at": "2024-09-23T09:24:42.182500+00:00",
        "menu_id": "0d811f97-ac24-4a10-a7f5-8f4b93d50dfd",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "eae5466a-05e1-4951-81d3-8c1af306f4ef",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-23T09:24:42.153486+00:00",
        "updated_at": "2024-09-23T09:24:42.183793+00:00",
        "menu_id": "0d811f97-ac24-4a10-a7f5-8f4b93d50dfd",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "generate_sub_menu_items": false,
        "generated": false,
        "sorting_weight": null
      },
      "relationships": {}
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/3be7b700-af87-46f8-85a3-fb5d78a97390' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3be7b700-af87-46f8-85a3-fb5d78a97390",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-23T09:24:44.273672+00:00",
      "updated_at": "2024-09-23T09:24:44.273672+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {}
  },
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following parameters:

Name | Description
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes