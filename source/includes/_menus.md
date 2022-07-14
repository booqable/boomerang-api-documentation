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
`title` | **String**<br>Name of the menu.
`key` | **String**<br>Key the menu can be referenced by.
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
      "id": "3cf0cf51-aade-46eb-a3ca-ee99b012a249",
      "type": "menus",
      "attributes": {
        "created_at": "2022-07-14T12:01:42+00:00",
        "updated_at": "2022-07-14T12:01:42+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=3cf0cf51-aade-46eb-a3ca-ee99b012a249"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`
`filter` | **Hash**<br>The filters to apply `?filter[created_at][gte]=2022-07-14T11:59:27Z`
`sort` | **String**<br>How to sort the data `?sort=-created_at`
`meta` | **Hash**<br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String**<br>The page to request
`page[size]` | **String**<br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
- | -
`id` | **Uuid**<br>`eq`, `not_eq`
`created_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime**<br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String**<br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
- | -
`total` | **Array**<br>`count`


### Includes

This request does not accept any includes
## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/c3af7293-d469-442e-90a1-2fc7f76090e0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c3af7293-d469-442e-90a1-2fc7f76090e0",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:01:42+00:00",
      "updated_at": "2022-07-14T12:01:42+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c3af7293-d469-442e-90a1-2fc7f76090e0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "5591278a-dddd-4c24-b4c1-a853dd614ea8"
          },
          {
            "type": "menu_items",
            "id": "c2198112-bec4-47d8-9aeb-479fa6efdb28"
          },
          {
            "type": "menu_items",
            "id": "314b9be9-f94c-45ac-a1d1-79166b9516b5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "5591278a-dddd-4c24-b4c1-a853dd614ea8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:42+00:00",
        "updated_at": "2022-07-14T12:01:42+00:00",
        "menu_id": "c3af7293-d469-442e-90a1-2fc7f76090e0",
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
            "related": "api/boomerang/menus/c3af7293-d469-442e-90a1-2fc7f76090e0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5591278a-dddd-4c24-b4c1-a853dd614ea8"
          }
        }
      }
    },
    {
      "id": "c2198112-bec4-47d8-9aeb-479fa6efdb28",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:42+00:00",
        "updated_at": "2022-07-14T12:01:42+00:00",
        "menu_id": "c3af7293-d469-442e-90a1-2fc7f76090e0",
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
            "related": "api/boomerang/menus/c3af7293-d469-442e-90a1-2fc7f76090e0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c2198112-bec4-47d8-9aeb-479fa6efdb28"
          }
        }
      }
    },
    {
      "id": "314b9be9-f94c-45ac-a1d1-79166b9516b5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:42+00:00",
        "updated_at": "2022-07-14T12:01:42+00:00",
        "menu_id": "c3af7293-d469-442e-90a1-2fc7f76090e0",
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
            "related": "api/boomerang/menus/c3af7293-d469-442e-90a1-2fc7f76090e0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=314b9be9-f94c-45ac-a1d1-79166b9516b5"
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


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
    "id": "e904f219-4c69-4491-84d7-0b5da40e47e4",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:01:42+00:00",
      "updated_at": "2022-07-14T12:01:42+00:00",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/9f8a3517-728f-4ee8-90eb-c07de569df95' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "9f8a3517-728f-4ee8-90eb-c07de569df95",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "df34e615-3f8f-4086-926d-db0db2d5889b",
              "title": "Contact us"
            },
            {
              "id": "26d148e9-58e6-40fe-8d3e-cceeb426bf0c",
              "title": "Start"
            },
            {
              "id": "8dcdffa0-6bb7-40f6-a952-bc8d489b5d8f",
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
    "id": "9f8a3517-728f-4ee8-90eb-c07de569df95",
    "type": "menus",
    "attributes": {
      "created_at": "2022-07-14T12:01:43+00:00",
      "updated_at": "2022-07-14T12:01:43+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "df34e615-3f8f-4086-926d-db0db2d5889b"
          },
          {
            "type": "menu_items",
            "id": "26d148e9-58e6-40fe-8d3e-cceeb426bf0c"
          },
          {
            "type": "menu_items",
            "id": "8dcdffa0-6bb7-40f6-a952-bc8d489b5d8f"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "df34e615-3f8f-4086-926d-db0db2d5889b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:43+00:00",
        "updated_at": "2022-07-14T12:01:43+00:00",
        "menu_id": "9f8a3517-728f-4ee8-90eb-c07de569df95",
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
      "id": "26d148e9-58e6-40fe-8d3e-cceeb426bf0c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:43+00:00",
        "updated_at": "2022-07-14T12:01:43+00:00",
        "menu_id": "9f8a3517-728f-4ee8-90eb-c07de569df95",
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
      "id": "8dcdffa0-6bb7-40f6-a952-bc8d489b5d8f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-07-14T12:01:43+00:00",
        "updated_at": "2022-07-14T12:01:43+00:00",
        "menu_id": "9f8a3517-728f-4ee8-90eb-c07de569df95",
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Request body

This request accepts the following body:

Name | Description
- | -
`data[attributes][title]` | **String**<br>Name of the menu.
`data[attributes][key]` | **String**<br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array**<br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/8b2605ef-db7f-46e5-8aca-705630883da5' \
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

This request accepts the following paramaters:

Name | Description
- | -
`include` | **String**<br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array**<br>List of comma seperated fields to include `?fields[menus]=id,created_at,updated_at`


### Includes

This request does not accept any includes