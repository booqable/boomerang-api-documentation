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
- | -
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
- | -
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
      "id": "ceb1e5d4-a682-45f5-9f48-17609e8846bd",
      "type": "menus",
      "attributes": {
        "created_at": "2022-08-19T07:57:27+00:00",
        "updated_at": "2022-08-19T07:57:27+00:00",
        "title": "Main menu",
        "key": "main-menu"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ceb1e5d4-a682-45f5-9f48-17609e8846bd"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-08-19T07:55:05Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/136e767c-0c42-4c71-9128-43143db8c394?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "136e767c-0c42-4c71-9128-43143db8c394",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-19T07:57:27+00:00",
      "updated_at": "2022-08-19T07:57:27+00:00",
      "title": "Main menu",
      "key": "main-menu"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=136e767c-0c42-4c71-9128-43143db8c394"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "3fdff035-b265-4c91-b09a-99d21473d8a5"
          },
          {
            "type": "menu_items",
            "id": "c44d9fc0-914f-4e1a-83b1-6ed601246e9c"
          },
          {
            "type": "menu_items",
            "id": "ec92f2b8-56dc-49be-a645-29ed6dfdaaab"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "3fdff035-b265-4c91-b09a-99d21473d8a5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:27+00:00",
        "updated_at": "2022-08-19T07:57:27+00:00",
        "menu_id": "136e767c-0c42-4c71-9128-43143db8c394",
        "parent_menu_item_id": null,
        "title": "About us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/136e767c-0c42-4c71-9128-43143db8c394"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3fdff035-b265-4c91-b09a-99d21473d8a5"
          }
        }
      }
    },
    {
      "id": "c44d9fc0-914f-4e1a-83b1-6ed601246e9c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:27+00:00",
        "updated_at": "2022-08-19T07:57:27+00:00",
        "menu_id": "136e767c-0c42-4c71-9128-43143db8c394",
        "parent_menu_item_id": null,
        "title": "Home",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/136e767c-0c42-4c71-9128-43143db8c394"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c44d9fc0-914f-4e1a-83b1-6ed601246e9c"
          }
        }
      }
    },
    {
      "id": "ec92f2b8-56dc-49be-a645-29ed6dfdaaab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:27+00:00",
        "updated_at": "2022-08-19T07:57:27+00:00",
        "menu_id": "136e767c-0c42-4c71-9128-43143db8c394",
        "parent_menu_item_id": null,
        "title": "Rentals",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "links": {
            "related": "api/boomerang/menus/136e767c-0c42-4c71-9128-43143db8c394"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ec92f2b8-56dc-49be-a645-29ed6dfdaaab"
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`GET /api/boomerang/menus/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "b9a31d98-7ca3-4429-a090-0c4a23fbb01b",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-19T07:57:27+00:00",
      "updated_at": "2022-08-19T07:57:27+00:00",
      "title": "Header menu",
      "key": "header-menu"
    },
    "relationships": {
      "menu_items": {
        "meta": {
          "included": false
        }
      }
    }
  },
  "meta": {}
}
```

### HTTP Request

`POST /api/boomerang/menus`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/d79dd433-aae6-4771-b51a-b7d7fb17a1b3' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "d79dd433-aae6-4771-b51a-b7d7fb17a1b3",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c891e716-1b5c-49bd-a702-b87e22298deb",
              "title": "Contact us"
            },
            {
              "id": "c8d0b74c-d4bc-447d-ab6d-b64f534496d7",
              "title": "Start"
            },
            {
              "id": "6f4ddf36-f597-42e1-983e-8486c46725e8",
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
    "id": "d79dd433-aae6-4771-b51a-b7d7fb17a1b3",
    "type": "menus",
    "attributes": {
      "created_at": "2022-08-19T07:57:28+00:00",
      "updated_at": "2022-08-19T07:57:28+00:00",
      "title": "Header menu",
      "key": "header-menu"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c891e716-1b5c-49bd-a702-b87e22298deb"
          },
          {
            "type": "menu_items",
            "id": "c8d0b74c-d4bc-447d-ab6d-b64f534496d7"
          },
          {
            "type": "menu_items",
            "id": "6f4ddf36-f597-42e1-983e-8486c46725e8"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c891e716-1b5c-49bd-a702-b87e22298deb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:28+00:00",
        "updated_at": "2022-08-19T07:57:28+00:00",
        "menu_id": "d79dd433-aae6-4771-b51a-b7d7fb17a1b3",
        "parent_menu_item_id": null,
        "title": "Contact us",
        "value": "/about-us",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "c8d0b74c-d4bc-447d-ab6d-b64f534496d7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:28+00:00",
        "updated_at": "2022-08-19T07:57:28+00:00",
        "menu_id": "d79dd433-aae6-4771-b51a-b7d7fb17a1b3",
        "parent_menu_item_id": null,
        "title": "Start",
        "value": "/",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    },
    {
      "id": "6f4ddf36-f597-42e1-983e-8486c46725e8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-08-19T07:57:28+00:00",
        "updated_at": "2022-08-19T07:57:28+00:00",
        "menu_id": "d79dd433-aae6-4771-b51a-b7d7fb17a1b3",
        "parent_menu_item_id": null,
        "title": "Rent from us",
        "value": "/products",
        "target_id": null,
        "target_type": "Static",
        "sorting_weight": null
      },
      "relationships": {
        "menu": {
          "meta": {
            "included": false
          }
        },
        "menu_items": {
          "meta": {
            "included": false
          }
        }
      }
    }
  ],
  "meta": {}
}
```

### HTTP Request

`PUT /api/boomerang/menus/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/68d9dd5f-881c-4719-aac1-f39dfdeee052' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "meta": {}
}
```

### HTTP Request

`DELETE /api/boomerang/menus/{id}`

### Request params

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes