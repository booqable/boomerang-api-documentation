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
      "id": "9528e9a3-aebe-4f45-870f-ef5dfb882aa0",
      "type": "menus",
      "attributes": {
        "created_at": "2023-02-13T12:47:13+00:00",
        "updated_at": "2023-02-13T12:47:13+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=9528e9a3-aebe-4f45-870f-ef5dfb882aa0"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-02-13T12:45:26Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/fa44db69-aa43-434e-b2b2-84a0ae567db3?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "fa44db69-aa43-434e-b2b2-84a0ae567db3",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:47:13+00:00",
      "updated_at": "2023-02-13T12:47:13+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=fa44db69-aa43-434e-b2b2-84a0ae567db3"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "bf3ff7ae-5691-4032-8776-585f285bec02"
          },
          {
            "type": "menu_items",
            "id": "7be622b5-be9d-4a8c-b47c-420f2c9f83db"
          },
          {
            "type": "menu_items",
            "id": "86656864-978b-445e-869c-fe97a1590918"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "bf3ff7ae-5691-4032-8776-585f285bec02",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:13+00:00",
        "updated_at": "2023-02-13T12:47:13+00:00",
        "menu_id": "fa44db69-aa43-434e-b2b2-84a0ae567db3",
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
            "related": "api/boomerang/menus/fa44db69-aa43-434e-b2b2-84a0ae567db3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=bf3ff7ae-5691-4032-8776-585f285bec02"
          }
        }
      }
    },
    {
      "id": "7be622b5-be9d-4a8c-b47c-420f2c9f83db",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:13+00:00",
        "updated_at": "2023-02-13T12:47:13+00:00",
        "menu_id": "fa44db69-aa43-434e-b2b2-84a0ae567db3",
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
            "related": "api/boomerang/menus/fa44db69-aa43-434e-b2b2-84a0ae567db3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7be622b5-be9d-4a8c-b47c-420f2c9f83db"
          }
        }
      }
    },
    {
      "id": "86656864-978b-445e-869c-fe97a1590918",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:13+00:00",
        "updated_at": "2023-02-13T12:47:13+00:00",
        "menu_id": "fa44db69-aa43-434e-b2b2-84a0ae567db3",
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
            "related": "api/boomerang/menus/fa44db69-aa43-434e-b2b2-84a0ae567db3"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=86656864-978b-445e-869c-fe97a1590918"
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
    "id": "f89ce8d6-ee95-4eff-9f56-bea683316133",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:47:14+00:00",
      "updated_at": "2023-02-13T12:47:14+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8c80182b-19d8-4e81-902d-77d4b1e3e85c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "8c80182b-19d8-4e81-902d-77d4b1e3e85c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "c08e5e54-1c8a-49ba-8a7e-9d9dd6426af6",
              "title": "Contact us"
            },
            {
              "id": "2c825402-4c69-49a5-a80c-3b9cd7efb9b8",
              "title": "Start"
            },
            {
              "id": "64325f12-ff69-4024-9f4f-4eb1d3ad163c",
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
    "id": "8c80182b-19d8-4e81-902d-77d4b1e3e85c",
    "type": "menus",
    "attributes": {
      "created_at": "2023-02-13T12:47:14+00:00",
      "updated_at": "2023-02-13T12:47:14+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "c08e5e54-1c8a-49ba-8a7e-9d9dd6426af6"
          },
          {
            "type": "menu_items",
            "id": "2c825402-4c69-49a5-a80c-3b9cd7efb9b8"
          },
          {
            "type": "menu_items",
            "id": "64325f12-ff69-4024-9f4f-4eb1d3ad163c"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "c08e5e54-1c8a-49ba-8a7e-9d9dd6426af6",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:14+00:00",
        "updated_at": "2023-02-13T12:47:14+00:00",
        "menu_id": "8c80182b-19d8-4e81-902d-77d4b1e3e85c",
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
      "id": "2c825402-4c69-49a5-a80c-3b9cd7efb9b8",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:14+00:00",
        "updated_at": "2023-02-13T12:47:14+00:00",
        "menu_id": "8c80182b-19d8-4e81-902d-77d4b1e3e85c",
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
      "id": "64325f12-ff69-4024-9f4f-4eb1d3ad163c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-02-13T12:47:14+00:00",
        "updated_at": "2023-02-13T12:47:14+00:00",
        "menu_id": "8c80182b-19d8-4e81-902d-77d4b1e3e85c",
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
    --url 'https://example.booqable.com/api/boomerang/menus/6def747f-5c11-488b-a82a-de1f014b2a51' \
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