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
      "id": "441ba438-2e1f-44d6-a7e3-d20c89d8bae5",
      "type": "menus",
      "attributes": {
        "created_at": "2024-10-14T09:24:59.562537+00:00",
        "updated_at": "2024-10-14T09:24:59.562537+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8b6ecae3-d27d-4d29-be41-4f68bac2fa37?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8b6ecae3-d27d-4d29-be41-4f68bac2fa37",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-14T09:25:00.004264+00:00",
      "updated_at": "2024-10-14T09:25:00.004264+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "21013236-cf9e-47ed-9006-fa89146a7de7"
          },
          {
            "type": "menu_items",
            "id": "5a19f80d-1071-4788-a3f0-5a6b49a6c826"
          },
          {
            "type": "menu_items",
            "id": "8d9182d6-995d-4527-a672-261594e75eea"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "21013236-cf9e-47ed-9006-fa89146a7de7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:00.005534+00:00",
        "updated_at": "2024-10-14T09:25:00.005534+00:00",
        "menu_id": "8b6ecae3-d27d-4d29-be41-4f68bac2fa37",
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
      "id": "5a19f80d-1071-4788-a3f0-5a6b49a6c826",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:00.007005+00:00",
        "updated_at": "2024-10-14T09:25:00.007005+00:00",
        "menu_id": "8b6ecae3-d27d-4d29-be41-4f68bac2fa37",
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
      "id": "8d9182d6-995d-4527-a672-261594e75eea",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:00.009000+00:00",
        "updated_at": "2024-10-14T09:25:00.009000+00:00",
        "menu_id": "8b6ecae3-d27d-4d29-be41-4f68bac2fa37",
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
    "id": "971f58fe-2da2-49c2-9de0-db4407009e65",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-14T09:25:00.467356+00:00",
      "updated_at": "2024-10-14T09:25:00.467356+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a4873557-fce9-42c1-be45-58470ac7acd3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a4873557-fce9-42c1-be45-58470ac7acd3",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d6ef88f8-61ce-49c9-8709-58ff31a4477c",
              "title": "Contact us"
            },
            {
              "id": "f27ecf72-ec11-499a-9ae9-b3aa4327e7ba",
              "title": "Start"
            },
            {
              "id": "4b9a26f5-1509-4e49-a764-987d4b90990c",
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
    "id": "a4873557-fce9-42c1-be45-58470ac7acd3",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-14T09:25:01.331548+00:00",
      "updated_at": "2024-10-14T09:25:01.361409+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d6ef88f8-61ce-49c9-8709-58ff31a4477c"
          },
          {
            "type": "menu_items",
            "id": "f27ecf72-ec11-499a-9ae9-b3aa4327e7ba"
          },
          {
            "type": "menu_items",
            "id": "4b9a26f5-1509-4e49-a764-987d4b90990c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d6ef88f8-61ce-49c9-8709-58ff31a4477c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:01.332805+00:00",
        "updated_at": "2024-10-14T09:25:01.362853+00:00",
        "menu_id": "a4873557-fce9-42c1-be45-58470ac7acd3",
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
      "id": "f27ecf72-ec11-499a-9ae9-b3aa4327e7ba",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:01.334336+00:00",
        "updated_at": "2024-10-14T09:25:01.364213+00:00",
        "menu_id": "a4873557-fce9-42c1-be45-58470ac7acd3",
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
      "id": "4b9a26f5-1509-4e49-a764-987d4b90990c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-14T09:25:01.335562+00:00",
        "updated_at": "2024-10-14T09:25:01.365453+00:00",
        "menu_id": "a4873557-fce9-42c1-be45-58470ac7acd3",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9a1e8d26-7a69-427a-adcc-0ff682f8387b' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9a1e8d26-7a69-427a-adcc-0ff682f8387b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-14T09:25:00.888725+00:00",
      "updated_at": "2024-10-14T09:25:00.888725+00:00",
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