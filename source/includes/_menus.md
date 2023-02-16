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
      "id": "57f624c3-95e8-42bd-89d7-4c9bc174fbab",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T23:13:23+00:00",
        "updated_at": "2023-02-16T23:13:23+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=57f624c3-95e8-42bd-89d7-4c9bc174fbab"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T23:11:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e28996ed-aa08-48df-b6df-bebd07aa5072?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e28996ed-aa08-48df-b6df-bebd07aa5072",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T23:13:23+00:00",
      "updated_at": "2023-02-16T23:13:23+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e28996ed-aa08-48df-b6df-bebd07aa5072"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "4a49e53c-d33e-4670-a9ea-a2a3aec167c3"
          },
          {
            "type": "menu_items",
            "id": "2a22752c-a3a9-470b-b1f8-3ee56389d8b8"
          },
          {
            "type": "menu_items",
            "id": "ff69a8b3-69c1-4833-b9ae-7a27631c3ed3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "4a49e53c-d33e-4670-a9ea-a2a3aec167c3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:23+00:00",
        "updated_at": "2023-02-16T23:13:23+00:00",
        "menu_id": "e28996ed-aa08-48df-b6df-bebd07aa5072",
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
            "related": "api/boomerang/menus/e28996ed-aa08-48df-b6df-bebd07aa5072"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4a49e53c-d33e-4670-a9ea-a2a3aec167c3"
          }
        }
      }
    },
    {
      "id": "2a22752c-a3a9-470b-b1f8-3ee56389d8b8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:23+00:00",
        "updated_at": "2023-02-16T23:13:23+00:00",
        "menu_id": "e28996ed-aa08-48df-b6df-bebd07aa5072",
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
            "related": "api/boomerang/menus/e28996ed-aa08-48df-b6df-bebd07aa5072"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=2a22752c-a3a9-470b-b1f8-3ee56389d8b8"
          }
        }
      }
    },
    {
      "id": "ff69a8b3-69c1-4833-b9ae-7a27631c3ed3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:23+00:00",
        "updated_at": "2023-02-16T23:13:23+00:00",
        "menu_id": "e28996ed-aa08-48df-b6df-bebd07aa5072",
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
            "related": "api/boomerang/menus/e28996ed-aa08-48df-b6df-bebd07aa5072"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ff69a8b3-69c1-4833-b9ae-7a27631c3ed3"
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
    "id": "2cceaeef-c06c-4ef5-a9ff-b6da0ac04ef1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T23:13:24+00:00",
      "updated_at": "2023-02-16T23:13:24+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b4271879-1400-4410-a3d0-0dedec20f463' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b4271879-1400-4410-a3d0-0dedec20f463",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "7771d492-676b-4919-a555-f77b801b9d4e",
              "title": "Contact us"
            },
            {
              "id": "998dc5ea-3421-4b35-9bc7-dedad8ef68ab",
              "title": "Start"
            },
            {
              "id": "5dc5c4b8-a6cb-4084-b1c6-35da7030f8bf",
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
    "id": "b4271879-1400-4410-a3d0-0dedec20f463",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T23:13:24+00:00",
      "updated_at": "2023-02-16T23:13:24+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "7771d492-676b-4919-a555-f77b801b9d4e"
          },
          {
            "type": "menu_items",
            "id": "998dc5ea-3421-4b35-9bc7-dedad8ef68ab"
          },
          {
            "type": "menu_items",
            "id": "5dc5c4b8-a6cb-4084-b1c6-35da7030f8bf"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7771d492-676b-4919-a555-f77b801b9d4e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:24+00:00",
        "updated_at": "2023-02-16T23:13:24+00:00",
        "menu_id": "b4271879-1400-4410-a3d0-0dedec20f463",
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
      "id": "998dc5ea-3421-4b35-9bc7-dedad8ef68ab",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:24+00:00",
        "updated_at": "2023-02-16T23:13:24+00:00",
        "menu_id": "b4271879-1400-4410-a3d0-0dedec20f463",
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
      "id": "5dc5c4b8-a6cb-4084-b1c6-35da7030f8bf",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T23:13:24+00:00",
        "updated_at": "2023-02-16T23:13:24+00:00",
        "menu_id": "b4271879-1400-4410-a3d0-0dedec20f463",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8f73038a-3c6c-4873-8686-e4aacd67e2f9' \
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