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
      "id": "e880debc-68d1-4b79-9d64-a712eac42b42",
      "type": "menus",
      "attributes": {
        "created_at": "2024-10-28T09:25:29.717156+00:00",
        "updated_at": "2024-10-28T09:25:29.717156+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7745c341-b583-4149-8ff5-41ccc70281b3?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "7745c341-b583-4149-8ff5-41ccc70281b3",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-28T09:25:27.001339+00:00",
      "updated_at": "2024-10-28T09:25:27.001339+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "2755a102-cd13-45c5-adaa-790d16c61ea9"
          },
          {
            "type": "menu_items",
            "id": "7ecf04e7-6163-4341-87d6-527c7496b5f3"
          },
          {
            "type": "menu_items",
            "id": "44b003eb-a83b-471d-959b-a7f8c5c0b27e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "2755a102-cd13-45c5-adaa-790d16c61ea9",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:27.005480+00:00",
        "updated_at": "2024-10-28T09:25:27.005480+00:00",
        "menu_id": "7745c341-b583-4149-8ff5-41ccc70281b3",
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
      "id": "7ecf04e7-6163-4341-87d6-527c7496b5f3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:27.009556+00:00",
        "updated_at": "2024-10-28T09:25:27.009556+00:00",
        "menu_id": "7745c341-b583-4149-8ff5-41ccc70281b3",
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
      "id": "44b003eb-a83b-471d-959b-a7f8c5c0b27e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:27.011790+00:00",
        "updated_at": "2024-10-28T09:25:27.011790+00:00",
        "menu_id": "7745c341-b583-4149-8ff5-41ccc70281b3",
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
    "id": "e45853d8-3436-4d8d-9f35-a256bee5442f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-28T09:25:27.671937+00:00",
      "updated_at": "2024-10-28T09:25:27.671937+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/76939b2e-feb2-4bdf-be58-d09169b2a389' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "76939b2e-feb2-4bdf-be58-d09169b2a389",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d7bd8afc-36f3-45fb-ad47-b65826d68132",
              "title": "Contact us"
            },
            {
              "id": "3c97b2b3-4147-4b15-ab41-50889bba073f",
              "title": "Start"
            },
            {
              "id": "4fc48eb6-a344-4714-8b74-45bdd898a4a0",
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
    "id": "76939b2e-feb2-4bdf-be58-d09169b2a389",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-28T09:25:29.078889+00:00",
      "updated_at": "2024-10-28T09:25:29.130163+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d7bd8afc-36f3-45fb-ad47-b65826d68132"
          },
          {
            "type": "menu_items",
            "id": "3c97b2b3-4147-4b15-ab41-50889bba073f"
          },
          {
            "type": "menu_items",
            "id": "4fc48eb6-a344-4714-8b74-45bdd898a4a0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d7bd8afc-36f3-45fb-ad47-b65826d68132",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:29.080759+00:00",
        "updated_at": "2024-10-28T09:25:29.132229+00:00",
        "menu_id": "76939b2e-feb2-4bdf-be58-d09169b2a389",
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
      "id": "3c97b2b3-4147-4b15-ab41-50889bba073f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:29.083004+00:00",
        "updated_at": "2024-10-28T09:25:29.134948+00:00",
        "menu_id": "76939b2e-feb2-4bdf-be58-d09169b2a389",
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
      "id": "4fc48eb6-a344-4714-8b74-45bdd898a4a0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-28T09:25:29.084878+00:00",
        "updated_at": "2024-10-28T09:25:29.136631+00:00",
        "menu_id": "76939b2e-feb2-4bdf-be58-d09169b2a389",
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
    --url 'https://example.booqable.com/api/boomerang/menus/df2b7ace-ad74-44b2-b305-d7c35710cd71' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "df2b7ace-ad74-44b2-b305-d7c35710cd71",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-28T09:25:28.349456+00:00",
      "updated_at": "2024-10-28T09:25:28.349456+00:00",
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