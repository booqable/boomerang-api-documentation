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
      "id": "97da11e8-2905-41c9-b1e3-484787140984",
      "type": "menus",
      "attributes": {
        "created_at": "2024-09-16T09:27:44.952124+00:00",
        "updated_at": "2024-09-16T09:27:44.952124+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1310c75c-9449-499a-ae1f-7923fec3aead?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1310c75c-9449-499a-ae1f-7923fec3aead",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-16T09:27:45.410187+00:00",
      "updated_at": "2024-09-16T09:27:45.410187+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "5bec7e96-9466-48d5-95cd-3f2fa392c4c9"
          },
          {
            "type": "menu_items",
            "id": "dc614e46-64db-4b10-8c31-2c54454aeb5c"
          },
          {
            "type": "menu_items",
            "id": "183cd66f-78a1-4dca-a3c9-d17f4d1d0872"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5bec7e96-9466-48d5-95cd-3f2fa392c4c9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.411845+00:00",
        "updated_at": "2024-09-16T09:27:45.411845+00:00",
        "menu_id": "1310c75c-9449-499a-ae1f-7923fec3aead",
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
      "id": "dc614e46-64db-4b10-8c31-2c54454aeb5c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.413647+00:00",
        "updated_at": "2024-09-16T09:27:45.413647+00:00",
        "menu_id": "1310c75c-9449-499a-ae1f-7923fec3aead",
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
      "id": "183cd66f-78a1-4dca-a3c9-d17f4d1d0872",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.415116+00:00",
        "updated_at": "2024-09-16T09:27:45.415116+00:00",
        "menu_id": "1310c75c-9449-499a-ae1f-7923fec3aead",
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
    "id": "f93796f1-4d35-45b5-80c8-4549fd1d1e19",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-16T09:27:46.405996+00:00",
      "updated_at": "2024-09-16T09:27:46.405996+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2496eb7c-0c6e-4824-aee5-61dcd7de2aea' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "2496eb7c-0c6e-4824-aee5-61dcd7de2aea",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d5b435cf-b4b6-4770-b471-7579f8a5fab6",
              "title": "Contact us"
            },
            {
              "id": "877090be-fe33-47a2-828c-48603b608566",
              "title": "Start"
            },
            {
              "id": "5e05fd07-14fa-4141-aac5-72c248c6e6b7",
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
    "id": "2496eb7c-0c6e-4824-aee5-61dcd7de2aea",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-16T09:27:45.880558+00:00",
      "updated_at": "2024-09-16T09:27:45.916771+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d5b435cf-b4b6-4770-b471-7579f8a5fab6"
          },
          {
            "type": "menu_items",
            "id": "877090be-fe33-47a2-828c-48603b608566"
          },
          {
            "type": "menu_items",
            "id": "5e05fd07-14fa-4141-aac5-72c248c6e6b7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d5b435cf-b4b6-4770-b471-7579f8a5fab6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.882396+00:00",
        "updated_at": "2024-09-16T09:27:45.918640+00:00",
        "menu_id": "2496eb7c-0c6e-4824-aee5-61dcd7de2aea",
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
      "id": "877090be-fe33-47a2-828c-48603b608566",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.884238+00:00",
        "updated_at": "2024-09-16T09:27:45.920395+00:00",
        "menu_id": "2496eb7c-0c6e-4824-aee5-61dcd7de2aea",
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
      "id": "5e05fd07-14fa-4141-aac5-72c248c6e6b7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-16T09:27:45.885808+00:00",
        "updated_at": "2024-09-16T09:27:45.921934+00:00",
        "menu_id": "2496eb7c-0c6e-4824-aee5-61dcd7de2aea",
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
    --url 'https://example.booqable.com/api/boomerang/menus/9b364157-76fb-477c-a924-1716bd2306dc' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9b364157-76fb-477c-a924-1716bd2306dc",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-16T09:27:46.891161+00:00",
      "updated_at": "2024-09-16T09:27:46.891161+00:00",
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