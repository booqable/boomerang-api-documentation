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
      "id": "b5624189-4049-45cd-b024-dc86157db659",
      "type": "menus",
      "attributes": {
        "created_at": "2024-09-30T09:22:57.166761+00:00",
        "updated_at": "2024-09-30T09:22:57.166761+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1afb9c4e-fe4c-4392-abdb-e9237e85ce12?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1afb9c4e-fe4c-4392-abdb-e9237e85ce12",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-30T09:22:54.361787+00:00",
      "updated_at": "2024-09-30T09:22:54.361787+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1ea80655-5c7b-4db7-af37-c5d47843adf0"
          },
          {
            "type": "menu_items",
            "id": "124de854-c069-4f8f-8346-b2be10516581"
          },
          {
            "type": "menu_items",
            "id": "77ec7947-f7fa-4ae0-81a0-60767a994662"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1ea80655-5c7b-4db7-af37-c5d47843adf0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:54.363670+00:00",
        "updated_at": "2024-09-30T09:22:54.363670+00:00",
        "menu_id": "1afb9c4e-fe4c-4392-abdb-e9237e85ce12",
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
      "id": "124de854-c069-4f8f-8346-b2be10516581",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:54.365650+00:00",
        "updated_at": "2024-09-30T09:22:54.365650+00:00",
        "menu_id": "1afb9c4e-fe4c-4392-abdb-e9237e85ce12",
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
      "id": "77ec7947-f7fa-4ae0-81a0-60767a994662",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:54.367272+00:00",
        "updated_at": "2024-09-30T09:22:54.367272+00:00",
        "menu_id": "1afb9c4e-fe4c-4392-abdb-e9237e85ce12",
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
    "id": "6d232ad4-edff-4348-9e95-4c9310cbf7a9",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-30T09:22:56.196522+00:00",
      "updated_at": "2024-09-30T09:22:56.196522+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f61cd81e-0ae5-4295-83dd-78570c997465' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "f61cd81e-0ae5-4295-83dd-78570c997465",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "62141957-91bf-4562-ba33-55da29b4c702",
              "title": "Contact us"
            },
            {
              "id": "d219fda8-bd8d-4789-b6a6-82b34daed5be",
              "title": "Start"
            },
            {
              "id": "b3c30952-0863-4d4b-9f59-b6e766d7ba57",
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
    "id": "f61cd81e-0ae5-4295-83dd-78570c997465",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-30T09:22:56.678939+00:00",
      "updated_at": "2024-09-30T09:22:56.719103+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "62141957-91bf-4562-ba33-55da29b4c702"
          },
          {
            "type": "menu_items",
            "id": "d219fda8-bd8d-4789-b6a6-82b34daed5be"
          },
          {
            "type": "menu_items",
            "id": "b3c30952-0863-4d4b-9f59-b6e766d7ba57"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "62141957-91bf-4562-ba33-55da29b4c702",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:56.680928+00:00",
        "updated_at": "2024-09-30T09:22:56.721084+00:00",
        "menu_id": "f61cd81e-0ae5-4295-83dd-78570c997465",
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
      "id": "d219fda8-bd8d-4789-b6a6-82b34daed5be",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:56.683232+00:00",
        "updated_at": "2024-09-30T09:22:56.722719+00:00",
        "menu_id": "f61cd81e-0ae5-4295-83dd-78570c997465",
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
      "id": "b3c30952-0863-4d4b-9f59-b6e766d7ba57",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-09-30T09:22:56.684903+00:00",
        "updated_at": "2024-09-30T09:22:56.724185+00:00",
        "menu_id": "f61cd81e-0ae5-4295-83dd-78570c997465",
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
    --url 'https://example.booqable.com/api/boomerang/menus/388b8e59-b970-41c9-9493-5d4431f0023c' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "388b8e59-b970-41c9-9493-5d4431f0023c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-09-30T09:22:53.112683+00:00",
      "updated_at": "2024-09-30T09:22:53.112683+00:00",
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