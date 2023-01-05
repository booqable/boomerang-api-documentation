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
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
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
      "id": "d52bb2e0-2dd9-4831-b3b8-52fca75294a5",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-05T09:56:24+00:00",
        "updated_at": "2023-01-05T09:56:24+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=d52bb2e0-2dd9-4831-b3b8-52fca75294a5"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-05T09:54:40Z`
`sort` | **String** <br>How to sort the data `?sort=-created_at`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array** <br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T09:56:24+00:00",
      "updated_at": "2023-01-05T09:56:24+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "02efb5e0-0bb4-4c82-a575-16718e5bd79e"
          },
          {
            "type": "menu_items",
            "id": "9f113e5f-40e5-4463-bd1b-50f143831a53"
          },
          {
            "type": "menu_items",
            "id": "a7898bae-aadd-4890-9401-1e0a1d321b17"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "02efb5e0-0bb4-4c82-a575-16718e5bd79e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:24+00:00",
        "updated_at": "2023-01-05T09:56:24+00:00",
        "menu_id": "3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7",
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
            "related": "api/boomerang/menus/3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=02efb5e0-0bb4-4c82-a575-16718e5bd79e"
          }
        }
      }
    },
    {
      "id": "9f113e5f-40e5-4463-bd1b-50f143831a53",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:24+00:00",
        "updated_at": "2023-01-05T09:56:24+00:00",
        "menu_id": "3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7",
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
            "related": "api/boomerang/menus/3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9f113e5f-40e5-4463-bd1b-50f143831a53"
          }
        }
      }
    },
    {
      "id": "a7898bae-aadd-4890-9401-1e0a1d321b17",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:24+00:00",
        "updated_at": "2023-01-05T09:56:24+00:00",
        "menu_id": "3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7",
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
            "related": "api/boomerang/menus/3dac5cef-b8a4-44c3-a15e-9db0b4ed48c7"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a7898bae-aadd-4890-9401-1e0a1d321b17"
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "72005c23-f8fe-4df4-a743-395a55091fce",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T09:56:25+00:00",
      "updated_at": "2023-01-05T09:56:25+00:00",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/menus/97cfad0e-4b1a-4fef-ac94-80b03b54fc54' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97cfad0e-4b1a-4fef-ac94-80b03b54fc54",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "ea26167c-f643-4814-859f-cd4437392bcb",
              "title": "Contact us"
            },
            {
              "id": "6cbd525c-d717-4400-9697-b1cf0fefaa9e",
              "title": "Start"
            },
            {
              "id": "1fb62610-6899-4f7f-a82a-eaae29a680a6",
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
    "id": "97cfad0e-4b1a-4fef-ac94-80b03b54fc54",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-05T09:56:25+00:00",
      "updated_at": "2023-01-05T09:56:25+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "ea26167c-f643-4814-859f-cd4437392bcb"
          },
          {
            "type": "menu_items",
            "id": "6cbd525c-d717-4400-9697-b1cf0fefaa9e"
          },
          {
            "type": "menu_items",
            "id": "1fb62610-6899-4f7f-a82a-eaae29a680a6"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ea26167c-f643-4814-859f-cd4437392bcb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:25+00:00",
        "updated_at": "2023-01-05T09:56:25+00:00",
        "menu_id": "97cfad0e-4b1a-4fef-ac94-80b03b54fc54",
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
      "id": "6cbd525c-d717-4400-9697-b1cf0fefaa9e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:25+00:00",
        "updated_at": "2023-01-05T09:56:25+00:00",
        "menu_id": "97cfad0e-4b1a-4fef-ac94-80b03b54fc54",
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
      "id": "1fb62610-6899-4f7f-a82a-eaae29a680a6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-05T09:56:25+00:00",
        "updated_at": "2023-01-05T09:56:25+00:00",
        "menu_id": "97cfad0e-4b1a-4fef-ac94-80b03b54fc54",
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
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
    --url 'https://example.booqable.com/api/boomerang/menus/b72b6ec5-e013-4b0c-9ede-d5ad1044975f' \
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

This request accepts the following parameters:

Name | Description
- | -
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes