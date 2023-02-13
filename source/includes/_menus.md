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
      "id": "dcb46a55-6799-4351-85fe-9d8bf6a8b19a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T12:53:48+00:00",
        "updated_at": "2023-02-13T12:53:48+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=dcb46a55-6799-4351-85fe-9d8bf6a8b19a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:51:57Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/6821a259-983a-403a-8d0d-b81b490ef34e?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "6821a259-983a-403a-8d0d-b81b490ef34e",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:53:48+00:00",
      "updated_at": "2023-02-13T12:53:48+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=6821a259-983a-403a-8d0d-b81b490ef34e"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "536d2c70-dcb1-4835-a7a2-904cae69d2fa"
          },
          {
            "type": "menu_items",
            "id": "fa05110e-04e1-4f93-8ea5-84f867a24896"
          },
          {
            "type": "menu_items",
            "id": "5da7b867-56e0-47a6-9691-311912bde5f7"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "536d2c70-dcb1-4835-a7a2-904cae69d2fa",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:48+00:00",
        "updated_at": "2023-02-13T12:53:48+00:00",
        "menu_id": "6821a259-983a-403a-8d0d-b81b490ef34e",
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
            "related": "api/boomerang/menus/6821a259-983a-403a-8d0d-b81b490ef34e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=536d2c70-dcb1-4835-a7a2-904cae69d2fa"
          }
        }
      }
    },
    {
      "id": "fa05110e-04e1-4f93-8ea5-84f867a24896",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:48+00:00",
        "updated_at": "2023-02-13T12:53:48+00:00",
        "menu_id": "6821a259-983a-403a-8d0d-b81b490ef34e",
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
            "related": "api/boomerang/menus/6821a259-983a-403a-8d0d-b81b490ef34e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fa05110e-04e1-4f93-8ea5-84f867a24896"
          }
        }
      }
    },
    {
      "id": "5da7b867-56e0-47a6-9691-311912bde5f7",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:48+00:00",
        "updated_at": "2023-02-13T12:53:48+00:00",
        "menu_id": "6821a259-983a-403a-8d0d-b81b490ef34e",
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
            "related": "api/boomerang/menus/6821a259-983a-403a-8d0d-b81b490ef34e"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5da7b867-56e0-47a6-9691-311912bde5f7"
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
    "id": "4a37f004-542a-44e8-8f61-9c752bf13000",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:53:48+00:00",
      "updated_at": "2023-02-13T12:53:48+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/1826b35e-c6d1-47e7-acb9-4cba45943e18' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "1826b35e-c6d1-47e7-acb9-4cba45943e18",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1c250d94-990d-4487-ae36-495abe003bbe",
              "title": "Contact us"
            },
            {
              "id": "c7280cc7-c3ce-445d-b75d-4cf6408d866c",
              "title": "Start"
            },
            {
              "id": "f5a53725-c055-4bc0-9fcf-e5fae28b9470",
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
    "id": "1826b35e-c6d1-47e7-acb9-4cba45943e18",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:53:49+00:00",
      "updated_at": "2023-02-13T12:53:49+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1c250d94-990d-4487-ae36-495abe003bbe"
          },
          {
            "type": "menu_items",
            "id": "c7280cc7-c3ce-445d-b75d-4cf6408d866c"
          },
          {
            "type": "menu_items",
            "id": "f5a53725-c055-4bc0-9fcf-e5fae28b9470"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1c250d94-990d-4487-ae36-495abe003bbe",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:49+00:00",
        "updated_at": "2023-02-13T12:53:49+00:00",
        "menu_id": "1826b35e-c6d1-47e7-acb9-4cba45943e18",
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
      "id": "c7280cc7-c3ce-445d-b75d-4cf6408d866c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:49+00:00",
        "updated_at": "2023-02-13T12:53:49+00:00",
        "menu_id": "1826b35e-c6d1-47e7-acb9-4cba45943e18",
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
      "id": "f5a53725-c055-4bc0-9fcf-e5fae28b9470",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:53:49+00:00",
        "updated_at": "2023-02-13T12:53:49+00:00",
        "menu_id": "1826b35e-c6d1-47e7-acb9-4cba45943e18",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0d861fe7-3299-4d19-a694-6a618f8c26fd' \
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