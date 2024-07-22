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
      "id": "0fcd5274-af42-43e6-be9b-a15ab2762f94",
      "type": "menus",
      "attributes": {
        "created_at": "2024-07-22T09:27:50.598522+00:00",
        "updated_at": "2024-07-22T09:27:50.598522+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7ddeefd3-dcda-4063-aef6-c4ce846c276c?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7ddeefd3-dcda-4063-aef6-c4ce846c276c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-22T09:27:51.270634+00:00",
      "updated_at": "2024-07-22T09:27:51.270634+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "290d97a4-54d3-4f8c-a531-2b697c293923"
          },
          {
            "type": "menu_items",
            "id": "96fa83fb-8f9a-41c3-8664-5050c6144b3b"
          },
          {
            "type": "menu_items",
            "id": "ed3a3da7-3766-4c9b-8ee7-319433360cf7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "290d97a4-54d3-4f8c-a531-2b697c293923",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:51.273824+00:00",
        "updated_at": "2024-07-22T09:27:51.273824+00:00",
        "menu_id": "7ddeefd3-dcda-4063-aef6-c4ce846c276c",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "96fa83fb-8f9a-41c3-8664-5050c6144b3b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:51.277211+00:00",
        "updated_at": "2024-07-22T09:27:51.277211+00:00",
        "menu_id": "7ddeefd3-dcda-4063-aef6-c4ce846c276c",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "ed3a3da7-3766-4c9b-8ee7-319433360cf7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:51.280369+00:00",
        "updated_at": "2024-07-22T09:27:51.280369+00:00",
        "menu_id": "7ddeefd3-dcda-4063-aef6-c4ce846c276c",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
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
    "id": "203c5ac6-5258-4b78-8ec4-85508b01a30f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-22T09:27:49.877336+00:00",
      "updated_at": "2024-07-22T09:27:49.877336+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/97f59dcf-a781-4b33-a7fd-5a966e3c9666' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97f59dcf-a781-4b33-a7fd-5a966e3c9666",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "2fdc6649-0f09-4f77-8787-62810538bdfa",
              "title": "Contact us"
            },
            {
              "id": "e569a470-efcf-49e5-85ac-62fe89a2ba1b",
              "title": "Start"
            },
            {
              "id": "06868092-4069-44e9-964d-bbfa09835583",
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
    "id": "97f59dcf-a781-4b33-a7fd-5a966e3c9666",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-22T09:27:48.991374+00:00",
      "updated_at": "2024-07-22T09:27:49.050657+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2fdc6649-0f09-4f77-8787-62810538bdfa"
          },
          {
            "type": "menu_items",
            "id": "e569a470-efcf-49e5-85ac-62fe89a2ba1b"
          },
          {
            "type": "menu_items",
            "id": "06868092-4069-44e9-964d-bbfa09835583"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2fdc6649-0f09-4f77-8787-62810538bdfa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:48.994025+00:00",
        "updated_at": "2024-07-22T09:27:49.053813+00:00",
        "menu_id": "97f59dcf-a781-4b33-a7fd-5a966e3c9666",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "e569a470-efcf-49e5-85ac-62fe89a2ba1b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:48.996897+00:00",
        "updated_at": "2024-07-22T09:27:49.056836+00:00",
        "menu_id": "97f59dcf-a781-4b33-a7fd-5a966e3c9666",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {}
    },
    {
      "id": "06868092-4069-44e9-964d-bbfa09835583",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-22T09:27:48.999439+00:00",
        "updated_at": "2024-07-22T09:27:49.059677+00:00",
        "menu_id": "97f59dcf-a781-4b33-a7fd-5a966e3c9666",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
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
    --url 'https://example.booqable.com/api/boomerang/menus/bee499f5-169e-475d-afb1-01522511593d' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bee499f5-169e-475d-afb1-01522511593d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-22T09:27:48.315889+00:00",
      "updated_at": "2024-07-22T09:27:48.315889+00:00",
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