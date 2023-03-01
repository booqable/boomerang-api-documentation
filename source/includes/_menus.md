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
      "id": "b0cba8db-211e-4ce6-a366-d0747125b7da",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-01T17:38:15+00:00",
        "updated_at": "2023-03-01T17:38:15+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b0cba8db-211e-4ce6-a366-d0747125b7da"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-01T17:36:22Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T17:38:15+00:00",
      "updated_at": "2023-03-01T17:38:15+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "254943df-65ce-4b77-a2df-c66ea9e45063"
          },
          {
            "type": "menu_items",
            "id": "682dc7ff-0adc-42c1-aa2f-747e0128d77d"
          },
          {
            "type": "menu_items",
            "id": "03ac1e48-18d2-4b49-a04b-72af523cdfee"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "254943df-65ce-4b77-a2df-c66ea9e45063",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:15+00:00",
        "updated_at": "2023-03-01T17:38:15+00:00",
        "menu_id": "8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd",
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
            "related": "api/boomerang/menus/8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=254943df-65ce-4b77-a2df-c66ea9e45063"
          }
        }
      }
    },
    {
      "id": "682dc7ff-0adc-42c1-aa2f-747e0128d77d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:15+00:00",
        "updated_at": "2023-03-01T17:38:15+00:00",
        "menu_id": "8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd",
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
            "related": "api/boomerang/menus/8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=682dc7ff-0adc-42c1-aa2f-747e0128d77d"
          }
        }
      }
    },
    {
      "id": "03ac1e48-18d2-4b49-a04b-72af523cdfee",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:15+00:00",
        "updated_at": "2023-03-01T17:38:15+00:00",
        "menu_id": "8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd",
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
            "related": "api/boomerang/menus/8cc6ccb4-eb9b-41a3-863f-49e36ca9c4dd"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=03ac1e48-18d2-4b49-a04b-72af523cdfee"
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
    "id": "d7971b8f-da65-4272-b2d2-5ce14714e53e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T17:38:15+00:00",
      "updated_at": "2023-03-01T17:38:15+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/a9f53f4d-644d-4295-b2e6-958dd5554873' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "a9f53f4d-644d-4295-b2e6-958dd5554873",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a453ca29-dcbc-4fb6-bea7-c46ea1d4ceb5",
              "title": "Contact us"
            },
            {
              "id": "35aefb6a-859e-45e2-bdc5-2eb380cce03d",
              "title": "Start"
            },
            {
              "id": "455a7eb1-3d0c-45da-81c6-57b668e1ea5d",
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
    "id": "a9f53f4d-644d-4295-b2e6-958dd5554873",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-01T17:38:16+00:00",
      "updated_at": "2023-03-01T17:38:16+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a453ca29-dcbc-4fb6-bea7-c46ea1d4ceb5"
          },
          {
            "type": "menu_items",
            "id": "35aefb6a-859e-45e2-bdc5-2eb380cce03d"
          },
          {
            "type": "menu_items",
            "id": "455a7eb1-3d0c-45da-81c6-57b668e1ea5d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a453ca29-dcbc-4fb6-bea7-c46ea1d4ceb5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:16+00:00",
        "updated_at": "2023-03-01T17:38:16+00:00",
        "menu_id": "a9f53f4d-644d-4295-b2e6-958dd5554873",
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
      "id": "35aefb6a-859e-45e2-bdc5-2eb380cce03d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:16+00:00",
        "updated_at": "2023-03-01T17:38:16+00:00",
        "menu_id": "a9f53f4d-644d-4295-b2e6-958dd5554873",
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
      "id": "455a7eb1-3d0c-45da-81c6-57b668e1ea5d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-01T17:38:16+00:00",
        "updated_at": "2023-03-01T17:38:16+00:00",
        "menu_id": "a9f53f4d-644d-4295-b2e6-958dd5554873",
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
    --url 'https://example.booqable.com/api/boomerang/menus/87261936-2ccf-42d3-a96d-1a44c101368c' \
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