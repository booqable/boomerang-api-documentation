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
      "id": "41e22297-8496-4e74-bb8f-edfdb726270b",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T10:19:34+00:00",
        "updated_at": "2023-02-09T10:19:34+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=41e22297-8496-4e74-bb8f-edfdb726270b"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T10:17:18Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/d3b86898-b4c3-4e89-97c9-842cb3a4286e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "d3b86898-b4c3-4e89-97c9-842cb3a4286e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:34+00:00",
      "updated_at": "2023-02-09T10:19:34+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=d3b86898-b4c3-4e89-97c9-842cb3a4286e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "f08d336e-cb15-40c2-b621-d6606bd3da11"
          },
          {
            "type": "menu_items",
            "id": "506b89fb-d1d1-46de-824b-57e4587b8da8"
          },
          {
            "type": "menu_items",
            "id": "15dd4b8c-1083-4aa8-afd1-99bec112e260"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "f08d336e-cb15-40c2-b621-d6606bd3da11",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:34+00:00",
        "updated_at": "2023-02-09T10:19:34+00:00",
        "menu_id": "d3b86898-b4c3-4e89-97c9-842cb3a4286e",
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
            "related": "api/boomerang/menus/d3b86898-b4c3-4e89-97c9-842cb3a4286e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f08d336e-cb15-40c2-b621-d6606bd3da11"
          }
        }
      }
    },
    {
      "id": "506b89fb-d1d1-46de-824b-57e4587b8da8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:34+00:00",
        "updated_at": "2023-02-09T10:19:34+00:00",
        "menu_id": "d3b86898-b4c3-4e89-97c9-842cb3a4286e",
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
            "related": "api/boomerang/menus/d3b86898-b4c3-4e89-97c9-842cb3a4286e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=506b89fb-d1d1-46de-824b-57e4587b8da8"
          }
        }
      }
    },
    {
      "id": "15dd4b8c-1083-4aa8-afd1-99bec112e260",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:34+00:00",
        "updated_at": "2023-02-09T10:19:34+00:00",
        "menu_id": "d3b86898-b4c3-4e89-97c9-842cb3a4286e",
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
            "related": "api/boomerang/menus/d3b86898-b4c3-4e89-97c9-842cb3a4286e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=15dd4b8c-1083-4aa8-afd1-99bec112e260"
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
    "id": "e916ecfb-0aed-4750-b66e-279cae1a9950",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:34+00:00",
      "updated_at": "2023-02-09T10:19:34+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0e38201c-b007-475a-8260-aec38a87fcfe' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0e38201c-b007-475a-8260-aec38a87fcfe",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e2e30fe7-42dc-48a9-b432-053f762d387d",
              "title": "Contact us"
            },
            {
              "id": "f63f8bdd-6985-4e14-ac4b-754d683e3928",
              "title": "Start"
            },
            {
              "id": "bb7f1e2b-d1b4-44d4-8580-0ccc89c75684",
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
    "id": "0e38201c-b007-475a-8260-aec38a87fcfe",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T10:19:35+00:00",
      "updated_at": "2023-02-09T10:19:35+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e2e30fe7-42dc-48a9-b432-053f762d387d"
          },
          {
            "type": "menu_items",
            "id": "f63f8bdd-6985-4e14-ac4b-754d683e3928"
          },
          {
            "type": "menu_items",
            "id": "bb7f1e2b-d1b4-44d4-8580-0ccc89c75684"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e2e30fe7-42dc-48a9-b432-053f762d387d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:35+00:00",
        "updated_at": "2023-02-09T10:19:35+00:00",
        "menu_id": "0e38201c-b007-475a-8260-aec38a87fcfe",
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
      "id": "f63f8bdd-6985-4e14-ac4b-754d683e3928",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:35+00:00",
        "updated_at": "2023-02-09T10:19:35+00:00",
        "menu_id": "0e38201c-b007-475a-8260-aec38a87fcfe",
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
      "id": "bb7f1e2b-d1b4-44d4-8580-0ccc89c75684",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T10:19:35+00:00",
        "updated_at": "2023-02-09T10:19:35+00:00",
        "menu_id": "0e38201c-b007-475a-8260-aec38a87fcfe",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b04fd8f9-4a98-4016-a481-accfd323ea76' \
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