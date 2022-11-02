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
      "id": "ada374ec-fe83-46d0-bbac-06100c087443",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-02T10:19:53+00:00",
        "updated_at": "2022-11-02T10:19:53+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=ada374ec-fe83-46d0-bbac-06100c087443"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-02T10:18:14Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-02T10:19:54+00:00",
      "updated_at": "2022-11-02T10:19:54+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b0ab2828-524a-44cb-b960-ee3624269646"
          },
          {
            "type": "menu_items",
            "id": "303055d4-50ba-451b-9924-cf547662b5a5"
          },
          {
            "type": "menu_items",
            "id": "1ee570a7-7c5c-4bf8-9a40-230950c0bc08"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b0ab2828-524a-44cb-b960-ee3624269646",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:54+00:00",
        "menu_id": "e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2",
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
            "related": "api/boomerang/menus/e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b0ab2828-524a-44cb-b960-ee3624269646"
          }
        }
      }
    },
    {
      "id": "303055d4-50ba-451b-9924-cf547662b5a5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:54+00:00",
        "menu_id": "e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2",
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
            "related": "api/boomerang/menus/e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=303055d4-50ba-451b-9924-cf547662b5a5"
          }
        }
      }
    },
    {
      "id": "1ee570a7-7c5c-4bf8-9a40-230950c0bc08",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:54+00:00",
        "menu_id": "e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2",
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
            "related": "api/boomerang/menus/e0baa0a3-c8a0-4aee-b626-6a3dd447a1d2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1ee570a7-7c5c-4bf8-9a40-230950c0bc08"
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
    "id": "562c762c-547a-4952-b0a9-a006273bf06a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-02T10:19:54+00:00",
      "updated_at": "2022-11-02T10:19:54+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/47a7b4fa-b660-441e-9986-0ec9405b4ef2' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "47a7b4fa-b660-441e-9986-0ec9405b4ef2",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "dae0c573-9909-4625-8f06-2a2e3ec8ebd5",
              "title": "Contact us"
            },
            {
              "id": "01b6f608-0bc5-4d34-8936-1a3c97d8ca04",
              "title": "Start"
            },
            {
              "id": "05e33f85-24b3-4580-8ccb-52050f2b0717",
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
    "id": "47a7b4fa-b660-441e-9986-0ec9405b4ef2",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-02T10:19:54+00:00",
      "updated_at": "2022-11-02T10:19:55+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "dae0c573-9909-4625-8f06-2a2e3ec8ebd5"
          },
          {
            "type": "menu_items",
            "id": "01b6f608-0bc5-4d34-8936-1a3c97d8ca04"
          },
          {
            "type": "menu_items",
            "id": "05e33f85-24b3-4580-8ccb-52050f2b0717"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dae0c573-9909-4625-8f06-2a2e3ec8ebd5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:55+00:00",
        "menu_id": "47a7b4fa-b660-441e-9986-0ec9405b4ef2",
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
      "id": "01b6f608-0bc5-4d34-8936-1a3c97d8ca04",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:55+00:00",
        "menu_id": "47a7b4fa-b660-441e-9986-0ec9405b4ef2",
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
      "id": "05e33f85-24b3-4580-8ccb-52050f2b0717",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-02T10:19:54+00:00",
        "updated_at": "2022-11-02T10:19:55+00:00",
        "menu_id": "47a7b4fa-b660-441e-9986-0ec9405b4ef2",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c0b72c2f-6692-40cc-8c89-8c5446b35a8c' \
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