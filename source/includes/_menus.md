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
      "id": "d5878a73-3bf4-45df-8d91-4f7817fa77f8",
      "type": "menus",
      "attributes": {
        "created_at": "2024-11-04T09:27:47.502582+00:00",
        "updated_at": "2024-11-04T09:27:47.502582+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1039aeac-ac23-4006-bd0f-6f1edebac20d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1039aeac-ac23-4006-bd0f-6f1edebac20d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-04T09:27:47.977243+00:00",
      "updated_at": "2024-11-04T09:27:47.977243+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "9875abda-47ee-484c-a2bb-0dbc5aace93e"
          },
          {
            "type": "menu_items",
            "id": "c7980226-2e5a-4cd5-9788-da1c8987c9de"
          },
          {
            "type": "menu_items",
            "id": "cf0a5e76-5544-4133-9ea8-0feb666b330e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "9875abda-47ee-484c-a2bb-0dbc5aace93e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:47.978778+00:00",
        "updated_at": "2024-11-04T09:27:47.978778+00:00",
        "menu_id": "1039aeac-ac23-4006-bd0f-6f1edebac20d",
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
      "id": "c7980226-2e5a-4cd5-9788-da1c8987c9de",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:47.980476+00:00",
        "updated_at": "2024-11-04T09:27:47.980476+00:00",
        "menu_id": "1039aeac-ac23-4006-bd0f-6f1edebac20d",
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
      "id": "cf0a5e76-5544-4133-9ea8-0feb666b330e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:47.981902+00:00",
        "updated_at": "2024-11-04T09:27:47.981902+00:00",
        "menu_id": "1039aeac-ac23-4006-bd0f-6f1edebac20d",
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
    "id": "da19aeac-b71f-4897-a484-327fbd110e15",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-04T09:27:48.549336+00:00",
      "updated_at": "2024-11-04T09:27:48.549336+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b30b2bff-c88c-48f3-ad74-f1b6fdf887ce' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b30b2bff-c88c-48f3-ad74-f1b6fdf887ce",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "bf3b6816-2563-4fe3-b06f-6671149d9929",
              "title": "Contact us"
            },
            {
              "id": "cfe6fd8e-1f70-42ab-9750-0683bedd6d73",
              "title": "Start"
            },
            {
              "id": "e000594d-1fe4-4ed7-b3fc-ee11c8320855",
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
    "id": "b30b2bff-c88c-48f3-ad74-f1b6fdf887ce",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-04T09:27:49.149713+00:00",
      "updated_at": "2024-11-04T09:27:49.182617+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "bf3b6816-2563-4fe3-b06f-6671149d9929"
          },
          {
            "type": "menu_items",
            "id": "cfe6fd8e-1f70-42ab-9750-0683bedd6d73"
          },
          {
            "type": "menu_items",
            "id": "e000594d-1fe4-4ed7-b3fc-ee11c8320855"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf3b6816-2563-4fe3-b06f-6671149d9929",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:49.151231+00:00",
        "updated_at": "2024-11-04T09:27:49.184457+00:00",
        "menu_id": "b30b2bff-c88c-48f3-ad74-f1b6fdf887ce",
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
      "id": "cfe6fd8e-1f70-42ab-9750-0683bedd6d73",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:49.152930+00:00",
        "updated_at": "2024-11-04T09:27:49.186084+00:00",
        "menu_id": "b30b2bff-c88c-48f3-ad74-f1b6fdf887ce",
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
      "id": "e000594d-1fe4-4ed7-b3fc-ee11c8320855",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-04T09:27:49.154289+00:00",
        "updated_at": "2024-11-04T09:27:49.187452+00:00",
        "menu_id": "b30b2bff-c88c-48f3-ad74-f1b6fdf887ce",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3a988583-6502-412c-a207-10d5b90c1be4' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3a988583-6502-412c-a207-10d5b90c1be4",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-04T09:27:47.006013+00:00",
      "updated_at": "2024-11-04T09:27:47.006013+00:00",
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