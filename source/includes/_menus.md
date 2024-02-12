# Menus

Allows creating and managing menus for your shop.

## Endpoints
`DELETE /api/boomerang/menus/{id}`

`POST /api/boomerang/menus`

`GET /api/boomerang/menus/{id}`

`PUT /api/boomerang/menus/{id}`

`GET /api/boomerang/menus`

## Fields
Every menu has the following fields:

Name | Description
-- | --
`id` | **Uuid** `readonly`<br>Primary key
`created_at` | **Datetime** `readonly`<br>When the resource was created
`updated_at` | **Datetime** `readonly`<br>When the resource was last updated
`title` | **String** <br>Name of the menu.
`key` | **String** <br>Key the menu can be referenced by.
`menu_items_attributes` | **Array** `writeonly`<br>Attributes of child menu items to be created or changed.


## Relationships
Menus have the following relationships:

Name | Description
-- | --
`menu_items` | **Menu items** `readonly`<br>Associated Menu items


## Deleting a menu



> How to delete a menu:

```shell
  curl --request DELETE \
    --url 'https://example.booqable.com/api/boomerang/menus/60d0b9d6-4b5a-4cb2-8fbd-75d50cf1f0fb' \
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
-- | --
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request does not accept any includes
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
    "id": "70529723-e6ae-4141-81e4-3773192b5b65",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-12T09:18:56+00:00",
      "updated_at": "2024-02-12T09:18:56+00:00",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










## Fetching a price structure



> How to fetch a menu with it's items:

```shell
  curl --request GET \
    --url 'https://example.booqable.com/api/boomerang/menus/3fd2d268-53ac-406e-bd37-056f24d1c29a?include=menu_items' \
    --header 'content-type: application/json' \
```

> A 200 status response looks like this:

```json
  {
  "data": {
    "id": "3fd2d268-53ac-406e-bd37-056f24d1c29a",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-12T09:18:57+00:00",
      "updated_at": "2024-02-12T09:18:57+00:00",
      "title": "Main menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "links": {
          "related": "api/boomerang/menu_items?filter[menu_id]=3fd2d268-53ac-406e-bd37-056f24d1c29a"
        },
        "data": [
          {
            "type": "menu_items",
            "id": "604cc6e8-0cac-4b25-917f-8c1ca767fb9d"
          },
          {
            "type": "menu_items",
            "id": "17d097a9-cc0e-4fda-bedf-02a7a4e40204"
          },
          {
            "type": "menu_items",
            "id": "486e772c-a37b-449a-aaa1-7d0ffafc91da"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "604cc6e8-0cac-4b25-917f-8c1ca767fb9d",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:57+00:00",
        "updated_at": "2024-02-12T09:18:57+00:00",
        "menu_id": "3fd2d268-53ac-406e-bd37-056f24d1c29a",
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
            "related": "api/boomerang/menus/3fd2d268-53ac-406e-bd37-056f24d1c29a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=604cc6e8-0cac-4b25-917f-8c1ca767fb9d"
          }
        }
      }
    },
    {
      "id": "17d097a9-cc0e-4fda-bedf-02a7a4e40204",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:57+00:00",
        "updated_at": "2024-02-12T09:18:57+00:00",
        "menu_id": "3fd2d268-53ac-406e-bd37-056f24d1c29a",
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
            "related": "api/boomerang/menus/3fd2d268-53ac-406e-bd37-056f24d1c29a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=17d097a9-cc0e-4fda-bedf-02a7a4e40204"
          }
        }
      }
    },
    {
      "id": "486e772c-a37b-449a-aaa1-7d0ffafc91da",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:57+00:00",
        "updated_at": "2024-02-12T09:18:57+00:00",
        "menu_id": "3fd2d268-53ac-406e-bd37-056f24d1c29a",
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
            "related": "api/boomerang/menus/3fd2d268-53ac-406e-bd37-056f24d1c29a"
          }
        },
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[parent_menu_item_id]=486e772c-a37b-449a-aaa1-7d0ffafc91da"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Includes

This request accepts the following includes:

`menu_items`






## Updating a menu and it's items



> How to update a menu with nested menu items:

```shell
  curl --request PUT \
    --url 'https://example.booqable.com/api/boomerang/menus/97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c' \
    --header 'content-type: application/json' \
    --data '{
      "data": {
        "id": "97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c",
        "type": "menus",
        "attributes": {
          "title": "Header menu",
          "menu_items_attributes": [
            {
              "id": "b1577e0f-9f37-4e43-8733-71cb78742e0f",
              "title": "Contact us"
            },
            {
              "id": "dc640605-1431-4d99-a75e-5e728178e31c",
              "title": "Start"
            },
            {
              "id": "695f44bf-4c0c-4e4e-adaf-f5d64cd136e2",
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
    "id": "97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c",
    "type": "menus",
    "attributes": {
      "created_at": "2024-02-12T09:18:58+00:00",
      "updated_at": "2024-02-12T09:18:58+00:00",
      "title": "Header menu",
      "key": "main"
    },
    "relationships": {
      "menu_items": {
        "data": [
          {
            "type": "menu_items",
            "id": "b1577e0f-9f37-4e43-8733-71cb78742e0f"
          },
          {
            "type": "menu_items",
            "id": "dc640605-1431-4d99-a75e-5e728178e31c"
          },
          {
            "type": "menu_items",
            "id": "695f44bf-4c0c-4e4e-adaf-f5d64cd136e2"
          }
        ]
      }
    }
  },
  "included": [
    {
      "id": "b1577e0f-9f37-4e43-8733-71cb78742e0f",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:58+00:00",
        "updated_at": "2024-02-12T09:18:58+00:00",
        "menu_id": "97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c",
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
      "id": "dc640605-1431-4d99-a75e-5e728178e31c",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:58+00:00",
        "updated_at": "2024-02-12T09:18:58+00:00",
        "menu_id": "97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c",
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
      "id": "695f44bf-4c0c-4e4e-adaf-f5d64cd136e2",
      "type": "menu_items",
      "attributes": {
        "created_at": "2024-02-12T09:18:58+00:00",
        "updated_at": "2024-02-12T09:18:58+00:00",
        "menu_id": "97e1eaa5-bdcc-4fe2-a7f6-27dd97f40c3c",
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`


### Request body

This request accepts the following body:

Name | Description
-- | --
`data[attributes][title]` | **String** <br>Name of the menu.
`data[attributes][key]` | **String** <br>Key the menu can be referenced by.
`data[attributes][menu_items_attributes][]` | **Array** <br>Attributes of child menu items to be created or changed.


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`










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
      "id": "f5aa10fd-8d4c-41fa-99bc-af77a4317bbb",
      "type": "menus",
      "attributes": {
        "created_at": "2024-02-12T09:18:58+00:00",
        "updated_at": "2024-02-12T09:18:58+00:00",
        "title": "Main menu",
        "key": "main"
      },
      "relationships": {
        "menu_items": {
          "links": {
            "related": "api/boomerang/menu_items?filter[menu_id]=f5aa10fd-8d4c-41fa-99bc-af77a4317bbb"
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
-- | --
`include` | **String** <br>List of comma seperated relationships `?include=menu_items`
`fields[]` | **Array** <br>List of comma seperated fields to include `?fields[menus]=created_at,updated_at,title`
`filter` | **Hash** <br>The filters to apply `?filter[attribute][eq]=value`
`sort` | **String** <br>How to sort the data `?sort=attribute1,-attribute2`
`meta` | **Hash** <br>Metadata to send along `?meta[total][]=count`
`page[number]` | **String** <br>The page to request
`page[size]` | **String** <br>The amount of items per page (max 100)


### Filters

This request can be filtered on:

Name | Description
-- | --
`id` | **Uuid** <br>`eq`, `not_eq`
`created_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`updated_at` | **Datetime** <br>`eq`, `not_eq`, `gt`, `gte`, `lt`, `lte`
`title` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`
`key` | **String** <br>`eq`, `not_eq`, `eql`, `not_eql`, `prefix`, `not_prefix`, `suffix`, `not_suffix`, `match`, `not_match`


### Meta

Results can be aggregated on:

Name | Description
-- | --
`total` | **Array** <br>`count`


### Includes

This request accepts the following includes:

`menu_items` => 
`menu_items` => 
`menu_items`









