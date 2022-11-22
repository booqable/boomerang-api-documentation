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
      "id": "be13835a-18a3-4677-965f-1d680382bae3",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-22T14:34:01+00:00",
        "updated_at": "2022-11-22T14:34:01+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=be13835a-18a3-4677-965f-1d680382bae3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T14:32:09Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/edb5bf62-3cb4-4595-a7b2-003d19fadc96?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "edb5bf62-3cb4-4595-a7b2-003d19fadc96",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T14:34:01+00:00",
      "updated_at": "2022-11-22T14:34:01+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=edb5bf62-3cb4-4595-a7b2-003d19fadc96"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "6756ab1a-92e3-4dc2-ab4b-fd7cbee4a550"
          },
          {
            "type": "menu_items",
            "id": "7c623de7-d3ae-4700-a0aa-ba17e0cf663e"
          },
          {
            "type": "menu_items",
            "id": "5a9aa367-bb66-496d-bc5d-6860d33733d5"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "6756ab1a-92e3-4dc2-ab4b-fd7cbee4a550",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:01+00:00",
        "updated_at": "2022-11-22T14:34:01+00:00",
        "menu_id": "edb5bf62-3cb4-4595-a7b2-003d19fadc96",
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
            "related": "api/boomerang/menus/edb5bf62-3cb4-4595-a7b2-003d19fadc96"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=6756ab1a-92e3-4dc2-ab4b-fd7cbee4a550"
          }
        }
      }
    },
    {
      "id": "7c623de7-d3ae-4700-a0aa-ba17e0cf663e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:01+00:00",
        "updated_at": "2022-11-22T14:34:01+00:00",
        "menu_id": "edb5bf62-3cb4-4595-a7b2-003d19fadc96",
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
            "related": "api/boomerang/menus/edb5bf62-3cb4-4595-a7b2-003d19fadc96"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7c623de7-d3ae-4700-a0aa-ba17e0cf663e"
          }
        }
      }
    },
    {
      "id": "5a9aa367-bb66-496d-bc5d-6860d33733d5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:01+00:00",
        "updated_at": "2022-11-22T14:34:01+00:00",
        "menu_id": "edb5bf62-3cb4-4595-a7b2-003d19fadc96",
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
            "related": "api/boomerang/menus/edb5bf62-3cb4-4595-a7b2-003d19fadc96"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5a9aa367-bb66-496d-bc5d-6860d33733d5"
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
    "id": "d344322e-83f9-4e49-8a4d-a861c79a019a",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T14:34:01+00:00",
      "updated_at": "2022-11-22T14:34:01+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/ed109847-7503-46c4-838a-e93e8c237471' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "ed109847-7503-46c4-838a-e93e8c237471",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "1cea85cb-495c-43b2-bad0-3e9ee0a6595c",
              "title": "Contact us"
            },
            {
              "id": "d96adebf-a2d5-4442-9a3f-7bec4a2bdfc6",
              "title": "Start"
            },
            {
              "id": "dc830ef6-77f6-4b60-abd6-9fded2aaf636",
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
    "id": "ed109847-7503-46c4-838a-e93e8c237471",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T14:34:02+00:00",
      "updated_at": "2022-11-22T14:34:02+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "1cea85cb-495c-43b2-bad0-3e9ee0a6595c"
          },
          {
            "type": "menu_items",
            "id": "d96adebf-a2d5-4442-9a3f-7bec4a2bdfc6"
          },
          {
            "type": "menu_items",
            "id": "dc830ef6-77f6-4b60-abd6-9fded2aaf636"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1cea85cb-495c-43b2-bad0-3e9ee0a6595c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:02+00:00",
        "updated_at": "2022-11-22T14:34:02+00:00",
        "menu_id": "ed109847-7503-46c4-838a-e93e8c237471",
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
      "id": "d96adebf-a2d5-4442-9a3f-7bec4a2bdfc6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:02+00:00",
        "updated_at": "2022-11-22T14:34:02+00:00",
        "menu_id": "ed109847-7503-46c4-838a-e93e8c237471",
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
      "id": "dc830ef6-77f6-4b60-abd6-9fded2aaf636",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T14:34:02+00:00",
        "updated_at": "2022-11-22T14:34:02+00:00",
        "menu_id": "ed109847-7503-46c4-838a-e93e8c237471",
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
    --url 'https://example.booqable.com/api/boomerang/menus/7d22e33a-325a-45a7-aa00-d384aa4ce35e' \
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