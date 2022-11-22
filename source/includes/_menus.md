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
      "id": "f4db20cb-a26f-46a7-90aa-f6fc168cdee3",
      "type": "menus",
      "attributes": {
        "created_at": "2022-11-22T17:43:03+00:00",
        "updated_at": "2022-11-22T17:43:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f4db20cb-a26f-46a7-90aa-f6fc168cdee3"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2022-11-22T17:40:55Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/348e336d-bf67-478e-8e9d-b3cfc7f77033?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "348e336d-bf67-478e-8e9d-b3cfc7f77033",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T17:43:03+00:00",
      "updated_at": "2022-11-22T17:43:03+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=348e336d-bf67-478e-8e9d-b3cfc7f77033"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "cf126533-1d42-4dd6-a3bf-91db55971123"
          },
          {
            "type": "menu_items",
            "id": "0afefc29-191e-455f-b5b2-0b117a94ac4a"
          },
          {
            "type": "menu_items",
            "id": "d3b2df64-4f4e-44e9-9069-075bad4f54b3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "cf126533-1d42-4dd6-a3bf-91db55971123",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:03+00:00",
        "updated_at": "2022-11-22T17:43:03+00:00",
        "menu_id": "348e336d-bf67-478e-8e9d-b3cfc7f77033",
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
            "related": "api/boomerang/menus/348e336d-bf67-478e-8e9d-b3cfc7f77033"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=cf126533-1d42-4dd6-a3bf-91db55971123"
          }
        }
      }
    },
    {
      "id": "0afefc29-191e-455f-b5b2-0b117a94ac4a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:03+00:00",
        "updated_at": "2022-11-22T17:43:03+00:00",
        "menu_id": "348e336d-bf67-478e-8e9d-b3cfc7f77033",
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
            "related": "api/boomerang/menus/348e336d-bf67-478e-8e9d-b3cfc7f77033"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=0afefc29-191e-455f-b5b2-0b117a94ac4a"
          }
        }
      }
    },
    {
      "id": "d3b2df64-4f4e-44e9-9069-075bad4f54b3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:03+00:00",
        "updated_at": "2022-11-22T17:43:03+00:00",
        "menu_id": "348e336d-bf67-478e-8e9d-b3cfc7f77033",
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
            "related": "api/boomerang/menus/348e336d-bf67-478e-8e9d-b3cfc7f77033"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d3b2df64-4f4e-44e9-9069-075bad4f54b3"
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
    "id": "4af774d0-e8fa-4f63-bb8a-32a28cc37e96",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T17:43:04+00:00",
      "updated_at": "2022-11-22T17:43:04+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6502863e-88c0-4ac4-8a75-110bafc646d9' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "6502863e-88c0-4ac4-8a75-110bafc646d9",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b234c382-0d69-4110-a199-12771595584b",
              "title": "Contact us"
            },
            {
              "id": "5c81bfbb-eb25-45b6-86d2-02c83a0f693e",
              "title": "Start"
            },
            {
              "id": "5fad44cf-817c-4057-bc8d-c1e8d41886f3",
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
    "id": "6502863e-88c0-4ac4-8a75-110bafc646d9",
    "type": "menus",
    "attributes": {
      "created_at": "2022-11-22T17:43:04+00:00",
      "updated_at": "2022-11-22T17:43:04+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b234c382-0d69-4110-a199-12771595584b"
          },
          {
            "type": "menu_items",
            "id": "5c81bfbb-eb25-45b6-86d2-02c83a0f693e"
          },
          {
            "type": "menu_items",
            "id": "5fad44cf-817c-4057-bc8d-c1e8d41886f3"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b234c382-0d69-4110-a199-12771595584b",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:04+00:00",
        "updated_at": "2022-11-22T17:43:04+00:00",
        "menu_id": "6502863e-88c0-4ac4-8a75-110bafc646d9",
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
      "id": "5c81bfbb-eb25-45b6-86d2-02c83a0f693e",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:04+00:00",
        "updated_at": "2022-11-22T17:43:04+00:00",
        "menu_id": "6502863e-88c0-4ac4-8a75-110bafc646d9",
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
      "id": "5fad44cf-817c-4057-bc8d-c1e8d41886f3",
      "type": "menu_items",
      "attributes": {
        "created_at": "2022-11-22T17:43:04+00:00",
        "updated_at": "2022-11-22T17:43:04+00:00",
        "menu_id": "6502863e-88c0-4ac4-8a75-110bafc646d9",
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
    --url 'https://example.booqable.com/api/boomerang/menus/c8e0de05-265a-4b3e-b91d-048076bd4f2f' \
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