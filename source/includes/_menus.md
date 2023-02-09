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
      "id": "a3718fe4-5eba-4757-bbbd-0e1a01f707ac",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-09T13:07:03+00:00",
        "updated_at": "2023-02-09T13:07:03+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=a3718fe4-5eba-4757-bbbd-0e1a01f707ac"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-09T13:05:03Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/3ca6506c-35b4-4881-896a-3af7fe07881d?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3ca6506c-35b4-4881-896a-3af7fe07881d",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:07:03+00:00",
      "updated_at": "2023-02-09T13:07:03+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3ca6506c-35b4-4881-896a-3af7fe07881d"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "1dcc10e2-dd98-4e93-a43c-03b52d6aeb11"
          },
          {
            "type": "menu_items",
            "id": "5497d09c-603a-496c-a2a2-13d616435f15"
          },
          {
            "type": "menu_items",
            "id": "e1f5aa47-333e-4b73-a427-486ccec6f20d"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "1dcc10e2-dd98-4e93-a43c-03b52d6aeb11",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:03+00:00",
        "updated_at": "2023-02-09T13:07:03+00:00",
        "menu_id": "3ca6506c-35b4-4881-896a-3af7fe07881d",
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
            "related": "api/boomerang/menus/3ca6506c-35b4-4881-896a-3af7fe07881d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=1dcc10e2-dd98-4e93-a43c-03b52d6aeb11"
          }
        }
      }
    },
    {
      "id": "5497d09c-603a-496c-a2a2-13d616435f15",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:03+00:00",
        "updated_at": "2023-02-09T13:07:03+00:00",
        "menu_id": "3ca6506c-35b4-4881-896a-3af7fe07881d",
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
            "related": "api/boomerang/menus/3ca6506c-35b4-4881-896a-3af7fe07881d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=5497d09c-603a-496c-a2a2-13d616435f15"
          }
        }
      }
    },
    {
      "id": "e1f5aa47-333e-4b73-a427-486ccec6f20d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:03+00:00",
        "updated_at": "2023-02-09T13:07:03+00:00",
        "menu_id": "3ca6506c-35b4-4881-896a-3af7fe07881d",
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
            "related": "api/boomerang/menus/3ca6506c-35b4-4881-896a-3af7fe07881d"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=e1f5aa47-333e-4b73-a427-486ccec6f20d"
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
    "id": "00c975da-2c11-4ac6-9699-1c863b7d4f68",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:07:04+00:00",
      "updated_at": "2023-02-09T13:07:04+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/0e550089-e617-45cc-8395-577761ef2d64' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "0e550089-e617-45cc-8395-577761ef2d64",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "33e54ae0-04ed-4e4c-8156-f2f54024acc2",
              "title": "Contact us"
            },
            {
              "id": "ed7c171f-a457-4427-b36f-c555cf60abc5",
              "title": "Start"
            },
            {
              "id": "16ba9668-5699-41b2-82b0-5458f8874f09",
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
    "id": "0e550089-e617-45cc-8395-577761ef2d64",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-09T13:07:04+00:00",
      "updated_at": "2023-02-09T13:07:04+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "33e54ae0-04ed-4e4c-8156-f2f54024acc2"
          },
          {
            "type": "menu_items",
            "id": "ed7c171f-a457-4427-b36f-c555cf60abc5"
          },
          {
            "type": "menu_items",
            "id": "16ba9668-5699-41b2-82b0-5458f8874f09"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "33e54ae0-04ed-4e4c-8156-f2f54024acc2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:04+00:00",
        "updated_at": "2023-02-09T13:07:04+00:00",
        "menu_id": "0e550089-e617-45cc-8395-577761ef2d64",
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
      "id": "ed7c171f-a457-4427-b36f-c555cf60abc5",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:04+00:00",
        "updated_at": "2023-02-09T13:07:04+00:00",
        "menu_id": "0e550089-e617-45cc-8395-577761ef2d64",
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
      "id": "16ba9668-5699-41b2-82b0-5458f8874f09",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-09T13:07:04+00:00",
        "updated_at": "2023-02-09T13:07:04+00:00",
        "menu_id": "0e550089-e617-45cc-8395-577761ef2d64",
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
    --url 'https://example.booqable.com/api/boomerang/menus/70c60120-6538-4092-a3fa-283e519bb314' \
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