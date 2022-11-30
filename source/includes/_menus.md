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
      "id": "b330accf-b910-4036-8633-8f40e5d7da93",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-30T08:58:40+00:00",
        "updated_at": "2022-11-30T08:58:40+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=b330accf-b910-4036-8633-8f40e5d7da93"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-30T08:56:44Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/729c5051-d799-43d2-b82b-0364027f166f?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "729c5051-d799-43d2-b82b-0364027f166f",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-30T08:58:41+00:00",
      "updated_at": "2022-11-30T08:58:41+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=729c5051-d799-43d2-b82b-0364027f166f"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "8b4ee63f-7324-4f5c-8e32-fabd3729a541"
          },
          {
            "type": "menu_items",
            "id": "4f700b48-665d-46b7-88af-5859d8b9e079"
          },
          {
            "type": "menu_items",
            "id": "c54ded17-cf92-4032-9c45-d697bd12d2ff"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "8b4ee63f-7324-4f5c-8e32-fabd3729a541",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:41+00:00",
        "updated_at": "2022-11-30T08:58:41+00:00",
        "menu_id": "729c5051-d799-43d2-b82b-0364027f166f",
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
            "related": "api/boomerang/menus/729c5051-d799-43d2-b82b-0364027f166f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=8b4ee63f-7324-4f5c-8e32-fabd3729a541"
          }
        }
      }
    },
    {
      "id": "4f700b48-665d-46b7-88af-5859d8b9e079",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:41+00:00",
        "updated_at": "2022-11-30T08:58:41+00:00",
        "menu_id": "729c5051-d799-43d2-b82b-0364027f166f",
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
            "related": "api/boomerang/menus/729c5051-d799-43d2-b82b-0364027f166f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=4f700b48-665d-46b7-88af-5859d8b9e079"
          }
        }
      }
    },
    {
      "id": "c54ded17-cf92-4032-9c45-d697bd12d2ff",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:41+00:00",
        "updated_at": "2022-11-30T08:58:41+00:00",
        "menu_id": "729c5051-d799-43d2-b82b-0364027f166f",
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
            "related": "api/boomerang/menus/729c5051-d799-43d2-b82b-0364027f166f"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c54ded17-cf92-4032-9c45-d697bd12d2ff"
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
    "id": "397a2835-fa4e-416f-9cff-b4bb52fc2f72",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-30T08:58:41+00:00",
      "updated_at": "2022-11-30T08:58:41+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/78b0a569-2d9c-436f-aee0-49b3f5a47421' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "78b0a569-2d9c-436f-aee0-49b3f5a47421",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "04f7ec87-e926-445a-abcb-9d4a97a919ae",
              "title": "Contact us"
            },
            {
              "id": "1d5399bb-56d9-4b21-a20a-50d91e989019",
              "title": "Start"
            },
            {
              "id": "964ebe13-1393-4445-ab89-70ed460329da",
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
    "id": "78b0a569-2d9c-436f-aee0-49b3f5a47421",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-30T08:58:42+00:00",
      "updated_at": "2022-11-30T08:58:42+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "04f7ec87-e926-445a-abcb-9d4a97a919ae"
          },
          {
            "type": "menu_items",
            "id": "1d5399bb-56d9-4b21-a20a-50d91e989019"
          },
          {
            "type": "menu_items",
            "id": "964ebe13-1393-4445-ab89-70ed460329da"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "04f7ec87-e926-445a-abcb-9d4a97a919ae",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:42+00:00",
        "updated_at": "2022-11-30T08:58:42+00:00",
        "menu_id": "78b0a569-2d9c-436f-aee0-49b3f5a47421",
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
      "id": "1d5399bb-56d9-4b21-a20a-50d91e989019",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:42+00:00",
        "updated_at": "2022-11-30T08:58:42+00:00",
        "menu_id": "78b0a569-2d9c-436f-aee0-49b3f5a47421",
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
      "id": "964ebe13-1393-4445-ab89-70ed460329da",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-30T08:58:42+00:00",
        "updated_at": "2022-11-30T08:58:42+00:00",
        "menu_id": "78b0a569-2d9c-436f-aee0-49b3f5a47421",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8ba22ae1-3491-4f1d-852b-d2cecf36bfdb' \
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