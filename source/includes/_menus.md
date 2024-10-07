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
      "id": "c95345cb-c35e-4701-9b5c-61d722c0c2b7",
      "type": "menus",
      "attributes": {
        "created_at": "2024-10-07T09:28:18.392789+00:00",
        "updated_at": "2024-10-07T09:28:18.392789+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b03827fd-776a-48bf-b3bd-7265e3748125?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b03827fd-776a-48bf-b3bd-7265e3748125",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-07T09:28:20.491117+00:00",
      "updated_at": "2024-10-07T09:28:20.491117+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "80d6c284-3053-458e-af37-3dd6b456a21e"
          },
          {
            "type": "menu_items",
            "id": "58613ee6-2922-417e-9bc8-b37aa08ffbbf"
          },
          {
            "type": "menu_items",
            "id": "b98399f9-31f8-40e1-9d96-da9fda7ad343"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "80d6c284-3053-458e-af37-3dd6b456a21e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:20.492792+00:00",
        "updated_at": "2024-10-07T09:28:20.492792+00:00",
        "menu_id": "b03827fd-776a-48bf-b3bd-7265e3748125",
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
      "id": "58613ee6-2922-417e-9bc8-b37aa08ffbbf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:20.494432+00:00",
        "updated_at": "2024-10-07T09:28:20.494432+00:00",
        "menu_id": "b03827fd-776a-48bf-b3bd-7265e3748125",
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
      "id": "b98399f9-31f8-40e1-9d96-da9fda7ad343",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:20.495837+00:00",
        "updated_at": "2024-10-07T09:28:20.495837+00:00",
        "menu_id": "b03827fd-776a-48bf-b3bd-7265e3748125",
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
    "id": "483c25ef-449e-4d21-b65d-fa676bc7e970",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-07T09:28:18.929021+00:00",
      "updated_at": "2024-10-07T09:28:18.929021+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a57da426-4355-481f-898f-50b0adff62f4' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a57da426-4355-481f-898f-50b0adff62f4",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dcc129b2-9c6f-43e2-88da-8c1964dd44c6",
              "title": "Contact us"
            },
            {
              "id": "27078b09-ba5f-459e-b589-fa03a0ef2073",
              "title": "Start"
            },
            {
              "id": "17189b4a-2fdf-4977-984b-7ed0d8febf79",
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
    "id": "a57da426-4355-481f-898f-50b0adff62f4",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-07T09:28:19.419169+00:00",
      "updated_at": "2024-10-07T09:28:19.452613+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dcc129b2-9c6f-43e2-88da-8c1964dd44c6"
          },
          {
            "type": "menu_items",
            "id": "27078b09-ba5f-459e-b589-fa03a0ef2073"
          },
          {
            "type": "menu_items",
            "id": "17189b4a-2fdf-4977-984b-7ed0d8febf79"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dcc129b2-9c6f-43e2-88da-8c1964dd44c6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:19.420847+00:00",
        "updated_at": "2024-10-07T09:28:19.454512+00:00",
        "menu_id": "a57da426-4355-481f-898f-50b0adff62f4",
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
      "id": "27078b09-ba5f-459e-b589-fa03a0ef2073",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:19.422517+00:00",
        "updated_at": "2024-10-07T09:28:19.456204+00:00",
        "menu_id": "a57da426-4355-481f-898f-50b0adff62f4",
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
      "id": "17189b4a-2fdf-4977-984b-7ed0d8febf79",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-10-07T09:28:19.424033+00:00",
        "updated_at": "2024-10-07T09:28:19.457732+00:00",
        "menu_id": "a57da426-4355-481f-898f-50b0adff62f4",
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
    --url 'https://example.booqable.com/api/boomerang/menus/be32dbb3-c07c-4063-92b4-06a15beb4ec3' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "be32dbb3-c07c-4063-92b4-06a15beb4ec3",
    "type": "menus",
    "attributes": {
      "created_at": "2024-10-07T09:28:19.934844+00:00",
      "updated_at": "2024-10-07T09:28:19.934844+00:00",
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