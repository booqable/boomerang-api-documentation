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
      "id": "34f72527-7874-4e6f-8360-8fae44bf3b2a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-03T11:10:51+00:00",
        "updated_at": "2023-02-03T11:10:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=34f72527-7874-4e6f-8360-8fae44bf3b2a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-03T11:08:37Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/387329fd-e434-4210-b51a-78d2986bfa6b?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "387329fd-e434-4210-b51a-78d2986bfa6b",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:52+00:00",
      "updated_at": "2023-02-03T11:10:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=387329fd-e434-4210-b51a-78d2986bfa6b"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ec8b74cd-772c-49d4-b346-295adeb7999a"
          },
          {
            "type": "menu_items",
            "id": "2f146d21-e12b-4e45-b615-9d77e166d69e"
          },
          {
            "type": "menu_items",
            "id": "b0793406-4975-4790-9ea7-228b84350706"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ec8b74cd-772c-49d4-b346-295adeb7999a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:52+00:00",
        "updated_at": "2023-02-03T11:10:52+00:00",
        "menu_id": "387329fd-e434-4210-b51a-78d2986bfa6b",
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
            "related": "api/boomerang/menus/387329fd-e434-4210-b51a-78d2986bfa6b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ec8b74cd-772c-49d4-b346-295adeb7999a"
          }
        }
      }
    },
    {
      "id": "2f146d21-e12b-4e45-b615-9d77e166d69e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:52+00:00",
        "updated_at": "2023-02-03T11:10:52+00:00",
        "menu_id": "387329fd-e434-4210-b51a-78d2986bfa6b",
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
            "related": "api/boomerang/menus/387329fd-e434-4210-b51a-78d2986bfa6b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2f146d21-e12b-4e45-b615-9d77e166d69e"
          }
        }
      }
    },
    {
      "id": "b0793406-4975-4790-9ea7-228b84350706",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:52+00:00",
        "updated_at": "2023-02-03T11:10:52+00:00",
        "menu_id": "387329fd-e434-4210-b51a-78d2986bfa6b",
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
            "related": "api/boomerang/menus/387329fd-e434-4210-b51a-78d2986bfa6b"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b0793406-4975-4790-9ea7-228b84350706"
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
    "id": "22a6d7ac-3211-48da-97b6-35d7fd76eed7",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:52+00:00",
      "updated_at": "2023-02-03T11:10:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0b59997d-4210-4f4a-9b5f-832ff4e57e06' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0b59997d-4210-4f4a-9b5f-832ff4e57e06",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8435ed46-ffbf-4cbd-9fb0-5699bfa18d22",
              "title": "Contact us"
            },
            {
              "id": "51197aec-59fc-475f-9c41-a6eb66710b31",
              "title": "Start"
            },
            {
              "id": "853605f0-f888-472c-a023-725e51eba970",
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
    "id": "0b59997d-4210-4f4a-9b5f-832ff4e57e06",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-03T11:10:53+00:00",
      "updated_at": "2023-02-03T11:10:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8435ed46-ffbf-4cbd-9fb0-5699bfa18d22"
          },
          {
            "type": "menu_items",
            "id": "51197aec-59fc-475f-9c41-a6eb66710b31"
          },
          {
            "type": "menu_items",
            "id": "853605f0-f888-472c-a023-725e51eba970"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8435ed46-ffbf-4cbd-9fb0-5699bfa18d22",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:53+00:00",
        "updated_at": "2023-02-03T11:10:53+00:00",
        "menu_id": "0b59997d-4210-4f4a-9b5f-832ff4e57e06",
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
      "id": "51197aec-59fc-475f-9c41-a6eb66710b31",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:53+00:00",
        "updated_at": "2023-02-03T11:10:53+00:00",
        "menu_id": "0b59997d-4210-4f4a-9b5f-832ff4e57e06",
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
      "id": "853605f0-f888-472c-a023-725e51eba970",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-03T11:10:53+00:00",
        "updated_at": "2023-02-03T11:10:53+00:00",
        "menu_id": "0b59997d-4210-4f4a-9b5f-832ff4e57e06",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0694fe4e-93e1-43a4-afb6-46424694206f' \
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