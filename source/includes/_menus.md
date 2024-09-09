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
      "id": "31478291-b533-42bf-9e59-9cc255fc1509",
      "type": "menus",
      "attributes": {
        "created_at": "2024-09-09T09:26:13.803381+00:00",
        "updated_at": "2024-09-09T09:26:13.803381+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1a88c882-c763-4e03-ba28-7e92b39cfe63?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1a88c882-c763-4e03-ba28-7e92b39cfe63",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-09T09:26:14.656250+00:00",
      "updated_at": "2024-09-09T09:26:14.656250+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a062c2e8-c39a-4b35-af18-d287361faf62"
          },
          {
            "type": "menu_items",
            "id": "7cfb6245-d6f0-4a9c-841d-d5bf2e47b703"
          },
          {
            "type": "menu_items",
            "id": "aaf201af-1ae4-427b-b7cc-c2f8acf5ce30"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a062c2e8-c39a-4b35-af18-d287361faf62",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:14.657473+00:00",
        "updated_at": "2024-09-09T09:26:14.657473+00:00",
        "menu_id": "1a88c882-c763-4e03-ba28-7e92b39cfe63",
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
      "id": "7cfb6245-d6f0-4a9c-841d-d5bf2e47b703",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:14.658927+00:00",
        "updated_at": "2024-09-09T09:26:14.658927+00:00",
        "menu_id": "1a88c882-c763-4e03-ba28-7e92b39cfe63",
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
      "id": "aaf201af-1ae4-427b-b7cc-c2f8acf5ce30",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:14.660278+00:00",
        "updated_at": "2024-09-09T09:26:14.660278+00:00",
        "menu_id": "1a88c882-c763-4e03-ba28-7e92b39cfe63",
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
    "id": "fd40df24-f9fb-4fef-bfea-3109a1a9bbd6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-09T09:26:14.248296+00:00",
      "updated_at": "2024-09-09T09:26:14.248296+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a4e31bd7-a573-40a1-8f63-5dc2b52ecf49' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a4e31bd7-a573-40a1-8f63-5dc2b52ecf49",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "21aef3e7-bcb0-4c47-8d2d-e9468f6befde",
              "title": "Contact us"
            },
            {
              "id": "e9b32c44-d819-4b0c-84ef-48a3da23aaa9",
              "title": "Start"
            },
            {
              "id": "2e25c966-1b74-4e21-ac65-127e39f21588",
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
    "id": "a4e31bd7-a573-40a1-8f63-5dc2b52ecf49",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-09T09:26:15.068993+00:00",
      "updated_at": "2024-09-09T09:26:15.099588+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "21aef3e7-bcb0-4c47-8d2d-e9468f6befde"
          },
          {
            "type": "menu_items",
            "id": "e9b32c44-d819-4b0c-84ef-48a3da23aaa9"
          },
          {
            "type": "menu_items",
            "id": "2e25c966-1b74-4e21-ac65-127e39f21588"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "21aef3e7-bcb0-4c47-8d2d-e9468f6befde",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:15.070461+00:00",
        "updated_at": "2024-09-09T09:26:15.101205+00:00",
        "menu_id": "a4e31bd7-a573-40a1-8f63-5dc2b52ecf49",
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
      "id": "e9b32c44-d819-4b0c-84ef-48a3da23aaa9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:15.072449+00:00",
        "updated_at": "2024-09-09T09:26:15.102586+00:00",
        "menu_id": "a4e31bd7-a573-40a1-8f63-5dc2b52ecf49",
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
      "id": "2e25c966-1b74-4e21-ac65-127e39f21588",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-09T09:26:15.073786+00:00",
        "updated_at": "2024-09-09T09:26:15.103890+00:00",
        "menu_id": "a4e31bd7-a573-40a1-8f63-5dc2b52ecf49",
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
    --url 'https://example.booqable.com/api/boomerang/menus/3fd3de1e-e9a7-4959-a5ed-3a5067700504' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fd3de1e-e9a7-4959-a5ed-3a5067700504",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-09T09:26:13.375629+00:00",
      "updated_at": "2024-09-09T09:26:13.375629+00:00",
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