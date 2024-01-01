# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

`POST /api/boomerang/menus`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus/{id}`

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


## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/ce6aced8-da79-4120-af19-3c3b85d00821' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
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
      "id": "e9fa89a1-0a4a-40ea-a544-e21e149c4396",
      "type": "menus",
      "attributes": {
        "created_at": "2024-01-01T09:18:33+00:00",
        "updated_at": "2024-01-01T09:18:33+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=e9fa89a1-0a4a-40ea-a544-e21e149c4396"
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
    "id": "a82849b7-d023-4daf-b93f-025d1208294f",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-01T09:18:33+00:00",
      "updated_at": "2024-01-01T09:18:33+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1335ab3b-089d-44a2-9c77-a22501c62226' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1335ab3b-089d-44a2-9c77-a22501c62226",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "646a6bd3-eeb6-4ff3-82b7-fc7b94f31930",
              "title": "Contact us"
            },
            {
              "id": "30e8669b-1c8d-44af-940e-5b8ada4a8ef4",
              "title": "Start"
            },
            {
              "id": "9fc900e1-8409-4d3a-8e35-4f9d1790f31e",
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
    "id": "1335ab3b-089d-44a2-9c77-a22501c62226",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-01T09:18:34+00:00",
      "updated_at": "2024-01-01T09:18:34+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "646a6bd3-eeb6-4ff3-82b7-fc7b94f31930"
          },
          {
            "type": "menu_items",
            "id": "30e8669b-1c8d-44af-940e-5b8ada4a8ef4"
          },
          {
            "type": "menu_items",
            "id": "9fc900e1-8409-4d3a-8e35-4f9d1790f31e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "646a6bd3-eeb6-4ff3-82b7-fc7b94f31930",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:34+00:00",
        "updated_at": "2024-01-01T09:18:34+00:00",
        "menu_id": "1335ab3b-089d-44a2-9c77-a22501c62226",
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
      "id": "30e8669b-1c8d-44af-940e-5b8ada4a8ef4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:34+00:00",
        "updated_at": "2024-01-01T09:18:34+00:00",
        "menu_id": "1335ab3b-089d-44a2-9c77-a22501c62226",
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
      "id": "9fc900e1-8409-4d3a-8e35-4f9d1790f31e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:34+00:00",
        "updated_at": "2024-01-01T09:18:34+00:00",
        "menu_id": "1335ab3b-089d-44a2-9c77-a22501c62226",
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










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/0c724a8f-0563-4109-bd14-c631524b0b9d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "0c724a8f-0563-4109-bd14-c631524b0b9d",
    "type": "menus",
    "attributes": {
      "created_at": "2024-01-01T09:18:35+00:00",
      "updated_at": "2024-01-01T09:18:35+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=0c724a8f-0563-4109-bd14-c631524b0b9d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "c4284815-6ec4-42b3-9965-b32c4fb3311f"
          },
          {
            "type": "menu_items",
            "id": "74e83b54-8367-47f5-ba2c-909fd6e31222"
          },
          {
            "type": "menu_items",
            "id": "3b081e79-a706-4945-8ff0-0546010d1ffd"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c4284815-6ec4-42b3-9965-b32c4fb3311f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:35+00:00",
        "updated_at": "2024-01-01T09:18:35+00:00",
        "menu_id": "0c724a8f-0563-4109-bd14-c631524b0b9d",
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
            "related": "api/boomerang/menus/0c724a8f-0563-4109-bd14-c631524b0b9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c4284815-6ec4-42b3-9965-b32c4fb3311f"
          }
        }
      }
    },
    {
      "id": "74e83b54-8367-47f5-ba2c-909fd6e31222",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:35+00:00",
        "updated_at": "2024-01-01T09:18:35+00:00",
        "menu_id": "0c724a8f-0563-4109-bd14-c631524b0b9d",
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
            "related": "api/boomerang/menus/0c724a8f-0563-4109-bd14-c631524b0b9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=74e83b54-8367-47f5-ba2c-909fd6e31222"
          }
        }
      }
    },
    {
      "id": "3b081e79-a706-4945-8ff0-0546010d1ffd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-01-01T09:18:35+00:00",
        "updated_at": "2024-01-01T09:18:35+00:00",
        "menu_id": "0c724a8f-0563-4109-bd14-c631524b0b9d",
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
            "related": "api/boomerang/menus/0c724a8f-0563-4109-bd14-c631524b0b9d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=3b081e79-a706-4945-8ff0-0546010d1ffd"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`





