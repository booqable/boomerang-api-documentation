# Menus

Allows creating and managing menus for your shop.

## Endpoints
`PUT /api/boomerang/menus/{id}`

`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

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


## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/9e6fcd97-8728-4e9c-9e2d-fb481fc19c11' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9e6fcd97-8728-4e9c-9e2d-fb481fc19c11",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "0302c023-1c2d-4e79-acb4-11b12337e36d",
              "title": "Contact us"
            },
            {
              "id": "2852d0d5-ce1c-4b47-a533-91dd4104d9c4",
              "title": "Start"
            },
            {
              "id": "57734fe9-9bcb-4ce4-bd54-214fcb6cb987",
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
    "id": "9e6fcd97-8728-4e9c-9e2d-fb481fc19c11",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-22T09:27:44+00:00",
      "updated_at": "2024-04-22T09:27:44+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "0302c023-1c2d-4e79-acb4-11b12337e36d"
          },
          {
            "type": "menu_items",
            "id": "2852d0d5-ce1c-4b47-a533-91dd4104d9c4"
          },
          {
            "type": "menu_items",
            "id": "57734fe9-9bcb-4ce4-bd54-214fcb6cb987"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "0302c023-1c2d-4e79-acb4-11b12337e36d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:44+00:00",
        "updated_at": "2024-04-22T09:27:44+00:00",
        "menu_id": "9e6fcd97-8728-4e9c-9e2d-fb481fc19c11",
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
      "id": "2852d0d5-ce1c-4b47-a533-91dd4104d9c4",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:44+00:00",
        "updated_at": "2024-04-22T09:27:44+00:00",
        "menu_id": "9e6fcd97-8728-4e9c-9e2d-fb481fc19c11",
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
      "id": "57734fe9-9bcb-4ce4-bd54-214fcb6cb987",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:44+00:00",
        "updated_at": "2024-04-22T09:27:44+00:00",
        "menu_id": "9e6fcd97-8728-4e9c-9e2d-fb481fc19c11",
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










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/b5f54256-22fd-4fe7-b354-f8c9e79199c0' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "b5f54256-22fd-4fe7-b354-f8c9e79199c0",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-22T09:27:44+00:00",
      "updated_at": "2024-04-22T09:27:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=b5f54256-22fd-4fe7-b354-f8c9e79199c0"
        }
      }
    }
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
    "id": "6f08241e-b22d-4acd-ade6-95ce6c530f23",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-22T09:27:45+00:00",
      "updated_at": "2024-04-22T09:27:45+00:00",
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










## Fetching a menu



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/a475d1f9-809d-4a44-b4ac-097817f5b3fd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a475d1f9-809d-4a44-b4ac-097817f5b3fd",
    "type": "menus",
    "attributes": {
      "created_at": "2024-04-22T09:27:45+00:00",
      "updated_at": "2024-04-22T09:27:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a475d1f9-809d-4a44-b4ac-097817f5b3fd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "e4698c63-f907-40a9-99bd-ee38ca9b15b0"
          },
          {
            "type": "menu_items",
            "id": "0f79e960-0383-4437-b8a2-0f986a5b091e"
          },
          {
            "type": "menu_items",
            "id": "9d48b453-f9ab-4203-8e51-8139f8d74732"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e4698c63-f907-40a9-99bd-ee38ca9b15b0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:45+00:00",
        "updated_at": "2024-04-22T09:27:45+00:00",
        "menu_id": "a475d1f9-809d-4a44-b4ac-097817f5b3fd",
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
            "related": "api/boomerang/menus/a475d1f9-809d-4a44-b4ac-097817f5b3fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e4698c63-f907-40a9-99bd-ee38ca9b15b0"
          }
        }
      }
    },
    {
      "id": "0f79e960-0383-4437-b8a2-0f986a5b091e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:45+00:00",
        "updated_at": "2024-04-22T09:27:45+00:00",
        "menu_id": "a475d1f9-809d-4a44-b4ac-097817f5b3fd",
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
            "related": "api/boomerang/menus/a475d1f9-809d-4a44-b4ac-097817f5b3fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0f79e960-0383-4437-b8a2-0f986a5b091e"
          }
        }
      }
    },
    {
      "id": "9d48b453-f9ab-4203-8e51-8139f8d74732",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-04-22T09:27:45+00:00",
        "updated_at": "2024-04-22T09:27:45+00:00",
        "menu_id": "a475d1f9-809d-4a44-b4ac-097817f5b3fd",
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
            "related": "api/boomerang/menus/a475d1f9-809d-4a44-b4ac-097817f5b3fd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9d48b453-f9ab-4203-8e51-8139f8d74732"
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
      "id": "a4608926-9f82-45d0-b753-062f80ee5f91",
      "type": "menus",
      "attributes": {
        "created_at": "2024-04-22T09:27:46+00:00",
        "updated_at": "2024-04-22T09:27:46+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a4608926-9f82-45d0-b753-062f80ee5f91"
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









