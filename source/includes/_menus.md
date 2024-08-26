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
      "id": "e9c04734-f307-4409-8234-c15bea9b714d",
      "type": "menus",
      "attributes": {
        "created_at": "2024-08-26T09:24:42.318732+00:00",
        "updated_at": "2024-08-26T09:24:42.318732+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fb9ed506-a033-4f5d-94c9-4f0129cdc872?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fb9ed506-a033-4f5d-94c9-4f0129cdc872",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-26T09:24:40.876961+00:00",
      "updated_at": "2024-08-26T09:24:40.876961+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8dbfed9f-8a80-4095-9f6a-10573d3f85eb"
          },
          {
            "type": "menu_items",
            "id": "23a6557a-e3f3-41b2-bc9f-7cc5da137b3b"
          },
          {
            "type": "menu_items",
            "id": "6d941a7d-7d43-4094-b57c-19fbee146c2f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8dbfed9f-8a80-4095-9f6a-10573d3f85eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:40.879196+00:00",
        "updated_at": "2024-08-26T09:24:40.879196+00:00",
        "menu_id": "fb9ed506-a033-4f5d-94c9-4f0129cdc872",
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
      "id": "23a6557a-e3f3-41b2-bc9f-7cc5da137b3b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:40.881776+00:00",
        "updated_at": "2024-08-26T09:24:40.881776+00:00",
        "menu_id": "fb9ed506-a033-4f5d-94c9-4f0129cdc872",
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
      "id": "6d941a7d-7d43-4094-b57c-19fbee146c2f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:40.884086+00:00",
        "updated_at": "2024-08-26T09:24:40.884086+00:00",
        "menu_id": "fb9ed506-a033-4f5d-94c9-4f0129cdc872",
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
    "id": "57299b8e-2bca-4b57-9ecc-0b53816d5cbd",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-26T09:24:40.210275+00:00",
      "updated_at": "2024-08-26T09:24:40.210275+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6fe07647-b721-497b-90d4-ad2dc7db001b' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6fe07647-b721-497b-90d4-ad2dc7db001b",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "4cb6fce2-3e9a-4b9d-b811-32427cdbca4a",
              "title": "Contact us"
            },
            {
              "id": "a6e6658b-c060-4470-9f8d-5198ce9c9eb8",
              "title": "Start"
            },
            {
              "id": "ca0c450d-2854-478c-bcbb-5c2df15734bc",
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
    "id": "6fe07647-b721-497b-90d4-ad2dc7db001b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-26T09:24:41.563485+00:00",
      "updated_at": "2024-08-26T09:24:41.635934+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "4cb6fce2-3e9a-4b9d-b811-32427cdbca4a"
          },
          {
            "type": "menu_items",
            "id": "a6e6658b-c060-4470-9f8d-5198ce9c9eb8"
          },
          {
            "type": "menu_items",
            "id": "ca0c450d-2854-478c-bcbb-5c2df15734bc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4cb6fce2-3e9a-4b9d-b811-32427cdbca4a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:41.566508+00:00",
        "updated_at": "2024-08-26T09:24:41.639486+00:00",
        "menu_id": "6fe07647-b721-497b-90d4-ad2dc7db001b",
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
      "id": "a6e6658b-c060-4470-9f8d-5198ce9c9eb8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:41.569758+00:00",
        "updated_at": "2024-08-26T09:24:41.642834+00:00",
        "menu_id": "6fe07647-b721-497b-90d4-ad2dc7db001b",
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
      "id": "ca0c450d-2854-478c-bcbb-5c2df15734bc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-08-26T09:24:41.572695+00:00",
        "updated_at": "2024-08-26T09:24:41.645981+00:00",
        "menu_id": "6fe07647-b721-497b-90d4-ad2dc7db001b",
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
    --url 'https://example.booqable.com/api/boomerang/menus/15581718-2ed5-4872-a29a-50fbe5f0519f' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "15581718-2ed5-4872-a29a-50fbe5f0519f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-08-26T09:24:43.012621+00:00",
      "updated_at": "2024-08-26T09:24:43.012621+00:00",
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