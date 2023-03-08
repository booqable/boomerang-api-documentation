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
      "id": "24dfdb81-250e-4c00-91d1-c48d316bb7e5",
      "type": "menus",
      "attributes": {
        "created_at": "2023-03-08T09:41:43+00:00",
        "updated_at": "2023-03-08T09:41:43+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=24dfdb81-250e-4c00-91d1-c48d316bb7e5"
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
`filter` | **Hash** <br>The filters to apply `?filter[created_at][gte]=2023-03-08T09:39:35Z`
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
    --url 'https://example.booqable.com/api/boomerang/menus/ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:41:44+00:00",
      "updated_at": "2023-03-08T09:41:44+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "7d510034-5d96-4ce6-a618-3452315e89df"
          },
          {
            "type": "menu_items",
            "id": "a1acf418-25de-4971-a1b2-2a640f26b57a"
          },
          {
            "type": "menu_items",
            "id": "d8208555-1b48-4302-af22-878da934c240"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "7d510034-5d96-4ce6-a618-3452315e89df",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:44+00:00",
        "updated_at": "2023-03-08T09:41:44+00:00",
        "menu_id": "ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25",
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
            "related": "api/boomerang/menus/ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=7d510034-5d96-4ce6-a618-3452315e89df"
          }
        }
      }
    },
    {
      "id": "a1acf418-25de-4971-a1b2-2a640f26b57a",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:44+00:00",
        "updated_at": "2023-03-08T09:41:44+00:00",
        "menu_id": "ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25",
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
            "related": "api/boomerang/menus/ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=a1acf418-25de-4971-a1b2-2a640f26b57a"
          }
        }
      }
    },
    {
      "id": "d8208555-1b48-4302-af22-878da934c240",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:44+00:00",
        "updated_at": "2023-03-08T09:41:44+00:00",
        "menu_id": "ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25",
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
            "related": "api/boomerang/menus/ea6b8e9d-8570-4dd9-8a1c-7f8ce694bf25"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=d8208555-1b48-4302-af22-878da934c240"
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
    "id": "25abc14e-1f53-496a-ade2-013e70fc85e6",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:41:44+00:00",
      "updated_at": "2023-03-08T09:41:44+00:00",
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
    --url 'https://example.booqable.com/api/boomerang/menus/718a3460-7736-47a4-b04e-e12c3c437034' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "718a3460-7736-47a4-b04e-e12c3c437034",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "a1ab3b82-e427-4092-be92-166cf6642b77",
              "title": "Contact us"
            },
            {
              "id": "cf9b7932-33ef-432b-bfa5-1b312bcd9b95",
              "title": "Start"
            },
            {
              "id": "c19d61bf-0305-4b27-a5bd-327d15fe7b76",
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
    "id": "718a3460-7736-47a4-b04e-e12c3c437034",
    "type": "menus",
    "attributes": {
      "created_at": "2023-03-08T09:41:45+00:00",
      "updated_at": "2023-03-08T09:41:45+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "a1ab3b82-e427-4092-be92-166cf6642b77"
          },
          {
            "type": "menu_items",
            "id": "cf9b7932-33ef-432b-bfa5-1b312bcd9b95"
          },
          {
            "type": "menu_items",
            "id": "c19d61bf-0305-4b27-a5bd-327d15fe7b76"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "a1ab3b82-e427-4092-be92-166cf6642b77",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:45+00:00",
        "updated_at": "2023-03-08T09:41:45+00:00",
        "menu_id": "718a3460-7736-47a4-b04e-e12c3c437034",
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
      "id": "cf9b7932-33ef-432b-bfa5-1b312bcd9b95",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:45+00:00",
        "updated_at": "2023-03-08T09:41:45+00:00",
        "menu_id": "718a3460-7736-47a4-b04e-e12c3c437034",
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
      "id": "c19d61bf-0305-4b27-a5bd-327d15fe7b76",
      "type": "menu_items",
      "attributes": {
        "created_at": "2023-03-08T09:41:45+00:00",
        "updated_at": "2023-03-08T09:41:45+00:00",
        "menu_id": "718a3460-7736-47a4-b04e-e12c3c437034",
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
    --url 'https://example.booqable.com/api/boomerang/menus/8335da8d-ac14-4b6d-8aee-ab28e601ab4e' \
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