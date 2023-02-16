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
      "id": "fc502324-05f3-469c-a623-09dd7004ad60",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-16T09:15:51+00:00",
        "updated_at": "2023-02-16T09:15:51+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=fc502324-05f3-469c-a623-09dd7004ad60"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-16T09:13:58Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/9ca0ae1a-249d-4d1c-aed0-79ada005711d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "9ca0ae1a-249d-4d1c-aed0-79ada005711d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:15:51+00:00",
      "updated_at": "2023-02-16T09:15:51+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=9ca0ae1a-249d-4d1c-aed0-79ada005711d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "dc868290-9d7c-4c36-85d8-70ff32625e6b"
          },
          {
            "type": "menu_items",
            "id": "9f5c7212-7925-4f08-a5c1-4cd677844065"
          },
          {
            "type": "menu_items",
            "id": "e8bafb48-2bb4-4b2a-a20f-d70759f1ba72"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "dc868290-9d7c-4c36-85d8-70ff32625e6b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:51+00:00",
        "updated_at": "2023-02-16T09:15:51+00:00",
        "menu_id": "9ca0ae1a-249d-4d1c-aed0-79ada005711d",
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
            "related": "api/boomerang/menus/9ca0ae1a-249d-4d1c-aed0-79ada005711d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=dc868290-9d7c-4c36-85d8-70ff32625e6b"
          }
        }
      }
    },
    {
      "id": "9f5c7212-7925-4f08-a5c1-4cd677844065",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:51+00:00",
        "updated_at": "2023-02-16T09:15:51+00:00",
        "menu_id": "9ca0ae1a-249d-4d1c-aed0-79ada005711d",
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
            "related": "api/boomerang/menus/9ca0ae1a-249d-4d1c-aed0-79ada005711d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=9f5c7212-7925-4f08-a5c1-4cd677844065"
          }
        }
      }
    },
    {
      "id": "e8bafb48-2bb4-4b2a-a20f-d70759f1ba72",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:51+00:00",
        "updated_at": "2023-02-16T09:15:51+00:00",
        "menu_id": "9ca0ae1a-249d-4d1c-aed0-79ada005711d",
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
            "related": "api/boomerang/menus/9ca0ae1a-249d-4d1c-aed0-79ada005711d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e8bafb48-2bb4-4b2a-a20f-d70759f1ba72"
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
    "id": "2df70d28-feaa-4971-b7c1-4be5d6fa0233",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:15:52+00:00",
      "updated_at": "2023-02-16T09:15:52+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/48eb02e9-b459-4178-a40f-a15e86b24f9f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "48eb02e9-b459-4178-a40f-a15e86b24f9f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "58039f75-05ab-400f-94c8-98d89b69aa55",
              "title": "Contact us"
            },
            {
              "id": "ca5455d4-1042-4447-9d94-01b7791ef26f",
              "title": "Start"
            },
            {
              "id": "8c48c972-4568-4807-9513-6fc4ecbc68dc",
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
    "id": "48eb02e9-b459-4178-a40f-a15e86b24f9f",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-16T09:15:52+00:00",
      "updated_at": "2023-02-16T09:15:52+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "58039f75-05ab-400f-94c8-98d89b69aa55"
          },
          {
            "type": "menu_items",
            "id": "ca5455d4-1042-4447-9d94-01b7791ef26f"
          },
          {
            "type": "menu_items",
            "id": "8c48c972-4568-4807-9513-6fc4ecbc68dc"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "58039f75-05ab-400f-94c8-98d89b69aa55",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:52+00:00",
        "updated_at": "2023-02-16T09:15:52+00:00",
        "menu_id": "48eb02e9-b459-4178-a40f-a15e86b24f9f",
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
      "id": "ca5455d4-1042-4447-9d94-01b7791ef26f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:52+00:00",
        "updated_at": "2023-02-16T09:15:52+00:00",
        "menu_id": "48eb02e9-b459-4178-a40f-a15e86b24f9f",
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
      "id": "8c48c972-4568-4807-9513-6fc4ecbc68dc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-16T09:15:52+00:00",
        "updated_at": "2023-02-16T09:15:52+00:00",
        "menu_id": "48eb02e9-b459-4178-a40f-a15e86b24f9f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0a3f48a4-7d98-4307-a55f-ecf93406319b' \
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