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
      "id": "502dded1-75ce-4277-8ef1-77169fe8b72e",
      "type": "menus",
      "attributes": {
        "created_at": "2024-08-05T09:24:21.446514+00:00",
        "updated_at": "2024-08-05T09:24:21.446514+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bbf5c409-8a87-4100-83be-3f63b157c476?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bbf5c409-8a87-4100-83be-3f63b157c476",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-05T09:24:22.900869+00:00",
      "updated_at": "2024-08-05T09:24:22.900869+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "f6905b47-acbe-4922-9769-b11efef391ab"
          },
          {
            "type": "menu_items",
            "id": "70cc2c30-773e-4612-944d-356f07a5f079"
          },
          {
            "type": "menu_items",
            "id": "4c113170-e5c0-416e-9b24-ebfdf2c59be7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f6905b47-acbe-4922-9769-b11efef391ab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:22.902597+00:00",
        "updated_at": "2024-08-05T09:24:22.902597+00:00",
        "menu_id": "bbf5c409-8a87-4100-83be-3f63b157c476",
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
      "id": "70cc2c30-773e-4612-944d-356f07a5f079",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:22.904286+00:00",
        "updated_at": "2024-08-05T09:24:22.904286+00:00",
        "menu_id": "bbf5c409-8a87-4100-83be-3f63b157c476",
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
      "id": "4c113170-e5c0-416e-9b24-ebfdf2c59be7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:22.905803+00:00",
        "updated_at": "2024-08-05T09:24:22.905803+00:00",
        "menu_id": "bbf5c409-8a87-4100-83be-3f63b157c476",
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
    "id": "2424a03c-9f5c-4dea-afba-1648c0d76ea7",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-05T09:24:20.862930+00:00",
      "updated_at": "2024-08-05T09:24:20.862930+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0ee93603-064c-4a9b-b81a-6058d2cae91b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0ee93603-064c-4a9b-b81a-6058d2cae91b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "bc8989cc-1b5f-4435-a4df-3cd0390e7497",
              "title": "Contact us"
            },
            {
              "id": "b2206c2a-756c-4401-b96d-643c4ab3daca",
              "title": "Start"
            },
            {
              "id": "bbce9cfc-adf5-409a-8dd6-63c6ec85a5ec",
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
    "id": "0ee93603-064c-4a9b-b81a-6058d2cae91b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-05T09:24:23.828482+00:00",
      "updated_at": "2024-08-05T09:24:23.893818+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "bc8989cc-1b5f-4435-a4df-3cd0390e7497"
          },
          {
            "type": "menu_items",
            "id": "b2206c2a-756c-4401-b96d-643c4ab3daca"
          },
          {
            "type": "menu_items",
            "id": "bbce9cfc-adf5-409a-8dd6-63c6ec85a5ec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bc8989cc-1b5f-4435-a4df-3cd0390e7497",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:23.830696+00:00",
        "updated_at": "2024-08-05T09:24:23.896757+00:00",
        "menu_id": "0ee93603-064c-4a9b-b81a-6058d2cae91b",
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
      "id": "b2206c2a-756c-4401-b96d-643c4ab3daca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:23.833101+00:00",
        "updated_at": "2024-08-05T09:24:23.900343+00:00",
        "menu_id": "0ee93603-064c-4a9b-b81a-6058d2cae91b",
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
      "id": "bbce9cfc-adf5-409a-8dd6-63c6ec85a5ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-05T09:24:23.835317+00:00",
        "updated_at": "2024-08-05T09:24:23.902780+00:00",
        "menu_id": "0ee93603-064c-4a9b-b81a-6058d2cae91b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2ce7afd0-6261-4614-8d55-1d25df4a72e8' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2ce7afd0-6261-4614-8d55-1d25df4a72e8",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-05T09:24:22.130043+00:00",
      "updated_at": "2024-08-05T09:24:22.130043+00:00",
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