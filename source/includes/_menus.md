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
      "id": "257e68fd-251f-4a5f-8220-6e3d601c6117",
      "type": "menus",
      "attributes": {
        "created_at": "2023-01-19T10:46:44+00:00",
        "updated_at": "2023-01-19T10:46:44+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=257e68fd-251f-4a5f-8220-6e3d601c6117"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-01-19T10:45:10Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/e5ba78e8-2482-4187-8032-3fa738bd0fa2?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "e5ba78e8-2482-4187-8032-3fa738bd0fa2",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:46:44+00:00",
      "updated_at": "2023-01-19T10:46:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=e5ba78e8-2482-4187-8032-3fa738bd0fa2"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bf2cab45-210e-42a1-84e4-f57bfb1459dd"
          },
          {
            "type": "menu_items",
            "id": "eee28e7a-e59d-4518-ba27-301d4f90ee34"
          },
          {
            "type": "menu_items",
            "id": "c5986f05-5bd7-4c1a-bf39-5dc10713d63a"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf2cab45-210e-42a1-84e4-f57bfb1459dd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:44+00:00",
        "updated_at": "2023-01-19T10:46:44+00:00",
        "menu_id": "e5ba78e8-2482-4187-8032-3fa738bd0fa2",
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
            "related": "api/boomerang/menus/e5ba78e8-2482-4187-8032-3fa738bd0fa2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bf2cab45-210e-42a1-84e4-f57bfb1459dd"
          }
        }
      }
    },
    {
      "id": "eee28e7a-e59d-4518-ba27-301d4f90ee34",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:44+00:00",
        "updated_at": "2023-01-19T10:46:44+00:00",
        "menu_id": "e5ba78e8-2482-4187-8032-3fa738bd0fa2",
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
            "related": "api/boomerang/menus/e5ba78e8-2482-4187-8032-3fa738bd0fa2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=eee28e7a-e59d-4518-ba27-301d4f90ee34"
          }
        }
      }
    },
    {
      "id": "c5986f05-5bd7-4c1a-bf39-5dc10713d63a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:44+00:00",
        "updated_at": "2023-01-19T10:46:44+00:00",
        "menu_id": "e5ba78e8-2482-4187-8032-3fa738bd0fa2",
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
            "related": "api/boomerang/menus/e5ba78e8-2482-4187-8032-3fa738bd0fa2"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c5986f05-5bd7-4c1a-bf39-5dc10713d63a"
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
    "id": "598bc27b-8c4d-48be-972d-449d7ecb7885",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:46:44+00:00",
      "updated_at": "2023-01-19T10:46:44+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/dedbb7c1-09c0-4a70-a41f-e021695d8d0c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "dedbb7c1-09c0-4a70-a41f-e021695d8d0c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "5fc7adca-3d10-40ac-848a-897a7c00c391",
              "title": "Contact us"
            },
            {
              "id": "ed8a1b8d-e8cc-4cf2-8b88-79f35e45ea3c",
              "title": "Start"
            },
            {
              "id": "4b8d894a-a258-4d2f-8297-cb79f6e4b9ed",
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
    "id": "dedbb7c1-09c0-4a70-a41f-e021695d8d0c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-01-19T10:46:45+00:00",
      "updated_at": "2023-01-19T10:46:45+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "5fc7adca-3d10-40ac-848a-897a7c00c391"
          },
          {
            "type": "menu_items",
            "id": "ed8a1b8d-e8cc-4cf2-8b88-79f35e45ea3c"
          },
          {
            "type": "menu_items",
            "id": "4b8d894a-a258-4d2f-8297-cb79f6e4b9ed"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5fc7adca-3d10-40ac-848a-897a7c00c391",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:45+00:00",
        "updated_at": "2023-01-19T10:46:45+00:00",
        "menu_id": "dedbb7c1-09c0-4a70-a41f-e021695d8d0c",
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
      "id": "ed8a1b8d-e8cc-4cf2-8b88-79f35e45ea3c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:45+00:00",
        "updated_at": "2023-01-19T10:46:45+00:00",
        "menu_id": "dedbb7c1-09c0-4a70-a41f-e021695d8d0c",
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
      "id": "4b8d894a-a258-4d2f-8297-cb79f6e4b9ed",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-01-19T10:46:45+00:00",
        "updated_at": "2023-01-19T10:46:45+00:00",
        "menu_id": "dedbb7c1-09c0-4a70-a41f-e021695d8d0c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ede0dada-6d44-4768-bbb9-2407378a7128' \
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