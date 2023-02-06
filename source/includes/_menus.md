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
      "id": "8338ce70-a881-4c70-b9e2-e6cd240fe7bf",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-06T08:48:51+00:00",
        "updated_at": "2023-02-06T08:48:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=8338ce70-a881-4c70-b9e2-e6cd240fe7bf"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-06T08:46:51Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/55e50000-2f88-4ac6-a215-d67bc1e89d4e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "55e50000-2f88-4ac6-a215-d67bc1e89d4e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T08:48:51+00:00",
      "updated_at": "2023-02-06T08:48:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=55e50000-2f88-4ac6-a215-d67bc1e89d4e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "ffd91226-7996-43fb-a2cb-f6954e883aeb"
          },
          {
            "type": "menu_items",
            "id": "5e4ea576-f545-4071-9c4f-75a057f0d23a"
          },
          {
            "type": "menu_items",
            "id": "d00939ef-93c8-4ec6-99ba-82eece8b9eca"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "ffd91226-7996-43fb-a2cb-f6954e883aeb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:51+00:00",
        "updated_at": "2023-02-06T08:48:51+00:00",
        "menu_id": "55e50000-2f88-4ac6-a215-d67bc1e89d4e",
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
            "related": "api/boomerang/menus/55e50000-2f88-4ac6-a215-d67bc1e89d4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ffd91226-7996-43fb-a2cb-f6954e883aeb"
          }
        }
      }
    },
    {
      "id": "5e4ea576-f545-4071-9c4f-75a057f0d23a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:51+00:00",
        "updated_at": "2023-02-06T08:48:51+00:00",
        "menu_id": "55e50000-2f88-4ac6-a215-d67bc1e89d4e",
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
            "related": "api/boomerang/menus/55e50000-2f88-4ac6-a215-d67bc1e89d4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5e4ea576-f545-4071-9c4f-75a057f0d23a"
          }
        }
      }
    },
    {
      "id": "d00939ef-93c8-4ec6-99ba-82eece8b9eca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:51+00:00",
        "updated_at": "2023-02-06T08:48:51+00:00",
        "menu_id": "55e50000-2f88-4ac6-a215-d67bc1e89d4e",
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
            "related": "api/boomerang/menus/55e50000-2f88-4ac6-a215-d67bc1e89d4e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d00939ef-93c8-4ec6-99ba-82eece8b9eca"
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
    "id": "3a353d15-8968-4962-a12c-8284f835fca1",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T08:48:52+00:00",
      "updated_at": "2023-02-06T08:48:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fccfa81c-e2a8-4787-90e9-d9ed76e5872c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "fccfa81c-e2a8-4787-90e9-d9ed76e5872c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "65d554ca-3fc7-4ca8-b22d-cce552e342cd",
              "title": "Contact us"
            },
            {
              "id": "e4b23d3c-644f-4326-9803-d88618e3e4f1",
              "title": "Start"
            },
            {
              "id": "2bd49309-ab78-4c62-8947-6ba04a0492ca",
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
    "id": "fccfa81c-e2a8-4787-90e9-d9ed76e5872c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-06T08:48:52+00:00",
      "updated_at": "2023-02-06T08:48:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "65d554ca-3fc7-4ca8-b22d-cce552e342cd"
          },
          {
            "type": "menu_items",
            "id": "e4b23d3c-644f-4326-9803-d88618e3e4f1"
          },
          {
            "type": "menu_items",
            "id": "2bd49309-ab78-4c62-8947-6ba04a0492ca"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "65d554ca-3fc7-4ca8-b22d-cce552e342cd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:52+00:00",
        "updated_at": "2023-02-06T08:48:52+00:00",
        "menu_id": "fccfa81c-e2a8-4787-90e9-d9ed76e5872c",
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
      "id": "e4b23d3c-644f-4326-9803-d88618e3e4f1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:52+00:00",
        "updated_at": "2023-02-06T08:48:52+00:00",
        "menu_id": "fccfa81c-e2a8-4787-90e9-d9ed76e5872c",
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
      "id": "2bd49309-ab78-4c62-8947-6ba04a0492ca",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-06T08:48:52+00:00",
        "updated_at": "2023-02-06T08:48:52+00:00",
        "menu_id": "fccfa81c-e2a8-4787-90e9-d9ed76e5872c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/cb4dc663-071d-4182-ae6f-41c20815d9c7' \
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