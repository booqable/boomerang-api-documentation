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
      "id": "79d736eb-493f-4e46-87c7-985368bbe3a5",
      "type": "menus",
      "attributes": {
        "created_at": "2024-11-11T09:26:36.445466+00:00",
        "updated_at": "2024-11-11T09:26:36.445466+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/36975e50-16eb-4464-bdc7-4ed085dd33df?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "36975e50-16eb-4464-bdc7-4ed085dd33df",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-11T09:26:37.513822+00:00",
      "updated_at": "2024-11-11T09:26:37.513822+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7efdcc74-822f-4614-bc75-7c03ac7c0275"
          },
          {
            "type": "menu_items",
            "id": "229ff596-8f36-4168-a696-1b5ee536cdc5"
          },
          {
            "type": "menu_items",
            "id": "78a40801-4c18-44b6-937c-60f2eff05fcc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7efdcc74-822f-4614-bc75-7c03ac7c0275",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:37.515517+00:00",
        "updated_at": "2024-11-11T09:26:37.515517+00:00",
        "menu_id": "36975e50-16eb-4464-bdc7-4ed085dd33df",
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
      "id": "229ff596-8f36-4168-a696-1b5ee536cdc5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:37.517351+00:00",
        "updated_at": "2024-11-11T09:26:37.517351+00:00",
        "menu_id": "36975e50-16eb-4464-bdc7-4ed085dd33df",
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
      "id": "78a40801-4c18-44b6-937c-60f2eff05fcc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:37.518832+00:00",
        "updated_at": "2024-11-11T09:26:37.518832+00:00",
        "menu_id": "36975e50-16eb-4464-bdc7-4ed085dd33df",
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
    "id": "859adcc8-420e-4516-b66a-db9af038b24b",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-11T09:26:36.958095+00:00",
      "updated_at": "2024-11-11T09:26:36.958095+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/5e6718fe-5126-4155-87f3-5f13b3c3dd82' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "5e6718fe-5126-4155-87f3-5f13b3c3dd82",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "896cef71-090b-40f6-a405-20f6353a3a8b",
              "title": "Contact us"
            },
            {
              "id": "fd3c5a3d-aa61-463d-b24c-9367d5b3b918",
              "title": "Start"
            },
            {
              "id": "da135f2c-12d6-4d86-9b7e-f8efabb27afe",
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
    "id": "5e6718fe-5126-4155-87f3-5f13b3c3dd82",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-11T09:26:35.902394+00:00",
      "updated_at": "2024-11-11T09:26:35.941780+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "896cef71-090b-40f6-a405-20f6353a3a8b"
          },
          {
            "type": "menu_items",
            "id": "fd3c5a3d-aa61-463d-b24c-9367d5b3b918"
          },
          {
            "type": "menu_items",
            "id": "da135f2c-12d6-4d86-9b7e-f8efabb27afe"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "896cef71-090b-40f6-a405-20f6353a3a8b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:35.904172+00:00",
        "updated_at": "2024-11-11T09:26:35.943883+00:00",
        "menu_id": "5e6718fe-5126-4155-87f3-5f13b3c3dd82",
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
      "id": "fd3c5a3d-aa61-463d-b24c-9367d5b3b918",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:35.906038+00:00",
        "updated_at": "2024-11-11T09:26:35.945778+00:00",
        "menu_id": "5e6718fe-5126-4155-87f3-5f13b3c3dd82",
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
      "id": "da135f2c-12d6-4d86-9b7e-f8efabb27afe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-11-11T09:26:35.907505+00:00",
        "updated_at": "2024-11-11T09:26:35.947064+00:00",
        "menu_id": "5e6718fe-5126-4155-87f3-5f13b3c3dd82",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a36c181b-b8b4-43be-bcd1-c681adbef9f1' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a36c181b-b8b4-43be-bcd1-c681adbef9f1",
    "type": "menus",
    "attributes": {
      "created_at": "2024-11-11T09:26:38.909636+00:00",
      "updated_at": "2024-11-11T09:26:38.909636+00:00",
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