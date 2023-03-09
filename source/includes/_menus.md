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
      "id": "cef3a5e6-f88c-41fa-a93c-38571f217c26",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-09T08:58:51+00:00",
        "updated_at": "2023-03-09T08:58:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=cef3a5e6-f88c-41fa-a93c-38571f217c26"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-09T08:56:36Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:52+00:00",
      "updated_at": "2023-03-09T08:58:52+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "26cbcb93-4fd9-4354-aead-31adbd1c4454"
          },
          {
            "type": "menu_items",
            "id": "037b0265-6c44-4c7d-969a-c30d9da4f577"
          },
          {
            "type": "menu_items",
            "id": "f1df2cf4-1b2f-494e-aea3-7eb5204c4a90"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "26cbcb93-4fd9-4354-aead-31adbd1c4454",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:52+00:00",
        "menu_id": "a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9",
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
            "related": "api/boomerang/menus/a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=26cbcb93-4fd9-4354-aead-31adbd1c4454"
          }
        }
      }
    },
    {
      "id": "037b0265-6c44-4c7d-969a-c30d9da4f577",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:52+00:00",
        "menu_id": "a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9",
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
            "related": "api/boomerang/menus/a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=037b0265-6c44-4c7d-969a-c30d9da4f577"
          }
        }
      }
    },
    {
      "id": "f1df2cf4-1b2f-494e-aea3-7eb5204c4a90",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:52+00:00",
        "menu_id": "a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9",
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
            "related": "api/boomerang/menus/a0e941fa-4a90-4a5e-a5f1-1bd07bbf81d9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=f1df2cf4-1b2f-494e-aea3-7eb5204c4a90"
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
    "id": "5670be87-5d52-4e0d-bf06-ad3ae80e4dde",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:52+00:00",
      "updated_at": "2023-03-09T08:58:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/205799d3-6de3-4327-ad18-e0bec209b869' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "205799d3-6de3-4327-ad18-e0bec209b869",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b9cf3827-9128-41c4-acdd-a797b6afa20d",
              "title": "Contact us"
            },
            {
              "id": "85316b61-2e73-4f54-a95a-6532a9aca812",
              "title": "Start"
            },
            {
              "id": "7a031568-cb88-497c-a239-17dcf8328e1c",
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
    "id": "205799d3-6de3-4327-ad18-e0bec209b869",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-09T08:58:52+00:00",
      "updated_at": "2023-03-09T08:58:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b9cf3827-9128-41c4-acdd-a797b6afa20d"
          },
          {
            "type": "menu_items",
            "id": "85316b61-2e73-4f54-a95a-6532a9aca812"
          },
          {
            "type": "menu_items",
            "id": "7a031568-cb88-497c-a239-17dcf8328e1c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b9cf3827-9128-41c4-acdd-a797b6afa20d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:53+00:00",
        "menu_id": "205799d3-6de3-4327-ad18-e0bec209b869",
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
      "id": "85316b61-2e73-4f54-a95a-6532a9aca812",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:53+00:00",
        "menu_id": "205799d3-6de3-4327-ad18-e0bec209b869",
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
      "id": "7a031568-cb88-497c-a239-17dcf8328e1c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-09T08:58:52+00:00",
        "updated_at": "2023-03-09T08:58:53+00:00",
        "menu_id": "205799d3-6de3-4327-ad18-e0bec209b869",
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
    --url 'https://example.booqable.com/api/boomerang/menus/51bf9774-54b8-46bb-9b3d-f0edd269f0df' \
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