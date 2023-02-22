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
      "id": "c04ad777-2c77-49b4-bf9e-867ca945216c",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-22T10:36:34+00:00",
        "updated_at": "2023-02-22T10:36:34+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=c04ad777-2c77-49b4-bf9e-867ca945216c"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-22T10:34:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T10:36:35+00:00",
      "updated_at": "2023-02-22T10:36:35+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "b999144f-d307-4bb6-a7c6-cabd223ff1cc"
          },
          {
            "type": "menu_items",
            "id": "c9dc0420-9026-4ecd-9caa-6865eb4ace5f"
          },
          {
            "type": "menu_items",
            "id": "ad3ed2ed-e167-4b29-bd02-64e5f03798ec"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b999144f-d307-4bb6-a7c6-cabd223ff1cc",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:35+00:00",
        "updated_at": "2023-02-22T10:36:35+00:00",
        "menu_id": "c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0",
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
            "related": "api/boomerang/menus/c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=b999144f-d307-4bb6-a7c6-cabd223ff1cc"
          }
        }
      }
    },
    {
      "id": "c9dc0420-9026-4ecd-9caa-6865eb4ace5f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:35+00:00",
        "updated_at": "2023-02-22T10:36:35+00:00",
        "menu_id": "c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0",
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
            "related": "api/boomerang/menus/c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=c9dc0420-9026-4ecd-9caa-6865eb4ace5f"
          }
        }
      }
    },
    {
      "id": "ad3ed2ed-e167-4b29-bd02-64e5f03798ec",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:35+00:00",
        "updated_at": "2023-02-22T10:36:35+00:00",
        "menu_id": "c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0",
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
            "related": "api/boomerang/menus/c1d8d1d2-1e74-40c2-b6f4-6c3f484218d0"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=ad3ed2ed-e167-4b29-bd02-64e5f03798ec"
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
    "id": "3c46223c-9635-492d-8f9d-90fee9222c67",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T10:36:35+00:00",
      "updated_at": "2023-02-22T10:36:35+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/27b0cb15-d4f8-45d3-994b-54c9a13ac4fc' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "27b0cb15-d4f8-45d3-994b-54c9a13ac4fc",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "d45bf06e-5f9f-45d8-a9cb-a38fbe55c05d",
              "title": "Contact us"
            },
            {
              "id": "391f1b42-09cc-4e18-8121-30373fe53a8a",
              "title": "Start"
            },
            {
              "id": "3a235a21-4083-401f-86d7-8042a5e8d138",
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
    "id": "27b0cb15-d4f8-45d3-994b-54c9a13ac4fc",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-22T10:36:35+00:00",
      "updated_at": "2023-02-22T10:36:36+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "d45bf06e-5f9f-45d8-a9cb-a38fbe55c05d"
          },
          {
            "type": "menu_items",
            "id": "391f1b42-09cc-4e18-8121-30373fe53a8a"
          },
          {
            "type": "menu_items",
            "id": "3a235a21-4083-401f-86d7-8042a5e8d138"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "d45bf06e-5f9f-45d8-a9cb-a38fbe55c05d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:35+00:00",
        "updated_at": "2023-02-22T10:36:36+00:00",
        "menu_id": "27b0cb15-d4f8-45d3-994b-54c9a13ac4fc",
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
      "id": "391f1b42-09cc-4e18-8121-30373fe53a8a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:36+00:00",
        "updated_at": "2023-02-22T10:36:36+00:00",
        "menu_id": "27b0cb15-d4f8-45d3-994b-54c9a13ac4fc",
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
      "id": "3a235a21-4083-401f-86d7-8042a5e8d138",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-22T10:36:36+00:00",
        "updated_at": "2023-02-22T10:36:36+00:00",
        "menu_id": "27b0cb15-d4f8-45d3-994b-54c9a13ac4fc",
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
    --url 'https://example.booqable.com/api/boomerang/menus/f25a53a2-11d1-4b11-9cc2-56b956a23bbf' \
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