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
      "id": "e213535a-2756-4d9e-858d-8f10f35e840b",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T10:17:52+00:00",
        "updated_at": "2022-07-14T10:17:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e213535a-2756-4d9e-858d-8f10f35e840b"
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
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T10:15:47Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/f854d70c-9dd2-4c55-8cca-2d0bbbd8302e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "f854d70c-9dd2-4c55-8cca-2d0bbbd8302e",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:17:52+00:00",
      "updated_at": "2022-07-14T10:17:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=f854d70c-9dd2-4c55-8cca-2d0bbbd8302e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ab55b02a-fc87-4871-807e-b1a6ff6a33c0"
          },
          {
            "type": "menu_items",
            "id": "89318514-833a-4512-afa4-9c2b7d57ad04"
          },
          {
            "type": "menu_items",
            "id": "d84b799f-63b7-4e92-91b7-40305a3930b0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ab55b02a-fc87-4871-807e-b1a6ff6a33c0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:52+00:00",
        "updated_at": "2022-07-14T10:17:52+00:00",
        "menu_id": "f854d70c-9dd2-4c55-8cca-2d0bbbd8302e",
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
            "related": "api/boomerang/menus/f854d70c-9dd2-4c55-8cca-2d0bbbd8302e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ab55b02a-fc87-4871-807e-b1a6ff6a33c0"
          }
        }
      }
    },
    {
      "id": "89318514-833a-4512-afa4-9c2b7d57ad04",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:52+00:00",
        "updated_at": "2022-07-14T10:17:52+00:00",
        "menu_id": "f854d70c-9dd2-4c55-8cca-2d0bbbd8302e",
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
            "related": "api/boomerang/menus/f854d70c-9dd2-4c55-8cca-2d0bbbd8302e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=89318514-833a-4512-afa4-9c2b7d57ad04"
          }
        }
      }
    },
    {
      "id": "d84b799f-63b7-4e92-91b7-40305a3930b0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:52+00:00",
        "updated_at": "2022-07-14T10:17:52+00:00",
        "menu_id": "f854d70c-9dd2-4c55-8cca-2d0bbbd8302e",
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
            "related": "api/boomerang/menus/f854d70c-9dd2-4c55-8cca-2d0bbbd8302e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d84b799f-63b7-4e92-91b7-40305a3930b0"
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
    "id": "7dc9ebc1-f63c-4ea8-b90a-d4f299296c52",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:17:52+00:00",
      "updated_at": "2022-07-14T10:17:52+00:00",
      "title": "Header menu",
      "key": "header"
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
    --url 'https://example.booqable.com/api/boomerang/menus/49832058-7778-4f8b-ae46-ded2aaee28af' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "49832058-7778-4f8b-ae46-ded2aaee28af",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ebd06f21-c686-4f60-b97b-8e82b2fb8e00",
              "title": "Contact us"
            },
            {
              "id": "b0b841cc-39f6-47e3-a625-ea1b0b21c541",
              "title": "Start"
            },
            {
              "id": "a7cc0cb0-8cd6-43d8-91e7-700e0d4c54e6",
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
    "id": "49832058-7778-4f8b-ae46-ded2aaee28af",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T10:17:53+00:00",
      "updated_at": "2022-07-14T10:17:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ebd06f21-c686-4f60-b97b-8e82b2fb8e00"
          },
          {
            "type": "menu_items",
            "id": "b0b841cc-39f6-47e3-a625-ea1b0b21c541"
          },
          {
            "type": "menu_items",
            "id": "a7cc0cb0-8cd6-43d8-91e7-700e0d4c54e6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ebd06f21-c686-4f60-b97b-8e82b2fb8e00",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:53+00:00",
        "updated_at": "2022-07-14T10:17:53+00:00",
        "menu_id": "49832058-7778-4f8b-ae46-ded2aaee28af",
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
      "id": "b0b841cc-39f6-47e3-a625-ea1b0b21c541",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:53+00:00",
        "updated_at": "2022-07-14T10:17:53+00:00",
        "menu_id": "49832058-7778-4f8b-ae46-ded2aaee28af",
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
      "id": "a7cc0cb0-8cd6-43d8-91e7-700e0d4c54e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T10:17:53+00:00",
        "updated_at": "2022-07-14T10:17:53+00:00",
        "menu_id": "49832058-7778-4f8b-ae46-ded2aaee28af",
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
    --url 'https://example.booqable.com/api/boomerang/menus/49dc7cee-76d9-477a-b9fc-16d88bca9536' \
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