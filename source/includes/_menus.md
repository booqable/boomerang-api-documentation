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
      "id": "87f86eea-bdb2-4b44-a306-dcaece4b5f20",
      "type": "menus",
      "attributes": {
        "created_at": "2022-12-19T08:47:27+00:00",
        "updated_at": "2022-12-19T08:47:27+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=87f86eea-bdb2-4b44-a306-dcaece4b5f20"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-12-19T08:45:38Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/a750bf6f-3f3f-43e7-9642-fc02e98298f9?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "a750bf6f-3f3f-43e7-9642-fc02e98298f9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-19T08:47:27+00:00",
      "updated_at": "2022-12-19T08:47:27+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=a750bf6f-3f3f-43e7-9642-fc02e98298f9"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "82dce484-8f89-479c-ac16-f0111b2d1a8b"
          },
          {
            "type": "menu_items",
            "id": "34b25fc1-1ae0-4555-832a-9600c7ff6acd"
          },
          {
            "type": "menu_items",
            "id": "d6818366-8f28-4cc1-b2bf-f3d136c2beb0"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "82dce484-8f89-479c-ac16-f0111b2d1a8b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:27+00:00",
        "updated_at": "2022-12-19T08:47:27+00:00",
        "menu_id": "a750bf6f-3f3f-43e7-9642-fc02e98298f9",
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
            "related": "api/boomerang/menus/a750bf6f-3f3f-43e7-9642-fc02e98298f9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=82dce484-8f89-479c-ac16-f0111b2d1a8b"
          }
        }
      }
    },
    {
      "id": "34b25fc1-1ae0-4555-832a-9600c7ff6acd",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:27+00:00",
        "updated_at": "2022-12-19T08:47:27+00:00",
        "menu_id": "a750bf6f-3f3f-43e7-9642-fc02e98298f9",
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
            "related": "api/boomerang/menus/a750bf6f-3f3f-43e7-9642-fc02e98298f9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=34b25fc1-1ae0-4555-832a-9600c7ff6acd"
          }
        }
      }
    },
    {
      "id": "d6818366-8f28-4cc1-b2bf-f3d136c2beb0",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:27+00:00",
        "updated_at": "2022-12-19T08:47:27+00:00",
        "menu_id": "a750bf6f-3f3f-43e7-9642-fc02e98298f9",
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
            "related": "api/boomerang/menus/a750bf6f-3f3f-43e7-9642-fc02e98298f9"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d6818366-8f28-4cc1-b2bf-f3d136c2beb0"
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
    "id": "a659732a-d4b2-4978-9c88-372a04771ce6",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-19T08:47:28+00:00",
      "updated_at": "2022-12-19T08:47:28+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/97691ddd-9996-451a-a348-110956be9243' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97691ddd-9996-451a-a348-110956be9243",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "cb2a0b8b-9881-4964-8756-f6657735f651",
              "title": "Contact us"
            },
            {
              "id": "8712b182-b6cf-4efe-9e61-afc2fd73c747",
              "title": "Start"
            },
            {
              "id": "a2a427db-ad1a-4871-8dcf-af9f27bc9f13",
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
    "id": "97691ddd-9996-451a-a348-110956be9243",
    "type": "menus",
    "attributes": {
      "created_at": "2022-12-19T08:47:28+00:00",
      "updated_at": "2022-12-19T08:47:28+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "cb2a0b8b-9881-4964-8756-f6657735f651"
          },
          {
            "type": "menu_items",
            "id": "8712b182-b6cf-4efe-9e61-afc2fd73c747"
          },
          {
            "type": "menu_items",
            "id": "a2a427db-ad1a-4871-8dcf-af9f27bc9f13"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cb2a0b8b-9881-4964-8756-f6657735f651",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:28+00:00",
        "updated_at": "2022-12-19T08:47:28+00:00",
        "menu_id": "97691ddd-9996-451a-a348-110956be9243",
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
      "id": "8712b182-b6cf-4efe-9e61-afc2fd73c747",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:28+00:00",
        "updated_at": "2022-12-19T08:47:28+00:00",
        "menu_id": "97691ddd-9996-451a-a348-110956be9243",
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
      "id": "a2a427db-ad1a-4871-8dcf-af9f27bc9f13",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-12-19T08:47:28+00:00",
        "updated_at": "2022-12-19T08:47:28+00:00",
        "menu_id": "97691ddd-9996-451a-a348-110956be9243",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ea887853-10e2-4cd5-9f5e-ca0a9f0b2393' \
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