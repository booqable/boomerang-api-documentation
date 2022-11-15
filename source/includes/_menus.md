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
      "id": "743eed28-ae57-4563-b071-dccc28d6f46e",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-15T08:05:52+00:00",
        "updated_at": "2022-11-15T08:05:52+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=743eed28-ae57-4563-b071-dccc28d6f46e"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-15T08:04:19Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/fd3b650b-6a08-46ee-b1b6-8668be1d00de?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fd3b650b-6a08-46ee-b1b6-8668be1d00de",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-15T08:05:53+00:00",
      "updated_at": "2022-11-15T08:05:53+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fd3b650b-6a08-46ee-b1b6-8668be1d00de"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8c9378d0-6aa3-44a6-994e-4f119f714935"
          },
          {
            "type": "menu_items",
            "id": "b766cf47-d7ff-4f2b-bb1f-28c148e88e35"
          },
          {
            "type": "menu_items",
            "id": "abc00db3-26cf-4aaf-ab13-058ddd04572b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8c9378d0-6aa3-44a6-994e-4f119f714935",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "fd3b650b-6a08-46ee-b1b6-8668be1d00de",
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
            "related": "api/boomerang/menus/fd3b650b-6a08-46ee-b1b6-8668be1d00de"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8c9378d0-6aa3-44a6-994e-4f119f714935"
          }
        }
      }
    },
    {
      "id": "b766cf47-d7ff-4f2b-bb1f-28c148e88e35",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "fd3b650b-6a08-46ee-b1b6-8668be1d00de",
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
            "related": "api/boomerang/menus/fd3b650b-6a08-46ee-b1b6-8668be1d00de"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b766cf47-d7ff-4f2b-bb1f-28c148e88e35"
          }
        }
      }
    },
    {
      "id": "abc00db3-26cf-4aaf-ab13-058ddd04572b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "fd3b650b-6a08-46ee-b1b6-8668be1d00de",
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
            "related": "api/boomerang/menus/fd3b650b-6a08-46ee-b1b6-8668be1d00de"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=abc00db3-26cf-4aaf-ab13-058ddd04572b"
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
    "id": "b63b5d06-219a-46d5-bd49-1eedaae37d42",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-15T08:05:53+00:00",
      "updated_at": "2022-11-15T08:05:53+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/b575e96c-593d-49db-9d66-361dcbb6cb8f' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "b575e96c-593d-49db-9d66-361dcbb6cb8f",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "35933f15-46e0-4e28-8c2d-26dfbc5409fd",
              "title": "Contact us"
            },
            {
              "id": "bb64f9cf-859a-453f-b6b9-1f7c748fbe0e",
              "title": "Start"
            },
            {
              "id": "3d81a514-afe9-4621-8001-e5ed14e8eb6d",
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
    "id": "b575e96c-593d-49db-9d66-361dcbb6cb8f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-15T08:05:53+00:00",
      "updated_at": "2022-11-15T08:05:53+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "35933f15-46e0-4e28-8c2d-26dfbc5409fd"
          },
          {
            "type": "menu_items",
            "id": "bb64f9cf-859a-453f-b6b9-1f7c748fbe0e"
          },
          {
            "type": "menu_items",
            "id": "3d81a514-afe9-4621-8001-e5ed14e8eb6d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "35933f15-46e0-4e28-8c2d-26dfbc5409fd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "b575e96c-593d-49db-9d66-361dcbb6cb8f",
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
      "id": "bb64f9cf-859a-453f-b6b9-1f7c748fbe0e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "b575e96c-593d-49db-9d66-361dcbb6cb8f",
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
      "id": "3d81a514-afe9-4621-8001-e5ed14e8eb6d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-15T08:05:53+00:00",
        "updated_at": "2022-11-15T08:05:53+00:00",
        "menu_id": "b575e96c-593d-49db-9d66-361dcbb6cb8f",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0544a5a2-ec82-445e-8361-74b247f84532' \
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