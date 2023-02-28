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
      "id": "a1277244-28d9-4f83-80e0-9e92b7203052",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-28T07:30:45+00:00",
        "updated_at": "2023-02-28T07:30:45+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a1277244-28d9-4f83-80e0-9e92b7203052"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-28T07:29:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/5e427832-18bf-463d-bbe6-56ea06a62c1d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "5e427832-18bf-463d-bbe6-56ea06a62c1d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T07:30:45+00:00",
      "updated_at": "2023-02-28T07:30:45+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=5e427832-18bf-463d-bbe6-56ea06a62c1d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bf5608eb-9925-4525-bd0c-5822e6a65273"
          },
          {
            "type": "menu_items",
            "id": "b1141b32-a6eb-4b1e-a053-5e6d6b7bbd8c"
          },
          {
            "type": "menu_items",
            "id": "cfbe3cba-5b32-483c-9568-fc7efc77fdb1"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf5608eb-9925-4525-bd0c-5822e6a65273",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:45+00:00",
        "updated_at": "2023-02-28T07:30:45+00:00",
        "menu_id": "5e427832-18bf-463d-bbe6-56ea06a62c1d",
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
            "related": "api/boomerang/menus/5e427832-18bf-463d-bbe6-56ea06a62c1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bf5608eb-9925-4525-bd0c-5822e6a65273"
          }
        }
      }
    },
    {
      "id": "b1141b32-a6eb-4b1e-a053-5e6d6b7bbd8c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:45+00:00",
        "updated_at": "2023-02-28T07:30:45+00:00",
        "menu_id": "5e427832-18bf-463d-bbe6-56ea06a62c1d",
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
            "related": "api/boomerang/menus/5e427832-18bf-463d-bbe6-56ea06a62c1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b1141b32-a6eb-4b1e-a053-5e6d6b7bbd8c"
          }
        }
      }
    },
    {
      "id": "cfbe3cba-5b32-483c-9568-fc7efc77fdb1",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:45+00:00",
        "updated_at": "2023-02-28T07:30:45+00:00",
        "menu_id": "5e427832-18bf-463d-bbe6-56ea06a62c1d",
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
            "related": "api/boomerang/menus/5e427832-18bf-463d-bbe6-56ea06a62c1d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cfbe3cba-5b32-483c-9568-fc7efc77fdb1"
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
    "id": "5744be76-c08c-48f7-ae46-02177706d848",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T07:30:45+00:00",
      "updated_at": "2023-02-28T07:30:45+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/250955ea-4265-4b36-87be-7c5e1656e081' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "250955ea-4265-4b36-87be-7c5e1656e081",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "8ed921df-2e03-4d63-b6eb-7be94c2e24c0",
              "title": "Contact us"
            },
            {
              "id": "db475e9b-fb94-4845-b63d-67d0b2fa5136",
              "title": "Start"
            },
            {
              "id": "e6b220a0-489b-4758-afa9-7513ede95e5e",
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
    "id": "250955ea-4265-4b36-87be-7c5e1656e081",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-28T07:30:46+00:00",
      "updated_at": "2023-02-28T07:30:46+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "8ed921df-2e03-4d63-b6eb-7be94c2e24c0"
          },
          {
            "type": "menu_items",
            "id": "db475e9b-fb94-4845-b63d-67d0b2fa5136"
          },
          {
            "type": "menu_items",
            "id": "e6b220a0-489b-4758-afa9-7513ede95e5e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8ed921df-2e03-4d63-b6eb-7be94c2e24c0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:46+00:00",
        "updated_at": "2023-02-28T07:30:46+00:00",
        "menu_id": "250955ea-4265-4b36-87be-7c5e1656e081",
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
      "id": "db475e9b-fb94-4845-b63d-67d0b2fa5136",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:46+00:00",
        "updated_at": "2023-02-28T07:30:46+00:00",
        "menu_id": "250955ea-4265-4b36-87be-7c5e1656e081",
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
      "id": "e6b220a0-489b-4758-afa9-7513ede95e5e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-28T07:30:46+00:00",
        "updated_at": "2023-02-28T07:30:46+00:00",
        "menu_id": "250955ea-4265-4b36-87be-7c5e1656e081",
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
    --url 'https://example.booqable.com/api/boomerang/menus/22eaa159-dcad-4c39-8913-e017ff2c0623' \
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