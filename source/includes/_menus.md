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
      "id": "cf8d9a34-b3d2-4c9b-817c-b0cbb208f018",
      "type": "menus",
      "attributes": {
        "created_at": "2024-07-01T09:30:11.249346+00:00",
        "updated_at": "2024-07-01T09:30:11.249346+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f1059a4c-f533-4dae-a813-c5db977bb181?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f1059a4c-f533-4dae-a813-c5db977bb181",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-01T09:30:12.872198+00:00",
      "updated_at": "2024-07-01T09:30:12.872198+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7d97c35b-431c-41e7-9c1f-540cac1d6a1a"
          },
          {
            "type": "menu_items",
            "id": "09d04edc-8fae-4623-86fc-097d7975d596"
          },
          {
            "type": "menu_items",
            "id": "1980204d-0632-4a40-b3e1-9f390b1e2232"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7d97c35b-431c-41e7-9c1f-540cac1d6a1a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:12.877283+00:00",
        "updated_at": "2024-07-01T09:30:12.877283+00:00",
        "menu_id": "f1059a4c-f533-4dae-a813-c5db977bb181",
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
      "id": "09d04edc-8fae-4623-86fc-097d7975d596",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:12.884317+00:00",
        "updated_at": "2024-07-01T09:30:12.884317+00:00",
        "menu_id": "f1059a4c-f533-4dae-a813-c5db977bb181",
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
      "id": "1980204d-0632-4a40-b3e1-9f390b1e2232",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:12.891707+00:00",
        "updated_at": "2024-07-01T09:30:12.891707+00:00",
        "menu_id": "f1059a4c-f533-4dae-a813-c5db977bb181",
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
    "id": "526c5c8a-b427-4bc3-8417-fac94df196cf",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-01T09:30:12.186218+00:00",
      "updated_at": "2024-07-01T09:30:12.186218+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ccd13ba6-6ac2-4b31-bddb-554cba443f5a' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ccd13ba6-6ac2-4b31-bddb-554cba443f5a",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ff268d4a-3b7c-4ff2-8e74-f38b24470725",
              "title": "Contact us"
            },
            {
              "id": "c9af55d9-fbdc-4bcd-880b-f6812f4b01fa",
              "title": "Start"
            },
            {
              "id": "a57a6e1a-87d0-47d1-90c0-1fa80f6259fd",
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
    "id": "ccd13ba6-6ac2-4b31-bddb-554cba443f5a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-01T09:30:10.577166+00:00",
      "updated_at": "2024-07-01T09:30:10.644736+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ff268d4a-3b7c-4ff2-8e74-f38b24470725"
          },
          {
            "type": "menu_items",
            "id": "c9af55d9-fbdc-4bcd-880b-f6812f4b01fa"
          },
          {
            "type": "menu_items",
            "id": "a57a6e1a-87d0-47d1-90c0-1fa80f6259fd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ff268d4a-3b7c-4ff2-8e74-f38b24470725",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:10.580459+00:00",
        "updated_at": "2024-07-01T09:30:10.648220+00:00",
        "menu_id": "ccd13ba6-6ac2-4b31-bddb-554cba443f5a",
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
      "id": "c9af55d9-fbdc-4bcd-880b-f6812f4b01fa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:10.583779+00:00",
        "updated_at": "2024-07-01T09:30:10.651905+00:00",
        "menu_id": "ccd13ba6-6ac2-4b31-bddb-554cba443f5a",
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
      "id": "a57a6e1a-87d0-47d1-90c0-1fa80f6259fd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-07-01T09:30:10.586603+00:00",
        "updated_at": "2024-07-01T09:30:10.655459+00:00",
        "menu_id": "ccd13ba6-6ac2-4b31-bddb-554cba443f5a",
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
    --url 'https://example.booqable.com/api/boomerang/menus/535cc7ca-7e1b-41c0-8cda-3a0142359d69' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "535cc7ca-7e1b-41c0-8cda-3a0142359d69",
    "type": "menus",
    "attributes": {
      "created_at": "2024-07-01T09:30:13.657277+00:00",
      "updated_at": "2024-07-01T09:30:13.657277+00:00",
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