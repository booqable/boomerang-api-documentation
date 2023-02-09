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
      "id": "b147b1e4-aca7-427d-824e-54c445d34292",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T09:28:49+00:00",
        "updated_at": "2023-02-09T09:28:49+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b147b1e4-aca7-427d-824e-54c445d34292"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T09:25:54Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/1df56b69-b88e-4bb9-b15b-5fa259da6535?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "1df56b69-b88e-4bb9-b15b-5fa259da6535",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T09:28:50+00:00",
      "updated_at": "2023-02-09T09:28:50+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=1df56b69-b88e-4bb9-b15b-5fa259da6535"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "171ef3eb-2a9a-4ba1-be6c-9b044f8b7a73"
          },
          {
            "type": "menu_items",
            "id": "a4416d3b-a153-4e04-be7f-6fc66f6d1c3c"
          },
          {
            "type": "menu_items",
            "id": "49aadad1-dd92-4e53-85dc-a58208708e07"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "171ef3eb-2a9a-4ba1-be6c-9b044f8b7a73",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:50+00:00",
        "updated_at": "2023-02-09T09:28:50+00:00",
        "menu_id": "1df56b69-b88e-4bb9-b15b-5fa259da6535",
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
            "related": "api/boomerang/menus/1df56b69-b88e-4bb9-b15b-5fa259da6535"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=171ef3eb-2a9a-4ba1-be6c-9b044f8b7a73"
          }
        }
      }
    },
    {
      "id": "a4416d3b-a153-4e04-be7f-6fc66f6d1c3c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:50+00:00",
        "updated_at": "2023-02-09T09:28:50+00:00",
        "menu_id": "1df56b69-b88e-4bb9-b15b-5fa259da6535",
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
            "related": "api/boomerang/menus/1df56b69-b88e-4bb9-b15b-5fa259da6535"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a4416d3b-a153-4e04-be7f-6fc66f6d1c3c"
          }
        }
      }
    },
    {
      "id": "49aadad1-dd92-4e53-85dc-a58208708e07",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:50+00:00",
        "updated_at": "2023-02-09T09:28:50+00:00",
        "menu_id": "1df56b69-b88e-4bb9-b15b-5fa259da6535",
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
            "related": "api/boomerang/menus/1df56b69-b88e-4bb9-b15b-5fa259da6535"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=49aadad1-dd92-4e53-85dc-a58208708e07"
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
    "id": "8b792aa2-ed4b-4545-b515-58b24bbdb2d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T09:28:52+00:00",
      "updated_at": "2023-02-09T09:28:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/784be833-4937-4578-a1dd-d3f99abc3081' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "784be833-4937-4578-a1dd-d3f99abc3081",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b58ce241-4ddc-44bb-8702-533c725532e6",
              "title": "Contact us"
            },
            {
              "id": "03d9586e-58d0-4053-a868-2182c9fd767d",
              "title": "Start"
            },
            {
              "id": "96ee599e-5db1-4e46-84c0-d39d8aa39c0f",
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
    "id": "784be833-4937-4578-a1dd-d3f99abc3081",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T09:28:53+00:00",
      "updated_at": "2023-02-09T09:28:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b58ce241-4ddc-44bb-8702-533c725532e6"
          },
          {
            "type": "menu_items",
            "id": "03d9586e-58d0-4053-a868-2182c9fd767d"
          },
          {
            "type": "menu_items",
            "id": "96ee599e-5db1-4e46-84c0-d39d8aa39c0f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b58ce241-4ddc-44bb-8702-533c725532e6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:53+00:00",
        "updated_at": "2023-02-09T09:28:53+00:00",
        "menu_id": "784be833-4937-4578-a1dd-d3f99abc3081",
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
      "id": "03d9586e-58d0-4053-a868-2182c9fd767d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:53+00:00",
        "updated_at": "2023-02-09T09:28:53+00:00",
        "menu_id": "784be833-4937-4578-a1dd-d3f99abc3081",
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
      "id": "96ee599e-5db1-4e46-84c0-d39d8aa39c0f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T09:28:53+00:00",
        "updated_at": "2023-02-09T09:28:53+00:00",
        "menu_id": "784be833-4937-4578-a1dd-d3f99abc3081",
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
    --url 'https://example.booqable.com/api/boomerang/menus/2c8ec4be-c1a0-4d03-94ee-984c3761d52a' \
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