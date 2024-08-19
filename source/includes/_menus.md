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
      "id": "1500d99b-ae89-4de0-9352-8d3adc1ee556",
      "type": "menus",
      "attributes": {
        "created_at": "2024-08-19T09:22:02.670852+00:00",
        "updated_at": "2024-08-19T09:22:02.670852+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5e9233d5-fa46-4300-9a91-3661752c6cc6?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5e9233d5-fa46-4300-9a91-3661752c6cc6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-19T09:22:01.618058+00:00",
      "updated_at": "2024-08-19T09:22:01.618058+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "afe6d907-0961-4c90-a036-3d0d79c36a74"
          },
          {
            "type": "menu_items",
            "id": "6ff33b72-ffa0-4d67-8987-5543f6cd9dc4"
          },
          {
            "type": "menu_items",
            "id": "e9597bf4-1b5d-4c92-95a6-66e16cca40e6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "afe6d907-0961-4c90-a036-3d0d79c36a74",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:01.619458+00:00",
        "updated_at": "2024-08-19T09:22:01.619458+00:00",
        "menu_id": "5e9233d5-fa46-4300-9a91-3661752c6cc6",
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
      "id": "6ff33b72-ffa0-4d67-8987-5543f6cd9dc4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:01.621066+00:00",
        "updated_at": "2024-08-19T09:22:01.621066+00:00",
        "menu_id": "5e9233d5-fa46-4300-9a91-3661752c6cc6",
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
      "id": "e9597bf4-1b5d-4c92-95a6-66e16cca40e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:01.622462+00:00",
        "updated_at": "2024-08-19T09:22:01.622462+00:00",
        "menu_id": "5e9233d5-fa46-4300-9a91-3661752c6cc6",
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
    "id": "520041c3-3e55-4117-8a50-ecaa24d47588",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-19T09:22:02.168346+00:00",
      "updated_at": "2024-08-19T09:22:02.168346+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9b4bb60b-cc65-460c-991c-07013765f6a0' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9b4bb60b-cc65-460c-991c-07013765f6a0",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7cb71115-1534-4e26-9149-121b9d9a27a3",
              "title": "Contact us"
            },
            {
              "id": "a71916fe-2848-4533-8eec-4cc0189c38d9",
              "title": "Start"
            },
            {
              "id": "1a724a34-f7ae-4634-9e43-01c0427b0c93",
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
    "id": "9b4bb60b-cc65-460c-991c-07013765f6a0",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-19T09:22:00.524753+00:00",
      "updated_at": "2024-08-19T09:22:00.559604+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7cb71115-1534-4e26-9149-121b9d9a27a3"
          },
          {
            "type": "menu_items",
            "id": "a71916fe-2848-4533-8eec-4cc0189c38d9"
          },
          {
            "type": "menu_items",
            "id": "1a724a34-f7ae-4634-9e43-01c0427b0c93"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7cb71115-1534-4e26-9149-121b9d9a27a3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:00.526343+00:00",
        "updated_at": "2024-08-19T09:22:00.561380+00:00",
        "menu_id": "9b4bb60b-cc65-460c-991c-07013765f6a0",
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
      "id": "a71916fe-2848-4533-8eec-4cc0189c38d9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:00.527965+00:00",
        "updated_at": "2024-08-19T09:22:00.562783+00:00",
        "menu_id": "9b4bb60b-cc65-460c-991c-07013765f6a0",
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
      "id": "1a724a34-f7ae-4634-9e43-01c0427b0c93",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-19T09:22:00.529355+00:00",
        "updated_at": "2024-08-19T09:22:00.564175+00:00",
        "menu_id": "9b4bb60b-cc65-460c-991c-07013765f6a0",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a7638715-6be6-4db3-8b36-09de2184d75f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a7638715-6be6-4db3-8b36-09de2184d75f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-19T09:22:01.116299+00:00",
      "updated_at": "2024-08-19T09:22:01.116299+00:00",
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