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
      "id": "7a965331-0f8a-476d-8d8e-2c3de0ee3bc5",
      "type": "menus",
      "attributes": {
        "created_at": "2024-11-25T09:28:22.270487+00:00",
        "updated_at": "2024-11-25T09:28:22.270487+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/42f4e1ef-8773-4f04-a155-3fec80c84c72?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "42f4e1ef-8773-4f04-a155-3fec80c84c72",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-25T09:28:24.408036+00:00",
      "updated_at": "2024-11-25T09:28:24.408036+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f1e743b2-94c5-43f1-a7c9-bd2690347330"
          },
          {
            "type": "menu_items",
            "id": "f8ac68fe-f47b-41a2-8469-0f557b6ff6cc"
          },
          {
            "type": "menu_items",
            "id": "e7d683d0-3a56-4fd7-9c97-c7535acdc833"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f1e743b2-94c5-43f1-a7c9-bd2690347330",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:24.411188+00:00",
        "updated_at": "2024-11-25T09:28:24.411188+00:00",
        "menu_id": "42f4e1ef-8773-4f04-a155-3fec80c84c72",
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
      "id": "f8ac68fe-f47b-41a2-8469-0f557b6ff6cc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:24.414478+00:00",
        "updated_at": "2024-11-25T09:28:24.414478+00:00",
        "menu_id": "42f4e1ef-8773-4f04-a155-3fec80c84c72",
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
      "id": "e7d683d0-3a56-4fd7-9c97-c7535acdc833",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:24.416881+00:00",
        "updated_at": "2024-11-25T09:28:24.416881+00:00",
        "menu_id": "42f4e1ef-8773-4f04-a155-3fec80c84c72",
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
    "id": "59146055-3c63-4e74-9041-bf05a28f3497",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-25T09:28:23.012771+00:00",
      "updated_at": "2024-11-25T09:28:23.012771+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/4878ba5d-4d02-4064-a55a-24cb9e40c82c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "4878ba5d-4d02-4064-a55a-24cb9e40c82c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "298dccb7-c78d-4c58-b504-bc40abfb04e7",
              "title": "Contact us"
            },
            {
              "id": "1f5c8e4c-2707-4088-bfd7-840c538e15f9",
              "title": "Start"
            },
            {
              "id": "2d844bd9-24fe-495b-9bc2-b044fc538c12",
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
    "id": "4878ba5d-4d02-4064-a55a-24cb9e40c82c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-25T09:28:25.118573+00:00",
      "updated_at": "2024-11-25T09:28:25.163054+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "298dccb7-c78d-4c58-b504-bc40abfb04e7"
          },
          {
            "type": "menu_items",
            "id": "1f5c8e4c-2707-4088-bfd7-840c538e15f9"
          },
          {
            "type": "menu_items",
            "id": "2d844bd9-24fe-495b-9bc2-b044fc538c12"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "298dccb7-c78d-4c58-b504-bc40abfb04e7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:25.120578+00:00",
        "updated_at": "2024-11-25T09:28:25.165189+00:00",
        "menu_id": "4878ba5d-4d02-4064-a55a-24cb9e40c82c",
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
      "id": "1f5c8e4c-2707-4088-bfd7-840c538e15f9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:25.122774+00:00",
        "updated_at": "2024-11-25T09:28:25.167149+00:00",
        "menu_id": "4878ba5d-4d02-4064-a55a-24cb9e40c82c",
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
      "id": "2d844bd9-24fe-495b-9bc2-b044fc538c12",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-25T09:28:25.125578+00:00",
        "updated_at": "2024-11-25T09:28:25.168843+00:00",
        "menu_id": "4878ba5d-4d02-4064-a55a-24cb9e40c82c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b92048b6-4a96-422b-9955-4f45b8194588' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b92048b6-4a96-422b-9955-4f45b8194588",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-25T09:28:23.734343+00:00",
      "updated_at": "2024-11-25T09:28:23.734343+00:00",
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