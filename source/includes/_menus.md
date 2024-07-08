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
      "id": "f1278a4e-d262-4144-81e0-ac3d097b4212",
      "type": "menus",
      "attributes": {
        "created_at": "2024-07-08T09:24:08.671588+00:00",
        "updated_at": "2024-07-08T09:24:08.671588+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/e3bf5251-998b-4a2d-94ad-14dabf10c1cb?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e3bf5251-998b-4a2d-94ad-14dabf10c1cb",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-08T09:24:02.242938+00:00",
      "updated_at": "2024-07-08T09:24:02.242938+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "56ded504-a4ef-42a7-a489-c21804463c0b"
          },
          {
            "type": "menu_items",
            "id": "7e712244-d6d8-45f0-a126-be6d3bb6fe7e"
          },
          {
            "type": "menu_items",
            "id": "f1619d04-e6bc-47fb-9072-a2588fa8239a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "56ded504-a4ef-42a7-a489-c21804463c0b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:02.246679+00:00",
        "updated_at": "2024-07-08T09:24:02.246679+00:00",
        "menu_id": "e3bf5251-998b-4a2d-94ad-14dabf10c1cb",
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
      "id": "7e712244-d6d8-45f0-a126-be6d3bb6fe7e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:02.250589+00:00",
        "updated_at": "2024-07-08T09:24:02.250589+00:00",
        "menu_id": "e3bf5251-998b-4a2d-94ad-14dabf10c1cb",
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
      "id": "f1619d04-e6bc-47fb-9072-a2588fa8239a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:02.254510+00:00",
        "updated_at": "2024-07-08T09:24:02.254510+00:00",
        "menu_id": "e3bf5251-998b-4a2d-94ad-14dabf10c1cb",
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
    "id": "ef171f61-84f8-4e32-9727-0b3d3dc0921c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-08T09:24:03.454898+00:00",
      "updated_at": "2024-07-08T09:24:03.454898+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dca01d9f-50c4-4b92-942e-195f80a53e91' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dca01d9f-50c4-4b92-942e-195f80a53e91",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "65e21453-4f3b-4846-afc8-0cc1160b0754",
              "title": "Contact us"
            },
            {
              "id": "c1638176-0d54-498f-8be5-ee18dede518a",
              "title": "Start"
            },
            {
              "id": "3b0f8418-185c-4c74-a118-5e99ca33cd53",
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
    "id": "dca01d9f-50c4-4b92-942e-195f80a53e91",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-08T09:24:04.819684+00:00",
      "updated_at": "2024-07-08T09:24:04.929604+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "65e21453-4f3b-4846-afc8-0cc1160b0754"
          },
          {
            "type": "menu_items",
            "id": "c1638176-0d54-498f-8be5-ee18dede518a"
          },
          {
            "type": "menu_items",
            "id": "3b0f8418-185c-4c74-a118-5e99ca33cd53"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65e21453-4f3b-4846-afc8-0cc1160b0754",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:04.825135+00:00",
        "updated_at": "2024-07-08T09:24:04.935559+00:00",
        "menu_id": "dca01d9f-50c4-4b92-942e-195f80a53e91",
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
      "id": "c1638176-0d54-498f-8be5-ee18dede518a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:04.831756+00:00",
        "updated_at": "2024-07-08T09:24:04.941320+00:00",
        "menu_id": "dca01d9f-50c4-4b92-942e-195f80a53e91",
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
      "id": "3b0f8418-185c-4c74-a118-5e99ca33cd53",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-08T09:24:04.838659+00:00",
        "updated_at": "2024-07-08T09:24:04.945914+00:00",
        "menu_id": "dca01d9f-50c4-4b92-942e-195f80a53e91",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2d85b9bb-37ac-4534-8ac0-86a4a31905a6' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "2d85b9bb-37ac-4534-8ac0-86a4a31905a6",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-08T09:24:05.776196+00:00",
      "updated_at": "2024-07-08T09:24:05.776196+00:00",
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