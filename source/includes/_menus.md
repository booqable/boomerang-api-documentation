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
      "id": "7ed807b4-acaa-4d2f-82d4-f9d767c72c6a",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-15T13:22:59+00:00",
        "updated_at": "2023-02-15T13:22:59+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=7ed807b4-acaa-4d2f-82d4-f9d767c72c6a"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-15T13:21:01Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/bb4386f5-31b2-45b1-bf04-0258a546545a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "bb4386f5-31b2-45b1-bf04-0258a546545a",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-15T13:23:00+00:00",
      "updated_at": "2023-02-15T13:23:00+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=bb4386f5-31b2-45b1-bf04-0258a546545a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7dfb63ab-d345-4ce1-8f55-0b0d38e645eb"
          },
          {
            "type": "menu_items",
            "id": "6993da85-a7b0-46a3-a92e-08a425428e8e"
          },
          {
            "type": "menu_items",
            "id": "fd3b220f-112d-47fa-8e79-05453c370f9b"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7dfb63ab-d345-4ce1-8f55-0b0d38e645eb",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:00+00:00",
        "updated_at": "2023-02-15T13:23:00+00:00",
        "menu_id": "bb4386f5-31b2-45b1-bf04-0258a546545a",
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
            "related": "api/boomerang/menus/bb4386f5-31b2-45b1-bf04-0258a546545a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7dfb63ab-d345-4ce1-8f55-0b0d38e645eb"
          }
        }
      }
    },
    {
      "id": "6993da85-a7b0-46a3-a92e-08a425428e8e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:00+00:00",
        "updated_at": "2023-02-15T13:23:00+00:00",
        "menu_id": "bb4386f5-31b2-45b1-bf04-0258a546545a",
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
            "related": "api/boomerang/menus/bb4386f5-31b2-45b1-bf04-0258a546545a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6993da85-a7b0-46a3-a92e-08a425428e8e"
          }
        }
      }
    },
    {
      "id": "fd3b220f-112d-47fa-8e79-05453c370f9b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:00+00:00",
        "updated_at": "2023-02-15T13:23:00+00:00",
        "menu_id": "bb4386f5-31b2-45b1-bf04-0258a546545a",
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
            "related": "api/boomerang/menus/bb4386f5-31b2-45b1-bf04-0258a546545a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=fd3b220f-112d-47fa-8e79-05453c370f9b"
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
    "id": "577c7889-2f3d-4c1f-9e77-40b820604229",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-15T13:23:00+00:00",
      "updated_at": "2023-02-15T13:23:00+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "e82a1df5-0c05-4dac-a13f-c70797b61c25",
              "title": "Contact us"
            },
            {
              "id": "fad62033-2a7f-494b-b934-f35f9866c9f6",
              "title": "Start"
            },
            {
              "id": "77081661-ce0e-40b3-84b6-36fe84c7c73e",
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
    "id": "46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-15T13:23:01+00:00",
      "updated_at": "2023-02-15T13:23:01+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "e82a1df5-0c05-4dac-a13f-c70797b61c25"
          },
          {
            "type": "menu_items",
            "id": "fad62033-2a7f-494b-b934-f35f9866c9f6"
          },
          {
            "type": "menu_items",
            "id": "77081661-ce0e-40b3-84b6-36fe84c7c73e"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "e82a1df5-0c05-4dac-a13f-c70797b61c25",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:01+00:00",
        "updated_at": "2023-02-15T13:23:01+00:00",
        "menu_id": "46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20",
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
      "id": "fad62033-2a7f-494b-b934-f35f9866c9f6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:01+00:00",
        "updated_at": "2023-02-15T13:23:01+00:00",
        "menu_id": "46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20",
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
      "id": "77081661-ce0e-40b3-84b6-36fe84c7c73e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-15T13:23:01+00:00",
        "updated_at": "2023-02-15T13:23:01+00:00",
        "menu_id": "46ffcb5a-dfd1-4831-9be5-2ad68bfd4e20",
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
    --url 'https://example.booqable.com/api/boomerang/menus/fb4aef1a-a437-4336-a495-d6f49329eafe' \
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