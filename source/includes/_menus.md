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
      "id": "6ef9c9be-44e8-4fca-80c2-8f1c422b2f72",
      "type": "menus",
      "attributes": {
        "created_at": "2024-08-12T09:24:14.937737+00:00",
        "updated_at": "2024-08-12T09:24:14.937737+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/79c1ec28-2983-4e89-8427-cd9bc604bd30?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "79c1ec28-2983-4e89-8427-cd9bc604bd30",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-12T09:24:13.527227+00:00",
      "updated_at": "2024-08-12T09:24:13.527227+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "04211e44-7b1c-41f5-b90c-97c7a3bfbc87"
          },
          {
            "type": "menu_items",
            "id": "e5ccf9e7-8c22-401a-902d-c151694cb0f0"
          },
          {
            "type": "menu_items",
            "id": "8f8c0d4c-e334-423f-b0e4-051aa0602ce2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "04211e44-7b1c-41f5-b90c-97c7a3bfbc87",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:13.529821+00:00",
        "updated_at": "2024-08-12T09:24:13.529821+00:00",
        "menu_id": "79c1ec28-2983-4e89-8427-cd9bc604bd30",
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
      "id": "e5ccf9e7-8c22-401a-902d-c151694cb0f0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:13.532872+00:00",
        "updated_at": "2024-08-12T09:24:13.532872+00:00",
        "menu_id": "79c1ec28-2983-4e89-8427-cd9bc604bd30",
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
      "id": "8f8c0d4c-e334-423f-b0e4-051aa0602ce2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:13.535655+00:00",
        "updated_at": "2024-08-12T09:24:13.535655+00:00",
        "menu_id": "79c1ec28-2983-4e89-8427-cd9bc604bd30",
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
    "id": "6a7e055b-45e7-45ca-898b-9f053475a745",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-12T09:24:12.926638+00:00",
      "updated_at": "2024-08-12T09:24:12.926638+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b88ffde2-9e23-4923-b95f-0a80e852cf98' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b88ffde2-9e23-4923-b95f-0a80e852cf98",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c697cdb6-c870-4d22-a0bd-3b37015b3afd",
              "title": "Contact us"
            },
            {
              "id": "c12f33a8-e1c1-4135-b38d-7d313c20449e",
              "title": "Start"
            },
            {
              "id": "6ae21af8-0473-49b2-b66c-a256699f7629",
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
    "id": "b88ffde2-9e23-4923-b95f-0a80e852cf98",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-12T09:24:14.179214+00:00",
      "updated_at": "2024-08-12T09:24:14.234910+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c697cdb6-c870-4d22-a0bd-3b37015b3afd"
          },
          {
            "type": "menu_items",
            "id": "c12f33a8-e1c1-4135-b38d-7d313c20449e"
          },
          {
            "type": "menu_items",
            "id": "6ae21af8-0473-49b2-b66c-a256699f7629"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c697cdb6-c870-4d22-a0bd-3b37015b3afd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:14.181025+00:00",
        "updated_at": "2024-08-12T09:24:14.237228+00:00",
        "menu_id": "b88ffde2-9e23-4923-b95f-0a80e852cf98",
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
      "id": "c12f33a8-e1c1-4135-b38d-7d313c20449e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:14.182756+00:00",
        "updated_at": "2024-08-12T09:24:14.238947+00:00",
        "menu_id": "b88ffde2-9e23-4923-b95f-0a80e852cf98",
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
      "id": "6ae21af8-0473-49b2-b66c-a256699f7629",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-12T09:24:14.184565+00:00",
        "updated_at": "2024-08-12T09:24:14.240568+00:00",
        "menu_id": "b88ffde2-9e23-4923-b95f-0a80e852cf98",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5f002680-5af3-4b88-9895-a029dbd8b926' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5f002680-5af3-4b88-9895-a029dbd8b926",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-12T09:24:12.107876+00:00",
      "updated_at": "2024-08-12T09:24:12.107876+00:00",
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